Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeDDKqF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:46:05 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48021 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeDDKqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:46:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        David Hildenbrand <david@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: kvm: hide the unused 'cpu' variable
Date: Wed,  4 Apr 2018 12:44:14 +0200
Message-Id: <20180404104449.113197-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:BQUml2M6sUsn6EsBUvm3QBmoWa0dZQc2If4szyNInaTC1IzeVPn
 BRG4WeC3iiWoXpHz+nhF1AOzuX770+RXs8XjOVCkJ/34YqCkPwgyyLqbhQ+1+80VdrH9Y9s
 5gWId1xcHLjLcfCkuM6zGoRqboyFARgg6y3Z26hr4CU3wSE731IE2ap16yinKpCsxFE2Kqd
 DAW6ORpqdVpBDOAKJRshQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ObOSg6mvcTQ=:sXibSBfEZrszB4JyYzag97
 Wda+Vhag4UpkYsQOIm58F3ltcy1lziRMlDLMZ8sPD/z+vtgy8DnJ8XLKN3MgwGGhlKIDjA7k0
 m77HEZduP022/iGBiKI7SyhwoqOSNo3Rw4spv523Q8GmitVP6PvZ9lk55JwG8Bugjq9Y6TkhL
 u3xXNsJ7gItyqt9x8WovSmh+0TjuQdI5XGM1bSytlqEk2Cba2VBQpCDFi5QhBGLqerVVDId19
 d/7449AqN7BSWE8dTz/heQBjcZxW54U+1gEEaWyM4RwHrx3VP9J1AQnJ50t0oNRiHNCeEQ24B
 yimuj9wJVXK0ev9o4Nqgs9IAHumYx3obD6JH5lMNSBoYyVkbQIOV805YlXfEO8QB+fCE+p8O2
 MCG13a4sqTPHaeYveDpss6pU/sMuEe1+zruyE2gGrIegGHwR5npeoTn40mOOqAceoPUCWgnlP
 AZ2gtFGcpNWXJL74DJWInH+5gUhfSEub34jzWt89GG0JzXw1AmFOwh8bKTXy6aTOaB6pECmH8
 f+kogJGbVPlo/5jBbcs+Mzq9aqp9xFnLtkQsWX/BBtzl3ydk7uENR3b0xusOyhprrZshfieyY
 dXmuAHhdGL9NKfh40SjgLkd0cm6bbKkxxUK9lxOP/ce9pgM8rx72ZRGe6gfOMlWKoj+iOZyc6
 4QYbbuGun/aoeJvU6sEgC/qYZVxzdVCnQU5e/Mg1483KE0MDxXy0xmL+iw3AhKp+xM9XWkrAw
 V1vOPiDDX4aD/SXVDmjHGSsAJA9GR1MQ4/W4+Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable was newly introduced but is only accessed in one
place on x86_64, but not on 32-bit:

arch/x86/kvm/vmx.c: In function 'vmx_save_host_state':
arch/x86/kvm/vmx.c:2175:6: error: unused variable 'cpu' [-Werror=unused-variable]

This puts it into another #ifdef.

Fixes: 35060ed6a1ff ("x86/kvm/vmx: avoid expensive rdmsr for MSR_GS_BASE")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kvm/vmx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 8307f625ea99..7399a4a17f78 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2357,7 +2357,9 @@ static unsigned long segment_base(u16 selector)
 static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+#ifdef CONFIG_X86_64
 	int cpu = raw_smp_processor_id();
+#endif
 	int i;
 
 	if (vmx->host_state.loaded)
-- 
2.9.0
