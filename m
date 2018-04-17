Return-Path: <kernel-hardening-return-13031-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48zFqmd0hAC3hmnMQAUIIo9/tZeH5Wa0FVIeFDEsskVgd2Ppaqup40SRl9GQEkvmcEB2e4f
ARC-Seal: i=1; a=rsa-sha256; t=1523994980; cv=none;
        d=google.com; s=arc-20160816;
        b=QkkZ27LPASFX8VJSyYOLlbthpelJ61ROOabf2XoUIYCakwYhb66ZHD+DQEZaQecBkk
         uU7qEB+rDloZfHsDnYiNmQbEz8zkJeKB0QqvX4XDMg8CYwWReIl6WtA3tN7SWAfjgd1B
         395ad9C5c93vPH+xyPDCDxMFLMREUUB/CdauZ/4HPRCBfqHkiykdR9zDqoCwc2dxkgTd
         frPtHq4FbBthfaiT2bqaAv0Jf4wun43OKOM+XJL+gwF4U/Kf12GI+psNm95Osm8XGtnv
         LN2HP+dgY6TaERdigVnB961Pz9plnqQ/gQCTlldyFla91c/iAz2V4fDwzW4Xhfpp+gnW
         ZBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=eZGAVXf/qp8NhFRMC2lpjuHVO16rVHPR2gPgjjIhwgg=;
        b=qpfdV23CGy1xNKFEpwmBqtJHaJxqlRkpRjFyZ2falQlShfTSWqaC650ZwwoPO/DQE+
         ymQk1hSwFwrkkt/uDQaXvdt18KyqMMa2/BfX6CYFt8slJR2cXhUNHzWdosSaE7//Kmki
         d7fa6S3Qqo5AHsB48pQm08UYaryYX2Q4JailDKO/Ez0RMkl+aD5YhtgxkvhU+5pOQkDp
         U+vcpEgmYFsuvKdoBXD9Pk3fvD2m6n5zZLvrfS9fcu7/QchEDAH3V46GYO/X4mjA0K61
         UOP5F/s3FPQVPs7Wvi9xZoAK9SQOyNKORvgZyQSuA5PN3xlvhFieEUoOKMPSPRV9xrhA
         OvWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kPAOhtVn;
       spf=pass (google.com: domain of kernel-hardening-return-13031-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13031-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kPAOhtVn;
       spf=pass (google.com: domain of kernel-hardening-return-13031-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13031-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180417183735.56985-7-mark.rutland@arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com> <20180417183735.56985-7-mark.rutland@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 17 Apr 2018 21:56:02 +0200
X-Google-Sender-Auth: QW06g8Mf48_VtHGEwdL9Pgq1cXM
Message-ID: <CAK8P3a3SVhW1ByQOtxw7JG8i3wWU5opdycfSCTbW=GCFvBJmQg@mail.gmail.com>
Subject: Re: [PATCHv3 06/11] asm-generic: mm_hooks: allow hooks to be
 overridden individually
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>, cdall@kernel.org, drjones@redhat.com,
	kvmarm@lists.cs.columbia.edu, linux-arch <linux-arch@vger.kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adam Wallis <awallis@codeaurora.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019747500119044?=
X-GMAIL-MSGID: =?utf-8?q?1598024560700607060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 8:37 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Currently, an architecture must either implement all of the mm hooks
> itself, or use all of those provided by the asm-generic implementation.
> When an architecture only needs to override a single hook, it must copy
> the stub implementations from the asm-generic version.
>
> To avoid this repetition, allow each hook to be overridden indiviually,
> by placing each under an #ifndef block. As architectures providing their
> own hooks can't include this file today, this shouldn't adversely affect
> any existing hooks.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
