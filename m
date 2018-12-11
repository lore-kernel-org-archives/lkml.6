Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A42BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D598E2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543099;
	bh=XsMkTJEhUoqn9xe3ym851uJYgL6RtMGMIIDdxfttD4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tWnvaGxnKkvVwWtACl3ZYvqGR5ljxx/umfNWaQsYlWkaAeujpAjokYuwdSdFVQBP3
	 maVeVW3hI1i1BbWb86u8RBszTZcyTra9Rvg57wd2w1CRawlhUK4l0xjPoEtnaZwOB/
	 BHWLS58M0gQLVwM4U07ZBbVFEg27CaMAPnFS+hGk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D598E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeLKPo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:44:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbeLKPoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:44:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D353C20855;
        Tue, 11 Dec 2018 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543095;
        bh=XsMkTJEhUoqn9xe3ym851uJYgL6RtMGMIIDdxfttD4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kku4kDk6pchq5FVAqoYR1frnOyK8GFZvHqTAzqb7yk1C4u9yPTEZaOFbDejAwyTEN
         fphV9zDvkv9x77Kt0CDgK8Ajv4zWwiv1QZXmdd43obWTa4XSZ/8usHCW5ttoFAIUgV
         lt3P20V8NuA2Pkf7KCwGcQg84f2tjjgEBi0434GA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Meelis Roos <mroos@linux.ee>
Subject: [PATCH 4.4 11/91] ALSA: ac97: Fix incorrect bit shift at AC97-SPSA control write
Date:   Tue, 11 Dec 2018 16:40:30 +0100
Message-Id: <20181211151606.866571820@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 7194eda1ba0872d917faf3b322540b4f57f11ba5 upstream.

The function snd_ac97_put_spsa() gets the bit shift value from the
associated private_value, but it extracts too much; the current code
extracts 8 bit values in bits 8-15, but this is a combination of two
nibbles (bits 8-11 and bits 12-15) for left and right shifts.
Due to the incorrect bits extraction, the actual shift may go beyond
the 32bit value, as spotted recently by UBSAN check:
 UBSAN: Undefined behaviour in sound/pci/ac97/ac97_codec.c:836:7
 shift exponent 68 is too large for 32-bit type 'int'

This patch fixes the shift value extraction by masking the properly
with 0x0f instead of 0xff.

Reported-and-tested-by: Meelis Roos <mroos@linux.ee>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/ac97/ac97_codec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -824,7 +824,7 @@ static int snd_ac97_put_spsa(struct snd_
 {
 	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
 	int reg = kcontrol->private_value & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0xff;
+	int shift = (kcontrol->private_value >> 8) & 0x0f;
 	int mask = (kcontrol->private_value >> 16) & 0xff;
 	// int invert = (kcontrol->private_value >> 24) & 0xff;
 	unsigned short value, old, new;


