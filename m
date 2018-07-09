Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D571AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCB42089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCB42089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933482AbeGIP0J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:26:09 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:41293 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933081AbeGIP0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:26:07 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M6ydl-1fzQ7615W9-00wjXw; Mon, 09 Jul 2018 17:25:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: xt_tee: fix calling nf_dup_ipv6
Date:   Mon,  9 Jul 2018 17:25:38 +0200
Message-Id: <20180709152546.1177277-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Zyi2ggLT3WyHCKTfDvyP0aV4IAzy86gcDwzL/vd4Bp8w6uLG5f+
 a1ZLCiVAY1xahuuuNLawJKKok5ckcz0JkQ6MNabDddhP5uo288vRpzZxUeCJm3ScKIeNdNw
 C+1j1YJKcxcy7mNxhW4XBIfeLas9vPMxrMxRG9Y8bWeXbzCxODt6mHseX8Zcxq+s/BD2g7E
 jXOV/yBmlH9x9XT1SB35A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jlJz5we5ZuQ=:QUnvjEF96KM0pJV6y1kWsc
 qvAJyvbDwccr4l5/EWRjU7fM3j4hKMS8jeNe0rYlFsGLN6Hk6CQ0a6ktefDgf2s5fI9L5OZ6n
 Y/UTn6xkZ4n/VE+WHHU18RNgqP08r8z5+5/IxGuoO3MVzmKodBBAc+Dt5D0EjNI1H4bYFC4/7
 xa9h+OWR0zJ0jMuYiwQgd30IRFgqhdHKU3PhJXou41h6/ajUU/2NkMzPOUdzQzBbh8fsMAGc9
 QnQ7wJmyfWcGvZPznfghB2wTNelY9hAucqTSK0y/oeEbSyM7BcmgXEkQVr9hg8AuUxlNmyvEQ
 Nq+gfCyaX/bBd5Qf1CS/ZYhRCbopVv3fTXVcgDVz+kZF56o6xChZfSigG/tavGyet6hro7Dav
 T/TwIkQS0ol9NGGJhLa1IjT9evo102f3DHIlj8/dJ+fLwb885lNHITlSwVmbH/TtzJkDvJuv3
 7uYBYjJblHzy40ojr9rRJinNsLkFDPw5FkDqzYipiQPI8Xtmzow5yGZk5/3fnisChgE0RvP4Q
 4IRudDKt/sXCgVl7gLTpoSIStQcYPiFP3v1pnotnxX6u5L+7hifQmtSUO3LzIkJdF4kuSifQc
 EurKLF/ztYvNoxAmSEmdWQorcBSI1AjlQrv9YHP1+knEV/4f+Jwtmqz8M5OsnsVoqIXlRbGCf
 +nRDEim/K+dkuzDdQxyhfj+kBIcR7u8iFOKeak5HY5cTd8zQ9QhDCsghBD0jEqX9HyGw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can enable the NETFILTER_XT_TARGET_TEE option without supporting
TEE on ipv6, we get a build error with NETFILTER_XT_TARGET_TEE=y, IPV6=y and
IP6_NF_IPTABLES=n:

ERROR: "nf_dup_ipv6" [net/netfilter/xt_TEE.ko] undefined!

I previously submitted another patch that fixes the same symptom for the
case of IP6_NF_IPTABLES=m, but missed the fact that there are still
similarly broken configurations.

Fixes: 35bf1ccecaaa ("netfilter: Kconfig: Change IPv6 select dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/netfilter/xt_TEE.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/xt_TEE.c b/net/netfilter/xt_TEE.c
index 475957cfcf50..0d0d68c989df 100644
--- a/net/netfilter/xt_TEE.c
+++ b/net/netfilter/xt_TEE.c
@@ -38,7 +38,7 @@ tee_tg4(struct sk_buff *skb, const struct xt_action_param *par)
 	return XT_CONTINUE;
 }
 
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
 static unsigned int
 tee_tg6(struct sk_buff *skb, const struct xt_action_param *par)
 {
@@ -141,7 +141,7 @@ static struct xt_target tee_tg_reg[] __read_mostly = {
 		.destroy    = tee_tg_destroy,
 		.me         = THIS_MODULE,
 	},
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
 	{
 		.name       = "TEE",
 		.revision   = 1,
-- 
2.9.0

