Return-Path: <kernel-hardening-return-11953-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsf2Kp+keIiC2P8HvhOmG6RNcumcNqdjcUv7VGPC77gK4ZF/BtH8doghrLBTsTn/KmBEZpt
ARC-Seal: i=1; a=rsa-sha256; t=1519608413; cv=none;
        d=google.com; s=arc-20160816;
        b=P+DIAKua2RKffztsatfY8M+i7UOXZ5Uh3AEIJt2Jpnrj/qVQyiTVDqZoUaMhheR3Na
         XUxET31jT2RGaUkdDGQHX+4Rt9Lsd3NM9XrKP11X7OhZg1omPOmUffE4r4D944q6OZYQ
         Hziplgiqf7S1kplREMzC8cfGu1OsELc5nATnfK1iTcIHMaBfJpxDuth5W9uXrdZlxrDM
         AXaj+I6zFeLjWbjB9HeJFFh2kTirZ1S8qAlTUeSdF0wzJbwU/ZXlfvvsfKgGKoiE9mrB
         cjeHfrX0j/QCmj0b95/sTcZ5sov+S/k7aI+r+FOvcYq5Dn+lmS+rTHlgVZkJRq4Es/7z
         J9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=r6WKPwZA6NjclYG1IYhYkTtnT/R2IzR8Ty3QfTzHMAg=;
        b=UbS7WXyHS49tQD81iZf9jD5gFUK4vG87slbUDVSgpDADV2p/M/f4UZlWT1I31iI3BC
         3Y76z/S3FVrYfedzc8I1GHr1uLRdUkq6m5zwq+TwCgNHjHyGGHZ45KDRlk+uTV2w9uul
         WzKrdeTrd89dZQ/EPPTq5KixBzAKoy/+Xj5a9SgXETUuDClXPyWbdLqyf/L4BCUh47cx
         ODxG8JlThmINmAZ9dS5MHyfNDLFaNRrFaMbGgZxcIupoi7ltkt3HZWi7FXqzTbr4w7lK
         cGhpIQTZurrF4pqa1boMaZPkLDHvIB23C5zGjrehFLcDH3bnk1Jgba3pwv+7fVFIVZXX
         zm0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=sPEQZxqK;
       spf=pass (google.com: domain of kernel-hardening-return-11953-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11953-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=sPEQZxqK;
       spf=pass (google.com: domain of kernel-hardening-return-11953-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11953-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 25 Feb 2018 18:26:31 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] leaking_addresses: simplify path skipping
Message-ID: <20180226012631.qff25qjngubxy4ia@cisco>
References: <1519008649-15782-1-git-send-email-me@tobin.cc>
 <1519008649-15782-3-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519008649-15782-3-git-send-email-me@tobin.cc>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592796064766188382?=
X-GMAIL-MSGID: =?utf-8?q?1593424911861460064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tobin,

On Mon, Feb 19, 2018 at 01:50:47PM +1100, Tobin C. Harding wrote:
> -# Do not parse these files under any subdirectory.
> -my @skip_parse_files_any = ('0',
> -			    '1',
> -			    '2',
> -			    'pagemap',
> -			    'events',
> -			    'access',
> -			    'registers',
> -			    'snapshot_raw',
> -			    'trace_pipe_raw',
> -			    'ptmx',
> -			    'trace_pipe');

It might be worth adding 'syscall' here; the pointers listed are user
pointers, and negative syscall args will show up like kernel pointers,
e.g. I get this output, which is spurious:

/proc/31808/syscall: 0 0x3 0x55b107a38180 0x2000 0xffffffffffffffb0 0x55b107a302d0 0x55b107a38180 0x7fffa313b8e8 0x7ff098560d11

Cheers,

Tycho
