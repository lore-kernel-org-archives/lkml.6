Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225F4X4nFpJDHSWr7Clf5ikeptyRCgFQAGxJLOHc76kiUoFdIBwPQMumr3hlAZ3niXo6B5Bu
ARC-Seal: i=1; a=rsa-sha256; t=1519218517; cv=none;
        d=google.com; s=arc-20160816;
        b=rTdiHBHm0xhZW2FCzvHTRhg7sCjAE0buZ1Ul3g7aQOXBoz0cLNjNwKSx88L3ymoxx3
         TqXk9D27/ZeNeKUQXZCkAechi/tboecLPmRi3q0fxf/aNs0wa15nSOI4KdHxDoKTe3yS
         Bxh+qhjTv5KlDBoj0U6V8+58l9Nk134FSAbyVduS6asa4THEWpTXeWvgFOetEsxXASYZ
         miCQ75Jb3eWMqDhUTwOrmHoQkyWY2nPQXes7BnnUmC50GdqR0HX8FA7m14DuLzbfy7S9
         pkCqEU/bLs6KYNgSN5TQEW8C86/tiPDrMpa63qc78rsHDFsDqUQQkPGdOpkWysVVfBNr
         CB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NlbnTRWm6OdVVLlSKzsfK6h9c86VADZZMgBQQcXc5NM=;
        b=ssakc8l3vbxptgvJViQ9FYzOyvpjkFRSYT69Paz0x7DlWvEkZlkSXHVBpYPgZwuz6u
         Hljxovo0eezVyG2oHFlMAyZtie2gSWHaKHbR1cGn7yvLVOl3RKI6SqFAmK95Xc1ra1hD
         1T8nlr2GlhrRMjQqtUzyArFaHcOQ9EjvYe+ND66u3UGkA8ETHL8MGjlQkNi4Z6PKkVa1
         uWx1sK0NJlup0Vas6n2K3peE+yh8PrlaeX4JqYNWE9jvkB7P0qUT/IL/c1Nu6Vjln4/6
         wqtX5AfKONGbb/CVa9nNxaTbWgj7+Ltaq9o/s9bu2yMzWy2NITZrAHFaD1+k5JSW/akm
         2rOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Lutomirski <luto@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 068/163] selftests/x86: Fix vDSO selftest segfault for vsyscall=none
Date: Wed, 21 Feb 2018 13:48:17 +0100
Message-Id: <20180221124534.239668731@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015606048915198?=
X-GMAIL-MSGID: =?utf-8?q?1593016076552612339?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 198ee8e17502da2634f7366395db1d77630e0219 upstream.

The vDSO selftest tries to execute a vsyscall unconditionally, even if it
is not present on the test system (e.g. if booted with vsyscall=none or
with CONFIG_LEGACY_VSYSCALL_NONE=y set. Fix this by copying (and tweaking)
the vsyscall check from test_vsyscall.c

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Link: http://lkml.kernel.org/r/20180211111013.16888-3-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/test_vdso.c |   50 +++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

--- a/tools/testing/selftests/x86/test_vdso.c
+++ b/tools/testing/selftests/x86/test_vdso.c
@@ -28,18 +28,52 @@
 
 int nerrs = 0;
 
+typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
+
+getcpu_t vgetcpu;
+getcpu_t vdso_getcpu;
+
+static void *vsyscall_getcpu(void)
+{
 #ifdef __x86_64__
-# define VSYS(x) (x)
+	FILE *maps;
+	char line[128];
+	bool found = false;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps) /* might still be present, but ignore it here, as we test vDSO not vsyscall */
+		return NULL;
+
+	while (fgets(line, sizeof(line), maps)) {
+		char r, x;
+		void *start, *end;
+		char name[128];
+		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
+			   &start, &end, &r, &x, name) != 5)
+			continue;
+
+		if (strcmp(name, "[vsyscall]"))
+			continue;
+
+		/* assume entries are OK, as we test vDSO here not vsyscall */
+		found = true;
+		break;
+	}
+
+	fclose(maps);
+
+	if (!found) {
+		printf("Warning: failed to find vsyscall getcpu\n");
+		return NULL;
+	}
+	return (void *) (0xffffffffff600800);
 #else
-# define VSYS(x) 0
+	return NULL;
 #endif
+}
 
-typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
-
-const getcpu_t vgetcpu = (getcpu_t)VSYS(0xffffffffff600800);
-getcpu_t vdso_getcpu;
 
-void fill_function_pointers()
+static void fill_function_pointers()
 {
 	void *vdso = dlopen("linux-vdso.so.1",
 			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
@@ -54,6 +88,8 @@ void fill_function_pointers()
 	vdso_getcpu = (getcpu_t)dlsym(vdso, "__vdso_getcpu");
 	if (!vdso_getcpu)
 		printf("Warning: failed to find getcpu in vDSO\n");
+
+	vgetcpu = (getcpu_t) vsyscall_getcpu();
 }
 
 static long sys_getcpu(unsigned * cpu, unsigned * node,
