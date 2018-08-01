Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AB7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E3020840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E3020840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbeHBA5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:57:55 -0400
Received: from exmail.andestech.com ([59.124.169.137]:54212 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbeHBA5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:57:54 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w71N9EUL062542;
        Thu, 2 Aug 2018 07:09:14 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 2 Aug 2018
 07:09:37 +0800
Date:   Thu, 2 Aug 2018 07:09:38 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Palmer Dabbelt <palmer@sifive.com>
CC:     <albert@sifive.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Christoph Hellwig" <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Darius Rad <darius@bluespec.com>, <greentime@andestech.com>,
        <zong@andestech.com>
Subject: Re: [PATCH v2] riscv: Add support to no-FPU systems
Message-ID: <20180801230936.GA19815@andestech.com>
References: <1530073346-5341-1-git-send-email-alankao@andestech.com>
 <mhng-47d9ea80-a0c6-4cde-be65-75046c5d49d2@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mhng-47d9ea80-a0c6-4cde-be65-75046c5d49d2@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w71N9EUL062542
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 10:55:28AM -0700, Palmer Dabbelt wrote:
> On Tue, 26 Jun 2018 21:22:26 PDT (-0700), alankao@andestech.com wrote:
> >This patch adds an option, CONFIG_FPU, to enable/disable floating
> >procedures.  Also, some style issues are fixed.
> >
> >Signed-off-by: Alan Kao <alankao@andestech.com>
> >Cc: Greentime Hu <greentime@andestech.com>
> >Cc: Zong Li <zong@andestech.com>
> >---
> > arch/riscv/Kconfig                 |  9 ++++
> > arch/riscv/Makefile                | 19 +++----
> > arch/riscv/include/asm/switch_to.h |  6 +++
> > arch/riscv/kernel/entry.S          |  3 +-
> > arch/riscv/kernel/process.c        |  7 ++-
> > arch/riscv/kernel/signal.c         | 82 +++++++++++++++++++++---------
> > 6 files changed, 90 insertions(+), 36 deletions(-)
> >
> >diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >index 6debcc4afc72..6069597ba73f 100644
> >--- a/arch/riscv/Kconfig
> >+++ b/arch/riscv/Kconfig
> >@@ -232,6 +232,15 @@ config RISCV_BASE_PMU
> >
> > endmenu
> >
> >+config FPU
> >+	bool "FPU support"
> >+	default y
> >+	help
> >+	  Say N here if you want to disable all floating-point related procedure
> >+	  in the kernel.
> >+
> >+	  If you don't know what to do here, say Y.
> >+
> > endmenu
> 
> Sorry for letting this slide for a bit.  While I'm not opposed to a solution
> that requires a FPU Kconfig option, it'd be a bit better if we could detect
> this at boot time.  I think this should be possible because at one point
> this actually worked and we could boot the same kernel on FPU and no-FPU
> systems.
> 
> If that's not possible then we'll have to take something like this.  There
> were some comments on this v2 but I don't see a v3, did I miss one?

I have been refatoring this into a patchset containing logically
indenpendent patches.  It will be sent soon after some sanity checks.
