Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33973C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC6E2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfBCOZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:25:18 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55712 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730351AbfBCOVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:11 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdx-0006Ot-UV; Sun, 03 Feb 2019 14:21:10 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Y-0006yK-Fb; Sun, 03 Feb 2019 14:49:44 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Nathan Chancellor" <natechancellor@gmail.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.423651486@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 103/305] clk: s2mps11: Add used attribute to
 s2mps11_dt_match
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <natechancellor@gmail.com>

commit 9c940bbe2bb47e03ca5e937d30b6a50bf9c0e671 upstream.

Clang warns after commit 8985167ecf57 ("clk: s2mps11: Fix matching when
built as module and DT node contains compatible"):

drivers/clk/clk-s2mps11.c:242:34: warning: variable 's2mps11_dt_match'
is not needed and will not be emitted [-Wunneeded-internal-declaration]
static const struct of_device_id s2mps11_dt_match[] = {
                                 ^
1 warning generated.

This warning happens when a variable is used in some construct that
doesn't require a reference to that variable to be emitted in the symbol
table; in this case, it's MODULE_DEVICE_TABLE, which only needs to hold
the data of the variable, not the variable itself.

$ nm -S drivers/clk/clk-s2mps11.o | rg s2mps11_dt_match
00000078 000003d4 R __mod_of__s2mps11_dt_match_device_table

Normally, with device ID table variables, it means that the variable
just needs to be tied to the device declaration at the bottom of the
file, like s2mps11_clk_id:

$ nm -S drivers/clk/clk-s2mps11.o | rg s2mps11_clk_id
00000000 00000078 R __mod_platform__s2mps11_clk_id_device_table
00000000 00000078 r s2mps11_clk_id

However, because the comment above this deliberately doesn't want this
variable added to .of_match_table, we need to mark s2mps11_dt_match as
__used to silence this warning. This makes it clear to Clang that the
variable is used for something, even if a reference to it isn't being
emitted.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Fixes: 8985167ecf57 ("clk: s2mps11: Fix matching when built as module and DT node contains compatible")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/clk/clk-s2mps11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -306,7 +306,7 @@ MODULE_DEVICE_TABLE(platform, s2mps11_cl
  * This requires of_device_id table.  In the same time this will not change the
  * actual *device* matching so do not add .of_match_table.
  */
-static const struct of_device_id s2mps11_dt_match[] = {
+static const struct of_device_id s2mps11_dt_match[] __used = {
 	{
 		.compatible = "samsung,s2mps11-clk",
 		.data = (void *)S2MPS11X,

