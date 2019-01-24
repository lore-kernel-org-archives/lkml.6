Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ED4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704D221903
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358729;
	bh=Q4ZpluHArJgss6GNO4XCRynB6tD3fyo8l4lo8TE959c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cVQJ0SPxoestIhK+L7eTfL34XM75YDwCY+pSZZo1m3kDSU8siRow5Yf6GMpQtXM1+
	 WsSrRx8DEEBz22Ws3BiU6dGKCoK2fPgf73+k4vSB/5hmBW7ZjLjFuMjT2ijYg8OK4q
	 +nVVSkgo+6OtAJ3jDb3lqlxg+zedJd/UZI7oM/lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbfAXTir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732907AbfAXTip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:38:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900CD21907;
        Thu, 24 Jan 2019 19:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358724;
        bh=Q4ZpluHArJgss6GNO4XCRynB6tD3fyo8l4lo8TE959c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xp4UACQGTbe0nNi94BendtHYXnyTL/3eXb06RhMaIg0S7NfevZsCu3asNwBhB9Wg+
         W3S6kJxcBxP0SIM80EVk3l2qHijx6SKyZ7fL4CBuZ9FYES6n1sTYtRcEY6nIfwz+rb
         sCs6PxK+44EPPfgACfyvxBL4RXDrfzJzNQwSzt+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4.19 103/106] ipmi: msghandler: Fix potential Spectre v1 vulnerabilities
Date:   Thu, 24 Jan 2019 20:21:00 +0100
Message-Id: <20190124190212.438297284@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit a7102c7461794a5bb31af24b08e9e0f50038897a upstream.

channel and addr->channel are indirectly controlled by user-space,
hence leading to a potential exploitation of the Spectre variant 1
vulnerability.

These issues were detected with the help of Smatch:

drivers/char/ipmi/ipmi_msghandler.c:1381 ipmi_set_my_address() warn: potential spectre issue 'user->intf->addrinfo' [w] (local cap)
drivers/char/ipmi/ipmi_msghandler.c:1401 ipmi_get_my_address() warn: potential spectre issue 'user->intf->addrinfo' [r] (local cap)
drivers/char/ipmi/ipmi_msghandler.c:1421 ipmi_set_my_LUN() warn: potential spectre issue 'user->intf->addrinfo' [w] (local cap)
drivers/char/ipmi/ipmi_msghandler.c:1441 ipmi_get_my_LUN() warn: potential spectre issue 'user->intf->addrinfo' [r] (local cap)
drivers/char/ipmi/ipmi_msghandler.c:2260 check_addr() warn: potential spectre issue 'intf->addrinfo' [r] (local cap)

Fix this by sanitizing channel and addr->channel before using them to
index user->intf->addrinfo and intf->addrinfo, correspondingly.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_msghandler.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -29,6 +29,7 @@
 #include <linux/moduleparam.h>
 #include <linux/workqueue.h>
 #include <linux/uuid.h>
+#include <linux/nospec.h>
 
 #define PFX "IPMI message handler: "
 
@@ -1297,10 +1298,12 @@ int ipmi_set_my_address(struct ipmi_user
 	if (!user)
 		return -ENODEV;
 
-	if (channel >= IPMI_MAX_CHANNELS)
+	if (channel >= IPMI_MAX_CHANNELS) {
 		rv = -EINVAL;
-	else
+	} else {
+		channel = array_index_nospec(channel, IPMI_MAX_CHANNELS);
 		user->intf->addrinfo[channel].address = address;
+	}
 	release_ipmi_user(user, index);
 
 	return rv;
@@ -1317,10 +1320,12 @@ int ipmi_get_my_address(struct ipmi_user
 	if (!user)
 		return -ENODEV;
 
-	if (channel >= IPMI_MAX_CHANNELS)
+	if (channel >= IPMI_MAX_CHANNELS) {
 		rv = -EINVAL;
-	else
+	} else {
+		channel = array_index_nospec(channel, IPMI_MAX_CHANNELS);
 		*address = user->intf->addrinfo[channel].address;
+	}
 	release_ipmi_user(user, index);
 
 	return rv;
@@ -1337,10 +1342,12 @@ int ipmi_set_my_LUN(struct ipmi_user *us
 	if (!user)
 		return -ENODEV;
 
-	if (channel >= IPMI_MAX_CHANNELS)
+	if (channel >= IPMI_MAX_CHANNELS) {
 		rv = -EINVAL;
-	else
+	} else {
+		channel = array_index_nospec(channel, IPMI_MAX_CHANNELS);
 		user->intf->addrinfo[channel].lun = LUN & 0x3;
+	}
 	release_ipmi_user(user, index);
 
 	return 0;
@@ -1357,10 +1364,12 @@ int ipmi_get_my_LUN(struct ipmi_user *us
 	if (!user)
 		return -ENODEV;
 
-	if (channel >= IPMI_MAX_CHANNELS)
+	if (channel >= IPMI_MAX_CHANNELS) {
 		rv = -EINVAL;
-	else
+	} else {
+		channel = array_index_nospec(channel, IPMI_MAX_CHANNELS);
 		*address = user->intf->addrinfo[channel].lun;
+	}
 	release_ipmi_user(user, index);
 
 	return rv;
@@ -2184,6 +2193,7 @@ static int check_addr(struct ipmi_smi  *
 {
 	if (addr->channel >= IPMI_MAX_CHANNELS)
 		return -EINVAL;
+	addr->channel = array_index_nospec(addr->channel, IPMI_MAX_CHANNELS);
 	*lun = intf->addrinfo[addr->channel].lun;
 	*saddr = intf->addrinfo[addr->channel].address;
 	return 0;


