Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeEQXzp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 19:55:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44505 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeEQXzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 19:55:43 -0400
X-Google-Smtp-Source: AB8JxZpfvd4InYGMrS6G9Xelv8uuKgcbNahpZpX68KJLykzWPMiTLPgfr8pUgC1W82zRR80PLriikQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net: dsa: Do not register devlink for unused ports
Date: Thu, 17 May 2018 16:55:39 -0700
Message-Id: <20180517235539.19418-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if commit 1d27732f411d ("net: dsa: setup and teardown ports") indicated
that registering a devlink instance for unused ports is not a problem, and this
is true, this can be confusing nonetheless, so let's not do it.

Fixes: 1d27732f411d ("net: dsa: setup and teardown ports")
Reported-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/dsa2.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index adf50fbc4c13..47725250b4ca 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -258,11 +258,13 @@ static void dsa_tree_teardown_default_cpu(struct dsa_switch_tree *dst)
 static int dsa_port_setup(struct dsa_port *dp)
 {
 	struct dsa_switch *ds = dp->ds;
-	int err;
+	int err = 0;
 
 	memset(&dp->devlink_port, 0, sizeof(dp->devlink_port));
 
-	err = devlink_port_register(ds->devlink, &dp->devlink_port, dp->index);
+	if (dp->type != DSA_PORT_TYPE_UNUSED)
+		err = devlink_port_register(ds->devlink, &dp->devlink_port,
+					    dp->index);
 	if (err)
 		return err;
 
@@ -293,7 +295,8 @@ static int dsa_port_setup(struct dsa_port *dp)
 
 static void dsa_port_teardown(struct dsa_port *dp)
 {
-	devlink_port_unregister(&dp->devlink_port);
+	if (dp->type != DSA_PORT_TYPE_UNUSED)
+		devlink_port_unregister(&dp->devlink_port);
 
 	switch (dp->type) {
 	case DSA_PORT_TYPE_UNUSED:
-- 
2.14.1
