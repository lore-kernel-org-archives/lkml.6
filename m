Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBF4C46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6684120839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6684120839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeIKGdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:33:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbeIKGdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:33:53 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 99431D8D83A46;
        Tue, 11 Sep 2018 09:37:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Tue, 11 Sep 2018
 09:37:00 +0800
Message-ID: <5B971C3B.4070605@huawei.com>
Date:   Tue, 11 Sep 2018 09:36:59 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Junhui Tang <tang.junhui.linux@gmail.com>
CC:     <colyli@suse.de>, Kent Overstreet <kent.overstreet@gmail.com>,
        <linux-bcache@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bcache: remove unnecessary null poiner check in cache_set_free
References: <1536406766-27021-1-git-send-email-zhongjiang@huawei.com> <CA+NNRhEo-qryWzGoVbUtQVSbOhbTTwVuzAA7DYmTOcVN8oYehQ@mail.gmail.com>
In-Reply-To: <CA+NNRhEo-qryWzGoVbUtQVSbOhbTTwVuzAA7DYmTOcVN8oYehQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/11 8:59, Junhui Tang wrote:
> This patch is NOT OK to me，maybe many cache in a  cache_set, and some
> cache are not registered yet, so ca is possible NULL.
 Yep,  It's my fault. please ingnore the patch.

 Thanks,
 zhong jiang
> zhong jiang <zhongjiang@huawei.com> 于2018年9月8日周六 下午7:52写道：
>> The iterator in for_each_cache is never null, therefore, remove
>> the redundant null pointer check.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/md/bcache/super.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>> index 94c756c..2d26f9e 100644
>> --- a/drivers/md/bcache/super.c
>> +++ b/drivers/md/bcache/super.c
>> @@ -1513,12 +1513,11 @@ static void cache_set_free(struct closure *cl)
>>         bch_btree_cache_free(c);
>>         bch_journal_free(c);
>>
>> -       for_each_cache(ca, c, i)
>> -               if (ca) {
>> -                       ca->set = NULL;
>> -                       c->cache[ca->sb.nr_this_dev] = NULL;
>> -                       kobject_put(&ca->kobj);
>> -               }
>> +       for_each_cache(ca, c, i) {
>> +               ca->set = NULL;
>> +               c->cache[ca->sb.nr_this_dev] = NULL;
>> +               kobject_put(&ca->kobj);
>> +       }
>>
>>         bch_bset_sort_state_free(&c->sort);
>>         free_pages((unsigned long) c->uuids, ilog2(bucket_pages(c)));
>> --
>> 1.7.12.4
>>
>


