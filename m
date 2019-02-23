Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0A4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A93220861
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956216;
	bh=inMo0OE74ODR41hCj2uE8MSO9Iqm7lwdSYWijsE8KFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d7PA+4B1qg6mxAzpQTtqGgSpr8QPFuliDrEZiEaWXxBjbAbAtC3algMijgHuNvNYx
	 kJcGTL+ZkH0XReseNlTbJGLGacS9ptFqBuLzq+BmxOY2H8WEu/05aqLTeeUWqTN+b9
	 F2FZB6bbNw5YWBGj8OzPpLyi8glwyxMOnYilopMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfBWVKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:10:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729677AbfBWVKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:10:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75EF02086A;
        Sat, 23 Feb 2019 21:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956207;
        bh=inMo0OE74ODR41hCj2uE8MSO9Iqm7lwdSYWijsE8KFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oesFkNbnhCa2yfoI1PfVnhYoetMgB6KeRzVK1TLZ6+zy+HFQPT1e3EAfyTbGlyCh+
         qWshaQf09pPJAtV6uvs0wY5k3VTsJi6/ITCnCWgMWEjKmVw7NlAwgwmGnOoSaPg4Rs
         tyBTbPkikLalyMv8goySMDYYm++Me1wUws720C0c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.9 10/32] xtensa: SMP: fix ccount_timer_shutdown
Date:   Sat, 23 Feb 2019 16:09:29 -0500
Message-Id: <20190223210951.202268-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210951.202268-1-sashal@kernel.org>
References: <20190223210951.202268-1-sashal@kernel.org>
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
index be81e69b25bc9..2251a6e0973a8 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -89,7 +89,7 @@ static int ccount_timer_shutdown(struct clock_event_device *evt)
 		container_of(evt, struct ccount_timer, evt);
 
 	if (timer->irq_enabled) {
-		disable_irq(evt->irq);
+		disable_irq_nosync(evt->irq);
 		timer->irq_enabled = 0;
 	}
 	return 0;
-- 
2.19.1

