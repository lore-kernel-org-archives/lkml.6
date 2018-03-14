Return-Path: <mdharm@one-eyed-alien.net>
ARC-Seal: i=1; a=rsa-sha256; t=1521010416; cv=none;
        d=google.com; s=arc-20160816;
        b=kXL3ykiWN/k3/4CmmDXxxuA2o47H6IWzpuM53aMXfYNWMff3vQOW8NqH+4XI9OkQU4
         z9uhxAhmj8oPdftdASpDh9XCxUw6q3T+fMW/8QrFsPwSWpquLlwSE5FplZuRy/EIs6tt
         BS0loyChMHA+SvO/hzGtXtXMCptK8N8+67MSNtq5mbZonIA07/Jws0vjajMHZr30ohrU
         JN7MwlsONzf0CPQ6cbAytHFeYaaGLM99hCELoKWvJCsf7/hupCeqLh3RRm67nVCVXuhi
         Bo7jet1sW5XLGuF938Yi4k3w6Brhlm+lUitRnQuQ20hYWLFwvPfiiaxywcgTPDDbu9Z2
         ghtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=QZyfWRWnC2zhBJJ6gI8ZcJlFDr0HjxC17lUyk3yqegI=;
        b=ngeqppl9GofZd5SkW7YnAov491SHKG+TMWhasZm7awu6QDuWR0q4AgCw2XemMKJqER
         inuoLdBu3vLmNH6mYHFBi9+J2+FFTBy/0yrj02pf7zdGPpPqeIK5/5BIVHAvRAWvGBGy
         GyAvUmMbB3JJYjwm8XmUdJbp+2w7rFdx2khToWYXOU13YatZ39ckCIFY4aeW/8+8vU9K
         7XFRG7IDv1yAEUMla4bhCietQpK6p8HlSzAoTC8K562CkH4hfB2ZUnY1mpgSrQq1Kf+w
         aJvORQCo3W2kYis+ooW1i7VYZkC4FjyrmdIESh1K764BZLsWqEboab84Ly7ci41uUDeu
         oJqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@one-eyed-alien.net header.s=google header.b=fLLUpNMk;
       spf=pass (google.com: domain of mdharm@one-eyed-alien.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=mdharm@one-eyed-alien.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@one-eyed-alien.net header.s=google header.b=fLLUpNMk;
       spf=pass (google.com: domain of mdharm@one-eyed-alien.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=mdharm@one-eyed-alien.net
X-Google-Smtp-Source: AG47ELtj+MlGoUtGuBv+87Xvi8rCdusBlmiJ0LRtY5+TD3uM+7nwHbSWWFwzE7p9wLynjJypQyhvSW9DP1iaQ/2vf1A=
MIME-Version: 1.0
In-Reply-To: <1521007356-12306-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1521007356-12306-1-git-send-email-chunfeng.yun@mediatek.com>
From: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Date: Tue, 13 Mar 2018 23:53:15 -0700
Message-ID: <CAA6KcBAnLYZ2UyUB6Ecv96D0zWhmce2BMmA_iWx04njeNYsd9w@mail.gmail.com>
Subject: Re: [PATCH] Add Apple Carplay driver
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Serge Semin <fancer.lancer@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>, Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594891852474932951?=
X-GMAIL-MSGID: =?utf-8?q?1594895018343977043?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Why is this a kernel-level driver, rather than a userspace application
that uses libusb to send the single vendor-specific command required?
Since this command would be applicable to many CarPlay devices, with
many different VID/PIDs, it would seem to make more sense as a
userspace app that took a reference to a USB device or VID/PID.

Matt

On Tue, Mar 13, 2018 at 11:02 PM, Chunfeng Yun
<chunfeng.yun@mediatek.com> wrote:
> From bf48dcd9cb254576cfea373c9a5d2ab996408895 Mon Sep 17 00:00:00 2001
> From: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Date: Tue, 13 Mar 2018 11:47:38 +0800
> Subject: [PATCH] Add Apple Carplay driver
>
> Some Apple devices which support Carplay can enter USB Host Mode from USB
> Device Mode after receiving a specific USB Vendor Request. There is a
> requirement apply to accesssories that support the USB dual role switch
> feature, and must have a USB-A receptacle that is capable of functioning
> in both USB Host and USB Device roles.
> It means that the driver should supports manual Dual-Role switch, due to
> no IDDIG pin is avaliable.
>
> There is no suitable place to add this spicific USB Vendor Request, so
> here I extract a single driver which allow user force to send it by a debug
> interface when need it, and keep it independent on USB Dual-Role Controller
> Drivers.
> But to implement carplay feature, there are some requirments for USB Dual-Role
> Driver:
> 1. supports manual dual-role switch, such as, by a debug interface;
> 2. keep vbus alive even when switch host into device mode;
>
> More information please refer to "Chapter 46. USB Role Switch" in
> MFI Accessroy Interface Specification.pdf
>
> Chunfeng Yun (1):
>   usb: misc: supports Apple Carplay driver
>
>  drivers/usb/misc/Kconfig   |    9 +++
>  drivers/usb/misc/Makefile  |    1 +
>  drivers/usb/misc/carplay.c |  193 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 203 insertions(+)
>  create mode 100644 drivers/usb/misc/carplay.c
>
> --
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Matthew Dharm
Former Maintainer, USB Mass Storage driver for Linux
