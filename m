Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48/fhY1+3To2CsTWotNl4RWZ0pcLlq4gB1Of1+1/yX1HlJgyEmknbzZ690VAivnIsGA18sj
ARC-Seal: i=1; a=rsa-sha256; t=1524405819; cv=none;
        d=google.com; s=arc-20160816;
        b=TiMKj/sC36DnlQCd53glRPmew+m7osdAT38v4KY2+V0J96MhwwiaT1VwCgajYlBoFC
         NukdXvLntLyXt2iMrG+MHs1Wajs05AuK6hB9ul0EzlOD96OUEv/imLSpu/7BfK16e6TJ
         /oVXRqRS22nJdCHbiGQM2nj9u0mdJ0sDASDimSnySO2qavzpNBmaZTUXGl949UJrJZI2
         4wILnHrduIgWj5QRBXSXoOA1qmyacsZPL/k5Sy3NCpI4dep2Oi+Qdj3HIWokoqMb94qA
         nbu5dH6DohD/oEbX6EAvVgRIxNlf58gLmZNLI3zzqi8bGpsX4kLLNu90J5EQUOImS9A7
         AGmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0jYbEBF7edRbxLhCb0ISkX9QE6A1deTflSmTdmk9NHg=;
        b=jQyRR2E+lJCc3s3YMngoysmqgYTaaxn0mj863WqLoMYGbeseWrkgVD9r5UJQ49ZynV
         S155Js6X73Ktz/dpeY6SQPTYLugIHB/7GL/TiC1u5Z8nbF+gmiPBmo+rtJAfqnsLm4BP
         tnFX0Ymw0uCgUGMDxEe5JatBcXB+2RVGVM/Pob8pFWUoMiOV2wg9/TVI4Q/g9dSoP2/3
         rlGlt2Rkxe/BQEKp71se7NHli9itIAg2BUt/yplMELneNhpdIQHaO3Gd2FGNUUIL5Ekg
         2pYULda2QL26bRXtU8H0dJYSzXg4kqDucvjNxwJSDAL2OF0RuRpjzECjAS2XO/pR0kNR
         dN7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 010/164] task_struct: only use anon struct under randstruct plugin
Date: Sun, 22 Apr 2018 15:51:17 +0200
Message-Id: <20180422135135.818096236@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454899762743687?=
X-GMAIL-MSGID: =?utf-8?q?1598455356670564211?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 2cfe0d3009418a132b93d78642a8059a38fe5944 upstream.

The original intent for always adding the anonymous struct in
task_struct was to make sure we had compiler coverage.

However, this caused pathological padding of 40 bytes at the start of
task_struct.  Instead, move the anonymous struct to being only used when
struct layout randomization is enabled.

Link: http://lkml.kernel.org/r/20180327213609.GA2964@beast
Fixes: 29e48ce87f1e ("task_struct: Allow randomized")
Signed-off-by: Kees Cook <keescook@chromium.org>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/compiler-clang.h |    3 ---
 include/linux/compiler-gcc.h   |   12 +++---------
 2 files changed, 3 insertions(+), 12 deletions(-)

--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -17,9 +17,6 @@
  */
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-#define randomized_struct_fields_start	struct {
-#define randomized_struct_fields_end	};
-
 /* Clang doesn't have a way to turn it off per-function, yet. */
 #ifdef __noretpoline
 #undef __noretpoline
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -229,6 +229,9 @@
 #ifdef RANDSTRUCT_PLUGIN
 #define __randomize_layout __attribute__((randomize_layout))
 #define __no_randomize_layout __attribute__((no_randomize_layout))
+/* This anon struct can add padding, so only enable it under randstruct. */
+#define randomized_struct_fields_start	struct {
+#define randomized_struct_fields_end	} __randomize_layout;
 #endif
 
 #endif /* GCC_VERSION >= 40500 */
@@ -243,15 +246,6 @@
  */
 #define __visible	__attribute__((externally_visible))
 
-/*
- * RANDSTRUCT_PLUGIN wants to use an anonymous struct, but it is only
- * possible since GCC 4.6. To provide as much build testing coverage
- * as possible, this is used for all GCC 4.6+ builds, and not just on
- * RANDSTRUCT_PLUGIN builds.
- */
-#define randomized_struct_fields_start	struct {
-#define randomized_struct_fields_end	} __randomize_layout;
-
 #endif /* GCC_VERSION >= 40600 */
 
 
