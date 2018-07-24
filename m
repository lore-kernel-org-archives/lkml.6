Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAACC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3432120852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqcUQ/bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3432120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbeGXXsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:48:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39224 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388915AbeGXXsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:48:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so5569269wre.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ui/ENQsK3coGxM9u4SbPNHKRlXUII1ql5vAqIOw34B4=;
        b=WqcUQ/bzhVX0/0O8uYdP/K/EI0gmkeE38EHoXu3Wwh0hQMixy8bGBJnLkJvxAIS4Jf
         rGUlGNKd/ceYtA10ofokRaMWEttqClPNt+eSAlmKfHB5UVsQcWRwZA8OpqCMp6wX9sAe
         qK0cvsXyOTmzbVIhguzr8VCa7wFnd1iKcgC43p2XtDeBWMPc/lZ0b2wpARuaWzmD78kk
         lcXqLOHomKOuL4ugEizedWA2z/xzcD3Brt/UD7l8ZKy8NAljQrJ/6YoGikzx9y7EwTTj
         CVtjaQGizabSk910MOUWXmjTNml/qrkKwnfUisxtnb7R/KGJU8XY/q36IjwdpLDQ9sV0
         6sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ui/ENQsK3coGxM9u4SbPNHKRlXUII1ql5vAqIOw34B4=;
        b=HJ7lECAXos92wKGnNnbJ7ppvHTlIxa7EoGIt/67CYvQrLYUAfFLLP0mhT1WTlTBCq2
         mxrG3d3fc/kt+noJCmyB9gfe1RB6GiNSHVICo2grHdNsl0iKXq0WLMW9KyJFVz6d9Elk
         CliBQenhggzh9ikiA1SF/p+Cg/ZI2KTXaUDglkCRR9FlZvglaHQ4Uu4xplYRDRnaZlsk
         njtOM6R72Gev77CMpLdsohQ2u9+FGGvDeXYPGPEwNtDH1fjU9IE+26pClX2p8s4jiOEL
         pmXufplhVYX36LnzFRvnttzTE/zC+FBF2L51Pk/ZY5oEvjnvUHBf1fZYcasqndptbzcx
         y07w==
X-Gm-Message-State: AOUpUlHjw7XrnCpoPMES8XSFGCQLbY/iQW1jMpTZmQizvWC09dsg2LFa
        5NuQ0svB0Q8KGirbmfVfKrc=
X-Google-Smtp-Source: AAOMgpev6r1Zg29hUlWLGn2u+SH70gJ+FiVU5OvsxVnwrOzKvO4YVDb7n8YFWjbjaxe4Ly2xhvN05w==
X-Received: by 2002:a5d:50cd:: with SMTP id f13-v6mr13563872wrt.73.1532471962038;
        Tue, 24 Jul 2018 15:39:22 -0700 (PDT)
Received: from we.local (athedsl-4407117.home.otenet.gr. [79.130.175.61])
        by smtp.gmail.com with ESMTPSA id b11-v6sm5289461wma.34.2018.07.24.15.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:39:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 488D464081F;
        Wed, 25 Jul 2018 01:39:20 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YJPD8qnwg33x; Wed, 25 Jul 2018 01:39:19 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id D4654640824; Wed, 25 Jul 2018 01:39:19 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Staging: octeon-usb: Applying coding style for column width.
Date:   Wed, 25 Jul 2018 01:38:51 +0300
Message-Id: <20180724223853.10198-3-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180724223853.10198-1-tsotsos@gmail.com>
References: <20180724223853.10198-1-tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves the warnings as its refereed to TODO list.
There are also a code style issues that could be resolved via breaking
down cvmx_usb_poll_channel().

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cff5e790b196..0d3ec12788fc 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -2637,12 +2637,14 @@ static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 				hcintmsk.u32 = 0;
 				hcintmsk.s.chhltdmsk = 1;
 				cvmx_usb_write_csr32(usb,
-						     CVMX_USBCX_HCINTMSKX(channel, usb->index),
-						     hcintmsk.u32);
+						CVMX_USBCX_HCINTMSKX(channel,
+							usb->index),
+							hcintmsk.u32);
 				usbc_hcchar.s.chdis = 1;
 				cvmx_usb_write_csr32(usb,
-						     CVMX_USBCX_HCCHARX(channel, usb->index),
-						     usbc_hcchar.u32);
+						CVMX_USBCX_HCCHARX(channel,
+							usb->index),
+							usbc_hcchar.u32);
 				return 0;
 			} else if (usbc_hcint.s.xfercompl) {
 				/*
-- 
2.16.4

