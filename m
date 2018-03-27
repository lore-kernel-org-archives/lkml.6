Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/ADD+Me29ZqCKcmnIeew0/CXKo5gVgaLjAXNfTQBHxtOYflkbsRkZALHf8OautgDTcQ4iG
ARC-Seal: i=1; a=rsa-sha256; t=1522168368; cv=none;
        d=google.com; s=arc-20160816;
        b=Wk3xVdYUdBOCDu3JZstaLAwsbl7zsCmtSjfxs2RxJDjvvTo+fPCQuAUXHBkKGsk+cV
         Up4FMQV00BlCjFqNZgrCVMZ/vegeidE/zKsWxXJ+coazyL9ZKUPRcjMxfdalATs/8j8h
         4S827PyvLKErx2XIrbyl7JJXObgSRgVhlsd5OfbE5zaupxHMif+U+JpF2jIgo+6VgJgu
         /acJmViltD8tjAxwX2SD5bq6nqV1lFNhAroV/Oy58tCoFbuk/cm2pCtyOnMlJsBu3lxI
         WI9y76/7bB1pfrbxOIo7T/RUqZt7J0kyL3fcF74ku2vkOzqWoLuKNnNJaW4qkwt6vQJz
         tfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3iy1qtuTmEiqY7bpOqwNHUsNB7yi8yYKnu7rZ192oic=;
        b=aQcOxHsp+v704akp1MbVKdPwDp+qauhczYItTWIRa4N2pdFhIYcyGEs8fb4N//Rmil
         NODhVyxO8DO3bIkO+MuBpxDB/9oG2GZJdqJXzIVMmpbIWW8/1r3oTa86mFC88u70ZpKg
         DDA782VbKCdJ5obTOfMSQGSEfDpRYnhemMH/PP5x0vpmYu1VKp4Hl9f82LIWM4KFR/6C
         UtpWG2ikWUVAFqrXuL0LtBIcWy5Tkka6mYvp7VMGVoD+AeaXer45+zJPMcDKwagSsnbJ
         +mhqtaOk+UATOcmNo3qNlz4ctlRXK7Cdfl3WJGlHLM7lbL2mUyPVJ6KOdMHuyFfA1jKG
         5fdw==
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
Subject: [PATCH 4.9 55/67] perf stat: Fix CVS output format for non-supported counters
Date: Tue, 27 Mar 2018 18:27:47 +0200
Message-Id: <20180327162730.617255686@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109219348833077?=
X-GMAIL-MSGID: =?utf-8?q?1596109219348833077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -876,7 +876,7 @@ static void print_metric_csv(void *ctx,
 	char buf[64], *vals, *ends;
 
 	if (unit == NULL || fmt == NULL) {
-		fprintf(out, "%s%s%s%s", csv_sep, csv_sep, csv_sep, csv_sep);
+		fprintf(out, "%s%s", csv_sep, csv_sep);
 		return;
 	}
 	snprintf(buf, sizeof(buf), fmt, val);
