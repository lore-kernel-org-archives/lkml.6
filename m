Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D19ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFF120664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkYiW/up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFF120664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbeKAIMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732087AbeKAIMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:12:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F29BA20866;
        Wed, 31 Oct 2018 23:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027520;
        bh=3xpQZJCx40UoNE4KL5N+S3vXKm2D2UT1sWsJ54KK2ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkYiW/upYIXLJGYFX7vSi8i5Nbln9jzfOnm/CDG47lYX1gq5zvkVKO04rI2ObfBI7
         JiAAyKuHX/La5YJJBAszp7K4Gz5UUHuphWYdDOPXXzR7QxezK44jU5h53/i0OhAm3y
         Urk7zD4qmPGio41Zov2Nzl9HoQfPqxUDV/K0dgwc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shaohua Li <shli@fb.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 25/32] MD: fix invalid stored role for a disk
Date:   Wed, 31 Oct 2018 19:11:30 -0400
Message-Id: <20181031231137.29429-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231137.29429-1-sashal@kernel.org>
References: <20181031231137.29429-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaohua Li <shli@fb.com>

[ Upstream commit d595567dc4f0c1d90685ec1e2e296e2cad2643ac ]

If we change the number of array's device after device is removed from array,
then add the device back to array, we can see that device is added as active
role instead of spare which we expected.

Please see the below link for details:
https://marc.info/?l=linux-raid&m=153736982015076&w=2

This is caused by that we prefer to use device's previous role which is
recorded by saved_raid_disk, but we should respect the new number of
conf->raid_disks since it could be changed after device is removed.

Reported-by: Gioh Kim <gi-oh.kim@profitbricks.com>
Tested-by: Gioh Kim <gi-oh.kim@profitbricks.com>
Acked-by: Guoqing Jiang <gqjiang@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 07f307402351..4caf240693cd 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1670,6 +1670,10 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 			} else
 				set_bit(In_sync, &rdev->flags);
 			rdev->raid_disk = role;
+			if (role >= mddev->raid_disks) {
+				rdev->saved_raid_disk = -1;
+				rdev->raid_disk = -1;
+			}
 			break;
 		}
 		if (sb->devflags & WriteMostly1)
-- 
2.17.1

