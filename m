Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtQbFSvuScgs7P1PtBocqdTK22k2uHy6alElu1mxpzpp7ZhtATjSNTHhR1Nm/U9CSFpgfAf
ARC-Seal: i=1; a=rsa-sha256; t=1521483360; cv=none;
        d=google.com; s=arc-20160816;
        b=QU+TNFhOhBPZRYsl+JTg7EaFqkxBse3oi289Vp4/cvJFQzs/8gV7Gdt2YGSgbxWijW
         pMTnzn7IY3DtSgnW+hgMOyIEn+xwWz1mfH7B5GivUrFn0z0eilc8xfD6dWhp2E36mHJ/
         WpRS2+zwWejR7bxpYjLyq4mQ7ckjWgbz3Z0d/Q3cQ1bhy1txjg8G0S3NKM0EjPnxopo6
         khcW6kxrF+HfnwuKvxFHvG8wmK3dQRmql1wLMOvf0w2j5r0+C+fK512qp6ulwSLPW1tE
         es6sxSisCY+4BMPVAa7u5g+cGAUffMA2WTzIrMBDG3CEYhTE3hVuxQWNuPAjzL95v9X6
         RIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AOMdJVa+ssnUJh8nsgnq6JJwHAihmZcZvykd84OHurM=;
        b=y5qZGiB8d3kTzlUnVdIcStBxUmHoEuM8/Qbh6Yr7lvwXGlor6+7lnFh5H9GuDmvnS1
         0Gt9NG1G0PesiOtH+pi8yIum27Yq/9K9wWBYgncxUHikkOzL/N6lJTVNl+Mm5GL2d36Z
         +zj2sx0XS6tsXf1alUPmL8n9nb1jAS33P4+ZCBz7DpJhpWNyL9bINPcU1MXkWd8cLkZQ
         mgn/QnpDX8z/6nahXVow9YWWBn9XskxQeFkBVeNNOWZU7tLFVkafDYE5kyyBVAvZDmLX
         IkkadHW020sCkVjjN1sZe+9I5vKaSS/3huhAihPZqDv+eaZRmcEKblt/iUHTtOlonZb6
         VKEw==
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
Subject: [PATCH 4.4 095/134] tools/usbip: fixes build with musl libc toolchain
Date: Mon, 19 Mar 2018 19:06:18 +0100
Message-Id: <20180319171903.000757234@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390614757030686?=
X-GMAIL-MSGID: =?utf-8?q?1595390936357921697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -451,7 +451,7 @@ static void set_signal(void)
 	sigaction(SIGTERM, &act, NULL);
 	sigaction(SIGINT, &act, NULL);
 	act.sa_handler = SIG_IGN;
-	sigaction(SIGCLD, &act, NULL);
+	sigaction(SIGCHLD, &act, NULL);
 }
 
 static const char *pid_file;
