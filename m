Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E67C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3310220684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3310220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeJBQCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:02:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59355 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeJBQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:02:46 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7Gqu-0005nI-53; Tue, 02 Oct 2018 11:20:24 +0200
Date:   Tue, 2 Oct 2018 11:20:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chen Yu <yu.c.chen@intel.com>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12][v4] Backport several fixes from 64bits to 32bits
 hibernation 
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
Message-ID: <alpine.DEB.2.21.1810021119540.32062@nanos.tec.linutronix.de>
References: <cover.1537448058.git.yu.c.chen@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018, Chen Yu wrote:

> Currently there are mainly three bugs in 32bits system when doing
> hibernation:
> 1. The page copy code is not running in safe page, which might
>    cause hang during resume.
> 2. There's no text mapping for the final jump address
>    of the original kernel, which might cause the system jumping
>    into illegal address and causes system hang during resume.
> 3. The restore kernel switches to its own kernel page table(swapper_pg_dir)
>    rather than the original kernel page table after all the pages
>    been copied back, which might cause invalid virtual-physical
>    mapping issue during resume.
> 
> To solve these problems:
> 
> 1. Copy the code core_restore_code to a safe page, to avoid the instruction
>    code been overwritten when image kernel pages are being copied.
> 2. Set up temporary text mapping for the image kernel's jump address,
>    so that after all the pages have been copied back, the system could
>    jump to this address.
> 3. Switch to the original kernel page table during resume.
> 
> Furthermore, MD5 hash check for e820 map is also backported from 64bits
> system.
> 
> In order to make this patch set more readable, these fixes are splitted
> into several sub patches.
> 
> And use CONFIG_X86_64 to control the common code to be 'activated' for
> 32 bit system during each sub-patch for better maintaining.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

Rafael, it's all yours :)

Thanks,

	tglx
