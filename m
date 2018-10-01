Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C68C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD68D2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8zwWoPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD68D2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeJAKXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 06:23:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40886 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbeJAKX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 06:23:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id o2-v6so7139967wmh.5;
        Sun, 30 Sep 2018 20:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNgubNEXCLIH3oaFkSkX7mnY9VLK7cUomorLs16Er3Y=;
        b=Z8zwWoPNWLeVWent7XtKcU1am2mGqNRyR64VEUdmJfPo7jm7NR/6MUFr24wjgBfLea
         yKjK+AL2OBDrAH5bb+1n8sYbuyWm5ACvFhrnGAxLnJ8ylofFgrQuL1C8kkaV+EV98JTV
         NqwIeLm/ix2ihK9LfPeJeyBb31GhB6exldubHBMS2HUg3zqwgyJFEbWQTvu78ufJTuc9
         K5tvC+gYsqO6Yi75aE1xXDiUBQ++Z4fE+FU+ayFvSWe/eYlrQLczxtnywcJuo9Bar47Z
         gn1fvCYdp0BYPN9RRu68aS2bAY2I17wlef2KP6frF5w33d6FTvLcb+7k+lr68vL/tLCz
         ipHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNgubNEXCLIH3oaFkSkX7mnY9VLK7cUomorLs16Er3Y=;
        b=q0/IPgo/ssLn57vy5Hn+73orV39322AVT45EL91OAHRJQUMkTE7kfjCavMegwJDzSP
         7f8QJ/psGkHTtbWlAFh8nT30Ggnm5zAZ1zT1PqDU5mqdN1DtIpbe2ggYtn5xsLukLaJe
         bcvz+wyXcesm2/LrLwtT6JOi53XamkqKcPc4vFMVx2hU3FGg9ZINnk3xaHXqUWN8W5bx
         0Q/igpZ323LsXQF8HtXlC7h3j0ru2aaCr+hDi3cv8UWZC3CeZVPNig2TDJ9H782Yguzp
         cxA9NyLM5oQGheDVDbKeolWPdTN/ozLZM2LFkSGSDxjn3qs2VXXq/oN2R6lAiIh89Qgn
         wiow==
X-Gm-Message-State: ABuFfojCe51J2TZqcCiy005WDUfzz7TDV9HtvdwwMWYi2MfI1p8R+JER
        YWhO3egaQANepJF37kL0Smo3rrntmDt6BQ==
X-Google-Smtp-Source: ACcGV633cc2MWDmIQDp6aXVJ6vCE6XxEXnehWukhwXFr2Jsbkv6Cyt20dlrma9YPoQSWtnO1kGDX2Q==
X-Received: by 2002:a1c:87c9:: with SMTP id j192-v6mr7589554wmd.71.1538365666424;
        Sun, 30 Sep 2018 20:47:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 63-v6sm1833157wmj.39.2018.09.30.20.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 20:47:45 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] cxgb4: Use proper enum in IEEE_FAUX_SYNC
Date:   Sun, 30 Sep 2018 20:47:38 -0700
Message-Id: <20181001034738.29475-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c:390:4: warning: implicit
conversion from enumeration type 'enum cxgb4_dcb_state' to different
enumeration type 'enum cxgb4_dcb_state_input' [-Wenum-conversion]
                        IEEE_FAUX_SYNC(dev, dcb);
                        ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h:70:10: note: expanded
from macro 'IEEE_FAUX_SYNC'
                                            CXGB4_DCB_STATE_FW_ALLSYNCED);
                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the equivalent value of the expected type to silence Clang while
resulting in no functional change.

CXGB4_DCB_STATE_FW_ALLSYNCED = CXGB4_DCB_INPUT_FW_ALLSYNCED = 3

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h
index 02040b99c78a..484ee8290090 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h
@@ -67,7 +67,7 @@
 	do { \
 		if ((__dcb)->dcb_version == FW_PORT_DCB_VER_IEEE) \
 			cxgb4_dcb_state_fsm((__dev), \
-					    CXGB4_DCB_STATE_FW_ALLSYNCED); \
+					    CXGB4_DCB_INPUT_FW_ALLSYNCED); \
 	} while (0)
 
 /* States we can be in for a port's Data Center Bridging.
-- 
2.19.0

