Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A5FC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BBC21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360505;
	bh=D+XuWGxgIefC4gOwHSyW/4nIZinCTljF3U2bb2XGAU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ix7xwov1Y31RH7veFIxnKYE63I8xWTzXdoMOgUQnEVDgDPGPKdnJtD4Yp+KTa4l6D
	 hXCzqAV0B4ILhst6pdvsn5J2fxmwu1nSe6Rn3FXn/O2Ls4X/3ELWKquQzbTuHWGHXa
	 a2iCNM510pgO3uFHlGK+tYOl+Z6UKoda0X6LNuoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfAXUIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:08:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731115AbfAXT3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:29:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A1C218FC;
        Thu, 24 Jan 2019 19:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358157;
        bh=D+XuWGxgIefC4gOwHSyW/4nIZinCTljF3U2bb2XGAU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXxXHsxIU8qrKqxFbsC64PkCshnJpt4BP12fdYsYxGHuy7tJaU7Kp0Tw2h1oWSI7d
         XkfRJChfBkRV6Ox84MbsSk6EV3ABa+5Y/kECk4KUmBlUwJ+RvyEy8u92C0tHcPmlWu
         F1Q6KW7cwB9S2a3/E7Q6UIeQLLcQ9asb9jhUAz/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 14/39] pstore/ram: Do not treat empty buffers as valid
Date:   Thu, 24 Jan 2019 20:20:17 +0100
Message-Id: <20190124190448.738679948@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190448.232316246@linuxfoundation.org>
References: <20190124190448.232316246@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ecdb3baa1283..11e558efd61e 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -488,6 +488,11 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
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



