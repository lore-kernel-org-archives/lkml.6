Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E73C1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66BA2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66BA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933659AbeFLMSu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:18:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932412AbeFLMSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:18:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C4B54021CC2;
        Tue, 12 Jun 2018 12:18:49 +0000 (UTC)
Received: from 117.195.187.81.in-addr.arpa (unknown [10.33.36.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1FEC178BC;
        Tue, 12 Jun 2018 12:18:45 +0000 (UTC)
Subject: Re: [Cluster-devel] [PATCH] gfs2: add error handling for
 kmem_cache_zalloc
To:     "cgxu519@gmx.com" <cgxu519@gmx.com>,
        Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
References: <1528774692-38990-1-git-send-email-jiazhouyang09@gmail.com>
 <C20C8754-0C63-4EB2-B3E9-68E4EE29338D@gmx.com>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <bd3892fd-e8f7-fd5f-bc85-b3a55301bebd@redhat.com>
Date:   Tue, 12 Jun 2018 13:18:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <C20C8754-0C63-4EB2-B3E9-68E4EE29338D@gmx.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 12 Jun 2018 12:18:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 12 Jun 2018 12:18:49 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'swhiteho@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 12/06/18 08:24, cgxu519@gmx.com wrote:
>> 在 2018年6月12日，上午11:38，Zhouyang Jia <jiazhouyang09@gmail.com> 写道：
>>
>> When kmem_cache_zalloc fails, the lack of error-handling code may
>> cause unexpected results.
>>
>> This patch adds error-handling code after calling kmem_cache_zalloc.
> Should not fail on this case.
>
> Thanks,
> Chengguang.
Indeed. It is one of the few GFP_NOFAIL allocations left in GFS2. It 
would be good to figure out how to remove the last few of these 
allocations, but simply adding a check for a NULL return is not the 
right solution here anyway. I would also add that if this problem was 
easier then I'm sure we'd have solved it before - the right answer is 
not very obvious in this case,

Steve.

>
>> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
>> ---
>> fs/gfs2/trans.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
>> index 064c9a0..da81eb4 100644
>> --- a/fs/gfs2/trans.c
>> +++ b/fs/gfs2/trans.c
>> @@ -130,6 +130,9 @@ static struct gfs2_bufdata *gfs2_alloc_bufdata(struct gfs2_glock *gl,
>> 	struct gfs2_bufdata *bd;
>>
>> 	bd = kmem_cache_zalloc(gfs2_bufdata_cachep, GFP_NOFS | __GFP_NOFAIL);
>> +	if (!bd)
>> +		return NULL;
>> +
>> 	bd->bd_bh = bh;
>> 	bd->bd_gl = gl;
>> 	bd->bd_ops = lops;
>> -- 
>> 2.7.4
>>
>


