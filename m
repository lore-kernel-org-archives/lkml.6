Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01819C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 22:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40AD208DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 22:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s/w8dqY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40AD208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeHWBmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 21:42:42 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:38343 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeHWBmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 21:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1534976159; x=1566512159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iVGKb5KkvBln/9eE6ysVruqq4/zJKZoU4PTDRsFSOAk=;
  b=s/w8dqY92qXx6zvR1fnXkF+I55is9Fw+AlDPe8txQEsnObku/BtNipvU
   ehcYLgjJAq/NfJbYHdLfJ3W/pkjWZAU30o7ZEqKbHvF9S8RJ/wLm1nNKb
   JI3ihEcg27zBgX2YrJelHeQa801lTzv664yiaiDma16Rc3C7Rz0GFgjpX
   c=;
X-IronPort-AV: E=Sophos;i="5.53,275,1531785600"; 
   d="scan'208";a="358750444"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Aug 2018 22:15:50 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w7MMCqbY085630
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 22 Aug 2018 22:12:53 GMT
Received: from EX13D07UEA001.ant.amazon.com (10.43.61.44) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 Aug 2018 22:12:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D07UEA001.ant.amazon.com (10.43.61.44) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 Aug 2018 22:12:51 +0000
Received: from localhost (10.55.160.46) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 22 Aug 2018 22:12:51 +0000
Date:   Wed, 22 Aug 2018 15:12:50 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <torvalds@linux-foundation.org>, <luto@kernel.org>,
        <x86@kernel.org>, <bp@alien8.de>, <will.deacon@arm.com>,
        <riel@surriel.com>, <jannh@google.com>, <ascannell@google.com>,
        <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH 4/4] x86/mm: Only use tlb_remove_table() for paravirt
Message-ID: <20180822221250.GB16015@u40b0340c692b58f6553c.ant.amazon.com>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.877071284@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180822154046.877071284@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Peter,

On Wed, Aug 22, 2018 at 05:30:16PM +0200, Peter Zijlstra wrote:
> If we don't use paravirt; don't play unnecessary and complicated games
> to free page-tables.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/Kconfig                      |    2 +-
>  arch/x86/hyperv/mmu.c                 |    2 ++
>  arch/x86/include/asm/paravirt.h       |    5 +++++
>  arch/x86/include/asm/paravirt_types.h |    3 +++
>  arch/x86/include/asm/tlbflush.h       |    3 +++
>  arch/x86/kernel/kvm.c                 |    5 ++++-
>  arch/x86/kernel/paravirt.c            |    2 ++
>  arch/x86/mm/pgtable.c                 |    8 ++++----
>  arch/x86/xen/mmu_pv.c                 |    1 +
>  9 files changed, 25 insertions(+), 6 deletions(-)
> 

<cut>

> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -2397,6 +2397,7 @@ static const struct pv_mmu_ops xen_mmu_o
>  	.flush_tlb_kernel = xen_flush_tlb,
>  	.flush_tlb_one_user = xen_flush_tlb_one_user,
>  	.flush_tlb_others = xen_flush_tlb_others,
> +	.tlb_remove_table = tlb_remove_table,

I tried compiling the series, and I am getting the following compilation error:

  CC      arch/x86/xen/mmu_pv.o
arch/x86/xen/mmu_pv.c:2400:22: error: ‘tlb_remove_table’ undeclared here (not in a function); did you mean ‘bus_remove_file’?
  .tlb_remove_table = tlb_remove_table,
                      ^~~~~~~~~~~~~~~~
                      bus_remove_file
make[4]: *** [arch/x86/xen/mmu_pv.o] Error 1


which I solved by:
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index a21988ec30d3..3114b7c76970 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -67,6 +67,7 @@
 #include <asm/init.h>
 #include <asm/pat.h>
 #include <asm/smp.h>
+#include <asm/tlb.h>
 
 #include <asm/xen/hypercall.h>
 #include <asm/xen/hypervisor.h>


>  
>  	.pgd_alloc = xen_pgd_alloc,
>  	.pgd_free = xen_pgd_free,
> 
> 
> 

-- 
All the best,
Eduardo Valentin
