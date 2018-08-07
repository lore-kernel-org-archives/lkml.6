Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D7AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6992157F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcT4F/uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6992157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbeHGPXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:23:42 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39249 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeHGPXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:23:42 -0400
Received: by mail-pl0-f66.google.com with SMTP id w14-v6so1526785plp.6;
        Tue, 07 Aug 2018 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ME/mOBwQdq4Dm8SdS8OUc9MhgdZev/Iu1cM/8Qi0MY8=;
        b=pcT4F/ujTgnshH94ZIdaYMfGOO5otnM/9Op2+yiih8B0Wq6N0XbRgQD2ZTzQZGw9Vr
         eh+f/u70L3oa+euAJa33GAjhw/yewJreNQT9e6BaV+JT7yAgerJdOdUcEhzmtfgsKvEB
         Pe/b5OyhRWVY10eYJP08CRTrpzTSe0Zbl5XbIalmgPhqp97dSvhsWvGx9xq2YTA5p8JH
         K1FPU1DgLcxOaP2uXZ76io19LkFCOHQshZRS/Ui3MDR9I+GpvvE3oimF8fhNbsh7zl3a
         RzGpC85fY3wMaON36XRJjtyYc2RrrL8GJpOYV5Iser9rWSyvZAOref8yoY3i5UjbQ0Cj
         a4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ME/mOBwQdq4Dm8SdS8OUc9MhgdZev/Iu1cM/8Qi0MY8=;
        b=hyKalnH6vQ5Gj7pHrHSqLiMWtJIscLbJCGmFV8Vmo0Mtt10X4pZuSDXT7jxyT4tSpf
         6etBLkcannGl9sJbvGsXrFJDx6bUQYHbKB4IogBCJgCzg1DTxTUawn8L7S05D+m6eSFO
         3DQncNkJKCbChUCGvltSTDTc2e98jJIXEFaLf7I0CB3KRkWPFjXW7kmpX1HV/+wGagZS
         xDfBQYDDfD37KFT8+WTG7s8wZv76Q2yCCiDpG/lgNv/CkUhFY3BW2+NzGvg5jU1GOzlp
         Sf7OoJgExrR5pp+Svlzik0XqPXdomLK21kI0KpHRmrlYacj+UgXqxUz8ZaDlSQQpJdWL
         iJNQ==
X-Gm-Message-State: AOUpUlH5Dl/aueKLV7u56kzqFKP6ie6pyJOqRi/ZS31RHy2s9N7OQT3j
        62rIVgk5i6gQK/l7zdy7uSA=
X-Google-Smtp-Source: AAOMgpeNCPrENkuQ00sGLl5N4CenVy6CCRA/+JkojgYddVM+XXo/48vdxBqr+oIzX/ybyHFGNjg8RQ==
X-Received: by 2002:a17:902:d68d:: with SMTP id v13-v6mr5898229ply.278.1533647366805;
        Tue, 07 Aug 2018 06:09:26 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id 73-v6sm5339229pfu.20.2018.08.07.06.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 06:09:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] host1x_cdma_update_sync_queue() clean up
Date:   Tue,  7 Aug 2018 16:07:10 +0300
Message-Id: <20180807130713.1016-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: I've added two more patches on top of "Cancel only job that actually got
    stuck" patch. Hence it is a patch-series now.

Dmitry Osipenko (3):
  gpu: host1x: Cancel only job that actually got stuck
  gpu: host1x: Don't complete a completed job
  gpu: host1x: Continue CDMA execution starting with a next job

 drivers/gpu/host1x/cdma.c       | 62 +++++++++++++--------------------
 drivers/gpu/host1x/hw/cdma_hw.c | 13 -------
 2 files changed, 24 insertions(+), 51 deletions(-)

-- 
2.18.0

