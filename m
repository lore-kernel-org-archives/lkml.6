Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E409C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C8D20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsMsMVen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C8D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeLJXwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:52:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33191 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeLJXwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:52:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so12312450wrr.0;
        Mon, 10 Dec 2018 15:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+msshKRQa9KDUGPA8ZgyKltmv5EfKoaQ+nuFeBBxXDA=;
        b=rsMsMVenPGicFCKYkJa7/Yxwq2zhAqpfjqWGRgrhwayc31uV9Krap45+zHnlOEg8sc
         KQDhjKJWYSEQvWF/i1R6FUA09WuN0vuwA8V/XE+sW1frxJ0j9zFiC2Y3GQKUfCULOxPQ
         FnJ3IYEw8Qq7ucY7DnbpGJEFvChQb0hwi5w0riBPNF9QREDp6Do99JZH/mWXbMpuLHd9
         nJXUIStBDn2USHHu/5lXAK89louQP5uI8SeIdFVBoMqThCAuJYtyWVbHXFF0Wh5XF9gJ
         AKQxCUcfyWwMiPsoU5DImhDHaA4+fIYAIAb/484xM8uGDj8trjxT7xFzaGytvHPYQg5C
         CagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+msshKRQa9KDUGPA8ZgyKltmv5EfKoaQ+nuFeBBxXDA=;
        b=l8cc5hOvQ4tJ5UlKpeCoXkXCrVdhTYnKeh9HiD6dkjIUdwcT6L2403YJoStjOWatKn
         lUR+FyWrD81Sjl4BEObajG2ENxvMxO6GlRPUMDUslnWUovRisDxpW9muWXYMCr8FtNkV
         xfkOLTbFeyLZhTjVcNOQf9v3nWl0vRkPYfQx0J1CR4e3c6DMnsXCk0db6NF4HBWjFx0j
         m36OyhxtVyRkbkKLzH54kNI9Wz9RGeOhK8A2SKqrFATRnpfFNvz0lAYF+xABXQOpXHN+
         cd5AJkeVbjjhqPtq/fdRSfddnRiNcklobvlizeXBtc5d+irP6uvYEKYekEmoBS3ZA9K4
         vVIg==
X-Gm-Message-State: AA+aEWZNhYUZDpK52dOJMNbYhB/p4AXKIZmyX8slBGu8Og0YYYqwk01U
        Dhke8701SvBZGVN4bkqGsoI=
X-Google-Smtp-Source: AFSGD/VAV0d2PpjlvvpsPltUc6vrbslwGrvngy7XafxAI+pQmC3FU7z0v1HZUF18y9ZvIVWfLVvyrg==
X-Received: by 2002:adf:b716:: with SMTP id l22mr12161765wre.186.1544485928370;
        Mon, 10 Dec 2018 15:52:08 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c10sm12186461wrw.49.2018.12.10.15.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 15:52:07 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     GOTO Masanori <gotom@debian.or.jp>,
        YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: nsp32: Remove unnecessary self assignment in nsp32_set_sync_entry
Date:   Mon, 10 Dec 2018 16:51:56 -0700
Message-Id: <20181210235156.6237-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/scsi/nsp32.c:2444:14: warning: explicitly assigning value of
variable of type 'unsigned char' to itself [-Wself-assign]
        offset      = offset;
        ~~~~~~      ^

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/nsp32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
index 5aac3e801903..7ce6e7acf2f3 100644
--- a/drivers/scsi/nsp32.c
+++ b/drivers/scsi/nsp32.c
@@ -2441,7 +2441,6 @@ static void nsp32_set_sync_entry(nsp32_hw_data *data,
 
 	period      = data->synct[entry].period_num;
 	ackwidth    = data->synct[entry].ackwidth;
-	offset      = offset;
 	sample_rate = data->synct[entry].sample_rate;
 
 	target->syncreg    = TO_SYNCREG(period, offset);
-- 
2.20.0

