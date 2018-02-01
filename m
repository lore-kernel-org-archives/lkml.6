Return-Path: <stern+5a7bc81c@rowland.harvard.edu>
X-Google-Smtp-Source: AH8x225M05xw4e6vdqdbbeah/SmUYB2r5G8tvfOEWptr89P2K9UASpiR+mLsTAwKg5QrAoGuSU9a
ARC-Seal: i=1; a=rsa-sha256; t=1517499214; cv=none;
        d=google.com; s=arc-20160816;
        b=u2B4dOu4eudLKQjaRIG932cD5d/OLaEcp/Na9suWnM7lkbk1QczFLTbt5VXzhHW0Z9
         dMA9/vOIjOcpShHmwguDbj7tQpEtEoNuHLpoMpnkMvucHwxBChuPev7sXW5wwIkqe9LY
         98D1t2bi4rMhDJnBcUOZAPHCygvejcvwnwltCTq8C4xyUfYMsxUNwblkYy51uUIMNn9e
         SQ830V83/ymT2HJOrtPbQHnBSf+Pd6GFlpsSN63FdyVgidbu5RitQu2DgZAuzLp3fpYY
         Pn5UAhu47SbHstFAThRGbMJhYYsrlgSuj4k7RPYgRhOeFbJwLyRXpjmIK/0IaBZQ7Kwl
         24ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=2GQb1rMw38IHB+yRqLDOgZ3lzbo3SWYowL9Yi8YJ4vM=;
        b=raOcl7xrxbwDuHe705wNg5LAHtDlW4B8RRiv/OZ9GP4hZc/royAplOVyy20uOJ7ppt
         wESGaLrFEKjBF4amLRmYOpB1uZeA6kYpP2a5MlVufQdBLpasX07GI+geYLT802TM9CFo
         ANj2ic+bdxO7zjWygiH8/bTy4Xx9azY0mYDmUFfWIiP6NZkg2dn5Xi04jt0g5e4Nf3lX
         QsEKxOq//HVFk7boCxgmSjii+GAgXYNygzamJWNZ0LY3sJX3oyfgHE1p7UmNaJm5iYmV
         80DLg0R3KHMdwcyue3AbHYVkNXdINoTcwBqEpwN0PIqIQ58ocEWVv+Jk5vESsDwLJdwH
         XXsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5a7bc81c@rowland.harvard.edu) smtp.mailfrom=stern+5a7bc81c@rowland.harvard.edu
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5a7bc81c@rowland.harvard.edu) smtp.mailfrom=stern+5a7bc81c@rowland.harvard.edu
Date: Thu, 1 Feb 2018 10:33:33 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Yoshida, Shigeru" <Shigeru.Yoshida@windriver.com>
cc: "Bai, Haiqing" <Haiqing.Bai@windriver.com>,
    "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
    "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ohci-hcd: Fix race condition caused by ohci_urb_enqueue()
 and io_watchdog_func()
In-Reply-To: <20180201.144911.2171407625301691891.shigeru.yoshida@windriver.com>
Message-ID: <Pine.LNX.4.44L0.1802011029160.1677-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591100238204595234?=
X-GMAIL-MSGID: =?utf-8?q?1591213256587281788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 1 Feb 2018, Yoshida, Shigeru wrote:

> Hi Alan,
> 
> Thank you for your commenting.
> 
> On Wed, 31 Jan 2018 11:02:47 -0500, Alan Stern wrote:
> >> To address above scenario, this patch introduces timer_running flag to
> >> ohci_hcd structure.  Setting true to ohci->timer_running indicates
> >> io_watchdog_func() is scheduled or is running.  ohci_urb_enqueue()
> >> checks the flag when it schedules the watchdog (step 4 and 12 above),
> >> so ohci->prev_frame_no is not overwritten while io_watchdog_func() is
> >> running.
> > 
> > Instead of adding an extra flag variable, which has to be kept in sync 
> > with the timer routine, how about defining a special sentinel value for 
> > prev_frame_no?  For example:
> > 
> > #define IO_WATCHDOG_OFF		0xffffff00
> > 
> > Then whenever the timer isn't scheduled or running, set
> > ohci->prev_frame_no to IO_WATCHDOG_OFF.  And instead of testing
> > timer_pending(), compare prev_frame_no to this special value.
> > 
> > I think that approach will be slightly more robust.
> 
> It's reasonable since ohci->prev_frame_no is not used while the
> watchdog timer is stopped.
> 
> I think we must choose an invalid frame number for the special
> sentinel value, but I'm not sure which value is adequate for it.
> Is 0xffffff00 an invalid frame number, otherwise how about simply
> -1(0xffffffff)?

Well, the frame_no register is 32 bits wide, but only the 16 low-order 
bits are meaningful.  ohci_frame_no() strips off the high-order 16 
bits, so any value with one of those bits set would be acceptable.  
(Besides, valid frame numbers only go up to 2047.)

I chose 0xffffff00 because PCI reads from a non-working device 
generally get a value with all the bits set.  But since the upper 16 
bits are masked away anyhow, it doesn't matter.  -1u would be fine.

Alan Stern
