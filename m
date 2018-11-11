Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4B8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA1F20866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v7M9XjQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA1F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeKLIRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731856AbeKLIRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:43 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECDA722353;
        Sun, 11 Nov 2018 22:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975268;
        bh=L7DqfjicCa8Ybo5qFIwZRFazqISozngey83K/rJezIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v7M9XjQhFQ/xSf1C0PDaMYdyguhGJTOByI1QcgRS4oN56VLqsO7RcJmoA2JHWAt0I
         csiA6KD22tbPfyT6hJYmtQrOWOolbWMfjOm0VRyr2TCFq2o7PFkdltw0cMQDhyE8rU
         lPCqTTN+1I4rkwQaz07WHSRzfmPjqPbrq21Qs/JQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gioh Kim <gi-oh.kim@profitbricks.com>,
        Guoqing Jiang <gqjiang@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 162/361] MD: fix invalid stored role for a disk
Date:   Sun, 11 Nov 2018 14:18:29 -0800
Message-Id: <20181111221643.157084537@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1776,6 +1776,10 @@ static int super_1_validate(struct mddev
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


