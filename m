Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD43C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3777520879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675465;
	bh=p/6wj75Vxnkm/+R2e+u3ZQz1C2Kt14aZW+OcNR6K3zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kwY2+E1NZpBl+YAtc1zi6iRWAP3pyRWZMZ9tq4WmnyqihgJ6Is65sLFFZk32qJv8F
	 /9+UV0uagCmWKeFDQOEriWN7Kq4adxVKulvq9nMz1wGc2P+OJEdpBEAEW0oIvFmiU9
	 D5FAP4vlphRCL7A+xiazkIEsUAbtV3VmY2PDiem0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3777520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeLMEbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:31:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbeLMEa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9211920882;
        Thu, 13 Dec 2018 04:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675458;
        bh=p/6wj75Vxnkm/+R2e+u3ZQz1C2Kt14aZW+OcNR6K3zY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqfxaGDZ8DjU/3ePLFWsDL2VQmHr8yc/KERxpZaOsnz+XKUvd+LwYSBe7hHGbjs8x
         qgL/2KfR0tkzdCP39OoWQ677n18J1i04LD9CAcpTRMdzgBlS9Hlr4r1ez9a+Qt+E5A
         vDeJ3e2Ash5ZTOUzsst4shAWAgf3j9DisvtQdN9I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fred Herard <fred.herard@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/41] scsi: libiscsi: Fix NULL pointer dereference in iscsi_eh_session_reset
Date:   Wed, 12 Dec 2018 23:30:16 -0500
Message-Id: <20181213043054.75891-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
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
index cf8a15e54d83..3ff536b350a1 100644
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

