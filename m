Return-Path: <kernel-hardening-return-13036-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49MfrFFw9Ekn7qeRrf8mYPG3NiTCj/B20GFRuw08TcfdGkkYnEHoAl/ssrFerTOma9X7ezL
ARC-Seal: i=1; a=rsa-sha256; t=1524051522; cv=none;
        d=google.com; s=arc-20160816;
        b=CJrHmAnJVfVC9LfnUwpAXtEBcokgYFj0XjdR2m3v8zYga3yL1Az2Wjl2V6EybyFVJM
         IWgDApykkyV/VGKiLGvvIZxcWf42Ers2zVBepLnIuSyR3ki9OE/OMcaSCPo/4339KksT
         GBwJitHf7NYfzWwMnZEfHL89StXgQC47Pu91V5XwFAEfq9SDZoErHPTaDP6igd2iGRkI
         khM/xuRM3A+ccL6ejOjtH1L2QE65bPpxTzF+oea8Ve51Az60elZIemFkdHZHGVoygCw+
         9jhuvbzOo5ByC5496uvVAmuDycgU5R4YbWXkhH6DrvBnvyuUSDNHo7JKSKeuhcyPm9be
         hmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Y1UVHD7BlRtNjmzohlg1KalwNgwDAW+mb+DiB/8kFuM=;
        b=CnFXBix6/Ijq99uOMls6mGP6RWjf5r+OTu09H30LQBG05u0v1PJM3CR07hLd2ICnDL
         oqABjI9o1+4ke+pRd3zPKnEFXQUFflx1yyhqQmNcGVxNS2EkB4F1C/jiXngGo5fsa3wb
         LdDg307p+aGAu4hZVp71UPpVs4JTJsYaCbgHCEBpNz633VTDvJU5vnTS2QCO6w4GXdlG
         JRc9pDJrX921wm7XJzmoplZjgSMXYULTbvdc/NgHJrE2lIMDP2BgmI1BJPw3QDPih1Ms
         wS0g4dm14vBSvEGbQ+CCt0yWMAJrLKPW71k2Xu2rurRCcNJhY7nAWZR4bSBu8kewr+Pu
         3alg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13036-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13036-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13036-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13036-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 18 Apr 2018 12:38:16 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>, cdall@kernel.org,
	drjones@redhat.com, kvmarm@lists.cs.columbia.edu,
	linux-arch <linux-arch@vger.kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Adam Wallis <awallis@codeaurora.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCHv3 06/11] asm-generic: mm_hooks: allow hooks to be
 overridden individually
Message-ID: <20180418113816.sgxdnxrbg4imzxfx@lakrids.cambridge.arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
 <20180417183735.56985-7-mark.rutland@arm.com>
 <CAK8P3a3SVhW1ByQOtxw7JG8i3wWU5opdycfSCTbW=GCFvBJmQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3SVhW1ByQOtxw7JG8i3wWU5opdycfSCTbW=GCFvBJmQg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019747500119044?=
X-GMAIL-MSGID: =?utf-8?q?1598083849489730266?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 09:56:02PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 17, 2018 at 8:37 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Currently, an architecture must either implement all of the mm hooks
> > itself, or use all of those provided by the asm-generic implementation.
> > When an architecture only needs to override a single hook, it must copy
> > the stub implementations from the asm-generic version.
> >
> > To avoid this repetition, allow each hook to be overridden indiviually,
> > by placing each under an #ifndef block. As architectures providing their
> > own hooks can't include this file today, this shouldn't adversely affect
> > any existing hooks.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-arch@vger.kernel.org
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Cheers!

Mark.
