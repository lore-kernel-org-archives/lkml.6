Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7481C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7845820851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0rHjzJ1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7845820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeLDLYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:24:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeLDLBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B60214DA;
        Tue,  4 Dec 2018 11:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921283;
        bh=6pkergr0Rc2GlUNKETl0mMF3CTcN8ft94xSI0RWeG4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0rHjzJ1INKLYmjVFKrF3p3OGCgFsv8NDc51JAEPiMVVOb+RM7yi6Gals/kKIcy81X
         MbTH+XVCYcyyI8MJbJUKElJYVazySMn7Gzh1NOGvhQbcweLpNJodbvX4p9lmzwGWo2
         heyHKy+Y4Cdbd0JwxCHYU/oh3pMEcBkeLP7QQ+n0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Lachmann, Juergen" <juergen.lachmann@harman.com>,
        Richard Weinberger <richard@nod.at>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 012/146] ubi: Initialize Fastmap checkmapping correctly
Date:   Tue,  4 Dec 2018 11:48:18 +0100
Message-Id: <20181204103727.292000416@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 25677478474a91fa1b46f19a4a591a9848bca6fb upstream

We cannot do it last, otherwithse it will be skipped for dynamic
volumes.

Reported-by: Lachmann, Juergen <juergen.lachmann@harman.com>
Fixes: 34653fd8c46e ("ubi: fastmap: Check each mapping only once")
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/ubi/vtbl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
index 94d7a865b135..7504f430c011 100644
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -578,6 +578,16 @@ static int init_volumes(struct ubi_device *ubi,
 		vol->ubi = ubi;
 		reserved_pebs += vol->reserved_pebs;
 
+		/*
+		 * We use ubi->peb_count and not vol->reserved_pebs because
+		 * we want to keep the code simple. Otherwise we'd have to
+		 * resize/check the bitmap upon volume resize too.
+		 * Allocating a few bytes more does not hurt.
+		 */
+		err = ubi_fastmap_init_checkmap(vol, ubi->peb_count);
+		if (err)
+			return err;
+
 		/*
 		 * In case of dynamic volume UBI knows nothing about how many
 		 * data is stored there. So assume the whole volume is used.
@@ -620,16 +630,6 @@ static int init_volumes(struct ubi_device *ubi,
 			(long long)(vol->used_ebs - 1) * vol->usable_leb_size;
 		vol->used_bytes += av->last_data_size;
 		vol->last_eb_bytes = av->last_data_size;
-
-		/*
-		 * We use ubi->peb_count and not vol->reserved_pebs because
-		 * we want to keep the code simple. Otherwise we'd have to
-		 * resize/check the bitmap upon volume resize too.
-		 * Allocating a few bytes more does not hurt.
-		 */
-		err = ubi_fastmap_init_checkmap(vol, ubi->peb_count);
-		if (err)
-			return err;
 	}
 
 	/* And add the layout volume */
-- 
2.17.1



