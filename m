Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2265RoVmSJ4DIIaTmW98b+URGLYAlTu1nVDsPSdjKai2aRXmy3zsz+BpZocUtTCI8GgkSxoJ
ARC-Seal: i=1; a=rsa-sha256; t=1519676651; cv=none;
        d=google.com; s=arc-20160816;
        b=jYRMG/Nn3hWaq8TR7K3aqClybx8tFYibBdi6BjtgmK0Y4kSf+NgnagLm8zBZ8JLmwu
         mHJ8V1ZUrlJ+1TFlt4VrydI6YFkMp2RcNscQ1h7o+oWVCK/WRB/x79WZ9hYLLP5J20LM
         jIYhBq5jj7YeVX6tm+SDZMvfI1h2f+GQzKXWRHqZTHMHbdvvaUEAcBuLMcNTs4jSfOiF
         h9jxsuLNEknz+smR0Pbua5oLT18DN89SgUZJEzJpUiT0g13Wq8co9t+9XIurQNHoH0VE
         xyeT0IqexHsP41CzFYy3KZVZLhWlelN7h9+sHbTzLitPLwlsQWQDiKOY0uxv+CMiwXb5
         pPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4CAKnvNcIyJcCzCRCuLmpoyiA2j6Uerg9dWs5mEibF0=;
        b=dy45JnmKrCDaFUDChbROKLDXawOqfHArAHWn053djLeP10Fq0+9Xv/DEy06EFpVQwA
         bEmEi16j1Jow1Uj1jIUm4nF7eDFxf6966z7Rc4kwRB/Ymj5yYhvXPB8hNdyCMaB2citv
         foF9Zoneqrb6VatVwub3DUjmeDtuL3CKCnP9ZJQDA9MuOUNSPalEj/Lpn2xgtQ9RD7Qp
         EFAOUbzAu9mh9PzUWXYZZAt0VLhnCpFpI8+Hkz/Czl+VszG5bi/ALCJUgVz+yk8km6wz
         tdrPwSnoB1K41lijP30wJ9W/YSd1tJtasRkyGqj+Om4+VNp7mPUcH8lgTuc+RbNO2Tn5
         PUyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jessica Yu <jeyu@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Sebor <msebor@gcc.gnu.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Robert Richter <rric@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	oprofile-list@lists.sf.net,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 26/54] x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()
Date: Mon, 26 Feb 2018 21:22:03 +0100
Message-Id: <20180226202145.709601114@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495973889701786?=
X-GMAIL-MSGID: =?utf-8?q?1593496464390723071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 85c615eb52222bc5fab6c7190d146bc59fac289e upstream.

GCC-8 shows a warning for the x86 oprofile code that copies per-CPU
data from CPU 0 to all other CPUs, which when building a non-SMP
kernel turns into a memcpy() with identical source and destination
pointers:

 arch/x86/oprofile/nmi_int.c: In function 'mux_clone':
 arch/x86/oprofile/nmi_int.c:285:2: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
   memcpy(per_cpu(cpu_msrs, cpu).multiplex,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          per_cpu(cpu_msrs, 0).multiplex,
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          sizeof(struct op_msr) * model->num_virt_counters);
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 arch/x86/oprofile/nmi_int.c: In function 'nmi_setup':
 arch/x86/oprofile/nmi_int.c:466:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
 arch/x86/oprofile/nmi_int.c:470:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]

I have analyzed a number of such warnings now: some are valid and the
GCC warning is welcome. Others turned out to be false-positives, and
GCC was changed to not warn about those any more. This is a corner case
that is a false-positive but the GCC developers feel it's better to keep
warning about it.

In this case, it seems best to work around it by telling GCC
a little more clearly that this code path is never hit with
an IS_ENABLED() configuration check.

Cc:stable as we also want old kernels to build cleanly with GCC-8.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Sebor <msebor@gcc.gnu.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <rric@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: oprofile-list@lists.sf.net
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180220205826.2008875-1-arnd@arndb.de
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84095
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/oprofile/nmi_int.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/oprofile/nmi_int.c
+++ b/arch/x86/oprofile/nmi_int.c
@@ -460,7 +460,7 @@ static int nmi_setup(void)
 		goto fail;
 
 	for_each_possible_cpu(cpu) {
-		if (!cpu)
+		if (!IS_ENABLED(CONFIG_SMP) || !cpu)
 			continue;
 
 		memcpy(per_cpu(cpu_msrs, cpu).counters,
