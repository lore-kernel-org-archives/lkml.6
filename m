Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeEQWQx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 18:16:53 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37920 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeEQWQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 18:16:50 -0400
X-Google-Smtp-Source: AB8JxZpzEU2zcTSxQRWmGAypvvYSt5bS+23ECof/N9ZaXw0UhgK+vS4H20x4M+7marbblH7XvKWLUg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: dsa: Do not register devlink for unused ports
Date: Thu, 17 May 2018 15:16:26 -0700
Message-Id: <20180517221626.13045-1-f.fainelli@gmail.com>
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
 net/dsa/dsa2.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index adf50fbc4c13..cc45a8ca45fb 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -262,13 +262,14 @@ static int dsa_port_setup(struct dsa_port *dp)
 
 	memset(&dp->devlink_port, 0, sizeof(dp->devlink_port));
 
+	if (dp->type == DSA_PORT_TYPE_UNUSED)
+		return 0;
+
 	err = devlink_port_register(ds->devlink, &dp->devlink_port, dp->index);
 	if (err)
 		return err;
 
 	switch (dp->type) {
-	case DSA_PORT_TYPE_UNUSED:
-		break;
 	case DSA_PORT_TYPE_CPU:
 	case DSA_PORT_TYPE_DSA:
 		err = dsa_port_link_register_of(dp);
@@ -293,11 +294,12 @@ static int dsa_port_setup(struct dsa_port *dp)
 
 static void dsa_port_teardown(struct dsa_port *dp)
 {
+	if (dp->type == DSA_PORT_TYPE_UNUSED)
+		return;
+
 	devlink_port_unregister(&dp->devlink_port);
 
 	switch (dp->type) {
-	case DSA_PORT_TYPE_UNUSED:
-		break;
 	case DSA_PORT_TYPE_CPU:
 	case DSA_PORT_TYPE_DSA:
 		dsa_port_link_unregister_of(dp);
-- 
2.14.1
