Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DE7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D9C208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D9C208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936825AbeFRKNx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:13:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53064 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934435AbeFRIQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:16:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8DA5C7A;
        Mon, 18 Jun 2018 08:16:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 039/279] ASoC: topology: Check widget kcontrols before deref.
Date:   Mon, 18 Jun 2018 10:10:24 +0200
Message-Id: <20180618080610.422957064@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

[ Upstream commit 05bdcf12905533b8628627b6634608cd3b57c607 ]

Validate the topology input before we dereference the pointer.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-topology.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -510,7 +510,7 @@ static void remove_widget(struct snd_soc
 	 */
 	if (dobj->widget.kcontrol_type == SND_SOC_TPLG_TYPE_ENUM) {
 		/* enumerated widget mixer */
-		for (i = 0; i < w->num_kcontrols; i++) {
+		for (i = 0; w->kcontrols != NULL && i < w->num_kcontrols; i++) {
 			struct snd_kcontrol *kcontrol = w->kcontrols[i];
 			struct soc_enum *se =
 				(struct soc_enum *)kcontrol->private_value;
@@ -528,7 +528,7 @@ static void remove_widget(struct snd_soc
 		kfree(w->kcontrol_news);
 	} else {
 		/* volume mixer or bytes controls */
-		for (i = 0; i < w->num_kcontrols; i++) {
+		for (i = 0; w->kcontrols != NULL && i < w->num_kcontrols; i++) {
 			struct snd_kcontrol *kcontrol = w->kcontrols[i];
 
 			if (dobj->widget.kcontrol_type


