Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49CO6BT4j0fqiyoKzwNPucLy0w7qkDO8Sjx3qd35B7+fFw5dKrco96Cl9nJjVQCjO9RsPPZ
ARC-Seal: i=1; a=rsa-sha256; t=1524405630; cv=none;
        d=google.com; s=arc-20160816;
        b=bNdkwZAEjc4XZUdDa1nX/qePqkvZ8l7y88ZQGIVd2OhJJXDmK9r+zrkMZ0NrNTS/9+
         bWK6vth8a/Tq4yuieATlHGcPak5SCqiaQ3nT3Gg2zMgNRVTMkWj2gSW7WvYVycEzlBqT
         vdP2sk2KzinqRZFuShfBlRc63mJa497YMF+b9E8d6pELHQsZtUevrGxOtgvH3HWnXfYW
         xlDafoln26qyhrKWXXtf8NQEnJpz7m+5uEwyfhIZotbDKHekypeMwRHlzlpAZQJDBrN/
         dABVccCqRJGJ2vRFUhFYVQeWF2GWNMeRsPH/EaTx0q7kdctAwDHUvEqss6WfWcPpYGGX
         iggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5vAWAiX4FUOEqOTEUagqTnlCqrUTmia4QeUMrmiRiAI=;
        b=ry7MagxrEqOw/FYcHLZWk/gI6GVyBbkAXFZsYgaMhgG8CgeL2uJbUkHPVGbbq/R00o
         fBQroPKApafyMI6Rf/W9FQ8upnMXywqVFLJuNlSpit3NH5RZPnUG0B7wbs0WyQFF0hYy
         cMDnx3VoLb0a4qCmocM9nhMk/5qR8xK2AnZFwF+bVoVkSvajjigNrsptdnT7tgIGPjBs
         auYJX6ILCL1EeERWtiF/0VmTDZGCMC7iLHlviWaJhMyyb98GO+F+Nw5EnihT5oQRayYu
         rYP6isgOWVWgoIoXUADdcnxBzp19KP+lwpjMn7j1oxBaoTgtu1AeyydPd5IM7CdqwFcM
         B8Bw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.16 137/196] trace_uprobe: Use %lx to display offset
Date: Sun, 22 Apr 2018 15:52:37 +0200
Message-Id: <20180422135111.330525700@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455157680430617?=
X-GMAIL-MSGID: =?utf-8?q?1598455157680430617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

commit 18d45b11d96e6f9b3814960a1394083a3d6b7f74 upstream.

tu->offset is unsigned long, not a pointer, thus %lx should
be used to print it, not the %px.

Link: http://lkml.kernel.org/r/20180315082756.9050-1-ravi.bangoria@linux.vnet.ibm.com

Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 0e4d819d0893 ("trace_uprobe: Display correct offset in uprobe_events")
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_uprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -608,7 +608,7 @@ static int probes_seq_show(struct seq_fi
 
 	/* Don't print "0x  (null)" when offset is 0 */
 	if (tu->offset) {
-		seq_printf(m, "0x%px", (void *)tu->offset);
+		seq_printf(m, "0x%0*lx", (int)(sizeof(void *) * 2), tu->offset);
 	} else {
 		switch (sizeof(void *)) {
 		case 4:
