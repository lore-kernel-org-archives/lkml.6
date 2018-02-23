Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvpfh5Aj+BFWVepVvWKjOoMmXrqF6h3zn3NzrAbbQad0jHfEMd1WaIKMPQXIFUxZCgVGlDZ
ARC-Seal: i=1; a=rsa-sha256; t=1519411588; cv=none;
        d=google.com; s=arc-20160816;
        b=PwJV8R+uCECKr8UZ4t1YoQk+OjHnDoNVYG1GMhv29fRI302r5MLe/oSf2NLVWg0sI9
         PMgdpG4PX0frhhIJ1uBbkI8NRo00KikpWNZwvPC7yWW6eYmTKsowUvto26s6DabCazvn
         S2hNNz1tDTEqYf7gfMbfLLpQo4kXdGUo8UyG5uv0ZEa2+pfwWjLtMFqbmFVVrThy3H5g
         RdLfRi1yPi9lqzc/HuL70m/+JD+UB2XWlpY/Y4sItmD5g6Nui+Lu7/PHnG1bzP/Rs43g
         5ABwTBp26yAb7gg9xGgATyEZysPV4eXY+gJanNzQvp0Hrc4sUBim/iKLnLfXU2tK9Hg/
         mvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1X/gkJGxiGFMm6i5Q7bjYQxk1nuDBu74bPJr7HwBdp4=;
        b=mlSOM5fV/pVYxjy19HHgLhkk7sbXXBuWW6RBdNUM5vQ6GCqvrxjJd77FDk3StUAN4I
         MBVdC+bqv4wIBSaHOmWdWUet9M3mnIiZBy11+IwL0PduJ0u0G1/90FDAWuU5MppCiRBq
         EkipAdt9AgsaB0D3Kc2XbsSzYbKOoRHbVPTIuHofZ1rpmBu3+TpKzz81N/dnQV4Wr5GI
         iaLbo2XEIPukX8nOIUCjrvqEb/RrLEfo6jHRJ+TSjY2o/anN/9LY5PZWS1Y6KKf7vre8
         Elmbkc2ueAl6qnqWn424AvR0T5dnmgXkenjq4+flR7S3OlXKIJhHfZy0/gvWk7pEO1qF
         WuIA==
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
Subject: [PATCH 4.9 095/145] perf/x86: Shut up false-positive -Wmaybe-uninitialized warning
Date: Fri, 23 Feb 2018 19:26:41 +0100
Message-Id: <20180223170737.082982002@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218087998560586?=
X-GMAIL-MSGID: =?utf-8?q?1593218526396205907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 arch/x86/events/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -190,8 +190,8 @@ static void release_pmc_hardware(void) {
 
 static bool check_hw_exists(void)
 {
-	u64 val, val_fail, val_new= ~0;
-	int i, reg, reg_fail, ret = 0;
+	u64 val, val_fail = -1, val_new= ~0;
+	int i, reg, reg_fail = -1, ret = 0;
 	int bios_fail = 0;
 	int reg_safe = -1;
 
