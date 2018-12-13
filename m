Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8ECC67873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FC421104
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675329;
	bh=59NPg5PfjOOqsOGAq6sevnI+rCa6TrmpyOnsMSJgqP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PHnhm+QyDFJXVYOirlaoiJ0TNQZISv6HhWYj1bcdUPn+rG+kZYap7rq3p0Pb+ePnd
	 Xv6Dx5zB8BrtSFGs73aVyvIVvju9LE+nTlRccN9cGbAmPMeOT1HvKaA9mMRl9x7Ecu
	 laVkIVtrRkeGQOKJtRgyemGojxiEAYcBCnxsKyI4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FC421104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeLME2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:28:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbeLME2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:28:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA604208E7;
        Thu, 13 Dec 2018 04:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675324;
        bh=59NPg5PfjOOqsOGAq6sevnI+rCa6TrmpyOnsMSJgqP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFHNfJgCY791l4JsEe76ciI+Zf7l/Zpz2QQdtF7k8A91op6CDyuRbvrwev68sQ0EI
         MobO+gudRwl78yNhTr49WGl1ncf8bO96spSX8vZRpu4vhP+3+dLy9djUD9RLfQCYcc
         RMLsiw1mern6oPv/mR0BHJzAL8UNXe+S+LpIDrgE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fred Herard <fred.herard@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 04/73] scsi: libiscsi: Fix NULL pointer dereference in iscsi_eh_session_reset
Date:   Wed, 12 Dec 2018 23:27:29 -0500
Message-Id: <20181213042838.75160-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fred Herard <fred.herard@oracle.com>

[ Upstream commit 5db6dd14b31397e8cccaaddab2ff44ebec1acf25 ]

This commit addresses NULL pointer dereference in iscsi_eh_session_reset.
Reference should not be made to session->leadconn when session->state is
set to ISCSI_STATE_TERMINATE.

Signed-off-by: Fred Herard <fred.herard@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libiscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 93c66ebad907..f78d2e5c1471 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -2416,8 +2416,8 @@ int iscsi_eh_session_reset(struct scsi_cmnd *sc)
 failed:
 		ISCSI_DBG_EH(session,
 			     "failing session reset: Could not log back into "
-			     "%s, %s [age %d]\n", session->targetname,
-			     conn->persistent_address, session->age);
+			     "%s [age %d]\n", session->targetname,
+			     session->age);
 		spin_unlock_bh(&session->frwd_lock);
 		mutex_unlock(&session->eh_mutex);
 		return FAILED;
-- 
2.19.1

