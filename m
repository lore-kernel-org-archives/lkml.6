Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B485CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8294A20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570480;
	bh=XbnYj2Bi9UdJX47hA5B7ALYRiNtugtAoQkK04yf81mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j6eMGOL8eo123RT4qH1TYdyCS3cj+cQm9PwQaovzTvdSZmeaz2CoY5w7iQOLth9wW
	 MMRs3mJ5w2Up8212Sr/j1T3a9MwmVmCB/G+RjfNecuyGH80qrXS7qYnfXCoqSv6AEo
	 wubVraDcwQ57Yb+A1XGIdwDPOJc621BtbFPqHGcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbfAOQlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:41:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732736AbfAOQlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:41:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7A0A2054F;
        Tue, 15 Jan 2019 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570474;
        bh=XbnYj2Bi9UdJX47hA5B7ALYRiNtugtAoQkK04yf81mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0UIh53ghxydbAMFLXm1W8BcEoMbYus35nuISV7f51CHL3jll7x11TvZz4sCkCkE1L
         Z7h/jj1issuH0cseS5wQ3yhsdIZVhQ/PCprMRC+RhVL7nAaRjWGKnZ9h79DKrKBLam
         Idi0cR23XrymqeyKXrwzymJOTs7C6fdRDULu4sDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 04/27] ALSA: hda/realtek - Add unplug function into unplug state of Headset Mode for ALC225
Date:   Tue, 15 Jan 2019 17:35:53 +0100
Message-Id: <20190115154901.461522178@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154901.189747728@linuxfoundation.org>
References: <20190115154901.189747728@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit 4d4b0c52bde470c379f5d168d5c139ad866cb808 upstream.

Forgot to add unplug function to unplug state of headset mode
for ALC225.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4005,6 +4005,7 @@ static void alc_headset_mode_unplugged(s
 	case 0x10ec0225:
 	case 0x10ec0295:
 	case 0x10ec0299:
+		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_process_coef_fw(codec, coef0225);
 		break;
 	case 0x10ec0867:


