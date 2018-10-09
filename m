Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ED3C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA4F2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C+bAB/5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA4F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeJII4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:56:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59216 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeJII4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:56:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w991XxfJ106968;
        Tue, 9 Oct 2018 01:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=d76BBHblQRrUEdNMiOAlrPU+71xLOchxUejClNFkOL0=;
 b=C+bAB/5bSSgpUWO0U4O75j1EqT6Cw/nEHotQ4INckL2iyjKrFjVr93RzQXFktSkuPoc7
 XuOMHgbGoZwn/3p60moCaUuFBdG/yr5F/Py1FOi0WztjviqNncta9xQAp2EgHldlNyQU
 UWnaigFbN4Msd/MZA5mof+jCxfLGuyx8egJD1IaoBnlAjhW6T16I29cYbLYeVrdvNqgK
 NwfpOvmzstKcXHCRPUuzPR3GTCj3FrYXOwKBEPBmwl51rTp1iwIkkC5c95R2uoFWBPub
 BM8yAq50WEmQvR5teFxtKmmsCwEtMKJhnPPTCJWHAOxCFQr7jcymkHMMKqg4n08AAUt3 Qw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mxmftj5gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Oct 2018 01:41:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w991fO1Y017611
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Oct 2018 01:41:25 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w991fO4w015173;
        Tue, 9 Oct 2018 01:41:24 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Oct 2018 01:41:24 +0000
Subject: Re: [PATCH 0/2] blk-mq: two fixes about updating hw queues
To:     axboe@kernel.dk
Cc:     keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <0bc3c8a1-484b-5fe5-a8af-17d09b0458fa@oracle.com>
Date:   Tue, 9 Oct 2018 09:41:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9040 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=769
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810090015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would anyone please take a look at this patch ?

Thanks in advance
Jianchao

On 09/27/2018 06:43 PM, Jianchao Wang wrote:
> Hi Jens
> 
> This patch set fixes two defects during update hw queues.
> 
> 1st patch refactor the blk-mq debugfs and sysfs register during
> blk_mq_update_nr_hw_queues.
> 
> 2nd patch should be able to fix the panic reported in follwing link
> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dblock-26m-3D153799465603723-26w-3D2&d=DwIBAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=JoGIFiPF4RF8WH8rquW8Qswr2FYvPOVaTxlgmjKHsDk&s=TQn_KiIX2sfmXP_9IYy2IFFRxBj4jBKVaSSU-I1z9g8&e=
> 
> Jianchao Wang (2)
> blk-mq: adjust debugfs and sysfs register when updating nr_hw_queues
> blk-mq: fallback to previous nr_hw_queues when updating fails
> 
> block/blk-mq.c | 79 ++++++++++++++++++++++++++++++++++------------------------
> 1 file changed, 47 insertions(+), 32 deletions(-)
> 
> Thanks
> Jianchao
> 
