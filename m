Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/7wLEDXM6xX7UvkQ9f7mqjJyYqF22+i7pV9ECY6HSm8jTCv7CHJyD6PLOx+j1GtUyp/dq8
ARC-Seal: i=1; a=rsa-sha256; t=1523473338; cv=none;
        d=google.com; s=arc-20160816;
        b=kr12Kcz1JhcsIhK+VJYCyx0/iT7tblt/RUH8ZIS0gjx2OyyGVGWuXIZVNfqikzFRf+
         HJuen+fYwDeEMYWMRqftkIMXrhs8vMHdiQLC/l7ZyRm1y9UBr6m0amJYimGzg7ReE4Lj
         LJ7KyzL4aLJMWiYvVqv1KKq6LVDnGDtf/NYS0tA9TocMlc2SK+SOnIu8BzCZbkZ5YPs1
         jIalgkq6KERZLAI9MhMZJiI2SkEQUdq5bXr9FFfeduDl+Lebd62Glv0SkokATgGXjfXO
         UYUIJ64U4mop8LwxNAxy0onXhcGgpx2kaoF4pPM94GrV2z7pCHfNM5YRsaWoJBumLiy9
         UaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+z5lddjS85y0Vtsa6BKevZPHuKh3aATy93FYLi3dttE=;
        b=xEjgOIweBSWYpCJExIQgQeI+Qxwe/kYcYeNy9MmcxEb8IbkDutzfOW0nKAbACLcJic
         owY1/K9A4vCW/42jfXnnO+blS5cNOAF9c1R6KU81F0IDmiG86edMkKSMATt/8EVPg7WY
         BpqtrNpvdvj+5LDWIdcdwj9ta3bwJVPaeD1QgH8XfkekuhMlbXUvJBnNIO32rR8q4D60
         nijMaMcmCAboZFKP4HCb4aZkZcu+QOFX6EefVrLvxyHoF/iNylXt28Fs0MXUkcvGu8SE
         1ljQGqj/trEomBbfaH5TsVtZE1xcfe4BwMxNKdSs97kswh1qrFWm+LkhdeABKl+8lTvc
         pnRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	David Ahern <dsahern@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 177/310] perf trace: Add mmap alias for s390
Date: Wed, 11 Apr 2018 20:35:16 +0200
Message-Id: <20180411183630.235378198@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476200320651286?=
X-GMAIL-MSGID: =?utf-8?q?1597477578768745704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>


[ Upstream commit 54265664c15a68905d8d67d19205e9a767636434 ]

The s390 architecture maps sys_mmap (nr 90) into sys_old_mmap.  For this
reason perf trace can't find the proper syscall event to get args format
from and displays it wrongly as 'continued'.

To fix that fill the "alias" field with "old_mmap" for trace's mmap record
to get the correct translation.

Before:
     0.042 ( 0.011 ms): vest/43052 fstat(statbuf: 0x3ffff89fd90                ) = 0
     0.042 ( 0.028 ms): vest/43052  ... [continued]: mmap()) = 0x3fffd6e2000
     0.072 ( 0.025 ms): vest/43052 read(buf: 0x3fffd6e2000, count: 4096        ) = 6

After:
     0.045 ( 0.011 ms): fstat(statbuf: 0x3ffff8a0930                           ) = 0
     0.057 ( 0.018 ms): mmap(arg: 0x3ffff8a0858                                ) = 0x3fffd14a000
     0.076 ( 0.025 ms): read(buf: 0x3fffd14a000, count: 4096                   ) = 6

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170531113557.19175-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-trace.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -679,6 +679,10 @@ static struct syscall_fmt {
 	{ .name	    = "mlockall",   .errmsg = true,
 	  .arg_scnprintf = { [0] = SCA_HEX, /* addr */ }, },
 	{ .name	    = "mmap",	    .hexret = true,
+/* The standard mmap maps to old_mmap on s390x */
+#if defined(__s390x__)
+	.alias = "old_mmap",
+#endif
 	  .arg_scnprintf = { [0] = SCA_HEX,	  /* addr */
 			     [2] = SCA_MMAP_PROT, /* prot */
 			     [3] = SCA_MMAP_FLAGS, /* flags */ }, },
