Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227By2vnBNphHpLla1FcTStjApPzB807OZcGwI/5uqx9COGSLnw+Pnc6BWwx/5FcxOTIGKON
ARC-Seal: i=1; a=rsa-sha256; t=1519218197; cv=none;
        d=google.com; s=arc-20160816;
        b=GB2k8Oa/2f0gunzZ+vsIAF7PVIlygUTYlITPFn46uU+FewPjYzAGlVGokiD3qW5SJY
         LtOi1+o3vZxJ7afryQ6r94sNAXKTz8qyF8b8afGlWaCRAUZnwY5ASrr7lH9a8SB0OT/T
         M6DatxGfD6WgNwpfIEpJ1pOvDlGAs8xX7KCCt2LAn6cTPA/x3UBffYaZJpqQLnZrhmmE
         CxlOKK3faZMqJUfY8b55rx7a9HwAtlGc/6LU3YFusmePqwgdEFIzMuigAgkwZm3VXAIY
         /6QrZ3oi8Y/ulCgB7/zagEUbBeiIO8PPxPqWRkKB2FWYzjko+0V/2HuMCvRxfiVzbWBb
         TG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Evzb+KeLtElVko7fjKNnrwkN0RgzKkptHgACjqA2AgQ=;
        b=Sb/ys050E7NPNlBkepFn7fa8Nj9WG/a54DtNQx86CPfe6YocdUI75F4mzNdfxT+kfw
         XJhvcj1qAYNurLt7VnoH2CEphISL3T1tpzzLLChnlk8GqtmV2GixTQqFXRtydDQ6dPLH
         J5TqxYx82ukDLQMlyR/f+BdAyrJaTioSL7uWUhCWpnA/hpzgUTiV65OMdds4rIt28/vS
         h/HQjK3ekjYgE3z/OsGFdCh3LM6iFqy8DsuhGKLgX/xYFy0+HY9Z0s7PM1CZ0AImW+IK
         Ra1T+FPkmTyC8vnvuIrUe6/i7le0SM4eT2PdOoqzClfxysam/iSp4ZLLieWNWATszuCa
         +VWQ==
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
Subject: [PATCH 4.14 122/167] tracing: Fix parsing of globs with a wildcard at the beginning
Date: Wed, 21 Feb 2018 13:48:53 +0100
Message-Id: <20180221124531.192670190@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015741124609783?=
X-GMAIL-MSGID: =?utf-8?q?1593015741124609783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
