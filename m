Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A86C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A18820851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8af4505"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A18820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeLDK6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbeLDK6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:58:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6BEE214DB;
        Tue,  4 Dec 2018 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921122;
        bh=tRcto52dn5Sr+E7ceFzICBGwvl3M/6YTIpVod1+AOZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8af4505EXfVfuaDhjGJc9lBXSb0WEXq2IdtHunQ9zeOWfYDslg21/wsd8HJ3mAaG
         ZJmwjFPtztlD2abY0J7WSNgZOjbHZ19KJ6/2K7AnffWHiQnKEXAVWJbdfhfDXMY+GB
         ZdaNuMT3PdKrAsskTnRftpuSzdVoWBCXEq3bM4XA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 090/139] ALSA: ac97: Fix incorrect bit shift at AC97-SPSA control write
Date:   Tue,  4 Dec 2018 11:49:31 +0100
Message-Id: <20181204103654.040088878@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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


