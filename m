Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A5EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BAB2150A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BdbruaX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BAB2150A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbeHBMcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:32:50 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:34111 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeHBMct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:32:49 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180802104213epoutp03b81e54e21983f106827bf446d85d4125~HCzglT2PZ2581325813epoutp03B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 10:42:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180802104213epoutp03b81e54e21983f106827bf446d85d4125~HCzglT2PZ2581325813epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533206533;
        bh=sLUXq53o9A5NmwTnlDAViIX1TekyJ+FxutbJx+U2ljM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BdbruaX6wNE8xNrRceZkXDAp0KvodHQjNjo05yHcjzc88ca69xhmuYdJSIq4lC28o
         4z6AWlMo0lWgB3faZlByX+ZaPXsJsf2G3WIr5Yk1TWyUO4RRcZwR2fOVba7t9W/Ewx
         1HGCsqwNMqKuRkM168os37ogKy+YRsJlJyuHrhts=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.194]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20180802104213epcas5p318d54dfbbb020be4f7a77c6f1e6ac68b~HCzf-FiOS0726307263epcas5p3b;
        Thu,  2 Aug 2018 10:42:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.B0.04304.500E26B5; Thu,  2 Aug 2018 19:42:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20180802100201epcas5p390bb362ccabaa99087eff88af37bffb2~HCQZjTEZd0101301013epcas5p3C;
        Thu,  2 Aug 2018 10:02:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180802100201epsmtrp18e84f8487533ad5aba8c0417a1a41484~HCQZhnMWY2448424484epsmtrp1L;
        Thu,  2 Aug 2018 10:02:01 +0000 (GMT)
X-AuditID: b6c32a4b-221ff700000010d0-30-5b62e0058ee7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.FA.03889.996D26B5; Thu,  2 Aug 2018 19:02:01 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180802100159epsmtip1fede2a466d01be43b5dfbce890dfa7b7~HCQXv9T-d2866628666epsmtip15;
        Thu,  2 Aug 2018 10:01:59 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     davem@davemloft.net, shuahkh@osg.samsung.com
Cc:     netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, edumazet@google.com,
        pankaj.m@samsung.com, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 1/1] selftest/net: fix protocol family to work for IPv4.
Date:   Thu,  2 Aug 2018 15:27:27 +0530
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmli7rg6Rog7fX+Swu7k61mHO+hcXi
        6bFH7Babv3ewWVzeNYfN4vD8NhaLYwvELO692cpkMfXLBxaLQyfnMjpweWxZeZPJY8GmUo8t
        /XfZPfq2rGL0+LxJLoA1KtUmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
        1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUrShoZGeoYG5npERkDaN
        tTIyBSpJSM1YfUKlYBZbxZRV75gaGKezdjFyckgImEh0/XjFBmILCexmlNi4rKSLkQvI/sQo
        8fDzKjYI5xujxLrt51m6GDnAOjZsNIOI7wVqmL2PEcL5wijRe+IZC8goNgE9iVW79oDZIgIG
        EvdWzmEGKWIWeMMo8fz8PiaQhLCAh8TxR3PB7mARUJV40/uVDeImOYmTxyazgjRICMxgk9hx
        bRtYEa9AmcTxpctZIIpcJJrXbmKCsIUlXh3fwg5hS0m87G9jh2huZ5S4PvMaC4QzhVGi8/1K
        qCp7iQc3jrKDPMQsoCmxfpc+RFhWYuqpdWBDmQX4JHp/P4FawCuxYx6MrSrRcnMDNPSkJT5/
        /Ah1kIfEi45d0JCMldh2aj77BEbZWQgbFjAyrmKUTC0ozk1PLTYtMM5LLdcrTswtLs1L10vO
        z93ECE5kWt47GDed8znEKMDBqMTDe4MhKVqINbGsuDL3EKMEB7OSCG+zB1CINyWxsiq1KD++
        qDQntfgQoykwCCcyS4km5wOTbF5JvKGpkZmZgaWBqbGFmaGSOO8Hv+BoIYH0xJLU7NTUgtQi
        mD4mDk6pBkaGtftDHCaWTi911Ts2u3brt0yvn0LRqx/p/t/z4136p13vF0i92Vl6vSScVXGT
        esScXeKSMmpL97m6LmxI3XljgV3+3PUn1fp8/7PMvflHSfqdTK17KUvHvJksc61WJp16Hn6j
        v+601INfl7xyVKaGq96unH9hQsCiS1ILV96Oa9m/56tJ59ZLSizFGYmGWsxFxYkAIssn+HoD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWy7bCSnO7Ma0nRBjcOM1tc3J1qMed8C4vF
        02OP2C02f+9gs7i8aw6bxeH5bSwWxxaIWdx7s5XJYuqXDywWh07OZXTg8tiy8iaTx4JNpR5b
        +u+ye/RtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfG6hMqBbPYKqasesfUwDidtYuRg0NCwERi
        w0azLkYuDiGB3YwSP08eZu9i5ASKS0v8/PeeBcIWllj57zk7RNEnRon9L/+ygiTYBPQkVu3a
        A1YkImAk0XX1EBuIzSzwhVGitd0XxBYW8JA4/mguWD2LgKrEm96vYDW8Am4Sv472MkEskJM4
        eWwy6wRGngWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYJDS0trB+OJE/GHGAU4
        GJV4eBv+JUYLsSaWFVfmHmKU4GBWEuFt9kiKFuJNSaysSi3Kjy8qzUktPsQozcGiJM4rn38s
        UkggPbEkNTs1tSC1CCbLxMEp1cCYeNx+6QnWH26cv5p9T/S3za2/fXhW4qwv/0QWl83fYXJt
        s8Xrz307F/+R2Vqx4sBbnv+Z68u0rt5dVdd2xnHqzK+9sbOPdxmnHJmU6tNou9ji8V5XC5b2
        6LN1RSrdEeYy/WUMXmf65guJrjxhbjH5zxWVZYu255btjlVRknw0cXPOtcf/9pYsUmIpzkg0
        1GIuKk4EADqP4q4pAgAA
Message-Id: <20180802100201epcas5p390bb362ccabaa99087eff88af37bffb2~HCQZjTEZd0101301013epcas5p3C@epcas5p3.samsung.com>
X-CMS-MailID: 20180802100201epcas5p390bb362ccabaa99087eff88af37bffb2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180802100201epcas5p390bb362ccabaa99087eff88af37bffb2
References: <CGME20180802100201epcas5p390bb362ccabaa99087eff88af37bffb2@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use actual protocol family passed by user rather than hardcoded
AF_INTE6 to cerate sockets.
current code is not working for IPv4.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
 tools/testing/selftests/net/tcp_mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
index 77f7627..e8c5dff 100644
--- a/tools/testing/selftests/net/tcp_mmap.c
+++ b/tools/testing/selftests/net/tcp_mmap.c
@@ -402,7 +402,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	fd = socket(cfg_family, SOCK_STREAM, 0);
 	if (fd == -1) {
 		perror("socket");
 		exit(1);
-- 
1.9.1

