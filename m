Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D727BC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94418218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358872;
	bh=NCgoW4mKYQyciiNoHkoPQLP8pJ8ccN7Qyk0J4uvLoxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qVESSlO4g8WC1wr3LJGbKCE0d2Fuq1Pq//Jp7U/5zC5s8IMCP8fJEV9m7FWjCgyF+
	 q3sjz5uc4h3auKEgN1DZdaU9lSS7iEOD6aDf6uoX0PIX8hchpJXiQTZNwuxRbERcO+
	 nz7FdSQflAsj4XIxyf1ErzlaiiONIIUdFE18i9gE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbfAXTlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:41:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387527AbfAXTlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:41:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD80820663;
        Thu, 24 Jan 2019 19:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358867;
        bh=NCgoW4mKYQyciiNoHkoPQLP8pJ8ccN7Qyk0J4uvLoxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8MY5e9LEd18IKwCH+jn6f2LCSIJ3bIfpFjsnsxRNkIZd3FduuQjjIHl61D22oxCV
         Dqt6I/8WenJXC1dRbCgLuhZq3Oz3OWUXWIL4Y5kRe3TRPxhnnBRRtaJlxWRoMliQ7p
         d79A2C2KWygi8lk2tRND+RPmmEPCe6mChAgYUUnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 054/127] pstore/ram: Do not treat empty buffers as valid
Date:   Thu, 24 Jan 2019 20:20:00 +0100
Message-Id: <20190124190214.500515058@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 12e21f789194..79f0e183f135 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -497,6 +497,11 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
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



