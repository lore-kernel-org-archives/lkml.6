Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AD8C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0E620658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9BTVNSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0E620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbeJVSip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbeJVSio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:38:44 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0ABA20890;
        Mon, 22 Oct 2018 10:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203650;
        bh=fkQM5544zFxxcSLREdgFQWUe3wDDzPwnqfCt2ptZR+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9BTVNSvQ3nlh2ti1oLEto0FKenbOi6C/P/Notary8NgbRZGfG9atpmq4Azx6kBGi
         ZeiM9Wgt5vrlNNZBGM+si2k+PjSWldHAdqgoyIQebTq9J9f5mztEBnv8n+jtPeI6co
         IEHLb7+AGnnoD8PGR7utRNNZLKCgXxUietIxz0FY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 07/15] Input: uinput - add a schedule point in uinput_inject_events()
Date:   Mon, 22 Oct 2018 06:20:18 -0400
Message-Id: <20181022102026.40869-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022102026.40869-1-sashal@kernel.org>
References: <20181022102026.40869-1-sashal@kernel.org>
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
index 443151de90c6..13d17e85f2cf 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -561,6 +561,7 @@ static ssize_t uinput_inject_events(struct uinput_device *udev,
 
 		input_event(udev->dev, ev.type, ev.code, ev.value);
 		bytes += input_event_size();
+		cond_resched();
 	}
 
 	return bytes;
-- 
2.17.1

