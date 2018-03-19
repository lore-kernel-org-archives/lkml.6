Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt3sXdt39pdGsHvIMd7gIj3w3bcva758MiAAuswKRX+0x9HeYd4+tjWXtJmfB5PnR5ZZAmV
ARC-Seal: i=1; a=rsa-sha256; t=1521483753; cv=none;
        d=google.com; s=arc-20160816;
        b=nlLVBhknuYn8nwJUwiqj93s7wWSK613Fw/8/h3Dl/QoeexgpjaWmqZQHGZieTeoCCt
         5t8cRuo205V146lBmNAv1Fa6kOuJ+ln/1XtfEtn7Cy0eyb2GCGR43+qFFH5hWJ00GWeN
         22oyIXDGfKLy9EDXGLguxaxxZ10e5pzOtOlDy8x9lcLqRNPDj5M6RbFocihkPMQs4JPh
         OSqbDIEaizCyZ0XXGZrNoEKFnrHiuisGbR1v8kWbynwrRHZ5jHuAdhO3jsbJI7IAa8bd
         mdO5JidN/NN22+wVxeLYFGnYH6PB7FAISx53PGevx6vyduqtGl/PluXkwmNFB54Bhv6f
         PzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s6SjzCic3RjrWlRQ1eD9sWaxqbiLJ0aZnln4xRFaJas=;
        b=ZryPeS4JCKDuoyR72AO5pZrwlwWalY9L8JaqJWbdSTSy8g83gDFdhVjXXc6y4l8x0k
         IZU7ldwxnF89WGwSsCsTZtqnQYWMpJlPv03wP0+GWCkYGCLBfnsjjNvcHvOf06iu+U+f
         Ct59E4t6qwD2ZZUoJ+YKN7irbpZu2PNcBF1JuZtj7NOqu0GfFSdqHl7EStP0aCvSi3nh
         ysONi8ZM8PYeIl+gm2y8ZghRBgMO1rtj3XYkyB+HX0hXMr2D0dy5sp038Ypx5gPfhZdj
         em2/rmSPjmv/pezbSMcO/hjkv7XyxcVpourCMrblFZWp2CcTeF3E4bVMKsqVcqbRrPY3
         aeDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tommi Rantala <tommi.t.rantala@nokia.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 069/241] perf buildid: Do not assume that readlink() returns a null terminated string
Date: Mon, 19 Mar 2018 19:05:34 +0100
Message-Id: <20180319180754.063574728@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391348080703478?=
X-GMAIL-MSGID: =?utf-8?q?1595391348080703478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tommi Rantala <tommi.t.rantala@nokia.com>


[ Upstream commit 5a2342111c68e623e27ee7ea3d0492d8dad6bda0 ]

Valgrind was complaining:

  $ valgrind ./perf list >/dev/null
  ==11643== Memcheck, a memory error detector
  ==11643== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
  ==11643== Using Valgrind-3.12.0 and LibVEX; rerun with -h for copyright info
  ==11643== Command: ./perf list
  ==11643==
  ==11643== Conditional jump or move depends on uninitialised value(s)
  ==11643==    at 0x4C30620: rindex (vg_replace_strmem.c:199)
  ==11643==    by 0x49DAA9: build_id_cache__origname (build-id.c:198)
  ==11643==    by 0x49E1C7: build_id_cache__valid_id (build-id.c:222)
  ==11643==    by 0x49E1C7: build_id_cache__list_all (build-id.c:507)
  ==11643==    by 0x4B9C8F: print_sdt_events (parse-events.c:2067)
  ==11643==    by 0x4BB0B3: print_events (parse-events.c:2313)
  ==11643==    by 0x439501: cmd_list (builtin-list.c:53)
  ==11643==    by 0x497150: run_builtin (perf.c:359)
  ==11643==    by 0x428CE0: handle_internal_command (perf.c:421)
  ==11643==    by 0x428CE0: run_argv (perf.c:467)
  ==11643==    by 0x428CE0: main (perf.c:614)
  [...]

Additionally, a zero length result from readlink() is not very interesting.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170322130624.21881-3-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/build-id.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -182,13 +182,17 @@ char *build_id_cache__origname(const cha
 	char buf[PATH_MAX];
 	char *ret = NULL, *p;
 	size_t offs = 5;	/* == strlen("../..") */
+	ssize_t len;
 
 	linkname = build_id_cache__linkname(sbuild_id, NULL, 0);
 	if (!linkname)
 		return NULL;
 
-	if (readlink(linkname, buf, PATH_MAX) < 0)
+	len = readlink(linkname, buf, sizeof(buf) - 1);
+	if (len <= 0)
 		goto out;
+	buf[len] = '\0';
+
 	/* The link should be "../..<origpath>/<sbuild_id>" */
 	p = strrchr(buf, '/');	/* Cut off the "/<sbuild_id>" */
 	if (p && (p > buf + offs)) {
