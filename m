Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B379FC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F24D20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyJJfFLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F24D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeJWXZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:25:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38717 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWXZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:25:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so2098661wrs.5;
        Tue, 23 Oct 2018 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DNPRj44yO0W2TUQq8beXtrJGB9zkBaGSgZsPlXqFj/A=;
        b=QyJJfFLOY65FbWduxMazW7FJJXkw829rPfmxBiDmTW1Grwx3zH4By+FeutZyqpGuUB
         d1twqZKnF2Y5h+gal1/ugPCpPGHXMExhLZlXQBtMemOV5Jx+GDd8sQ63Cy058iJkGwe8
         k01594Wk+rR3HpFrHr8BmEeK9Jyu1AX9f5gRHZpEqlWIWxMV0fqOdBiBDETuC4HMUiyU
         iMTBHBCrwDRlYuixfZhjfNuBdwa/e9NQho4NjA4hFFF402j1i94/Cg/LK5PIsUuqFbuc
         5h/OjZI5lnc917GsV7huKASiiHKTmYE5NfCkGzA1tjqYR2K6yUxSLjDgOUWZ4+Yl9jab
         VCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DNPRj44yO0W2TUQq8beXtrJGB9zkBaGSgZsPlXqFj/A=;
        b=KWJCV8NnptvtE1xPd0zvOEiFO8ehJBl1u5x3pzwvDgcmvqwfU+P2+MFzEkDyWDkuVT
         17Fd6T8/nBGUDFT7Qtg5B15ZVWDOE3rJTkDHNmHc+dQwd3xyMm6BY2cz0oxCMaxDNNlS
         j1WM1ypsIrZzS/smaXsvw13LGCIBKXE6jmBQ8V4Vr9IFv1ncUFMLUST/5zaRjkt5vxkB
         gHrlarPmjOuhB0pZl2V0VqPnJSJ2CnONA10vNjyUdZ4aRE2O3U/3i+x9TAmIWeH6uLZs
         vUUNz6kGsMoguDHquIY9/qXUPbqZBzHfAsybrpxXlenuoUr1FoY3A7hSPFis+4T+N3o3
         GWmg==
X-Gm-Message-State: AGRZ1gJSQy+fmw+ElL1QXOZL1yaM6G3LqbZgeQVz9/1p3AfyLF3Seqvg
        yqK8Fiq9GaBMMyIoDxOv6T4=
X-Google-Smtp-Source: AJdET5cNURh1YsokQ/6OfdD+fmprUGaZlvkGHNHrg0IjSoikyPmCoh5KQV/CNN2LXvnDDXLFyLQiyA==
X-Received: by 2002:a5d:5449:: with SMTP id w9-v6mr4685974wrv.284.1540306875020;
        Tue, 23 Oct 2018 08:01:15 -0700 (PDT)
Received: from artemis.netio.cloud (bzq-218-196-25.red.bezeqint.net. [81.218.196.25])
        by smtp.gmail.com with ESMTPSA id u132-v6sm2485699wmg.17.2018.10.23.08.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 08:01:14 -0700 (PDT)
From:   Rami Rosen <ramirose@gmail.com>
To:     pandit.parav@gmail.com
Cc:     tj@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Rami Rosen <ramirose@gmail.com>
Subject: [PATCH] rdmacg: fix a typo in rdmacg documentation
Date:   Tue, 23 Oct 2018 18:01:06 +0300
Message-Id: <20181023150106.7332-1-ramirose@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a typo in RDMA cgroup documentation.

Signed-off-by: Rami Rosen <ramirose@gmail.com>
---
 Documentation/cgroup-v1/rdma.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/cgroup-v1/rdma.txt b/Documentation/cgroup-v1/rdma.txt
index af618171e0eb..9bdb7fd03f83 100644
--- a/Documentation/cgroup-v1/rdma.txt
+++ b/Documentation/cgroup-v1/rdma.txt
@@ -27,7 +27,7 @@ cgroup.
 Currently user space applications can easily take away all the rdma verb
 specific resources such as AH, CQ, QP, MR etc. Due to which other applications
 in other cgroup or kernel space ULPs may not even get chance to allocate any
-rdma resources. This can leads to service unavailability.
+rdma resources. This can lead to service unavailability.
 
 Therefore RDMA controller is needed through which resource consumption
 of processes can be limited. Through this controller different rdma
-- 
2.17.1

