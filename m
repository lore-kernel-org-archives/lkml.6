Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227AXYWrK1P91sTipUXowQgfnG3adiTDqDBWG03zz+JWri3rpDSyGW6Zzcpxexh1KPmKROmL
ARC-Seal: i=1; a=rsa-sha256; t=1519218682; cv=none;
        d=google.com; s=arc-20160816;
        b=xRjxktfunJqGczn/YqP1cfn/EAEk2iMSB9cpQaeEW0Uso/98O6a8UY84/CepFF3bSI
         tUKe5G5zFtdhO6xNFHiv7OpCQItgd6oJh97NwW62hTTg+AvZzdJy0nc3G0H3Rzy2ot30
         aa0CPVNMzip3l3y3M+s31G7Ax9SpjaLxnG/hyhXxFN3JaBKd9jZ/PlLGK2F7yRkpNkNd
         t92g695x6s8p9qC3V90xEoHqalnxEKOYftRHR3B7i4EmASyZrji/aFw531+/leGdiM9J
         4ZfH2JIPqqNN8IdOU8iRLi5zkmfxR4SFLbSzbe+siO1y/7jR6YrjqNHXbXdy+giCmacy
         ceww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oH0ENzNwh31jP1Qyo2deSXlbpBRPQMbqFW1i+5Uoe2A=;
        b=oOpFwVdhfLgWG0LDYPHI/SOtqgKHT3XImCknj7bcUNyQksNdHUyiZy0p+KCXg/J+sK
         dKN8e1yzRDCnbNtemId1agDJhVFko1X5wnDMUwIT00HOjJgPhFhq3DR6ZK+EF9ZPsCIf
         709ctXh2aTC8kx+iIgFa1fYvOm0ge7PTq2pQmHdbey5OyFSj1s/bzDBytYwu/1q+KsQs
         1bx3tgY+KV9jut+K6SDngHi2+tHvb3+pG+xgsRIBLnhpaiqj4DN6nsAHFGQOQOhjWhxY
         BU/YSv2CjU9CiCliuSaWGtCGEOKLtkVKtJkGtgrz3QGgY0eib+Bq8DnfqSctTWaPtBz8
         I+Vg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.15 125/163] tracing: Fix parsing of globs with a wildcard at the beginning
Date: Wed, 21 Feb 2018 13:49:14 +0100
Message-Id: <20180221124537.044703262@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015741124609783?=
X-GMAIL-MSGID: =?utf-8?q?1593016249573774892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 07234021410bbc27b7c86c18de98616c29fbe667 upstream.

Al Viro reported:

    For substring - sure, but what about something like "*a*b" and "a*b"?
    AFAICS, filter_parse_regex() ends up with identical results in both
    cases - MATCH_GLOB and *search = "a*b".  And no way for the caller
    to tell one from another.

Testing this with the following:

 # cd /sys/kernel/tracing
 # echo '*raw*lock' > set_ftrace_filter
 bash: echo: write error: Invalid argument

With this patch:

 # echo '*raw*lock' > set_ftrace_filter
 # cat set_ftrace_filter
_raw_read_trylock
_raw_write_trylock
_raw_read_unlock
_raw_spin_unlock
_raw_write_unlock
_raw_spin_trylock
_raw_spin_lock
_raw_write_lock
_raw_read_lock

Al recommended not setting the search buffer to skip the first '*' unless we
know we are not using MATCH_GLOB. This implements his suggested logic.

Link: http://lkml.kernel.org/r/20180127170748.GF13338@ZenIV.linux.org.uk

Cc: stable@vger.kernel.org
Fixes: 60f1d5e3bac44 ("ftrace: Support full glob matching")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Suggsted-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_filter.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -400,7 +400,6 @@ enum regex_type filter_parse_regex(char
 	for (i = 0; i < len; i++) {
 		if (buff[i] == '*') {
 			if (!i) {
-				*search = buff + 1;
 				type = MATCH_END_ONLY;
 			} else if (i == len - 1) {
 				if (type == MATCH_END_ONLY)
@@ -410,14 +409,14 @@ enum regex_type filter_parse_regex(char
 				buff[i] = 0;
 				break;
 			} else {	/* pattern continues, use full glob */
-				type = MATCH_GLOB;
-				break;
+				return MATCH_GLOB;
 			}
 		} else if (strchr("[?\\", buff[i])) {
-			type = MATCH_GLOB;
-			break;
+			return MATCH_GLOB;
 		}
 	}
+	if (buff[0] == '*')
+		*search = buff + 1;
 
 	return type;
 }
