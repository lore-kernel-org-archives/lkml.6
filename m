Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F06BECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156A520873
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156A520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeGPBvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 21:51:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbeGPBvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 21:51:54 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9769A2B7A6BB7;
        Mon, 16 Jul 2018 09:26:54 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Mon, 16 Jul 2018
 09:26:52 +0800
Subject: Re: [V9fs-developer] [PATCH] net/9p/client.c: fix misuse of
 spin_lock_irqsave for p9_client lock
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <5B46F5AD.50200@huawei.com> <20180712070122.GB7639@nautica>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        <ericvh@gmail.com>, <rminnich@sandia.gov>, <lucho@ionkov.net>,
        <v9fs-developer@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B4BF457.2070905@huawei.com>
Date:   Mon, 16 Jul 2018 09:26:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180712070122.GB7639@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominique,

On 2018/7/12 15:01, Dominique Martinet wrote:
> piaojun wrote on Thu, Jul 12, 2018:
>> In p9_read_work(), we use spin_lock for client->lock, but misuse
>> spin_lock_irqsave for it in p9_fid_create(). As p9_client lock won't be
>> locked in irq context, so spin_lock is enough. And that will improve the
>> performance.
> 
> Agreed on principle, see remark below
> 
>> Signed-off-by: Jun Piao <piaojun@huawei.com>
>> ---
>>  net/9p/client.c   | 17 +++++++----------
>>  net/9p/trans_fd.c |  7 +++----
>>  2 files changed, 10 insertions(+), 14 deletions(-)
>>
>> diff --git a/net/9p/client.c b/net/9p/client.c
>> index 8bc8b3e..b05cbfc 100644
>> --- a/net/9p/client.c
>> +++ b/net/9p/client.c
>> @@ -260,7 +260,6 @@ static struct p9_fcall *p9_fcall_alloc(int alloc_msize)
>>  static struct p9_req_t *
>>  p9_tag_alloc(struct p9_client *c, u16 tag, unsigned int max_size)
>>  {
>> -	unsigned long flags;
>>  	int row, col;
>>  	struct p9_req_t *req;
>>  	int alloc_msize = min(c->msize, max_size);
>> @@ -270,7 +269,7 @@ static struct p9_fcall *p9_fcall_alloc(int alloc_msize)
>>  	tag++;
>>
>>  	if (tag >= c->max_tag) {
>> -		spin_lock_irqsave(&c->lock, flags);
>> +		spin_lock(&c->lock);
> 
> This code doesn't exist anymore with Matthew's idr rework, could you
> submit that patch based on top of my 9p-next branch?
> (unless you really want Andrew to take this for the next 4.18-rc, but
> I'm not convinced this qualifies)

OK, I will rebase my patch and resend later.

Thanks,
Jun

> 
> Please see my "Current 9P patches - test branch" for details:
> https://sourceforge.net/p/v9fs/mailman/message/36365359/
> 
