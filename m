Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZprQyqGPb459WcKqyZHhM89tdz6Rnj4hAbAXOyzRJniKknylQGpaa/521mm3zMhx5YHVgcS
ARC-Seal: i=1; a=rsa-sha256; t=1526937500; cv=none;
        d=google.com; s=arc-20160816;
        b=l6kF2M5iaUvXz4wxf8nF+DEqEnsxI3cLPW/e9+PSbCU46d1tvnXJp78BTdQazCFnFy
         Lxby9+yOpN+d6TOzbuoc4EKEEDfL3WaqEx0YGTRKEP7hAM2CAiWtBDSmFoJVEQxy/bPi
         PGZ2M/g+cMVKovEiFd340ZeFlPxU508VTPLfHH5bSToUzFuUqVPe1VJlIHkGKPrsoddI
         M4/dq/EnXMSj9RCPcye14k7QKRgk8cgUmvwEKyUR5GMTHn9hvDefbHoyOGyV1FTj/Vra
         rkEX4CTnv5qjgj3oS37ygPj6k1GrPKbrG8g6pG/3fIeGqFzVnWazSQA4UqJ1ZQ8sinf4
         Azqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wjNcoXoYTYFgt0K6+q3cFP/Uflgw6HjpgHHlicWxvp4=;
        b=TRzJkEvgkvfsnS36XvYiYvjQUE2aCXUh2HPP/riY8WsIETZxpRe69X8ep6vAT0/1Wv
         rLa7/oVEDC3pvGa9Ch6E3+zYPzBet/AKfxnGoQz714MTSCqF7TuRBkX3JBZ4kleC7bdG
         HS3f8cQJrrX2QpWw6NW8ZMu2ejfNL8ZDIEIklg2q0xYcC3hroTJ33Ef9WuZWwOxFSq19
         60C2oJCQd40PUjhEw9l3TK6BSKELI6oevTPjOO50sKxRQnpuGfW3HXwOimA4yao4kDLm
         wdZEkMcBnwbeFDbfIm2eaIGw3g+qw4BBdpihDCmx339kglkftvLEZUY1Daa6xuvnzyQQ
         1RBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=o/PLEDzx;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=o/PLEDzx;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 4.14 17/95] tee: shm: fix use-after-free via temporarily dropped reference
Date: Mon, 21 May 2018 23:11:07 +0200
Message-Id: <20180521210451.210684927@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110016429100028?=
X-GMAIL-MSGID: =?utf-8?q?1601110016429100028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit bb765d1c331f62b59049d35607ed2e365802bef9 upstream.

Bump the file's refcount before moving the reference into the fd table,
not afterwards. The old code could drop the file's refcount to zero for a
short moment before calling get_file() via get_dma_buf().

This code can only be triggered on ARM systems that use Linaro's OP-TEE.

Fixes: 967c9cca2cc5 ("tee: generic TEE subsystem")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tee/tee_shm.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -203,9 +203,10 @@ int tee_shm_get_fd(struct tee_shm *shm)
 	if ((shm->flags & req_flags) != req_flags)
 		return -EINVAL;
 
+	get_dma_buf(shm->dmabuf);
 	fd = dma_buf_fd(shm->dmabuf, O_CLOEXEC);
-	if (fd >= 0)
-		get_dma_buf(shm->dmabuf);
+	if (fd < 0)
+		dma_buf_put(shm->dmabuf);
 	return fd;
 }
 
