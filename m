Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF5CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FBA21019
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTSoPFGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FBA21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbeKIHrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:47:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732957AbeKIHrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:48 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46B05208A3;
        Thu,  8 Nov 2018 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715016;
        bh=KcIibG8roijUXxtv1YGydyWbeVS7Rs85L6KVGVymShM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TTSoPFGI/GQWlGHtUf8MhS02O3N+/GmStXnaJL3//dwTwrPP4SD27vxsQK4W0Rn+6
         v5HFh4AlyPEbz0a6GcxBUhrtO3H9tfhWJBxzAlZe7UkR9XRfW3Y6w9q1C6nNiWeNVm
         8IGFUB3yzHlrN6XBeYqmNQ+q+fkTvigehF+Z86FU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4.18 27/34] drm/sun4i: Fix an ulong overflow in the dotclock driver
Date:   Thu,  8 Nov 2018 13:52:56 -0800
Message-Id: <20181108215140.563857522@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit e84cb605e02f1b3d0aee8d7157419cd8aaa06038 upstream.

The calculated ideal rate can easily overflow an unsigned long, thus
making the best div selection buggy as soon as no ideal match is found
before the overflow occurs.

Fixes: 4731a72df273 ("drm/sun4i: request exact rates to our parents")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181018100250.12565-1-boris.brezillon@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -81,9 +81,19 @@ static long sun4i_dclk_round_rate(struct
 	int i;
 
 	for (i = tcon->dclk_min_div; i <= tcon->dclk_max_div; i++) {
-		unsigned long ideal = rate * i;
+		u64 ideal = (u64)rate * i;
 		unsigned long rounded;
 
+		/*
+		 * ideal has overflowed the max value that can be stored in an
+		 * unsigned long, and every clk operation we might do on a
+		 * truncated u64 value will give us incorrect results.
+		 * Let's just stop there since bigger dividers will result in
+		 * the same overflow issue.
+		 */
+		if (ideal > ULONG_MAX)
+			goto out;
+
 		rounded = clk_hw_round_rate(clk_hw_get_parent(hw),
 					    ideal);
 


