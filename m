Return-Path: <kernel-hardening-return-12412-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsusTNdii7RrrRI9g1n3Dt09hGEUfy76lDRcPCtao48vqFgl4c7Uc+0gmF93Jp5vKDg+ccM
ARC-Seal: i=1; a=rsa-sha256; t=1520831205; cv=none;
        d=google.com; s=arc-20160816;
        b=YwUsYKE0xpl85TTQaCXZCWuMyZrqV8QHUDm54O0vaOrqIgu24aPOTw9b8Qu1k2hsEt
         l7afbOMwDcGpoVHuzwoWz7xmySce4KIV1xJ4wnAn/TeiHbPiVn9TpBPyq1jveyAaoxfw
         rPRUL7+nGwsHDCEaI9NRWKRwKGSytZywNc7lPEi4o+Y+zLCcu/u42MrILXFWXu6a35O8
         /IrTQHG+alytBH43w+KyTnaEukQLwuNZax6l0djZdIBbCwOTuQ8H1Qwc+TFPknMvlZuK
         ieCxkGKaroHm5abhArJbcuB9DoprnXFVQPveXzDUrj5vA8DZIPYHV0jJJiYfj7Wi8N9/
         ckTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=ZTwFoiFSkQxrYNJqMaHI8oCmSRSrTXdeu61DiK4Gixk=;
        b=oHRhB0AA6EMbYxRZIQBjoXY4L63EKUFwJDl09kmXJ4bonXm2rPOtMmL1RNfT7OODhK
         X88dKgPlznxjMFU4u8c5bv7LN1RQaV2/dLSnXQ7NUIPfGB6bmGsWbNZtkKaDkCF4xvNu
         s7fpkA42GcEOUQROpQVfeLLXuOGCqyZogRZ6WU8b4ggpIVrc1zwaV5JaB7U79RTSOdVE
         Psa6owE8lOqkYWEeEpte6Iiz3wXBOmpAJ1Hg02zW/o5rKTTxOUINuQ/i0d017pLp6Prm
         c1MLSjmzbE7Exyru2tJXRVUFHlX5yVA7f5Ta07XfT3z7srUoidv+R4/v8IQxltWiDNOj
         S5Og==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=JnI4mNdt;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Efu5RVF5;
       spf=pass (google.com: domain of kernel-hardening-return-12412-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12412-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=JnI4mNdt;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Efu5RVF5;
       spf=pass (google.com: domain of kernel-hardening-return-12412-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12412-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:0gqmWttr6ILRshL_PtXo-zUqfYGk_Yko_LtfXuWRFYlIYd6K2omjxw>
Date: Mon, 12 Mar 2018 16:06:23 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
	Alex Elder <elder@kernel.org>, ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] rbd: Remove VLA stack usage
Message-ID: <20180312050623.GD8631@eros>
References: <1520830180-25452-1-git-send-email-me@tobin.cc>
 <20180312050204.GC25480@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312050204.GC25480@zzz.localdomain>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594706055475539474?=
X-GMAIL-MSGID: =?utf-8?q?1594707102207299191?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 11, 2018 at 10:02:04PM -0700, Eric Biggers wrote:
> On Mon, Mar 12, 2018 at 03:49:40PM +1100, Tobin C. Harding wrote:
> > The kernel would like to have all stack VLA usage removed[1].
> 
> Can you please stop writing this?  The Linux kernel isn't sentient; it doesn't
> "like" anything.  You need to explain why *you* (and other people) believe these
> changes should be made.

No worries, will re-spin with better description.

thanks,
Tobin.
