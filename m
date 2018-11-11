Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E46C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE7D22353
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xSmlXY/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE7D22353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390207AbeKLIWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390172AbeKLIV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:59 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A19A1223C8;
        Sun, 11 Nov 2018 22:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975522;
        bh=mc8itRNRiGU3sL3WoWJwUXQ0ryiDfqTz1uzNk7/R/iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xSmlXY/czjXvqdiipRFEVXqHFrnDnwDi6/YWW3wwX2o0qXraD24a4XrGtX/xegILj
         VeblxZXaSPLkRQVIJQbnmJDRol+idrQY63UHnMsIn2k5nzmkB6azwZPLdXeDN+9t+p
         VHtUA5shx3jyuGJABj4NHKF18Uh6I4BBZ3CpoYZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 016/222] ALSA: hda/realtek - Fix the problem of the front MIC on the Lenovo M715
Date:   Sun, 11 Nov 2018 14:21:53 -0800
Message-Id: <20181111221649.592178173@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Wang <hui.wang@canonical.com>

commit d06fb562bff5d14defdacbd92449bacbaedd5cdf upstream.

The front MIC on the Lenovo M715 can't record sound, after applying
the ALC294_FIXUP_LENOVO_MIC_LOCATION, the problem is fixed. So add
the pin configuration of this machine to the pin quirk table.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6631,6 +6631,12 @@ static const struct snd_hda_pin_quirk al
 		{0x21, 0x0221101f}),
 	SND_HDA_PIN_QUIRK(0x10ec0235, 0x17aa, "Lenovo", ALC294_FIXUP_LENOVO_MIC_LOCATION,
 		{0x14, 0x90170110},
+		{0x19, 0x02a11030},
+		{0x1a, 0x02a11040},
+		{0x1b, 0x01011020},
+		{0x21, 0x0221101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0235, 0x17aa, "Lenovo", ALC294_FIXUP_LENOVO_MIC_LOCATION,
+		{0x14, 0x90170110},
 		{0x19, 0x02a11020},
 		{0x1a, 0x02a11030},
 		{0x21, 0x0221101f}),


