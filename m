Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D98C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898BE214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LMG35cAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898BE214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeJIVxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:53:21 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:39094 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIVxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:53:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 93A7BEEA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 14:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gyJXj9VU3O-B for <linux-kernel@vger.kernel.org>;
        Tue,  9 Oct 2018 09:36:06 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 60480DB8
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 09:36:06 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id p22-v6so1500949ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TmvjctwlEH2k+mWL682SP3FFbm0u41+Ro94eJ+jcraw=;
        b=LMG35cAImYQRNJLRtvwvx+yIRhj25VcDBtHUeUwGYJ6p1fWI/NnQ+lKEPQ4NVEF9nn
         yhLhOYhq0zRraBBpxbNhfHWMCAUSTh3KCkR2aP5TJAWd85TxiKuhXn8AKJI7MTDJvhO1
         7NU7JaL9a3kJ3oXbKd8WUvDU4RoUb76SE3Qa6H5lrsZZ7Z2vDg2nKNIRYARmHCUmYoaC
         uOnhzrYdKiORsd3H99SUSekTKPzNQvT7PCVp8NYfu19w4pZpT9Ht1vhJbUT4Y873p8ZI
         QSkb7xW9RyjQ5ub0u8I5dMZC7O631IvJ4/rtvLpZqZ2N0wh9rpsyd5S+7uxBt/eg0VvN
         FFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TmvjctwlEH2k+mWL682SP3FFbm0u41+Ro94eJ+jcraw=;
        b=QmmRc5Lz4T5VgjKbEmgBzxV0PdOopDqL4PiJAn74kTcPJt5Gf5TTtBudei7oRRIEro
         sRCcsksT6xXZFxui8n8A5sXo30LLXI4wTWwBvnYdE5wKu+Sb9RUMs6TeGkieRQ0KhOJN
         7VhUsHU2QV+lbhnlR47gtmU/oXyMfFAQMRYz6e9wouRJJmZtoqAPsHMpQ3dil2Q5XcCi
         6uUFzwqFtR3IOwZDGuJ26aTyXe010knkB7Ep5E+a7fGKaA4luSVXVssvjOryt2IwM/Vz
         7kHe8LVEalX8AIADRnu3gB9FlU7YJKf0q71g+sOlws60+ijpuI+zaT1ltU5oKs1OSZam
         OhHg==
X-Gm-Message-State: ABuFfoiXTXASgNfsVYhRGCnVISvNI+NC7gTpLdRfMUsFVNveI/0hWQq/
        HOwoXnSAKhliCvTi39Eo9Gb43sgqrS8bOl21dWd4ZCQW2U3ukQSdhblhZlur+UaYsiu9L0UvIeH
        SMW4GFsZt9RrWe44NX6Uz3ioDIH89
X-Received: by 2002:a24:f58a:: with SMTP id k132-v6mr2102799ith.68.1539095765892;
        Tue, 09 Oct 2018 07:36:05 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61jQbbweKAgk7CWF4Gdd71RAd5o5I59lcKebhHcwWPC9+J+6/lpqu6E2cefcj60LY54720ufQ==
X-Received: by 2002:a24:f58a:: with SMTP id k132-v6mr2102783ith.68.1539095765644;
        Tue, 09 Oct 2018 07:36:05 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id j75-v6sm6300825itj.33.2018.10.09.07.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 07:36:04 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: intel8x0: fix a redundant check bug
Date:   Tue,  9 Oct 2018 09:35:52 -0500
Message-Id: <1539095754-5609-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In snd_intel8x0_codec_semaphore(), the parameter 'codec' is firstly
checked to see whether it is greater than 2. If yes, an error code EIO is
returned. Otherwise, 'chip->in_sdin_init' is further checked. If
'chip->in_sdin_init' is not zero, 'codec' is updated immediately with
'chip->codec_isr_bits'. That means, the parameter 'codec' is not used in
this branch. Actually, it is only used in the else branch when
'chip->in_sdin_init' is zero. Thus, the check on the parameter 'codec' is
redundant if 'chip->in_sdin_init' is not zero. This can cause potential
incorrect execution in this function. Suppose the parameter 'codec' is 3,
which is greater than 2, and 'chip->in_sdin_init' is not zero. The current
version of this function will return EIO after the first check because
'codec' is greater than 2. However, since 'codec' will be updated in the
following execution when 'chip->in_sdin_init' is not zero, this check will
be meaningless and the execution should continue, instead of returning the
error code EIO.

This patch avoids the above issue by moving the check on the parameter
'codec' to the else branch of the if statement that checks
'chip->in_sdin_init'.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 sound/pci/intel8x0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 5ee468d..f619e58 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -515,13 +515,13 @@ static int snd_intel8x0_codec_semaphore(struct intel8x0 *chip, unsigned int code
 {
 	int time;
 	
-	if (codec > 2)
-		return -EIO;
 	if (chip->in_sdin_init) {
 		/* we don't know the ready bit assignment at the moment */
 		/* so we check any */
 		codec = chip->codec_isr_bits;
 	} else {
+		if (codec > 2)
+			return -EIO;
 		codec = chip->codec_bit[chip->ac97_sdin[codec]];
 	}
 
-- 
2.7.4

