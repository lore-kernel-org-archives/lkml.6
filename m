Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuIhw1XJILZtMvXpfBVSOSWezljuaikJ/ZbSWNvewUn/0USp7HT9+7G5ewlyfEvfyQdOocb
ARC-Seal: i=1; a=rsa-sha256; t=1521483987; cv=none;
        d=google.com; s=arc-20160816;
        b=l3Jka4pkEyirpzCswJpMW+FlDqUDHCJ1Xxa6ITEh4r/Aa2cUB2dRzmOVKLkPc52LqX
         H9yXwe2dslyEJgFAUzwpPgtHLuZiq1T1ZyQEZqJ5BznAGwS59nR0sfPVfjVUfNZyT/yh
         NnQEVYN7hqmxaN641c6qUjyCuWeFgxYhjF3awjA44F+VU9EvblNN5RTbpBsFfHThotpT
         XvrCTSXJG17aXZr3rSaPdRAwktw8fGJdxaVMQVWkX0kcLFPHAo6GghZcQhCwM/rj+DpD
         COcABfkvd/Is2pbv0o4hfe27KJGMLqL3FsADM9I1MDTMOjoZcs7x4b9BI1HRdBULP1a1
         u2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IU2NeCng7ScS42cAUxSfI02w7SGbVlgz/UuLSZF5E/Q=;
        b=J6bemZfaNNMXpUHDRx4ijUh4ZG67JjTJaQh1fut4s0y24EcbC78vJloubIx3YTMlwj
         euvqGJHmngGum3oGv8mDvF/DHduFgj05bKjnRE1BE63CMqong25Iny/vVjgokw9sWCTU
         16P3yXlMe6kcLfmElRjHvh8X3T5AdL8t9AS+0C+lO1LEbPwSvXsjphLQiRugZd2VoqQy
         s9Kc6G3W0aBxdtx5aN3CxlOg7EXVJg2D9welLXxDFIscfMQ+gW9zvpMajeXmzIkvH5y7
         YjNXUSO4p4tkuTmgi7MBDpvqiXTMSXneEZb9/QsOGiqu9IEueiJYYXSEKU5v21+QhEhw
         eSAA==
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
Subject: [PATCH 4.9 191/241] tools/usbip: fixes build with musl libc toolchain
Date: Mon, 19 Mar 2018 19:07:36 +0100
Message-Id: <20180319180759.047372125@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390614757030686?=
X-GMAIL-MSGID: =?utf-8?q?1595391593718893498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -463,7 +463,7 @@ static void set_signal(void)
 	sigaction(SIGTERM, &act, NULL);
 	sigaction(SIGINT, &act, NULL);
 	act.sa_handler = SIG_IGN;
-	sigaction(SIGCLD, &act, NULL);
+	sigaction(SIGCHLD, &act, NULL);
 }
 
 static const char *pid_file;
