Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CA6C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB6920837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m07y7dDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB6920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933222AbeFUNNc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:13:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34596 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932743AbeFUNNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:13:30 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5LD96ln145881;
        Thu, 21 Jun 2018 13:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=/KCwabEDvxG5JoMliUG82xtRoiEJbg1WvmkjL1wUi0k=;
 b=m07y7dDuyjqCqo9DMzoQiAgsgywqX6VCbLhzqAiHN2H5JfGlu8/mRHImABiveLqgbdNt
 /7XECVlIlxFX9JjpV6PJj5s72/tXHtNyPFarZ4uhaqJoL9tVRajcojs2Z2HcAKT9a5CF
 SCQJskygLJUEHBXp93MUtDbI8cU92hbfcYaBB/qenl09hUdLbyMUXD56G+1fFeFFJ0gY
 OcrZ/ZHS6K+qx5r6iAX+pduMa2A7PHnLH6AZxCgkPM/f+lxWO5HXALqY2Cx24HbuT24n
 QB/BUK/GPjn3Pqzkd+SVOyyR/aj8n0nu6K6ZE9pKQ2MmCJQ4YkEkrRWUFV3s3OGKHDf+ 5Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jmr2mrura-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 13:13:23 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5LDDMNn009185
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 13:13:22 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5LDDLiI026037;
        Thu, 21 Jun 2018 13:13:21 GMT
Received: from [10.191.15.192] (/10.191.15.192)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 06:13:20 -0700
Subject: Re: [PATCH 0/5]stop normal completion path entering a timeout req
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <keith.busch@intel.com>, axboe@kernel.dk,
        martin.petersen@oracle.com, josef@toxicpanda.com,
        ulf.hansson@linaro.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180620181601.GA24145@localhost.localdomain>
 <e87f5946-bb21-942e-2dcc-b24cee1ad23c@oracle.com>
 <20180621081900.GA5183@lst.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <df1633e8-7df4-976b-a7d5-77679c92843a@oracle.com>
Date:   Thu, 21 Jun 2018 21:13:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180621081900.GA5183@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On 06/21/2018 04:19 PM, Christoph Hellwig wrote:
> On Thu, Jun 21, 2018 at 09:43:26AM +0800, jianchao.wang wrote:
>> So we have to preserve the ability of block layer that it could prevent
>> IO completion path from entering a timeout request.
>>
>> With scsi-debug module, I tried to simulate a scenario where timeout and IO
>> completion path could occur concurrently, the system ran into crash easily.
> 
> Trace, please.  With the latest kernel.  I'm not saying that there
> is nothing to fix, but the mode of never completing once timeout
> requests as currently done is SCSI is clearly broken.
> 

Sorry, I don't quite get your point.
Do you mean we should do the modification in the scsi layer ?
Actually, I used to look at the code to try to stop io completion on timeout request
in scsi-mid layer, but it looks like difficult, especially, scsi eh would try
to borrow the command to issue admin command such as get sense, test unit,etc.

Thanks
Jianchao
