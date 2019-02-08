Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7B9C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC3C2147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TnT50oi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBHHZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:25:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50074 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfBHHZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:25:30 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x187NxQC188231;
        Fri, 8 Feb 2019 07:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=geF/3jJl7XuabR8YMzSfPsiDbRrTM8ihdKE7E2zArws=;
 b=TnT50oi5IxMACmKDpE1xPqSb9G6AaHybCTr1iib7zh9jTw6+18YxKqWNatdOGZC3oFoq
 OF6+boAZn9yp6WwuwuB91mtipYBP0HhNtujGLQ6EtmlMYtRSsN7qAFGhXc/GYgRc3wti
 v3GL6OOOk5z8CbJU75Q9oxTdD/A0zNs2O7MDIAcw7vGtSmzUi8SXPbDQWqgRFmvpK0mt
 2ZgO7jyDhFsaZKuiWXkQ/I1ss3yV4Zz1QfwS4SN5+1MMmPzLxRRfvyPN5cj5uGTEFblj
 mcqtty1Q9rF1T61715LDku4hKKyjoBV3PUPpcEaIWC4baZ5M8TELGQ30gApd9U71broX QQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qd97fb1qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Feb 2019 07:25:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x187PLfg009116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 07:25:21 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x187PJp1001511;
        Fri, 8 Feb 2019 07:25:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Feb 2019 23:25:19 -0800
Date:   Thu, 7 Feb 2019 23:25:17 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for v5.0-rc6
Message-ID: <20190208072517.GL7991@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9160 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902080054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are a handful of XFS fixes to fix a data corruption problem, a
crasher bug, and a deadlock.  It merged cleanly against this morning's
master, so please let me know if you encounter any problems.

--D

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.0-fixes-1

for you to fetch changes up to add46b3b021263c02d5a7080c58e5b459479fafd:

  xfs: set buffer ops when repair probes for btree type (2019-02-03 14:03:59 -0800)

----------------------------------------------------------------
Changes since last update:
- Fix cache coherency problem with writeback mappings
- Fix buffer deadlock when shutting fs down
- Fix a null pointer dereference when running online repair

----------------------------------------------------------------
Brian Foster (2):
      xfs: eof trim writeback mapping as soon as it is cached
      xfs: end sync buffer I/O properly on shutdown error

Darrick J. Wong (1):
      xfs: set buffer ops when repair probes for btree type

 fs/xfs/scrub/repair.c | 11 ++++++++---
 fs/xfs/xfs_aops.c     |  2 ++
 fs/xfs/xfs_buf.c      | 19 +++++++++++++++++--
 3 files changed, 27 insertions(+), 5 deletions(-)
