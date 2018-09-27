Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4583FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0EF21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GSBonbPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0EF21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeI0Q6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:58:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46980 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbeI0Q6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:58:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8RAd8AQ144705;
        Thu, 27 Sep 2018 10:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=Wd2EG06MVyKQypwiXW3ayoYq6PoUpGgAhp51keAtcCU=;
 b=GSBonbPmW1ZR6SbWEKomrrh0sftWIx09fRzXhdWjc2wbM0cIMG9/F6lQXWOLmzv7iov2
 X1+vWLqdiHka5QOHL33Y6UJ6Y+O2hERcL6DIFNDNx1d/cBimqTcMNJPrT9KRi6bYr0o3
 fV/jnPmLh14ALdJJb85sqBpk5AJHcdr/V5nmDbtnHEmW8W82PC5eJ4BQttP355mD1wXH
 9Aj+EpfqXYL18OV6+1WFWSMtnj7fAM//4AKEZl82ngsnfEPE+GjqADeeOulYLqBBY+tJ
 jA8WtyFnr/n6WuvDvzFYTpXv4oOlMILEBMwySF/UGLhfpjYegjO3/2bKzOkohfOMLQ0/ BQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mnvtuyywx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 10:41:12 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8RAfB8k008292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 10:41:11 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8RAfBHT003465;
        Thu, 27 Sep 2018 10:41:11 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Sep 2018 03:41:10 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] blk-mq: two fixes about updating hw queues
Date:   Thu, 27 Sep 2018 18:43:02 +0800
Message-Id: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9028 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=505
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809270109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

This patch set fixes two defects during update hw queues.

1st patch refactor the blk-mq debugfs and sysfs register during
blk_mq_update_nr_hw_queues.

2nd patch should be able to fix the panic reported in follwing link
https://marc.info/?l=linux-block&m=153799465603723&w=2

Jianchao Wang (2)
blk-mq: adjust debugfs and sysfs register when updating nr_hw_queues
blk-mq: fallback to previous nr_hw_queues when updating fails

block/blk-mq.c | 79 ++++++++++++++++++++++++++++++++++------------------------
1 file changed, 47 insertions(+), 32 deletions(-)

Thanks
Jianchao
