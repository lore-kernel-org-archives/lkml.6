Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E963C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2476B20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2476B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbeKTN00 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:26:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:56758 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbeKTN00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 08:26:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 18:59:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,255,1539673200"; 
   d="scan'208";a="87741622"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga008.fm.intel.com with ESMTP; 19 Nov 2018 18:59:33 -0800
Received: from orsmsx108.amr.corp.intel.com ([169.254.2.228]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.166]) with mapi id 14.03.0415.000;
 Mon, 19 Nov 2018 18:59:33 -0800
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH] x86/mm: Drop usage of __flush_tlb_all() in
 kernel_physical_mapping_init()
Thread-Topic: [PATCH] x86/mm: Drop usage of __flush_tlb_all() in
 kernel_physical_mapping_init()
Thread-Index: AQHUgF/sHYVfwB8KUk2LbwicCEvrHKVYSK2AgAA2zYA=
Date:   Tue, 20 Nov 2018 02:59:32 +0000
Message-ID: <7b1bbfd295c4709e85ca26457b460fb4d36aa276.camel@intel.com>
References: <154266954452.2939184.974606608701109493.stgit@dwillia2-desk3.amr.corp.intel.com>
         <279dadae-9148-465c-7ec6-3f37e026c6c9@intel.com>
In-Reply-To: <279dadae-9148-465c-7ec6-3f37e026c6c9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.8.242]
Content-Type: text/plain; charset="utf-7"
Content-ID: <EFA97235C897774088F107F4853F5641@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-19 at 15:43 -0800, Dave Hansen wrote:
+AD4- On 11/19/18 3:19 PM, Dan Williams wrote:
+AD4- +AD4- Andy wondered why a path that can sleep was using +AF8AXw-flush+AF8-tlb+AF8-all()
+AD4- +AD4- +AFs-1+AF0-
+AD4- +AD4- and Dave confirmed the expectation for TLB flush is for modifying /
+AD4- +AD4- invalidating existing pte entries, but not initial population +AFs-2+AF0-.
+AD4- 
+AD4- I +AF8-think+AF8- this is OK.
+AD4- 
+AD4- But, could we sprinkle a few WARN+AF8-ON+AF8-ONCE(p+ACoAXw-present()) calls in
+AD4- there
+AD4- to help us sleep at night?

Well, I'm having nightmares now because my naive patch to sprinkle some
WARN+AF8-ON+AF8-ONCE() calls is leading to my VM live locking at boot... no
backtrace. If I revert the patch below and just go with the
+AF8AXw-flush+AF8-tlb+AF8-all() removal it seems fine.

I'm going to set this aside for a bit, but if anyone has any thoughts
in the meantime I'd appreciate it.

---

diff --git a/arch/x86/mm/init+AF8-64.c b/arch/x86/mm/init+AF8-64.c
index de95db8ac52f..ecdf917def4c 100644
--- a/arch/x86/mm/init+AF8-64.c
+-+-+- b/arch/x86/mm/init+AF8-64.c
+AEAAQA- -432,6 +-432,7 +AEAAQA- phys+AF8-pte+AF8-init(pte+AF8-t +ACo-pte+AF8-page, unsigned long paddr, unsigned long paddr+AF8-end,
 					     E820+AF8-TYPE+AF8-RAM) +ACYAJg-
 			    +ACE-e820+AF8AXw-mapped+AF8-any(paddr +ACY- PAGE+AF8-MASK, paddr+AF8-next,
 					     E820+AF8-TYPE+AF8-RESERVED+AF8-KERN))
+-				WARN+AF8-ON+AF8-ONCE(pte+AF8-present(+ACo-pte))+ADs-
 				set+AF8-pte(pte, +AF8AXw-pte(0))+ADs-
 			continue+ADs-
 		+AH0-
+AEAAQA- -452,6 +-453,7 +AEAAQA- phys+AF8-pte+AF8-init(pte+AF8-t +ACo-pte+AF8-page, unsigned long paddr, unsigned long paddr+AF8-end,
 			pr+AF8-info(+ACI-   pte+AD0AJQ-p addr+AD0AJQ-lx pte+AD0AJQ-016lx+AFw-n+ACI-, pte, paddr,
 				pfn+AF8-pte(paddr +AD4APg- PAGE+AF8-SHIFT, PAGE+AF8-KERNEL).pte)+ADs-
 		pages+-+-+ADs-
+-		WARN+AF8-ON+AF8-ONCE(pte+AF8-present(+ACo-pte))+ADs-
 		set+AF8-pte(pte, pfn+AF8-pte(paddr +AD4APg- PAGE+AF8-SHIFT, prot))+ADs-
 		paddr+AF8-last +AD0- (paddr +ACY- PAGE+AF8-MASK) +- PAGE+AF8-SIZE+ADs-
 	+AH0-
+AEAAQA- -487,6 +-489,7 +AEAAQA- phys+AF8-pmd+AF8-init(pmd+AF8-t +ACo-pmd+AF8-page, unsigned long paddr, unsigned long paddr+AF8-end,
 					     E820+AF8-TYPE+AF8-RAM) +ACYAJg-
 			    +ACE-e820+AF8AXw-mapped+AF8-any(paddr +ACY- PMD+AF8-MASK, paddr+AF8-next,
 					     E820+AF8-TYPE+AF8-RESERVED+AF8-KERN))
+-				WARN+AF8-ON+AF8-ONCE(pmd+AF8-present(+ACo-pmd))+ADs-
 				set+AF8-pmd(pmd, +AF8AXw-pmd(0))+ADs-
 			continue+ADs-
 		+AH0-
+AEAAQA- -524,6 +-527,7 +AEAAQA- phys+AF8-pmd+AF8-init(pmd+AF8-t +ACo-pmd+AF8-page, unsigned long paddr, unsigned long paddr+AF8-end,
 		if (page+AF8-size+AF8-mask +ACY- (1+ADwAPA-PG+AF8-LEVEL+AF8-2M)) +AHs-
 			pages+-+-+ADs-
 			spin+AF8-lock(+ACY-init+AF8-mm.page+AF8-table+AF8-lock)+ADs-
+-			WARN+AF8-ON+AF8-ONCE(pmd+AF8-present(+ACo-pmd))+ADs-
 			set+AF8-pte((pte+AF8-t +ACo-)pmd,
 				pfn+AF8-pte((paddr +ACY- PMD+AF8-MASK) +AD4APg- PAGE+AF8-SHIFT,
 					+AF8AXw-pgprot(pgprot+AF8-val(prot) +AHw- +AF8-PAGE+AF8-PSE)))+ADs-
+AEAAQA- -536,6 +-540,7 +AEAAQA- phys+AF8-pmd+AF8-init(pmd+AF8-t +ACo-pmd+AF8-page, unsigned long paddr, unsigned long paddr+AF8-end,
 		paddr+AF8-last +AD0- phys+AF8-pte+AF8-init(pte, paddr, paddr+AF8-end, new+AF8-prot)+ADs-
 
 		spin+AF8-lock(+ACY-init+AF8-mm.page+AF8-table+AF8-lock)+ADs-
+-		WARN+AF8-ON+AF8-ONCE(pmd+AF8-present(+ACo-pmd))+ADs-
 		pmd+AF8-populate+AF8-kernel(+ACY-init+AF8-mm, pmd, pte)+ADs-
 		spin+AF8-unlock(+ACY-init+AF8-mm.page+AF8-table+AF8-lock)+ADs-
 	+AH0-
+AEAAQA- -573,6 +-578,7 +AEAAQA- phys+AF8-pud+AF8-init(pud+AF8-t +ACo-pud+AF8-page, unsigned long paddr, unsigned long paddr+AF8-end,
 					     E820+AF8-TYPE+AF8-RAM) +ACYAJg-
 			    +ACE-e820+AF8AXw-mapped+AF8-any(paddr +ACY- PUD+AF8-MASK, paddr+AF8-next,
 					     E820+AF8-TYPE+AF8-RESERVED+AF8-KERN))
+-				WARN+AF8-ON+AF8-ONCE(pud+AF8-present(+ACo-pud))+ADs-
 				set+AF8-pud(pud, +AF8AXw-pud(0))+ADs-
 			continue+ADs-
 		+AH0-
+AEAAQA- -610,6 +-616,7 +AEAAQA- phys+AF8-pud+AF8-init(pud+AF8-t +ACo-pud+AF8-page, unsigned long paddr, unsigned long paddr+AF8-end,
 		if (page+AF8-size+AF8-mask +ACY- (1+ADwAPA-PG+AF8-LEVEL+AF8-1G)) +AHs-
 			pages+-+-+ADs-
 			spin+AF8-lock(+ACY-init+AF8-mm.page+AF8-table+AF8-lock)+ADs-
+-			WARN+AF8-ON+AF8-ONCE(pud+AF8-present(+ACo-pud))+ADs-
 			set+AF8-pte((pte+AF8-t +ACo-)pud,
 				pfn+AF8-pte((paddr +ACY- PUD+AF8-MASK) +AD4APg- PAGE+AF8-SHIFT,
 					PAGE+AF8-KERNEL+AF8-LARGE))+ADs-
+AEAAQA- -623,6 +-630,7 +AEAAQA- phys+AF8-pud+AF8-init(pud+AF8-t +ACo-pud+AF8-page, unsigned long paddr, unsigned long paddr+AF8-end,
 					   page+AF8-size+AF8-mask, prot)+ADs-
 
 		spin+AF8-lock(+ACY-init+AF8-mm.page+AF8-table+AF8-lock)+ADs-
+-		WARN+AF8-ON+AF8-ONCE(pud+AF8-present(+ACo-pud))+ADs-
 		pud+AF8-populate(+ACY-init+AF8-mm, pud, pmd)+ADs-
 		spin+AF8-unlock(+ACY-init+AF8-mm.page+AF8-table+AF8-lock)+ADs-
 	+AH0-
+AEAAQA- -657,6 +-665,7 +AEAAQA- phys+AF8-p4d+AF8-init(p4d+AF8-t +ACo-p4d+AF8-page, unsigned long paddr, unsigned long paddr+AF8-end,
 					     E820+AF8-TYPE+AF8-RAM) +ACYAJg-
 			    +ACE-e820+AF8AXw-mapped+AF8-any(paddr +ACY- P4D+AF8-MASK, paddr+AF8-next,
 					     E820+AF8-TYPE+AF8-RESERVED+AF8-KERN))
+-				WARN+AF8-ON+AF8-ONCE(p4d+AF8-present(+ACo-p4d))+ADs-
 				set+AF8-p4d(p4d, +AF8AXw-p4d(0))+ADs-
 			continue+ADs-
 		+AH0-
+AEAAQA- -674,6 +-683,7 +AEAAQA- phys+AF8-p4d+AF8-init(p4d+AF8-t +ACo-p4d+AF8-page, unsigned long paddr, unsigned long paddr+AF8-end,
 					   page+AF8-size+AF8-mask)+ADs-
 
 		spin+AF8-lock(+ACY-init+AF8-mm.page+AF8-table+AF8-lock)+ADs-
+-		WARN+AF8-ON+AF8-ONCE(p4d+AF8-present(+ACo-p4d))+ADs-
 		p4d+AF8-populate(+ACY-init+AF8-mm, p4d, pud)+ADs-
 		spin+AF8-unlock(+ACY-init+AF8-mm.page+AF8-table+AF8-lock)+ADs-
 	+AH0-
