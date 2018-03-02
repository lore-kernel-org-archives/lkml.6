Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtuTafGQxW6jjBTWD7FYDAP4c9H8co9oewxN8rA1+xQYKCLJ5hUGA7Rle57lFvRqq4Iq4z5
ARC-Seal: i=1; a=rsa-sha256; t=1519981172; cv=none;
        d=google.com; s=arc-20160816;
        b=KEtI4kytbFXPmRsSEuQ9dsMFzIh01f0WPmv0yzYc5lnHixfpJPGYMiLAEQ2+mW380a
         TTtlLHu+LAKmmCI3A4ymk6JNFZWmD8Bessy4twB5etZZthwYzhQ0OqfzsBYWRwpDuU5U
         XIQELdNOghfQ3usSTcWdYMzdo6pl0pD55Guesh2UKJDYqAl2I2llXg3G2cwwfYTbo4wO
         StKG2Kj90/YxJG68VcwJllpLoyxZ4ZuCBEtKO3Z7I70YfCnlq5PAwBAtqh7Cwy8C5UFj
         QPcKK7lwmPwVzb5Cqp1BkdThAff1FxK0KjfIpF+eJauFeOrA0pC6DbfgA1Jnxz/TtVeO
         y4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5i7xD7mHh+dhL+HVC2HYB5vMhzg29KHticpLP17goJ0=;
        b=lukMqHV0At+LAKVL81HugPbP4wit52WjBWWUXz4DpcPr23AxoC28goCq4n6Yt4lnoA
         zAakb+Mcknv5iFJ+SOcc0O2l4+9YFd1eBo2FE4uIjeoXKZRrUCla/w2vlS7KuZ0MClzz
         Ssq2+ffuEyPVqmMpF7YNCTdnYi1iU86huTiM734SEHpzUszjZy5LWClWiOQ8/3MKcjqL
         crL85FRCMvrAPvSzD7vRbwfaRSBMDfSP6QPwEvd5PUEwfSTyBFSIHllrYPkyAZWqUZXH
         DGSNkpaJTKwCrhY9QGp3Xb/1aKXag5yldjQnh1c/oMmZLXVNSeqgyJ2S+se0NMhs78bX
         2zVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	John David Anglin <dave.anglin@bell.net>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 015/115] parisc: Reduce thread stack to 16 kb
Date: Fri,  2 Mar 2018 09:50:18 +0100
Message-Id: <20180302084504.486407235@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815778108173461?=
X-GMAIL-MSGID: =?utf-8?q?1593815778108173461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John David Anglin <dave.anglin@bell.net>


[ Upstream commit da57c5414f49ef9e4bcb9ae0bbafd1d650b31411 ]

In testing, I found that the thread stack can be 16 kB when using an irq
stack.  Without it, the thread stack needs to be 32 kB. Currently, the irq
stack is 32 kB. While it probably could be 16 kB, I would prefer to leave it
as is for safety.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/thread_info.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/parisc/include/asm/thread_info.h
+++ b/arch/parisc/include/asm/thread_info.h
@@ -35,7 +35,12 @@ struct thread_info {
 
 /* thread information allocation */
 
+#ifdef CONFIG_IRQSTACKS
+#define THREAD_SIZE_ORDER	2 /* PA-RISC requires at least 16k stack */
+#else
 #define THREAD_SIZE_ORDER	3 /* PA-RISC requires at least 32k stack */
+#endif
+
 /* Be sure to hunt all references to this down when you change the size of
  * the kernel stack */
 #define THREAD_SIZE             (PAGE_SIZE << THREAD_SIZE_ORDER)
