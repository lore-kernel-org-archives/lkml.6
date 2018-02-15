Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2257rpC5O8iyTYtiy2qx+A2tdaPtdayT75nh4cRjz8vAq/gJquHTezyolgjno9TJmlcZOPME
ARC-Seal: i=1; a=rsa-sha256; t=1518709105; cv=none;
        d=google.com; s=arc-20160816;
        b=FNSH1yEh86xUODPngpTzfW9OHt0s/tyMujfwO7iZs31r82/fP9EqMDi0DD/q/2qaEv
         TeZcBxZZwdBAEfkkuO36zh7ax7IQAAQWobtsC4a3X6qqpGCcyRVU45UR06XdPgn93cnd
         4TgOKWQMsGNKeQdEk4ZEtNaLt/dLyF+Sz2c8pdKPyfbx8PJ9tdJxJ8Pv8zomDvqhnXnh
         Yc/yTR+NyHJKJx3DLwKx9AfHt0Q8iyRnFicg8IGqai8MWqjmy26TtdamKBwAgvG80b3A
         4Wkxoe91NqjO9+vdjCi3wtlFIRDpSEPrlViTbrFySkHSVHLCsCD5oLv7w9I16WX1EgD4
         sKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l7ZdZHX7WY632f0pRgMi6KE6KASINzogz7KsnGRbSpU=;
        b=qJ4eSyd8YYbNNy98AhilOss9qwxExPKqAvfGSPctajSj/Paqh0CXm/CsNw1aAOkPT7
         lnKLHECccJ71SG/cQDYfMTTjOIQ/ktyEUdQvjFe7xZ7Y1bH2uUmA4aH8PopfNOyZ9/v3
         JXiKGBXDB33WLCAMGhtHCXpSrMML/DTAxrJIZt8Zt0T8hfhP6W5oexzblGEVsZSB9hMU
         kagr8C4MRmhrGwXEzAUWiT1t2qDptBwAkLX/kDpQxZN1NNBQ/+RA7bpGH4x6PTpCcCfE
         b3IauMLK/ZlfoJeShPBjpddUnbNOH9R/d8D0ot3GaSF8TmJMP9PsGQBT/DTX7+CIT92P
         h31A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 192/195] ftrace: Remove incorrect setting of glob search field
Date: Thu, 15 Feb 2018 16:18:03 +0100
Message-Id: <20180215151715.939254109@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481094081439695?=
X-GMAIL-MSGID: =?utf-8?q?1592481918346481871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 7b6586562708d2b3a04fe49f217ddbadbbbb0546 upstream.

__unregister_ftrace_function_probe() will incorrectly parse the glob filter
because it resets the search variable that was setup by filter_parse_regex().

Al Viro reported this:

    After that call of filter_parse_regex() we could have func_g.search not
    equal to glob only if glob started with '!' or '*'.  In the former case
    we would've buggered off with -EINVAL (not = 1).  In the latter we
    would've set func_g.search equal to glob + 1, calculated the length of
    that thing in func_g.len and proceeded to reset func_g.search back to
    glob.

    Suppose the glob is e.g. *foo*.  We end up with
	    func_g.type = MATCH_MIDDLE_ONLY;
	    func_g.len = 3;
	    func_g.search = "*foo";
    Feeding that to ftrace_match_record() will not do anything sane - we
    will be looking for names containing "*foo" (->len is ignored for that
    one).

Link: http://lkml.kernel.org/r/20180127031706.GE13338@ZenIV.linux.org.uk

Fixes: 3ba009297149f ("ftrace: Introduce ftrace_glob structure")
Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ftrace.c |    1 -
 1 file changed, 1 deletion(-)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4488,7 +4488,6 @@ unregister_ftrace_function_probe_func(ch
 		func_g.type = filter_parse_regex(glob, strlen(glob),
 						 &func_g.search, &not);
 		func_g.len = strlen(func_g.search);
-		func_g.search = glob;
 
 		/* we do not support '!' for function probes */
 		if (WARN_ON(not))
