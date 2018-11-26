Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA845C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BAB2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTtBoTOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BAB2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbeKZV7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:59:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730474AbeKZV7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:59:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7148A20645;
        Mon, 26 Nov 2018 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230344;
        bh=5LmbyjcH6rE6hoOOhW+mc3haVrmpsBycjtF8/ZM9OPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTtBoTOyK7ZjaY972+ljggPQf1itReMidB2zGVAE1arXBAHeA0hu7Omu+BJxAF1Od
         A/yZ4L/Hos2VX9SNGF9HKIw2wzEJpnt6zDbJh9tPN6pqu4sskiL0g6iKB5RfGOwTxV
         UV9ZQJYtN6KeZTpzMeL9rfHkoS9g/qaio11lDN+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 100/118] ALSA: hda/ca0132 - Call pci_iounmap() instead of iounmap()
Date:   Mon, 26 Nov 2018 11:51:34 +0100
Message-Id: <20181126105105.714482699@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
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

commit d99501b8575dc1248bacf1b58d2241cb4b265d49 upstream.

We need to call pci_iounmap() instead of iounmap() for the regions
obtained via pci_iomap() call for some archs that need special
treatment.

Fixes: aa31704fd81c ("ALSA: hda/ca0132: Add PCI region2 iomap for SBZ")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_ca0132.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7395,7 +7395,7 @@ static void ca0132_free(struct hda_codec
 
 	snd_hda_power_down(codec);
 	if (spec->mem_base)
-		iounmap(spec->mem_base);
+		pci_iounmap(codec->bus->pci, spec->mem_base);
 	kfree(spec->spec_init_verbs);
 	kfree(codec->spec);
 }


