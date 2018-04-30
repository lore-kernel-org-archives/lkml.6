Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeD3CjX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 22:39:23 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42075 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeD3CjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 22:39:21 -0400
X-Google-Smtp-Source: AB8JxZqXnHV7cUlvakBeBuGEfjJowwoiKRzLju31qnM5izAOA82ruRBlAHfOznnq68MtTMfCLdZ0og==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
Subject: [PATCH] KVM: X86: Limit timer frequency with more smaller interval
Date: Sun, 29 Apr 2018 19:38:20 -0700
Message-Id: <1525055900-20729-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Anthoine reported:
 The period used by Windows change over time but it can be 1 milliseconds
 or less. I saw the limit_periodic_timer_frequency print so 500
 microseconds is sometimes reached.

This patchs limits timer frequency with more smaller interval 200ms(5000Hz) 
to leave some headroom as Paolo suggested since Windows 10 changed the 
scheduler tick limit from 1024 Hz to 2048 Hz.

Reported-by: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com> 
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 51ecd38..dc47073 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -114,7 +114,7 @@ module_param(ignore_msrs, bool, S_IRUGO | S_IWUSR);
 static bool __read_mostly report_ignored_msrs = true;
 module_param(report_ignored_msrs, bool, S_IRUGO | S_IWUSR);
 
-unsigned int min_timer_period_us = 500;
+unsigned int min_timer_period_us = 200;
 module_param(min_timer_period_us, uint, S_IRUGO | S_IWUSR);
 
 static bool __read_mostly kvmclock_periodic_sync = true;
-- 
2.7.4
