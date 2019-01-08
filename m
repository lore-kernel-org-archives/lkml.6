Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFEFC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617C620645
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976355;
	bh=kP3xqKMPjF9mdDQili8JQSuUpvPUc/O9wMpOSEfIfhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGH1G6v5A4CWLaBWCIIiTJRiZbKClVCenjBxG037s2quRZbsp6nmiedqYcBoBlNyX
	 tvHl3pToy48wPQplLk0yGiC5iZ06QQ/Tq3Rdq4p9+BR0VjL8xLOQHvJGWvIQRZTF8D
	 MPgmUyVncdRD2OI6blusLEuBE8Lqthcbl6k3tCX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbfAHTfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbfAHTfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:35:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B8B20645;
        Tue,  8 Jan 2019 19:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976101;
        bh=kP3xqKMPjF9mdDQili8JQSuUpvPUc/O9wMpOSEfIfhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CILTb9YiRNacdA9vUa3Eq64KCq3VV51sVhzWI1ldAl1V7xHsqC0q45n7pUc2gSp/y
         H1goTafas1TwqlNYykS1qcGSD0w5xeMiVc3vgO4Y9TzQF12Csl1H87T+mmKj2kYOXn
         4K6IYZl8n+TBREVzc2y1Mh9DEJuVme0ApoZkS4E8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 09/28] pstore/ram: Do not treat empty buffers as valid
Date:   Tue,  8 Jan 2019 14:34:26 -0500
Message-Id: <20190108193445.124251-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193445.124251-1-sashal@kernel.org>
References: <20190108193445.124251-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

[ Upstream commit 30696378f68a9e3dad6bfe55938b112e72af00c2 ]

The ramoops backend currently calls persistent_ram_save_old() even
if a buffer is empty. While this appears to work, it is does not seem
like the right thing to do and could lead to future bugs so lets avoid
that. It also prevents misleading prints in the logs which claim the
buffer is valid.

I got something like:

	found existing buffer, size 0, start 0

When I was expecting:

	no valid data in buffer (sig = ...)

This bails out early (and reports with pr_debug()), since it's an
acceptable state.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/ram_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index bd21795ce657..679d75a864d0 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -445,6 +445,11 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 	sig ^= PERSISTENT_RAM_SIG;
 
 	if (prz->buffer->sig == sig) {
+		if (buffer_size(prz) == 0) {
+			pr_debug("found existing empty buffer\n");
+			return 0;
+		}
+
 		if (buffer_size(prz) > prz->buffer_size ||
 		    buffer_start(prz) > buffer_size(prz))
 			pr_info("found existing invalid buffer, size %zu, start %zu\n",
-- 
2.19.1

