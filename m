Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EAAC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0EF20651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956505;
	bh=2RK11LxbtsLKo3neffoRf5XkHTPvnw2ttdzhT+uq8aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DhaOaVfvIsGoRA+bZZloe7E+eLIXDWHgY3V1jpNSnqSh4BjJILBdAgwkz6GncLQzL
	 Ug2Xa8qykv1hLhgdBFvgdNE+M+yVMPt1hlAd16SkwKbqgdptcIwkhUEU2Vj5K1EbGG
	 jBJkDi2iq5MMfUsICAY/Bt1Ucj426Of/QcWY8Sro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfBWVPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbfBWVLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:11:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E2B2085A;
        Sat, 23 Feb 2019 21:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956260;
        bh=2RK11LxbtsLKo3neffoRf5XkHTPvnw2ttdzhT+uq8aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdOu/UDcXdTy5nAjiuyJ8G/dvR7RqV9MLDrmq6UYrdHTpM5z6TpEj6zkZoCCBXcdd
         BTOb4EBYGLGjsQW3Yx53UAiqlbYjwQ7rqbYAWeMpilYWWh/fEftwKlUs3/cUBfPSWs
         iMNHNOuvtle1B0ZkER/hXilgEmlAu/xjsFdW3V9s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.4 07/26] xtensa: SMP: fix ccount_timer_shutdown
Date:   Sat, 23 Feb 2019 16:10:28 -0500
Message-Id: <20190223211047.202725-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211047.202725-1-sashal@kernel.org>
References: <20190223211047.202725-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit 4fe8713b873fc881284722ce4ac47995de7cf62c ]

ccount_timer_shutdown is called from the atomic context in the
secondary_start_kernel, resulting in the following BUG:

BUG: sleeping function called from invalid context
in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/1
Preemption disabled at:
  secondary_start_kernel+0xa1/0x130
Call Trace:
  ___might_sleep+0xe7/0xfc
  __might_sleep+0x41/0x44
  synchronize_irq+0x24/0x64
  disable_irq+0x11/0x14
  ccount_timer_shutdown+0x12/0x20
  clockevents_switch_state+0x82/0xb4
  clockevents_exchange_device+0x54/0x60
  tick_check_new_device+0x46/0x70
  clockevents_register_device+0x8c/0xc8
  clockevents_config_and_register+0x1d/0x2c
  local_timer_setup+0x75/0x7c
  secondary_start_kernel+0xb4/0x130
  should_never_return+0x32/0x35

Use disable_irq_nosync instead of disable_irq to avoid it.
This is safe because the ccount timer IRQ is per-CPU, and once IRQ is
masked the ISR will not be called.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index b9ad9feadc2d1..a992cb6a47db3 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -87,7 +87,7 @@ static int ccount_timer_shutdown(struct clock_event_device *evt)
 		container_of(evt, struct ccount_timer, evt);
 
 	if (timer->irq_enabled) {
-		disable_irq(evt->irq);
+		disable_irq_nosync(evt->irq);
 		timer->irq_enabled = 0;
 	}
 	return 0;
-- 
2.19.1

