Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp4tP3C5R/G2gMKXxMSjdEuOmdm+TJQuqaV82zEt3CAqDR0tYx1Xe7x1dqtqQKPbymfmX3D
ARC-Seal: i=1; a=rsa-sha256; t=1526280677; cv=none;
        d=google.com; s=arc-20160816;
        b=EYSRWNffYCVKI712uP4hnnjP+pEzS1dZTrC1aEjqD9TiiZy+nq+FJIWJaoNJl3Rtbl
         rjPlfb2+UO1rH706/LwAHdtU9KAtD5w+6+gwW+EyWOch3Qo4y4u/CNjxegUIpcBS0v2h
         8W482Q2SUc8nfAA2QpqKWKfLI/2XLRC1fcffR5jRfMVPn1HbANR2Jy3ICyIQZiA6Qlnv
         p08dtVsNG5sXiDYt7jADuDBv4u9w6TyBQul6XcUwikvLuY1Md80dBwg8sQpvWKoUJP9X
         sIX0iZ49Cft8AcoNhL+HmUYBDoBf8aCX0IyjzHySgKGPqIwIhxk9VHetRAPoT9ngbwv6
         8Ezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=fvFyliFhE/TzU6w5lONCR0uAkNnnjwQAhO+q88E/oI8=;
        b=HkRrJVN5END1n31UZ0Kt5Z1uNTNY+mykADDw59mF+EYd9J+ooQAh2VlnoCl8PJR53Q
         2oH7IMRvMpAB/xRYpzLDMv3NIqw7ie6EXCVGERP3aDU8aDVU4JFK6TMX00FUiGJct3R8
         MP6tTosFZK7Nkfbhbq9yeA7me26uhIDZP6IZRHaYpg3nZmt7L/Y5aAV9Zebt3fdFM8Vu
         izoCGNkqi3wVRDykU9/DynS+yaOs5rDxdg1A40XGQGxUpAh+onIuihJAKGDa3r/sffKD
         XOSda3zq4x4kG1dC1pQbns/+GSNXGKOiBFN279nWY1RbEFv0u35dVSBm1Phwslt/maFO
         hYAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ReHTxOJS;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ReHTxOJS;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Jiri Olsa <jolsa@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	syzbot+9c0d616860575a73166a@syzkaller.appspotmail.com,
	syzbot+4e9ae7fa46233396f64d@syzkaller.appspotmail.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.4 16/56] tracepoint: Do not warn on ENOMEM
Date: Mon, 14 May 2018 08:48:21 +0200
Message-Id: <20180514064756.599222401@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421287557067240?=
X-GMAIL-MSGID: =?utf-8?q?1600421287557067240?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit d66a270be3310d7aa132fec0cea77d3d32a0ff75 upstream.

Tracepoint should only warn when a kernel API user does not respect the
required preconditions (e.g. same tracepoint enabled twice, or called
to remove a tracepoint that does not exist).

Silence warning in out-of-memory conditions, given that the error is
returned to the caller.

This ensures that out-of-memory error-injection testing does not trigger
warnings in tracepoint.c, which were seen by syzbot.

Link: https://lkml.kernel.org/r/001a114465e241a8720567419a72@google.com
Link: https://lkml.kernel.org/r/001a1140e0de15fc910567464190@google.com
Link: http://lkml.kernel.org/r/20180315124424.32319-1-mathieu.desnoyers@efficios.com

CC: Peter Zijlstra <peterz@infradead.org>
CC: Jiri Olsa <jolsa@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Namhyung Kim <namhyung@kernel.org>
CC: stable@vger.kernel.org
Fixes: de7b2973903c6 ("tracepoint: Use struct pointer instead of name hash for reg/unreg tracepoints")
Reported-by: syzbot+9c0d616860575a73166a@syzkaller.appspotmail.com
Reported-by: syzbot+4e9ae7fa46233396f64d@syzkaller.appspotmail.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/tracepoint.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -202,7 +202,7 @@ static int tracepoint_add_func(struct tr
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_add(&tp_funcs, func, prio);
 	if (IS_ERR(old)) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
 
@@ -235,7 +235,7 @@ static int tracepoint_remove_func(struct
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_remove(&tp_funcs, func);
 	if (IS_ERR(old)) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
 
