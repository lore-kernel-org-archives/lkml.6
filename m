Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E577C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1E3208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1E3208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeH0Gny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:43:54 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:53927 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbeH0Gnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:43:53 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="43989417"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Aug 2018 10:59:14 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 045184B6AE13;
        Mon, 27 Aug 2018 10:59:10 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 27 Aug 2018 10:59:12 +0800
Date:   Mon, 27 Aug 2018 10:56:12 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <n-horiguchi@ah.jp.nec.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v5 3/4] x86/boot/KASLR: Walk srat tables to filter
 immovable memory
Message-ID: <20180827025611.GC6769@localhost.localdomain>
References: <20180807065000.30958-1-fanc.fnst@cn.fujitsu.com>
 <20180807065000.30958-4-fanc.fnst@cn.fujitsu.com>
 <20180827021349.GR29313@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180827021349.GR29313@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 045184B6AE13.A9DF6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:13:49AM +0800, Baoquan He wrote:
>On 08/07/18 at 02:49pm, Chao Fan wrote:
>> If 'CONFIG_MEMORY_HOTREMOVE' specified, walk the acpi srat memory
>> tables, store the immovable memory regions, so that kaslr can get
>> the information abouth where can be selected or not.
>> If 'CONFIG_MEMORY_HOTREMOVE' not specified, go on the old code.
>Just adjust the patch log a little bit, just for your reference.
>
>If 'CONFIG_MEMORY_HOTREMOVE' specified, walk through the acpi srat memory
>tables and store those immovable memory regions so that kaslr can get
>where to choose for randomization.

OK, I will change more patch log in next version.

>
>> 

[...]

>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +/*
>> + * According to ACPI table, filter the immvoable memory regions
>> + * and store them in immovable_mem[].
>> + */
>> +static void handle_immovable_mem(void)
>
>Can we change this function like below, passed in the immovable_mem and
>the array lengty, the value of num_immovable_mem will be passed back?
>
>static void handle_immovable_mem(char* region, int max, int *num)
>{
>}
>
>Like this, you don't need patch 1/4 to make a header file, just put this
>function handle_immovable_mem() into acpitb.c since it's handling acpi
>tables. And its name can be get_immovable_mem().

That makes sense.
But if we change like this, we can put the whole function to acpitb.c.
It will be like:
static void handle_immovable_mem(int *num)
{
}
Because the value of immovable_mem is filled in handle_immovable_mem,
it's better to put immovable_mem in acpitb.c also, then extern in
kaslr.c.

Thanks,
Chao Fan


