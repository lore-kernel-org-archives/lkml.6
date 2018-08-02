Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1121C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84035208D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84035208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeHBHgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 03:36:07 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33941 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbeHBHgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 03:36:07 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42971092"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Aug 2018 13:46:31 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 617754B66A09;
        Thu,  2 Aug 2018 13:46:31 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Thu, 2 Aug 2018 13:46:33 +0800
Subject: Re: [PATCH v4 4/4] x86/boot/KASLR: Limit kaslr to choosing the
 immovable memory
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
References: <20180723092908.32656-1-fanc.fnst@cn.fujitsu.com>
 <20180723092908.32656-5-fanc.fnst@cn.fujitsu.com>
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <961acf17-c76f-1c51-f7e6-a7854a487a09@cn.fujitsu.com>
Date:   Thu, 2 Aug 2018 13:46:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180723092908.32656-5-fanc.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 617754B66A09.A975E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fan,

At 07/23/2018 05:29 PM, Chao Fan wrote:
> If 'CONFIG_MEMORY_HOTREMOVE' specified and the account of immovable
> memory regions is not zero. Calculate the intersection between memory
> regions from e820/efi memory table and immovable memory regions.
> Or go on the old code.
> 
> Rename process_mem_region to slots_count to match slots_fetch_random,
> and name new function as process_mem_region.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>   arch/x86/boot/compressed/kaslr.c | 66 ++++++++++++++++++++++++++------
>   1 file changed, 55 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 4705682caf1f..10bda3a1fcaa 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -631,9 +631,9 @@ static unsigned long slots_fetch_random(void)
>   	return 0;
>   }
>   
> -static void process_mem_region(struct mem_vector *entry,
> -			       unsigned long minimum,
> -			       unsigned long image_size)
> +static void slots_count(struct mem_vector *entry,
                ^^^^^^^^^^^
                           is not suitable.
IMO, how about process_mem_slots() or you may have a better name, it's
up to you.

> +			unsigned long minimum,
> +			unsigned long image_size)
>   {
>   	struct mem_vector region, overlap;
>   	struct slot_area slot_area;

slot_area is also unused.

Thanks,
	dou



