Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+wQnYdy7imZHpE00V95NIwRlDX+esRwIkFSqVumSiEiFCRbwvk2qbWRgXbagTEPIb4TVYz
ARC-Seal: i=1; a=rsa-sha256; t=1522168965; cv=none;
        d=google.com; s=arc-20160816;
        b=rSTCNUa1vLUwUNHaWBzlBjZqEIOJlwkQl8EqK+/MTF4UNvvHtWP/p3BL8NxjwE6oVw
         2QtjMNPSb6tP7XRNQH4dthqNFL3IdnnL1AplfW6nY2FgIwhptFpD1fVK5Qij7zxJV2D1
         bthhfmzTKXGG23yLzl9mgn5VF/y2P1+vpw5NxOi2uopOfTKmPAX2dlKlVARZXaa+iG6S
         tMFfMfe19lyTLWz1D5xD9GmkbbvueKCLRhiF/tFYEIm16dUYCB4HBv8CODya5XtLaYQW
         RepmUE6dGk2g6+6wZ1YfIAgB2yFDzGne5i6aX11PBvii7zmT1FklXJ96wQfmytdNT1Y3
         TZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6Vt/W9cYd5u3b7zdOaAxXggtwJHE1TaTMAiOmt1Wbig=;
        b=axPjVS6cW1uf18f2/9VqMU44qgdRO6Jok7BD3mlp4oxIWTTLR3HhqgApf3Ok3NxATJ
         lJUOfqV9WTRvC56Y5/pumIf1YEWKj3wgdjkbwmFZ6Y+lHcMcA26ZQrYMj4fCtS0a1EI6
         ttR1Ed05RAkClTFXYk4ld1FB/jhcJ7oRdVqpHmBs+Ofj0KkaeQnv6O5ipZrqbIutbAmR
         X4bB6CZcex1sc7Odx8vz4jC+m4BJQkUo9kYNyNjrfEUg80RCIoNBzrEHBaUc5pULZAAL
         j2fnHmFV9RdJt9f0smucqoMoFwskT2vnaE+tvSm74pONDaAG6v/E0AOIwxSo+X6FLv/R
         rRNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Pronin <ipronin@twitter.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.15 094/105] perf stat: Fix CVS output format for non-supported counters
Date: Tue, 27 Mar 2018 18:28:14 +0200
Message-Id: <20180327162803.830153158@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109219348833077?=
X-GMAIL-MSGID: =?utf-8?q?1596109845249326261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Pronin <ipronin@twitter.com>

commit 40c21898ba5372c14ef71717040529794a91ccc2 upstream.

When printing stats in CSV mode, 'perf stat' appends extra separators
when a counter is not supported:

<not supported>,,L1-dcache-store-misses,mesos/bd442f34-2b4a-47df-b966-9b281f9f56fc,0,100.00,,,,

Which causes a failure when parsing fields. The numbers of separators
should be the same for each line, no matter if the counter is or not
supported.

Signed-off-by: Ilya Pronin <ipronin@twitter.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/r/20180306064353.31930-1-xiyou.wangcong@gmail.com
Fixes: 92a61f6412d3 ("perf stat: Implement CSV metrics output")
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/builtin-stat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -967,7 +967,7 @@ static void print_metric_csv(void *ctx,
 	char buf[64], *vals, *ends;
 
 	if (unit == NULL || fmt == NULL) {
-		fprintf(out, "%s%s%s%s", csv_sep, csv_sep, csv_sep, csv_sep);
+		fprintf(out, "%s%s", csv_sep, csv_sep);
 		return;
 	}
 	snprintf(buf, sizeof(buf), fmt, val);
