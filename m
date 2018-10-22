Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60472C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1659320881
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1659320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeJVTIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:08:47 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36392 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728101AbeJVTIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:08:47 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46553001"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Oct 2018 18:50:42 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id C8FBA4B6AE0E;
        Mon, 22 Oct 2018 18:50:39 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 22 Oct 2018 18:50:43 +0800
Date:   Mon, 22 Oct 2018 18:49:45 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v9 8/8] x86/boot/KASLR: Limit kaslr to choosing the
 immovable memory
Message-ID: <20181022104945.GA21886@localhost.localdomain>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
 <20181017102012.872-9-fanc.fnst@cn.fujitsu.com>
 <20181018042123.GD1885@192.168.1.4>
 <20181022101329.GC7641@localhost.localdomain>
 <20181022102455.GN1885@192.168.1.4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181022102455.GN1885@192.168.1.4>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: C8FBA4B6AE0E.ADA57
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 06:24:55PM +0800, Baoquan He wrote:
>On 10/22/18 at 06:13pm, Chao Fan wrote:
>> >> +static bool process_mem_region(struct mem_vector *region,
>> >> +			       unsigned long long minimum,
>> >> +			       unsigned long long image_size)
>> >> +{
>> >> +	int i;
>> >> +	/*
>> >> +	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
>> >> +	 * walk all the regions, so use region directely.
>> >> +	 */
>> >> +	if (num_immovable_mem == 0) {
>> >> +		slots_count(region, minimum, image_size);
>> >> +
>> >> +		if (slot_area_index == MAX_SLOT_AREA) {
>> >> +			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
>> >> +			return 1;
>> >> +		}
>> >> +		return 0;
>> >> +	}
>> >> +
>> >> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> >> +	/*
>> >> +	 * If immovable memory found, filter the intersection between
>> >> +	 * immovable memory and region to slots_count.
>> >> +	 * Otherwise, go on old code.
>> >
>> >Could you explain more about what is the old code in otherwise case you
>> >want to go on?
>> 
>> Sure,
>> 1. 'movable_node' not specified in cmdline.
>> 2. CONFIG_HOT_REMOVE not difned.
>> 3. Just one node in this machine.
>
>So these cases are not covered by 'if (num_immovable_mem == 0)' code?
They are covered by 'if (num_immovable_mem == 0)' code.
>In thise ifdef code block, where do you handle above three cases?
"go on old code." means above:
+ if (num_immovable_mem == 0) {
+         slots_count(region, minimum, image_size);
+
+         if (slot_area_index == MAX_SLOT_AREA) {
+                 debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
+                 return 1;
+         }
+         return 0;
+ }

Thanks,
Chao Fan

>
>Thanks
>Baoquan
>
>


