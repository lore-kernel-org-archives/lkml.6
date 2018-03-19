Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtVFoVhPh25l7QlYfx1YycUQxxNy8EgMBDLl9nqD7d5MD/BQAIEuJGlBdcddHwcp7MC4gJg
ARC-Seal: i=1; a=rsa-sha256; t=1521483656; cv=none;
        d=google.com; s=arc-20160816;
        b=LTkEjurnqlVQdeg+J4FTiJcg4IwT3/JNDTVHuofgkTe2LOAZUVG+DWEQJ59oJtOdlz
         qenM4GctLkPQtW0957RiYsq7YO7AiI9v6PVq7d3msUADYaV7NSORlbcj+Y5qWGZ4gWBB
         fGU/E7wDrnj0j1VEQryAKL/71FPET8+VtH4CmWhBeK0gzzRDn8duUciFA1PcesmD8nxk
         g7KZg3ZW9sV3dmtYL6aysEA6ZxaYUKrYajHrUCi5rJscYRIlHBk3sLi+rcJKQfTJ+Uc1
         bZiRhdKqyUglZIMtS9s2JZ4mKBm63tj28k9JHo05C6HZFwXyGldIcWVU9TcjPXpvs7B5
         fCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5tRgJVrzPxxONIW44ioF/QKyE6Q/c1V4SeYOdEDBAUg=;
        b=rzzPwk0uZOf7BYuY9usQQxR4PWEvDrlzFVw9Yga3X5ZZ52tMp6gnx9VULDNCE14rLJ
         mCDKQbiH/fD6fLJMQwhyRHoO4f3O+O9QEOvLClMIyv4MDdw2cpwSI5YNXSh4sjG+F64q
         /qQR7OfSa9nfyqvyCk/Zereb3dpc/zfocStMWTVqI4BJkvwrmUlG7qzg2j47TaVXTsxs
         gql649ldRq1HAbVTsloT2t2q8k7Bhy6MPA/VkaayVMmgFmpFErzXOqdL8WykuuFag4jA
         sUpa8A+6JWDHHomMY8X0b1hq1B497i/wxI2Eja8VLP1Q0Eb+UwXlrfU3YZdz1p2UnE7E
         c3zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Elliott Hughes <enh@google.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 023/241] eventpoll.h: fix epoll event masks
Date: Mon, 19 Mar 2018 19:04:48 +0100
Message-Id: <20180319180752.133182910@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391246031865705?=
X-GMAIL-MSGID: =?utf-8?q?1595391246031865705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg KH <gregkh@linuxfoundation.org>


[ Upstream commit 6f051e4a685b768f3704c7c069aa1edee3010622 ]

[resend due to me forgetting to cc: linux-api the first time around I
posted these back on Feb 23]

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

When userspace tries to use these defines, it complains that it needs to
be an unsigned 1 that is shifted, so libc implementations have to create
their own version.  Fix this by defining it properly so that libcs can
just use the kernel uapi header.

Reported-by: Elliott Hughes <enh@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/eventpoll.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -40,7 +40,7 @@
 #define EPOLLRDHUP	0x00002000
 
 /* Set exclusive wakeup mode for the target file descriptor */
-#define EPOLLEXCLUSIVE (1 << 28)
+#define EPOLLEXCLUSIVE (1U << 28)
 
 /*
  * Request the handling of system wakeup events so as to prevent system suspends
@@ -52,13 +52,13 @@
  *
  * Requires CAP_BLOCK_SUSPEND
  */
-#define EPOLLWAKEUP (1 << 29)
+#define EPOLLWAKEUP (1U << 29)
 
 /* Set the One Shot behaviour for the target file descriptor */
-#define EPOLLONESHOT (1 << 30)
+#define EPOLLONESHOT (1U << 30)
 
 /* Set the Edge Triggered behaviour for the target file descriptor */
-#define EPOLLET (1 << 31)
+#define EPOLLET (1U << 31)
 
 /* 
  * On x86-64 make the 64bit structure have the same alignment as the
