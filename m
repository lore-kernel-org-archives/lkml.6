Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrfZUKMc7dBQj8Jk4wOu3LUS4kF0WsXhxhgAbMQ/V0dSuEQl8TYVXBhQLJ9MPCfidVhAtb/
ARC-Seal: i=1; a=rsa-sha256; t=1526937826; cv=none;
        d=google.com; s=arc-20160816;
        b=JiUOA5ULLjcKFP4il83DOXB1A0Raa5FN1qu2ays6K9SztJNvu6JtwNR/Xhjs766iHn
         zpG8d/mudnoBMz0ySixN/gb6iIcqIOJU+mSXj3h7G4MFreEW1+t/DD1FJVOodrNCQPaU
         K8oKPn1bXBsPgeyxbPJvMf4wR+becWgZOYRGN72qLQ7TuIkjOMgHPb8pk668Hau1uKQV
         w6+JQKbHnTDoD0p9vReyfnmIvfAbKnfuTunYlFxde5M1GolQ98eX158mfFsvQ86wgVLI
         axYqDogKUa13WdlAaIZzzZX6dq0i0it0qX6y1qtm1t48gGh40oT5AVYVpoxQnMDObn3u
         koYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=5rce2/XRSA0YyYce8GaCpIVvsm20ccOr3ZlQ4zQE3MU=;
        b=kzNQu1QuoQY1QPsZ0VxKiV0p6njs1Z+07epUUzC7YMNf60B9p3K2IVHy7T+8R6zNvp
         J0Ds4diz83o+k+/Nc8NPYK8XQSVhyNhbMc8l0bcJiee2fcvsjya2CeyOr3B0bNY2BbaQ
         peouZLYLzSRGC0kXI0zk1cdXPG005I5LGu8fPpizGaqkhCwzPqSBMaAnidDlk+i/2Kvn
         Z+u+aKfcVK8w89HzdiYPI2QF2GbzOdyLoNknHfha3D5BWMhBIXJBhcoi27DlfIAAwW1E
         x3uHbAGE52U6fOoEbjWk1XTAiNZHZ0FNZ30TaAhwBP0pmuCbisAP0YmIe/b28re6Ife2
         Nlag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=yY1HFOi6;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=yY1HFOi6;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 040/110] s390/qdio: fix access to uninitialized qdio_q fields
Date: Mon, 21 May 2018 23:11:37 +0200
Message-Id: <20180521210507.606013066@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109872569829997?=
X-GMAIL-MSGID: =?utf-8?q?1601110358130238174?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

commit e521813468f786271a87e78e8644243bead48fad upstream.

Ever since CQ/QAOB support was added, calling qdio_free() straight after
qdio_alloc() results in qdio_release_memory() accessing uninitialized
memory (ie. q->u.out.use_cq and q->u.out.aobs). Followed by a
kmem_cache_free() on the random AOB addresses.

For older kernels that don't have 6e30c549f6ca, the same applies if
qdio_establish() fails in the DEV_STATE_ONLINE check.

While initializing q->u.out.use_cq would be enough to fix this
particular bug, the more future-proof change is to just zero-alloc the
whole struct.

Fixes: 104ea556ee7f ("qdio: support asynchronous delivery of storage blocks")
Cc: <stable@vger.kernel.org> #v3.2+
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/qdio_setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -141,7 +141,7 @@ static int __qdio_allocate_qs(struct qdi
 	int i;
 
 	for (i = 0; i < nr_queues; i++) {
-		q = kmem_cache_alloc(qdio_q_cache, GFP_KERNEL);
+		q = kmem_cache_zalloc(qdio_q_cache, GFP_KERNEL);
 		if (!q)
 			return -ENOMEM;
 
