Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E3EC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3A3217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277350;
	bh=fNcdiSdxgwXTNpr4N8gQ+SsdgI64moe9kK9WKX57RQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HxTPvtaZ+f/18eqLi7/kSrCNEEM71o7bnuJn29ECW1+niNGd+WMRrwsrYsixRta/e
	 vpItmjHth54lDR0EOHAiQiYg3hQ+i/aZQpfufC27tRppTVS3Qd3Op4vk19pXNKH0uJ
	 vabOpZPP94vpAel7IjTGCWc9EouM8BC106ceW95k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfBDKtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731362AbfBDKtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:49:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 573B72070C;
        Mon,  4 Feb 2019 10:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277344;
        bh=fNcdiSdxgwXTNpr4N8gQ+SsdgI64moe9kK9WKX57RQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tsvpe1rpAdf/ZLf8/tHA1cqlUQ5Ow7BkUnJgIPiZISDj+QSAtudmt0PdJSSDL2XyL
         XbdkFL/z6T1nXEkaKwVW/jstW/irVW4/2EmQlGZg89MrSqQCvDD3mxSY5POPsjzZAg
         v4uAMZyEemdsvJAp7+lTfTKbdCEtRW17hptzgH70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 56/74] platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
Date:   Mon,  4 Feb 2019 11:37:09 +0100
Message-Id: <20190204103627.215853600@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

[ Upstream commit b3f2f3799a972d3863d0fdc2ab6287aef6ca631f ]

When the OS registers to handle events from the display off hotkey the
EC will send a notification with 0x35 for every key press, independent
of the backlight state.

The behavior of this key on Windows, with the ATKACPI driver from Asus
installed, is turning off the backlight of all connected displays with a
fading effect, and any cursor input or key press turning the backlight
back on. The key press or cursor input that wakes up the display is also
passed through to the application under the cursor or under focus.

The key that matches this behavior the closest is KEY_SCREENLOCK.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -444,6 +444,7 @@ static const struct key_entry asus_nb_wm
 	{ KE_KEY, 0x32, { KEY_MUTE } },
 	{ KE_KEY, 0x33, { KEY_DISPLAYTOGGLE } }, /* LCD on */
 	{ KE_KEY, 0x34, { KEY_DISPLAY_OFF } }, /* LCD off */
+	{ KE_KEY, 0x35, { KEY_SCREENLOCK } },
 	{ KE_KEY, 0x40, { KEY_PREVIOUSSONG } },
 	{ KE_KEY, 0x41, { KEY_NEXTSONG } },
 	{ KE_KEY, 0x43, { KEY_STOPCD } }, /* Stop/Eject */


