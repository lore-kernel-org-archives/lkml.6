Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C205C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFF82087D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFF82087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeJNXNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:13:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36425 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728262AbeJNXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:07 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLv-0004io-KM; Sun, 14 Oct 2018 16:30:47 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000QZ-3H; Sun, 14 Oct 2018 16:30:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "=?UTF-8?Q?Jo=C3=A3o=20?=Avelino Bellomo Filho" <jbellomo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Xin Long" <lucien.xin@gmail.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.909124168@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 207/366] team: fix netconsole setup over team
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit 9cf2f437ca5b39828984064fad213e68fc17ef11 upstream.

The same fix in Commit dbe173079ab5 ("bridge: fix netconsole
setup over bridge") is also needed for team driver.

While at it, remove the unnecessary parameter *team from
team_port_enable_netpoll().

v1->v2:
  - fix it in a better way, as does bridge.

Fixes: 0fb52a27a04a ("team: cleanup netpoll clode")
Reported-by: João Avelino Bellomo Filho <jbellomo@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/team/team.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1052,14 +1052,11 @@ static void team_port_leave(struct team
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-static int team_port_enable_netpoll(struct team *team, struct team_port *port)
+static int __team_port_enable_netpoll(struct team_port *port)
 {
 	struct netpoll *np;
 	int err;
 
-	if (!team->dev->npinfo)
-		return 0;
-
 	np = kzalloc(sizeof(*np), GFP_KERNEL);
 	if (!np)
 		return -ENOMEM;
@@ -1073,6 +1070,14 @@ static int team_port_enable_netpoll(stru
 	return err;
 }
 
+static int team_port_enable_netpoll(struct team_port *port)
+{
+	if (!port->team->dev->npinfo)
+		return 0;
+
+	return __team_port_enable_netpoll(port);
+}
+
 static void team_port_disable_netpoll(struct team_port *port)
 {
 	struct netpoll *np = port->np;
@@ -1087,7 +1092,7 @@ static void team_port_disable_netpoll(st
 	kfree(np);
 }
 #else
-static int team_port_enable_netpoll(struct team *team, struct team_port *port)
+static int team_port_enable_netpoll(struct team_port *port)
 {
 	return 0;
 }
@@ -1175,7 +1180,7 @@ static int team_port_add(struct team *te
 		goto err_vids_add;
 	}
 
-	err = team_port_enable_netpoll(team, port);
+	err = team_port_enable_netpoll(port);
 	if (err) {
 		netdev_err(dev, "Failed to enable netpoll on device %s\n",
 			   portname);
@@ -1880,7 +1885,7 @@ static int team_netpoll_setup(struct net
 
 	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list) {
-		err = team_port_enable_netpoll(team, port);
+		err = __team_port_enable_netpoll(port);
 		if (err) {
 			__team_netpoll_cleanup(team);
 			break;

