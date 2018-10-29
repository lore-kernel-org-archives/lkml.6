Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DAAC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB6620827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB6620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeJ2SRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:17:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbeJ2SRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:17:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECC233082211;
        Mon, 29 Oct 2018 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A31695D75E;
        Mon, 29 Oct 2018 09:29:20 +0000 (UTC)
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Petr Tesarik <ptesarik@suse.cz>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, mingo@redhat.com, tglx@linutronix.de,
        dyoung@redhat.com
References: <20181026222517.GB26927@nazgul.tnic>
 <20181027081343.GA1884@MiWiFi-R3L-srv> <20181027091007.GB1046@nazgul.tnic>
 <20181027093917.GA14493@MiWiFi-R3L-srv> <20181027101221.GC1046@nazgul.tnic>
 <20181027110858.GB14493@MiWiFi-R3L-srv>
 <C5F8ED8E-F361-4C6C-B9E2-E3C8BCD8E050@alien8.de>
 <c55bef2a-b972-7e6e-b698-6ac1bc736046@redhat.com>
 <20181027145151.GA7338@nazgul.tnic>
 <390b16ba-05d7-3590-c3b2-4b69aa3ae051@redhat.com>
 <20181029083118.GC1884@MiWiFi-R3L-srv>
From:   lijiang <lijiang@redhat.com>
Message-ID: <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
Date:   Mon, 29 Oct 2018 17:29:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181029083118.GC1884@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 29 Oct 2018 09:29:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年10月29日 16:31, Baoquan He 写道:
> On 10/29/18 at 03:59pm, lijiang wrote:
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index 4c8acdfdc5a7..de363796ed20 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -29,6 +29,9 @@
>>  #include <asm/setup.h>
>>  #include <asm/set_memory.h>
>>
>> +u64 sme_mask;
>> +EXPORT_SYMBOL(sme_mask);
> 
> Wondering why it is global. Who else will use it?
> 
In general, no need to export the symbol of local variable.

Ok, i will change it to a local variable and export it.

Thanks.
Lianbo

>> +
>>  #ifdef CONFIG_KEXEC_FILE
>>  const struct kexec_file_ops * const kexec_file_loaders[] = {
>>                 &kexec_bzImage64_ops,
>> @@ -357,6 +360,9 @@ void arch_crash_save_vmcoreinfo(void)
>>         vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>>                         pgtable_l5_enabled());
>>
>> +       sme_mask = sme_me_mask;
>> +       VMCOREINFO_NUMBER(sme_mask);
>> +
>>  #ifdef CONFIG_NUMA
>>         VMCOREINFO_SYMBOL(node_data);
>>         VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
