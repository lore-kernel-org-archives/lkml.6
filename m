Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0094EC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBBF20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBBF20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJKROA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:14:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56913 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbeJKRN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:13:59 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 43C8077832092;
        Thu, 11 Oct 2018 17:47:26 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 11 Oct
 2018 17:47:17 +0800
Subject: Re: [PATCH] staging: erofs: harden inode lookup for 32-bit platforms
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20181009140713.29629-1-gaoxiang25@huawei.com>
 <20181011084413.3sovzgsj6pzyrml7@mwanda>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <b6baf932-64e5-c902-7e7f-02094b96a8d6@huawei.com>
Date:   Thu, 11 Oct 2018 17:46:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181011084413.3sovzgsj6pzyrml7@mwanda>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/11 16:44, Dan Carpenter wrote:
> On Tue, Oct 09, 2018 at 10:07:13PM +0800, Gao Xiang wrote:
>> This patch introduces inode hash function, test and set callbacks,
>> and iget5_locked to find the right inode for 32-bit platforms.
>>
> 
> The way I read this changelog, we're trying to deal with corrupt file
> systems?  Is that correct?  Presumably in the current code it could lead
> to a Oops or something?

No, this commit isn't trying to deal with corrupt file systems.
In EROFS, the nid is not continuous and it represents the inode offset
inode offset = nid * 32.
Therefore the nid is 64-bit both for 32-bit and 64-bit platforms. However,
i_ino is 'unsigned long', which means for 32-bit platforms, i_ino is not enough
to contain the nid.

Therefore, we should use iget5_locked for this case.

> 
> regards,
> dan carpenter
> 
