Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733C7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415DC206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q44yXeXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeLXAmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 19:42:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47460 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeLXAmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 19:42:12 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBO0Z6xc160893;
        Mon, 24 Dec 2018 00:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=TFbPGvHFSi2VVGZ5q2cy42u5ssWdCr3S4h4mDrKTSig=;
 b=q44yXeXYWJt8eL7KlZ1Yxuhsgcj4G+bXrtYZpOtrWaPSKBRsD8CU1WwCMQavAJKEWlJG
 6UXybSkygSxzF0Y6x7SwTbhp7VK/ovj7Gf8nmyGCGR1J1IJvMLufubmuaGytKBuG9YdA
 u9UIEmvp0SBNSGMrjXkiym3TDuRIDK/3ludzbZCtDMOvRlsZ0rV/F9PAxXV4GbsbXE0V
 Ct+3PbLB1f1NqcbY2Np5MwVgVmJOHa7AaRHAy8UesMMm1pY8f+vDsjgYP/23ntGMVsSi
 +s1HTdkO5pUGwCLtLex8zKOwIpHTcvUvnMeMqxk/6YD5CP6yTtSp/DnSfNUYopV5smtJ FQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2phasdk624-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Dec 2018 00:42:08 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBO0g6hZ026589
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Dec 2018 00:42:06 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBO0g5lv001919;
        Mon, 24 Dec 2018 00:42:05 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Dec 2018 16:42:05 -0800
Date:   Sun, 23 Dec 2018 16:42:04 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net
Subject: [GIT PULL] iomap: updates for v4.21
Message-ID: <20181224004204.GL27208@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9116 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=829
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812240003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a fix for a memory overflow bug in the iomap code for 4.21-rc1.
It has undergone the usual testing regimen and merges cleanly with 4.20
final.  Let me know if you encounter any problems with the merge.

--D

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-4.21-merge-2

for you to fetch changes up to 3cc31fa65d85610574c0f6a474e89f4c419923d5:

  iomap: don't search past page end in iomap_is_partially_uptodate (2018-12-21 08:42:50 -0800)

----------------------------------------------------------------
Updates for 4.21:
- Fix a memory overflow bug for blocksize < pagesize

----------------------------------------------------------------
Eric Sandeen (1):
      iomap: don't search past page end in iomap_is_partially_uptodate

 fs/iomap.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)
