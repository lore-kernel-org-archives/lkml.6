Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A2CC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 03:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16B02073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 03:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4Qujji/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16B02073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeI2J2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 05:28:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45896 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeI2J2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 05:28:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8T2wvu5186394;
        Sat, 29 Sep 2018 03:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=DOpax+qFi3xz+++wAvi1WLqPdBheZpu1s6SqYlfwdYA=;
 b=4Qujji/NTEVMU7PxE8ahG5ybNSe1s7KX05MmYBVzkishgSFr3RapSlNCh5xkGVB8qvaB
 1QLqmcWnAlH7QKGRHJ3YoQaG/QsEEb5Yn9Qo3J1hvVegmi6GzxzHcwKHZNmJKWp3s0OC
 Le1hUX85sq+VPTwFlNNABPmlNAYVVHyGBlwufsCzdKnLWIEabnzdAYHR6J1IF5yx1H8W
 3IVuWAnZdES5YLIOG0Yvh12i+SFg0+MNSbITzAlNyShQQ49IJ+mDKqcm5O0Jb7KhzRgM
 QzCFBziTBszu1glQVNbfZn9msoPOCPDguonDGNCSMmit6qSwuhcTFH3DmLj2kPYdwP0L hw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2mndpq3b14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Sep 2018 03:02:05 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8T323vh028529
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Sep 2018 03:02:04 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8T323O5018311;
        Sat, 29 Sep 2018 03:02:03 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Sep 2018 20:02:03 -0700
Subject: Re: [PATCH 1/2] blk-mq: adjust debugfs and sysfs register when
 updating nr_hw_queues
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, keith.busch@linux.intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
 <1538044984-2147-2-git-send-email-jianchao.w.wang@oracle.com>
 <20180929024902.GA27170@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <bea8e6e0-f9fb-d70b-d8c8-d4b53bf8828c@oracle.com>
Date:   Sat, 29 Sep 2018 11:02:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180929024902.GA27170@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9030 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=801
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809290029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 09/29/2018 10:49 AM, Ming Lei wrote:
> Looks both blk_mq_sysfs_register() and blk_mq_debugfs_register_hctx()
> are removed from the path of blk_mq_init_allocated_queue(), so where are
> the two registered for a freshly new queue?

Initially, both of them are registered by following path.
__device_add_disk
  -> blk_register_queue

	if (q->mq_ops) {
		__blk_mq_register_dev(dev, q);
		blk_mq_debugfs_register(q);
	}

blk_mq_init_allocated_queue won't do any thing.

Thanks
Jianchao
