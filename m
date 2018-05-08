Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoh7wiegs3KPfA+DtqiBL+d7UhIEw5anK9U29Fzd5+O/s501EDIEKekTDfJvaW/TK3rzlj5
ARC-Seal: i=1; a=rsa-sha256; t=1525767318; cv=none;
        d=google.com; s=arc-20160816;
        b=wxhbqbyhQSC9lC6ZxstSw3fjNgwrvmdSHzcMJHTreNMrF8Vb8xwluTv4XbpR+VF/BH
         r7QlJWT/vudPK7GFg9jcWxSpR49r1Ld4KoWpcXLuLOJ+YSDnStgaW+kxwhhKTH/y97yW
         gUXZXau9p9OqP3hp/DBX4TF8wYISVuYun3x456LIOwFWAzkjGK3sZO4ayTuuUrFD8BvD
         daQKXgIOQNfLivoRyyDHNgV1bfRSTIJZr38vFUDt1FbIJRZWB14YDT1e1eEYE0RpW7et
         7p8a2iDkwUiALCU7K00PnI+tLNx9fJDDrUy9LKOfQMzhD9dSVLDvYitNgnDqAp2W3qCd
         31qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mYANIHUYq4fv7daDsbU+EEj1QvFKy24Cu/2Eo4pOqIs=;
        b=uaMGz6NYa8lPDL81zj3ils0bL+48pzbkYMc7RZLQCoHI8n3c9N61xEGmphrXByk+IJ
         H3YT/2z7SicJH0iOmD3Y8dnUG7JzzJ3M5j8HNfu6PvOnb6J2CdVY4r22c+TKB0fjucpU
         5BS8mzidZjWtyszn+fh180chlDHjAFPw0Sin6+Z/9ctU/MIzjgFbyhOJhFW752N18sIs
         39sifq0G4xTtGXC5izqW3ZfzCySc+2AJAbfobAUfSjyBAl0LmmXVxpUNVbySiRFPqr1T
         QdIBXUbmseuerHd6g7Q5+CchSqFQdbl/IUQDAqqM5ipp4asx12eE9JMRYrbKGPv5MUrE
         eD8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=A3it6iKY;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=A3it6iKY;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
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
Subject: [PATCH 4.14 13/43] tracepoint: Do not warn on ENOMEM
Date: Tue,  8 May 2018 10:10:32 +0200
Message-Id: <20180508074006.151315030@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882764347607574?=
X-GMAIL-MSGID: =?utf-8?q?1599882992216371766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -207,7 +207,7 @@ static int tracepoint_add_func(struct tr
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_add(&tp_funcs, func, prio);
 	if (IS_ERR(old)) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
 
@@ -240,7 +240,7 @@ static int tracepoint_remove_func(struct
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_remove(&tp_funcs, func);
 	if (IS_ERR(old)) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
 
