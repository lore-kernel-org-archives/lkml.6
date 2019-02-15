Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD44C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB1B2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393083AbfBOWDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:03:18 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55869 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733184AbfBOWDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:03:18 -0500
Received: by mail-it1-f194.google.com with SMTP id z131so17371871itf.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 14:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=knOx25++K9f2PpNjsJJVR0YOB7lmETFhT/2wOOmVbyI=;
        b=uZ6eE1Mq3xDrsBc6cncq3cAv2cBESWTX977XOugzEbl03jQ1xCp6Nimwa2i9hLfVDK
         fJheNOlGQVJG0In6WM3/MnwZx+8giK9WUlg8V5WkyMD2lbo0axJ6e/kELXi+74hDq6MR
         il2vuhjpuHlXs3Jd1VCSAtVKhGoEXCMyIxdDS26R8TqSzSHyWcmhiFqe/Plm2kVPTTOH
         i/aURZXA2bUvB4mz1fRywGx0EKwNzXv7ylgK0mzZ75p+ymrq9frYz0Ch71iH5Kl1UvqG
         5G7Brdzpvf4+KRKOUbGEKUvsUsuoiYiIXPHj0iNUU8iWh1qj4IYiQhlwxwidOShFHdhf
         kLug==
X-Gm-Message-State: AHQUAuZemR+z3HQ79bwcJ+Yxno+LXiCqEbkNSph2owBQdB3w5qY//qv+
        Q7sKeqGlqGFl0nXosTxT0CBSf4fd
X-Google-Smtp-Source: AHgI3IaPOY3MGT7Hc42bw4lHubQ54ojv6PJLAbIS0r7dZwHoVZg0zoDqUP+ripx76BEBX6RGv1tKbg==
X-Received: by 2002:a5d:974b:: with SMTP id c11mr7107691ioo.257.1550268197345;
        Fri, 15 Feb 2019 14:03:17 -0800 (PST)
Received: from mail-it1-f174.google.com (mail-it1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id k77sm3184384itb.7.2019.02.15.14.03.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:03:17 -0800 (PST)
Received: by mail-it1-f174.google.com with SMTP id l15so14271209iti.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 14:03:17 -0800 (PST)
X-Received: by 2002:a6b:b408:: with SMTP id d8mr6192402iof.138.1550268196904;
 Fri, 15 Feb 2019 14:03:16 -0800 (PST)
MIME-Version: 1.0
From:   Sultan Alsawaf <sultan@kerneltoast.com>
Date:   Fri, 15 Feb 2019 14:03:06 -0800
X-Gmail-Original-Message-ID: <CAFArEyWsuvEMFQ-CpTeawBbDY1egDzXf1HaOyd9z-uKcbSCq=Q@mail.gmail.com>
Message-ID: <CAFArEyWsuvEMFQ-CpTeawBbDY1egDzXf1HaOyd9z-uKcbSCq=Q@mail.gmail.com>
Subject: [PATCH] random: fix inconsistent spinlock usage
To:     tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users of the struct entropy_store spinlock use the irqsave spinlock variant.
Spinlock users of the same lock should use be consistent in their use of a
certain spinlock primitive, which makes add_interrupt_randomness()'s spinlock
usage incorrect.

Fix the inconsistency by converting add_interrupt_randomness()'s spinlocks to
use the irqsave primitive.

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 drivers/char/random.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38c6d1af6..1365017a7 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1239,6 +1239,7 @@ void add_interrupt_randomness(int irq, int irq_flags)
  __u64 ip;
  unsigned long seed;
  int credit = 0;
+ unsigned long flags;

  if (cycles == 0)
  cycles = get_reg(fast_pool, regs);
@@ -1269,7 +1270,7 @@ void add_interrupt_randomness(int irq, int irq_flags)
  return;

  r = &input_pool;
- if (!spin_trylock(&r->lock))
+ if (!spin_trylock_irqsave(&r->lock, flags))
  return;

  fast_pool->last = now;
@@ -1285,7 +1286,7 @@ void add_interrupt_randomness(int irq, int irq_flags)
  __mix_pool_bytes(r, &seed, sizeof(seed));
  credit = 1;
  }
- spin_unlock(&r->lock);
+ spin_unlock_irqrestore(&r->lock, flags);

  fast_pool->count = 0;

-- 
2.20.1
