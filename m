Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Ll9iSYhsRa0m9AwK5NN1/qGtfjyNkhaXPlTB0uHB3ozKYEzCgHygvYi78sbBPAXCDh3bx
ARC-Seal: i=1; a=rsa-sha256; t=1519218503; cv=none;
        d=google.com; s=arc-20160816;
        b=nz0m2l0F8cYzy9LYM17HeYB5djLm/axiyMs18V1t1AVT2swWdsLMfDG+rST9rZbt2b
         LyQ+zx28iYj6TC5XpQE+39lWgDOcqkr0zX+VOUdgqhPWKdp2MwN1YXqfmS0lfCwHt5+Z
         as2frRRBC3Y4Nh1v5La6sNmgAY/hFLSooIrlfNskNfPVG1rIs98ei0x08U5OwpWr8TmK
         pV0nbdXsa4eExCgHdkGYo19PUGf69sMZkfVtdnhtJmcOGwkIEo7zte4dAii7eldL1Dvz
         adEEIiDbuocrZ51eXE+JKipskyLOjHESQNi3fHf0nBeL2HeLfcY/e71vcrnZe8QZ2QK/
         rY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ryKBaoZW18KvZ4+xzw41s+UkRnQ/PgyW+Wr6dGDN80o=;
        b=CwaPp0GWyohXsqMQJirwjHnCwfkDNSHU3onmc1s3BT+RrsUkzIoARV+rbK61Dyjy0A
         mF0xH4czio+w0N2Zs7Rs9zVpLw7SnqjItaM9vxxJYMInji8PxsyAA9eXB3gV7zkmHGUw
         2iF9pTQg4xwNJqtPUCwNRdr0kUdxzOpOqPduKkiJh2gJYBiyJkRKub5jY+ZNr5dZFGlV
         edCvLaMF7RaSeMXYlGBzaOPt2dpiFsMto4wpAw8XD0CwdcaQt+UzTkCxWR4PQoaD7VsJ
         TKqYGxaaqyULYmLgQXy3jUCk3BuH1Dcn64gVWoSMaRrF50Xlzl12rtR6cPSLZv+tJYii
         +8MQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.15 018/163] trace_uprobe: Display correct offset in uprobe_events
Date: Wed, 21 Feb 2018 13:47:27 +0100
Message-Id: <20180221124531.133282347@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593016061996653080?=
X-GMAIL-MSGID: =?utf-8?q?1593016061996653080?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

commit 0e4d819d0893dc043ea7b7cb6baf4be1e310bd96 upstream.

Recently, how the pointers being printed with %p has been changed
by commit ad67b74d2469 ("printk: hash addresses printed with %p").
This is causing a regression while showing offset in the
uprobe_events file. Instead of %p, use %px to display offset.

Before patch:

  # perf probe -vv -x /tmp/a.out main
  Opening /sys/kernel/debug/tracing//uprobe_events write=1
  Writing event: p:probe_a/main /tmp/a.out:0x58c

  # cat /sys/kernel/debug/tracing/uprobe_events
  p:probe_a/main /tmp/a.out:0x0000000049a0f352

After patch:

  # cat /sys/kernel/debug/tracing/uprobe_events
  p:probe_a/main /tmp/a.out:0x000000000000058c

Link: http://lkml.kernel.org/r/20180106054246.15375-1-ravi.bangoria@linux.vnet.ibm.com

Cc: stable@vger.kernel.org
Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
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
-		seq_printf(m, "0x%p", (void *)tu->offset);
+		seq_printf(m, "0x%px", (void *)tu->offset);
 	} else {
 		switch (sizeof(void *)) {
 		case 4:
