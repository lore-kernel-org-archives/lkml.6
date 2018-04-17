Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ZI4wI6DpZnsNs4MGw4yh7ZBcr05Z6KLrPXqGg9s63L1wHaF5n1nukwFq7YWwLjaoc+I0k
ARC-Seal: i=1; a=rsa-sha256; t=1523980931; cv=none;
        d=google.com; s=arc-20160816;
        b=HSwF22QQNbsRCTWhlLiR4K/zidj1X/py08fil23XTacGaw2xQmE86t0uMaDQz6fjcW
         23a6JQ+yrI5XuAu2DoV7b1ndSBsqQCylvzO+sOhawBQqmzSpTJjmbTezLPArEfXgJqp+
         yhMOAR6QsEd3yxnHlBFhjEUHmpMAzZDXJfGY+Zy87iHSR4VL9eblFYAlhNYKmVzC+0Ym
         H3TzyD/TPTB8n0FDfnjhHbK4sAD/KdVzkbYjWAo7S72uxAaivYc7LNlziEHtU3h1Q9rG
         XdtJs7f8DgTa9on99RPkNW1s2XaCfUnFJ3ANSSelNh26OeYfN01vuAstEKFOmY4Cc0cO
         lUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZZVYdOftna/DTDDAugUhHeAIj974z0dVybhcoSqy5Is=;
        b=Ds2XUHdTlVlOdCpIVFQFj2A1zuRFg7nvbfO80Y4MDYUigOzIeutY1Y3o79VUrEao1H
         zlhUT3gIMhPKujUadIiOmyd155b4lIkjkme9NnXvbZ7ZuSABeg3Y3SFZhalG/Ivma7uU
         DmILX1cBKeoYr/pmSjfU16h4S0eLd9X/Okx+Wjt06W2wqDNaXeGbA1ljKGjlLKZxVsGu
         rsLo74lOYKBOLxuO6PWYUnAaSjEDc3XUT/ZOQ6edfvUwJJPKkH+GLIN7d7DgMXd+xsj8
         RQSV5pKYIQZ9soEGBtWkagZVgz17BwdpCZcWfmmlWShPbl/DwHsTClGlZUQzIwNUDExZ
         TdCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.16 54/68] apparmor: fix logging of the existence test for signals
Date: Tue, 17 Apr 2018 17:58:07 +0200
Message-Id: <20180417155751.545865361@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009829328873460?=
X-GMAIL-MSGID: =?utf-8?q?1598009829328873460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

commit 98cf5bbff413eadf1b9cb195a7b80cc61c72a50e upstream.

The existence test is not being properly logged as the signal mapping
maps it to the last entry in the named signal table. This is done
to help catch bugs by making the 0 mapped signal value invalid so
that we can catch the signal value not being filled in.

When fixing the off-by-one comparision logic the reporting of the
existence test was broken, because the logic behind the mapped named
table was hidden. Fix this by adding a define for the name lookup
and using it.

Cc: Stable <stable@vger.kernel.org>
Fixes: f7dc4c9a855a1 ("apparmor: fix off-by-one comparison on MAXMAPPED_SIG")
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/apparmor/include/sig_names.h |    4 +++-
 security/apparmor/ipc.c               |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/security/apparmor/include/sig_names.h
+++ b/security/apparmor/include/sig_names.h
@@ -2,6 +2,8 @@
 
 #define SIGUNKNOWN 0
 #define MAXMAPPED_SIG 35
+#define MAXMAPPED_SIGNAME (MAXMAPPED_SIG + 1)
+
 /* provide a mapping of arch signal to internal signal # for mediation
  * those that are always an alias SIGCLD for SIGCLHD and SIGPOLL for SIGIO
  * map to the same entry those that may/or may not get a separate entry
@@ -56,7 +58,7 @@ static const int sig_map[MAXMAPPED_SIG]
 };
 
 /* this table is ordered post sig_map[sig] mapping */
-static const char *const sig_names[MAXMAPPED_SIG + 1] = {
+static const char *const sig_names[MAXMAPPED_SIGNAME] = {
 	"unknown",
 	"hup",
 	"int",
--- a/security/apparmor/ipc.c
+++ b/security/apparmor/ipc.c
@@ -174,7 +174,7 @@ static void audit_signal_cb(struct audit
 			audit_signal_mask(ab, aad(sa)->denied);
 		}
 	}
-	if (aad(sa)->signal < MAXMAPPED_SIG)
+	if (aad(sa)->signal < MAXMAPPED_SIGNAME)
 		audit_log_format(ab, " signal=%s", sig_names[aad(sa)->signal]);
 	else
 		audit_log_format(ab, " signal=rtmin+%d",
