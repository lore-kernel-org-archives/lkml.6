Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtTlo4nMcSaV4fUbJQPGVweajLpvxns7dCgJC3He/1sjwmkh2cFV0LfolxjUNIdMBB7eZJw
ARC-Seal: i=1; a=rsa-sha256; t=1519676197; cv=none;
        d=google.com; s=arc-20160816;
        b=WazYPyAUfhbxp7MGZKHxIq8z4dV5q8gTMmm0OCM9HgY1G4GN9EsxRMBhuQySAU5tZt
         QuKi2Fb1AFnUYiMbs4Ao6YOHIyP8NIM4FMLsxvj/X/RpVKlZ9z1Yb67yY7M5bO32FQ6/
         4w9ZOrXKsoFJR40Q7QlVLQBRtsc3CeULBMu0IrxJEeWrW6r+nSqqpnh4pyD7JiTLB/JJ
         tNqp9IGgvpq90TIoayeQO1CYNbnFJomE5okoUzQgk1SMl7fXJp98+kEmg61arFlQ6loc
         WkF97FZPoE7/9y2Wn42k5n3coXCwH3Rrf3YH+FRadECK04G3Ra6uQm1sghWU3E3wPb0q
         mEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u6ztRzyAf8khfauoJZLgYrsTurLz5pYF26gpm+oFB/o=;
        b=iXJKSaSuTnp0bTwd3o7X+N5alG5myeTLl7FPehcbUjJ1L4f3zB/N87tOtD354Qy50I
         mwKX0yLsgmWQQQoc8ppdkwbyXtXcKJsDAskte+Vq24zkMEvw4a/ymsuDotY2eu15OZf/
         aeR/waRa3GF2l1PQ+U6Q6Ii7D/pPZ0hctuqqHviBtvy/TMsne1gqr+YDXylx92ARX7lR
         juBXO5EpVAsnv9FMVDaHTGqNnx5zqTQpRkcGT3gs+PmVV1f05j9jH53yMU7kdDCXSYPp
         xlkWiZv2SUtEVPAYR1Ygg8SMImfXreeVvCkT4yEVeiKBBADOfymVuMvd5YDcS9NkOhX5
         aYqg==
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
Subject: [PATCH 4.4 11/22] x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()
Date: Mon, 26 Feb 2018 21:16:11 +0100
Message-Id: <20180226201559.228121253@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495973889701786?=
X-GMAIL-MSGID: =?utf-8?q?1593495988158006629?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -471,7 +471,7 @@ static int nmi_setup(void)
 		goto fail;
 
 	for_each_possible_cpu(cpu) {
-		if (!cpu)
+		if (!IS_ENABLED(CONFIG_SMP) || !cpu)
 			continue;
 
 		memcpy(per_cpu(cpu_msrs, cpu).counters,
