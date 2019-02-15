Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31F4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6CC222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fozceu1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394138AbfBOWxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:53:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33617 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390106AbfBOWxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:53:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id y10so5664586plp.0;
        Fri, 15 Feb 2019 14:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GmsxL6ue1pwm/WQ282fv6yCw0X20h/gOBu2/en2qp7g=;
        b=Fozceu1F+1bDq17QQavBU465DtifEHGf1fNzXB4V4SFfF6Y+yldqVXsuVAZYOgtzTi
         vcjAJ7K4Mpdtk3kxMH/uJy0hJQozFXNQKpK14clcxWLxjeoYgBEIvUOUiTOBzRB/y9pW
         er2scEk7V3y1jqdb+Yg6/b0dTitHAmIG3dC1QjA0G9zujrIt47UpS6MrBx9aMc8IB0EK
         VP/vAa0wizCsGwztSiXtNvoYacCHDrLjpwPoLExqct5VAtA5/qcKmOAjPV5PXAltghjB
         zxiLi8DaSbK8wPNImVwDAMLVetUc3B7KBnPqoOGujtKuKeFckxJxvFth0dlwpcwKhWSn
         stiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GmsxL6ue1pwm/WQ282fv6yCw0X20h/gOBu2/en2qp7g=;
        b=PI8RPGEOPaTFmkaQMg5R6YkuvHKBuX4idSY13Cqk4/1MjIQxRXqjaBJVC1hR78ffuT
         TcNSKp48q0bEn36aCmF3z7ZhrqVKmrLlIDJAAjnE9gb+w8tMphH/tF4zVCxNg2QbjkWO
         Cg4rjthMopyyfzjre2+aFajBAuRtDos6exbLGG201e6VfjMN20kTHOd5mCO0C2A48TUk
         7DbW3JphJEdGCqEGvpBOHA6+3INLuH0G2m0l2RZ797AHaX3fCJ+FU/PxipY8n9w/W7bm
         tbLY+cMzGDeiUZYEaTQpVsU78SMyjQ7QrkrQY+dIrslWhS1KiCIkR+VuE0Am3OPfE9ML
         b9ug==
X-Gm-Message-State: AHQUAuZwyiYzNmH4jBJHNBjSbiazml2t/XaUm8atE0XbR+mFjaJUYR4B
        2OXqEXvwPETnirbufXFYmj61xxzw
X-Google-Smtp-Source: AHgI3IY5hZPR/Z6U6+T545CIQgDQkN7n9B+KJwuk5i9jpFoKY0sbhr4I+ciVtHyg0BC83SQJqbqYMg==
X-Received: by 2002:a17:902:3283:: with SMTP id z3mr12772258plb.76.1550271199723;
        Fri, 15 Feb 2019 14:53:19 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d129sm9719905pfc.31.2019.02.15.14.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:53:18 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 1/9] Documentation: networking: switchdev: Update port parent ID section
Date:   Fri, 15 Feb 2019 14:53:05 -0800
Message-Id: <20190215225313.32303-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the section about switchdev drivers having to implement a
switchdev_port_attr_get() function to return
SWITCHDEV_ATTR_ID_PORT_PARENT_ID since that is no longer valid after
commit bccb30254a4a ("net: Get rid of
SWITCHDEV_ATTR_ID_PORT_PARENT_ID").

Fixes: bccb30254a4a ("net: Get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID")
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index f3244d87512a..ea90243340a9 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -92,11 +92,11 @@ device.
 Switch ID
 ^^^^^^^^^
 
-The switchdev driver must implement the switchdev op switchdev_port_attr_get
-for SWITCHDEV_ATTR_ID_PORT_PARENT_ID for each port netdev, returning the same
-physical ID for each port of a switch.  The ID must be unique between switches
-on the same system.  The ID does not need to be unique between switches on
-different systems.
+The switchdev driver must implement the net_device operation
+ndo_get_port_parent_id for each port netdev, returning the same physical ID for
+each port of a switch. The ID must be unique between switches on the same
+system. The ID does not need to be unique between switches on different
+systems.
 
 The switch ID is used to locate ports on a switch and to know if aggregated
 ports belong to the same switch.
-- 
2.17.1

