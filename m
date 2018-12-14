Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A3BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A5D214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789305;
	bh=XnDWskw6PA1zSXHsdawybCa5yW9qOHj5cs+KsAcHEfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xjtp0W3gQVnDfauYMwURG592bM2Gipeb5vFfUy7lUXMDYz9MnRnMTbNixeVdO6N3s
	 E0kDg7gFfCBBzu90oB6DtGfjhqKjdwpQyzv+p++RNScEhKMFt5IrSZDSXb4jEed2QC
	 OB4q9v36O7hOxGCUUiZm+vs61QtjaPoanI9kUgAM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A5D214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbeLNMIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:08:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730817AbeLNMIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B535214D9;
        Fri, 14 Dec 2018 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789299;
        bh=XnDWskw6PA1zSXHsdawybCa5yW9qOHj5cs+KsAcHEfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pUXcbq45y4qPZx/4o/SGrdwCauccunChNkBXqXz7WhXzC1uaM1OuVN1ZY3jEpiclp
         N1ahJFL9SJv3aToPFZKHr3NDcmIS2zkaZxy5guknSYxyK3YE9AslEKPACdTnCrnbQg
         XZnyL4h1CXfYNzCQl0PuHdoLSxzBEizdBGqmc6l4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 29/89] ASoC: dapm: Recalculate audio map forcely when card instantiated
Date:   Fri, 14 Dec 2018 12:59:42 +0100
Message-Id: <20181214115731.125055421@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

[ Upstream commit 882eab6c28d23a970ae73b7eb831b169a672d456 ]

Audio map are possible in wrong state before card->instantiated has
been set to true.  Imaging the following examples:

time 1: at the beginning

  in:-1    in:-1    in:-1    in:-1
 out:-1   out:-1   out:-1   out:-1
 SIGGEN        A        B      Spk

time 2: after someone called snd_soc_dapm_new_widgets()
(e.g. create_fill_widget_route_map() in sound/soc/codecs/hdac_hdmi.c)

   in:1     in:0     in:0     in:0
  out:0    out:0    out:0    out:1
 SIGGEN        A        B      Spk

time 3: routes added

   in:1     in:0     in:0     in:0
  out:0    out:0    out:0    out:1
 SIGGEN -----> A -----> B ---> Spk

In the end, the path should be powered on but it did not.  At time 3,
"in" of SIGGEN and "out" of Spk did not propagate to their neighbors
because snd_soc_dapm_add_path() will not invalidate the paths if
the card has not instantiated (i.e. card->instantiated is false).
To correct the state of audio map, recalculate the whole map forcely.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fee4b0ef5566..42c2a3065b77 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2307,6 +2307,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 
 	card->instantiated = 1;
+	dapm_mark_endpoints_dirty(card);
 	snd_soc_dapm_sync(&card->dapm);
 	mutex_unlock(&card->mutex);
 	mutex_unlock(&client_mutex);
-- 
2.19.1



