Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D24EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD26D2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD26D2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbeIREg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:36:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeIREgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:36:55 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D1335C75;
        Mon, 17 Sep 2018 23:07:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Werschlein <thomas.werschlein@geo.uzh.ch>,
        Steve French <stfrench@microsoft.com>,
        Tom Talpey <ttalpey@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 4.18 018/158] cifs: connect to servername instead of IP for IPC$ share
Date:   Tue, 18 Sep 2018 00:40:48 +0200
Message-Id: <20180917211711.645323138@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Werschlein <thomas.werschlein@geo.uzh.ch>

commit 395a2076b4064f97d3fce03af15210ff2a7bb7f9 upstream.

This patch is required allows access to a Microsoft fileserver failover
cluster behind a 1:1 NAT firewall.

The change also provides stronger context for authentication and share
connection (see MS-SMB2 3.3.5.7 and MS-SRVS 3.1.6.8) as noted by
Tom Talpey, and addresses comments about the buffer size for the UNC
made by Aurélien Aptel.

Signed-off-by: Thomas Werschlein <thomas.werschlein@geo.uzh.ch>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Tom Talpey <ttalpey@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/connect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2523,7 +2523,7 @@ cifs_setup_ipc(struct cifs_ses *ses, str
 	if (tcon == NULL)
 		return -ENOMEM;
 
-	snprintf(unc, sizeof(unc), "\\\\%s\\IPC$", ses->serverName);
+	snprintf(unc, sizeof(unc), "\\\\%s\\IPC$", ses->server->hostname);
 
 	/* cannot fail */
 	nls_codepage = load_nls_default();


