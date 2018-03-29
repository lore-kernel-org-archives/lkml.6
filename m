Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/2BuK9dGzNu66rnt2sc698pRY/xMKSPAp1LTzW8V8YnTf8n1xRdpnw/hMOGA5hHpiddbu2
ARC-Seal: i=1; a=rsa-sha256; t=1522346772; cv=none;
        d=google.com; s=arc-20160816;
        b=mCRtBUrJ2E1ttgZPFVGOJexBHsWwAYU+03W/wBostMeU8qR8pMXUM07e4b76ude9Qj
         fyEssqou4peQZpjT/xZKhRNg6icUOYOVKBmXWqIpnApw+3CxCvb197SoOSSo4QptY24h
         p4Ug4cJJv6KUmt8w07Fiscsire1EK8olG66D4URYt8+9BcnL3yyIs5/yVpyvHtBlyWuh
         Knxsheojx88XSj3VPCtbujlJVeIHoQfkNQRAl2P1ryBT4kC+z5chczmi/yT/d4YvgOYO
         pOhfr+boD/3c8kTXCaoQDC22kITyp6nYD4DZGXtGjXtWzSZrH+xkybxiRX40qkM5um/r
         X4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RNcAw6OJBoX7k/o/vAmPgBuBFrVvRpX+MESD/3aJskU=;
        b=0rGxS0OEWu6q7rQiyCBgM4gtIGE7Y1qKu+qzdB9lLWil5gf+Dis/BysqqZE2oBLH2M
         lY9d96623VK/0g2lGIh5L2E6HxfJIEPfc3/wkBYp/4IMooBojfSmR7nr0GetxQmyqTFF
         D9TQjq2EsAJszVrHzKQcOuBU8xeN9a5yu/kLonvSu+vlM09xN2u9mtMzHGX3x4LJGiEc
         /9XK3OHnBDwPO7YFNPTxyDGzJPy9+/1g1qEFHnqAoOItlzmVyKQl5aNQiJXmWmKK3Ix+
         ID9//sq8SShIgdibfh5dinTlI1NFOSe8CKrKSoLewTrSlBPZcPaiv6SKDn2PLO0DedWv
         iKDg==
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
Subject: [PATCH 4.9 01/28] scsi: sg: dont return bogus Sg_requests
Date: Thu, 29 Mar 2018 20:00:20 +0200
Message-Id: <20180329175733.628549584@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296289036439826?=
X-GMAIL-MSGID: =?utf-8?q?1596296289036439826?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2064,11 +2064,12 @@ sg_get_rq_mark(Sg_fd * sfp, int pack_id)
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
