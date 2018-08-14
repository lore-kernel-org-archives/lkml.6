Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95AEC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F62D208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=makelinux.com header.i=@makelinux.com header.b="nlwCkg/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F62D208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=MakeLinux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeHOAhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:37:47 -0400
Received: from bosmailout06.eigbox.net ([66.96.188.6]:52791 "EHLO
        bosmailout06.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbeHOAhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:37:47 -0400
X-Greylist: delayed 1808 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Aug 2018 20:37:46 EDT
Received: from bosmailscan11.eigbox.net ([10.20.15.11])
        by bosmailout06.eigbox.net with esmtp (Exim)
        id 1fpgi3-0007gc-Al; Tue, 14 Aug 2018 17:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=makelinux.com; s=dkim; h=Sender:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GBtGA2TgmyKJ1yg4632p8s+/UcZh8Cabn/wOcieVyQw=; b=nlwCkg/qAPvp3Upos4fa0Drj5
        GelGpKnv8isSVivmlKMl40eLfo+Luptiw9TZuTfqP4JYJiN7zzIbqlmj9ZlaNIaYGlbBU/5mAkjqX
        1R7ChqzNcusCYzxOScJPFSSelm5pFl8F/CM7Xc1Kp79AUWwgXX8ZT+9sqCMjn2f6xGpMjqCGWpuyb
        JpAIZ9mhiybU7+y6XNwhG2X40WS+w7DttdtN5WEurGpFMIh10tBegv2L8PMO66SZoFe8QgeFSC4lZ
        jubiBDfkYcuyeYEbaY0LUp3r5nw8dyW+KKeya6z2RdsD1AuAVbEmUTA36QCLIIaX+Lct5eMeFUo0o
        0HPUk0jHA==;
Received: from [10.115.3.31] (helo=bosimpout11)
        by bosmailscan11.eigbox.net with esmtp (Exim)
        id 1fpgi3-00052N-7c; Tue, 14 Aug 2018 17:18:35 -0400
Received: from bosauthsmtp13.yourhostingaccount.com ([10.20.18.13])
        by bosimpout11 with 
        id P9JT1y0090GvDVm019JWoL; Tue, 14 Aug 2018 17:18:35 -0400
X-Authority-Analysis: v=2.2 cv=PN5/wbiC c=1 sm=1 tr=0
 a=UH8/iCWBfdUmbm4Ft4Vi3Q==:117 a=WFC+M0LbvcyalcFcVaxzsg==:17
 a=dapMudl6Dx4A:10 a=I7kt_hwf06sA:10 a=dSbym95GAAAA:8 a=2zjW_QlX0rfYgiC2WAIA:9
 a=eg0O5KPjxGrMl0Mu5AXQ:22
Received: from [77.139.214.119] (port=50384 helo=localhost.localdomain)
        by bosauthsmtp13.eigbox.net with esmtpa (Exim)
        id 1fpghv-0000xX-D3; Tue, 14 Aug 2018 17:18:27 -0400
From:   Constantine Shulyupin <const@MakeLinux.com>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk, corbet@lwn.net,
        liushuoran@jd.com, mitsuo.hayasaka.hu@hitachi.com,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Cc:     amir73il@gmail.com, Constantine Shulyupin <const@MakeLinux.com>
Subject: [PATCH v3 3/3] fuse: export pipe_max_size for max_pages
Date:   Wed, 15 Aug 2018 00:17:16 +0300
Message-Id: <20180814211717.22170-3-const@MakeLinux.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180814211717.22170-1-const@MakeLinux.com>
References: <20180814211717.22170-1-const@MakeLinux.com>
X-EN-UserInfo: 49eb4aefa70c42fb849786903cdd8376:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: smtp@makelinux.net
X-EN-OrigIP: 77.139.214.119
X-EN-OrigHost: unknown
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 fs/pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index bb0840e234f3..4990d92b0849 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -34,6 +34,7 @@
  * be set by root in /proc/sys/fs/pipe-max-size
  */
 unsigned int pipe_max_size = 1048576;
+EXPORT_SYMBOL(pipe_max_size);
 
 /* Maximum allocatable pages per user. Hard limit is unset by default, soft
  * matches default values.
-- 
2.17.1

