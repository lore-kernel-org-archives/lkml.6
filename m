Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF26C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C7F2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C7F2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756839AbeFPIEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 04:04:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36181 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754036AbeFPIEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 04:04:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id v131-v6so7394961wma.1;
        Sat, 16 Jun 2018 01:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cZQqNQFRx8zRyEWS6IG7xxjG1Rxxm3t/wC7ySITCQ+k=;
        b=fdePybb2Oc4lgFJtob6Yr0sjJGXphamakGzLoVpcmT1BD+Rtc0EgXoc0X5NpJy7GyS
         C1BAF0UKHbAw+wDuamhM6Y0AuAex0kJSKYhMRXLTrsPNvNwINpTrYI5QtGSNHzwC11HF
         aMPrdNfR54ftBSYBMwd2vOsGb2BSTrwmO9BmAdCBYEDzfJi2YXxIwScQwWPSH5AtzhC9
         mth3UafyP+ybosaOIhJV5wZ6fIyrEljkSM42BCqWpHpwUdtySUS9CVyrdY0xMk+03o5W
         HPPScJ0yct5ydEEWljqLF/PasgU+0J/Y2JvFmwVRMNTeD61YnTN+fwReom6idu50k9vD
         NQhw==
X-Gm-Message-State: APt69E1PWPP0TJ6VLjlhLhlufQVZVUvWAwym24hZoZy09tsHyitgAmU2
        khd5T/y8S/L2txtAhQU0ntE=
X-Google-Smtp-Source: ADUXVKJNMMZDqg8ZtkCik1Vlfef4LiQD0Ijx4TGn0Ba+us4/WpFQmjKCvuFixCuA7rCV/2lPuKuuUw==
X-Received: by 2002:a1c:8206:: with SMTP id e6-v6mr3473475wmd.24.1529136262931;
        Sat, 16 Jun 2018 01:04:22 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::70f? ([2a01:4240:2e27:ad85:aaaa::70f])
        by smtp.gmail.com with ESMTPSA id 82-v6sm3710664wmm.39.2018.06.16.01.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 01:04:22 -0700 (PDT)
Subject: Re: [PATCH v1] mm: relax deferred struct page requirements
To:     Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        benh@kernel.crashing.org, paulus@samba.org,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        arbab@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, mgorman@techsingularity.net
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
 <20171121072416.v77vu4osm2s4o5sq@dhcp22.suse.cz>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b16029f0-ada0-df25-071b-cd5dba0ab756@suse.cz>
Date:   Sat, 16 Jun 2018 10:04:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20171121072416.v77vu4osm2s4o5sq@dhcp22.suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/2017, 08:24 AM, Michal Hocko wrote:
> On Thu 16-11-17 20:46:01, Pavel Tatashin wrote:
>> There is no need to have ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT,
>> as all the page initialization code is in common code.
>>
>> Also, there is no need to depend on MEMORY_HOTPLUG, as initialization code
>> does not really use hotplug memory functionality. So, we can remove this
>> requirement as well.
>>
>> This patch allows to use deferred struct page initialization on all
>> platforms with memblock allocator.
>>
>> Tested on x86, arm64, and sparc. Also, verified that code compiles on
>> PPC with CONFIG_MEMORY_HOTPLUG disabled.
> 
> There is slight risk that we will encounter corner cases on some
> architectures with weird memory layout/topology

Which x86_32-pae seems to be. Many bad page state errors are emitted
during boot when this patch is applied:
BUG: Bad page state in process swapper  pfn:3c01c
page:f566c3f0 count:0 mapcount:1 mapping:00000000 index:0x0
flags: 0x0()
raw: 00000000 00000000 00000000 00000000 00000000 00000100 00000200 00000000
raw: 00000000
page dumped because: nonzero mapcount
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Tainted: G    B
4.17.1-4.gdf028bb-pae #1 openSUSE Tumbleweed (unreleased)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.0.0-prebuilt.qemu-project.org 04/01/2014
Call Trace:
 dump_stack+0x7d/0xbd
 bad_page.cold.111+0x90/0xc7
 free_pages_check_bad+0x52/0x70
 free_pcppages_bulk+0x37d/0x570
 free_unref_page_commit+0x9a/0xc0
 free_unref_page+0x6a/0xa0
 __free_pages+0x17/0x30
 free_highmem_page+0x1e/0x50
 add_highpages_with_active_regions+0xd6/0x113
 set_highmem_pages_init+0x67/0x7d
 mem_init+0x23/0x1d9
 start_kernel+0x1c2/0x437
 i386_start_kernel+0x98/0x9c
 startup_32_smp+0x164/0x168

free_pages_check_bad expects mapcount == -1, but it is 1 with this patch.

Reverting the patch makes the BUGs go away -- the config diff is then:
@@ -617,7 +617,7 @@
 # CONFIG_PGTABLE_MAPPING is not set
 # CONFIG_ZSMALLOC_STAT is not set
 CONFIG_GENERIC_EARLY_IOREMAP=y
-CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
+CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
 # CONFIG_IDLE_PAGE_TRACKING is not set
 CONFIG_FRAME_VECTOR=y
 # CONFIG_PERCPU_STATS is not set

>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -148,7 +148,6 @@ config PPC
>>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>>  	select ARCH_MIGHT_HAVE_PC_SERIO
>>  	select ARCH_SUPPORTS_ATOMIC_RMW
>> -	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
>>  	select ARCH_USE_BUILTIN_BSWAP
>>  	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
>>  	select ARCH_WANT_IPC_PARSE_VERSION
>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> index 863a62a6de3c..525c2e3df6f5 100644
>> --- a/arch/s390/Kconfig
>> +++ b/arch/s390/Kconfig
>> @@ -108,7 +108,6 @@ config S390
>>  	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
>>  	select ARCH_SAVE_PAGE_KEYS if HIBERNATION
>>  	select ARCH_SUPPORTS_ATOMIC_RMW
>> -	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
>>  	select ARCH_SUPPORTS_NUMA_BALANCING
>>  	select ARCH_USE_BUILTIN_BSWAP
>>  	select ARCH_USE_CMPXCHG_LOCKREF
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index df3276d6bfe3..00a5446de394 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -69,7 +69,6 @@ config X86
>>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>>  	select ARCH_MIGHT_HAVE_PC_SERIO
>>  	select ARCH_SUPPORTS_ATOMIC_RMW
>> -	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
>>  	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
>>  	select ARCH_USE_BUILTIN_BSWAP
>>  	select ARCH_USE_QUEUED_RWLOCKS
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 9c4bdddd80c2..c6bd0309ce7a 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -639,15 +639,10 @@ config MAX_STACK_SIZE_MB
>>  
>>  	  A sane initial value is 80 MB.
>>  
>> -# For architectures that support deferred memory initialisation
>> -config ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
>> -	bool
>> -
>>  config DEFERRED_STRUCT_PAGE_INIT
>>  	bool "Defer initialisation of struct pages to kthreads"
>>  	default n
>> -	depends on ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
>> -	depends on NO_BOOTMEM && MEMORY_HOTPLUG
>> +	depends on NO_BOOTMEM
>>  	depends on !FLATMEM
>>  	help
>>  	  Ordinarily all struct pages are initialised during early boot in a

thanks,
-- 
js
suse labs
