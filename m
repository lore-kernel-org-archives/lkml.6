Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B413C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E49720661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107331;
	bh=ykZCfEzirjBZx4VZIIN+LAM89zv6LtpKvkoVrF65OSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YG4/HGKNAM3plFm86oQN3DOMcvKYbCpCJ2k0BoiECaOpLoHHRbam6lGX/KU11XvZE
	 3gwJAzcezvRD8kWPAtX9dQo1U4LOj3yDuCAVZr5WlJTbninZZ2DyZuEwIa9jIZiue0
	 Ak2hoGaD1cBcAoZd4c5bU8t2Th3tuQRjaJYRCwTg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E49720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbeLFOmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:42:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730401AbeLFOmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:42:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6978720892;
        Thu,  6 Dec 2018 14:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107327;
        bh=ykZCfEzirjBZx4VZIIN+LAM89zv6LtpKvkoVrF65OSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=El1oTgY65zGBYib/q/81jDBAGUgMcOSTDdRn/CmwquUisEFFUi5luG0Jfu6vVAmJ8
         8xBgwLbtCqXGa0+ofF/e8QTa10MBC+rqJROj1FHsmBo+L3eGAIVzoRVA3+ekMsiItc
         TBAO1oxDVfuPQ02w3Nb9tWbcacIHFivTG6nG9j1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 05/55] ALSA: intel_hdmi: Use strlcpy() instead of strncpy()
Date:   Thu,  6 Dec 2018 15:38:39 +0100
Message-Id: <20181206143002.035400607@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit c288248f5b26cd5563112fcdc077bf44964a942d upstream.

hdmi_lpe_audio_probe() copies the pcm name string via strncpy(), but
as a gcc8 warning suggests, it misses a NUL terminator, and unlikely
the expected result.

Use the proper one, strlcpy() instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/x86/intel_hdmi_audio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1839,7 +1839,7 @@ static int hdmi_lpe_audio_probe(struct p
 		/* setup private data which can be retrieved when required */
 		pcm->private_data = ctx;
 		pcm->info_flags = 0;
-		strncpy(pcm->name, card->shortname, strlen(card->shortname));
+		strlcpy(pcm->name, card->shortname, strlen(card->shortname));
 		/* setup the ops for playabck */
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &had_pcm_ops);
 


