Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A30C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C9520827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C9520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbeJ2TAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:00:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729487AbeJ2TAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:00:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56EF53003064;
        Mon, 29 Oct 2018 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FD3F620C0;
        Mon, 29 Oct 2018 10:12:23 +0000 (UTC)
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.cz>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, mingo@redhat.com, tglx@linutronix.de,
        dyoung@redhat.com
References: <20181027091007.GB1046@nazgul.tnic>
 <20181027093917.GA14493@MiWiFi-R3L-srv> <20181027101221.GC1046@nazgul.tnic>
 <20181027110858.GB14493@MiWiFi-R3L-srv>
 <C5F8ED8E-F361-4C6C-B9E2-E3C8BCD8E050@alien8.de>
 <c55bef2a-b972-7e6e-b698-6ac1bc736046@redhat.com>
 <20181027145151.GA7338@nazgul.tnic>
 <390b16ba-05d7-3590-c3b2-4b69aa3ae051@redhat.com>
 <20181029083118.GC1884@MiWiFi-R3L-srv>
 <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
 <20181029095738.GB20101@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
Date:   Mon, 29 Oct 2018 18:12:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181029095738.GB20101@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 29 Oct 2018 10:12:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年10月29日 17:57, Borislav Petkov 写道:
> On Mon, Oct 29, 2018 at 05:29:16PM +0800, lijiang wrote:
>> Ok, i will change it to a local variable and export it.
> 
> Why do you have to export it at all?!
> 

I mean that i will write the value of local variable to the vmcoreinfo. For example:

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4c8acdfdc5a7..3cc975e7ff8f 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -352,11 +352,16 @@ void machine_kexec(struct kimage *image)

 void arch_crash_save_vmcoreinfo(void)
 {
+       u64 sme_mask = 0;
+
        VMCOREINFO_NUMBER(phys_base);
        VMCOREINFO_SYMBOL(init_top_pgt);
        vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
                        pgtable_l5_enabled());

+       sme_mask = sme_me_mask;
+       VMCOREINFO_NUMBER(sme_mask);
+
 #ifdef CONFIG_NUMA
        VMCOREINFO_SYMBOL(node_data);
        VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
-- 


Because the crash kernel's page table(pgd/pud/pmd/pte) contains
the memory encryption mask(bit 47), makedumpfile needs to remove
the sme mask to obtain the true physical address.


Thanks.
Lianbo

