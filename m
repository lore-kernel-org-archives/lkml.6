Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6821C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACA82082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vqh8lMuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACA82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeLAVlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:41:09 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47564 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeLAVlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zFTcUVo6z3KD5U7gQQLOU1pgneU6Vm06NCHu7XIuaig=; b=vqh8lMuveo7/lMvNoEG6435U9
        hMJlZ3fq2Lry2CUWJkhiHSnX8mMsJMqQpnN72OAd68WX7eFW6zCmSWg+2OvnZofsOWAHg45LhxsIA
        UolV18ZPsFz+uKxieESxmnU32R50LREEJkQ8lrNDE1kQmYS4/78eE/L+erAquaqEbaEtmO73o3FN0
        t4+0PTNu0SdbTCeHNnaglJazyPpkxXbijvCylicfcJYqByb0hmiiMQPRIhwpG//w3aw4CD1TAiBZ8
        /XIAQePrHcdnlrQ9vLZiuF1XkAYFrgAS0csOP2if2zeXk/7VMiyvNQ6Fo36nhKaXKlq+5AINk9d/H
        PtX1L6Fwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gT2Vx-000243-Ob; Sat, 01 Dec 2018 10:28:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90AA42029FD58; Sat,  1 Dec 2018 11:28:43 +0100 (CET)
Date:   Sat, 1 Dec 2018 11:28:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] x86/mm: Drop usage of __flush_tlb_all() in
 kernel_physical_mapping_init()
Message-ID: <20181201102843.GF11614@hirez.programming.kicks-ass.net>
References: <154362450646.2367148.16448130381211111341.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154362450646.2367148.16448130381211111341.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 04:35:06PM -0800, Dan Williams wrote:
> 
> Dan Williams (5):
>       generic/pgtable: Make {pmd,pud}_same() unconditionally available
>       generic/pgtable: Introduce {p4d,pgd}_same()
>       generic/pgtable: Introduce set_pte_safe()
>       x86/mm: Validate kernel_physical_mapping_init() pte population
>       x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_init()
> 

Since you failed to send me 1,2, only for 3-5:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

although going by the subjects, the earlier two patches should be fine
too.
