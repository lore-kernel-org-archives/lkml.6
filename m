Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3462C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94CD20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8YAQfy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94CD20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeJVSjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbeJVSjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:39:39 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69F7D2088F;
        Mon, 22 Oct 2018 10:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203704;
        bh=oHtvCnO5jYWTa5t3fEx/PrxOW1HE33JPP7mCRb45+zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8YAQfy8gaxPCHx+JohOv3dKg7jndkTEvBI0Qp/ZvbbErtWBNRem1gKk9u1SUzpXT
         S1j1H7Cv3Js/q5Se8rN7xrSaAKn2rf3EBfgsn32IpAUozTkwV184gexRqHkkKZQkk/
         lnhanQG0hAfM3swRvPZm7memvir2T23xY0aGu+4E=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 4/9] Input: uinput - add a schedule point in uinput_inject_events()
Date:   Mon, 22 Oct 2018 06:21:28 -0400
Message-Id: <20181022102133.41222-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022102133.41222-1-sashal@kernel.org>
References: <20181022102133.41222-1-sashal@kernel.org>
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
index 022be0e22eba..d015fd7151c1 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -540,6 +540,7 @@ static ssize_t uinput_inject_events(struct uinput_device *udev,
 
 		input_event(udev->dev, ev.type, ev.code, ev.value);
 		bytes += input_event_size();
+		cond_resched();
 	}
 
 	return bytes;
-- 
2.17.1

