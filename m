Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeDJL5O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:57:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752833AbeDJL5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:57:13 -0400
Date: Tue, 10 Apr 2018 08:57:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] target-i386: add KVM_HINTS_DEDICATED performance hint
Message-ID: <20180410115711.GE29865@localhost.localdomain>
References: <1518185725-69559-1-git-send-email-wanpengli@tencent.com>
 <20180309141653.GA2871@localhost.localdomain>
 <CANRm+CzKFoo4DfdiHyBiVPYaeMpMBq2MGck+i=qC2y8xfyCgKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANRm+CzKFoo4DfdiHyBiVPYaeMpMBq2MGck+i=qC2y8xfyCgKA@mail.gmail.com>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 05:13:21PM +0800, Wanpeng Li wrote:
> Hi Eduardo,
> 2018-03-09 22:16 GMT+08:00 Eduardo Habkost <ehabkost@redhat.com>:
> > On Fri, Feb 09, 2018 at 06:15:25AM -0800, Wanpeng Li wrote:
> >> From: Wanpeng Li <wanpengli@tencent.com>
> >>
> >> Add KVM_HINTS_DEDICATED performance hint, guest checks this feature bit
> >> to determine if they run on dedicated vCPUs, allowing optimizations such
> >> as usage of qspinlocks.
> >>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Radim Krčmář <rkrcmar@redhat.com>
> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> >> ---
> >> v1 -> v2:
> >>  * add a new feature word
> >>
> >>  target/i386/cpu.c | 14 ++++++++++++++
> >>  target/i386/cpu.h |  3 +++
> >>  target/i386/kvm.c |  4 ++++
> >>  3 files changed, 21 insertions(+)
> >>
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index d70954b..e2974ad 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -358,6 +358,20 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> >>          .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EAX,
> >>          .tcg_features = TCG_KVM_FEATURES,
> >>      },
> >> +    [FEAT_KVM_HINTS] = {
> >> +        .feat_names = {
> >> +            "hint-dedicated", NULL, NULL, NULL,
> >
> > I suggest naming it "kvm-hint-dedicated", to indicate it's
> > KVM-specific.
> 
> I found this feature is enabled by default w/o kvm-hint-dedicated
> parameter, any idea how to make it disabled by default?

You mean on "-cpu host", right?

The assumption in most of the code is that anything enabled on
GET_SUPPORTED_CPUID should be enabled on "-cpu host".  This
shouldn't be the case for FEAT_KVM_HINTS.

Untested fix below.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1a6b082b6f..a20fe26573 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -295,6 +295,8 @@ typedef struct FeatureWordInfo {
     uint32_t tcg_features; /* Feature flags supported by TCG */
     uint32_t unmigratable_flags; /* Feature flags known to be unmigratable */
     uint32_t migratable_flags; /* Feature flags known to be migratable */
+    /* Features that shouldn't be auto-enabled by "-cpu host" */
+    uint32_t no_autoenable_flags;
 } FeatureWordInfo;
 
 static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
@@ -400,6 +402,11 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EDX,
         .tcg_features = TCG_KVM_FEATURES,
+        /*
+         * KVM hints aren't auto-enabled by -cpu host, they need to be
+         * explicitly enabled in the command-line.
+         */
+        .no_autoenable_flags = ~0U,
     },
     [FEAT_HYPERV_EAX] = {
         .feat_names = {
@@ -4062,7 +4069,8 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
              */
             env->features[w] |=
                 x86_cpu_get_supported_feature_word(w, cpu->migratable) &
-                ~env->user_features[w];
+                ~env->user_features[w] & \
+                ~feature_word_info[w].no_autoenable_flags;
         }
     }
 
-- 
2.14.3

-- 
Eduardo
