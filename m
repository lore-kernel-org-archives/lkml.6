Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+aEDTneOg6++1cJDI2y+uCV4m3xJVyQwJnAi9F+mC3jNDys6pW2ailbWOJbFdIxXCTFEJA
ARC-Seal: i=1; a=rsa-sha256; t=1522168666; cv=none;
        d=google.com; s=arc-20160816;
        b=jWZmkzyump/Jeoqct1ZI2Xt9+ZZAza7Jopi8P7FjLqDSO+nREu44t5lfZND6sjnYvA
         uCDE9nbajUIwC1r66bXDrZCPZL6LZO1aTZ4+dJdeEvIX5Sq6uK3E1Uz3l4YDnL+Cc/pQ
         074YAqMp0UEUANVUhfmBTho0cb7/S7txN67NjK7gGE+SGUUGhhuDHVZ/s7PPSsAb015a
         kZLmBUUJo/8IVbtKfhKV/dbz5g5gFoMqrZDtGqhdOgpf7KQzotZtMh4Ilo3UwsT5CQGW
         ORbJvJmN2U3eDgfHahqPHFZ2n9vr7i6FcLh5v2CpWADQ3YhUstoVEYF/enzaFQQG4Sks
         DWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9tmUA6hXdGJlHls7+cvdgpgp3M93ihV+Xbdb4+y3mXk=;
        b=JHRod/NRkdi74kNB6k1L7LPaIjTAYr/XsqWaRjMYbprSTixeOBbbFDR66IgMNZpigo
         dsYuLWxk+XNIdyOkJbR20y8Vmw6rf1o9ft2u8WmRmArZoUT4DWCl9lnD5fDo6Gc0a+jZ
         yL/0WQGVw6hM2KPWX7sSTbRailH3IY494lfEG5IS9D/yEdAYyAS0GTzl72GCpOcQYQ5m
         N7rUKPiYDvzMpVxzDac7BJhgKouTVfzDHfTbl5j2mATNkxvGJAZ15vQ2Wv0mk8gL5u0O
         x2peelnz/4r9jVNRkKNJ23z5uUepCSGPKpGa6DZtXifIid15fsf8ipcek9ztQYlPRxKk
         FknA==
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
Subject: [PATCH 4.14 088/101] perf stat: Fix CVS output format for non-supported counters
Date: Tue, 27 Mar 2018 18:28:00 +0200
Message-Id: <20180327162755.455552312@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109219348833077?=
X-GMAIL-MSGID: =?utf-8?q?1596109531055126555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -922,7 +922,7 @@ static void print_metric_csv(void *ctx,
 	char buf[64], *vals, *ends;
 
 	if (unit == NULL || fmt == NULL) {
-		fprintf(out, "%s%s%s%s", csv_sep, csv_sep, csv_sep, csv_sep);
+		fprintf(out, "%s%s", csv_sep, csv_sep);
 		return;
 	}
 	snprintf(buf, sizeof(buf), fmt, val);
