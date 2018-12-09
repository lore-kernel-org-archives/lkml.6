Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EF2C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D372081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=c0d3.blue header.i=@c0d3.blue header.b="Hk0RX1IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D372081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeLIGVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:21:24 -0500
Received: from mail.aperture-lab.de ([138.201.29.205]:44094 "EHLO
        mail.aperture-lab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeLIGVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:21:24 -0500
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Dec 2018 01:21:21 EST
From:   =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1544336062; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=oNHoiu42/t/ww87E46wJP16iwRyR74KseDxu5fVbDXM=;
        b=Hk0RX1IZ4A4xusHEMxXqrBC1ik1wUXrq5iAO73QOUgGmSK42RLv8EJlKW0rW1iZYPb05Iw
        xuopuq4ty3Hf3EzYLYhnZEErlIsFfT1XN05kQSN9Qul0q44SucWKNkiYvGvFSRaYKnyhGQ
        jETIYZnMMp8p4bgJ8v0NNC8u4C0V1mDIflyEmcNrgFqIQo17/WuvAcV6+T6BxrwtDU02HL
        JV56tJmf4TPTPbZll5qIqbGxTDUYGDHA5fkEtVxea/WpXAqBl3xgW5C6AGH9eg4UaN+KAL
        dbFCV8qlff9FuNWy6DX07M2vQI6PtLuQskrdu7oeoJ1nNKGfyhGeHeVPTlqozw==
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v2] netfilter: ebtables: avoid resetting limit rule state
Date:   Sun,  9 Dec 2018 07:14:05 +0100
Message-Id: <20181209061405.15112-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue;
        s=2018; t=1544336062; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=oNHoiu42/t/ww87E46wJP16iwRyR74KseDxu5fVbDXM=;
        b=a/DSPdOcQJeJldAo9RRTvPiaBya/2nb1D7UgKe+2KuEifskLbZ7IzD6Dd7blpHW4gwrTae
        lq5+aMuXdxIO0tzUbcKqMHMNS9lQ6MsBGQK4+MFVQ7BW7T8tzixbbMsrXeS9uZ21Ipn+gz
        ekwRqufbSv8bDlDuDLieGPybBWoaPpsR9EMeBo5qcjZdQ/dfvQKir/FpbOuc8zV5GkhbMV
        g8stxjGQ0FfAke7SmXOUam2IoNqcLwy7+hK8onIw9hxzcGDb5WuoUNVPR5sVNckxlwyyqR
        7oOIPkYa3l+dvzyyYhtyhZx/qQZVg3+vITSdK5F9iRiNXDP33L4wz7NiSCuQMg==
ARC-Seal: i=1; s=2018; d=c0d3.blue; t=1544336062; a=rsa-sha256; cv=none;
        b=ZafTox+1Tboge3Mn7To8WKxfwn87ktKPdtIg76a1XaFSRI4yCmGEEfaxP8UVNHH2hvjOlK
        AUZceFPh9805kb2VuXN/nt3xAOTUZVx/KNKAec4XCunoCLuhdr1XTU1oyEdbfMrKkkL0SV
        +FkrKeUHbZmHs2NcWmZqTvR5j7YJoLGZ8gda1qpQq8OwvNvfShD4N9gxIeEy+/Au/dP5us
        TVtQE2EMMcPNcyvZ7MXh2JeNKwTDcNykQ9CVaGuqWUoRmDt30sopfQZG+y7gp1HvT/5GWp
        STutfZi3HZrZdpziQWeFHgDmV+jGL2as+OW3MqRNEgICZf6HgbAoucG8OvJNHg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far any changes with ebtables will reset the state of limit rules,
leading to spikes in traffic. This is especially noticeable if changes
are done frequently, for instance via a daemon.

This patch fixes this by bailing out from (re)setting if the limit
rule was initialized before.

When sending packets every 250ms for 600s, with a
"--limit 1/sec --limit-burst 50" rule and a command like this
in the background:

$ ebtables -N VOIDCHAIN
$ while true; do ebtables -F VOIDCHAIN; sleep 30; done

The results are:

Before: ~1600 packets
After: 650 packets

This also aligns the behavior to "xtables-nft-multi ebtables" which uses
nft_limit instead of ebt_limit. In tests nft_limit did not suffer from
this issue and rate limited to 650 just fine.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

Changelog v2:

- Adjusted commit message (adjusted title, added test results with
  nft_limit for comparison)
- Excluded rate limiting variables from zeroing when passed to userspace
  by increasing .usersize. This became necessary with 4.11 /
  commit ec2318904965 ("xtables: extend matches and targets with .usersize")
- Retested with 4.20-rc4 and current net-next/master (83af01ba1c2d)

v1 was:

"[net-next] bridge: ebtables: Avoid resetting limit rule state"
-> https://lore.kernel.org/patchwork/patch/854802/
---
 net/bridge/netfilter/ebt_limit.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebt_limit.c b/net/bridge/netfilter/ebt_limit.c
index 165b9d678cf1..2cf9861c3bce 100644
--- a/net/bridge/netfilter/ebt_limit.c
+++ b/net/bridge/netfilter/ebt_limit.c
@@ -69,6 +69,10 @@ static int ebt_limit_mt_check(const struct xt_mtchk_param *par)
 {
 	struct ebt_limit_info *info = par->matchinfo;
 
+	/* Do not reset state on unrelated table changes */
+	if (info->prev)
+		return 0;
+
 	/* Check for overflow. */
 	if (info->burst == 0 ||
 	    user2credits(info->avg * info->burst) < user2credits(info->avg)) {
@@ -105,7 +109,7 @@ static struct xt_match ebt_limit_mt_reg __read_mostly = {
 	.match		= ebt_limit_mt,
 	.checkentry	= ebt_limit_mt_check,
 	.matchsize	= sizeof(struct ebt_limit_info),
-	.usersize	= offsetof(struct ebt_limit_info, prev),
+	.usersize	= sizeof(struct ebt_limit_info),
 #ifdef CONFIG_COMPAT
 	.compatsize	= sizeof(struct ebt_compat_limit_info),
 #endif
-- 
2.11.0

