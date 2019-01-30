Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BDEC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E763A20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbfA3STQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:19:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56633 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732721AbfA3STO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:19:14 -0500
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <marcelo.cerri@canonical.com>)
        id 1gouS8-0004Is-HY
        for linux-kernel@vger.kernel.org; Wed, 30 Jan 2019 18:19:12 +0000
Received: by mail-qk1-f200.google.com with SMTP id k203so485978qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v4Kod+YGlCFOYY4e9EVxTY6sboTZZszaR/wjp0V9ViA=;
        b=d6H5ECove/ol5lk63k3DapjhfsaCseaguTJRYCd4H7IavVa/s1n5XyyBwfFcoLljW6
         A5y640ipII6d8/ery4X7IWOXLWcQg3nxnJT46aE542Gp0h488CGEIPq27+6NHAZ6DIjU
         VOxN8qi3+jhzZTtcZ4CkJLuejNdx/thFsxzPUpxZWxj1chyD7MzZZy6uu8C2N2iiq9oP
         4PztS4qf9+Ej1McLoObT3sRiA7kjB6qoOzbxKmafPcNSpm3eHurcpn+taHHmoGuG5Q0u
         Yant/CaY2sBu6b9HJ9g7Us1gcFIbHLdhJvp2xqkChQd+JyLOvYxzBKj7kk3s+lNNE0fI
         DU1w==
X-Gm-Message-State: AJcUuke4HveS4HitzKfaY9Ao2IkANO7qMwMRzttLKO45QNy9VKXzVH8l
        Qggc7mNY3RlxK3pL9RsRS/vD8AnUDZwvMKArn69DmwrNiHuHLNQP1Fq56ywmS7pJiBf4iZx4Mq0
        s2bQEoItjHKr3k7YFNTa1Dpojk5gTTftUNa6E8jbU
X-Received: by 2002:ac8:198f:: with SMTP id u15mr31600517qtj.62.1548872351612;
        Wed, 30 Jan 2019 10:19:11 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7kuUcEj9oW0ogIPKT42CP7jRmiaUhxcig3TY3jeCfrNknHoI4Je/fLjzJcdsapkD/yvh7XdA==
X-Received: by 2002:ac8:198f:: with SMTP id u15mr31600487qtj.62.1548872351216;
        Wed, 30 Jan 2019 10:19:11 -0800 (PST)
Received: from gallifrey.lan ([189.61.208.219])
        by smtp.gmail.com with ESMTPSA id j38sm3035666qtj.72.2019.01.30.10.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:19:10 -0800 (PST)
From:   Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Subject: [PATCH] selftests: net: fix "from" match test in fib_rule_tests.sh
Date:   Wed, 30 Jan 2019 16:19:03 -0200
Message-Id: <20190130181903.16465-1-marcelo.cerri@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the IPv4 address of the dummy0 interface and ensure that ip_forward
is enabled in the network space to get a valid response when checking
for routes between the gateway and other hosts.

Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index d4cfb6a7a086..552a9784e759 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -54,9 +54,11 @@ setup()
 
 	$IP link add dummy0 type dummy
 	$IP link set dev dummy0 up
-	$IP address add 198.51.100.1/24 dev dummy0
+	$IP address add 192.51.100.1/24 dev dummy0
 	$IP -6 address add 2001:db8:1::1/64 dev dummy0
 
+	ip netns exec testns sysctl -w net.ipv4.ip_forward=1
+
 	set +e
 }
 
-- 
2.17.1

