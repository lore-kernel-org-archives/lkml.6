Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs8tIg7nzP6zy1FciczyGYe/1+f7W5/GADdD///8akE6quzn/tX/x4c1mbBg6BpUFj1Em5x
ARC-Seal: i=1; a=rsa-sha256; t=1521484229; cv=none;
        d=google.com; s=arc-20160816;
        b=UlRz0jkrCIClEl8tVYmq2wrrZ5TLAFLVYYbDxC6mlrYw4hSUSvP4/Oh35xbEEEqsc4
         x0IUxKPQJqJMgpxuq12Cy4qOL+t8Cz0O7r4WUaA4zV7/ZyZHOLxwqaQmrYu/vMMbfLKg
         xEih2ltPtF0VUZUGkmRZUoBThq0Nh1fhrVfPyDaFxn3fQwgHP07RdIs7CTJAS9b4+aAJ
         mtbrubcusA0keMpGG4NP95OLYb7CrxA4EvskMoBpYlcKSBeCE0BGd5BuP4phiyl+Zmvw
         Ml1IdpFe+NWFY9zC6KSy5x2n4VVNrvKJfFOyxw0siwjpMUF+ujNpKSzM40xLg0s0MKQg
         YDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yQ7LlL5d3swEk0ATKOSNO0igcrm1mXeRTnnoqPin0hg=;
        b=SHSlh08dxK7PNHB7SkIcCnv8RYWiAMBmB2caL6qG81HqUZ1y3QAsA9hfJCrj3nQPSI
         s0VzbXU7MaE+IlvgzMmQYlZHHgDEW9atFvarEKUsoQUequf4cs3KXR8wkTGwvJw6tg88
         TzqZdY7hw5Mmh9W52bzmJSz4wUlUDO8oO1ZcmAL8tJV3qzhwkeYsPEwyZOEbNmYTDQ3u
         Tc3XiN+UEPuA/1kxWUX8kDE561E3YGTlYEiw93ilp0rmgeKHfed0dR8WD3jUrScxXH6v
         BELDphJoThyaLv5NBVMwLHqW+zsYRX7C9VRUO18967dZStFZbWWKewtFFbOI7Q1evF7M
         bLCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 36/41] scsi: qla2xxx: Fix smatch warning in qla25xx_delete_{rsp|req}_que
Date: Mon, 19 Mar 2018 19:08:36 +0100
Message-Id: <20180319180734.567154127@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391847425293288?=
X-GMAIL-MSGID: =?utf-8?q?1595391847425293288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Himanshu Madhani <himanshu.madhani@cavium.com>

commit 62aa281470fdb7c0796d63a1cc918a8c1f02dde2 upstream.

This patch fixes following warnings reported by smatch:

drivers/scsi/qla2xxx/qla_mid.c:586 qla25xx_delete_req_que()
error: we previously assumed 'req' could be null (see line 580)

drivers/scsi/qla2xxx/qla_mid.c:602 qla25xx_delete_rsp_que()
error: we previously assumed 'rsp' could be null (see line 596)

Fixes: 7867b98dceb7 ("scsi: qla2xxx: Fix memory leak in dual/target mode")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_mid.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -582,8 +582,9 @@ qla25xx_delete_req_que(struct scsi_qla_h
 		ret = qla25xx_init_req_que(vha, req);
 		if (ret != QLA_SUCCESS)
 			return QLA_FUNCTION_FAILED;
+
+		qla25xx_free_req_que(vha, req);
 	}
-	qla25xx_free_req_que(vha, req);
 
 	return ret;
 }
@@ -598,8 +599,9 @@ qla25xx_delete_rsp_que(struct scsi_qla_h
 		ret = qla25xx_init_rsp_que(vha, rsp);
 		if (ret != QLA_SUCCESS)
 			return QLA_FUNCTION_FAILED;
+
+		qla25xx_free_rsp_que(vha, rsp);
 	}
-	qla25xx_free_rsp_que(vha, rsp);
 
 	return ret;
 }
