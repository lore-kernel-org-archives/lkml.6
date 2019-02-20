Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB432146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzW/2Rmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbfBTDYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:24:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38933 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfBTDYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:24:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id i20so776544pfo.6;
        Tue, 19 Feb 2019 19:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=01V+6R8bkfws7Rsp/O1h53KMz0eR0Jxhfhg4foqPLZs=;
        b=qzW/2RmtBda7JraYPw3rw0rJ5DYVecqh/snAZ+uoUxETcviQqNLaBhBlYrZOz3sZmX
         RQaDx/NhK4CY0xSO/DS2mNjKDYaX7Z1ffPVYJaoL2xo6GT1goz11O/BF2sJGBS0dwrjh
         9fVvah+uKq9ZzgMVD4A8MrKdqEaN04tMM+oSrG+FC+km9V0yTllH1M1BX0d4sZEOMj6p
         PfFK0330YqOaNchnYhJS0DbeOdieqeFMy+Hw1E0dhGsXGUe1bSaemSdlA7c8K/ajt6RY
         gAbR72w+xs4TmHEHRvbNNVmnDS1kup+PkjM3lap3zNRpi0DBPMG/RZ5Dx99CuQwIkKr+
         xOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=01V+6R8bkfws7Rsp/O1h53KMz0eR0Jxhfhg4foqPLZs=;
        b=KXX2ifJ24zmRzUHi9Nvkw4eMdsXtVLSzpLJCNI117NFUfV63xlIy48D6WZUSfenojA
         bDPiXGD46OnHH8bLqxLsqTfYpx59dHEMK1GT/lPQffP6PqajHjkqaSF14WoKLS1RzZzk
         BhsAl5Q45uyDF01sJcsfZNLNLWLcNRVhkzGYdOw+1F2PdBGO0kO3yKTtDpfzb2yxAUKA
         O0vmADpg7kzturxZgKpZiasETuBo7b77OdCurENmoC155/Re0od1CR+ZLrwhRYPL045D
         cHF1jFV5Yf6u4MVUx9fayUVfxzKpHYFAycWNyrYkGUBdxq+wSdyyRQZtnhomN1+wOxV+
         fj3g==
X-Gm-Message-State: AHQUAubI+1FcJZJhKWKRFpStJibfuH4siY+Gf3Hw/EISS8K0uN2mHI1F
        4AZChd8WwgcNDKkmDF5DkYU=
X-Google-Smtp-Source: AHgI3IaWaDPt63nrpCK+WYSS85UZiUo3XtzVjROrgmdQObDRiu3kX4rHRGBMikno+ge/yqdaksusqQ==
X-Received: by 2002:a62:1d8c:: with SMTP id d134mr32737232pfd.96.1550633089138;
        Tue, 19 Feb 2019 19:24:49 -0800 (PST)
Received: from localhost.localdomain ([49.34.135.168])
        by smtp.googlemail.com with ESMTPSA id k64sm34698322pfj.69.2019.02.19.19.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 19:24:48 -0800 (PST)
From:   Himadri Pandya <himadri18.07@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     julia.lawall@lip6.fr, andrew@lunn.ch, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Himadri Pandya <himadri18.07@gmail.com>
Subject: [PATCH] net: dsa: add missing of_node_put
Date:   Wed, 20 Feb 2019 08:54:32 +0530
Message-Id: <20190220032432.2878-1-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decrement the reference count on port while returning out of the loop.

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
 net/dsa/dsa2.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index a1917025e155..396e7433dd8f 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -624,19 +624,25 @@ static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
 	for_each_available_child_of_node(ports, port) {
 		err = of_property_read_u32(port, "reg", &reg);
 		if (err)
-			return err;
+			goto put_port;
 
-		if (reg >= ds->num_ports)
-			return -EINVAL;
+		if (reg >= ds->num_ports) {
+			err = -EINVAL;
+			goto put_port;
+		}
 
 		dp = &ds->ports[reg];
 
 		err = dsa_port_parse_of(dp, port);
 		if (err)
-			return err;
+			goto put_port;
 	}
 
 	return 0;
+
+put_port:
+	of_node_put(port);
+	return err;
 }
 
 static int dsa_switch_parse_member_of(struct dsa_switch *ds,
-- 
2.17.1

