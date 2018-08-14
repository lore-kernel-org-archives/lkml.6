Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706B0C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2432B21580
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZMOl1JoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2432B21580
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbeHNTyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:54:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41394 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733141AbeHNTyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:54:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id y10-v6so9515098pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYNyxDGRcAM39zp8KUtMlIUKrI6lSh43IdRhuAwGMwI=;
        b=ZMOl1JoFVT0uxFk92u5K9js1WUCJRCIhSL5G4A4TXnbAKGZfRRXdVTsCDTS/yXp07k
         rUSOGWMYQTnXY+vH3QwKgP4h+Z+pc5f3CnoAb3Z3Frgf6shz88MKTNeVQ+vukl23UD9s
         B+AQtDUNXTmoDiROVR8xWb8VI+0WplLzZ/eYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYNyxDGRcAM39zp8KUtMlIUKrI6lSh43IdRhuAwGMwI=;
        b=iP5XKfvcGbcZZiWUuI31abM6xDmGvYFBh7OtW2e/OB+BWp2jy7rVs1LbLfsMnaiDNb
         bz7EcrMP5usNrk4cJpq/6z5Sx+yt1hStqZkHnDs/q5zLmlE657IENpHNKnkt/G/Syx2+
         0f1h/HHnIJXewRbzGvfiLP+7fN96Qnkht9zrk06Sz4sdW21kUAac2z3INI1anH+w0FkL
         AwlZRQ7UYjalrr59S/FWIi5ewMAg9uj5Ae8tFqxcJ4YwCPYeiZpg6HeeoxUCG5HDCJbZ
         hDne/tZbm+/oZTW9hvZune3GwUkFE7CzB8bAtMAG4NIoDMolv25T5ZV9if7ekVbtdpIq
         x00Q==
X-Gm-Message-State: AOUpUlHgv4Qec3lGWQAZtjzYrBZVb+kyCRwEdxkZvR29VeAK3SxupEaY
        7ZjF/PVe0cAl0Ue6B7DIpB9dPQ==
X-Google-Smtp-Source: AA+uWPykDcYmPa2sGFSW0D6YfYLEhInjrwkZPsz4n0Vnc/+bIWPC++eN1aLD2f7KFlOOi8qwNP9MpQ==
X-Received: by 2002:a63:9f0a:: with SMTP id g10-v6mr21926716pge.324.1534266412536;
        Tue, 14 Aug 2018 10:06:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id d19-v6sm67940763pfe.42.2018.08.14.10.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 10:06:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        collinsd@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] regulator: core: A few useful patches for regulators that need load set
Date:   Tue, 14 Aug 2018 10:06:13 -0700
Message-Id: <20180814170617.100087-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches ought to be useful for those people who need to work
with regulator drivers where regulator_set_load() is important.  The
first patch in this series actually implements real functionality.
After that patch then devices whose drivers don't know to call
regulator_set_load() are more likely to work.  The rest of the patches
just work on regulator_summary to try to make it so we can confirm
that the first patch works.


Douglas Anderson (4):
  regulator: core: If consumers don't call regulator_set_load() assume
    max
  regulator: core: Add the opmode to regulator_summary
  regulator: core: Add consumer-requested load in regulator_summary
  regulator: core: Add locking to debugfs regulator_summary

 drivers/regulator/core.c     | 98 ++++++++++++++++++++++++------------
 drivers/regulator/internal.h |  1 +
 2 files changed, 66 insertions(+), 33 deletions(-)

-- 
2.18.0.865.gffc8e1a3cd6-goog

