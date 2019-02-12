Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023E9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F19217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549985297;
	bh=s6/a0bPet2ex/8bTsaFozGz2TXCrghouCP9rpUuEGCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yLOwiPeAHgOaExHh3rWwv6C2Fu26833VEmQeCDc9izk4+g5Him3CiPgqZuDI2tsgf
	 ltfgZIXFtRJ/d47Cty+I/886K5WXVy4/6hfffswi8j0JBzcQgpYoqbJ8hLHa3YuOv+
	 GjM+45jKSYITMUAlKrz6l0KwxXpmwJyB/ttHVFDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfBLP2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:28:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbfBLP2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:28:15 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F21E42084E;
        Tue, 12 Feb 2019 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549985295;
        bh=s6/a0bPet2ex/8bTsaFozGz2TXCrghouCP9rpUuEGCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e+rXngJFkKNT1anz/+MSTnbgC3Dh3SIgxAZ7P0ivef3UFARlmJYcyMZ5h1GZR+kZX
         oX9JQyya7YwgI7kw9MxHhSFLJ1ln5n90KqUfBgEdXi03wxZjw9OLsAEj/D6gpeq8uL
         WAN2xbzooof6IBXMD6s+MO3i7RLbcOAXqC2WvtYg=
Date:   Wed, 13 Feb 2019 00:28:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
Message-Id: <20190213002811.37186ba204f5eec7b9a30445@kernel.org>
In-Reply-To: <659f8c4f-c5ef-ade7-4fb3-aacff5779d73@arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
        <154753353370.31541.14485875717131836689.stgit@devbox>
        <7f840cc8-4e62-e1d7-9035-4361204fc134@arm.com>
        <20190121222558.1ef0abc89a704597d6c3de7f@kernel.org>
        <20190208091519.GB6972@fuggles.cambridge.arm.com>
        <20190211221023.0bb43554647f99afce8dd060@kernel.org>
        <20190211155836.GA2692@fuggles.cambridge.arm.com>
        <659f8c4f-c5ef-ade7-4fb3-aacff5779d73@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 16:05:17 +0000
Marc Zyngier <marc.zyngier@arm.com> wrote:

> On 11/02/2019 15:58, Will Deacon wrote:
> > [+Marc]
> > 
> > On Mon, Feb 11, 2019 at 10:10:23PM +0900, Masami Hiramatsu wrote:
> >> On Fri, 8 Feb 2019 09:15:19 +0000
> >> Will Deacon <will.deacon@arm.com> wrote:
> >>> Did you send a new version of this series? I can't seem to spot it in my
> >>> inbox.
> >>
> >> Ah, OK. I just waited for James' patch series,
> >>
> >> https://patchwork.kernel.org/cover/10779489/
> >>
> >> Are those merged? I'd like to move this series on that.
> > 
> > Patches 2-4 are in mainline:
> > 
> > f7daa9c8fd19 arm64: hibernate: Clean the __hyp_text to PoC after resume
> > 8fac5cbdfe0f arm64: hyp-stub: Forbid kprobing of the hyp-stub
> > f2b3d8566d81 arm64: kprobe: Always blacklist the KVM world-switch code
> > 
> > Patch 1 is queued via kvm-arm (also for 5.0) but it doesn't seem to have
> > landed yet.
> 
> It was part of the pull request sent on Thursday[1], but Paolo hasn't
> pulled it yet.
> 
> Hopefully soon...

OK, then I'll send updated series since Patch1 is independent from
this series.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
