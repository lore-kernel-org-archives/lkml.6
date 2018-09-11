Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF511C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D742086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D742086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeIKXGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:06:16 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39115 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIKXGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:06:16 -0400
Received: by mail-qt0-f196.google.com with SMTP id o15-v6so29210530qtk.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=frRqL3gXTVynBijbSg3IhiObefKTSIflFFkVaehCekg=;
        b=Krf9G6ZRb8+78+ni1uTMR2q4C9L3FuBKx03TW3/2+X8sEfa++lJtT7y1NUjytlMm+f
         qjU3q3/C4v9NRQCOBFhL7dtRf3MsAJCj/l5iQPISGMUoue+c1m6g/pfw/uq2FFDQy3jr
         GZ63yEehLFgnv97IFpkpfrhtUswR1QfcTPJrnwFIV/I72XTAaX8o3oPb4V1r2cLhwUtv
         SFHnVCVK61DoRYlaqs36aAMmYRgCafQ7cJjnNjx7BGRlWLSXGxG+N/NBKqcso2HJ/omh
         FnLuAgGtdbzxK9bmcW3u8FAqaTmUgX37vMnL2FuzzBX9ACIWU50uNIFyxlGxLa6PzSJ0
         OYxw==
X-Gm-Message-State: APzg51BgK2xTI5mKrEl/MnXdhEWpF0UF3r5k4rVVCPLNE9VgWXVj9s6u
        hjAlKoOSVdSJDLe45nECTDzZ0w==
X-Google-Smtp-Source: ANB0VdbhjY7la/0YpYC7b48xbdqfJo4JCXtw9hLBDmsR97vKOa4y62zr3ftarc9cyPhVTcpeGT0twg==
X-Received: by 2002:a0c:b584:: with SMTP id g4-v6mr19486585qve.94.1536689148808;
        Tue, 11 Sep 2018 11:05:48 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::42c3])
        by smtp.gmail.com with ESMTPSA id i19-v6sm184875qtf.87.2018.09.11.11.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 11:05:47 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCHv2] scsi: ibmvscsis: Fix a stringop-overflow warning
Date:   Tue, 11 Sep 2018 11:05:42 -0700
Message-Id: <20180911180542.7778-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There's currently a warning about string overflow with strncat:

drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_probe':
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3479:2: error: 'strncat' specified
bound 64 equals destination size [-Werror=stringop-overflow=]
  strncat(vscsi->eye, vdev->name, MAX_EYE);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Switch to a single snprintf instead of a strcpy + strcat to handle this
cleanly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Swtich to using snprintf per suggestion of Kees
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index fac377320158..9305440a00a1 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3474,8 +3474,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
 		vscsi->dds.window[LOCAL].liobn,
 		vscsi->dds.window[REMOTE].liobn);
 
-	strcpy(vscsi->eye, "VSCSI ");
-	strncat(vscsi->eye, vdev->name, MAX_EYE);
+	snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI%s", vdev->name);
 
 	vscsi->dds.unit_id = vdev->unit_address;
 	strncpy(vscsi->dds.partition_name, partition_name,
-- 
2.17.1

