Return-Path: <kernel-hardening-return-11952-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsb57qwJCkAbnwujIQofgdjI+jgMitWFU6iLUHP/ZxEe0ZwS6pmXRX4yiEaMv9nnCZcUjWd
ARC-Seal: i=1; a=rsa-sha256; t=1519607418; cv=none;
        d=google.com; s=arc-20160816;
        b=vp8zex9m+LIRuigx379eRf2ZD2IBVmuj6eUGw1Em3gyfnlwGqOuFf7P1EyakM2KgpN
         Bct3DnToqDr2PwfzfGDGetNyFXszHHXsdavDhpnYHtKhW9XUlrcpw1BsMgUe18AEQKXI
         zB6PshffCGGQPQzE9ZTNq6Y0jueIC58by5ePpY3CvZvgK3QvpqAjEFteFBEiuqEk4xer
         XQ2AIpfjPFppV08pVuMFyTxnpYEOSFHnM9g3XYSP7sa4LSyIMCMrFLaK0HmdZViUkWrU
         XjFkMMB4GqW8bTdWvWmuohaYSNB+r1GnUeODmhUyubNal4aRoQixdKgIcIyQEOLvgWmJ
         sEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=DcQtHhR2lftXnHFobrnIvXK6iqZpGIiFH8eIUGsLVjc=;
        b=aVKLfPY8ZJpbnxzJxXezhjed/2q93W+eQ+wnxSj4H1muaHKCM3xcS7Lbw1eDeRaObR
         rXXH/26WcZkmOKyqdAxfaMLbt26SQJrcnEesWmKiZR8uJf5c+wo9D+QmN4gTgITNykR4
         IX7ySfhE4VAvNsoa5szBX5kJ66mEK9rADTdDhVz2XcCj+PT1H06RWY+cbnE6xy6YDEvY
         MktrZZOmc2O08ZkXwMSOCJ+bS0bS1Ir1sQCYOsPoiHKiShXkuCfgA7Vm0+wOVllZ/XCZ
         UIaK4Fq0oKGRWTLMgo2OYQzHf64jzzfMQJxVGWUsrivjpVJ0FZ/vBeIZD8WTRW060cTy
         If3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=YN2jvr3L;
       spf=pass (google.com: domain of kernel-hardening-return-11952-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11952-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=YN2jvr3L;
       spf=pass (google.com: domain of kernel-hardening-return-11952-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11952-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 25 Feb 2018 18:09:53 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] leaking_addresses: add scan_once array
Message-ID: <20180226010953.37z3sz3rwcnj426k@cisco>
References: <1519008649-15782-1-git-send-email-me@tobin.cc>
 <1519008649-15782-5-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519008649-15782-5-git-send-email-me@tobin.cc>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592796084722705424?=
X-GMAIL-MSGID: =?utf-8?q?1593423869039911845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tobin,

On Mon, Feb 19, 2018 at 01:50:49PM +1100, Tobin C. Harding wrote:
> +sub already_scanned
> +{
> +	my ($filename) = @_;
> +	state %seen;
> +
> +	foreach (@once_only) {
> +		if (/^$filename$/) {
> +			if ($seen{$_} == 1) {

This should be something like,

if (($seen{$_} //= 0) == 1) {

otherwise I get a bunch of uninitialized warnings,

Use of uninitialized value in pattern match (m//) at /usr/share/perl/5.26/Math/BigInt.pm line 1199.
    Math::BigInt::bcmp(Math::BigInt=HASH(0x55dc2f7e4580), undef) called at /usr/share/perl/5.26/Math/BigInt.pm line 1257
    Math::BigInt::beq(Math::BigInt=HASH(0x55dc2f7e4580), undef) called at /usr/share/perl/5.26/Math/BigInt.pm line 105
    Math::BigInt::__ANON__(Math::BigInt=HASH(0x55dc2f7e4580), undef, 1) called at ./leaking_addresses.pl line 422
    main::already_scanned("smaps") called at ./leaking_addresses.pl line 448
    main::skip("/proc/1/smaps") called at ./leaking_addresses.pl line 509
    main::walk("/proc", "/sys") called at ./leaking_addresses.pl line 159

Tycho
