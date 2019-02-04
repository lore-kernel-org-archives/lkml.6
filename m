Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D686CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BE72082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwdoEbbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfBDSTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:19:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46815 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDSTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:19:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so277365pfe.13;
        Mon, 04 Feb 2019 10:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y7C467UHY1ApxkxNkde5pS9++k5K00rvSuCeNYW/XeQ=;
        b=iwdoEbbnl4vZrbishwBQADfm0EjzsEvtHQeQ6GN0r++6qhZmzJ4ra5tLQ/peaafWbw
         GVn04HzCjogTvmqOQVez+ktoUNo643bJP+Voe3yD2BNf9GGKcUiuhld+hFM99JLyyuTy
         Yfz+Ft0DJiABsRnpy8YvYeISWquaVnSpYfsfr9te6EaUtjikDvw7UUfjGd56lzJLLwUf
         UV2OAV5ORXguYBBzpKG2kFVB0EB0xq4Vf7tQTZmqIoFZypIHOX1vmeJh7cCZkmMmUx3j
         UsBBFie+qczkJY7HzLQgkDB6dyJPnGBJ9UsDEHwX3DIS1/Cw/wbIEYGaAxVDoqrkJw9V
         wlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Y7C467UHY1ApxkxNkde5pS9++k5K00rvSuCeNYW/XeQ=;
        b=EzsduwiSDpt6cBLC9Qv2OpE9B3DOHgxnCrRd82Z5bLs2YZsVhkOh4KPhAxNcA7xk9v
         Ku8szrk7keEYiFUZYFlEopByiTSNOhRbBKTktngZNlGRhL1igbmZv7SdCZQ43zuXdlkP
         vblozJq1y+c3QvrA6jDPy/5ZJMgQuvnDZXxiuK/XJbDDKNE1v8ypbMzW9YQbI0/T/HQm
         CaFgEOn4i6P9XVCWlHJah7mpYxEKiBgNeyt2/ZVt/L68Y3QmvFKNQyGpFZkFrNzGw6ZA
         eGU84w3JYanoAd2vRhCI0p2EB3HU6BJmXUOyXes4d7idkatcwqu6HOrae4X1JYP5Mh1c
         zcIA==
X-Gm-Message-State: AHQUAuYgqmLQaXYVU52PBOTWdc3c2yisKeegi2EYuBeP7m7OdSotBL/I
        ZVl1qYBe62ICwE19ioZ6k4k=
X-Google-Smtp-Source: AHgI3IaZ5KYOLTDHY5ylXp1cXQI1eFxJVc/+W8nm45glPPlIfvBa3WiT3NNRTVLf89Oqk2rOV4wjQQ==
X-Received: by 2002:a63:3206:: with SMTP id y6mr627427pgy.338.1549304390629;
        Mon, 04 Feb 2019 10:19:50 -0800 (PST)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d21sm811265pgv.37.2019.02.04.10.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 10:19:50 -0800 (PST)
Subject: [RFC PATCH QEMU] i386/kvm: Enable paravirtual unused page hint
 mechanism
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, alexander.h.duyck@linux.intel.com,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org
Date:   Mon, 04 Feb 2019 10:19:49 -0800
Message-ID: <20190204181825.12252.81443.stgit@localhost.localdomain>
In-Reply-To: <20190204181118.12095.38300.stgit@localhost.localdomain>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

This patch adds the flag named kvm-pv-unused-page-hint. This functionality
is enabled by kvm for x86 and provides a mechanism by which the guest can
indicate to the host which pages it is no longer using. By providing these
hints the guest can help to reduce the memory pressure on the host as
dirtied pages will be cleared and not written out to swap if they are
marked as being unused.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 target/i386/cpu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2f5412592d30..0d19a9dc64f1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -900,7 +900,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
             NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
-            NULL, NULL, NULL, NULL,
+            "kvm-pv-unused-page-hint", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             "kvmclock-stable-bit", NULL, NULL, NULL,

