Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuxtxCp/G7BlTJ0k03cSV1hEYotLAS4lPt1BgSl20WHySuUIIKYy5yxz5pzR5wDuxEnu4K9
ARC-Seal: i=1; a=rsa-sha256; t=1521215011; cv=none;
        d=google.com; s=arc-20160816;
        b=PXUwEhhAB6hENGW4oa3xdfktBwYi2giYm+23TexoymppTre4HdybSay1ezKl+jkn8v
         j1dUM6xA2wWDJehBaEVJ+GL+c3iyVlwlATQkRSKIga3clLTd0nMXXlJ0IL22YVRNK5+E
         UEvMTSB0xvc7tJoDHiRYiG6IvXSl9AoZOafrtas1PmfFN2PVrZXZc6Wfl3Va4IfgxGuG
         jqJYL7HG1nu4NX4rYFNgHUXrv8O1ewILLDi847AKgFia5qs1cHgT3TflIF4iJ5FBDobf
         PS47uLS9YycX74YvyrgA1iLJbu9PGTS7MqGmScRiUxoxvuW1KWhL5VEG5Ni1PMsNKmQw
         PsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ww/cajx/joBZDxiUOLgXn8UK+LdLYd0Qve25EGsHunk=;
        b=ly4sYlRdekEaHNj0FcZcyXgDEJ+fAgNzoJHG23+y2YLrxJrozKRAt5kPewTcPGgB0Q
         Pn3ZMmKKSbuUJ5WJpwYKHtg/nUdf7lww/3+9mdlicbPHaog5Y0oSwZN65xY3YxPfYNw3
         93e0aHpRRXn5tAp4LhthEOWM0ZyLWrsKkmW0Sy/iOajcR6qOcKgtiw+IAGK1zq6LE5gI
         YmzpeNnvgioOO2TATeBNjWwdJ/TDq/5zR67YhdwHrE+ULmhW0USxWqp1BIwTzAM2x6Va
         J19JUm8NOFk+1VxCfWh/ZELA0llHMZB8NHw0DsyNTHYIBH20Oags83kn9NmBHpyNExj1
         j53w==
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
Subject: [PATCH 4.15 096/128] tools/usbip: fixes build with musl libc toolchain
Date: Fri, 16 Mar 2018 16:23:57 +0100
Message-Id: <20180316152341.345441462@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109176956118610?=
X-GMAIL-MSGID: =?utf-8?q?1595109552047977935?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
