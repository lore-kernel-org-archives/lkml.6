Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B774DC7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAD920652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgE2J7fY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAD920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbeJVSlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbeJVSlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:41:06 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B9642089E;
        Mon, 22 Oct 2018 10:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203790;
        bh=GEKvDTtp22vLHOmyh//VRUBTXUGxkYeVzlCqcm0dJu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgE2J7fYRUKzqKkwGi2PFYteHm41WcisHiC2Zp3q23N67fv+dLzNyfVBQe7/CNF7W
         JTChSFzrF5JlFhcupWgFvRqr5OT6tnsWhRZipmzqWJ5nv1Mm3O2tQcM8IAwfEilzuK
         puCKyKSVMayVt96duPfdnh+ReZaIU4Qd54yle2Zc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 3/4] Input: uinput - add a schedule point in uinput_inject_events()
Date:   Mon, 22 Oct 2018 06:22:54 -0400
Message-Id: <20181022102255.41695-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022102255.41695-1-sashal@kernel.org>
References: <20181022102255.41695-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit cecf10704899467a787975e3d94a1f0129b9688e ]

Large writes to uinput interface may cause rcu stalls. Let's add
cond_resched() to the loop to avoid this.

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/uinput.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 5221450f9b57..0cc05a4cf685 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -456,6 +456,7 @@ static ssize_t uinput_inject_events(struct uinput_device *udev,
 
 		input_event(udev->dev, ev.type, ev.code, ev.value);
 		bytes += input_event_size();
+		cond_resched();
 	}
 
 	return bytes;
-- 
2.17.1

