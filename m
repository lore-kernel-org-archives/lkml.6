Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226B5C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08F52087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="iRNLTKAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08F52087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeJEAXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:23:18 -0400
Received: from [103.7.29.155] ([103.7.29.155]:50774 "EHLO smtpbg64.qq.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727407AbeJEAXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:23:18 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Oct 2018 20:23:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1538674119;
        bh=q5J3fTBYBfLVacWSewOnuui65PxXgU1hTmbQtzEPkT0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=iRNLTKARUbaS4IeSqJNsinKlHA1B3KmbDonl/EK95JEwacH3LpxUsJvcITJIEOUTn
         wgk/eib6DLAwcFDrl1IvBLfB86GVANqG6sLZ1kJY3sMwFBgENiio69xblUIEuVDTL8
         WFwsbP+veWf1y9JUNyty8e+kt9r79O0MzJwsY0kw=
X-QQ-mid: esmtp5t1538673666tquy6ek8g
Received: from chenchacha.lan (unknown [111.199.190.105])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 05 Oct 2018 01:21:02 +0800 (CST)
X-QQ-SSF: 00000000000000F0FI100F00000000R
X-QQ-FEAT: Ngtn/3KK5eqNU5aIYCHkR9+rCrWCKESfBW/ZfMY+QXXRs2ozxq+pBWRY8BLzi
        Rew/qOm/5kduBYAC8vKNop20KnELDuImqeqI1dyCzbwDxQU7x6whhNd5oPzYyZxOU2/tvQ2
        V6p98TjzLbTCv/sKwPu1iy7Y1cLQWLUrFQTqMDCEHLerngozmjfXrXpLHg8TMhGYOZoefjt
        UvcwxNiWwxr0reNXgokNOgVDjJXUKv7bD11JPFlXCp0Xa05yj1aAdm4s7EerkMMpWmmCvoI
        NBZaZxu8HsX0wOQxqXQMcF7yM=
X-QQ-GoodBg: 0
From:   chenchacha <chen.chenchacha@foxmail.com>
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        pali.rohar@gmail.com
Subject: [PATCH 0/2] fs: fat: add ioctl method to read voluem label in fat filesystem driver
Date:   Fri,  5 Oct 2018 01:20:59 +0800
Message-Id: <20181004172101.15525-1-chen.chenchacha@foxmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgweb:bgweb115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add fat ioctl command FAT_IOCTL_GET_VOLUME_LABEL.

We can get the volume label with this command:

	ioctl(fd, FAT_IOCTL_GET_VOLUME_LABEL, &volume_label);

FAT volume label (volume name) is exactly same stored in boot sector and root
directory. And this patch read label only from the root directory. If label in
root directory is missing then disk would be treated as without label. Label
from boot sector would not be read.

The volume label format reference from Pali Rohár testing results
(https://www.spinics.net/lists/kernel/msg2645732.html) in the previous mail.

chenchacha (2):
  Add FAT_IOCTL_GET_VOLUME_LABEL in fat_generic_ioctl()
  Add a new function to get root directory with ATTR_VOLUME

 fs/fat/dir.c                  | 13 +++++++++++++
 fs/fat/fat.h                  |  2 ++
 fs/fat/file.c                 | 22 ++++++++++++++++++++++
 include/uapi/linux/msdos_fs.h |  1 +
 4 files changed, 38 insertions(+)

-- 
2.19.0

