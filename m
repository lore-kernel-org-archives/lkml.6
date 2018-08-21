Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF0FC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A56208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A56208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeHUJpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:45:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56384 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeHUJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:45:39 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D41B7516;
        Tue, 21 Aug 2018 06:26:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhang jun <jun.zhang@intel.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 16/29] ALSA: memalloc: Dont exceed over the requested size
Date:   Tue, 21 Aug 2018 08:21:09 +0200
Message-Id: <20180821055109.046580809@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055108.333930282@linuxfoundation.org>
References: <20180821055108.333930282@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/memalloc.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -242,16 +242,12 @@ int snd_dma_alloc_pages_fallback(int typ
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


