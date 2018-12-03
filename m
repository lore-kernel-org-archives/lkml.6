Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E0DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76EB20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYWDlTvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76EB20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeLCPxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:53:23 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42567 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeLCPxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:53:23 -0500
Received: by mail-ed1-f65.google.com with SMTP id j6so11160955edp.9;
        Mon, 03 Dec 2018 07:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhRX7GdrWa1eintwejLB4d7a72Ap802ixvYj84okxaY=;
        b=ZYWDlTvt+KsEiwbZFfZBZrbTL9c0VTIxw+jzuLNzSuYEaE+GO0uiphM/4tA9mt2s3U
         ooiL7h4qqQDm5D6ohzhEjeu27XX0aCSARDEICoVhjm2Ent+DBocdILWSxh6ppaCMUofL
         SVS8xZDl9+uoOTNEhVyVqmyBtF+1lHN0PLXwKXRDtnoGBUjPUGuSCybJn89WCE4lSPR5
         SHFbaS0pC4W7QNy3nlw1TcDooTYwivLPVlnkE4lwXqDPi1PjTifSrEByGvGfSRt+SncY
         33u2Ik7JXPdzyZVwBw3u6oylsYB+b0o1rx5b7ZEH6TI8ad7vXIAlIWuGgppposXsuvar
         9mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhRX7GdrWa1eintwejLB4d7a72Ap802ixvYj84okxaY=;
        b=sig5LnNdu9TOmeCE8VrZVH/aLwyBL0HqdVS9W1Q/tqmHyYxwtHq0aIlgPTz3qvcnq6
         A1z//yi4bclvGEwRbaZElTeNsF4xxwfZNqOZF3Vvw1yf6311+eX6+Mq35A/8QLI0sOFa
         IZLwRpQObYlR9c/xnER/MGneTTQrY/LOQIsCppc391Intxl6DYcw1CJtF8Qa/equSI0H
         sEWr1a6BJZPXlJ2837MNsnn3OI5D9o7etZxTkOubav3SpMbp9lr0zUI/dykzAFeY6+YE
         lY/2xVfmyplfyTFfPpcVR1MhyHn6GIHJ5XtUlARn0pFkRXRhGNmIzr8kh168O0yo7mL7
         3Ijw==
X-Gm-Message-State: AA+aEWYmGw98fPkhAHcmnK4vqW9SFWxFYSIcird16EduzHCFliKCKH8T
        7Pdja+xBfJkil9Oild9k+0k=
X-Google-Smtp-Source: AFSGD/WToOuIfWi4jl+FR7kug7YLt7Ocu6p251r9ucqWm30lff4Ix37z4fNAqPPitPknI38I7ZW35A==
X-Received: by 2002:a50:ade7:: with SMTP id b36mr4376493edd.215.1543852398660;
        Mon, 03 Dec 2018 07:53:18 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id b46sm3924526edc.57.2018.12.03.07.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 07:53:18 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ALSA: hda/tegra - Probe up to 8 codecs
Date:   Mon,  3 Dec 2018 16:53:16 +0100
Message-Id: <20181203155317.16627-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Recent devices support more than the 4 codecs that the AZX core will
probe by default. Probe up to 8 codecs to make sure all of them are
enumerated.

Suggested-by: Sameer Pujar <spujar@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 84ea6069d28b..83befd8d43e8 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -531,7 +531,7 @@ static void hda_tegra_probe_work(struct work_struct *work)
 		goto out_free;
 
 	/* create codec instances */
-	err = azx_probe_codecs(chip, 0);
+	err = azx_probe_codecs(chip, 8);
 	if (err < 0)
 		goto out_free;
 
-- 
2.19.1

