Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq0d4wa61yJWucCooze0yOY1I1GzJ+OAxl3e0Dc9oQkncHrh+8wS3TGP3cm0sXvtXZxj1Kh
ARC-Seal: i=1; a=rsa-sha256; t=1524837947; cv=none;
        d=google.com; s=arc-20160816;
        b=a97YGLltBHckJoAWZHzwhC/pblFKd47IMcJGPxWu2rf+p6P4VRupR8pUI+CXH5UrPK
         0HNmgIYzUW/jncjoHflJxj67aa3eMjaBMWsP0ckBsUTqvVd+CEVLVCUbD94R5WtxHO/l
         YJYlE02pPfxvzGEb2HzEi2OYCiuRia0OlzQCuPMzCf7LTH5gAURrkSgRpCybjatpfO/R
         3zK5l2aXdt4pg95lvvDi4dmgSP7kikmjkbfbd0LgxcpHjz74QrK27kBcLOsafHpQCfBq
         29E8lrbuvvGbclZO7M69fxrxKPoipaTFlDr6LHk2aZItcp2+cEnidZ/4LC0Pg2JGyn7e
         Fszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=qRQXpNmi0pSa/uRkojmf0SB5z9ckUuGPz5i5cxRXwDM=;
        b=SQtGypBLhtXLPWK4fDHhLH2a+xcf2Jqwem8XXHSa47AeWqAA/joLO21dmRo+NmbSg/
         A9mPZ2O/Yj1wKM5l4PuOaL6sEmBhSyqysF8h4c8mUPcHMGrdsgbjJ2yy3RHaBS8QYHHi
         N9jtAsjltISt8EeuYgSYV8ia5VfFj7RIZ4HJWtg9QajwsiiBa9wRSV3K8WIwk/Rwnjfj
         LrxXyeJXUNN5H7prvNjoJ9zDOgB9LXSk9xJQWJ/0YWN4sf40772SG16xW4OiocQkdGew
         xAudPAwNeFQ8pnIdYF9l8Z/DAbAVRqeL/ntLYL+iR3aiXy8miw0WGKghnekftC60fsgu
         WIZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4000221890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Avelino=20Bellomo=20Filho?= <jbellomo@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 54/74] team: fix netconsole setup over team
Date: Fri, 27 Apr 2018 15:58:44 +0200
Message-Id: <20180427135712.174970063@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908221945898093?=
X-GMAIL-MSGID: =?utf-8?q?1598908474993550515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1078,14 +1078,11 @@ static void team_port_leave(struct team
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
@@ -1099,6 +1096,14 @@ static int team_port_enable_netpoll(stru
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
@@ -1113,7 +1118,7 @@ static void team_port_disable_netpoll(st
 	kfree(np);
 }
 #else
-static int team_port_enable_netpoll(struct team *team, struct team_port *port)
+static int team_port_enable_netpoll(struct team_port *port)
 {
 	return 0;
 }
@@ -1221,7 +1226,7 @@ static int team_port_add(struct team *te
 		goto err_vids_add;
 	}
 
-	err = team_port_enable_netpoll(team, port);
+	err = team_port_enable_netpoll(port);
 	if (err) {
 		netdev_err(dev, "Failed to enable netpoll on device %s\n",
 			   portname);
@@ -1919,7 +1924,7 @@ static int team_netpoll_setup(struct net
 
 	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list) {
-		err = team_port_enable_netpoll(team, port);
+		err = __team_port_enable_netpoll(port);
 		if (err) {
 			__team_netpoll_cleanup(team);
 			break;
