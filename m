Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ECCC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D0C20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107464;
	bh=zKNjQJssegW6hQQZkCg0NjTWHgd8NN2zigPFwoWPY2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E3VO8G2qRuw6lAz7YI9T2oYuxyuwgSAxS8rnbnzqAQwotp/6jIn5x0vgwFzypme3u
	 9jLLUcIkK6inoENMsmz/OzmZ4icYeSm9vjrHtMGmR8+UJGjvkyinMAIGlKQx8V9Wus
	 Np7r3VtYqzoikhHw5Xgr8ngas3lStR5nAo9TLnOg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D0C20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbeLFOoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:44:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730860AbeLFOoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:44:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0727720892;
        Thu,  6 Dec 2018 14:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107460;
        bh=zKNjQJssegW6hQQZkCg0NjTWHgd8NN2zigPFwoWPY2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0NX4zsFjqqo4zY2KIdyTnf1uUmpt+3u46DhX4W49wHYE7HDCoVbKWesB8/GRf4Ew
         abX4ozIU6Tf42siyHXkOS5TgUrvo4oc2tZRCxiASA4LK5vduBNJG2d3D96NxdPl38k
         d0Xblbt+cC7cDQh67myuRB7GjauUAIEOrstnCzAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Mathias Kresin <dev@kresin.me>,
        Paul Burton <paul.burton@mips.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.9 015/101] MIPS: ralink: Fix mt7620 nd_sd pinmux
Date:   Thu,  6 Dec 2018 15:38:14 +0100
Message-Id: <20181206143012.426964716@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Kresin <dev@kresin.me>

commit 7d35baa4e9ec4b717bc0e58a39cdb6a1c50f5465 upstream.

In case the nd_sd group is set to the sd-card function, Pins 45 + 46 are
configured as GPIOs. If they are blocked by the sd function, they can't
be used as GPIOs.

Reported-by: Kristian Evensen <kristian.evensen@gmail.com>
Signed-off-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: f576fb6a0700 ("MIPS: ralink: cleanup the soc specific pinmux data")
Patchwork: https://patchwork.linux-mips.org/patch/21220/
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v3.18+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/mt7620.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -81,7 +81,7 @@ static struct rt2880_pmx_func pcie_rst_g
 };
 static struct rt2880_pmx_func nd_sd_grp[] = {
 	FUNC("nand", MT7620_GPIO_MODE_NAND, 45, 15),
-	FUNC("sd", MT7620_GPIO_MODE_SD, 45, 15)
+	FUNC("sd", MT7620_GPIO_MODE_SD, 47, 13)
 };
 
 static struct rt2880_pmx_group mt7620a_pinmux_data[] = {


