Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AC6C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E83B2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543594;
	bh=3AzIccjd9ZXrZt4UDpvXTbuTOHEwIdt/d1t6AVcIB+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DSlwoexv2AyzWaeUHRXOfMs2X7FUyjB3qcSiEJYPpgfHmmGG01TKJwwg7saAx/gOw
	 xGqR1AXHTqv0562Dr1huVmmyJZdha+fTGhnLorPzCfskTvGCPqzwF0cAKwi3gpeDqu
	 exr54CQxZdI7OERn+Jq8BTYj1Aqs+GepNCa51V5s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E83B2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbeLKPxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:53:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbeLKPxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:53:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C45F20855;
        Tue, 11 Dec 2018 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543589;
        bh=3AzIccjd9ZXrZt4UDpvXTbuTOHEwIdt/d1t6AVcIB+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=suU+lLFK80rxSJcBh/DRPYV6tQ/0c6IvKMMeRTmzztMoZGlsnc8pgAvuRrGtv/Qd7
         VPyJOXlV4DhOPGgrRvVieD3LyRbXFW6vbV44OQ1/EOTMVS+VDR8QAPaVexklWmxdmn
         lD+7gqfSq/4wAJzd9sZ2fURz9LXrvY2t6kR2Fa/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 38/67] ALSA: pcm: Fix interval evaluation with openmin/max
Date:   Tue, 11 Dec 2018 16:41:38 +0100
Message-Id: <20181211151632.320874594@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

commit 5363857b916c1f48027e9b96ee8be8376bf20811 upstream.

As addressed in alsa-lib (commit b420056604f0), we need to fix the
case where the evaluation of PCM interval "(x x+1]" leading to
-EINVAL.  After applying rules, such an interval may be translated as
"(x x+1)".

Fixes: ff2d6acdf6f1 ("ALSA: pcm: Fix snd_interval_refine first/last with open min/max")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/sound/pcm_params.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -247,11 +247,13 @@ static inline int snd_interval_empty(con
 static inline int snd_interval_single(const struct snd_interval *i)
 {
 	return (i->min == i->max || 
-		(i->min + 1 == i->max && i->openmax));
+		(i->min + 1 == i->max && (i->openmin || i->openmax)));
 }
 
 static inline int snd_interval_value(const struct snd_interval *i)
 {
+	if (i->openmin && !i->openmax)
+		return i->max;
 	return i->min;
 }
 


