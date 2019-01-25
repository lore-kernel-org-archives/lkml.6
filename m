Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0774AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43C4217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfAYVfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:35:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:25165 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfAYVfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:35:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 13:35:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,523,1539673200"; 
   d="scan'208";a="109840698"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2019 13:35:02 -0800
Received: from [10.254.80.124] (kliang2-mobl1.ccr.corp.intel.com [10.254.80.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1682A5806CD;
        Fri, 25 Jan 2019 13:35:02 -0800 (PST)
Subject: Re: perf/x86/intel/uncore
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
References: <E44A3BE5-E45A-4D88-818C-02E6E6342060@fb.com>
 <2f74c906-6d13-ff18-f967-100e82343f2f@linux.intel.com>
 <5350E02A-6457-41A8-8F33-AF67BFDAEE3E@fb.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <50e2eb5b-bb83-6219-d2d7-4ec832b9f5d5@linux.intel.com>
Date:   Fri, 25 Jan 2019 16:35:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5350E02A-6457-41A8-8F33-AF67BFDAEE3E@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2019 3:16 PM, Song Liu wrote:
> Thanks Kan!
> 
>> On Jan 25, 2019, at 12:08 PM, Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 1/25/2019 1:54 PM, Song Liu wrote:
>>> Hi,
>>> We are debugging an issue that skx_pci_uncores cannot be registered on
>>> 8-socket system with Xeon Platinum 8176 CPUs. After poking around for a
>>> while, I found it is caused by snbep_pci2phy_map_init() couldn't find
>>> a unbox_dev:
>>>    ubox_dev = pci_get_device(PCI_VENDOR_ID_INTEL, devid, ubox_dev);
>>>    unbox_dev == NULL
>>>    ...
>>> The same kernel (Linus' master) works fine on some single socket SKX
>>> systems.
>>> I am not sure what to check next. And I am not sure whether this is
>>> specific to this system (HPE Superdome Flex).
>>
>> Could you please share the offset 0xC0 and 0xD4 of the PCI configuration space for each device which PCI ID is 0x2014?
>>
>> snbep_pci2phy_map_init() tries to build a mapping from BUS# to Socket ID.
>> CPUNODEID (0xc0) discloses the Node ID of current BUS.
>> GIDNIDMAP (0xd4) discloses the mapping between Socket ID and Node ID.
>>
>> Here is an example from a 4 socket SKX.
>> BUS    CPUNODEID(bit2:0)    GIDNIDMAP
>> 0x0    0x0            0x688
>> 0x40    0x1            0x688
>> 0x80    0x2            0x688
>> 0xC0    0x3            0x688
>>
> 
> Here is the data I get:
> 
> # lspci -xxx | grep "86 80 14 20" -A 15 -B 1 | grep -e "86 80 14 20" -e c0: -e d0: -e Intel
> 0000:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers (rev 04)
> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
> c0: 00 a0 00 00 2f 00 00 80 01 00 02 00 2f 2f 2f 20
> d0: 02 00 00 00 88 d6 b6 00 01 00 00 00 00 00 00 00
> 
> 0001:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers (rev 04)
> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
> c0: 01 80 00 00 1f 00 00 80 01 00 02 00 1f 1f 1f 10
> d0: 02 00 00 00 88 46 92 00 01 00 00 00 00 00 00 00
> 
> 0002:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers (rev 04)
> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
> c0: 02 e0 00 00 8f 00 00 80 01 00 02 00 8f 8f 8f 80
> d0: 02 00 00 00 88 f6 ff 00 01 00 00 00 00 00 00 00
> 
> 0003:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers (rev 04)
> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
> c0: 03 c0 00 00 4f 00 00 80 01 00 02 00 4f 4f 4f 40
> d0: 02 00 00 00 88 66 db 00 01 00 00 00 00 00 00 00
> 
> 0004:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers (rev 04)
> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
> c0: a0 b4 00 00 2f 00 00 80 01 00 02 00 2f 2f 2f 20

The local node ID should be bit2:0. We didn't mask it in our codes.
Does the patch as below work?

diff --git a/arch/x86/events/intel/uncore_snbep.c 
b/arch/x86/events/intel/uncore_snbep.c
index c07bee3..15a8e3c 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1222,6 +1222,8 @@ static struct pci_driver snbep_uncore_pci_driver = {
  	.id_table	= snbep_uncore_pci_ids,
  };

+#define NODE_ID_MASK	0x7
+
  /*
   * build pci bus to socket mapping
   */
@@ -1243,7 +1245,7 @@ static int snbep_pci2phy_map_init(int devid, int 
nodeid_loc, int idmap_loc, bool
  		err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
  		if (err)
  			break;
-		nodeid = config;
+		nodeid = config & NODE_ID_MASK;
  		/* get the Node ID mapping */
  		err = pci_read_config_dword(ubox_dev, idmap_loc, &config);
  		if (err)


Thanks,
Kan

> d0: 02 00 00 00 6d 8b 68 00 01 00 00 00 00 00 00 00
> 
> 0005:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers (rev 04)
> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
> c0: 81 90 00 00 1f 00 00 80 01 00 02 00 1f 1f 1f 10
> d0: 02 00 00 00 24 89 68 00 01 00 00 00 00 00 00 00
> 
> 0006:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers (rev 04)
> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
> c0: e2 fc 00 00 8f 00 00 80 01 00 02 00 8f 8f 8f 80
> d0: 02 00 00 00 ff 8f 68 00 01 00 00 00 00 00 00 00
> 
> 0007:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers (rev 04)
> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
> c0: c3 d8 00 00 4f 00 00 80 01 00 02 00 4f 4f 4f 40
> d0: 02 00 00 00 b6 8d 68 00 01 00 00 00 00 00 00 00
> 
> Song
>>
>>> One thing I noticed is that the PCI configuration space shows
>>> subsystem vendor ID of 0x1590 instead of 0x8086:
>>> 0000:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers (rev 04)
>>> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
>>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 90 15 14 20   << subsystem vendor
>>> 30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
>>> But I don't think that is the problem as the code search with PCI_ANY_ID.
>>>
>>
>> It looks for the device with PCI ID 0x2014.
>>
>>
>> Thanks,
>> Kan
> 
