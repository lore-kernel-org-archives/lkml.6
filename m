Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247B7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39F02098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39F02098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeJEQu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:50:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53495 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeJEQu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:50:56 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 677d3cc73a615d88; Fri, 5 Oct 2018 11:52:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Thomas Gleixner <tglx@linutronix.de>, Chen Yu <yu.c.chen@intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12][v4] Backport several fixes from 64bits to 32bits hibernation
Date:   Fri, 05 Oct 2018 11:49:51 +0200
Message-ID: <1776557.eug3UU5KzN@aspire.rjw.lan>
In-Reply-To: <alpine.DEB.2.21.1810021119540.32062@nanos.tec.linutronix.de>
References: <cover.1537448058.git.yu.c.chen@intel.com> <alpine.DEB.2.21.1810021119540.32062@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 2, 2018 11:20:23 AM CEST Thomas Gleixner wrote:
> On Fri, 21 Sep 2018, Chen Yu wrote:
> 
> > Currently there are mainly three bugs in 32bits system when doing
> > hibernation:
> > 1. The page copy code is not running in safe page, which might
> >    cause hang during resume.
> > 2. There's no text mapping for the final jump address
> >    of the original kernel, which might cause the system jumping
> >    into illegal address and causes system hang during resume.
> > 3. The restore kernel switches to its own kernel page table(swapper_pg_dir)
> >    rather than the original kernel page table after all the pages
> >    been copied back, which might cause invalid virtual-physical
> >    mapping issue during resume.
> > 
> > To solve these problems:
> > 
> > 1. Copy the code core_restore_code to a safe page, to avoid the instruction
> >    code been overwritten when image kernel pages are being copied.
> > 2. Set up temporary text mapping for the image kernel's jump address,
> >    so that after all the pages have been copied back, the system could
> >    jump to this address.
> > 3. Switch to the original kernel page table during resume.
> > 
> > Furthermore, MD5 hash check for e820 map is also backported from 64bits
> > system.
> > 
> > In order to make this patch set more readable, these fixes are splitted
> > into several sub patches.
> > 
> > And use CONFIG_X86_64 to control the common code to be 'activated' for
> > 32 bit system during each sub-patch for better maintaining.
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Rafael, it's all yours :)

Thank you, I have applied the series.

This was long overdue, many thanks to everyone involved for taking care of it!

Thanks,
Rafael

