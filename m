Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrFkqIDUDOQ9EABqXbvtynrv2qzTBO/dry6w+tVUAxY5D0lxpmSaYVNo3irf86bo82DGaB3
ARC-Seal: i=1; a=rsa-sha256; t=1526280626; cv=none;
        d=google.com; s=arc-20160816;
        b=qb9+k5ebojxoGjz+XWnVJ1Zm53W4f13F5aaW7RlUVnPO2qugLRioZ3mMVDqcmPLJtk
         qYb1crpGORvVgJ/4me3THLgpTdkYIOPGo0moAy+2r6r436dkXF66phFcViAdh2c6Hhs5
         qVTJHb/+k6D+4ln36Yd3HNEgU7aQSmyCCRocv0c8pWW9OGKPv7oBFtET43FperMhk7Yr
         UbcMKtwghmsuDonXDM23QB+7WZUOA+IO7Iq9Ir/SSfNIlQ7GS+x53snTf8YjWr3MUEln
         13DGUm6f4YtLLP3LTkG+rXJapUV3+e8JRA4Ey/AO6ikRUVGq8wnQUZ2h+wenG3i3DVzb
         mPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=xIBf8uUZszFZnaR8ahQtEePkLw5N08TYX6qx8ycQ124=;
        b=V+/G6N+SQ0uA3WTOZp5y3XK08X350rU0VfzsgkkfEe2QDmGj9/4In8EBogGKsmda3e
         vVNiEtWpmRdztYrowQZvv6DWgBstj6IUh9+lHYoz622B/KgLYjdIclcvU+oqXdnp1DNa
         dmkjspofaClbKkgFyueye1hh4Oxz3WB3RpuabN4UER1+cJe/acihQ4v+kQD+AtLBcKyO
         xMT3K4FXIixIIFgW4V/CP7jKYvTPWMfeu824YN/A8XTyf0+BlCHnlb82MWwiJrNlk13V
         so287nnn/9jFBalsSZ4n2SKIsPZZ6fgWcNgSfQ0tdWZJQtuuzjNKBmQnL8AKlhGBFraW
         we0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UrFzRoHK;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UrFzRoHK;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 3.18 21/23] tracing: Fix regex_match_front() to not over compare the test string
Date: Mon, 14 May 2018 08:48:50 +0200
Message-Id: <20180514064704.936636221@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421234253584189?=
X-GMAIL-MSGID: =?utf-8?q?1600421234253584189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -273,6 +273,9 @@ static int regex_match_full(char *str, s
 
 static int regex_match_front(char *str, struct regex *r, int len)
 {
+	if (len < r->len)
+		return 0;
+
 	if (strncmp(str, r->pattern, r->len) == 0)
 		return 1;
 	return 0;
