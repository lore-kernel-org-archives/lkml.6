Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F12C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862082082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895984;
	bh=rhohZB/oxolQwt2FIhQ3n1GPZLJSLxc4SSDaBXcTVKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NLv+Z+7slCszT9bvMda5W8XOEjcDhhgjcrknf4dq1zUHueuq9mXAq4/UnqJ41jxDi
	 R21XhTKcGssEyClA4cOEOegBW4YxIA4acsBCHomiunlR+6HN+SgL0MwuxZAeoCDaSZ
	 sNAiRzs3WXWpsDCo2u//Ux5TtI9FeWAmbk4Y8OpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbfBKOjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731915AbfBKOjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B75F92082F;
        Mon, 11 Feb 2019 14:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895977;
        bh=rhohZB/oxolQwt2FIhQ3n1GPZLJSLxc4SSDaBXcTVKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5ntKWvk2w7KgQydReae0fS2sW7gXQegWCSm059uJ1OdabuiybXYhlgbio74HvO13
         INhqFBqqJSsz6RX3GBvM78MhrO7dzZohQOWpL1sFAOP6b1wBNb7wBEAXiPRTZ4gCwZ
         cqTRIAq3AGg114O2v+8H2niyDOp8PbyxJrLYYvVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 033/313] Tools: hv: kvp: Fix a warning of buffer overflow with gcc 8.0.1
Date:   Mon, 11 Feb 2019 15:15:13 +0100
Message-Id: <20190211141855.638381455@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4fcba7802c3e15a6e56e255871d6c72f829b9dd8 ]

The patch fixes:

hv_kvp_daemon.c: In function 'kvp_set_ip_info':
hv_kvp_daemon.c:1305:2: note: 'snprintf' output between 41 and 4136 bytes
into a destination of size 4096

The "(unsigned int)str_len" is to avoid:

hv_kvp_daemon.c:1309:30: warning: comparison of integer expressions of
different signedness: 'int' and 'long unsigned int' [-Wsign-compare]

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/hv/hv_kvp_daemon.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index bbb2a8ef367c..d7e06fe0270e 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1178,6 +1178,7 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	FILE *file;
 	char cmd[PATH_MAX];
 	char *mac_addr;
+	int str_len;
 
 	/*
 	 * Set the configuration for the specified interface with
@@ -1301,8 +1302,18 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	 * invoke the external script to do its magic.
 	 */
 
-	snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s",
-		 "hv_set_ifconfig", if_file);
+	str_len = snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s",
+			   "hv_set_ifconfig", if_file);
+	/*
+	 * This is a little overcautious, but it's necessary to suppress some
+	 * false warnings from gcc 8.0.1.
+	 */
+	if (str_len <= 0 || (unsigned int)str_len >= sizeof(cmd)) {
+		syslog(LOG_ERR, "Cmd '%s' (len=%d) may be too long",
+		       cmd, str_len);
+		return HV_E_FAIL;
+	}
+
 	if (system(cmd)) {
 		syslog(LOG_ERR, "Failed to execute cmd '%s'; error: %d %s",
 				cmd, errno, strerror(errno));
-- 
2.19.1



