Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE919C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB11B217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130589;
	bh=KZaLNCiOm+MZ/b/Lb/gdnzSf9sbtz8PV7X/K5lYA+WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tBtdug+OQN7kstrleaJXmV4qO/gat63TsgpZGBHe2Can5xFKtC5T12iSb08z7JQmQ
	 3LbTc88XInFpmrmA3ZGauS3m9qruXtWWPfp5o+VsUlBYKodP/KBtyF1eYYUiZq+gBS
	 0Je0rks0LWIlci42c+iNk+d2EAc8Gi1jbtAdn51Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbfBYVg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbfBYVgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B4F020578;
        Mon, 25 Feb 2019 21:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130584;
        bh=KZaLNCiOm+MZ/b/Lb/gdnzSf9sbtz8PV7X/K5lYA+WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZj5plKXB9/CCgD9sAJc0fNrxvM7a8yTGQSPZ8vfGmpQ7mJTRrqvn0/8qXRaAUeLF
         i8R78xL4y7UMhYysg9UfOfOKAhuTb/JEHz6BnX1P3SaW8t1BlETOtEb9IBDL6LPatp
         0T2jl3FnrJi8pjYdt6vuyEBRvv0CRLnAL6YKaSb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 4.20 167/183] ASoC: soc-core: fix init platform memory handling
Date:   Mon, 25 Feb 2019 22:12:20 +0100
Message-Id: <20190225195123.288103931@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Curtis Malainey <cujomalainey@chromium.org>

commit 09ac6a817bd687e7f5dac00470262efdd72f9319 upstream.

snd_soc_init_platform initializes pointers to snd_soc_dai_link which is
statically allocated and it does this by devm_kzalloc. In the event of
an EPROBE_DEFER the memory will be freed and the pointers are left
dangling. snd_soc_init_platform sees the dangling pointers and assumes
they are pointing to initialized memory and does not reallocate them on
the second probe attempt which results in a use after free bug since
devm has freed the memory from the first probe attempt.

Since the intention for snd_soc_dai_link->platform is that it can be set
statically by the machine driver we need to respect the pointer in the
event we did not set it but still catch dangling pointers. The solution
is to add a flag to track whether the pointer was dynamically allocated
or not.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/sound/soc.h  |    6 ++++++
 sound/soc/soc-core.c |   11 ++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -985,6 +985,12 @@ struct snd_soc_dai_link {
 	/* Do not create a PCM for this DAI link (Backend link) */
 	unsigned int ignore:1;
 
+	/*
+	 * This driver uses legacy platform naming. Set by the core, machine
+	 * drivers should not modify this value.
+	 */
+	unsigned int legacy_platform:1;
+
 	struct list_head list; /* DAI link list of the soc card */
 	struct snd_soc_dobj dobj; /* For topology */
 };
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1034,17 +1034,18 @@ static int snd_soc_init_platform(struct
 	 * this function should be removed in the future
 	 */
 	/* convert Legacy platform link */
-	if (!platform) {
+	if (!platform || dai_link->legacy_platform) {
 		platform = devm_kzalloc(card->dev,
 				sizeof(struct snd_soc_dai_link_component),
 				GFP_KERNEL);
 		if (!platform)
 			return -ENOMEM;
 
-		dai_link->platform	= platform;
-		platform->name		= dai_link->platform_name;
-		platform->of_node	= dai_link->platform_of_node;
-		platform->dai_name	= NULL;
+		dai_link->platform	  = platform;
+		dai_link->legacy_platform = 1;
+		platform->name		  = dai_link->platform_name;
+		platform->of_node	  = dai_link->platform_of_node;
+		platform->dai_name	  = NULL;
 	}
 
 	/* if there's no platform we match on the empty platform */


