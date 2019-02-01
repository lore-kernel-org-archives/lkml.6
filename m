Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9117C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D8721726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RXtfrcGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfBAQ4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:56:34 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37774 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfBAQ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:56:34 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x11Gs1en069483;
        Fri, 1 Feb 2019 16:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=TYpOYi5urIoUZ65KykyQGXWNi7wW2uUFuLVSD5poK9A=;
 b=RXtfrcGXoulDRgEosHmE7n1Pr6Odcb87YARqusH8fxNrQXRMyBUc6sV/T8ICnoHiUGEX
 BnC7wyxcUrxmAzKhYNy4yr9ckP8Avk0tZ1MKaKKdQerLm21M54g3sK/qIDfxnxWtbH98
 ZM5OJgFs3VpsHPcuKH0Q51nHrdb6WXQgnLnUaBd5Drfu/eaW38TVvB4LdYX5oewV4Ipp
 luBqKVCRh1A2OUFwrxpFi1z6JJj4SWdMj7bIBYHezNKE4ty2VrMXk3nM40h0rCTbEM8c
 nL6ddhEfkaWXUmJMo/ZR235rHU87zgyo5dBWGz7XstY6agwv5J2zB1kuB6adXK93w/yK ug== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2q8d2eqy7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Feb 2019 16:56:25 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x11GuIsF027113
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Feb 2019 16:56:18 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x11GuHKc014894;
        Fri, 1 Feb 2019 16:56:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Feb 2019 08:56:17 -0800
Date:   Fri, 1 Feb 2019 08:56:16 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] iomap: more fixes for v5.0
Message-ID: <20190201165616.GG5761@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9154 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=950 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902010124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are a couple of iomap fixes to eliminate some memory corruption
and hang problems that were reported.

--D

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.0-fixes-1

for you to fetch changes up to 4ea899ead2786a30aaa8181fefa81a3df4ad28f6:

  iomap: fix a use after free in iomap_dio_rw (2019-01-27 08:47:42 -0800)

----------------------------------------------------------------
Changes since last update:
- fix page migration when using iomap for pagecache management
- fix a use-after-free bug in the directio code

----------------------------------------------------------------
Christoph Hellwig (1):
      iomap: fix a use after free in iomap_dio_rw

Piotr Jaroszynski (1):
      iomap: get/put the page in iomap_page_create/release()

 fs/iomap.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)
