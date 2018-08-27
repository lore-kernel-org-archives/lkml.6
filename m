Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62988C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E7B20891
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E7B20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeH0KTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:19:52 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15330 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726831AbeH0KTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:19:51 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="43997661"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Aug 2018 14:34:33 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 5C8A04B6AE16;
        Mon, 27 Aug 2018 14:34:33 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 27 Aug 2018 14:34:36 +0800
Date:   Mon, 27 Aug 2018 14:31:35 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <n-horiguchi@ah.jp.nec.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v5 4/4] x86/boot/KASLR: Limit kaslr to choosing the
 immovable memory
Message-ID: <20180827063135.GE6769@localhost.localdomain>
References: <20180807065000.30958-1-fanc.fnst@cn.fujitsu.com>
 <20180807065000.30958-5-fanc.fnst@cn.fujitsu.com>
 <20180827055607.GB1748@MiWiFi-R3L-srv>
 <20180827062854.GD6769@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180827062854.GD6769@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 5C8A04B6AE16.AC399
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 02:28:54PM +0800, Chao Fan wrote:
>On Mon, Aug 27, 2018 at 01:56:07PM +0800, Baoquan He wrote:
>>On 08/07/18 at 02:50pm, Chao Fan wrote:
[...]
>>
>>Is it possible to take num_immovable_mem definition out from #ifdef
>>CONFIG_MEMORY_HOTREMOVE block and check it here like below? This way,
>>one level of indentation can be reduced in the for loop, and code is
>>more readable.
>>
>
>I think there is a mistake.
>
>The logical is:
>if (#ifdef CONFIG_MEMORY_HOTREMOVE) && (num_immovable_mem > 0)
>	then A;
>else
>	then B;
>
>But below is:

Sorry for that, here the 'below' means the code in your mail.

Thanks,
Chao Fan

>if (num_immovable_mem > 0)
>	then B;
>else if (#ifdef CONFIG_MEMORY_HOTREMOVE)
>	then A;
>else
>	nothing;
>
>The precondition of the loop is (num_immovable_mem > 0), because
>there is only one condition that we need go the A code:
>CONFIG_MEMORY_HOTREMOVE is defined, and memory information in srat
>found.
>
>But there is many conditions we go the B code:
>1. CONFIG_MEMORY_HOTREMOVE is not defined.
>2. CONFIG_MEMORY_HOTREMOVE defined, but we didn't get the right acpi tables
>3. CONFIG_MEMORY_HOTREMOVE defined, or there is only one node in this machine.
>
>Yes, the code is hard to read, but you have changed the logical, there
>is a compromise method, I don't know whether is better:
>
>#ifdef CONFIG_MEMORY_HOTREMOVE
>	if (num_immovable_mem == 0)
>		goto B;
>
>	for (i = 0; i < num_immovable_mem; i++) {
>		...
>	}
>#endif
>
>B:
>	slots_count(region, minimum, image_size);
>	
>	if (slot_area_index == MAX_SLOT_AREA) {
>		debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
>		return 1;
>	}
>	return 0;
>	
>
>>
>>static bool process_mem_region(struct mem_vector *region,
>>			       unsigned long long minimum,
>>			       unsigned long long image_size)
>>{
>>
>>	/*
>>	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
>>	 * walk all the regions, so use region directely.
>>	 */
>>	if (num_immovable_mem > 0) {
>>		slots_count(region, minimum, image_size);
>>		
>>		if (slot_area_index == MAX_SLOT_AREA) {
>>			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
>>			return 1;
>>		}
>>		return 0;
>>	}
>>
>>#ifdef CONFIG_MEMORY_HOTREMOVE
>>	for (i = 0; i < num_immovable_mem; i++) {
>>		...
>>	}
>>#endif
>>}
>>


