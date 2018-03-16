Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsnPPeuZan6g9zIir9e5ZEU0/+EAgDl3hXWR5j8IdJ7y/5biPWYSjNB/iQ3wmw7+vcPkRun
ARC-Seal: i=1; a=rsa-sha256; t=1521214653; cv=none;
        d=google.com; s=arc-20160816;
        b=XEyM03tamIVEi2BMEm19I5NDhkaQWEVSn0iDEhPTh3HefdsrM8ZSD1V9w6bbMAmdBl
         fexj10m3L7yInK+7DivOskDwgkDTn0sH6ZiIO/0jnX2+AuR2kKlAUmUbx+DbLWSqS7yo
         9Ikqu/5/zP6/9Z1xk93ZqJJ8GzTgeXTQ/uFW1ytPUpJpPm/+2wVRuMXPYvVhXJfklGL1
         Rv57rzJ8RDS1490mVKJ811RpRM14jovqhVo2Usz5cAWHxqltQLFBfi4YB94yGwVXKi65
         g/nWjqosKgcAV5wtRK7xEDxcrtKUjivbMLWNNrOTQs8INVNGU5FKobRimyxO8+Lqeao3
         uJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TEHNhVyLd7+0xbXW+jJhLIGaImk34WDTOpePxj4eMRA=;
        b=cA20+nvPXN3jrDopnJnl1DcxkOhdfuabS8PF0jLmIUcpmXoCxRbTuCSOPDA1EQ6uXA
         4to+WnGv74nsgThwFWaTf71K2bDYlBO8/R+r+h76wmJvHMbyGDShovI+Y6SjqX7hYSwx
         cFsBfIPcb8BrNtOdo431zR5ycJ27kvPJVUMXI8KNcBwrWMnaitgyriO9BHkvQncpdRm6
         yfFvyRynR6FirjKvIo4rRbTB7rzNcxuFiXESmKyTfRno0M1Gukt88GAv3PLcMby5g7qG
         PSj1nYMyQAGNYRCUeuXBXhCZTiuLB5CeDp32JDWicEDuxCrCR/GaDdzorvL/8Ld+VXjv
         8s0Q==
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
Subject: [PATCH 4.14 079/109] tools/usbip: fixes build with musl libc toolchain
Date: Fri, 16 Mar 2018 16:23:48 +0100
Message-Id: <20180316152334.257925032@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109176956118610?=
X-GMAIL-MSGID: =?utf-8?q?1595109176956118610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -456,7 +456,7 @@ static void set_signal(void)
 	sigaction(SIGTERM, &act, NULL);
 	sigaction(SIGINT, &act, NULL);
 	act.sa_handler = SIG_IGN;
-	sigaction(SIGCLD, &act, NULL);
+	sigaction(SIGCHLD, &act, NULL);
 }
 
 static const char *pid_file;
