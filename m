Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1755C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE69A2184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfBACg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 21:36:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726968AbfBACg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 21:36:56 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 028D693409ED4078EBA0;
        Fri,  1 Feb 2019 10:36:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 10:36:45 +0800
Subject: Re: [PATCH -next] bcache: Fix potential NULL pointer dereference
To:     Kent Overstreet <kent.overstreet@gmail.com>
References: <20190130102112.11228-1-yuehaibing@huawei.com>
 <20190130105817.GA12598@kmo-pixel>
CC:     <colyli@suse.de>, <linux-kernel@vger.kernel.org>,
        <linux-bcache@vger.kernel.org>, Yufen Yu <yuyufen@huawei.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <853cf0ed-330e-8e09-394d-b6a4fc7c5528@huawei.com>
Date:   Fri, 1 Feb 2019 10:36:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190130105817.GA12598@kmo-pixel>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/30 18:58, Kent Overstreet wrote:
> On Wed, Jan 30, 2019 at 06:21:12PM +0800, YueHaibing wrote:
>> There is a potential NULL pointer dereference in case
>> kzalloc() fails and returns NULL.
>>
>> Fixes: bc082a55d25c ("bcache: fix inaccurate io state for detached bcache devices")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/md/bcache/request.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
>> index 1507041..a50afa4 100644
>> --- a/drivers/md/bcache/request.c
>> +++ b/drivers/md/bcache/request.c
>> @@ -1094,6 +1094,8 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio)
>>  	 * which would call closure_get(&dc->disk.cl)
>>  	 */
>>  	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
>> +	if (!ddip)
>> +		return;
>>  	ddip->d = d;
>>  	ddip->start_time = jiffies;
>>  	ddip->bi_end_io = bio->bi_end_io;
> 
> This should be using a mempool/bioset... just returning from a make_request
> function is not correct, that's a serious bug - you're just dropping an IO on
> the floor, which is going to cause whatever submitted that IO to hang.


How about this:

         * which would call closure_get(&dc->disk.cl)
         */
        ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
+       if (!ddip) {
+               bio->bi_status = BLK_STS_RESOURCE;
+               bio_endio(bio);
+               return;
+       }
        ddip->d = d;
        ddip->start_time = jiffies;
        ddip->bi_end_io = bio->bi_end_io;

> 
> 

