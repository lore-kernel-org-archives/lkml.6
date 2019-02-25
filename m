Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B23BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2581217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130316;
	bh=69jrz7XkGRJH52xw5E540A9569TqnzOo+auxBfe7Ulg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FzitcblEeBmt2EBUK/aMO1xtkc2oaxxbfaxizKNYdvwRYzNPCBiXJZUtMUeFkYD66
	 h1UyxJNHrynfNAj660j7U4NtF2zVl/LON6Ih9GCVghJM+nUmcd8Oa7gCsiQvAmGV7r
	 W4OfrxZqV+mBQZY9PSWpXOazriUbEB3rywY8fj7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbfBYVby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:31:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732086AbfBYVbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:31:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90D0F21848;
        Mon, 25 Feb 2019 21:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130309;
        bh=69jrz7XkGRJH52xw5E540A9569TqnzOo+auxBfe7Ulg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hydHrs5i4aeNfFFIAQ8wQ3NONvcQHNVc5HXGPgRyIw0NOHMN8PMNjAodwm0bGbcI+
         eCERnUXcxSl4vJmN5RdWhVZxvjx9/i/8r5XCl4DJsTqE3Pky6/AcfDladiQRjgG3gn
         bGapI1JK2ViULLMnILrox3jbaMxqjuUfxv9czDwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 080/183] scsi: ufs: Fix geometry descriptor size
Date:   Mon, 25 Feb 2019 22:10:53 +0100
Message-Id: <20190225195107.955624018@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9be9db9f78f52ef03ee90063730cb9d730e7032b ]

Albeit we no longer rely on those hard-coded descriptor sizes, we still use
them as our defaults, so better get it right. While adding its sysfs
entries, we forgot to update the geometry descriptor size. It is 0x48
according to UFS2.1, and wasn't changed in UFS3.0.

[mkp: typo]

Fixes: c720c091222e (scsi: ufs: sysfs: geometry descriptor)
Signed-off-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 58087d3916d05..5417ce09b1054 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -195,7 +195,7 @@ enum ufs_desc_def_size {
 	QUERY_DESC_CONFIGURATION_DEF_SIZE	= 0x90,
 	QUERY_DESC_UNIT_DEF_SIZE		= 0x23,
 	QUERY_DESC_INTERCONNECT_DEF_SIZE	= 0x06,
-	QUERY_DESC_GEOMETRY_DEF_SIZE		= 0x44,
+	QUERY_DESC_GEOMETRY_DEF_SIZE		= 0x48,
 	QUERY_DESC_POWER_DEF_SIZE		= 0x62,
 	QUERY_DESC_HEALTH_DEF_SIZE		= 0x25,
 };
-- 
2.19.1



