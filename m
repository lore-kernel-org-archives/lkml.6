Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756666AbeDBUTK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:19:10 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:48106 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753382AbeDBUTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:19:07 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
References: <87woypy8zc.fsf@xmission.com>
        <20180331105658.GA4332@asgard.redhat.com>
Date: Mon, 02 Apr 2018 15:17:58 -0500
In-Reply-To: <20180331105658.GA4332@asgard.redhat.com> (Eugene Syromiatnikov's
        message of "Sat, 31 Mar 2018 12:56:58 +0200")
Message-ID: <87woxpz7k9.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f35uy-0008M8-Pq;;;mid=<87woxpz7k9.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/mcFXZqwXToOqzso4Wq/iGPEO0+gx2Oo=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Eugene Syromiatnikov <esyr@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 767 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.9 (0.4%), b_tie_ro: 1.89 (0.2%), parse: 1.41 (0.2%),
        extract_message_metadata: 27 (3.6%), get_uri_detail_list: 5 (0.7%),
        tests_pri_-1000: 10 (1.3%), tests_pri_-950: 2.1 (0.3%), tests_pri_-900: 1.66
        (0.2%), tests_pri_-400: 39 (5.1%), check_bayes: 37 (4.8%), b_tokenize: 16
        (2.0%), b_tok_get_all: 9 (1.2%), b_comp_prob: 4.8 (0.6%), b_tok_touch_all:
        3.6 (0.5%), b_finish: 0.83 (0.1%), tests_pri_0: 669 (87.3%),
        check_dkim_signature: 0.96 (0.1%), check_dkim_adsp: 7 (0.9%), tests_pri_500:
        8 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] siginfo fix for v4.16-rc5
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Syromiatnikov <esyr@redhat.com> writes:

> So, the offset of the si_lower field is 20 at the current HEAD and was 18 at
> commits v4.16-rc3~17^2 and v4.16-rc1~159^2~20.  I believe this is due to
> the fact that m68k uses 2-byte default alignment and not 4-byte.

A 2-byte alignment for 4 byte pointers.  That is a new one to me.

Euguene can you test the patch below.  It should be fully robust against
this kind of craziness.  It certainly passes my BUILD_BUG_ON tests for
m68k.

Eric

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 2 Apr 2018 14:45:42 -0500
Subject: [PATCH] signal: Correct the offset of si_pkey and si_lower in struct siginfo on m68k

The change moving addr_lsb into the _sigfault union failed to take
into account that _sigfault._addr_bnd._lower being a pointer forced
the entire union to have pointer alignment.  The fix for
_sigfault._addr_bnd._lower having pointer alignment failed to take
into account that m68k has a pointer alignment less than the size
of a pointer.  So simply making the padding members pointers changed
the location of later members in the structure.

Fix this by directly computing the needed size of the padding members,
and making the padding members char arrays of the needed size.  AKA
if __alignof__(void *) is 1 sizeof(short) otherwise __alignof__(void *).
Which should be exactly the same rules the compiler whould have
used when computing the padding.

I have tested this change by adding BUILD_BUG_ONs to m68k to verify
the offset of every member of struct siginfo, and with those testing
that the offsets of the fields in struct siginfo is the same before
I changed the generic _sigfault member and after the correction
to the _sigfault member.

I have also verified that the x86 with it's own BUILD_BUG_ONs to verify
the offsets of the siginfo members also compiles cleanly.

Cc: stable@vger.kernel.org
Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
Fixes: 859d880cf544 ("signal: Correct the offset of si_pkey in struct siginfo")
Fixes: b68a68d3dcc1 ("signal: Move addr_lsb into the _sigfault union for clarity")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/compat.h             | 6 ++++--
 include/uapi/asm-generic/siginfo.h | 7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index e16d07eb08cf..d770e62632d7 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -221,6 +221,8 @@ typedef struct compat_siginfo {
 #ifdef __ARCH_SI_TRAPNO
 			int _trapno;	/* TRAP # which caused the signal */
 #endif
+#define __COMPAT_ADDR_BND_PKEY_PAD  (__alignof__(compat_uptr_t) < sizeof(short) ? \
+				     sizeof(short) : __alignof__(compat_uptr_t))
 			union {
 				/*
 				 * used when si_code=BUS_MCEERR_AR or
@@ -229,13 +231,13 @@ typedef struct compat_siginfo {
 				short int _addr_lsb;	/* Valid LSB of the reported address. */
 				/* used when si_code=SEGV_BNDERR */
 				struct {
-					compat_uptr_t _dummy_bnd;
+					char _dummy_bnd[__COMPAT_ADDR_BND_PKEY_PAD];
 					compat_uptr_t _lower;
 					compat_uptr_t _upper;
 				} _addr_bnd;
 				/* used when si_code=SEGV_PKUERR */
 				struct {
-					compat_uptr_t _dummy_pkey;
+					char _dummy_pkey[__COMPAT_ADDR_BND_PKEY_PAD];
 					u32 _pkey;
 				} _addr_pkey;
 			};
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 4b3520bf67ba..6d789648473d 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -94,6 +94,9 @@ typedef struct siginfo {
 			unsigned int _flags;	/* see ia64 si_flags */
 			unsigned long _isr;	/* isr */
 #endif
+
+#define __ADDR_BND_PKEY_PAD  (__alignof__(void *) < sizeof(short) ? \
+			      sizeof(short) : __alignof__(void *))
 			union {
 				/*
 				 * used when si_code=BUS_MCEERR_AR or
@@ -102,13 +105,13 @@ typedef struct siginfo {
 				short _addr_lsb; /* LSB of the reported address */
 				/* used when si_code=SEGV_BNDERR */
 				struct {
-					void *_dummy_bnd;
+					char _dummy_bnd[__ADDR_BND_PKEY_PAD];
 					void __user *_lower;
 					void __user *_upper;
 				} _addr_bnd;
 				/* used when si_code=SEGV_PKUERR */
 				struct {
-					void *_dummy_pkey;
+					char _dummy_pkey[__ADDR_BND_PKEY_PAD];
 					__u32 _pkey;
 				} _addr_pkey;
 			};
-- 
2.14.1
