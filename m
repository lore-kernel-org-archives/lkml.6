Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507FAC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAB420C07
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ySLlyqzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAB420C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeHTEpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 00:45:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54946 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeHTEpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 00:45:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7K1Tk4m066903;
        Mon, 20 Aug 2018 01:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=R3/LANc47hxZ0zvZcbGMGxAci+ng7++gXQSVeD8f2E0=;
 b=ySLlyqzAVe1X2UdEw6t7CGyCJSZwWhbBGGaph7TzJU/B6Hk0Q+yZNA9Fluftx2W0Ql/O
 B5152WqCVZZ8uv3Lyb6W7SrTD5YwNoMK2eVRKH6uy6529RrOASMV/HRg7ECkJpNCGjvv
 HPPMOU+WwEq5MvHh/u7ByK61OAkD53wkn4F8icU4Hwj31gXe5WejXzoVXMvzpiTtAFIc
 +l6gFXMxhm1/v2PMLMFbfCsucoMZf3FxW2wZtHbU64+ZaZL7M7erMxxR0Q+EHADjuB3T
 FSQyBGItF4oaJ0cjI/ztV9vP+5G6NxQZ29XB3zvPa2B2PYssSmcq8ekkdfWc5OF721Gw zQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kxavtbqge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 01:31:56 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7K1Vt1W010901
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 01:31:55 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7K1Vtkf030462;
        Mon, 20 Aug 2018 01:31:55 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 19 Aug 2018 18:31:54 -0700
Subject: Re: [PATCH V2 2/2] blk-mq: sync the update nr_hw_queues with
 part_in_flight
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534478043-7170-3-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVMBFwGngLWjf=oT+2=57xWgF38ozf0D3hc_RKOTXbRWVA@mail.gmail.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <75c13c79-efc6-c41f-c349-9dae094f50be@oracle.com>
Date:   Mon, 20 Aug 2018 09:32:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVMBFwGngLWjf=oT+2=57xWgF38ozf0D3hc_RKOTXbRWVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8990 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=701
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808200014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 08/17/2018 05:36 PM, Ming Lei wrote:
> I'd suggest to put the rcu_* and percpu_ref_is_zero() into
> blk_mq_queue_tag_busy_iter().

Yes, it's fine for me. :)
I will change it in next version.

Thanks
Jianchao
