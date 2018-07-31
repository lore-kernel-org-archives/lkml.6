Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CF0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23FF20857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23FF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeGaWzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:55:49 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45730 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeGaWzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:55:49 -0400
Received: by mail-io0-f194.google.com with SMTP id k16-v6so14277041iom.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wmt8Fw3hF+mPWm2h8R/mssVWL5mTsEcAK60fqIEJ8Fw=;
        b=tX7iMwcChOt5Xx/teGZwhWbO1OU2+WXXag2xURpEZpqo5DcnUvmgf3Yignu9MAvpFU
         6l1Y3xcZAwqqEjBPM3I5dh4CH4b5bRirHRvNYSyWvHjeWdzP7SWfkXr9TgmwWKFsZiD+
         fZh+3Yx6r2ajoE7g7VEiJX49gXsWzrCiGUcAKufop1EN6iOpR21YUV0q3FmNfRnyvlQx
         +mZkeo3+LkI6B3JD8eNn9/weC0nsGedaK9EmrXQZRs5BBRrj5ippvcK0A7kOhwhBEszm
         NLq6tAJp1zcfBW13+LxDRiYOnh13G+DLbFT6kRtftc/keyK6+U/Q8qfgo2uQoVDHHlnZ
         NqLw==
X-Gm-Message-State: AOUpUlFLUz55rjLOx1oCmA7VwJr4pJIJvrQ+5fag2rs2ngdrW4F8Gybs
        BwXGpW3F22eiFKXIhKTy/2ROrg==
X-Google-Smtp-Source: AAOMgpfrB5+1vtP5/nJaT8YilZbaqqKm0MfAYDHb2d/4G6qA4Mr8Ep/p9JABpuQr62qI1oSdtDHOlA==
X-Received: by 2002:a5e:da41:: with SMTP id o1-v6mr1204123iop.81.1533071615062;
        Tue, 31 Jul 2018 14:13:35 -0700 (PDT)
Received: from builder.jcline.org ([2605:a601:80ce:4700:77a5:8983:ea8b:82ec])
        by smtp.gmail.com with ESMTPSA id j6-v6sm4813955iog.39.2018.07.31.14.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 14:13:34 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] netlink: Fix spectre v1 gadget in netlink_create()
Date:   Tue, 31 Jul 2018 21:13:16 +0000
Message-Id: <20180731211316.12971-1-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'protocol' is a user-controlled value, so sanitize it after the bounds
check to avoid using it for speculative out-of-bounds access to arrays
indexed by it.

This addresses the following accesses detected with the help of smatch:

* net/netlink/af_netlink.c:654 __netlink_create() warn: potential
  spectre issue 'nlk_cb_mutex_keys' [w]

* net/netlink/af_netlink.c:654 __netlink_create() warn: potential
  spectre issue 'nlk_cb_mutex_key_strings' [w]

* net/netlink/af_netlink.c:685 netlink_create() warn: potential spectre
  issue 'nl_table' [w] (local cap)

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 net/netlink/af_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 393573a99a5a..59dac45ad452 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -63,6 +63,7 @@
 #include <linux/hash.h>
 #include <linux/genetlink.h>
 #include <linux/net_namespace.h>
+#include <linux/nospec.h>
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
@@ -679,6 +680,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
 
 	if (protocol < 0 || protocol >= MAX_LINKS)
 		return -EPROTONOSUPPORT;
+	protocol = array_index_nospec(protocol, MAX_LINKS);
 
 	netlink_lock_table();
 #ifdef CONFIG_MODULES
-- 
2.17.1

