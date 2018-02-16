Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-399776-1518794915-5-10635128387653813616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518794915; b=s4EmqVnjD2kldYWtl2EcBwVQTxR3ohPvz/EVJJ/AdLZMGu8
    s0RzrRayMNaksj7PZ3rhyLlZ8CYa5y3CvEE6Oy3zWdlMuepWnQCnJMdNjrNwAUxX
    wa69sXHVdMr222C1KtKOXyGXVtj60kJDTuIddXcelEACOYPniXxhYZSO7a4rH+Sh
    s/DoDjmAjCjqVKHiBguoGU7ADVxrWJe6q9ibhENGs6lDPJs+MTj2goEX7JCgUGXt
    xx5cAigu5mZc96h/peYrXxaCA6Q84RFPK4iPzroxM6KhD1WQiJ7dvpK0XiBGt8e6
    F33ed60HZwX38DB2zal9Qzmivws88KT9MscZluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518794915; bh=4/82fOTzvgyAaCDpFwIp3PFX3p
    9i0yon9pl9Gd+y+Jc=; b=MJ8gqiCU8OdQzirqW73txjvUtNVw/SrWwrW9yVyR3R
    Tq4LJUSDP5mPly46JoZA2xPL2niKRuxepU7xyVsDIKNTX7ZMNa/mDReDu2cRdzRK
    0m3MNR1CEDtUytEdOZL5v88QCbcb19eLEpAGzCZKywxit49Xgafjydt7HXc1VRnX
    kOhk6aXr6xo7AQS63x2MY5bkshJvX/01xcrX8iMELF54DLkHKkXJJH3MnmTBC7QD
    HOyr3++QT35RnkigygCJZ10TRtv14e7e1SmexgMt20xbHvklIcbXpv5Y8wLYm67t
    gr8SwQtWxUg4+V3sDTvS7Z8ZX56jrS4FXBi5sZ6oHffg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030285AbeBPP2T (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 10:28:19 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:38491 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030266AbeBPP2R (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 10:28:17 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: fix false-positive Wmaybe-uninitialized warning
Date: Fri, 16 Feb 2018 16:27:47 +0100
Message-Id: <20180216152807.1629038-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:iyeRScIsRZi3vjs/r63vmKfKEw2frPNzKJNNqp7CYyFbeikwvaQ
 AeLiS+KmOY6f2us7oV8cgCj7vJvSylqLgMzWIKE/82az7OoVNZIaAopfxVyW0C544QsuzVR
 PkrB7ydPw33c1VCuSrVjIhp/qnzArdzl9epu8KU24PHMagNOG10oSnUpVpQcKZxkICkiAcy
 5p2HxkvDxTCbSo0w2ZfQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:14G+KML9F6A=:s0AfaDwiN+uxF0LriP3hiy
 RfaAU/mzWR4FvjDFU6cbZxdqWDnbTfEBr6Zz/51EyknUy1ymU6HkzFzyQj8DdMme6bxPniGvA
 Jp0WklubgX8BX5O2Yk2rTNy8cd00BsN5oC6fLPwqyyWSRuJkNFNiFoJztC+5UCvb6uXI3aPTV
 n/mz282oDzkDmsjx1pZUJnNfyGQ/y/ZSOipd7313z8+EYk0Ivhx/XUg1X7eC0tV4DM8NFE0kR
 VSdNN0bcRLDHXR12A3Gu2B2c2uhbBtG9fvzWtY/JriUmOh7tKdSEyTBs1l0PijYXpuBqOIVq9
 bGlRdpDpmqQxZZ8VtmRv/6q4jIXnNEfw6jYli6W3diiBKFg9mrZgdW+aa1GWen0A34VYhTQNx
 1gQKO/nP5tKhx2wljpAOw68tXDQfSe6pL+LZlhqtZxH+z3qght+KHvP0ifyEEAcPsPA5UI6vh
 lKtK2fMDKaiARJukvJJeleWeveSjX8Vv9Js86+OuiYO/Au4LErtLyefTpuOVdD3bpmAlEb2ng
 5wr/0j7+bWBgAMHqcDAM+he1P0kTnOWOM1JLLifWFa+qiBgxQxqdx/a4KpOgRYoF4SQFkbkfK
 uAnv+5quTSqp0cLgzCIoa15LpImeZxZyZ9kx0ty1oe7HQWMWODTl5188Gh+3nyFtzn18S4q+Q
 m8dHoG5L/Fvcc8TQMYa4OMRRe+7JwgBWBIWtBox1UdCuroa/3ayPUH5NK1e5aK/fYou2Q35a0
 j3Jxotfw5kr6jxbDhbWGUOlwW01dsosXexAVmg==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When we build this driver with on x86-32, gcc produces a false-positive warning:

drivers/clk/renesas/clk-sh73a0.c: In function 'sh73a0_cpg_clocks_init':
drivers/clk/renesas/clk-sh73a0.c:155:10: error: 'parent_name' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   return clk_register_fixed_factor(NULL, name, parent_name, 0,

We can work around that warning by adding a fake initialization, I tried
and failed to come up with any better workaround. This is currently one
of few remaining warnings for a 4.14.y randconfig build, so it would be
good to also have it backported at least to that version. Older versions
have more randconfig warnings, so we might not care.

I had not noticed this earlier, because one patch in my randconfig test
tree removes the '-ffreestanding' option on x86-32, and that avoids
the warning. The -ffreestanding flag was originally global but moved
into arch/i386 by Andi Kleen in commit 6edfba1b33c7 ("[PATCH] x86_64:
Don't define string functions to builtin") as a 'temporary workaround'.

Like many temporary hacks, this turned out to be rather long-lived, from
all I can tell we still need a simple fix to asm/string_32.h before it
can be removed, but I'm not sure about how to best do that.

Cc: stable@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/renesas/clk-sh73a0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/clk-sh73a0.c b/drivers/clk/renesas/clk-sh73a0.c
index eea38f6ea77e..3892346c4fcc 100644
--- a/drivers/clk/renesas/clk-sh73a0.c
+++ b/drivers/clk/renesas/clk-sh73a0.c
@@ -46,7 +46,7 @@ struct div4_clk {
 	unsigned int shift;
 };
 
-static struct div4_clk div4_clks[] = {
+static const struct div4_clk div4_clks[] = {
 	{ "zg", "pll0", CPG_FRQCRA, 16 },
 	{ "m3", "pll1", CPG_FRQCRA, 12 },
 	{ "b",  "pll1", CPG_FRQCRA,  8 },
@@ -79,7 +79,7 @@ sh73a0_cpg_register_clock(struct device_node *np, struct sh73a0_cpg *cpg,
 {
 	const struct clk_div_table *table = NULL;
 	unsigned int shift, reg, width;
-	const char *parent_name;
+	const char *parent_name = NULL;
 	unsigned int mult = 1;
 	unsigned int div = 1;
 
@@ -135,7 +135,7 @@ sh73a0_cpg_register_clock(struct device_node *np, struct sh73a0_cpg *cpg,
 		shift = 24;
 		width = 5;
 	} else {
-		struct div4_clk *c;
+		const struct div4_clk *c;
 
 		for (c = div4_clks; c->name; c++) {
 			if (!strcmp(name, c->name)) {
-- 
2.9.0
