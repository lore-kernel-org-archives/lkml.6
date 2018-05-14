Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqo43oIKaoPU2wQ6X4M8oSHAA3N/PppNwOIhPs/GXZlkmbNvJ60FNrwpO/0rD2G/XoHddoO
ARC-Seal: i=1; a=rsa-sha256; t=1526281038; cv=none;
        d=google.com; s=arc-20160816;
        b=BdGJzb/66WlYSd2xAl7EQ0k4FpX6c9qSddnLRCfQtP74NxNfbIMUqDM38cBEyjBfOX
         BqrXlao4KTI81nv2oW6CMqGyodV2JGeXjx9khQ2UmOMjOCmjktkFl+xaSaUojvR/jJHN
         /P0xnr50Dg3bqQyg89Wh2WJ22m2FKOaf6HwJTI0jyvXIl4W2AQH0y9hqDms7QrxGgyE3
         oOAH2WYxHXvvqk9lnNYDytFzQOee3eojOKyjFPNv/vLz6or2NvbIuJpIX2rGRII893fE
         /xegOwbF/3YBp2ODvOw53JKAt5EEL8yxfzEVYuABKIkVvMDuSfkT7Iox5VIXKTvG+BJj
         sJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=kTKtzLfLQeFe9UCSfRkftXSw+/yiEdOz4uf0XuGCZ5I=;
        b=ayErKl0Q5qIa/EwdtyL3f4J3BgoPR8jkaoEKIglYo85INMxpVa4vOrthXJCfNc4nA9
         hM9hMlNAB7Qed7uCTB1NlACWfOmDJo4mXEB6l6o5DnczBOQOVkLRGJuAeYD4MzIOOBQR
         t+3i3KtgSbn1x82MGNoRlmmHWfmcRNQIxwqWDLzU6YH4v1m3vtXUxlW7W7A3FFkUAm7f
         55p3IP196G0cgKi7ic/dPX9AGDQC7OO+AsUhXVyLTj/+ejdxhYtLZQsPTNV0yJgnK2GU
         XeKn5FJdGYqRxuJ5WzogATC+Nh//1wgf99dQHZDromls/il1T9zOH2VgXt8EmTYFXRuo
         UDRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qhX3eRq8;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qhX3eRq8;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 29/62] tracing: Fix regex_match_front() to not over compare the test string
Date: Mon, 14 May 2018 08:48:45 +0200
Message-Id: <20180514064817.977118104@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421234253584189?=
X-GMAIL-MSGID: =?utf-8?q?1600421666546093143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -338,6 +338,9 @@ static int regex_match_full(char *str, s
 
 static int regex_match_front(char *str, struct regex *r, int len)
 {
+	if (len < r->len)
+		return 0;
+
 	if (strncmp(str, r->pattern, r->len) == 0)
 		return 1;
 	return 0;
