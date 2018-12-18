Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E83C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A967B218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151213;
	bh=SrjNqVI9Eh1D61pvyOTeVbgYkhKib5x0jyhqYVWTOtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I67u8mP7rsDMKkJnGuLsRLL+AZ3UspNv+JKbhWSRshSUwkZLIl93VZWahDjoeneYE
	 zfFRwE/jCfdMwT/WOcHatqjucInvrU13C1oAvqZgqNmv0ALlnX7ZaNqEaae6Wm/IsL
	 CQyXa9lny3uzkUfnn/RYvL4uLvz+Fi2raTCDZUhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeLRQkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeLRQkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D4D9218A6;
        Tue, 18 Dec 2018 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151209;
        bh=SrjNqVI9Eh1D61pvyOTeVbgYkhKib5x0jyhqYVWTOtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5qvY1aghMYXP7nAOGx5TNkfxTbRpBadC2ji2VBujDv5IQbbb3aQKh4bBWByJCR6e
         yCSQvMJWLnfp0n/uWsNnfBSjnISBFeVAQmA341kVHf1Tz0+kbt/fRPpVGjqE8gtr8r
         npcKeiakVRpAjpZCA1NdHIHlu5F1hMWBW/weyhew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 02/44] scsi: raid_attrs: fix unused variable warning
Date:   Tue, 18 Dec 2018 17:39:14 +0100
Message-Id: <20181218163927.395125602@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit 0eeec01488da9b1403c8c29e73eacac8af9e4bf2 upstream.

I ran into a new warning on randconfig kernels:

drivers/scsi/raid_class.c: In function 'raid_match':
drivers/scsi/raid_class.c:64:24: error: unused variable 'i' [-Werror=unused-variable]

This looks like a very old problem that for some reason was very hard to
run into, but it is very easy to fix, by replacing the incorrect #ifdef
with a simpler IS_ENABLED() check.

Fixes: fac829fdcaf4 ("[SCSI] raid_attrs: fix dependency problems")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/raid_class.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index ea88906d2cc5..5c3d6e1e0145 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -63,8 +63,7 @@ static int raid_match(struct attribute_container *cont, struct device *dev)
 	 * emulated RAID devices, so start with SCSI */
 	struct raid_internal *i = ac_to_raid_internal(cont);
 
-#if defined(CONFIG_SCSI) || defined(CONFIG_SCSI_MODULE)
-	if (scsi_is_sdev_device(dev)) {
+	if (IS_ENABLED(CONFIG_SCSI) && scsi_is_sdev_device(dev)) {
 		struct scsi_device *sdev = to_scsi_device(dev);
 
 		if (i->f->cookie != sdev->host->hostt)
@@ -72,7 +71,6 @@ static int raid_match(struct attribute_container *cont, struct device *dev)
 
 		return i->f->is_raid(dev);
 	}
-#endif
 	/* FIXME: look at other subsystems too */
 	return 0;
 }
-- 
2.19.1



