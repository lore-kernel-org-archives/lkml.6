Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACAFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57D2218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfB0DR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 22:17:57 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728942AbfB0DR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 22:17:57 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4E046B222F42759B7AE;
        Wed, 27 Feb 2019 11:17:52 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 11:17:48 +0800
Subject: Re: [PATCH v2] xfrm: correctly check policy index in
 verify_newpolicy_info
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <20190225095600.26260-1-yuehaibing@huawei.com>
 <20190225134330.ohrvjssdnsmcyxnp@gondor.apana.org.au>
CC:     <steffen.klassert@secunet.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <5a576347-45e2-edf9-f304-b98057893eb1@huawei.com>
Date:   Wed, 27 Feb 2019 11:17:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190225134330.ohrvjssdnsmcyxnp@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/25 21:43, Herbert Xu wrote:
> On Mon, Feb 25, 2019 at 05:56:00PM +0800, Yue Haibing wrote:
>>
>> the check. Then __xfrm_policy_unlink use the index to access array policy_count
>> whose size is XFRM_POLICY_MAX * 2, triggering out of bounds access.
> 
> No it doesn't.  Even if it did the bug would be in __xfrm_policy_unlink
> and not here.
> 

Yes, my fix is wrong.

The issue is triggered as this:

xfrm_add_policy
    -->verify_newpolicy_info  //here check the index provided by user with XFRM_POLICY_MAX
			      //In my case, the index is 0x6E6BB6, so it pass the check.
    -->xfrm_policy_construct  //copy the user's policy and set xfrm_policy_timer
    -->xfrm_policy_insert
	--> __xfrm_policy_link //use the orgin dir, in my case is 2
	--> xfrm_gen_index   //generate policy index, there is 0x6E6BB6

then xfrm_policy_timer be fired

xfrm_policy_timer
   --> xfrm_policy_id2dir  //get dir from policy index & 7, in my case is 6
   --> xfrm_policy_delete
      --> __xfrm_policy_unlink //There access policy_count[dir], it trigger out of range access

So maybe the fix is like this:

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 8d1a898..b27eb742 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -316,6 +316,8 @@ static void xfrm_policy_timer(struct timer_list *t)
                goto out;

        dir = xfrm_policy_id2dir(xp->index);
+       if (dir >= XFRM_POLICY_MAX * 2)
+               dir = dir & XFRM_POLICY_MAX;

        if (xp->lft.hard_add_expires_seconds) {
                time64_t tmo = xp->lft.hard_add_expires_seconds +



> Your patch makes no sense.
> 
> Cheers,
> 

