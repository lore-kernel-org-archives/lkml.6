Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuKPFfW6nxXWSmStQ6mS5P5zlqGBficOucsXMUHTSDIPKzqBY5iAdRRZJy0oGu6MhRCjjuk
ARC-Seal: i=1; a=rsa-sha256; t=1521214755; cv=none;
        d=google.com; s=arc-20160816;
        b=DpKJor8+VMBDHPWsllTszLsJ2EPTxHkojmGUYWMvp5fV4m7f3IH+m2gKb+tWaU9fvh
         CC4O8nN89gGqeReNENoDz4XIw7AgyvQo1bO9D7XMaPbPq+sPeNNyG6GRNR1J/TT/dm19
         G5TAsidD+2YDH7XYLbGXtsBsFRbwlcY6Ipf0tJLJlT3tZ7hA5V2GTiH0OTEjX4kVsqhA
         2tEXEj2th34FU/DbeRxEvaSDx9gA/W9km43oQNtPEdsrPE+89R96i1qNUGMx5mScirMF
         O6Z/QXXyyw04XFWxDMsfVoK+zKN1wXdADa5p26QOqpIzO7J+Uzk4ydZ+VrHwlgj9uuJB
         SB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IBWkPAxDEeA9FKDJBbDfLlooxiH5o1YcFzzCX6vvJqE=;
        b=bETznznSgpngWMhVr3FkXOpyqzgiFrM2FsPkmvM/qsuKC/eu04WRLvnlMg4ER+IBkc
         /dxsQyvGKT4gYCQ2OKPwsCmylvneaLuzD2RmIEpA+ZJlIJde6dJ12852FgBH25iJNuH5
         8VgB4WtvVVLiyjI8oeWN4MlUQGjT7yh6I8qa7XqfCAeiBmup/frkezkwz14y3re1RCWl
         SlOYu+/Ao2TarCt9l6GozhIobbcNs64RWtzGR3Av0FRnmsIc2cXidQSLjBcno4QjSzB8
         YbeGmRPDNsvEdkT5RBcNAyKhaII/O9qzCF2sq8BgUZWrrrPM+XXIlr4k/R0PyFlFd/f4
         oluA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 102/109] Fix misannotated out-of-line _copy_to_user()
Date: Fri, 16 Mar 2018 16:24:11 +0100
Message-Id: <20180316152335.401619923@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109283133107823?=
X-GMAIL-MSGID: =?utf-8?q?1595109283133107823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>


[ Upstream commit a0e94598e6b6c0d1df6a5fa14eb7c767ca817a20 ]

Destination is a kernel pointer and source - a userland one
in _copy_from_user(); _copy_to_user() is the other way round.

Fixes: d597580d37377 ("generic ...copy_..._user primitives")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/usercopy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -20,7 +20,7 @@ EXPORT_SYMBOL(_copy_from_user);
 #endif
 
 #ifndef INLINE_COPY_TO_USER
-unsigned long _copy_to_user(void *to, const void __user *from, unsigned long n)
+unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
 	if (likely(access_ok(VERIFY_WRITE, to, n))) {
