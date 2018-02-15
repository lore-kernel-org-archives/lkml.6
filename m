Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2275akX+njxsdhKje0IvznnNXPjkW4VUxBkP1NbP5qqbB872R5Qr79AAIxHcHyXBf11xACig
ARC-Seal: i=1; a=rsa-sha256; t=1518709002; cv=none;
        d=google.com; s=arc-20160816;
        b=gxuv/bEOrstB1mocdZrT3T5Yft2gnfn54A3fgwZiAvojclXG12ackkVzN82MSOC+Ra
         tR/n+/UV+Go1rNVfJJNwr+Vt+pwddvF057mlj/772EXM3kKftzXG+uVqYoCSnjO2jMEA
         5whLCUBzJUlMuHjFENVkdXbf88BCjgnJAG4hJ7ciMVt4R4IZ11qbi1khtOmaDKSuxPrg
         ga3dlwdCLgxZ26xNtayqHxpPIxVYUBTkIfZnVc3Th08NNP6qGGBKMo+EF+wq0hXR6kkK
         l6RLhvUE2vBc0lh5Yd4fWU99FXjEVDKR1fXhIwRaCfIzfqY4q1s8LuwIjOMjz9g8nQWi
         x4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SwN4aCVIL+zGpbOT7moUHI6XCIRJuBn4U0bUtbjuqBw=;
        b=0Tol6fT65Ig0gRU+Fc9Q3nohn6gF0vqWiFx/Otk7UN3vJfhTNjy9U2eGlCps+G1LvA
         f0Gdw7KJMS2/TlpX4Wfjq/k/epLaOVlq3l6lLCZyxTW2zwHwavryjAty4QTOyIKNR7l/
         YdGFpMRy/BbjV58RGlxDc2QOVfM/SLz6OPvVqKy4Yasf4w09+l/EH17zuMusMohijTy4
         nULMCe1tTsdhaCY8Tp9K7E3yRfSFi4PBAFrTaJ03p2Oow4p7VrLUAiT/kO81jXwMePMm
         iNJf1kUwNxZtGTT1tuC+u28GgHBA7eL5KAYYCyermiZJGK9qubyP7bMxeklPMOIJuhyG
         FZ3A==
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
Subject: [PATCH 4.14 154/195] kernel/relay.c: revert "kernel/relay.c: fix potential memory leak"
Date: Thu, 15 Feb 2018 16:17:25 +0100
Message-Id: <20180215151713.596546248@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481365623098658?=
X-GMAIL-MSGID: =?utf-8?q?1592481811173182097?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
