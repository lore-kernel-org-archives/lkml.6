Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqzCNmT+uYoXd6+Se9E2gy6FqmWAYA6vn+5ssXmWk64RbcDGAzo7dmwrGxYmit5uxEdgoO/
ARC-Seal: i=1; a=rsa-sha256; t=1526280845; cv=none;
        d=google.com; s=arc-20160816;
        b=hjGA6dWSZOT5XuOZ3qyYnkLEEFtIEsor2rT9lL1BqWLb5F9S3TOEbtVQ1PStFr+JxH
         thSQxWx1vn+kVPhI7ke9NbOW7xjh08WNu5Q+cFtmFV64Xbyayom8DqX2QU3Otna4gZ1N
         htqyyveDtiNkv0ApRPvmrdSZ2X8GDdPBcpOXU1UgYZu0E2THX2u6fwsVsmXZ3sPfxoQE
         ZKcS6ttUkyfdyKtzO5WCUGVo57ptnfwpzUclMtusx7uWzPqvzLhAMBlqiDQ9X7HOTxU8
         nYUxVcLULh8Vzv/Rt3NdhQm26pCfLj+UD/DSEIPQia1PKxdSXw9KOtoHQDo+s1fTizgR
         e/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=D+3WTyilwr+JUBjzETGz4vGxy9zDzjobI4StXDRfbKc=;
        b=DyCJBihnIzw0Q7SCAwHmDJcD9d1DRPkh4MRCSdB1IUVSqPly12Z/hh2UcIBfjh0FhU
         /07h7p122S4PoeAj3JKMmpqqt2ynZI5CxrDvUZs2sStjQAlClQKWdaYk67i0XFnKeg05
         8F8e9tzRwKtNbOaEx57ywPqsExWd9/4hU8MssFnciz2mBiE9MObk2+5XIRUiyCRhE71a
         3UFaZ6D2AgeyhFG6WXqY+4bzPZSGxQ/K8GVgUyJ3SgSy/Kn0qTfbtQl10uezESP4TkGN
         YmVOcloI2X3PU4ZQwfjcquQbYbB8PCSNTOsGefzWKZIY6D0rFkGU81UypZs194SK3D03
         b44Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=y3py0vUw;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=y3py0vUw;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.9 22/36] tracing: Fix regex_match_front() to not over compare the test string
Date: Mon, 14 May 2018 08:48:56 +0200
Message-Id: <20180514064805.989102555@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421234253584189?=
X-GMAIL-MSGID: =?utf-8?q?1600421463851298004?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit dc432c3d7f9bceb3de6f5b44fb9c657c9810ed6d upstream.

The regex match function regex_match_front() in the tracing filter logic,
was fixed to test just the pattern length from testing the entire test
string. That is, it went from strncmp(str, r->pattern, len) to
strcmp(str, r->pattern, r->len).

The issue is that str is not guaranteed to be nul terminated, and if r->len
is greater than the length of str, it can access more memory than is
allocated.

The solution is to add a simple test if (len < r->len) return 0.

Cc: stable@vger.kernel.org
Fixes: 285caad415f45 ("tracing/filters: Fix MATCH_FRONT_ONLY filter matching")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_filter.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -322,6 +322,9 @@ static int regex_match_full(char *str, s
 
 static int regex_match_front(char *str, struct regex *r, int len)
 {
+	if (len < r->len)
+		return 0;
+
 	if (strncmp(str, r->pattern, r->len) == 0)
 		return 1;
 	return 0;
