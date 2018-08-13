Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073E7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14162171F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14162171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbeHNALG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:11:06 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44585 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbeHNALG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:11:06 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M16aW-1g8vcM2BFA-00tC3M; Mon, 13 Aug 2018 23:27:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bnxt_en: avoid string overflow for record->system_name
Date:   Mon, 13 Aug 2018 23:26:54 +0200
Message-Id: <20180813212700.2681499-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:gH6T27BtgypcwrQwANOFw6VbcUIQ7DkW+PBxph1zc2WO063OYYW
 2zQ6k+BKwShTWB76QKb4x1QhTP5aotQ78Q8yWzzLmYic0aD822fwoLepOIkft/Z+lAw9sFB
 Yf1HogllWYCOk3kv2kItROR5gYmp1/1JvuUc651iarMKKDEaBH/kffc7Rm6WVmtrjd22O6r
 zkGlZiB+msOSCTp7CeIjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UElvnY30Nu8=:EfGJLYWqscyl6H/hyYt81x
 cjjUqengUYR5b+pKESXvBMt+W0r4ko5f19S9jFQKAPt1dnMiEt4HyRqEiE7FAmGWNb6NpoCdM
 9FnZbk7in0Z7gYk56NFWd9/AVFGX0SCYPXJjBu7kCdWjBYg+PxzEfYRfmkEcrc6J4OY3851co
 4+2dMkodAdhgrHzVGZMnr7QpaJhx8ozbOKTboAYpE+UEcAiPbRMAs8eQR7yyBcHd5ZcaYf7Wv
 U35vHG7VTbsnUPbdcDsCydekOivNmWG4vA+gS+RNRJjzRQDHAQOLWbwJ0TUzNc3ouOMYyjV78
 4PHdYpxKVhPIZ1r96rbe5afi7+bbVFNkrzLp7syZUEqWIUB2pQaqdikEy247Yv1OqBz2rkgST
 YByhyc+CVIVPOAO7ZEFJuxgMWAX8uZfqNkpiki30MdkwMhTR9ZPuIs/wWOwPiC0WIYExQebyP
 jgyuOURmu7KXVQe3FDc+zfZz8PPImy2RjZzt40m4svP4tbqMSLRaWnP1T1+Cgze/t+KOf5oT5
 xAa4pW6RSHc+1v9+2uB8PDNPPuuQG+xZurZDaBDp0OUL+nmtifhC3SO3faexm3KQLxDBwshyF
 MauVV+S8jw9fAX1gPMzassRPwLQJvANm9+cJHmFF3g25kIACTvne/c6gJvSQ8Fl+ZR2gQqEgK
 MlrdYxIsXtac2Vayon2FqeMeelxD93ZmVC8ZPgVdWerrzQdii4NWQhnRtHGinhDEp0/E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The utsname()->nodename string may be 64 bytes long, and it gets
copied without the trailing nul byte into the shorter record->system_name,
as gcc now warns:

In file included from include/linux/bitmap.h:9,
                 from include/linux/ethtool.h:16,
                 from drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:13:
In function 'strncpy',
    inlined from 'bnxt_fill_coredump_record' at drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:2863:2:
include/linux/string.h:254:9: error: '__builtin_strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Werror=stringop-truncation]

Using strlcpy() at least avoids overflowing the destination buffer
and adds proper nul-termination. It may still truncate long names
though, which probably can't be solved here.

Fixes: 6c5657d085ae ("bnxt_en: Add support for ethtool get dump.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index b1602ea64372..e52d7af3ab3e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2860,8 +2860,8 @@ bnxt_fill_coredump_record(struct bnxt *bp, struct bnxt_coredump_record *record,
 	record->low_version = 0;
 	record->high_version = 1;
 	record->asic_state = 0;
-	strncpy(record->system_name, utsname()->nodename,
-		strlen(utsname()->nodename));
+	strlcpy(record->system_name, utsname()->nodename,
+		sizeof(record->system_name));
 	record->year = cpu_to_le16(tm.tm_year);
 	record->month = cpu_to_le16(tm.tm_mon);
 	record->day = cpu_to_le16(tm.tm_mday);
-- 
2.18.0

