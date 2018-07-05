Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09041C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EFE23EF0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fz8proUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EFE23EF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbeGEQKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:10:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52590 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbeGEQJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:09:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w65Fwkl4135123;
        Thu, 5 Jul 2018 16:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=VvwBY2tjyb60E0HX/ofDHD71xBFPIEa7NzsqrwBS1Kk=;
 b=Fz8proUGytUTNN2gLAD8A+F8899RvqJg+tKfbm7Jb65qRVrQOAXysacUG3R6MnzhmuL7
 3Rv4Jw7bqHyJlqmCjXy9iRjJAc78iRD3LHqGlH1WJPS52r4oqlIw9hCbiu2QP9p6x9rf
 8q9LHpgmRuAvdlkCPlbIM620aoWH4M7dBecDvmdR435p1rHJvA/o3/R2O3riCaqDWDwe
 rfQN6EcFu3VKCZTv11Im1GQVyAp+Ofo1cy2D1QLKlWhIe3HpPw2b/hPHHfZCRGc1LL9b
 qJGTbVYGt4cMvGqpyk99C8Aw6ypsfqBP38R/ydrHxP6/5Rgn2nnawKAldXWq9m54bTSo Pw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k0dnt6m82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jul 2018 16:09:51 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w65G9nbB021333
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jul 2018 16:09:49 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w65G9mii025095;
        Thu, 5 Jul 2018 16:09:48 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Jul 2018 09:09:48 -0700
Subject: Re: general protection fault in rds_ib_get_mr
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Eric Biggers <ebiggers3@gmail.com>, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com,
        syzbot <syzbot+b51c77ef956678a65834@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <089e082ce58896ad350567ee4825@google.com>
 <20180513211058.GE677@sol.localdomain>
 <27665604-6a26-36e2-3a58-9c8b3d9eab80@oracle.com>
 <20180704213506.GH725@sol.localdomain>
 <04c882dc-332e-92d6-fe76-b1dd3bedd71c@oracle.com>
 <20180705070641.ske6jjvk4zp5kg2f@linux-x5ow.site>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <3bb47711-870e-90c6-d404-3fe61f0ab9a0@oracle.com>
Date:   Thu, 5 Jul 2018 09:09:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705070641.ske6jjvk4zp5kg2f@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8944 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=889
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807050182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/2018 12:06 AM, Johannes Thumshirn wrote:
> On Wed, Jul 04, 2018 at 05:32:20PM -0700, santosh.shilimkar@oracle.com wrote:
>> On 7/4/18 2:35 PM, Eric Biggers wrote:
>>> On Sun, May 13, 2018 at 10:46:37PM -0700, santosh.shilimkar@oracle.com wrote:
>>>> On 5/13/18 2:10 PM, Eric Biggers wrote:
>>>>> On Wed, Mar 21, 2018 at 09:00:01AM -0700, syzbot wrote:
>>>>
>>>> [...]
>>>>
>>>>
>>>>> Still reproducible on Linus' tree (commit 66e1c94db3cd4) and linux-next
>>>>> (next-20180511).  Here's a simplified reproducer:
>>>>>
>>>> Thanks for the test case !!
>>>>
>>
>> [...]
>>
>>>
>>> Ping; this RDS bug is still unfixed.  The same reproducer I gave earlier still
>>> works, even when run as a non-root user.  I tested upstream commit
>>> fc36def997cfd6 (v4.18-rc3-113-gfc36def997cfd), and linux-next commit
>>> bce40927669338 (next-20180704).
>>>
>> Yeah I haven't sent a fix for this yet. Downstream we have refactored
>> MR code and I wanted to get that upstream. With that this bug will
>> also get addressed. I was hoping to get that series but since some
>> optimisation is still pending investigations its getting delayed.
>>
>> Will find out if I can fix this panic in meantime with smaller change.
>> Thanks for reminder.
> 
> Oh please sent bug fixes _before_ refactoring in that area. Otherwise
> it's a pain for everybody backporting the fix to a stable kernel.
> 
OK. we will look into it if an interim fix can be made....
