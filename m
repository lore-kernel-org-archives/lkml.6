Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A37AECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E6B214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E6B214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbeISIEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:04:23 -0400
Received: from mail5.windriver.com ([192.103.53.11]:51382 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730651AbeISIEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:04:22 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8J2RLKp025194
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 18 Sep 2018 19:27:48 -0700
Received: from [128.224.162.216] (128.224.162.216) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 18 Sep
 2018 19:27:30 -0700
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len to
 command line
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
 <20180919015030.GA423@jagdpanzerIV>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
Date:   Wed, 19 Sep 2018 10:27:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919015030.GA423@jagdpanzerIV>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.216]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月19日 09:50, Sergey Senozhatsky wrote:
> On (09/19/18 01:17), zhe.he@windriver.com wrote:
>> @@ -1048,7 +1048,14 @@ static void __init log_buf_len_update(unsigned size)
>>  /* save requested log_buf_len since it's too early to process it */
>>  static int __init log_buf_len_setup(char *str)
>>  {
>> -	unsigned size = memparse(str, &str);
>> +	unsigned size;
> 	unsigned int size;

This is in v1 but then Steven suggested that it should be split out
and only keep the pure fix part here.

>
>> +	if (!str) {
>> +		pr_err("Config string not provided\n");
> pr_debug() may be?
>
> It's not clear from this error message which one of the "config strings"
> was not provided. Besides, I think "config string" is misleading and in
> fact it's a "boot command line parameter". But, dunno, I guess I'd just
> drop that print out.

I'm OK with dropping it. Anyway it'd get "Malformed early
option 'log_buf_len'" from early_param later.

I'll send v3. Thank you.

Zhe

>
> Otherwise,
>
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>
> 	-ss
>

