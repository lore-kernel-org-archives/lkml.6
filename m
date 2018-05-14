Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpDq0/cudeKr6PNJokV37KSbvOv5hcXJ942TkXOixvSxr47uV9PTwAcZzUeprMbRcHLwaw8
ARC-Seal: i=1; a=rsa-sha256; t=1526280757; cv=none;
        d=google.com; s=arc-20160816;
        b=Hf5GXi6biPKAORWzq1YsHNofSprgOQx2ivwrkdaNbxG8fsix4bXcI3sDhbLLCELBZe
         G1xJ0ey9djGaU4mSR7FTxQDg6wSFxThWbyBbUKnSs2T3jv87dzXfFRASy4rKJ1TxL8XG
         PQG2u1ISXwmn5nVKXGbJyHegqy0cmkhYQVfWbxs4FC3TQDB5l9NusmLAckh5DnEmXimR
         5p4pVv61mOaoqOiKI+EyETmnaZ1SgbzuAnojQjzO8sL0V1TeWHR6U5AXAk6YwmBCj0uJ
         gZNelRHcxnZsd/IPesrnzC58vOhjDxr1avgt82sbTKxVLwrL+okhtpzqwOCE6zU9BSht
         4ETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=PKxXLNibukgVUVDPzcyZrTNqIZrIfOglXNnF5dgYag4=;
        b=ZTCVWikNHYBEr93xO67W/4eUgJWaj2DlbyDUT+jBLYIBoEtOzTjPUoKLUprd5rGbLr
         fafPGLjtbIUm2rtIYTUjN+IBatlkIWaA0/s39QhPC2SCEtgtgxnZicg9r0ZyFkT4QrUi
         7luC+kXe49ojXjUh3Yfjg7d9vldOxKvF3TY+yIPT6Z5uO4Buy8EFC1KIq/FZwYr8MQfI
         pvwFnouFV7Xnlq2vDZyt61mPOe60RdbTx0OMC87IhmL/iIoXQnTHc6ULsNfqWCxBh2op
         aW3X3qSJut92zL0Qo9EiMTxmVKQs6bUaw56KadM7E/d7+crnmHG/NLSD8P3m6insaIdd
         jBWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=DIueHqYt;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=DIueHqYt;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.4 46/56] tracing: Fix regex_match_front() to not over compare the test string
Date: Mon, 14 May 2018 08:48:51 +0200
Message-Id: <20180514064759.044491014@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421234253584189?=
X-GMAIL-MSGID: =?utf-8?q?1600421372066307073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
