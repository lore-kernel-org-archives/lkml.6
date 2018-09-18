Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBA8ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BBA2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BBA2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbeIRRe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:34:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727757AbeIRRe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:34:59 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1E92D587431EE;
        Tue, 18 Sep 2018 20:02:39 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 18 Sep
 2018 20:02:30 +0800
Subject: Re: [PATCH 0/8] staging: erofs: error handing and more tracepoints
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <1536936030-62362-1-git-send-email-gaoxiang25@huawei.com>
 <20180918111953.GA3585@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <aab26d0e-f8dc-cc83-46eb-7a93a833eaae@huawei.com>
Date:   Tue, 18 Sep 2018 20:02:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180918111953.GA3585@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/9/18 19:19, Greg Kroah-Hartman wrote:
> On Fri, Sep 14, 2018 at 10:40:22PM +0800, Gao Xiang wrote:
>> In order to avoid conflicts with cleanup patches, Chao and I think
>> it is better to send reviewed preview patches in the erofs mailing list
>> to the community in time.
>>
>> So here is reviewed & tested patches right now, which clean up and
>> enhance the error handing and add some tracepoints for decompression.
>>
>> Note that in this patchset, bare use of 'unsigned' and NULL comparison are
>> also fixed compared with the preview patches according to the previous
>> discussion in the staging mailing list.
> 
> I applied this, but I need to go delete it as this patch series adds a
> build warning to the system:
> 
> In file included from drivers/staging/erofs/unzip_vle.h:16:0,
>                  from drivers/staging/erofs/unzip_vle.c:13:
> drivers/staging/erofs/unzip_vle.c: In function ‘z_erofs_map_blocks_iter’:
> drivers/staging/erofs/internal.h:303:34: warning: ‘pblk’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>  #define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
>                                   ^
> drivers/staging/erofs/unzip_vle.c:1574:20: note: ‘pblk’ was declared here
>   erofs_blk_t mblk, pblk;
>                     ^~~~
> 
> Please fix that up and resend.

strange... my compiler (4.8.4) and huawei internal CI don't report that,
and this patchset has been in Chao's tree for a while, I don't get any report so far...

I just looked into that code again and it seems a false warning since
1) this code is heavily running on the products and working fine till now.
2) pblk gets a proper value before unzip_vle.c:1690 map->m_pa = blknr_to_addr(pblk);

so I think I need to silence this warning for now and check if there is a really issue....

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
