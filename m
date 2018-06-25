Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD4AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0D7253B0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KJ/Rb6MI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0D7253B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeFYB3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 21:29:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38612 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeFYB3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 21:29:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5P1SuPa103335;
        Mon, 25 Jun 2018 01:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=rZmO17pWO5mXS1M6/k+r1JbTkkUkB5bYyZYcI9Vb+4k=;
 b=KJ/Rb6MIBUKNlZZtQIqPo35Yb6XVFJumVMY6Y+Isq+I4lRgkbDZsWr5NlS9jllEVW1Bd
 BuTpaa1zCr11AZwIqvcgnzQCx6yT5Xps+2aCqfN27d/lmQ/BI2pwAAVzDeeRGJE5CqXH
 x9lvJD8kXqmQa54UutL8ksh4nKkoXSFtDeUD5zFI4Q2SVuI28aP29xPvkONuEyv2hHMo
 tC3Th/x4hkTFTj4E3VmiD1f/2nlWrpbdeQnRcyK4yCDOj5iV4qT+zX9igCy3jUkgGS4k
 2RSO1+GXvqzYUzBzcK5sLsMPrDgPh/Ra1o0Aa93Dsev885HOqLXqTO4NjH79e+fO1vGB 9A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jt7vm0sy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 01:28:57 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5P1SuoY027137
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 01:28:56 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5P1SteT024950;
        Mon, 25 Jun 2018 01:28:55 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Jun 2018 18:28:55 -0700
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
 <a68ad043-26a1-d3d8-2009-504ba4230e0f@oracle.com>
 <20180622151043.GA13470@lst.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <8438fb8b-564b-1208-7c88-8061552e1dcb@oracle.com>
Date:   Mon, 25 Jun 2018 09:29:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180622151043.GA13470@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8934 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806250016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

Sorry for delayed response.

On 06/22/2018 11:10 PM, Christoph Hellwig wrote:
> On Thu, Jun 21, 2018 at 04:22:22PM +0800, jianchao.wang wrote:
>>> Trace, please.  With the latest kernel.  I'm not saying that there
>>> is nothing to fix, but the mode of never completing once timeout
>>> requests as currently done is SCSI is clearly broken.
>>>
>>
>> I didn't find the existing method to simulate this.
>> So I modified the scsi-debug as following patch as install it as following:
>> modprobe scsi-debug delay=-1 ndelay=-1
>> Both 4.17-rc1 and 4.18-rc1 with this patch set could survive from the test.
> 
> What tree is this against?  I can't apply it to either current Linus'
> tree or 4.17 for that matter.

Ｉ made the patch against 4.18.rc1.

> Also I'm not sure this blk_abort_request call is representative
> of the real world.  Drivers do drain their queues before calling
> it in general, e.g. take a look at ata_eh_set_pending for the
> probably most common user.
> 

This blk_abort_request here is to force request timed out and simulate the
scenario where timeout path and io completion path could occur concurrently.
It is hard for me to trigger this scenario in real world, so I made  this patch
which may looks bad. What I want is to trigger the io completion and timeout path
concurrently.


Thanks
Jianchao
