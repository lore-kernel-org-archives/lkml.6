Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeA3N0e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:26:34 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41732 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbeA3N0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:26:17 -0500
X-Google-Smtp-Source: AH8x224wmH+JpvYi4ThR2lUxn32L5nQJgEfQDjJG6eU+SlyoQaDJodCKm+656bhndyB3oZTV1+gcFQ==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 2/2] lightnvm: remove multiple groups in 1.2 data structure
Date: Tue, 30 Jan 2018 14:26:05 +0100
Message-Id: <20180130132605.28635-2-m@bjorling.me>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180130132605.28635-1-m@bjorling.me>
References: <20180130132605.28635-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only one id group from the 1.2 specification is supported. Make
sure that only the first group is accessible.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/nvme/host/lightnvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 16906327645e..e5544806fb0e 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -167,7 +167,8 @@ struct nvme_nvm_id {
 	__le32			dom;
 	struct nvme_nvm_addr_format ppaf;
 	__u8			resv[228];
-	struct nvme_nvm_id_group groups[4];
+	struct nvme_nvm_id_group group;
+	__u8			resv2[2880];
 } __packed;
 
 struct nvme_nvm_bb_tbl {
@@ -209,7 +210,7 @@ static int init_grps(struct nvm_id *nvm_id, struct nvme_nvm_id *nvme_nvm_id)
 	if (nvme_nvm_id->cgrps != 1)
 		return -EINVAL;
 
-	src = &nvme_nvm_id->groups[0];
+	src = &nvme_nvm_id->group;
 	grp = &nvm_id->grp;
 
 	grp->mtype = src->mtype;
-- 
2.11.0
