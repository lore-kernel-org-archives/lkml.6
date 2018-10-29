Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A064AC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466B32082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BqV8S92L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466B32082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbeJ2RVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:21:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37732 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbeJ2RVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:21:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9T8SpTV013176;
        Mon, 29 Oct 2018 08:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=690QdTpQUIPmwOBlK3N6CRFxt3mwVwZzIMFkarWwql8=;
 b=BqV8S92LIpS2VpfOcEZcifJN/4spb/tXxpwehMhZO8RLO9ErqaVMqeeFrmuQB7IZVLkk
 ZcpIDB3O4dWd3Px9mbQz+J40Rep0xJvcRzMsj37ND4JQpdyY/Zbci8Aqwj7y12J0zWCa
 4tn19FQQsJk+VNl/gvMe0ZXR4dQFgWog3bC7fXhiUkKKZ4uYP/8F2ooH85HzlwZCFu87
 1xD3islsKG0SWehtuBXBwKwZcjjDzJMg6+kjfYFf6D4HFH41L8PC+0jBLfYGDdq9I3C5
 OgjXpArOLbPezRY4qagzjr/ZkP2NqJ8IcJD8wsaqjImwWAu6U4wwJIODwKBEJr2usxMt oQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2ncfypm5ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 08:34:06 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9T8Y5vR027342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 08:34:05 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9T8Y49Y020147;
        Mon, 29 Oct 2018 08:34:04 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Oct 2018 01:34:04 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/4] blk-mq: refactor and fix on issue request directly
Date:   Mon, 29 Oct 2018 16:33:29 +0800
Message-Id: <1540802013-2921-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9060 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=830
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810290082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

The 1st patch refactors the code of issue request directly.
It merges the blk_mq_try_issue_directly and __blk_mq_try_issue_directly
and make it handle the return value of .queue_rq itself.

The 2nd patch let the requests be inserted into hctx->dispatch when
the queue is stopped or quiesced if bypass_insert is true.

The 3rd patch make blk_mq_sched_insert_requests issue requests directly
with 'bypass_insert' false, then it needn't to handle the non-issued requests
any more.

The 4th patch ensures the hctx to be ran on its mapped cpu in issue directly
path.

V3:
 - Correct the code about the case bypass_insert is true and io scheduler
   attached. The request still need to be issued in case above. (1/4)
 - Refactor the code to make code clearer. (1/4) 
 - Add the 2nd patch.
 - Modify the code to adapt the new patch 1.

V2:
 - Add 1st and 2nd patch

Jianchao Wang(4)
blk-mq: refactor the code of issue request directly
blk-mq: insert request without involving any io
blk-mq: issue directly with bypass_insert 'false' in
blk-mq: ensure hctx to be ran on mapped cpu when issue

 block/blk-mq-sched.c |   8 ++-
 block/blk-mq.c       | 139 ++++++++++++++++++++++++++++++---------------------
 block/blk-mq.c.rej   |  60 ++++++++++++++++++++++
 3 files changed, 146 insertions(+), 61 deletions(-)
