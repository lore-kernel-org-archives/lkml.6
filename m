Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22613oUoN/wXd4Dj5zhqejYrIcwEDTse8Ee4c3De5H9IcmKSMbqAYh+b7bMF7pAODyT1yn5/
ARC-Seal: i=1; a=rsa-sha256; t=1519411171; cv=none;
        d=google.com; s=arc-20160816;
        b=WATvBSLZxVuZZ4A4kl+cmqN3nNt+wuiumtJqSiph+Lb9z7EZ+wIRbynAen4yedKrzA
         NAdfSqmSX8s6W+BsQ+bTMOFwY9nPPxX2N9q0LMzrBItoWx22LgnGgFSO4M298TRCIh97
         xpE4wzbnQSZL92d+2F6BxQlJspT+gQXD6dJLSt6W7yr1HHXxWsC3+cN3ZI6JLdJGUssh
         HdpxhiB6SqydellpnEt1V1qP6lxcPptx79WsRaPxK8n6vK3+b4gJkwMYo5gu8GaQ/kL2
         jtjou/cvNcAiY7c8Fmpn4fg2gA2nBf2IZi17VUP5V+sSoNvICEajNqJpaTvVHq2OUwsU
         c/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9Ja34OWzG1HWVS67QkfrUYZq41hst+OzfBQ6shv5xrw=;
        b=1LWNbNlNTnJ+hwLwRLS/NQUQxwXa7ICabknf3nkfXrciG3duS/qHXWwmRHHyEL2bb3
         Hj41kcTp1oODeQlPxtSSa+5RdkTVaLINi2KwO2cWWGLTwAyqd24fBErYi9WsNbHiq/JT
         VRcjVqrjpZDV2vmqm7cQe1Ed4tc824mwdAOV5NmBnueUCyHkRyaVPv4e7YktsDKkvwhN
         rOwuXutAwXO0xfJiOnFIXkyvzGjjZP1/kLf9Q8yUmJc25H7AS3V96Wt7hx0EaomN+kmj
         0pmB4Mld9oaxr8X2CLY/3zcaBFft6mobpnaqH+Xj06L69Khzr1B81haRfSNQRcrwTv+O
         NPvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 144/193] perf/x86: Shut up false-positive -Wmaybe-uninitialized warning
Date: Fri, 23 Feb 2018 19:26:17 +0100
Message-Id: <20180223170348.399001558@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218087998560586?=
X-GMAIL-MSGID: =?utf-8?q?1593218087998560586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 11d8b05855f3749bcb6c57e2c4052921b9605c77 upstream.

The intialization function checks for various failure scenarios, but
unfortunately the compiler gets a little confused about the possible
combinations, leading to a false-positive build warning when
-Wmaybe-uninitialized is set:

  arch/x86/events/core.c: In function ‘init_hw_perf_events’:
  arch/x86/events/core.c:264:3: warning: ‘reg_fail’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  arch/x86/events/core.c:264:3: warning: ‘val_fail’ may be used uninitialized in this function [-Wmaybe-uninitialized]
     pr_err(FW_BUG "the BIOS has corrupted hw-PMU resources (MSR %x is %Lx)\n",

We can't actually run into this case, so this shuts up the warning
by initializing the variables to a known-invalid state.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170719125310.2487451-2-arnd@arndb.de
Link: https://patchwork.kernel.org/patch/9392595/
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/perf_event.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -188,8 +188,8 @@ static void release_pmc_hardware(void) {
 
 static bool check_hw_exists(void)
 {
-	u64 val, val_fail, val_new= ~0;
-	int i, reg, reg_fail, ret = 0;
+	u64 val, val_fail = -1, val_new= ~0;
+	int i, reg, reg_fail = -1, ret = 0;
 	int bios_fail = 0;
 	int reg_safe = -1;
 
