Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrjN1tjXAbk6m4Gh95wIV1F4Uh7pdmso0OFH1QN9+CwSg9mEo4mMF9cnj9pNN0lD1+3hA3m
ARC-Seal: i=1; a=rsa-sha256; t=1524838242; cv=none;
        d=google.com; s=arc-20160816;
        b=VtJNuJSmQy/2ZMfTCld/J2jCLl80/W3ev9Ozb8RVMLRaFuibo8m+LdwYsP2+xneYRl
         rl8Dl4TPG5XqVJFfUj2NmKU69UVWej27svixeJztDassYetP5NFpDU8TCufnAbFh4g5I
         ewkjo+xTi0B1Ky+4dWit6RfLWjmRf+fAWuQMKJtna7EEfAPVswULBCXxEFozvUD/Gecm
         TgUu0qjIlk2WpZyn//iXeI9LP9zMbIScDNmEmXZe08PNlvnMX6OpuRr8oZbbBkoh16WI
         sAH0bu4PT7MS2eDOi6GDpUN91eYIKkPDUzft9egWbCiChGuxZK7VirQWPD0mLAkMOtE1
         NpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=F2VAVidHtUWkNpsqcbK/oD5uj4iqJ0GFH+9T6NTZjl4=;
        b=SXRAfBVD8KrStHAgVTgpVWG7tw8jnEHiwYhXA2ySOIGethV2ga8mdV/ucVmtjw5Now
         ZMy5L9jYpVcQavcveyqtaAIvAx7GP7hcPIwMvjAbndpb9s2FR03nmDHrKyEHvGFW+rGo
         diB220NfyUC7Cmfyc8bSJICfJGVTsu9nIwwbTZoGc4yCYII5m/wsnJ8GEj149jWvF8Uw
         el6vq2lQkhOrAVqpbGxVvYeaZ3mDZHypTz/FTzgsdewj8ZMnqgA1u5xjU5gpRpbZ9ciE
         y1tklX8rWV29ziFzDj8xPO5jlOdXvcKpdRomcvyMcJy7bz/THLXe/zVvvOSoz8G04hvf
         pbcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BE721864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Avelino=20Bellomo=20Filho?= <jbellomo@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 31/81] team: fix netconsole setup over team
Date: Fri, 27 Apr 2018 15:58:33 +0200
Message-Id: <20180427135744.860972673@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908221945898093?=
X-GMAIL-MSGID: =?utf-8?q?1598908785011294944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 9cf2f437ca5b39828984064fad213e68fc17ef11 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1072,14 +1072,11 @@ static void team_port_leave(struct team
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
@@ -1093,6 +1090,14 @@ static int team_port_enable_netpoll(stru
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
@@ -1107,7 +1112,7 @@ static void team_port_disable_netpoll(st
 	kfree(np);
 }
 #else
-static int team_port_enable_netpoll(struct team *team, struct team_port *port)
+static int team_port_enable_netpoll(struct team_port *port)
 {
 	return 0;
 }
@@ -1215,7 +1220,7 @@ static int team_port_add(struct team *te
 		goto err_vids_add;
 	}
 
-	err = team_port_enable_netpoll(team, port);
+	err = team_port_enable_netpoll(port);
 	if (err) {
 		netdev_err(dev, "Failed to enable netpoll on device %s\n",
 			   portname);
@@ -1912,7 +1917,7 @@ static int team_netpoll_setup(struct net
 
 	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list) {
-		err = team_port_enable_netpoll(team, port);
+		err = __team_port_enable_netpoll(port);
 		if (err) {
 			__team_netpoll_cleanup(team);
 			break;
