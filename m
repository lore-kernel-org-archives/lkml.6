Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D7EC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708EC20883
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547904693;
	bh=69JKOV4aZJgNkcHQhaXRUy/LvLRubnjjGz8b+joy6xg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tGMtxHxxBROAzghzy87joSB8VYDhhy/m4HNmeb3qY23mx62HqoQXd5y9HTyrq2Aki
	 qug8ZL3Xd5ZmJnaAxDRvjDZoKSS+mUc9CO+ZDZXDfKLRed992yvSjakxFFkX3OfDlU
	 dKbW7/2c/keFEvyf0vVrpO06KhaPASO4p/uB1Vhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfASNbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:31:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbfASNbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 08:31:31 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBAA82086A;
        Sat, 19 Jan 2019 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547904691;
        bh=69JKOV4aZJgNkcHQhaXRUy/LvLRubnjjGz8b+joy6xg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JWpGMpGgYrSJ1SYVCdWK2KR35Hl+lLtVPTNZ9mE64uCtu7UEB3zj6PQ9SCmO6ZfmV
         znxq3kbP9ixGV2mTPkbQJEJX9tviIGJcIE2R8osVWjyn87HZKhNotKTcORumLHrz3N
         G1R4EcQywDrJiKRl0LuKkxD/Cq8BNlalfWcuB3+Q=
Date:   Sat, 19 Jan 2019 22:31:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 0/4] arm64: kprobes: Update blacklist checking on
 arm64
Message-Id: <20190119223126.6741b98ffae45b52f433a650@kernel.org>
In-Reply-To: <20190116134007.GA15255@fuggles.cambridge.arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
        <20190116134007.GA15255@fuggles.cambridge.arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Wed, 16 Jan 2019 13:40:07 +0000
Will Deacon <will.deacon@arm.com> wrote:

> Hi Masami,
> 
> On Tue, Jan 15, 2019 at 03:23:39PM +0900, Masami Hiramatsu wrote:
> > Hello,
> > 
> > Here is the v2 series of update of the kprobe blacklist
> > checking on arm64.
> > 
> > I found that some blacklist checking code were mis-placed in
> > arch_prepare_kprobe() and arch_within_kprobe_blacklist().
> > Since the blacklist just filters by symbol, smaller than the
> > symbol, like extable must be checked in arch_prepare_kprobe().
> > Also, all function (symbol) level check must be done by blacklist.
> > 
> > For arm64, it checks the extable entry address in blacklist
> > and exception/irqentry function in arch_prepare_kprobe().
> > And, RODATA check is unneeded since kernel/kprobes.c
> > already ensures the probe address is in kernel-text area.
> > 
> > In v2, I updated [1/4]'s description and added James'
> > Reviewed-by. Also, in this version, I added a patch which
> > uses arch_populate_kprobe_blacklist() instead of
> > arch_within_kprobe_blacklist() so that user can see the full
> > list of blacklisted symbols under the debugfs.
> 
> Assuming these are targetting the arm64 tree, are you intending to get them
> merged for 5.0?

No, I don't rush it, since these are not bugfix but just enhancements.
(User can see the blacklisted symbols precisely) If you think you are
easy to pick this to arm64/next, it is OK to me.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
