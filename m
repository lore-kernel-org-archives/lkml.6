Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3708C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E11B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E11B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJDVSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:18:13 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:64436 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727322AbeJDVSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:18:13 -0400
X-Greylist: delayed 1225 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Oct 2018 17:18:11 EDT
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w94E7H0u057543
        for <linux-kernel@vger.kernel.org>; Thu, 4 Oct 2018 22:07:17 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w94E6k36057260;
        Thu, 4 Oct 2018 22:06:48 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 4 Oct 2018
 13:30:42 +0800
Date:   Thu, 4 Oct 2018 13:30:42 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Palmer Dabbelt <palmer@sifive.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <albert@sifive.com>, Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>, <greentime@andestech.com>,
        <vincentc@andestech.com>, <zong@andestech.com>,
        <nickhu@andestech.com>
Subject: Re: [PATCH v7 0/5] riscv: Add support to no-FPU systems
Message-ID: <20181004053042.GA31734@andestech.com>
References: <1535332075-5727-1-git-send-email-alankao@andestech.com>
 <mhng-e6132f52-a57b-482e-8fed-03e3b6f0ee93@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mhng-e6132f52-a57b-482e-8fed-03e3b6f0ee93@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w94E6k36057260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 02:45:04AM -0700, Palmer Dabbelt wrote:
> On Sun, 26 Aug 2018 18:07:50 PDT (-0700), alankao@andestech.com wrote:
> >This patchset adds an option, CONFIG_FPU, to enable/disable floating-
> >point procedures.
> >
> >Kernel's new behavior will be as follows:
> >
> >* with CONFIG_FPU=y
> >  All FPU codes are reserved.  If no FPU is found during booting, a
> >  global flag will be set, and those functions will be bypassed with
> >  condition check to that flag.
> >
> >* with CONFIG_FPU=n
> >  No floating-point instructions in kernel and all related settings
> >  are excluded.
> >
> >Changes in v7:
> > - Remove "fd" attribute from KBUILD_CFLAGS.
> >
> >Changes in v6 (PATCH 0005 only):
> > - Make the flag checking neater.
> >
> >Changes in v5:
> > - Invert the polarity of checking flag from no_fpu to has_fpu.
> >
> >Changes in v4:
> > - Append a new patch to detect existence of FPU and followups.
> > - Add SPDX header to newly created fpu.S.
> > - Fix a build error, sorry for that.
> > - Fix wording, style, etc.
> >
> >Changes in v3:
> > - Refactor the whole patch into independent ones.
> >
> >Changes in v2:
> > - Various code cleanups and style fixes.
> >
> >
> >Alan Kao (5):
> >  Extract FPU context operations from entry.S
> >  Refactor FPU code in signal setup/return procedures
> >  Cleanup ISA string setting
> >  Allow to disable FPU support
> >  Auto-detect whether a FPU exists
> >
> > arch/riscv/Kconfig                 |   9 +++
> > arch/riscv/Makefile                |  19 +++---
> > arch/riscv/include/asm/switch_to.h |  12 +++-
> > arch/riscv/kernel/Makefile         |   1 +
> > arch/riscv/kernel/cpufeature.c     |   8 +++
> > arch/riscv/kernel/entry.S          |  87 -----------------------
> > arch/riscv/kernel/fpu.S            | 106 +++++++++++++++++++++++++++++
> > arch/riscv/kernel/process.c        |   6 +-
> > arch/riscv/kernel/signal.c         |  75 ++++++++++++--------
> > 9 files changed, 196 insertions(+), 127 deletions(-)
> > create mode 100644 arch/riscv/kernel/fpu.S
> 
> Thanks!  I'll add this to our for-next branch.

Any updates?
