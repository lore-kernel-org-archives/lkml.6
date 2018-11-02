Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4AEC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02ED2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q8EXrCJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02ED2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbeKBQQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:16:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34338 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbeKBQQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 12:16:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA278sgO007487;
        Fri, 2 Nov 2018 07:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=3IDPr7f7YTKgrAbn0CjW4ax7Hw9G0BPjH/FYfNHQAe4=;
 b=q8EXrCJvrkPEkzlL2L3BTbg0zsPSQIdD0wCCk7kVghW8LB4wtsMyqkmWNwoU661gv7y6
 DTbbcVgLUBaTF8BgTofMVMCR99fdws5SoReJDSYrhJ92q69v/XbDbLojH3R/Zml0t0Gk
 Pe19v+yC4QBHFERhDsofcdMq7aczWJIltF6nrO50z0RnE/apk2QuNdWuGeePVa6WxF+L
 k1H6/lbaSxrpMOCaYNWUvNPmAzaC03dzTPG2quBaQh80U1OvN7RKC0JcCPpptb2lnfX8
 I2+GMRUqoieZdZKlCv2ZlFTqvrM8HOPzjmCb2s7PGgKj3yo62NOhQEBoS5dhlY352w0W 7Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2ncgnrcuhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Nov 2018 07:10:12 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA27ABuV030942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Nov 2018 07:10:12 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA27ABYh005676;
        Fri, 2 Nov 2018 07:10:11 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Nov 2018 00:10:10 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/5] blk-mq: refactor and fix on issue request directly
Date:   Fri,  2 Nov 2018 15:08:51 +0800
Message-Id: <1541142536-1431-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9064 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811020067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

These patch set refactors the code of issueing request driectly and
fix some defects.

The 1st patch make __blk_mq_issue_directly be able to accept NULL cookie
pointer.

The 2nd patch refactors the code of issue request directly.
It merges the blk_mq_try_issue_directly and __blk_mq_try_issue_directly
and make it handle the return value of .queue_rq itself.

The 3rd patch let the requests be inserted into hctx->dispatch when
the queue is stopped or quiesced if bypass is true.

The 4th patch make blk_mq_sched_insert_requests issue requests directly
with 'bypass' false, then it needn't to handle the non-issued requests
any more.

The 5th patch ensures the hctx to be ran on its mapped cpu in issue directly
path.

V4:
 - split the original patch 1 into two patches, 1st and 2nd patch currently
 - rename the mq_decision to mq_issue_decision
 - comment changes

V3:
 - Correct the code about the case bypass_insert is true and io scheduler
   attached. The request still need to be issued in case above. (1/4)
 - Refactor the code to make code clearer. blk_mq_make_request is introduced
   to decide insert, end or just return based on the return value of .queue_rq
   and bypass_insert (1/4) 
 - Add the 2nd patch. It introduce a new decision result which indicates to
   insert request with blk_mq_request_bypass_insert.
 - Modify the code to adapt the new patch 1.

V2:
 - Add 1st and 2nd patch

Jianchao Wang (5)
blk-mq: make __blk_mq_issue_directly be able to accept
blk-mq: refactor the code of issue request directly
blk-mq: fix issue directly case when q is stopped or
blk-mq: issue directly with bypass 'false' in
blk-mq: ensure hctx to be ran on mapped cpu when issue

 block/blk-mq-sched.c |   8 ++-
 block/blk-mq.c       | 149 ++++++++++++++++++++++++++++++---------------------
 2 files changed, 92 insertions(+), 65 deletions(-)

Thanks
Jianchao
