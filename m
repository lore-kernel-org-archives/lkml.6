Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFB62083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvWdV7zG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFB62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeIGWaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:30:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38720 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeIGWaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:30:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so12957324ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qM43LjXiLjSbUJAJgeRwrTixwsuyvPKwSICeRdq7uNY=;
        b=ZvWdV7zGjmfeG5v7DQcXbWgOALkUzB7iXaN9ap4QNEXoSirURz+XV/bcIMVaFYH5lm
         t0+38BIVe3S5PqYaPzHVL6cgPuJPI7AGUfaml98riBVHnf0FPFnWis8ufLBBsFnyVZZZ
         VdycG4nahFlFxn6hZlwoXTFwoN5V1FqbU78lxabLQg64CDPsoU2WWG/IfwUQ4kgLrM+1
         HS0Gp4mRiUSUT0LsO0viWZ7o2lV3J6ycsJlhUFsfbrRWhXXZw+OFHDmkG38+fdLGTdNC
         3xM/TfNHj/HE30v2a/UhuoPLjYwq0b05e1iDz/lKS0EFzRf5b8r0n2QKI4UxADq+g5fP
         CJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qM43LjXiLjSbUJAJgeRwrTixwsuyvPKwSICeRdq7uNY=;
        b=AesIMv95lN+1GWfdEPJmUaF+ee0o+ojkeyVKolcSntB3D4MGVXF+49uQ5RkRHQgiyI
         LpGnfn8TnkutxrxN+kydx0JNYPN62Hit3kUJwQYbhzc5O0H5Wd9tELmAF/2lzpz0S0/L
         WF6a6XEMvuupr46TK5T2HobI6ZwcwKhs3qMaNryZKkY41B0y5AEIL0T/H3Lb5LH9JN8X
         BWZ73KyZ/8kybJk45sBhWAmSc+5j+RErqd04BGRly7iVCDrw7PbOo/gqh4kqxr24cJ9j
         bOYRMH2PUrJc8UTXn4moa+z4uVGkolmt+j+ppCMJ0T2Y63IM5c+9Xem30/zbY3XA7c2E
         4fcg==
X-Gm-Message-State: APzg51AWd1KagneY5votvkyEfQ/IuDezSUTGP7KMA1JyZY4d2yvyYcMt
        6udnYyj4MyJae/jibCjSogY=
X-Google-Smtp-Source: ANB0VdYwL9olv9g6up0LhN5+n7Sf9rdwUZVmToGXyK2IWUFWTWY3YMUgKkmBJtZfmrQ2H3QB2JVvIg==
X-Received: by 2002:a2e:750d:: with SMTP id q13-v6mr5437493ljc.148.1536342492583;
        Fri, 07 Sep 2018 10:48:12 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id j135-v6sm1384100lfj.91.2018.09.07.10.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 10:48:11 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Jason Wang <jasowang@redhat.com>,
        Virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: add unlikely() to WARN_ON_ONCE()
Date:   Fri,  7 Sep 2018 20:48:02 +0300
Message-Id: <20180907174802.31900-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The condition to test is unlikely() to be true. Add the hint.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
---
 tools/virtio/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index fb22bccfbc8a..2b5e417ea2f0 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -123,7 +123,7 @@ static inline void free_page(unsigned long addr)
 #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 
-#define WARN_ON_ONCE(cond) ((cond) ? fprintf (stderr, "WARNING\n") : 0)
+#define WARN_ON_ONCE(cond) (unlikely(cond) ? fprintf (stderr, "WARNING\n") : 0)
 
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
-- 
2.17.1

