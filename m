Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+yAmnhjpJeGfCqSTXo+xGpLqGDXDVsxkuY0M8Q+oNRZOYOq6SxsAMtKUfk0ze35dkcPlAA
ARC-Seal: i=1; a=rsa-sha256; t=1523473297; cv=none;
        d=google.com; s=arc-20160816;
        b=RXaekxBtJ9R7vR0sIS50p+90v8BBjwc05iXKCe16CgH0TVcs5LhUGz6kLMfKf1KF3I
         Dajkc6h6VEB0jWedAgMno67hpP0WnjXoRvqLHthYsMIx0rtLxu2Fi5FzKnh3WglUNK6K
         s8G7kCPTfO01IQh+2YUmgd3ijGT838ccTKh8Vez87PzgH3NmHx+koPFG/lmBZDg+FcMC
         CUPVnEzDNTPZ7/DAkbDnaxHonbdFEGTx2+gR6vcKqoB9Lo9PPEq/+p2Dfo58EM2UlH0/
         U7/RmqAdNvTHwSJxQwDL77qCP9RftpF4dr38D2v55fTYrjnOngzZU1pBXsrJ/Ek1OMk5
         Pcog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nYBjX1fMXAk9Q/vcGMCXCR8Asu5DDYxVL6u/9yB1DSc=;
        b=kolIinzOBkTFldb4aXUr19h862YCyZu0y4nb4lb9nN57wpbJtyeCv+zfFQfmKWlBWZ
         qioNAeQbB/iQjxaYkSjK7ArzkN8kXQVrZgPIpj4oEUFfGpnjFFPsCGK98CjthaPXLH6k
         BGXqYj+oYFyTjSDZjJO+q1SCLFFygw69zIzhMr9ibWeu9800xCvrs9JPBjEy86F8KXTJ
         XLVgjhLBoLfPpJ2/gUk0V+RBaC3i0iMn8NVcZRuRNLWz/bgN1rGcK/jJyUthsj1tJNdZ
         V/2ojouFpDNatdcqiMQQuCEJJugFtE6pJW0qS9Y2f4mDk5H+DtTPkho1b1dOep9u9J2B
         LYWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Milian Wolff <milian.wolff@kdab.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 196/310] perf report: Ensure the perf DSO mapping matches what libdw sees
Date: Wed, 11 Apr 2018 20:35:35 +0200
Message-Id: <20180411183631.020338130@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476232291576091?=
X-GMAIL-MSGID: =?utf-8?q?1597477536094114154?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Milian Wolff <milian.wolff@kdab.com>


[ Upstream commit 2538b9e2450ae255337c04356e9e0f8cb9ec48d9 ]

In some situations the libdw unwinder stopped working properly.  I.e.
with libunwind we see:

~~~~~
heaptrack_gui  2228 135073.400112:     641314 cycles:
	            e8ed _dl_fixup (/usr/lib/ld-2.25.so)
	           15f06 _dl_runtime_resolve_sse_vex (/usr/lib/ld-2.25.so)
	           ed94c KDynamicJobTracker::KDynamicJobTracker (/home/milian/projects/compiled/kf5/lib64/libKF5KIOWidgets.so.5.35.0)
	           608f3 _GLOBAL__sub_I_kdynamicjobtracker.cpp (/home/milian/projects/compiled/kf5/lib64/libKF5KIOWidgets.so.5.35.0)
	            f199 call_init.part.0 (/usr/lib/ld-2.25.so)
	            f2a5 _dl_init (/usr/lib/ld-2.25.so)
	             db9 _dl_start_user (/usr/lib/ld-2.25.so)
~~~~~

But with libdw and without this patch this sample is not properly
unwound:

~~~~~
heaptrack_gui  2228 135073.400112:     641314 cycles:
	            e8ed _dl_fixup (/usr/lib/ld-2.25.so)
	           15f06 _dl_runtime_resolve_sse_vex (/usr/lib/ld-2.25.so)
	           ed94c KDynamicJobTracker::KDynamicJobTracker (/home/milian/projects/compiled/kf5/lib64/libKF5KIOWidgets.so.5.35.0)
~~~~~

Debug output showed me that libdw found a module for the last frame
address, but it thinks it belongs to /usr/lib/ld-2.25.so. This patch
double-checks what libdw sees and what perf knows. If the mappings
mismatch, we now report the elf known to perf. This fixes the situation
above, and the libdw unwinder produces the same stack as libunwind.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20170602143753.16907-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/unwind-libdw.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -38,6 +38,14 @@ static int __report_module(struct addr_l
 		return 0;
 
 	mod = dwfl_addrmodule(ui->dwfl, ip);
+	if (mod) {
+		Dwarf_Addr s;
+
+		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
+		if (s != al->map->start)
+			mod = 0;
+	}
+
 	if (!mod)
 		mod = dwfl_report_elf(ui->dwfl, dso->short_name,
 				      dso->long_name, -1, al->map->start,
