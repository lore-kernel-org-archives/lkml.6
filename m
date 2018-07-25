Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2E3C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CEB20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IjqZLob3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CEB20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeGYFIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 01:08:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51000 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbeGYFIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 01:08:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6P3s49V055215;
        Wed, 25 Jul 2018 03:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=SdCo1KA8tOmjM6JduSLGt8v/+CbGShO5h/GC5HHqPic=;
 b=IjqZLob3BqEhV9fgrcj1dH1ZjHacf2hTGpzCfRF3jKoadcMkAp99i8UHg2bkPN8nz3Yu
 qSpnf4j/0knQlKagJlGhrPO/Mr7OrYm2x13y2bdafIxAd/u4IGl8iigfuNMIDLZjHYQx
 i6ww8pwmacLVwJU0TB6NNwtVOgpsSk0gfvzmw6qXl2Cd66/ukruI06okYoZXGWac2UW5
 18R3Vw9FcP2pLm/h25/u2kpkHvJt++HOh4ZjbWvwSAWoDifXPxsHrdAG/zOb1vqgcdiU
 PBH9oicQt/u0Flk4VHupZWihMF68abUCrRkfkW+uL+dWJBXDmIRqyfQursjm2JbfqdDt zg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kbwfpum6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 03:58:47 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6P3wjGk015859
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 03:58:46 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6P3wipU006641;
        Wed, 25 Jul 2018 03:58:44 GMT
Received: from santoshs-mbp.lan (/69.181.241.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Jul 2018 20:58:44 -0700
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
 <3bb47711-870e-90c6-d404-3fe61f0ab9a0@oracle.com>
 <20180706081113.kwrwcat5l6o7ozar@linux-x5ow.site>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <a879fe73-1755-8e4c-6f23-203b8d46a373@oracle.com>
Date:   Tue, 24 Jul 2018 20:58:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180706081113.kwrwcat5l6o7ozar@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=668
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/18 1:11 AM, Johannes Thumshirn wrote:
> On Thu, Jul 05, 2018 at 09:09:44AM -0700, Santosh Shilimkar wrote:
>> OK. we will look into it if an interim fix can be made....
> 
> Thanks a lot.
> 
Intermediate fix is posted here [1]

Regards,
Santosh

[1] https://patchwork.ozlabs.org/patch/949010/
