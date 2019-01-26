Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35323C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 22:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032D92184C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 22:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="qBfziX+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfAZWkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 17:40:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40671 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfAZWkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 17:40:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so6296806pfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 14:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czvbKr9B+EvUXOh/KxPcjLLJafEzm1/2XYBjHSTOhQs=;
        b=qBfziX+pXsXKKxv+8RCJRt7Io03DQrtTVbUCYoerDHnO86KlfSKF9C871eNVzqwL0O
         n6DgJthFSjtNT8BhrZvJblwJFSiDod/iT8z3JfZOHzsuQvzN5ZnQEFNoxpglpMUE4CTH
         /t006cfLbLHt5i9k7EZqcwVn7k3sP1ukiwbt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czvbKr9B+EvUXOh/KxPcjLLJafEzm1/2XYBjHSTOhQs=;
        b=OkdERzgcjE62g46SXIEgVIleDYM9iIYIFbW6oEW6hg4QAiQoF3OM8W1OlMcN9vDTQz
         ptYQDDOdonh34NsbcPaxHTu/HwQ0z/9HOWSlXAJxlaF58iccboWEZ029kqM4mt5nuMDL
         8jF6lEmhx3XfXSrzh7yYVKwWAjfAJ6b7ruDO1Awzr55haidQKmDcs3dcuP5AVDd2V4A1
         EF9wRkZxVF6pH2IV6WZvb3NA6cEqI5JrcafxTdVzsJ18pxELlsAjHzC7xtw/o+dB6AUq
         P+dCnZ2fwekprO+0lCg+qhJa9aRRKclSKVWFWniG2yddqzgnBqIu7uns9AW1caJCMHTX
         Wv4w==
X-Gm-Message-State: AJcUukf7TN6YMj434ArZxLLmD8r50TQ8Z7tn1I33rSD6OhbEvKuHG0Oj
        ryN46meI2ESCY1t6bU2VEN/7dMnp0+Dz
X-Google-Smtp-Source: ALg8bN7HDsHkFD7WdxQl5QhepcUeK+8RiP5MQRADWfPDHo+dPaVScL8djAk9DTSYPO6Z1TAQX5t4qQ==
X-Received: by 2002:a63:d005:: with SMTP id z5mr14682425pgf.64.1548542412547;
        Sat, 26 Jan 2019 14:40:12 -0800 (PST)
Received: from debian9-jae.jaalam.net (dhcp-128-189-224-133.ubcsecure.wireless.ubc.ca. [128.189.224.133])
        by smtp.gmail.com with ESMTPSA id p2sm38441308pfp.125.2019.01.26.14.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 14:40:11 -0800 (PST)
From:   Josh Elsasser <jelsasser@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     josh@elsasser.ca, Josh Elsasser <jelsasser@appneta.com>,
        Edward Cree <ecree@solarflare.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        Eric Dumazet <edumazet@google.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Li RongQing <lirongqing@baidu.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: set default network namespace in init_dummy_netdev()
Date:   Sat, 26 Jan 2019 14:38:33 -0800
Message-Id: <20190126223835.14613-1-jelsasser@appneta.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign a default net namespace to netdevs created by init_dummy_netdev().
Fixes a NULL pointer dereference caused by busy-polling a socket bound to
an iwlwifi wireless device, which bumps the per-net BUSYPOLLRXPACKETS stat
if napi_poll() received packets:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000190
  IP: napi_busy_loop+0xd6/0x200
  Call Trace:
    sock_poll+0x5e/0x80
    do_sys_poll+0x324/0x5a0
    SyS_poll+0x6c/0xf0
    do_syscall_64+0x6b/0x1f0
    entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: 7db6b048da3b ("net: Commonize busy polling code to focus on napi_id instead of socket")
Signed-off-by: Josh Elsasser <jelsasser@appneta.com>
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 82f20022259d..d1043d49979c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8712,7 +8712,9 @@ int init_dummy_netdev(struct net_device *dev)
 	set_bit(__LINK_STATE_PRESENT, &dev->state);
 	set_bit(__LINK_STATE_START, &dev->state);
 
+	/* napi_busy_loop stats accounting wants this */
+	dev_net_set(dev, &init_net);
+
 	/* Note : We dont allocate pcpu_refcnt for dummy devices,
 	 * because users of this 'device' dont need to change
 	 * its refcount.
-- 
2.19.1

