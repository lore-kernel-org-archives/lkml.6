Return-Path: <alan@llwyncelyn.cymru>
X-Google-Smtp-Source: AIpwx487Ehy8CR+rRYNj6fVJFa2QfG55PXUcAI/MAvS7AGFPMjz0U+HbGaeTNG3Q6fncxYiNx5iy
ARC-Seal: i=1; a=rsa-sha256; t=1522934712; cv=none;
        d=google.com; s=arc-20160816;
        b=TvzlENFQ9z0tb6JRBzQbG2zDlaptmw14b3P753zQ3TMUHCunCg106m0RqvKebvuOk4
         kbUDoGANqDbUuZYFC4yQUBRWG70FOTGRGOu1GNN0rDUPAnIdOEkTvaNwf3A0tlg0tCLj
         e6xHTi9Y63cWdILwgc9lgUJYyecpkqpQOA4Kw/8vuLFlk332c9exwNJ2xzJqMbOzxagM
         Ly4RuhSHGJpRTR7Y4beH0Y2goakTz2FifM7gqgK+CJ9838zbxhQM5qEuomLWzUOlGSED
         z3KzsN7NpPhLih881i1SyX8xM5vKNIVqyu8ILaJCKajENstvPr5o3WYBCP8xE8W+1Sq/
         QQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=rI0yRdXCjN9vaU4siIBnNU/MnCOWyvTKrL446IxUk1g=;
        b=jjYQ1Ezfa+MB6gh99Fd6UA3RCLbf65J5l8fLC9GsWroNDW8LNaVplDsXvIU5uvyig3
         cXbuPoOmN+uEyZGk7mthRSmgMb+Z5IHE2VCGSz2iBXLFj08TjG/8ki6zfnHTdm4Ef2iC
         q5QFTkdRaP4ZX/SzCW85JIPMHGg6HOKDpMVZ/KfYyh0arQi+dmB03gX3Qgu6B2RspJ4H
         M5ZGCC0wH2iudjJQiY6cG4kFBKcvsZb/ucr9kIPT+A7gaS6EQRdzCyUCxqr6r44U6C/p
         arbPTPBt7hnVJRbekT/dh0Y7bJJbibiIkqdLxeFfRLUPdxd/DsVEZ593nIIcKUY45CeC
         LHeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alan@llwyncelyn.cymru designates 82.70.14.225 as permitted sender) smtp.mailfrom=alan@llwyncelyn.cymru
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alan@llwyncelyn.cymru designates 82.70.14.225 as permitted sender) smtp.mailfrom=alan@llwyncelyn.cymru
Date: Thu, 5 Apr 2018 14:25:03 +0100
From: Alan Cox <alan@llwyncelyn.cymru>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        syzbot
 <bot+1a77aeddeaf63317949b59c3df98f139a1ca34f9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Dmitry
 Vyukov <dvyukov@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: WARNING in tty_set_ldisc
Message-ID: <20180405142503.627552ca@alans-desktop>
In-Reply-To: <2e8fd7a6-6841-d660-8e1c-17b5a07618fa@I-love.SAKURA.ne.jp>
References: <001a1141f0c87da52c055d385a4d@google.com>
	<20171105103404.GB1487@kroah.com>
	<2e8fd7a6-6841-d660-8e1c-17b5a07618fa@I-love.SAKURA.ne.jp>
Organization: is over-rated
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1583215020386127700?=
X-GMAIL-MSGID: =?utf-8?q?1596912789841878860?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

rror pointer dereference at tty_ldisc_restore().
> 
> syzbot is reporting crashes [1] triggered by memory allocation failure at
> tty_ldisc_get() from tty_ldisc_restore(). While syzbot stops at WARN_ON()
> due to panic_on_warn == true, panic_on_warn == false will after all trigger
> an OOPS by dereferencing old->ops->num if IS_ERR(old) == true.
> 
> We can simplify tty_ldisc_restore() as three calls (old->ops->num, N_TTY,
> N_NULL) to tty_ldisc_failto() in addition to avoiding possible error
> pointer dereference.
> 
> If someone reports kernel panic triggered by forcing all memory allocations
> for tty_ldisc_restore() to fail, we can consider adding __GFP_NOFAIL for
> tty_ldisc_restore() case.
> 
> [1] https://syzkaller.appspot.com/bug?id=6ac359c61e71d22e06db7f8f88243feb11d927e7
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Alan Cox <alan@llwyncelyn.cymru>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Michal Hocko <mhocko@suse.com>

Seems reasonable to me

Alan
