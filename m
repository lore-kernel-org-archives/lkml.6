Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeEELDf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 07:03:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46657 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeEELDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 07:03:33 -0400
X-Google-Smtp-Source: AB8JxZrUceRfeGFLI3mSZlV4YZi/DpwTUP3s2KDWLc3muc5PDiU9Acb10jNQvwXzKOR9bcdyvKkk6A==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>,
        Darren Kenny <darren.kenny@oracle.com>, Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH v3] KVM: X86: Lower the default timer frequency limit to 200us
Date: Sat,  5 May 2018 04:02:32 -0700
Message-Id: <1525518152-58340-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Anthoine reported:
 The period used by Windows change over time but it can be 1 
 milliseconds or less. I saw the limit_periodic_timer_frequency 
 print so 500 microseconds is sometimes reached.

As suggested by Paolo, lower the default timer frequency limit to a
smaller interval of 200 us (5000 Hz) to leave some headroom. This
is required due to Windows 10 changing the scheduler tick limit
from 1024 Hz to 2048 Hz.

Reported-by: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com> 
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
Cc: Darren Kenny <darren.kenny@oracle.com>
Cc: Jan Kiszka <jan.kiszka@web.de>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v2 -> v3:
 * update patch subject and description
v1 -> v2:
 * update patch subject and description

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
