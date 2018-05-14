Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoZVg5G+eUgBApDDzgCMm/qM4p6srKXoYNbXz11PUHIHjxN8c5C4wV32764s4B7hzJCOt/g
ARC-Seal: i=1; a=rsa-sha256; t=1526280600; cv=none;
        d=google.com; s=arc-20160816;
        b=cQyOCE6OoOdrWAJX7p7sQ7e0AgqQtguKcWeGtBRhaUMgRGXoOyKSZqFbFSvPW9DZEy
         a73oVvBa3j/9XMJR/hUOooYZhLEuxdZB4GmQ7FUWTSe4WRHGlQdICuX8Pi5AiXkSQofo
         CqrOb7vXFKwv1hEYqbfaFHF2vjrHZ3akdpCP/PE85RNqBqY1vDTU6DsavSysFdd2zWPC
         QG+WUGsKuI9p7GHf1fvlbursvTu3qsOvFnR/B4TMQx0F/dJimbmLtUjgE//VzDe1bflL
         4/1yjq4hqebPxga+LULxKHGMip3xvtW/2lXz5OykPDpiQaezL8+8Lnm7H9R7GV8yWV4/
         ec0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+GzaKqvaQcHtp/jzpplK++CqyqnxGkBGnG/eSuyI7sU=;
        b=jtaZR1tj9va1HW27bCLvYIQkBkeQl4fz1jkZzF7EuzPOl5MAKM/ihlBt9IxFGwORNC
         SJPqZVsIa1Tr7p9bUzj23Yh8V97ZwFkshEJYTfKSNU8AuTDJTYkiG8Xxu3ljemozagk1
         o1fnz537T3tPuZQ9KwRTBOyl8HuFhatAC1pwODde7ST4Z2H8I9ozWjACNDl2IGA/LCl0
         Zn9FCt6HR4Y5hmH6u1QaoNfcHTgH41pXzBnRbC4hySgu4DCdzGHRZj0k5F07uBvFpRL2
         z1kYv+Y5Vpxh/GMJJX1Ta03IuESIoNV1B29sx1++jpaksox4JvrmC+TNlKYqFOL8YoLB
         ilJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1HTsyFF+;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1HTsyFF+;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	muriloo@linux.ibm.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	David Carrillo-Cisneros <davidcc@google.com>,
	He Kuang <hekuang@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Paul Turner <pjt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <alexander.levin@microsoft.com>,
	Simon Que <sque@chromium.org>,
	Stephane Eranian <eranian@google.com>,
	Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 3.18 03/23] perf session: Fix undeclared oe
Date: Mon, 14 May 2018 08:48:32 +0200
Message-Id: <20180514064704.191796012@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421207032592915?=
X-GMAIL-MSGID: =?utf-8?q?1600421207032592915?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Using linux-3.18.y branch, perf build fails with the following:

    $ make -s -j16 -C tools/perf V=1 WERROR=0 NO_LIBUNWIND=1 HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_LIBNUMA=1 NO_STRLCPY=1 NO_BIONIC=1 prefix=/usr DESTDIR=/tmp/builddir/build all
    [...]
    util/session.c: In function ‘__perf_session__process_pipe_events’:
    util/session.c:1093:36: error: ‘oe’ undeclared (first use in this function)
      ordered_events__set_copy_on_queue(oe, true);
                                        ^
    util/session.c:1093:36: note: each undeclared identifier is reported only once for each function it appears in

This patch fixes it for linux-3.18.y branch.

Fixes: 95b33b99cdd6 ("perf inject: Copy events when reordering events in pipe mode")
Cc: <stable@vger.kernel.org> # 3.18.x
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: He Kuang <hekuang@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Hi, Greg.

Perf build on linux-3.18.y is broken since v3.18.101 (v3.18.100 worked just
fine). This fixes it.

Changes since v2:
 - rebased on v3.18.108

 tools/perf/util/session.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1073,6 +1073,7 @@ volatile int session_done;
 static int __perf_session__process_pipe_events(struct perf_session *session,
 					       struct perf_tool *tool)
 {
+	struct ordered_events *oe = &session->ordered_events;
 	int fd = perf_data_file__fd(session->file);
 	union perf_event *event;
 	uint32_t size, cur_size = 0;
