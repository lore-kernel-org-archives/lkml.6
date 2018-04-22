Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49/eJwvBVhD/OyhVSe8eh102ebOYCF9d1rrFFnZLcVf9rgeoY3bFUOnsjf2VVwkwRtbheLy
ARC-Seal: i=1; a=rsa-sha256; t=1524406359; cv=none;
        d=google.com; s=arc-20160816;
        b=s3cmHr269duxQeEePsxsGhOVa5oGKIcL2vWW1eHmmeVl5ZgDqa7kQijkIEs/yH8jC0
         oieDTv26f6HfnI8fyov8lSmcarFkjL4SwHcjuSxweGg+O/uhUHV84hQYU/wt/I0QtHEK
         xVkBC4VswDT2BlrPtRHVAvkOaQJw7M8JqFSPTgdh5mqBlsLjx9xvTeRaZWOfefJVVErh
         O3hvKSctCNOPtUPrrRngibQQvYMd/v3XHJAKnG5nnYZXNAo2ykv8KhIOwOGRZW9X5Srz
         cApJkfdDLtVM2RZJePraaJNL5P+Y/Zc7Co6amoUAaBxfa4k2DslF/hl0AVLQJSBDRrS/
         rxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZZNC5X92Kjz363YsjTBmSAtFC+o1cP1hTio8dH/RNCU=;
        b=xWwc1EeazN5439uZVWbCPQ+LuoHFKmKo2BbQZVQetl26eDfBKAH1vWooAxbyWxXhFw
         sEmYJfJvoCQBwKWy3kv1aVWFMMz8bgE7MjoW/TkB2Q5d+2JlVHgK+A29q+bARS30K3WV
         Qo2wqiILO+Ym+fe/RuVJoSSegYIqj0wNHKy9pmjAoN7RS/+zydBAu5syh/jQGuR6CnWW
         XKV1HKKArQ8dbUyMclBd1ZUHo/Jxa+4C6hHcsO3TR8aIEgSnWvFt2fBTpIy1X2SAhNRk
         psRvANySvXu8qd3xf0e/i5XXlGC1ERXU9r9moW36BrbFQom0eU8Z77StV5qAUJOKnGLX
         nFag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.9 42/95] IB/srp: Fix srp_abort()
Date: Sun, 22 Apr 2018 15:53:11 +0200
Message-Id: <20180422135212.138989249@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455092179886788?=
X-GMAIL-MSGID: =?utf-8?q?1598455923278426115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit e68088e78d82920632eba112b968e49d588d02a2 upstream.

Before commit e494f6a72839 ("[SCSI] improved eh timeout handler") it
did not really matter whether or not abort handlers like srp_abort()
called .scsi_done() when returning another value than SUCCESS. Since
that commit however this matters. Hence only call .scsi_done() when
returning SUCCESS.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srp/ib_srp.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2626,9 +2626,11 @@ static int srp_abort(struct scsi_cmnd *s
 		ret = FAST_IO_FAIL;
 	else
 		ret = FAILED;
-	srp_free_req(ch, req, scmnd, 0);
-	scmnd->result = DID_ABORT << 16;
-	scmnd->scsi_done(scmnd);
+	if (ret == SUCCESS) {
+		srp_free_req(ch, req, scmnd, 0);
+		scmnd->result = DID_ABORT << 16;
+		scmnd->scsi_done(scmnd);
+	}
 
 	return ret;
 }
