Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28ACC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B6E20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B6E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeLIWLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:11:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37656 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728207AbeLIWLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:11:12 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73O-0002iq-Iw; Sun, 09 Dec 2018 21:55:58 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Z-0003Fx-Oc; Sun, 09 Dec 2018 21:55:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "zhang jun" <jun.zhang@intel.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.171404831@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 048/328] ALSA: memalloc: Don't exceed over the
 requested size
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit dfef01e150824b0e6da750cacda8958188d29aea upstream.

snd_dma_alloc_pages_fallback() tries to allocate pages again when the
allocation fails with reduced size.  But the first try actually
*increases* the size to power-of-two, which may give back a larger
chunk than the requested size.  This confuses the callers, e.g. sgbuf
assumes that the size is equal or less, and it may result in a bad
loop due to the underflow and eventually lead to Oops.

The code of this function seems incorrectly assuming the usage of
get_order().  We need to decrease at first, then align to
power-of-two.

Reported-and-tested-by: he, bo <bo.he@intel.com>
Reported-by: zhang jun <jun.zhang@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/memalloc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -239,16 +239,12 @@ int snd_dma_alloc_pages_fallback(int typ
 	int err;
 
 	while ((err = snd_dma_alloc_pages(type, device, size, dmab)) < 0) {
-		size_t aligned_size;
 		if (err != -ENOMEM)
 			return err;
 		if (size <= PAGE_SIZE)
 			return -ENOMEM;
-		aligned_size = PAGE_SIZE << get_order(size);
-		if (size != aligned_size)
-			size = aligned_size;
-		else
-			size >>= 1;
+		size >>= 1;
+		size = PAGE_SIZE << get_order(size);
 	}
 	if (! dmab->area)
 		return -ENOMEM;

