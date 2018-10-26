Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01142C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0CE2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R5ru+q6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0CE2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeJZQi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:38:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55464 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:38:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9Q7wxlA191817;
        Fri, 26 Oct 2018 08:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=1ab5QSGL4fxsXV8DEmcKtwjhzsKgGkshoYiL4IUUqW0=;
 b=R5ru+q6hZMhv7n20gZUjmm5xAROQYcQvJ3o5XaKtExkPeGUDH07bolJ2BvfpKNCxVTDT
 PqeBSxMyMdieaATDlF8HiSlRPuonCUn0mSZURj+scakWoixpv8OH2hGXq3L9R0HO3VuN
 q32iaAP5SXQ4elQ697U+m9SNQ3B2KEyg2J2Ob4DYd1iTADoFLzjLiC1+SHUVKAebcox0
 IXoAXT4GbCF5NAFD8QlGjLym6kwWA0No21cFO6X8+yU+AHNJjQ6ECQtDK9iYnrOwdvvb
 w1ZfAJIBi3uJgv5noU+7OunVfk+/AF4S+PHQHhMzGJBku4ZZzjJesh7Ek+6XXRVOMURc ng== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n7vaqdrew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 08:02:51 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q82o3i000990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 08:02:51 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9Q82oE2004406;
        Fri, 26 Oct 2018 08:02:50 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Oct 2018 01:02:49 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/3] blk-mq: refactor and fix on issue request directly
Date:   Sat, 27 Oct 2018 00:01:08 +0800
Message-Id: <1540569671-6589-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9057 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=563
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

The 1st patch refactors the code of issue request directly.
It merges the blk_mq_try_issue_directly and __blk_mq_try_issue_directly
and make blk_mq_try_issue_directly handle return value of .queue_rq itself.

The 2nd patch make blk_mq_sched_insert_requests issue request directly with
bypass "false" instead of the "true", then needn't to handle the non-issued
requests any more.

The 3rd patch ensures the hctx to be ran on its mapped cpu in issue directly
path.

V2:
 - Add 1st and 2nd patch.

Jianchao Wang(3)
    blk-mq: refactor the code of issue request directly
    blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests
    blk-mq: ensure hctx to be ran on mapped cpu when issue

 block/blk-mq-sched.c |   8 ++--
 block/blk-mq.c       | 128 ++++++++++++++++++++++++---------------------------
 2 files changed, 63 insertions(+), 73 deletions(-)
