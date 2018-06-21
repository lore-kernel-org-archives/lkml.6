Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E2EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA4720846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ePRSkKsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA4720846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932829AbeFUIWP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:22:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41896 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932430AbeFUIWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:22:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5L8J46s070657;
        Thu, 21 Jun 2018 08:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=cmtEASNo05PBx3w4H8J7ZsXzWuLipphD71mar0DVg+c=;
 b=ePRSkKsAyiap5x4rGq7+35hxTpSiJWZf7SZpkXlkzdyyKprAvdu7tkVPDJERxCjjeWe8
 hI8BIG6+IWPCUml2eigC/A9S28ytMbAHfjAPA0asvQjQDxfRrUjmmbjEWP18sQvHvZPo
 Xaqxa5ANmD+oBkBfCQgGWmR+UBBbWQoB3QmUTbWIsNyyGcijjYGgNCW2Yqt609yL5snr
 K9rk6ktc7amsL0pvUcVIrDRAhKd5ITJUq3qw/E7uNlEGAqx5IzGU5A9Oyt6BUh6vuYh4
 sAb1ueoB5bgnVNruzP8MKVJFWDVkgH+2hGC+4nZMYVzqSHWftOVja1ArI07ZJBsYiRM1 AQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jmtgwyp9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 08:22:06 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5L8M5ad025731
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 08:22:05 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5L8M4TN032417;
        Thu, 21 Jun 2018 08:22:04 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 01:22:04 -0700
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
Message-ID: <a68ad043-26a1-d3d8-2009-504ba4230e0f@oracle.com>
Date:   Thu, 21 Jun 2018 16:22:22 +0800
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
 engine=8.0.1-1805220000 definitions=main-1806210094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

Thanks for your kindly response.

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

I didn't find the existing method to simulate this.
So I modified the scsi-debug as following patch as install it as following:
modprobe scsi-debug delay=-1 ndelay=-1
Both 4.17-rc1 and 4.18-rc1 with this patch set could survive from the test.

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 24d7496..f278e6c 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -4323,6 +4323,8 @@ static void setup_inject(struct sdebug_queue *sqp,
        sqcp->inj_host_busy = !!(SDEBUG_OPT_HOST_BUSY & sdebug_opts);
 }
 
+static atomic_t g_abort_counter;
+
 /* Complete the processing of the thread that queued a SCSI command to this
  * driver. It either completes the command by calling cmnd_done() or
  * schedules a hr timer or work queue then returns 0. Returns
@@ -4459,6 +4461,11 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
                        sd_dp->issuing_cpu = raw_smp_processor_id();
                sd_dp->defer_t = SDEB_DEFER_WQ;
                schedule_work(&sd_dp->ew.work);
+               atomic_inc(&g_abort_counter);
+               if (atomic_read(&g_abort_counter)%2000 == 0) {
+                       blk_abort_request(cmnd->request);
+                       trace_printk("abort request tag %d\n", cmnd->request->tag);
+               }
        }
        if (unlikely((SDEBUG_OPT_Q_NOISE & sdebug_opts) &&
                     (scsi_result == device_qfull_result)))
@@ -5844,6 +5851,7 @@ static int sdebug_driver_probe(struct device *dev)
        struct Scsi_Host *hpnt;
        int hprot;
 
+       atomic_set(&g_abort_counter, 0);
        sdbg_host = to_sdebug_host(dev);
 
        sdebug_driver_template.can_queue = sdebug_max_queue;
