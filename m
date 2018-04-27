Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrzlbi6atViOX6HmlbYbarxySRXIprJrrLB1IqebG1o/LBX7d0QRvEuLU6sCYbpdYEV6EhY
ARC-Seal: i=1; a=rsa-sha256; t=1524837510; cv=none;
        d=google.com; s=arc-20160816;
        b=b9WAXbOYRKtRKynqeKLBZ9a3evyp40FNYzUcetZGrAUIqa1oRTTJHhEPpNBp5cmWFl
         nsViFuwgN3j57hDKhfzY/L12T6sun8C1J9Kp+oFRy+eXyG0YnAdFwtvWqk9kySRUeg6r
         5UVvm0430inZMyCipUxyjeXRZTxR0lBvZC1aRz+vKQMhQoNuES55zq312lQ3cmUtYYFN
         6ZK5/iTnI/+wEsSueG3mi9UuH3pwt10kZR2AwE4ZnpzXOR9z5nIKxJfJcy+dOkoBv4tX
         sVfk1Y0pfNS1+4czjB5kuyY0nGF0IyKRwlj38brPQUefit3dN6+WfrmsjA8NYGRvFYWj
         ypqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=bAQ5DeYkT2mkE5q7fDX3KiX850D6kAuF3k1TX7S0720=;
        b=GxweId6JfwzWjDUnbYsGAiZtWUDLl/mN+aGFR2IMM16Y0lZSsv6ox8iX079KGVGxH+
         OZUl2MeeRL+s+5HJygC+VoYfGmT+9rZrapQiVKFSULPSt7WetIi8zVscnrI/tCjt+r8N
         Qm7F7Uskf0mdhpHuNx6lnkq0NyHkI2T0ppBkBC2LDEgy6OMud22cp3xtxJOW8Nlq3++N
         wTkBrXx4BetL78HPulLvm1sdMfYnhcefc4YWnYyQcuJUzDOorySEkwbqDQZc60k5giVY
         +AjJ7NXr0tQY7ar3aYWucD8yOCZUTQPWfxMfXrww+ltjMXR+MRJqaXhznE88qcO7UX5z
         LZNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9F021894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Avelino=20Bellomo=20Filho?= <jbellomo@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 14/24] team: fix netconsole setup over team
Date: Fri, 27 Apr 2018 15:57:49 +0200
Message-Id: <20180427135632.155190818@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908017399488779?=
X-GMAIL-MSGID: =?utf-8?q?1598908017399488779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1051,14 +1051,11 @@ static void team_port_leave(struct team
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
@@ -1072,6 +1069,14 @@ static int team_port_enable_netpoll(stru
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
@@ -1086,7 +1091,7 @@ static void team_port_disable_netpoll(st
 	kfree(np);
 }
 #else
-static int team_port_enable_netpoll(struct team *team, struct team_port *port)
+static int team_port_enable_netpoll(struct team_port *port)
 {
 	return 0;
 }
@@ -1193,7 +1198,7 @@ static int team_port_add(struct team *te
 		goto err_vids_add;
 	}
 
-	err = team_port_enable_netpoll(team, port);
+	err = team_port_enable_netpoll(port);
 	if (err) {
 		netdev_err(dev, "Failed to enable netpoll on device %s\n",
 			   portname);
@@ -1898,7 +1903,7 @@ static int team_netpoll_setup(struct net
 
 	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list) {
-		err = team_port_enable_netpoll(team, port);
+		err = __team_port_enable_netpoll(port);
 		if (err) {
 			__team_netpoll_cleanup(team);
 			break;
