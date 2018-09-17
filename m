Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4DBECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC242088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC242088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbeIRETc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:19:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44784 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeIRETc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:19:32 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2931CAD;
        Mon, 17 Sep 2018 22:50:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 32/56] Bluetooth: hidp: Fix handling of strncpy for hid->name information
Date:   Tue, 18 Sep 2018 00:42:05 +0200
Message-Id: <20180917213829.263546555@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
References: <20180917213827.913122591@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcel Holtmann <marcel@holtmann.org>

[ Upstream commit b3cadaa485f0c20add1644a5c877b0765b285c0c ]

This fixes two issues with setting hid->name information.

  CC      net/bluetooth/hidp/core.o
In function ‘hidp_setup_hid’,
    inlined from ‘hidp_session_dev_init’ at net/bluetooth/hidp/core.c:815:9,
    inlined from ‘hidp_session_new’ at net/bluetooth/hidp/core.c:953:8,
    inlined from ‘hidp_connection_add’ at net/bluetooth/hidp/core.c:1366:8:
net/bluetooth/hidp/core.c:778:2: warning: ‘strncpy’ output may be truncated copying 127 bytes from a string of length 127 [-Wstringop-truncation]
  strncpy(hid->name, req->name, sizeof(req->name) - 1);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  CC      net/bluetooth/hidp/core.o
net/bluetooth/hidp/core.c: In function ‘hidp_setup_hid’:
net/bluetooth/hidp/core.c:778:38: warning: argument to ‘sizeof’ in ‘strncpy’ call is the same expression as the source; did you mean to use the size of the destination? [-Wsizeof-pointer-memaccess]
  strncpy(hid->name, req->name, sizeof(req->name));
                                      ^

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hidp/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -774,7 +774,7 @@ static int hidp_setup_hid(struct hidp_se
 	hid->version = req->version;
 	hid->country = req->country;
 
-	strncpy(hid->name, req->name, sizeof(req->name) - 1);
+	strncpy(hid->name, req->name, sizeof(hid->name));
 
 	snprintf(hid->phys, sizeof(hid->phys), "%pMR",
 		 &l2cap_pi(session->ctrl_sock->sk)->chan->src);


