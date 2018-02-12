Return-Path: <kernel-hardening-return-11723-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x22575IBBOhxjsfCZWphGYZkZD/iNQtkhlGGXviaMrJN5ymn/Z2w4Hf/w0tET8EVbbCaAvrmN
ARC-Seal: i=1; a=rsa-sha256; t=1518451267; cv=none;
        d=google.com; s=arc-20160816;
        b=Gr/Y03MDRSzNxI1rrtgHC5ga52adFdpVd0LrKCRzoeAAGp3Cb2cdihxzRg5O23RhFC
         4KykOD8PK2u2KzvdV0l7lb/SLns8Vh2Wje8znKIMvgxF6MMaV2lgVHHNhxxuCiNMQgNR
         O/ZfBYEt4WUQe0Qu4cYhNlWBnnNhAby/fo+bLniCpzXlOqFWdufyR+8Goy5vaK4T+2LU
         1a0GSnBoMUGhzEVFByOMCQ7lsrVIjZaAFhdWVWtCwR2ShRpT3XecUIpBbVUqTOVtlWaq
         MvYwmJHoX5lWXFxHF88auBzT2Z5L4ecdjkxXqcXE54aIxuBa7SCePCb0HQhXPW/qMJu+
         uhZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=dBKaZ0juvIT9KJwAM79awEnX2jPL4/eCYJFV6EKFZYQ=;
        b=IK/8Kqb+ym4T97q2Gh27YkARMN/ClDgJkPH4jr+2OCamiCdrVWuPqbwjhEdinRYaIC
         W682xS1B2BikT0umiKP2+XGnceNbq6zUGcX+KKVUcY68xJEnkUscCU8svMJELxcVv1HH
         eFyYcmZxNvUQmlUeOKgS2tkP3r/JAbm+d1ILQJnrmKSErZHsmhZFvGWaak+eyGUZsUe9
         YuOISQSlVfrkgklPik1rOpawv615siW0n9IVNx0OmAC1BZuDPhaRk3P+y1CQI7LUxF54
         f6iWB5rOv0HKdkz9SQBBXlX3exOZVCSmwi9Bb1RK3gGHOxXfG68Q4OKkATYEkkwDW66w
         CfWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11723-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11723-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11723-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11723-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Feb 2018 16:00:39 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	catalin.marinas@arm.com, cdall@linaro.org,
	kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
	marc.zyngier@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com,
	yao.qi@arm.com, kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org, awallis@codeaurora.org
Subject: Re: [PATCHv2 05/12] arm64: Don't trap host pointer auth use to EL2
Message-ID: <20180212160039.br2emy3zt6ftmwfu@lakrids.cambridge.arm.com>
References: <20171127163806.31435-1-mark.rutland@arm.com>
 <20171127163806.31435-6-mark.rutland@arm.com>
 <20180206123906.GZ21802@cbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206123906.GZ21802@cbox>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1585238009734058312?=
X-GMAIL-MSGID: =?utf-8?q?1592211556398310113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 01:39:06PM +0100, Christoffer Dall wrote:
> Hi Mark,
> 
> On Mon, Nov 27, 2017 at 04:37:59PM +0000, Mark Rutland wrote:
> > To allow EL0 (and/or EL1) to use pointer authentication functionality,
> > we must ensure that pointer authentication instructions and accesses to
> > pointer authentication keys are not trapped to EL2 (where we will not be
> > able to handle them).
> 
> ...on non-VHE systems, presumably?

For EL0 usage, we don't want to trap even in the absence of VHE, so I'll
drop the bit in brackets entirely.

> > This patch ensures that HCR_EL2 is configured appropriately when the
> > kernel is booted at EL2. For non-VHE kernels we set HCR_EL2.{API,APK},
> > ensuring that EL1 can access keys and permit EL0 use of instructions.
> > For VHE kernels, EL2 access is controlled by EL3, and we need not set
> > anything.
> 
> 
> for VHE kernels host EL0 (TGE && E2H) is unaffected by these settings,
> and it doesn't matter how we configure HCR_EL2.{API,APK}.
> 
> (Because you do actually set these bits when the features are present if
> I read the code correctly).

Ah, true. I've taken your proposed wording.

> > This does not enable support for KVM guests, since KVM manages HCR_EL2
> > itself.
> 
>         (...when running VMs.)
> 
> 
> Besides the nits:
> 
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Cheers!

Mark.
