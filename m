Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224EWymSCEoSjoQsBfIZo7TlVevecYHIanVgoLw3JHZt+uTBeW3MBkw8+WcO80uLlLEOUakg
ARC-Seal: i=1; a=rsa-sha256; t=1519218222; cv=none;
        d=google.com; s=arc-20160816;
        b=R2TK20DcDNpQ8AZueGiIz27KXnDlr6FPlFGENvvkMHxXYXc4cYFCjZItmbv4pXeaWF
         dpuNcw0Tyby/g0PWmHXkecy1kaPrulur3+C4plZktTVIoW4Tq6XFbMTtIHI25SmRASwJ
         OuyTbA21DJx3b1YZFeC3yc9Kn8Dx5ymKoJJCWUfpRXlNl0NcD0Vy07uvv/yo2xdHviGU
         AF0AgC/7siQbYCY0nNMGHOsBqPQw9qhffZM4ZDDPwbQWx93TB+K9ofn5lsJEVyLX9qza
         ldWpj4PcsaAXaDzJGg6RdEYIBkHrLY48JbyOpqAUGSCPQU9+xpyfjVgujzZzvuQhqzrI
         UVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MDChoz2qIOecVNdcAcBU+VbItArJCFnVpy9Toj0fM1I=;
        b=PhVf9WEg30Q1+3j+Hh/3iqN7gRlp+FujnzeBnfRA1WZzMflHj7JNcZrpqSocW5xtUI
         WAQzsHuBm/s7pLPCDkVQBolCAQlb6Hp83YP12CBGQJcmiaSon5W4lQp5xu/R/x0GnaHA
         3hvf1uc33/yyTh2e3x137Rir/AIVTBO9GBpJy6E/WZ7G3mpo7qmLYSFmR8EHtzSemyi0
         Wx/mN980RS4pGNmrXgTivWWZtmN9Vvsk0Nx3AoYXNNrZgt3dMfBu+6MMo7s969BELwFy
         GOWpEUsv/4CWjjqYcBWCZWBVq56KmnND8lAexmIVSavKGHvkhDVLebkzlIy+cn6BlR5r
         5tuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 130/167] blk-wbt: account flush requests correctly
Date: Wed, 21 Feb 2018 13:49:01 +0100
Message-Id: <20180221124531.735046708@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015767205981106?=
X-GMAIL-MSGID: =?utf-8?q?1593015767205981106?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 5235553d821433e1f4fa720fd025d2c4b7ee9994 upstream.

Mikulas reported a workload that saw bad performance, and figured
out what it was due to various other types of requests being
accounted as reads. Flush requests, for instance. Due to the
high latency of those, we heavily throttle the writes to keep
the latencies in balance. But they really should be accounted
as writes.

Fix this by checking the exact type of the request. If it's a
read, account as a read, if it's a write or a flush, account
as a write. Any other request we disregard. Previously everything
would have been mistakenly accounted as reads.

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-wbt.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -698,7 +698,15 @@ u64 wbt_default_latency_nsec(struct requ
 
 static int wbt_data_dir(const struct request *rq)
 {
-	return rq_data_dir(rq);
+	const int op = req_op(rq);
+
+	if (op == REQ_OP_READ)
+		return READ;
+	else if (op == REQ_OP_WRITE || op == REQ_OP_FLUSH)
+		return WRITE;
+
+	/* don't account */
+	return -1;
 }
 
 int wbt_init(struct request_queue *q)
