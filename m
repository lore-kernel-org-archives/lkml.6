Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFD8C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B43E21B31
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B43E21B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeHJLD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:03:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:59962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbeHJLD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:03:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3112AD1B;
        Fri, 10 Aug 2018 08:35:05 +0000 (UTC)
Date:   Fri, 10 Aug 2018 10:35:04 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: a13c600e15 ("x86/mm/pti: Move user W+X check into .."): WARNING:
 CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:283 note_page
Message-ID: <20180810083504.55pljlr733lctz5k@suse.de>
References: <5b6cc146.lVmfvLKHKgZxC5d8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b6cc146.lVmfvLKHKgZxC5d8%lkp@intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 06:33:42AM +0800, kernel test robot wrote:
> commit a13c600e15de44ccf03df28d3311ef3cb754ed9b
> Author:     Joerg Roedel <jroedel@suse.de>
> AuthorDate: Wed Aug 8 13:16:40 2018 +0200
> Commit:     Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Thu Aug 9 20:42:07 2018 +0200
> 
>     x86/mm/pti: Move user W+X check into pti_finalize()

Okay, I found the problem and the diff below fixes it.

Ingo, Thomas, can you fold that diff into above commit or do you prefer
a separate patch?

Thanks and sorry for the hassle,


       Joerg

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 026a89aa16d7..d1435c78ae4f 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -629,5 +629,6 @@ void pti_finalize(void)
 	pti_clone_entry_text();
 	pti_clone_kernel_text();
 
-	debug_checkwx_user();
+	if (__supported_pte_mask & _PAGE_NX)
+		debug_checkwx_user();
 }
