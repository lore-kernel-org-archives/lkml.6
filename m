Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6655CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D58820883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D58820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeKHHsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:48:50 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:38042 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbeKHHsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:48:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 075B818011A7A;
        Wed,  7 Nov 2018 23:16:26 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, thomas.roeder@harman.com,
        juergen.lachmann@harman.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] ubi: Introduce in_pq()
Date:   Wed,  7 Nov 2018 23:16:18 +0100
Message-Id: <20181107221619.32498-1-richard@nod.at>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function works like in_wl_tree() but checks whether an ubi_wl_entry
is currently in the protection queue.
We need this function to query the current state of an ubi_wl_entry.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/wl.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 6f2ac865ff05..ca1b31385eb5 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -277,6 +277,27 @@ static int in_wl_tree(struct ubi_wl_entry *e, struct=
 rb_root *root)
 	return 0;
 }
=20
+/**
+ * in_pq - check if a wear-leveling entry is present in the protection q=
ueue.
+ * @ubi: UBI device description object
+ * @e: the wear-leveling entry to check
+ *
+ * This function returns non-zero if @e is in the protection queue and z=
ero
+ * if it is not.
+ */
+static inline int in_pq(const struct ubi_device *ubi, struct ubi_wl_entr=
y *e)
+{
+	struct ubi_wl_entry *p;
+	int i;
+
+	for (i =3D 0; i < UBI_PROT_QUEUE_LEN; ++i)
+		list_for_each_entry(p, &ubi->pq[i], u.list)
+			if (p =3D=3D e)
+				return 1;
+
+	return 0;
+}
+
 /**
  * prot_queue_add - add physical eraseblock to the protection queue.
  * @ubi: UBI device description object
@@ -1848,16 +1869,11 @@ static int self_check_in_wl_tree(const struct ubi=
_device *ubi,
 static int self_check_in_pq(const struct ubi_device *ubi,
 			    struct ubi_wl_entry *e)
 {
-	struct ubi_wl_entry *p;
-	int i;
-
 	if (!ubi_dbg_chk_gen(ubi))
 		return 0;
=20
-	for (i =3D 0; i < UBI_PROT_QUEUE_LEN; ++i)
-		list_for_each_entry(p, &ubi->pq[i], u.list)
-			if (p =3D=3D e)
-				return 0;
+	if (in_pq(ubi, e))
+		return 0;
=20
 	ubi_err(ubi, "self-check failed for PEB %d, EC %d, Protect queue",
 		e->pnum, e->ec);
--=20
2.19.1

