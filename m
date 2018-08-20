Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8761AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2740620936
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ixK593oM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2740620936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbeHTEmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 00:42:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeHTEmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 00:42:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7K1T6EQ092918;
        Mon, 20 Aug 2018 01:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=E4RSNjI3tGlH9ZeEygUpgZa+HQD33hPQwF2yrwOKreU=;
 b=ixK593oMgvTz3GFNm/3XNqTe2fjNFYQwqNbYwRYmLunwUdJN6px2dBzyZ2SJxaUqbVGI
 NO/EYW8hzG25XoZf+1YdGwDP+KRX2U9fCcXeXQhHNTqMRAeO3MTH49p+uOMDC+8kOO9L
 Hlv7SqvFh9mW5YsyxOuDjPvzpnl1LnO6SjF8gWfrKTq3jk8I5Uzi+NVctrqjlEQqX47W
 NgLpjM4455wKvNmVZA0ibWVf1xy5DWVb5f+3BMl+0oskEoAfBl8M0+648J/bTubbdHsj
 jU3ffphP0Npfkck5+pj++LPFG87uHWuL8i5Oi8x3mx3OJwwRqECBKV2H6BHX65iKejfq hQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2kxbdpknws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 01:29:06 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7K1T5h1014083
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 01:29:05 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7K1T3X7008289;
        Mon, 20 Aug 2018 01:29:04 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 19 Aug 2018 18:29:03 -0700
Subject: Re: [PATCH V2 1/2] blk-mq: init hctx sched after update ctx and hctx
 mapping
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534478043-7170-2-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVPZF7ohzUib4Nr1qdHLwjpEWP4+be6h6GmZh1y9-qsVqg@mail.gmail.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <96657784-dd95-6ea9-3ffd-25737c534075@oracle.com>
Date:   Mon, 20 Aug 2018 09:29:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVPZF7ohzUib4Nr1qdHLwjpEWP4+be6h6GmZh1y9-qsVqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8990 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=813
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808200014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 08/17/2018 05:33 PM, Ming Lei wrote:
>> +               /*
>> +                * elevator_release will put it.
>> +                */
>> +               __module_get(q->elv_type->elevator_owner);
> I understand what elevator_release() frees is the 'ref-counter' got in
> elevator_get(), but who will be the counter-pair of the above  __module_get()?


Sorry for my bad description.

The code path is:

elevator_release
  -> elevator_put(e->type)
    -> module_put(e->elevator_owner)

In normal elevator switch path, elevator_get will hold a reference counter of the
elevator_owner.
In this patch set, the elevator_type is saved directly. To prevent the io scheduler module
is removed, we need to hold a reference of the module.

Thanks
Jianchao
