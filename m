Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761BCC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3709B2150D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3709B2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbeHBOvu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:51:50 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6399 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732298AbeHBOvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:51:49 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 81D48C3C36168;
        Thu,  2 Aug 2018 21:00:29 +0800 (CST)
Received: from DGGEMM507-MBX.china.huawei.com ([169.254.1.75]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0382.000;
 Thu, 2 Aug 2018 21:00:27 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "andros@netapp.com" <andros@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] fs/nfsd: Delete invalid assignment statements in
 nfsd4_decode_exchange_id
Thread-Topic: [PATCH v2] fs/nfsd: Delete invalid assignment statements in
 nfsd4_decode_exchange_id
Thread-Index: AQHUIi1NRysWYcff9EOHqMRQnWfztqSqi0sAgAHuf1A=
Date:   Thu, 2 Aug 2018 13:00:26 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A730A64@dggemm507-mbx.china.huawei.com>
References: <20180723015711.27961-1-nixiaoming@huawei.com>
 <20180801151820.GA18338@fieldses.org>
In-Reply-To: <20180801151820.GA18338@fieldses.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.88.168]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 01, 2018 11:18 PM ,  J. Bruce Fields  wrote: 
>On Mon, Jul 23, 2018 at 09:57:11AM +0800, nixiaoming wrote:
>> READ_BUF(8);
>> dummy = be32_to_cpup(p++);
>> dummy = be32_to_cpup(p++);
>> ...
>> READ_BUF(4);
>> dummy = be32_to_cpup(p++);
>> 
>> Assigning value to "dummy" here, but that stored value
>> is overwritten before it can be used.
>> At the same time READ_BUF() will re-update the pointer p.
>> 
>> delete invalid assignment statements
>
>Thanks, applying with a minor comment tweak to clarify that we're
>intentionally not reading these:
>
>-		/* ssp_window and ssp_num_gss_handles */
>+		/* ignore ssp_window and ssp_num_gss_handles: */
> 		READ_BUF(8);
> 		break;
>
>--b.
>

Thanks for your advice
I will update the patch as soon as possible according to your advice.

>> 
>> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>2
>> Signed-off-by: Trond Myklebust <trondmy@hammerspace.com>
>> ---
>>  fs/nfsd/nfs4xdr.c | 2 --
>>  1 file changed, 2 deletions(-)
>> 
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index a96843c..375ad4b 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -1392,8 +1392,6 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
>>  
>>  		/* ssp_window and ssp_num_gss_handles */
>>  		READ_BUF(8);
>> -		dummy = be32_to_cpup(p++);
>> -		dummy = be32_to_cpup(p++);
>>  		break;
>>  	default:
>>  		goto xdr_error;
>> -- 
>> 2.10.1



