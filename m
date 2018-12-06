Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C799FC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC0421479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107352;
	bh=W8fC+tIuaRGcV1DN4DT/JYpWdleXQsFRZnjhoCjazR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VtP5yozq8XhwAyDkoIlUem7TsQBlKU2wWStC8dQT79m+6rhok2ptXlmLwtlaoupAs
	 xYPO9s1toFNcKeMLwPXA1+zWmhhbN/u1LEOzk/1Chnjel6O+IbNqPjEZGCvCYEikwI
	 4OfY4xbxTnVooRKRg/BkcOVmCxJgB04ZswzH5SEs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC0421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbeLFOmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729939AbeLFOm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:42:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74EA21479;
        Thu,  6 Dec 2018 14:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107348;
        bh=W8fC+tIuaRGcV1DN4DT/JYpWdleXQsFRZnjhoCjazR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPDeNEGpa1Yv+JECrU18x3zxPVoRG1XECKXx+LOsCeWMq7gh4gxY4W49SNuJif3oQ
         zPRC5cM46WEQc9i2PhnR9vnyXvYbVwAobgoh/3THuzghIh63YzzsdoNFk9h6YHzVhd
         CVWjeNLFKxiZ8fF+5+biTA1RE8yaSV5Bt3HicsDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 28/55] ALSA: trident: Suppress gcc string warning
Date:   Thu,  6 Dec 2018 15:39:02 +0100
Message-Id: <20181206143003.246348079@linuxfoundation.org>
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
 


