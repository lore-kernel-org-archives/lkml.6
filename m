Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62826C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2872921774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2872921774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeHUJnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:43:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55022 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeHUJnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:43:14 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B7B07516;
        Tue, 21 Aug 2018 06:24:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Park Ju Hyung <qkrwngud825@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.17 17/42] ALSA: hda - Sleep for 10ms after entering D3 on Conexant codecs
Date:   Tue, 21 Aug 2018 08:20:49 +0200
Message-Id: <20180821055018.473780279@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055017.596264829@linuxfoundation.org>
References: <20180821055017.596264829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Park Ju Hyung <qkrwngud825@gmail.com>

commit f59cf9a0551dd954ad8b752461cf19d9789f4b1d upstream.

On rare occasions, we are still noticing that the internal speaker
spitting out spurious noises even after adding the problematic codec
to the list.

Adding a 10ms artificial delay before rebooting fixes the issue entirely.

Patch for Realtek codecs also adds the same amount of delay after
entering D3.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_conexant.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -225,6 +225,7 @@ static void cx_auto_reboot_notify(struct
 	snd_hda_codec_set_power_to_all(codec, codec->core.afg, AC_PWRST_D3);
 	snd_hda_codec_write(codec, codec->core.afg, 0,
 			    AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+	msleep(10);
 }
 
 static void cx_auto_free(struct hda_codec *codec)


