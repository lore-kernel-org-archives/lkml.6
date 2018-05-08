Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoADwtoiucHnIefwK/RmwJpjs8Y0wm4FrUnumiwpH3wuKBn3l/2Pwb9XZmbypMDi2dJ9ExU
ARC-Seal: i=1; a=rsa-sha256; t=1525767449; cv=none;
        d=google.com; s=arc-20160816;
        b=ogrdl6VXbHWlacooAyDvoIs9+oupTUjIAdYHfIJtUOCrqjL2L7z07S+ccRJsvo9HPo
         j78h9ove1BcQwdqz5otOix9KA7mPPBtFKBpIQ7VpYffn//H4e6w4ZYa3VpCndIRDY9BL
         QCf/jd0iRFEUaigtJRc2mILYd+sMbzOE61Y4qUXcN22AkspEsnJapsd7PC6TkncD34Wa
         QBIR+uJyscH3D9/hO8yx/RiRJhPMeZNwkxJHsCz7xFXC+ZXtv9pPyv0CRhBNEWH9GvZ+
         v61WIPIkZlinhg/QgpLHF/Vbc/ncA8ekjXE7ZkIijdJ5Q3Lio8D4YV1kCEbBm4k7PNGt
         zGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=oRpkKO++zJiNNq0AN4U60/KAzT/kNbejHcoXOnyqPlQ=;
        b=fzCBaM3HpeecmZGo9b/c7ITfNj8gUoNytg/d8IYRFgR4q76mKp70vBlxQkE2jWUH51
         Mr3GfeTLIZikLZPhZKBDALm6EMphTxDjk0wTCfheDKenUuLinxRaYw3tEz8shCLu2AYc
         Gwu07sH+lpWm8WG2LNz521TzPQXHXrQhDI5jr3lEN02wBbsHIItU/+JVecp77D5ReMuC
         ihfBABthPSf/gKCzgzzBnB4f2ehkSkszOnrtSULdNIDQimZhszWllt7fF6LOvVuwdOzA
         UP6lyCL4czgOTJK6u56wIcOgYSrxWmAKw2HnvGhTsfGczbmAR2y7h6PEDkD40CgdC8UJ
         v+wA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QBc50iJJ;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QBc50iJJ;
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
Subject: [PATCH 4.9 12/32] tracepoint: Do not warn on ENOMEM
Date: Tue,  8 May 2018 10:10:52 +0200
Message-Id: <20180508074010.792210274@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882764347607574?=
X-GMAIL-MSGID: =?utf-8?q?1599883129157999215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
