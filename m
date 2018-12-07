Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE132C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E93620882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E93620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbeLGBeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:34:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33911 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGBeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:34:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so2331928wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 17:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nXcyb4wVOdunexeWebf188Q6PWPhmCn4fAP7SIU9vc4=;
        b=ZvfKfpX+L4CMqTwV8k6ubNVbK1puXL04wWMMcMjdk24LQrb2aKs+A8Nkh5IPiH4jpz
         zqVx3XunlOdsmeWIErz5NbynxqAVsn0gPmlGNP2/Ni3CJw3GDxyK0/zrGwQr78Hm1Y7u
         rjgRk+1gGB/LDHssEVygRdIM+LDIIp0RafZgFbN3Sqh18Kea9q651+V/f9qAAVM8ghwY
         G3yb2yHJsQDF+qGBA5bPhvdpgg/PeRIa+5s27T8Khh+iaMLfBAao8fvRwjVVR8xvJJPI
         0nZijYPbaZ5hbkE1C8EkRnWuizItM1vkQCZ8bdFyMNCsJ6Pm/r+R9U2zMo7jbRBKOEng
         mVwA==
X-Gm-Message-State: AA+aEWZvDcQ/5M/f1f0eSnHmzYj2Q18d1sZgoBscxJSq4iA6xVkghnYh
        AldRobciqb+oFl7qtT6VzNG70N9gKHo=
X-Google-Smtp-Source: AFSGD/WIfooclz686i2pZTbPKMztkymU0eSXU6PD89nYsGWlsPfHOsFqrjOLJpwsZNie8RIGBdiW3A==
X-Received: by 2002:adf:f009:: with SMTP id j9mr185460wro.170.1544146452018;
        Thu, 06 Dec 2018 17:34:12 -0800 (PST)
Received: from raver.teknoraver.net (net-37-182-2-241.cust.vodafonedsl.it. [37.182.2.241])
        by smtp.gmail.com with ESMTPSA id j202sm4815675wmf.15.2018.12.06.17.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 17:34:10 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Timothy Redaelli <tredaelli@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vfat: don't read garbage after last dirent
Date:   Fri,  7 Dec 2018 02:34:10 +0100
Message-Id: <20181207013410.7050-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FAT32 File System Specification[1] states:

    If DIR_Name[0] == 0x00, then the directory entry is free, and there
    are no allocated directory entries after this one.

    The special 0 value, indicates to FAT file system driver code that
    the rest of the entries in this directory do notneed to be examined
    because they are all free.

This is not enforced by Linux, and is possible to read garbage if
not all the dirents after the last one are filled with zeroes.

[1] http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/fatgen103.doc

Reported-by: Timothy Redaelli <tredaelli@redhat.com>
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 fs/fat/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index c8366cb8eccd..0cec89271349 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -588,7 +588,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
 
 	bh = NULL;
 get_new:
-	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+	if (fat_get_entry(inode, &cpos, &bh, &de) == -1 || !de->name[0])
 		goto end_of_dir;
 parse_record:
 	nr_slots = 0;
-- 
2.19.2

