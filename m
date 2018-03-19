Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvqRUtjgcPUNAFVH7UGDNICCxBs5xEZTQM96YfcqByJ9MVXo4hI9cPah5jjmHMH/W7NjPvI
ARC-Seal: i=1; a=rsa-sha256; t=1521483053; cv=none;
        d=google.com; s=arc-20160816;
        b=OgmX0lCrkQKlweRPSnL6KG/Z/Hu02phA0nocYMrzV69jKcHrlYnEFCEWGX2i1w90Dh
         ui608XEvFYCnWTswir8LEYHgkOJlm+aRvI7Qf1EjZSdoFcBoIpCllAvx3agzhEzrtGxS
         CIyHA/qvtKnv/hxZTqjWBhbpt6u4TRCh3Q4doyr0qS339elxud4GAPfOICsXM8rE5xqk
         iPBfXISPScyBIlSE6mW5ouR5Exz07ywjI/JrVZurhXMXn7svynDSEJ9QJvwrghXjpPTf
         RuZK4c2TkSeHK0/Uyru0Kvp9Tuc+pQK7qW/817UFul7zwHA72DrpEr6nxab1jKYfeuNK
         x3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7+Qz1f+Bm31H/YZgk3jpZeeILGEj+J/LyNVti1Kcrxs=;
        b=m8W0o+6QC8cugrKgF7aNISgZ/zjsgR+vfUrYNmxy5AI20+06V/qy4ltLx/vC4Xxpk+
         NGa7UywEsa/3omUjhzw/TftXYCGZgaJGO022/wqGoCaskYBkdl0+zIu3e52BJRfxOjrr
         /bKx44Q8005fpvo7U26AFMvCQH2uoZ6RQT1Z8PrXBaFP3jjDuWQEATWbwQYthWTu+TED
         YENmHDc37Q8aMprw9IiI4yHU5EG47DbIJ77fstOcIgHhfHLAhDnL1taXLA3gcRA3YwqN
         Lq4T4rI4k/tp/rX7k4Oq6lvBEWIoR0952mvfAj36Ieq97v2yGCwwKwlBG+YfV7nCx8p9
         5Lcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julien BOIBESSOT <julien.boibessot@armadeus.com>,
	Shuah Khan <shuahkh@osg.samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 51/68] tools/usbip: fixes build with musl libc toolchain
Date: Mon, 19 Mar 2018 19:06:29 +0100
Message-Id: <20180319171835.032897047@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390614757030686?=
X-GMAIL-MSGID: =?utf-8?q?1595390614757030686?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julien BOIBESSOT <julien.boibessot@armadeus.com>


[ Upstream commit 77be4c878c72e411ad22af96b6f81dd45c26450a ]

Indeed musl doesn't define old SIGCLD signal name but only new one SIGCHLD.
SIGCHLD is the new POSIX name for that signal so it doesn't change
anything on other libcs.

This fixes this kind of build error:

usbipd.c: In function ‘set_signal’:
usbipd.c:459:12: error: 'SIGCLD' undeclared (first use in this function)
  sigaction(SIGCLD, &act, NULL);
            ^~~~~~
usbipd.c:459:12: note: each undeclared identifier is reported only once
	for each function it appears in
Makefile:407: recipe for target 'usbipd.o' failed
make[3]: *** [usbipd.o] Error 1

Signed-off-by: Julien BOIBESSOT <julien.boibessot@armadeus.com>
Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/usb/usbip/src/usbipd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/usb/usbip/src/usbipd.c
+++ b/tools/usb/usbip/src/usbipd.c
@@ -453,7 +453,7 @@ static void set_signal(void)
 	sigaction(SIGTERM, &act, NULL);
 	sigaction(SIGINT, &act, NULL);
 	act.sa_handler = SIG_IGN;
-	sigaction(SIGCLD, &act, NULL);
+	sigaction(SIGCHLD, &act, NULL);
 }
 
 static const char *pid_file;
