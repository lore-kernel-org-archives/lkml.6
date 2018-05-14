Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo3x1bLONN05TsjGpRYJRmRdHybwppuhP0jQ7xxet2zsVD2Fljc3p4pCZaqroTl8PCeZsfq
ARC-Seal: i=1; a=rsa-sha256; t=1526281139; cv=none;
        d=google.com; s=arc-20160816;
        b=QtSeMg0hwlZIVYrFipSvPQN/3LFm4gJ3A53Ae42E1nRTtZZ8GqFQ8ZKPfTi810+Tf9
         hmj5xTwlVEPMFK77HCLWzdyggRIW1/viu/6Kak/Bcpc44AjDC5e99YwirUOHeFqb8VRh
         FFQ/w3CEfISSJ86w1i7Uq43RRt7QjcSiJ+mdwoTnhSwbXtMzhHmdU9jYlIXLg5He+Dfj
         XFV1uLmAmr1+uCjD7pKcEBihJ7tNe/VIvtXjZUMvKUGXtCYxs+kvofrFaC+R1jznFY1s
         n5VFUEhAmUDCW7SCVBrXqNxZd/NGUAwVdQRlfatC2c7O/JQtrPsRNatcr4v9d+m3rEfI
         vbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ok06PHvbIPgaIdAse4aL1lCNnYR+vnUFOQsYyBec5Rk=;
        b=PnIwDYR5Fr+XfQwMRh7OCU5butAZGQTURx8byuMfUq6Rfihj84v+KTmy9FjpDvnnTp
         /0TRMLeECSNKd1vbUDP/iqos3pzYUhnlMXXMkjkBaz9BYbk7ok236rOibSOxWOY8+rTi
         +iyR02Uoo5CbtI2txGVkeHL0LF9G+yJVpn3Tf23UJxDQOKNr0l9LzD6fPscCydanHK38
         Jpr3Vr3ixC5R0gOh9sm5WbLqBcVwhCeZta1wYFAkQ7U+26MKI5tmEQ7D22kb6U6YwmWh
         D8akkG4Q9rbVFBuFXR6sQN3wmUuvdzTRWnSNjUaVm8/OWzy/dUnJy8xvkx49QLJ14zo0
         w3kw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TGUdQt+u;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TGUdQt+u;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.16 30/72] tracing: Fix regex_match_front() to not over compare the test string
Date: Mon, 14 May 2018 08:48:47 +0200
Message-Id: <20180514064824.348630867@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421234253584189?=
X-GMAIL-MSGID: =?utf-8?q?1600421772215527923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
