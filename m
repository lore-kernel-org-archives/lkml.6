Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083E0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD392173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866108;
	bh=Rv2hE2zlNol/70MxCs8l6bbvNaBl7U7go5/3M7s/eTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2DGQck2NNG1DpJ4pFT4mgWfXRjJ4XSBsEjARjF50Zf+rsRHOghfY5/yKdoxhNXQa/
	 AORzUuKEtvHtoop1+qmuU1y8DWGk7ctRgevycSRcRlLw9rcOatmIgq14nZuqSC/snC
	 BexeVNtqpneUFMwOdn4cygGoMPW0WLSwxx2LBji4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfAGNBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729655AbfAGNBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:01:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A30206BB;
        Mon,  7 Jan 2019 13:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866105;
        bh=Rv2hE2zlNol/70MxCs8l6bbvNaBl7U7go5/3M7s/eTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mS+D8htU0rwMnapj9ehBfQSphcZy4w0wwH6GqDXOSWI8OPcF47frfZ0SMAQ6riqgk
         4qPoWKzf2wMVK4p1dcexR2nSrCVUsq12TekmMVQA75qBeftT+AdGHiWOefANs81srG
         W0btd9Sl5+qEiaNUhOclu4aQqC3rrmOhcfbAh2pw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 040/101] ALSA: pcm: Fix potential Spectre v1 vulnerability
Date:   Mon,  7 Jan 2019 13:32:28 +0100
Message-Id: <20190107105335.100613782@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 94ffb030b6d31ec840bb811be455dd2e26a4f43e upstream.

stream is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

sound/core/pcm.c:140 snd_pcm_control_ioctl() warn: potential spectre issue 'pcm->streams' [r] (local cap)

Fix this by sanitizing stream before using it to index pcm->streams

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: stable@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -25,6 +25,7 @@
 #include <linux/time.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
+#include <linux/nospec.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/pcm.h>
@@ -129,6 +130,7 @@ static int snd_pcm_control_ioctl(struct
 				return -EFAULT;
 			if (stream < 0 || stream > 1)
 				return -EINVAL;
+			stream = array_index_nospec(stream, 2);
 			if (get_user(subdevice, &info->subdevice))
 				return -EFAULT;
 			mutex_lock(&register_mutex);


