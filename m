Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FC9C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1FC2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543003;
	bh=LqMB3z5/dgVSCrEPQMOqeUvvLb8nltkmb/Tis/8fa+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sAxp8yIwk+gL8FbRSkRkoRxd5al83Bw09O2tgTs40is5EPml/WDcA/6Wb1YypYiIy
	 vIZXSq+I0kWIbpdbxOBXheT3Mhx98Cp2cMg2B/t6nR1c2LLiF/VI2ygbQvmMnYjiTv
	 rzcGTs2llTF5SvNBDMvJn+f4Ml6T5+zuddyR/r2k=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1FC2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeLKPnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:43:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbeLKPnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:43:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6551420855;
        Tue, 11 Dec 2018 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544542997;
        bh=LqMB3z5/dgVSCrEPQMOqeUvvLb8nltkmb/Tis/8fa+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHkDTlyrOZ9ApTd7hVb7NLsgaEvn3D5VmyFl3KxI6ZfzB3PGVi1sd9C/QTMxIujST
         TWvtjPmUVrNlRY5M1Y2XIUll5G7fvpvoaJLHEYOKVxhgNC0G57cguw+Ek7u9ahpT8l
         OTFm3FyrYIgIUbI5e3t8o6RGw7CCx70f0beBenic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 27/54] ALSA: trident: Suppress gcc string warning
Date:   Tue, 11 Dec 2018 16:41:15 +0100
Message-Id: <20181211151547.593117958@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 


