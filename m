Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B781C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F18222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894951;
	bh=iZR26Q6xkex2tEhRSm7+dZ0bFobj22YCAxUrycMhFmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hvi8MAV4e6mhSNLIwcMkF7Yqky9yyyAOAQpQ9hLkgbsLylQgxzR0RQoAnO53sWps7
	 RHz8sUl8wLara4b0E4Lv4CNYbpCE8R4S4CqqArPGEZB9mPivPPV8eP7kJDl4XOHs1r
	 RWx+e7iSZ5t1qRrk9WMuK9DGmsr5//ahNjs1DQic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfBKOW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:22:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfBKOWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:22:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEE60222A1;
        Mon, 11 Feb 2019 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894941;
        bh=iZR26Q6xkex2tEhRSm7+dZ0bFobj22YCAxUrycMhFmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ox6drZoB/6mxb/SveC0PsVTIRP+GAf0nIbdALU2laqIuXJoz5Ey4B0fSNd2vby+G7
         2HsZaHCYLiL14rSHq0Ob3E8ju5VTZ7ogtwx7gOGw3kdoA+WcfviZkHFtcbSIXErC1s
         +dMQ+quIHFZ+7SVXCtsa4ggEx7zvQ7EVD9HVC7wQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 038/352] Tools: hv: kvp: Fix a warning of buffer overflow with gcc 8.0.1
Date:   Mon, 11 Feb 2019 15:14:25 +0100
Message-Id: <20190211141848.745977693@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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



