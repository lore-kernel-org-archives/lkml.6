Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32404C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E792085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m/X35SB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E792085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeKFLAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:00:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55984 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKFLAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 06:00:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA61YR9A130926;
        Tue, 6 Nov 2018 01:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=H2Fj0AUHG6POQgM0p6zviKHMTfTgR3sXcg4413mxF0I=;
 b=m/X35SB985W8FIFXoYn4mRx24fI7t5/RB6w8CLXzc3QTs41ISmdobu24TZewj7O9r5s3
 U4fhCMy+bPFyo93yBetq533FvgrIR84e+wOTgJMNIT5ZuN4VDjl+kvSYWlyJYJfLCRNm
 lrhKQhQ2Bf2ZxhxM+Q4Xh3QBjBvhyG37GA8tFsHQ7R+noPSeNL/jVe/u+Qkm2PT2dsOj
 uD0ZboiM9hKj3DanFpa+ZzZLz75MNJtqGx+Iuq7KgwrOBBsGidYnNUsM7oJV4AqZW8D2
 R9Guj7KthJEbQmnew3V4JNAeMhkCmw/W3Bdypq3M5jSphxQFP3GUBGO+mEVzIiPSThVU 5g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nh3mpjewb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 01:37:53 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA61blX2010429
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 01:37:47 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA61bkLT011207;
        Tue, 6 Nov 2018 01:37:46 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 17:37:46 -0800
Subject: Re: [PATCH V4 0/5] blk-mq: refactor and fix on issue request directly
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1541142536-1431-1-git-send-email-jianchao.w.wang@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <24495fec-ab19-abc2-d5e8-2734d4f67fcb@oracle.com>
Date:   Tue, 6 Nov 2018 09:37:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541142536-1431-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would anyone please take a look at this ?

Thanks
Jianchao

On 11/2/18 3:08 PM, Jianchao Wang wrote:
> Hi Jens
> 
> These patch set refactors the code of issueing request driectly and
> fix some defects.
> 
> The 1st patch make __blk_mq_issue_directly be able to accept NULL cookie
> pointer.
> 
> The 2nd patch refactors the code of issue request directly.
> It merges the blk_mq_try_issue_directly and __blk_mq_try_issue_directly
> and make it handle the return value of .queue_rq itself.
> 
> The 3rd patch let the requests be inserted into hctx->dispatch when
> the queue is stopped or quiesced if bypass is true.
> 
> The 4th patch make blk_mq_sched_insert_requests issue requests directly
> with 'bypass' false, then it needn't to handle the non-issued requests
> any more.
> 
> The 5th patch ensures the hctx to be ran on its mapped cpu in issue directly
> path.
> 
> V4:
>  - split the original patch 1 into two patches, 1st and 2nd patch currently
>  - rename the mq_decision to mq_issue_decision
>  - comment changes
> 
> V3:
>  - Correct the code about the case bypass_insert is true and io scheduler
>    attached. The request still need to be issued in case above. (1/4)
>  - Refactor the code to make code clearer. blk_mq_make_request is introduced
>    to decide insert, end or just return based on the return value of .queue_rq
>    and bypass_insert (1/4) 
>  - Add the 2nd patch. It introduce a new decision result which indicates to
>    insert request with blk_mq_request_bypass_insert.
>  - Modify the code to adapt the new patch 1.
> 
> V2:
>  - Add 1st and 2nd patch
> 
> Jianchao Wang (5)
> blk-mq: make __blk_mq_issue_directly be able to accept
> blk-mq: refactor the code of issue request directly
> blk-mq: fix issue directly case when q is stopped or
> blk-mq: issue directly with bypass 'false' in
> blk-mq: ensure hctx to be ran on mapped cpu when issue
> 
>  block/blk-mq-sched.c |   8 ++-
>  block/blk-mq.c       | 149 ++++++++++++++++++++++++++++++---------------------
>  2 files changed, 92 insertions(+), 65 deletions(-)
> 
> Thanks
> Jianchao
> 
