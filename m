Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B770FC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC0220890
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wU20M5WV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC0220890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeJVShj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbeJVShi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:37:38 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00B392088F;
        Mon, 22 Oct 2018 10:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203583;
        bh=3hVpM/G/+WQEQ9ApbBe7g1nwkD0UMLMpGuA5u7EFI8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wU20M5WVAZDiPzBClQMwUtNwJh9ZeWVQBO4mqwO3OxGfzjo8XFFu+fjayR/cDlVyX
         DjxGaCoT/T27wtPw8dzaJU+PnVY2qIrXsQ21IUmIk8D1B6YEzbugpL9wWUQD1klAg+
         NXOiJPUnjqiRYpczB6l4FZj5u+tv8Mrf69rzvvuU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 08/27] Input: evdev - add a schedule point in evdev_write()
Date:   Mon, 22 Oct 2018 06:19:05 -0400
Message-Id: <20181022101924.40531-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022101924.40531-1-sashal@kernel.org>
References: <20181022101924.40531-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 36d2582ff235b4e01ad64a734c877a52dc762d9c ]

Large writes to evdev interface may cause rcu stalls. Let's add
cond_resched() to the loop to avoid this.

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/evdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index c81c79d01d93..718d5622267d 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -564,6 +564,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 
 		input_inject_event(&evdev->handle,
 				   event.type, event.code, event.value);
+		cond_resched();
 	}
 
  out:
-- 
2.17.1

