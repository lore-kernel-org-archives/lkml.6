Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F9EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC49206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyVXkCcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC49206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbeKVFnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbeKVFnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9489214DB;
        Wed, 21 Nov 2018 19:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827250;
        bh=Q+uqVGMG8QMA6Yij3tVZEVdwXY2TsRERJygcQkvaRT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NyVXkCcGp+XruO/uoVPWnBdo9eHJj29XDlBz/wpUL6rch4tiBZakpxzG2wU+BuRxe
         MxBJMAFbiyzchup8L61VoJ6bhZiSENQSQXwA/TM4F+LlnBamvqenaEkKkWf/16DAGA
         Nh5WlhWbKrssVaiZ4yFTmhE0g7mYi+5GHZmBL9SI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 30/42] net: dsa: mv88e6xxx: Fix clearing of stats counters
Date:   Wed, 21 Nov 2018 20:06:06 +0100
Message-Id: <20181121183149.288064693@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit a9049ff9214da68df1179a7d5e36b43479abc9b8 ]

The mv88e6161 would sometime fail to probe with a timeout waiting for
the switch to complete an operation. This operation is supposed to
clear the statistics counters. However, due to a read/modify/write,
without the needed mask, the operation actually carried out was more
random, with invalid parameters, resulting in the switch not
responding. We need to preserve the histogram mode bits, so apply a
mask to keep them.

Reported-by: Chris Healy <Chris.Healy@zii.aero>
Fixes: 40cff8fca9e3 ("net: dsa: mv88e6xxx: Fix stats histogram mode")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/global1.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -567,6 +567,8 @@ int mv88e6xxx_g1_stats_clear(struct mv88
 	if (err)
 		return err;
 
+	/* Keep the histogram mode bits */
+	val &= MV88E6XXX_G1_STATS_OP_HIST_RX_TX;
 	val |= MV88E6XXX_G1_STATS_OP_BUSY | MV88E6XXX_G1_STATS_OP_FLUSH_ALL;
 
 	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_STATS_OP, val);


