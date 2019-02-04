Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60221C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242AB2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278211;
	bh=Y4rt3+s0bGClf0+6/XIyTYJxdi/wSI/irW/K7eUhzFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aDwBCf02TMd2Vf/TlSe23xvryvUypbfVj314YdGY/QHIpUWa64dGSdsAWF7E+ubid
	 Twt0iERg8+FBGzbbnbDOowQsbGg2O0aoS2qnRivMk7/hotDRbma9DKSECTOnSMhyC6
	 2/Bsfa0eDYdTzbMXViZ/NJDxRPBR6ThhT+PUyR58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfBDLD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:03:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730692AbfBDKqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:46:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E9312087C;
        Mon,  4 Feb 2019 10:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277190;
        bh=Y4rt3+s0bGClf0+6/XIyTYJxdi/wSI/irW/K7eUhzFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DduHUC5kf+JODoPxKcty5a1NXSMhtrtCuMQBF3urddPUfH1CX3+BZ/yELMSCI9yn3
         hBPPHxzhPyRpjO0Pr08XBK+9xMrG8iZ2bfqUyxovvEJ6lYCUvKXm/Dd/Lct/4AHQL4
         9+3PlzqN/f6L0ACfrvftYBKVzTNn4obW0NQTSRck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Paulo Alcantara <palcantara@suse.de>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.14 44/46] cifs: Always resolve hostname before reconnecting
Date:   Mon,  4 Feb 2019 11:37:15 +0100
Message-Id: <20190204103616.478506244@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <paulo@paulo.ac>

commit 28eb24ff75c5ac130eb326b3b4d0dcecfc0f427d upstream.

In case a hostname resolves to a different IP address (e.g. long
running mounts), make sure to resolve it every time prior to calling
generic_ip_connect() in reconnect.

Suggested-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Paulo Alcantara <palcantara@suse.de>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/connect.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -51,6 +51,7 @@
 #include "cifs_unicode.h"
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
+#include "dns_resolve.h"
 #include "ntlmssp.h"
 #include "nterr.h"
 #include "rfc1002pdu.h"
@@ -314,6 +315,53 @@ static int cifs_setup_volume_info(struct
 					const char *devname);
 
 /*
+ * Resolve hostname and set ip addr in tcp ses. Useful for hostnames that may
+ * get their ip addresses changed at some point.
+ *
+ * This should be called with server->srv_mutex held.
+ */
+#ifdef CONFIG_CIFS_DFS_UPCALL
+static int reconn_set_ipaddr(struct TCP_Server_Info *server)
+{
+	int rc;
+	int len;
+	char *unc, *ipaddr = NULL;
+
+	if (!server->hostname)
+		return -EINVAL;
+
+	len = strlen(server->hostname) + 3;
+
+	unc = kmalloc(len, GFP_KERNEL);
+	if (!unc) {
+		cifs_dbg(FYI, "%s: failed to create UNC path\n", __func__);
+		return -ENOMEM;
+	}
+	snprintf(unc, len, "\\\\%s", server->hostname);
+
+	rc = dns_resolve_server_name_to_ip(unc, &ipaddr);
+	kfree(unc);
+
+	if (rc < 0) {
+		cifs_dbg(FYI, "%s: failed to resolve server part of %s to IP: %d\n",
+			 __func__, server->hostname, rc);
+		return rc;
+	}
+
+	rc = cifs_convert_address((struct sockaddr *)&server->dstaddr, ipaddr,
+				  strlen(ipaddr));
+	kfree(ipaddr);
+
+	return !rc ? -1 : 0;
+}
+#else
+static inline int reconn_set_ipaddr(struct TCP_Server_Info *server)
+{
+	return 0;
+}
+#endif
+
+/*
  * cifs tcp session reconnection
  *
  * mark tcp session as reconnecting so temporarily locked
@@ -408,6 +456,11 @@ cifs_reconnect(struct TCP_Server_Info *s
 		rc = generic_ip_connect(server);
 		if (rc) {
 			cifs_dbg(FYI, "reconnect error %d\n", rc);
+			rc = reconn_set_ipaddr(server);
+			if (rc) {
+				cifs_dbg(FYI, "%s: failed to resolve hostname: %d\n",
+					 __func__, rc);
+			}
 			mutex_unlock(&server->srv_mutex);
 			msleep(3000);
 		} else {


