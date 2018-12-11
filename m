Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DEDC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD222087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543176;
	bh=Sb2LZhea8SCJikvrUTUObU7rv/95/9mz2XLpBNxe47U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SCIgI4pmmf8bPY9fYLMWXBaj63lfxOAQaUYzO3BlzxEjCMcKwguPEmfro1Dn+gnzR
	 zWrkZzh9uAdS0zi6I7Zk6rzYymERPBKA6/EAVol1HQkgXuTlZpol51PsVTC7tGVJ0s
	 zTTEV4TiZeQD3zGTwkSMb4T6Fq61ynDB0zN26AJ4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD222087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeLKPqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbeLKPqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:46:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F62A2087F;
        Tue, 11 Dec 2018 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543168;
        bh=Sb2LZhea8SCJikvrUTUObU7rv/95/9mz2XLpBNxe47U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAChU/mp2QPhwj0JKpD/Sngl3TSbdiTELR+MYeWgS4hFq98xNZizj6+9m1IAswWd3
         sokHeWMZCxp9SRcFboUVd+7THBl5oKFIdYX9EOVtTMRUTMxBOQTXHRHAC4PcfvVNf4
         Tpm/uE0X1ptMs/yuVf8CsH1bY/FGs0tELifjtTrU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 38/91] ALSA: trident: Suppress gcc string warning
Date:   Tue, 11 Dec 2018 16:40:57 +0100
Message-Id: <20181211151608.968759154@linuxfoundation.org>
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

commit d6b340d7cb33c816ef4abe8143764ec5ab14a5cc upstream.

The meddlesome gcc warns about the possible shortname string in
trident driver code:
  sound/pci/trident/trident.c: In function ‘snd_trident_probe’:
  sound/pci/trident/trident.c:126:2: warning: ‘strcat’ accessing 17 or more bytes at offsets 36 and 20 may overlap 1 byte at offset 36 [-Wrestrict]
  strcat(card->shortname, card->driver);

It happens since gcc calculates the possible string size from
card->driver, but this can't be true since we did set the string just
before that, and they are much shorter.

For shutting it up, use the exactly same string set to card->driver
for strcat() to card->shortname, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/trident/trident.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/trident/trident.c
+++ b/sound/pci/trident/trident.c
@@ -123,7 +123,7 @@ static int snd_trident_probe(struct pci_
 	} else {
 		strcpy(card->shortname, "Trident ");
 	}
-	strcat(card->shortname, card->driver);
+	strcat(card->shortname, str);
 	sprintf(card->longname, "%s PCI Audio at 0x%lx, irq %d",
 		card->shortname, trident->port, trident->irq);
 


