Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+U2yRMNUtROqSVmGXst1A6eZPumCo35H0TeB8SEgcL1nVZckfpeadL0rdemZhivPWU/5jN
ARC-Seal: i=1; a=rsa-sha256; t=1522346853; cv=none;
        d=google.com; s=arc-20160816;
        b=DGVq37ff8a55PVWW1a9RSZT89/0VTv5brjb1CIu4Crg9O6eQG/A89kfcE5SNBMKque
         30JQNvblY/9ob0yUtZ1NAo+7MXYXotSqb51v0Bp2JmidoOhpLPz2vZlMPDUiikBUZ1xU
         zpcF0F7Iv3z/uUZMP07WvDczCb4LGir9fJGbOImOKVbXwSORai0U3tyB9b+HkTxrVUCi
         7kMfOdigWzJZz5iZhcLLG+6+Zrz9OsacqnW0asNoeL7XQ8gyturo7JNSd8MiM9TjjvMa
         3xlH3Mloz74snAh6E0uMxchoQrVpnFdevYPq09Un3qMuM7kv7H6Bhj38DzqtzjfYhE6t
         Fyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WuWgu9vwWJpSBg987+q6nQm6OB5cpCwzk2Ju+F/lmyw=;
        b=c4E0up2kZHhQT2ibv92PPjhk2BmmoqA17VtoI+DquWbA3rTYDDHjUnZJDg9mczAoqp
         2G5hCy6lJX+6vCx6wUcl+hfU789JpgiTX///Zh6WRbOASJGW/9eTa7OGTAlF6VjK7JZa
         jwe5RkOHzQyUtPmVbwDEjR9S4bddKzrE4qwBoMJKYHNPqnhowCnSsLLtSK4xxGcnZZaz
         2YJBnhDdCvlnFYf32wNKu0PiIbAmRtkTAcwCFnKeBQlRjW0fQhF0gfL7OhhOb+zDqC4g
         hVpUuE/fqHEeugMBiKliZnIXQ3UevQtXOwcOskS8mlMNF8SQWR+I0Ofpyz8rJg7Bi7y0
         Q8tA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Andrey Konovalov <andreyknvl@google.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Doug Gilbert <dgilbert@interlog.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH 4.4 01/20] scsi: sg: dont return bogus Sg_requests
Date: Thu, 29 Mar 2018 20:00:37 +0200
Message-Id: <20180329175741.949669985@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296289036439826?=
X-GMAIL-MSGID: =?utf-8?q?1596296374432949148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

commit 48ae8484e9fc324b4968d33c585e54bc98e44d61 upstream.

If the list search in sg_get_rq_mark() fails to find a valid request, we
return a bogus element. This then can later lead to a GPF in
sg_remove_scat().

So don't return bogus Sg_requests in sg_get_rq_mark() but NULL in case
the list search doesn't find a valid request.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Doug Gilbert <dgilbert@interlog.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Doug Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sg.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2074,11 +2074,12 @@ sg_get_rq_mark(Sg_fd * sfp, int pack_id)
 		if ((1 == resp->done) && (!resp->sg_io_owned) &&
 		    ((-1 == pack_id) || (resp->header.pack_id == pack_id))) {
 			resp->done = 2;	/* guard against other readers */
-			break;
+			write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+			return resp;
 		}
 	}
 	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-	return resp;
+	return NULL;
 }
 
 /* always adds to end of list */
