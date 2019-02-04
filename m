Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93707C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0E02082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277670;
	bh=xoNhoR+rKYw9MmGfTDix/BtPU0qYJg5moRoqm9wqqSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ul5Shwbd5b5XawQSAYQG3YdiWgKBZ6i6Monq7Rh8tcjlrr31lG+cTFLmXpVTPUoZN
	 p6e+mpUpkmu3Y6YRDtUYL7uCJMiX1+NFJQNBhOjH2mLHVmHR6kNRxTP9axiIX8fkmt
	 kGU9dEa1TEWYz3kuy/rlNjbGS6uCp6Bm4BvPnjz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbfBDKy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:54:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732424AbfBDKy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:54:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0B172176F;
        Mon,  4 Feb 2019 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277667;
        bh=xoNhoR+rKYw9MmGfTDix/BtPU0qYJg5moRoqm9wqqSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvUNFIAR8e/zGNWTKhFbU/Q8YPFVPJk4FCaA8zNdC/mG4jKwt4bbXRZIC5k7do277
         3kXAVAo18F3qFS8uBe4Z+EVEYyQ6F5Ag6NoYZIHWj5KzMxZcDmr0kxCp3Dlt6HJu82
         7AxncTqvd6Baec1sZh+rqDJ2hdG+FCmCw5m5S94Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Paulo Alcantara <palcantara@suse.de>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.20 80/80] cifs: Always resolve hostname before reconnecting
Date:   Mon,  4 Feb 2019 11:37:40 +0100
Message-Id: <20190204103631.047605879@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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
@@ -50,6 +50,7 @@
 #include "cifs_unicode.h"
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
+#include "dns_resolve.h"
 #include "ntlmssp.h"
 #include "nterr.h"
 #include "rfc1002pdu.h"
@@ -319,6 +320,53 @@ static int cifs_setup_volume_info(struct
 					const char *devname, bool is_smb3);
 
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
@@ -418,6 +466,11 @@ cifs_reconnect(struct TCP_Server_Info *s
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


