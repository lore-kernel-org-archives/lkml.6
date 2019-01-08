Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2543AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F8F206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977242;
	bh=qqtGQgUzx6kn7kcwTK8uVxR+rzlHb3XJGlWwRnppqU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FHhbBMQnLrAy7GBQxzXJgQzvxsabSwP50WRpHb/UhdnDESu5b/25v1/bGhl2C7QEa
	 pG4mefA15xtC5mVCFyez+VZLB99ueobvqMWkWkR/Z0/kdT0iTtDR6rXeoChkVSWU/N
	 I8PCX8LUr1ADCSnuMhYF2U4oBbU9LKiYskDHWU24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbfAHTyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:54:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730160AbfAHTat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAF3320645;
        Tue,  8 Jan 2019 19:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975849;
        bh=qqtGQgUzx6kn7kcwTK8uVxR+rzlHb3XJGlWwRnppqU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ef+SCDYr9G35ESuK3XUBixyu1SgGe52iJyybbGSsTzBg9h+qXTyU+peGPuAD4QnP/
         bA3/aW+doFNywZGhTgy0X9bLJpzAZ3qDbbIwg4hGE2yW8XVd/VrXF4lP9nb2xmw44l
         as+QaeTAW0hqNASEHHk/8FOUUCAbj2BH3HJQRUoY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 35/97] pstore/ram: Do not treat empty buffers as valid
Date:   Tue,  8 Jan 2019 14:28:44 -0500
Message-Id: <20190108192949.122407-35-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
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
index 0792595ebcfb..3c777ec80d47 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -496,6 +496,11 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
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

