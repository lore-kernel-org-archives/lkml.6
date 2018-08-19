Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30997C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707F12145D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=jpberlin.de header.i=@jpberlin.de header.b="xH+xOm/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707F12145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jpberlin.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeHSTkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:40:46 -0400
Received: from plasma4.jpberlin.de ([80.241.57.33]:58514 "EHLO
        plasma4.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbeHSTkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:40:46 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Aug 2018 15:40:45 EDT
Received: from spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115])
        by plasma.jpberlin.de (Postfix) with ESMTP id 1DF49B7B14;
        Sun, 19 Aug 2018 18:22:01 +0200 (CEST)
Authentication-Results: spamfilter01.heinlein-hosting.de (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=jpberlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jpberlin.de; h=
        x-mailer:message-id:date:date:subject:subject:from:from:received
        :received; s=mail20140220; t=1534695720; bh=ocA4r8FAWIjq+awUwO+o
        8jP0gnXXzxve0T43t/bIcpE=; b=xH+xOm/tsYAEoSaFTaFB9oBxpVL8KSVBJR5o
        p8m41RhHucIiAaMO0ALi2G6n4GR/4A2Up83A5yVQ2KVkeW+TvzdYIu5AqP4vL8YK
        w/OaG1TSTxUU88VvdctveBeeBa4r3BofFP7loyWAgbr0mXtr/tmIakRcA2ISWWoJ
        RxDFpEA23bQFEHzfNC+hjZ62fGl/6RxANk4l7lOnPDlBymGGoX+jyw5yIn1b3mnZ
        iGMcxqdsgRP/tuDMrdBfKE4581VztE758Ni6/RSc6GMainW0U8LtTgnNa3QxPfD9
        pPbkKEvjC3M7FHIJiFSQp7PhcubRUy2bBLGXCvHvV5UBJy0tdwDj1tjqxIqg4aeF
        5QP5bX+GZmceDZqTWL0px1C1WhAqWQANKBZ2sN7wSueWI8h103nJENbGKeFIWeiQ
        gOarxiXqV1eeBOu/zNtyA6A9OXwDJDNbfWnnFrHU1XhglPGjDwiylGSx5+nfRFUT
        U+LVsDNNK6aNgP9fOVLsO9UOcNkumoa1ufI6kjl1IPKMflPfJJLKbcTK/aDM/Qwy
        jmvBpUxbrPPABk4ezr8OBCf0XIZChYdxK0yfawqpp0jDpmmHt+/K6HvZqncVjKL+
        5CnMXbr/P+7LT161feCfRhfFsnA5NKMuqgU5EmoiGKvQSVdb0rC0Nh/q3sHV9psB
        CcDSGJk=
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.68])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id ni7roFRIZsSh; Sun, 19 Aug 2018 18:22:00 +0200 (CEST)
Received: from localhost.localdomain (ip1f12ba6b.dynamic.kabel-deutschland.de [31.18.186.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: jnaw@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 83CB2B6374;
        Sun, 19 Aug 2018 18:21:59 +0200 (CEST)
From:   Jannis Nawroth <jnaw@jpberlin.de>
To:     ruxandra.radulescu@nxp.com, ioana.ciornei@nxp.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Jannis Nawroth <jnaw@jpberlin.de>
Subject: [PATCH] Staging: fsl-dpaa2: ethsw: dpsw: Use correct SPDX-License-Identifier comment
Date:   Sun, 19 Aug 2018 18:21:36 +0200
Message-Id: <20180819162136.19647-1-jnaw@jpberlin.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use correct comment for SPDX-License-Identifier

Signed-off-by: Jannis Nawroth <jnaw@jpberlin.de>
---
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index db43fa3782b8..95feb7ffd575 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -1,5 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
+/* SPDX-License-Identifier: GPL-2.0
  * Copyright 2014-2016 Freescale Semiconductor Inc.
  * Copyright 2017-2018 NXP
  *
-- 
2.18.0

