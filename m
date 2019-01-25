Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5613C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09612133F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfAYUI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:08:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:50936 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfAYUI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:08:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 12:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,522,1539673200"; 
   d="scan'208";a="133140165"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2019 12:08:27 -0800
Received: from [10.254.80.124] (kliang2-mobl1.ccr.corp.intel.com [10.254.80.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BCE545806CD;
        Fri, 25 Jan 2019 12:08:26 -0800 (PST)
Subject: Re: perf/x86/intel/uncore
To:     Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <E44A3BE5-E45A-4D88-818C-02E6E6342060@fb.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <2f74c906-6d13-ff18-f967-100e82343f2f@linux.intel.com>
Date:   Fri, 25 Jan 2019 15:08:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <E44A3BE5-E45A-4D88-818C-02E6E6342060@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2019 1:54 PM, Song Liu wrote:
> Hi,
> 
> We are debugging an issue that skx_pci_uncores cannot be registered on
> 8-socket system with Xeon Platinum 8176 CPUs. After poking around for a
> while, I found it is caused by snbep_pci2phy_map_init() couldn't find
> a unbox_dev:
> 
>    ubox_dev = pci_get_device(PCI_VENDOR_ID_INTEL, devid, ubox_dev);
>    unbox_dev == NULL
>    ...
> 
> The same kernel (Linus' master) works fine on some single socket SKX
> systems.
> 
> I am not sure what to check next. And I am not sure whether this is
> specific to this system (HPE Superdome Flex).

Could you please share the offset 0xC0 and 0xD4 of the PCI configuration 
space for each device which PCI ID is 0x2014?

snbep_pci2phy_map_init() tries to build a mapping from BUS# to Socket ID.
CPUNODEID (0xc0) discloses the Node ID of current BUS.
GIDNIDMAP (0xd4) discloses the mapping between Socket ID and Node ID.

Here is an example from a 4 socket SKX.
BUS    CPUNODEID(bit2:0)    GIDNIDMAP
0x0    0x0            0x688
0x40    0x1            0x688
0x80    0x2            0x688
0xC0    0x3            0x688


> 
> One thing I noticed is that the PCI configuration space shows
> subsystem vendor ID of 0x1590 instead of 0x8086:
> 
> 0000:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers (rev 04)
> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 90 15 14 20   << subsystem vendor
> 
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
> 
> But I don't think that is the problem as the code search with PCI_ANY_ID.
>

It looks for the device with PCI ID 0x2014.


Thanks,
Kan
