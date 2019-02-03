Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6DBC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AC42073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfBCOTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:19:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55146 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728443AbfBCOTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:19:48 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIcc-00062Q-Uv; Sun, 03 Feb 2019 14:19:47 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Z-00070R-F6; Sun, 03 Feb 2019 14:49:45 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jakub Kicinski" <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.78626542@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 120/305] net: sched: gred: pass the right attribute
 to gred_change_table_def()
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

From: Jakub Kicinski <jakub.kicinski@netronome.com>

commit 38b4f18d56372e1e21771ab7b0357b853330186c upstream.

gred_change_table_def() takes a pointer to TCA_GRED_DPS attribute,
and expects it will be able to interpret its contents as
struct tc_gred_sopt.  Pass the correct gred attribute, instead of
TCA_OPTIONS.

This bug meant the table definition could never be changed after
Qdisc was initialized (unless whatever TCA_OPTIONS contained both
passed netlink validation and was a valid struct tc_gred_sopt...).

Old behaviour:
$ ip link add type dummy
$ tc qdisc replace dev dummy0 parent root handle 7: \
     gred setup vqs 4 default 0
$ tc qdisc replace dev dummy0 parent root handle 7: \
     gred setup vqs 4 default 0
RTNETLINK answers: Invalid argument

Now:
$ ip link add type dummy
$ tc qdisc replace dev dummy0 parent root handle 7: \
     gred setup vqs 4 default 0
$ tc qdisc replace dev dummy0 parent root handle 7: \
     gred setup vqs 4 default 0
$ tc qdisc replace dev dummy0 parent root handle 7: \
     gred setup vqs 4 default 0

Fixes: f62d6b936df5 ("[PKT_SCHED]: GRED: Use central VQ change procedure")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sched/sch_gred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -437,7 +437,7 @@ static int gred_change(struct Qdisc *sch
 		return err;
 
 	if (tb[TCA_GRED_PARMS] == NULL && tb[TCA_GRED_STAB] == NULL)
-		return gred_change_table_def(sch, opt);
+		return gred_change_table_def(sch, tb[TCA_GRED_DPS]);
 
 	if (tb[TCA_GRED_PARMS] == NULL ||
 	    tb[TCA_GRED_STAB] == NULL)

