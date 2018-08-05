Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F48C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 23:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44023219A3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 23:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44023219A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeHFBi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 21:38:28 -0400
Received: from exmail.andestech.com ([59.124.169.137]:37639 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeHFBi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 21:38:28 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w75NVIBs005553;
        Mon, 6 Aug 2018 07:31:18 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 6 Aug 2018
 07:32:00 +0800
Date:   Mon, 6 Aug 2018 07:32:01 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Palmer Dabbelt <palmer@sifive.com>
CC:     Andrew Waterman <andrew@sifive.com>, <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Darius Rad <darius@bluespec.com>, <greentime@andestech.com>,
        <zong@andestech.com>
Subject: Re: [PATCH v2] riscv: Add support to no-FPU systems
Message-ID: <20180805233201.GA15062@andestech.com>
References: <CA++6G0AMXC0ZeTZ+tkLh_5QGoPMR+3YD8Ed=DR8-G=6FL1yDSw@mail.gmail.com>
 <mhng-d4977eb5-94cc-4b3f-b548-e27158814ed7@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mhng-d4977eb5-94cc-4b3f-b548-e27158814ed7@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w75NVIBs005553
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 09:03:00PM -0700, Palmer Dabbelt wrote:
> On Wed, 01 Aug 2018 11:23:43 PDT (-0700), Andrew Waterman wrote:
> >On Wed, Aug 1, 2018 at 10:55 AM, Palmer Dabbelt <palmer@sifive.com> wrote:
> >>On Tue, 26 Jun 2018 21:22:26 PDT (-0700), alankao@andestech.com wrote:
> >>>
> >>>This patch adds an option, CONFIG_FPU, to enable/disable floating
> >>>procedures.  Also, some style issues are fixed.
> >>>
> >>>Signed-off-by: Alan Kao <alankao@andestech.com>
> >>>Cc: Greentime Hu <greentime@andestech.com>
> >>>Cc: Zong Li <zong@andestech.com>
> >>>---
> >>> arch/riscv/Kconfig                 |  9 ++++
> >>> arch/riscv/Makefile                | 19 +++----
> >>> arch/riscv/include/asm/switch_to.h |  6 +++
> >>> arch/riscv/kernel/entry.S          |  3 +-
> >>> arch/riscv/kernel/process.c        |  7 ++-
> >>> arch/riscv/kernel/signal.c         | 82 +++++++++++++++++++++---------
> >>> 6 files changed, 90 insertions(+), 36 deletions(-)
> >>>
> >>>diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>>index 6debcc4afc72..6069597ba73f 100644
> >>>--- a/arch/riscv/Kconfig
> >>>+++ b/arch/riscv/Kconfig
> >>>@@ -232,6 +232,15 @@ config RISCV_BASE_PMU
> >>>
> >>> endmenu
> >>>
> >>>+config FPU
> >>>+       bool "FPU support"
> >>>+       default y
> >>>+       help
> >>>+         Say N here if you want to disable all floating-point related
> >>>procedure
> >>>+         in the kernel.
> >>>+
> >>>+         If you don't know what to do here, say Y.
> >>>+
> >>> endmenu
> >>
> >>
> >>Sorry for letting this slide for a bit.  While I'm not opposed to a solution
> >>that requires a FPU Kconfig option, it'd be a bit better if we could detect
> >>this at boot time.  I think this should be possible because at one point
> >>this actually worked and we could boot the same kernel on FPU and no-FPU
> >>systems.
> >
> >I believe it would suffice to have start_thread set sstatus.FS to OFF
> >for no-FPU systems (vs. INITIAL for systems with FPU).   The ISA
> >string in the devicetree should indicate whether F/D extensions are
> >present.
> >
> >That said, it makes sense to me to additionally provide the Kconfig
> >option.  This would elide the sstatus.SD check for no-FPU systems,
> >shaving a couple instructions off the context-switch path.  It would
> >also enable mimicking the behavior of a no-FPU system even when the
> >FPU is present.
> 
> That sounds like a good argument.  Do you mind submitting a two-part patch
> set, to:
> 
> * Allow FPU kernels to detect and run correctly on non-FPU systems.  You
> should  be able to detect these very early by writing to sstatus, or later
> by looking  at the device tree.
> * Add a Kconfig option to disable the FPU entirely (which is pretty much
> this  patch).
> 
> Thanks!
> 

Thanks for the feedback from all of you.

We will fix v3 according to Christph's suggestions,
and append a new patch of the auto-detecting feature.
