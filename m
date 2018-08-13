Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C49EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05E62174C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05E62174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbeHMPV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:21:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728684AbeHMPVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:21:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 494E1E54A05C0;
        Mon, 13 Aug 2018 20:39:16 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 13 Aug
 2018 20:39:08 +0800
Subject: Re: [PATCH 4/8] staging: erofs: cleanup z_erofs_vle_work_{lookup,
 register}
To:     Dan Carpenter <dan.carpenter@oracle.com>, Chao Yu <chao@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
        Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-5-chao@kernel.org>
 <20180813120057.6grkpue6h7dtmpt2@mwanda>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <f162748e-cc02-8578-2a0b-af16d982e0b3@huawei.com>
Date:   Mon, 13 Aug 2018 20:37:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180813120057.6grkpue6h7dtmpt2@mwanda>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2018/8/13 20:00, Dan Carpenter wrote:
> On Sun, Aug 12, 2018 at 10:01:46PM +0800, Chao Yu wrote:
>> From: Gao Xiang <gaoxiang25@huawei.com>
>>
>> This patch introduces 'struct z_erofs_vle_work_finder' to clean up
>> arguments of z_erofs_vle_work_lookup and z_erofs_vle_work_register.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  drivers/staging/erofs/unzip_vle.c | 89 ++++++++++++++++---------------
>>  1 file changed, 47 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
>> index b2e05e2b4116..5032b3b05de1 100644
>> --- a/drivers/staging/erofs/unzip_vle.c
>> +++ b/drivers/staging/erofs/unzip_vle.c
>> @@ -271,36 +271,42 @@ static inline bool try_to_claim_workgroup(
>>  	return true;	/* lucky, I am the followee :) */
>>  }
>>  
>> +struct z_erofs_vle_work_finder {
>> +	struct super_block *sb;
>> +	pgoff_t idx;
>> +	unsigned pageofs;
>> +
>> +	struct z_erofs_vle_workgroup **grp_ret;
>> +	enum z_erofs_vle_work_role *role;
>> +	z_erofs_vle_owned_workgrp_t *owned_head;
>> +	bool *hosted;
>> +};
>> +
>>  static struct z_erofs_vle_work *
>> -z_erofs_vle_work_lookup(struct super_block *sb,
>> -			pgoff_t idx, unsigned pageofs,
>> -			struct z_erofs_vle_workgroup **grp_ret,
>> -			enum z_erofs_vle_work_role *role,
>> -			z_erofs_vle_owned_workgrp_t *owned_head,
>> -			bool *hosted)
>> +z_erofs_vle_work_lookup(const struct z_erofs_vle_work_finder *f)
>>  {
>>  	bool tag, primary;
>>  	struct erofs_workgroup *egrp;
>>  	struct z_erofs_vle_workgroup *grp;
>>  	struct z_erofs_vle_work *work;
>>  
>> -	egrp = erofs_find_workgroup(sb, idx, &tag);
>> +	egrp = erofs_find_workgroup(f->sb, f->idx, &tag);
>>  	if (egrp == NULL) {
>> -		*grp_ret = NULL;
>> +		*f->grp_ret = NULL;
> 
> All these pointers to pointer seem a bit messy.  Just do this:
> 
> 	struct z_erofs_vle_workgroup *grp;
> 
> Then replace "grp" in z_erofs_vle_work_iter_begin() with finder.grp;
> 

I wrote this because I am not sure of all compiler behaviors.

Notice that the struct `struct z_erofs_vle_work_finder' has been all marked as const.

If I use `struct z_erofs_vle_workgroup *grp;' and drop the `const' decorator,
compilers could do some re-read operations bacause its value could potentially change by its caller at the same time.

Thanks,
Gao Xiang

> regards,
> dan carpenter
> 
