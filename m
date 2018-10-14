Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799BCC070C3
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 23:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E0E20652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 23:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E0E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeJOHaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 03:30:22 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:36284 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725792AbeJOHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 03:30:21 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9ENmn0T059745;
        Mon, 15 Oct 2018 07:48:49 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 15 Oct 2018
 07:46:39 +0800
Date:   Mon, 15 Oct 2018 07:46:40 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Greentime Hu <greentime@andestech.com>,
        Vincent Chen <vincentc@andestech.com>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>
Subject: Re: [PATCH v8 3/5] Cleanup ISA string setting
Message-ID: <20181014234639.GA14835@andestech.com>
References: <1539051514-3658-1-git-send-email-alankao@andestech.com>
 <1539051514-3658-4-git-send-email-alankao@andestech.com>
 <20181014000205.GA22333@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181014000205.GA22333@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9ENmn0T059745
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Sat, Oct 13, 2018 at 05:02:05PM -0700, Guenter Roeck wrote:
> Hi,
> 
> With this patch in -next applied, I get the following error
> when building riscv:defconfig.

I guess what you meant was this commit:
commit 0a5bee05fc67ce2044b8d91a18abbf14042da531

The modification in Makefile was

-endif
-
-KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)fd$(KBUILD_ARCH_C)
+# ISA string setting
+riscv-march-$(CONFIG_ARCH_RV32I)       := rv32im
+riscv-march-$(CONFIG_ARCH_RV64I)       := rv64im
+riscv-march-$(CONFIG_RISCV_ISA_A)      := $(riscv-march-y)a
+riscv-march-y                          := fd
+riscv-march-$(CONFIG_RISCV_ISA_C)      := $(riscv-march-y)c

and the ":= fd" line was wrong.  It should have been 

+riscv-march-y                          := $(riscv-march-y)fd

> 
> 
> What am I missing ? Does RISC-V now require a new non-upstream compiler ?
> Or a special version of make ? I am currently using GNU Make 4.1.

So I sent the v8 to fix this problem.
Sorry for the inconvinience.

> 
> Thanks,
> Guenter
> 
> ---

And Palmer, it seems that the patch that causes this build error has been
pulled into linux-next.  Any idea how to fix that one?

Many thanks,
Alan
