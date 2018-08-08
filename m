Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DF9C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B238921781
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bza3AlPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B238921781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeHHTzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:55:46 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55080 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:55:46 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so4524909itb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AjHhvUUact6sJc0wcvB0qbSDbW8aAjhloaQI4ZM3vN4=;
        b=bza3AlPj4gCgxqt5RsEYqgH+pPYN7EnHA5LoGwEGmp5akww2SGtFxEokGvsEpO9DlX
         lh/BSDymHrIrJ1BsvBz0ls05A2/tA4Pu2JVPIaig6BojzibFhltu8py9AMHcbOhRZ35Y
         UTLXqEnuRUE9QKWwkDqGNfC3+OZbufoo79FZ7676O/0DIIjkVF1Krf9lrNCrv1QfNQLZ
         bV4qt1O8wp2eMg1TVNMb6UAEsHPiyDa/Ageh37PjXfNiPsBLstMFZFs8fIpZ1UdJzHD+
         gnaRf1qP7V3fUxpHqF5QYWt+qKYKBvICZMI+kJbrQOpv2teTrS6WfsCHWEF9Hj5+OYmO
         /uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AjHhvUUact6sJc0wcvB0qbSDbW8aAjhloaQI4ZM3vN4=;
        b=I+NN5VJudz2DgvQwm8nGsXDTRLQK8RlScCkGTFu75L4Wqgdn80WKTPlQwAcJw1OTNh
         1e0daNXqYphV3kUpNExbiI5/V4wMqrd2oyUHkKWezLuitOW6QlkF3hxCWJALzeU6V6sY
         G+ZTo44+G5BBYoYFdVRdFQ0RUo/ddSMcwmsZFucD4DJCGWyFT+CGoa48ApYkF7TsIivK
         pcDpTuj/E8RuE+vfDPGjZwommvUaFmYR2+buhCTLbuHaQFnjrwc8Vp2HxNoKegYq7BrY
         6ohoJaLslrfnR9S0e4PtAgUlkYQA8lwG2OWooFUYaHx7eGP/DsYXBKD9b0ufOkC0k3qB
         ioAg==
X-Gm-Message-State: AOUpUlFoFGC7WZujpwywKOyXxRLUF2JqeV9fELWV8nmwmPmS5ma9ulOz
        Trpk7yBawQqc8n1iCshwynQ=
X-Google-Smtp-Source: AA+uWPzwq8YuXKJePzoHBeaVMHEkkYhZxmhn0Yb0MfKVwLE2yGmHwgumTO8ZNBLfMpuczLsrQFMe+g==
X-Received: by 2002:a02:6901:: with SMTP id e1-v6mr3338939jac.62.1533749704787;
        Wed, 08 Aug 2018 10:35:04 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:45c1:6d6b:de32:e032:aa21])
        by smtp.googlemail.com with ESMTPSA id d8-v6sm1977480itj.10.2018.08.08.10.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 10:35:04 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] Add Recon3D support + Driver cleanup
Date:   Wed,  8 Aug 2018 13:34:11 -0400
Message-Id: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Recon3D PCI-E card. I have
personally tested it on a Recon3D that was sent to me, and included
that PCI ID in the quirk table.

Much of this patch series renames Recon3Di functions to just r3d
because both cards behave similarly.

Aside from that, I do have a question- If the PCI ID's are included in
the Window's driver .inf file, would I be good to add them in as
quirks? Or should I wait for someone with the card to test it, and
then add it once I know it works on that specific card?

Connor McAdams (11):
  ALSA: hda/ca0132 - Create mmio gpio function to make code clearer
  ALSA: hda/ca0132 - Clean up ca0132_init function.
  ALSA: hda/ca0132 - Add alt_functions unsolicited response
  ALSA: hda/ca0132 - Add quirk ID and enum for Recon3D
  ALSA: hda/ca0132 - Add Recon3D pincfg
  ALSA: hda/ca0132 - Add bool variable to enable/disable pci region2
    mmio
  ALSA: hda/ca0132 - Add Recon3D startup functions and setup
  ALSA: hda/ca0132 - Add DSP setup defaults for Recon3D
  ALSA: hda/ca0132 - Add Recon3D input and output select commands
  ALSA: hda/ca0132 - Change mixer controls for Recon3D
  ALSA: hda/ca0132 - Add exit commands for Recon3D

 sound/pci/hda/patch_ca0132.c | 276 ++++++++++++++++++++++++++++---------------
 1 file changed, 180 insertions(+), 96 deletions(-)

-- 
2.7.4

