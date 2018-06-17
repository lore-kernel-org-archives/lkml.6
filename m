Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250B3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 13:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25C7208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 13:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="q2evcvPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25C7208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755568AbeFQNrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 09:47:37 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:47068 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754357AbeFQNre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 09:47:34 -0400
Received: from trochilidae.lan (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 7EA7B5C00F6;
        Sun, 17 Jun 2018 15:47:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529243253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=eBgYbAvAeUgat/9LmSLthWg8/GnXlU5LdZIgVoc1QGY=;
        b=q2evcvPpSZEQtQoUg5AFuM6pb4M30DIQvq/ycZ655ExkSHlPrgoO5XTXxTXQjHwJrHAdgw
        23+1rIqFD63qjIHrYtyzSDraUX6MnezO9P0CA1OxB1xxkQz0WRNjBEnkqMvSp/cv7+np2s
        VfEQVV9xLoLzNgW/Y2ubWfdFlJsM1cg=
From:   Stefan Agner <stefan@agner.ch>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Stefan Agner <stefan@agner.ch>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ctxfi: use enum type CT_SUM_CTL where appropriate
Date:   Sun, 17 Jun 2018 15:46:49 +0200
Message-Id: <20180617134652.1638-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.1
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         RCPT_COUNT_FIVE(0.00)[5];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a variable of type enum CT_AMIXER_CTL is used for enum
CT_SUM_CTL values. This leads to warnings when using clang:
sound/pci/ctxfi/ctmixer.c:945:32: warning: implicit conversion from enumeration type
      'enum CT_SUM_CTL' to different enumeration type 'enum CT_AMIXER_CTL'
      [-Wenum-conversion]
        for (i = AMIXER_MASTER_F, j = SUM_IN_F;
                                    ~ ^~~~~~~~
sound/pci/ctxfi/ctmixer.c:975:29: warning: implicit conversion from enumeration type
      'enum CT_SUM_CTL' to different enumeration type 'enum CT_AMIXER_CTL'
      [-Wenum-conversion]
        for (i = AMIXER_PCM_F, j = SUM_IN_F; i <= AMIXER_PCM_S; i++, j++) {
                                 ~ ^~~~~~~~

Introduce enum CT_SUM_CTL k and it instead.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 sound/pci/ctxfi/ctmixer.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/pci/ctxfi/ctmixer.c b/sound/pci/ctxfi/ctmixer.c
index db710d0a609f..4777d50fbbf8 100644
--- a/sound/pci/ctxfi/ctmixer.c
+++ b/sound/pci/ctxfi/ctmixer.c
@@ -938,17 +938,18 @@ static int ct_mixer_topology_build(struct ct_mixer *mixer)
 	struct sum *sum;
 	struct amixer *amix_d, *amix_s;
 	enum CT_AMIXER_CTL i, j;
+	enum CT_SUM_CTL k;
 
 	/* Build topology from destination to source */
 
 	/* Set up Master mixer */
-	for (i = AMIXER_MASTER_F, j = SUM_IN_F;
-					i <= AMIXER_MASTER_S; i++, j++) {
+	for (i = AMIXER_MASTER_F, k = SUM_IN_F;
+					i <= AMIXER_MASTER_S; i++, k++) {
 		amix_d = mixer->amixers[i*CHN_NUM];
-		sum = mixer->sums[j*CHN_NUM];
+		sum = mixer->sums[k*CHN_NUM];
 		amix_d->ops->setup(amix_d, &sum->rsc, INIT_VOL, NULL);
 		amix_d = mixer->amixers[i*CHN_NUM+1];
-		sum = mixer->sums[j*CHN_NUM+1];
+		sum = mixer->sums[k*CHN_NUM+1];
 		amix_d->ops->setup(amix_d, &sum->rsc, INIT_VOL, NULL);
 	}
 
@@ -972,12 +973,12 @@ static int ct_mixer_topology_build(struct ct_mixer *mixer)
 	amix_d->ops->setup(amix_d, &amix_s->rsc, INIT_VOL, NULL);
 
 	/* Set up PCM-in mixer */
-	for (i = AMIXER_PCM_F, j = SUM_IN_F; i <= AMIXER_PCM_S; i++, j++) {
+	for (i = AMIXER_PCM_F, k = SUM_IN_F; i <= AMIXER_PCM_S; i++, k++) {
 		amix_d = mixer->amixers[i*CHN_NUM];
-		sum = mixer->sums[j*CHN_NUM];
+		sum = mixer->sums[k*CHN_NUM];
 		amix_d->ops->setup(amix_d, NULL, INIT_VOL, sum);
 		amix_d = mixer->amixers[i*CHN_NUM+1];
-		sum = mixer->sums[j*CHN_NUM+1];
+		sum = mixer->sums[k*CHN_NUM+1];
 		amix_d->ops->setup(amix_d, NULL, INIT_VOL, sum);
 	}
 
-- 
2.17.1

