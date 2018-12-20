Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE33C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DF421720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297687;
	bh=xnSwO6+akl+uM8tOLWQcjaIznTcnIDDFkgGu+ZkZNkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cs65YzCoftHD4o5RtM7OtL3PLVTjj+hnyDANLtwxkJbCH/S8dqVvQLpMc+a7w2Mfd
	 n5QD962CnYmKZ87gIjKI5GPA0vP4g2Ret5/WLFrJRxVOdlxMip3G6e3T5+87eySbPL
	 gZuI94AxgkBgDenykchzNHDnFkoVZS8L9k4g2SUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbeLTJV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730992AbeLTJVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65D9521720;
        Thu, 20 Dec 2018 09:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297683;
        bh=xnSwO6+akl+uM8tOLWQcjaIznTcnIDDFkgGu+ZkZNkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8OL41N+30Knct+H9xES6OlPXdmt9vVs3ob95dReS/LHJ3Ae8wqFrrb/uLgA9/3fz
         YBvze7gYOliAqgpNdmQusTJER54KP+QICipNM+D4ZG4iynR24H7JuX3IA8/INB0oel
         ghMGszvFU53PTIAgmY0U3xPxR7RYQ3nPnvWbNGXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fred Herard <fred.herard@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 19/40] scsi: libiscsi: Fix NULL pointer dereference in iscsi_eh_session_reset
Date:   Thu, 20 Dec 2018 10:18:31 +0100
Message-Id: <20181220085827.234545968@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index a74f8fbefd33..009a2ef829d6 100644
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



