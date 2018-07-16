Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2524ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFF5208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFF5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeGPQ7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:59:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:21528 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbeGPQ7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:59:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 09:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,361,1526367600"; 
   d="scan'208";a="72781141"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2018 09:31:38 -0700
Received: from [10.252.208.117] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9B5BE580213;
        Mon, 16 Jul 2018 09:31:37 -0700 (PDT)
Subject: Re: [PATCH] [RESEND] perf/x86/intel/uncore: Fix the index of PCU.3
 Broadwell CPUs
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>, mingo@kernel.org,
        kan.liang@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        m.mizuma@jp.fujitsu.com
References: <20180710233158.21037-1-msys.mizuma@gmail.com>
 <20180715223444.GA16209@gmail.com>
 <7d97606b-67b6-4eb7-48ca-99250edc3fba@linux.intel.com>
 <376d5419-9ba5-ef5e-3089-f841fbb1772b@gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <55fd243f-7c3c-1a02-65d4-3fae3c540d50@linux.intel.com>
Date:   Mon, 16 Jul 2018 12:31:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <376d5419-9ba5-ef5e-3089-f841fbb1772b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/2018 11:07 AM, Masayoshi Mizuma wrote:
> 
> 
> On 07/16/2018 10:29 AM, Liang, Kan wrote:
>>
>>
>> On 7/15/2018 6:34 PM, Ingo Molnar wrote:
>>>
>>> * Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>>>
>>>> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>>>
>>>> commit 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
>>>> Broadwell CPUs") introduced PCU.3 for Broadwell CPU. Unfortunately,
>>>> the driver_data of PCU.3 conflicts to QPI Port 2 filter.
>>>>
>>>>       { /* QPI Port 2 filter  */
>>>>               PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
>>>>               .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),
>>>>
>>>>       { /* PCU.3 (for Capability registers) */
>>>>               PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
>>>>               .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
>>>>                                                  HSWEP_PCI_PCU_3),
>>>>                                // HSWEP_PCI_PCU_3 == 2
>>>
>>>> --- a/arch/x86/events/intel/uncore_snbep.c
>>>> +++ b/arch/x86/events/intel/uncore_snbep.c
>>>> @@ -1030,6 +1030,7 @@ enum {
>>>>        SNBEP_PCI_QPI_PORT0_FILTER,
>>>>        SNBEP_PCI_QPI_PORT1_FILTER,
>>>>        HSWEP_PCI_PCU_3,
>>>> +    BDX_PCI_PCU_3,
>>>>    };
>>>
>>> So we use a magic '2' enumerator in the 'QPI Port 2 filter', and that overlaps
>>> with HSWEP_PCI_PCU_3, right?
>>>
>>> Shouldn't we clean up all the enumerators and not use magic numbers, and this fix
>>> the conflict?
>>>
>>
>> Yes, it should fix the conflict. I will clean up the code.
> 
> Thanks a lot!
> I would appreciate if you could add CC to me when you post the patch.
> 

Here is the patch.

Masa, could you please give it a try?

Thanks,
Kan

 From 688378a4003ec33156958a52dc822105c18075af Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Mon, 16 Jul 2018 04:57:51 -0400
Subject: [PATCH] perf/x86/intel/uncore: Fix hardcode index of Broadwell 
extra PCI DEV

Masa reports that a warning message is shown while CPU hot-removing on
Broadwell server.

   WARNING: CPU: 126 PID: 6 at arch/x86/events/intel/uncore.c:988
   uncore_pci_remove+0x10b/0x150
   Call Trace:
    pci_device_remove+0x42/0xd0
    device_release_driver_internal+0x148/0x220
    pci_stop_bus_device+0x76/0xa0
    pci_stop_root_bus+0x44/0x60
    acpi_pci_root_remove+0x1f/0x80
    acpi_bus_trim+0x57/0x90
    acpi_bus_trim+0x2e/0x90
    acpi_device_hotplug+0x2bc/0x4b0
    acpi_hotplug_work_fn+0x1a/0x30
    process_one_work+0x174/0x3a0
    worker_thread+0x4c/0x3d0
    kthread+0xf8/0x130

This bug was introduced in:

   commit 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
Broadwell CPUs")

The index of "QPI Port 2 filter" was hardcode to 2. The index of
"PCU.3" used enumerator "HSWEP_PCI_PCU_3", which equals to 2 as well.

To fix the conflict, the hardcode index needs to be cleaned up.
Introduce a new enumerator "BDX_PCI_QPI_PORT2_FILTER" for "QPI Port 2
filter" on Broadwell, and increase the UNCORE_EXTRA_PCI_DEV_MAX.
Clean up hardcode index.

Reported-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Fixes: 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
Broadwell CPUs")
---
  arch/x86/events/intel/uncore.h       |  2 +-
  arch/x86/events/intel/uncore_snbep.c | 10 +++++++---
  2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index c9e1e0b..e17ab88 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -28,7 +28,7 @@
  #define UNCORE_PCI_DEV_TYPE(data)	((data >> 8) & 0xff)
  #define UNCORE_PCI_DEV_IDX(data)	(data & 0xff)
  #define UNCORE_EXTRA_PCI_DEV		0xff
-#define UNCORE_EXTRA_PCI_DEV_MAX	3
+#define UNCORE_EXTRA_PCI_DEV_MAX	4

  #define UNCORE_EVENT_CONSTRAINT(c, n) EVENT_CONSTRAINT(c, n, 0xff)

diff --git a/arch/x86/events/intel/uncore_snbep.c 
b/arch/x86/events/intel/uncore_snbep.c
index 87dc026..51d7c11 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1029,6 +1029,7 @@ void snbep_uncore_cpu_init(void)
  enum {
  	SNBEP_PCI_QPI_PORT0_FILTER,
  	SNBEP_PCI_QPI_PORT1_FILTER,
+	BDX_PCI_QPI_PORT2_FILTER,
  	HSWEP_PCI_PCU_3,
  };

@@ -3286,15 +3287,18 @@ static const struct pci_device_id 
bdx_uncore_pci_ids[] = {
  	},
  	{ /* QPI Port 0 filter  */
  		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f86),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 0),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   SNBEP_PCI_QPI_PORT0_FILTER),
  	},
  	{ /* QPI Port 1 filter  */
  		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f96),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 1),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   SNBEP_PCI_QPI_PORT1_FILTER),
  	},
  	{ /* QPI Port 2 filter  */
  		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   BDX_PCI_QPI_PORT2_FILTER),
  	},
  	{ /* PCU.3 (for Capability registers) */
  		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
-- 
2.4.11


