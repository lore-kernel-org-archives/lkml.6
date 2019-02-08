Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2DEC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CDC21916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy0udnz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfBHEsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:48:12 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43084 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfBHEsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:48:11 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so1709668eds.10;
        Thu, 07 Feb 2019 20:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZK2ARna89nwub9SrCDuV8r5zp5Wp4HvW14CW+Lai6c=;
        b=Iy0udnz47VF/VsGRubEsMZgIofvyywYL7HC2YbNvYz0bm//iFFhErr4h55wMGO7Ycx
         L67zioQqR3tUx9L8PqKV7P9sko1aHoYsI9ovT50FQ1xNnNLxU4ZEKmfLmVmER8rIL2w6
         GwoHisowxBPuSWzdZn1CRZ6R+Zfhqp/P4laVW53bL28IrmSzhm+9tuerB4gDF2oxFCWt
         In0thZi4wWkCDPGvscINfJLYqGv+rlRq+6BPuYjqCfRGzC1Rd5CwxH2guJzmyvQEK+M6
         WTf2FbcA9t9eC/AVqlStTsJVpDDVQdWUiWJex39T+vX03jJzmWFea2TokKU/CfqgWKVV
         vihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZK2ARna89nwub9SrCDuV8r5zp5Wp4HvW14CW+Lai6c=;
        b=AKEIh/SKDBikV2RzYkn0hyapClsRGYvsOYZEWTYaRafHsZiW6atqKbWTGh17h/a0p0
         ZxePrzZfTwjPoz3/8m/mVXLHmacKMfgWLDF6n5QxerMIjGepP1LXEEDuQuspbAsjVVkQ
         obwWg+CEdHeIa7zfNJyPVHyqcqAAcLGvEj2fBv5osvAF57PKbAJcZWNFTYr4Q2u0Rd1g
         VjzDn2K/34wuSV4icxgo03mzSAVrO272WAYjAeO++sg7xA6B9c+Ni3WYtEmr0aZKPTyg
         MHCzMSG8Sn9hqv0hsQqHB6rv3puWuIAUffpYJIEGngJ+IKIOHD2UaGBOGRwk3S2gO2Ju
         9lGg==
X-Gm-Message-State: AHQUAuZJ9OoaEe4zvbTSpBNnQm8HBdQ5gqrDSw5LglECe2rY5VPTM8ib
        t2Nwt2/HhsZsJbWDn9NMW6k=
X-Google-Smtp-Source: AHgI3IY3yq7YvIXzkEWIHvI7AqBrumkWAAveKQJmE/5AXl/bd6YgZ666M84mNXHyqvzjR5PLAI4xGg==
X-Received: by 2002:a17:906:5048:: with SMTP id e8mr14460288ejk.214.1549601289261;
        Thu, 07 Feb 2019 20:48:09 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id b46sm323417edd.94.2019.02.07.20.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 20:48:08 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH net-next] ethtool: Remove unnecessary null check in ethtool_rx_flow_rule_create
Date:   Thu,  7 Feb 2019 21:46:53 -0700
Message-Id: <20190208044652.32166-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

net/core/ethtool.c:3023:19: warning: address of array
'ext_m_spec->h_dest' will always evaluate to 'true'
[-Wpointer-bool-conversion]
                if (ext_m_spec->h_dest) {
                ~~  ~~~~~~~~~~~~^~~~~~

h_dest is an array, it can't be null so remove this check.

Fixes: eca4205f9ec3 ("ethtool: add ethtool_rx_flow_spec to flow_rule structure translator")
Link: https://github.com/ClangBuiltLinux/linux/issues/353
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 net/core/ethtool.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index 0fbf39239b29..d2c47cdf25da 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -3020,17 +3020,15 @@ ethtool_rx_flow_rule_create(const struct ethtool_rx_flow_spec_input *input)
 		const struct ethtool_flow_ext *ext_h_spec = &fs->h_ext;
 		const struct ethtool_flow_ext *ext_m_spec = &fs->m_ext;
 
-		if (ext_m_spec->h_dest) {
-			memcpy(match->key.eth_addrs.dst, ext_h_spec->h_dest,
-			       ETH_ALEN);
-			memcpy(match->mask.eth_addrs.dst, ext_m_spec->h_dest,
-			       ETH_ALEN);
-
-			match->dissector.used_keys |=
-				BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS);
-			match->dissector.offset[FLOW_DISSECTOR_KEY_ETH_ADDRS] =
-				offsetof(struct ethtool_rx_flow_key, eth_addrs);
-		}
+		memcpy(match->key.eth_addrs.dst, ext_h_spec->h_dest,
+		       ETH_ALEN);
+		memcpy(match->mask.eth_addrs.dst, ext_m_spec->h_dest,
+		       ETH_ALEN);
+
+		match->dissector.used_keys |=
+			BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS);
+		match->dissector.offset[FLOW_DISSECTOR_KEY_ETH_ADDRS] =
+			offsetof(struct ethtool_rx_flow_key, eth_addrs);
 	}
 
 	act = &flow->rule->action.entries[0];
-- 
2.20.1

