Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226ITqFD4iM2SEAY45/RnamjmZbtjV4R2M68vpA47qLH2io/Eu5tb5i1I92g+hgUmYV/RTz+
ARC-Seal: i=1; a=rsa-sha256; t=1518708577; cv=none;
        d=google.com; s=arc-20160816;
        b=God6UXSfElpIO55d+GIfUwo9KoIBUso1Gf+2VxvdNBkalNReG3RHfFdieK5BIRLmwh
         2RVgRg3FAeqgUfEN9Yr9BeESMq1uw0hPtrL60K8uFSlU8jYBmaZP+1X1Ty5LxJFXS2Da
         BO6l/8o64uPkLPqUJAA1hpbfAskai0g6s2xhpSlRH2D7L4HMlYiyEj20AXc9RJScW5jQ
         h6g5SDDgTzBGVQVmhNqRwL0pBRy7TJLVMw3WQFXZcY7oCygV+1kSwBgDEZbT7WLoCTVK
         GOQcWCNS55/K51WROAEthkrVjfvOATGYUTGVzgXxto7Nd6DQXuEsArSYKecrrr6R2SBl
         QfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HAuxF4E8ZQRUwi5Jad6meNSFYwcdSnUlmQl2gmBWVfE=;
        b=k0WJjiyp19XOMKn+dHxhvbq7XBZ1O/fNKqysYDk4iGdYVVhDCF2MnLosA5vqoSUM4f
         Pssq1UVyX+GPY+6ccMqT9DjTF7XETXkZqxcO1aoG6HJ66+jbZWAMb2dJSrrzFJPZqI0G
         sVg3xKEXImveX373REJEh3tbrFIrH6eTD1mmB/tLLIE/sU/C1GeNT28H29k2HBzt6Ht9
         HaRf9gVd4rI7NYaykRhokdpIexrrV62sIIw3VWJgLPz3T/k0KCopun8S/mbksnXKQQfn
         5gvka+rj3JTmQlPFs2zrR+jrUWve/9YHHRC78wj+56UphQNijTMiD72cFH+N2ZSqPo8e
         vRAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zhouyi Zhou <yizhouzhou@ict.ac.cn>,
	Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 63/88] kernel/relay.c: revert "kernel/relay.c: fix potential memory leak"
Date: Thu, 15 Feb 2018 16:17:30 +0100
Message-Id: <20180215151231.342012717@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481365623098658?=
X-GMAIL-MSGID: =?utf-8?q?1592481365623098658?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit a1be1f3931bfe0a42b46fef77a04593c2b136e7f upstream.

This reverts commit ba62bafe942b ("kernel/relay.c: fix potential memory leak").

This commit introduced a double free bug, because 'chan' is already
freed by the line:

    kref_put(&chan->kref, relay_destroy_channel);

This bug was found by syzkaller, using the BLKTRACESETUP ioctl.

Link: http://lkml.kernel.org/r/20180127004759.101823-1-ebiggers3@gmail.com
Fixes: ba62bafe942b ("kernel/relay.c: fix potential memory leak")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/relay.c |    1 -
 1 file changed, 1 deletion(-)

--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -611,7 +611,6 @@ free_bufs:
 
 	kref_put(&chan->kref, relay_destroy_channel);
 	mutex_unlock(&relay_channels_mutex);
-	kfree(chan);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(relay_open);
