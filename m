Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60B1C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7082083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X3/HUmP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7082083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbeIFGBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:01:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51516 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFGBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:01:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w861JGSM148421;
        Thu, 6 Sep 2018 01:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1P0chGSb3rxKccYuX/YKV+R7iMMbzgCoaJvV3WErQm0=;
 b=X3/HUmP2cXmooAN+3G1f+klmtOiDIfpgk8K5EutsqY+b4AP69ju1OKOXYb3cXLBpEsfy
 q8H74LKhYo+GG2trYfvWEmLWiCEidFBhvQeDSnpEAKVlXzB9eQgmjzGuBEnUtzqU6tqn
 gSpJM9VE8CJDG7GrEcE/blN6EySI7ij6b3hqmstvlQocbstohlsmdSyBVZj7I5CIIraC
 w7F53pp8vI1waml+nYsKxfZxNwdv74kiEozEif4FuuS74yyhWck2mDYYNjbsX4RN2T21
 wEsZecBo5+dLfiNcYvHyAWuGVM0ApuRgtrURA8B5zAyH4Zx02fAHRx2nkWZhcXTuxxyK gQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2m7kdqqaaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Sep 2018 01:28:04 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w861Rwxl021516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Sep 2018 01:27:58 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w861Ruc9017112;
        Thu, 6 Sep 2018 01:27:56 GMT
Received: from [10.182.69.224] (/10.182.69.224)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 18:27:56 -0700
Subject: Re: [PATCH 3/3] nvme-pci: use queue close instead of queue freeze
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, bart.vanassche@wdc.com, sagi@grimberg.me,
        keith.busch@intel.com, jthumshirn@suse.de, jsmart2021@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <1536120586-3378-4-git-send-email-jianchao.w.wang@oracle.com>
 <20180905220910.GC21352@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <8ba97c77-0c3b-75df-0259-3c97ef7b774e@oracle.com>
Date:   Thu, 6 Sep 2018 09:28:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905220910.GC21352@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9007 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=985
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809060012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 09/06/2018 06:09 AM, Ming Lei wrote:
> nvme_dev_add() still may call freeze & unfreeze queue, so your patch
> can't avoid draining queue completely here.

Yes, I know this. We still need to freeze queue when update nr_hw_queues.
But we move forward a step at least. :)
We don't need to drain request queue in normal case of nvme_reset_work.

As for updating nr_hw_queues, we could try some other method on it next.


Thanks
Jianchao
