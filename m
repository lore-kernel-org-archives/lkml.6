Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE106C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E194120659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E194120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJKSQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:16:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbeJKSQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:16:53 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5E3A732E0EB15;
        Thu, 11 Oct 2018 18:50:09 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 11 Oct
 2018 18:50:02 +0800
Subject: Re: [PATCH] staging: erofs: harden inode lookup for 32-bit platforms
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20181009140713.29629-1-gaoxiang25@huawei.com>
 <20181011084413.3sovzgsj6pzyrml7@mwanda>
 <b6baf932-64e5-c902-7e7f-02094b96a8d6@huawei.com>
 <20181011101807.hydncp6nhzjlzznr@mwanda>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <6318156d-4a3d-e5d0-93c1-90be2345565b@huawei.com>
Date:   Thu, 11 Oct 2018 18:49:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181011101807.hydncp6nhzjlzznr@mwanda>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2018/10/11 18:18, Dan Carpenter wrote:
> On Thu, Oct 11, 2018 at 05:46:26PM +0800, Gao Xiang wrote:
>>
>>
>> On 2018/10/11 16:44, Dan Carpenter wrote:
>>> On Tue, Oct 09, 2018 at 10:07:13PM +0800, Gao Xiang wrote:
>>>> This patch introduces inode hash function, test and set callbacks,
>>>> and iget5_locked to find the right inode for 32-bit platforms.
>>>>
>>>
>>> The way I read this changelog, we're trying to deal with corrupt file
>>> systems?  Is that correct?  Presumably in the current code it could lead
>>> to a Oops or something?
>>
>> No, this commit isn't trying to deal with corrupt file systems.
>> In EROFS, the nid is not continuous and it represents the inode offset
>> inode offset = nid * 32.
>> Therefore the nid is 64-bit both for 32-bit and 64-bit platforms. However,
>> i_ino is 'unsigned long', which means for 32-bit platforms, i_ino is not enough
>> to contain the nid.
>>
>> Therefore, we should use iget5_locked for this case.
> 
> I guess what I'm saying is, what are the user visible effects of this
> patch?  It's hard for me to tell from the patch description.  Could you
> please re-write the description and send a v2?

Sorry for my just hurry reply. It seems I really misunderstood your point :-(

If all nids are less than 32-bit, the user will see the correct inode/nid number
for all 32-bit platforms, but if some nids are greater than 32-bit, it could be
collisions without this patch for 32-bit platforms.

This patch switch the inode number by XOR the high 32-bit and the low 32-bit,
use customized tester to avoid collisions for 32-bit platforms.

I will send v2 to fix the commit message...but it seems Greg is already merged in
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=2abd7814138774eb56319e9dcc0abd08ece45424

Thanks,
Gao Xiang

> 
> regards,
> dan carpenter
> 
