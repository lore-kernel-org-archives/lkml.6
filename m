Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226X32M3Absgum58W7wgVndebRfqyeYcamk/4uYb/xckDijFfgz9tJQGIUV4nzXeSIM+9fcL
ARC-Seal: i=1; a=rsa-sha256; t=1519410901; cv=none;
        d=google.com; s=arc-20160816;
        b=gJz9RAbhE9EPdNPwxCsOQBxM0ye5C3qS5dK1CK5wi0JTjQ/qIcfEL/eAnDB2dmDPtm
         soh9kTbMta1XIiQ97Zdwo/hZg1j4zJCCLxCz29N12jaN6laR3BmiZwLXkcgXzCVuqwcT
         dly19/QLlQjDS+AnK4vRQ8NVlOE4xFHec2auJrMCCBdjffgNeJ9csnvcVzOXejwAEY3R
         bw7kYfbO67dD9mpoanueOAIbD2mAfXtF2BzBZatCgqGta/cL7YOXpZ9sNsmzilzyJjLy
         ebaVuT7+djqureznqm+mw9riDK1iTbb0U7SacnBoTzHgfJuaNttsUZBWzOPLUgkljV4j
         bgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zDmFS06FrhE4u9pa9w2Msm4/xe/jiGowtP2Y6pXck3g=;
        b=S1rQ4f2gFlP9nlHSKcwnVyIsgrAmaLGrdApMCiVD108VDDkUzan97U3eqHfQS5RtBA
         VGmKJvLXYZz88PXwB8BEnRSPJ3W188bIFAYRgmBSS2nwHw0TzPNH8sn4Zh3ogbOfXOqM
         EH0fWTez6xAEbSQ9OLFRdQc4CmAOBfrkx7cYVW+/5eJuRxIhNMcsr3ZxYqxC5t/7XoyA
         L52Cdlpndw//eR1ZZRKoUed9fvCE8hC6Hg3AZ7rLHm6gW53AZjsQPcCrUeCgs7JLdMOr
         dMqPiUfD5s1gzGxYCr565AtSBEyHx4E18tEA96Y2uSdlI5tMlOxiPs/g5PKldjk6YX02
         7OcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andi Kleen <andi@firstfloor.org>,
	David Ahern <dsahern@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Wang Nan <wangnan0@huawei.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 035/193] perf top: Fix window dimensions change handling
Date: Fri, 23 Feb 2018 19:24:28 +0100
Message-Id: <20180223170331.576368507@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217584770930249?=
X-GMAIL-MSGID: =?utf-8?q?1593217805429687382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>


[ Upstream commit 89d0aeab4252adc2a7ea693637dd21c588bfa2d1 ]

The stdio perf top crashes when we change the terminal
window size. The reason is that we assumed we get the
perf_top pointer as a signal handler argument which is
not the case.

Changing the SIGWINCH handler logic to change global
resize variable, which is checked in the main thread
loop.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-ysuzwz77oev1ftgvdscn9bpu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-top.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -70,6 +70,7 @@
 #include <linux/types.h>
 
 static volatile int done;
+static volatile int resize;
 
 #define HEADER_LINE_NR  5
 
@@ -79,10 +80,13 @@ static void perf_top__update_print_entri
 }
 
 static void perf_top__sig_winch(int sig __maybe_unused,
-				siginfo_t *info __maybe_unused, void *arg)
+				siginfo_t *info __maybe_unused, void *arg __maybe_unused)
 {
-	struct perf_top *top = arg;
+	resize = 1;
+}
 
+static void perf_top__resize(struct perf_top *top)
+{
 	get_term_dimensions(&top->winsize);
 	perf_top__update_print_entries(top);
 }
@@ -466,7 +470,7 @@ static bool perf_top__handle_keypress(st
 					.sa_sigaction = perf_top__sig_winch,
 					.sa_flags     = SA_SIGINFO,
 				};
-				perf_top__sig_winch(SIGWINCH, NULL, top);
+				perf_top__resize(top);
 				sigaction(SIGWINCH, &act, NULL);
 			} else {
 				signal(SIGWINCH, SIG_DFL);
@@ -1023,6 +1027,11 @@ static int __cmd_top(struct perf_top *to
 
 		if (hits == top->samples)
 			ret = perf_evlist__poll(top->evlist, 100);
+
+		if (resize) {
+			perf_top__resize(top);
+			resize = 0;
+		}
 	}
 
 	ret = 0;
