Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELt/9ADLOoNd0T6dk/7MpygHKP1IN/zqtGOlQQN9kmD8jlbEr/kw0UJoKP1RueNUVGLuaEbC
ARC-Seal: i=1; a=rsa-sha256; t=1520504255; cv=none;
        d=google.com; s=arc-20160816;
        b=BS3RuiGWJYdK6fMH0TWUsu8ZYiwSh0qTS5XCF6arZ//8zY1fnnsc3t1lGXPkRCEtEp
         gOSjmqmh+2g+PuSiucItyaqgE3OzDPriXl7hD9s+YdAX5rI8PimjRQMZcg0DaLniFM6D
         QmAt9+6NlEUkay1qnwWUEK0WZi6wr5ae2Obvcx8NvFnF0xp65D0K0vS0IxN0s3OXmzNO
         OfgrXeyLgRtZhUyUhFdaXZ9knnEb1Cr7BgfSawm5rSJImK5i8YEkUn1B8Awp/HwMf3mt
         t7XQuTx8ovBL1UKYNdS80A7lIh8G/IxMhXvbZaKjS6mPNJQ42OLGEFTHydzLWOnjDkM+
         WCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=oKuqsNcH2DEucso7zaGePY+9SqCRF9Zk26p+pEdjpxo=;
        b=kFEpJ8SqCzxYyc5LYw+6XafKK3BDxMtwWTTNjYU6Bie2OEBf/YbHoNoQSz7I5N8oKr
         qRXXIRECBFelO4cTHbnE3Zx12XQ2AYjSjJqa26ttkcCojCZHGqDXuiJjosbUOU3kiw+s
         dNmUSltwsTg+gpAYGft2y1W0NfqRQnIpgSbZwN6OTSMTDTmMMkI9Pljs77vqZOt+gQKS
         RQQNtA9+FjSMsWzW5O0zdlSWXBIUvXVycKoPkwgJ4tHJbUENCvww3DdSdRkvxGukVknG
         ChL9DQ+flqm0YH1ypJ/rWkLr54tybD3AKIu3omm5uDcF/Imyfyok36DTXCUqpfAtk6SH
         eIbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=g7cqMDE/;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=g7cqMDE/;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755491AbeCHKRe (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 05:17:34 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42124 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755373AbeCHKRd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 05:17:33 -0500
From: Anders Roxell <anders.roxell@linaro.org>
To: davem@davemloft.net, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/net: enable fragments for fib-onlink-tests
Date: Thu,  8 Mar 2018 11:17:23 +0100
Message-Id: <20180308101723.19721-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594364269879247386?=
X-GMAIL-MSGID: =?utf-8?q?1594364269879247386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We miss CONFIG_* fragments so test fib-onlink-tests.sh can do:
ip li add lisa type vrf table 1101
ip li add veth1 type veth peer name veth2

And the follow message occurs if it isn't enabled:
Configuring interfaces
RTNETLINK answers: Operation not supported

This enables for NET_NRF (and friends) and VETH so we can create a vrf
table and veth.

Fixes: 153e1b84f477 ("selftests: Add FIB onlink tests")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 7177bea1fdfa..6a75a3ea44ad 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -2,3 +2,8 @@ CONFIG_USER_NS=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_TEST_BPF=m
 CONFIG_NUMA=y
+CONFIG_NET_VRF=y
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_IPV6=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_VETH=y
-- 
2.11.0

