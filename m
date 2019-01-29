Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7BEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCDE2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762372;
	bh=IYCO2a4U7kA/Uwhvd8yX5iWqj1yFrdKpSsO/z2wsIEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=so4/IT9Ghb9HSXafAsAE3HLPEmkkymZuWL5YsBbXvatbUHHz6VpcuFrofKOEvIDyf
	 zMO/O/GIhqurgkfYW83UKbn5SK5Qwm0S84CIiC/PoQfxDB8hdPh14W1crPLsBIpcwc
	 +brwfcMrp66CRbgPF40faLYPjyE3JEqjWj7ZRohw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbfA2LqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:46:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730504AbfA2LqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:46:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB622083B;
        Tue, 29 Jan 2019 11:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762366;
        bh=IYCO2a4U7kA/Uwhvd8yX5iWqj1yFrdKpSsO/z2wsIEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ih9Julevmu6wHTXBnkeYUzN5yoaJLolUBZKf6wGwwoKbG49dnSaac1f29Mc/yoBa1
         M3tgt52X9ze2sBW1XU8HgOBBSeJyjigD0CyC0N4byCFVX9EPD1Sju/F4oX/vK+u0y/
         LnQcyfAoKzEbKrCVb4x3v/jKDw36rPQ32oYYw6h0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@linaro.org>
Subject: [PATCH 4.19 083/103] vt: always call notifier with the console lock held
Date:   Tue, 29 Jan 2019 12:36:00 +0100
Message-Id: <20190129113206.434012220@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <nicolas.pitre@linaro.org>

commit 7e1d226345f89ad5d0216a9092c81386c89b4983 upstream.

Every invocation of notify_write() and notify_update() is performed
under the console lock, except for one case. Let's fix that.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2767,8 +2767,8 @@ rescan_last_byte:
 	con_flush(vc, draw_from, draw_to, &draw_x);
 	vc_uniscr_debug_check(vc);
 	console_conditional_schedule();
-	console_unlock();
 	notify_update(vc);
+	console_unlock();
 	return n;
 }
 


