Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49N3BKbcY6aC3a6cNTyP3q0+1ZNYvYLXoYV2na7aC/t7+QR196rymPKTsdpaVioLMiX3AUo
ARC-Seal: i=1; a=rsa-sha256; t=1524406039; cv=none;
        d=google.com; s=arc-20160816;
        b=i66LCadF1AVTH8Rio+I6olRQWvVXFHbv57vRC+ZM3EQdRva3vIf1PrSHaSrqN+xJB8
         bzjje41PNii6IfX6zcC/I/YVodPdWoa+AgdAViScwce4OkYO3yZANoHPYdpUBFEachA5
         i3mtJ7qu7gzwKYpu0UpsmFLQ8joDx79841r/Bh8jLkLgzAn1AImc2kUFTJCifqTSKthc
         7gSV4fsQrmmFj2bo1tQIyhESfXuvE8rKPeVctN3obYfZdPyLw3oMd0DqiRsIeyK8kBVd
         jQN0ATiTue788oNoTYyoHzRvQEkp/eMgFyL9AzaH+I/Ju0dC6xiyI/ROBQOM4fr5R1xi
         xvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DBkNWWjL69Lvwqhzi9+gZgyX4AAS+/wn8AcOl4vzRws=;
        b=urzZf4Z4GEXSCXRTAT6E4oturE9IRrfooX0Ep8zeIRcu/crICxk2c951H1Emki5ZC2
         oCn3shUEefQfBfLIBpfC8EKG5WhtT8WeK3pzBiuGfEBY1bHJe+GDUhvokE5og45W8RzM
         6HTi6cQrrKe5B87FYRE4Ahvbsh/cJA4IKkTYNo2GakjgtnpcSO6OGPnO0YrN0H21Bqm+
         XvnYxbt/OQ+qGksJHD2TmhCq9S9eiwxAVjISASNtcm1wMDBwpArbX3jdMQfTE2fyFFlV
         2QDTzHboEAT3hXEHd++hRDT2Q+GJ8cdNUJtV7GWHpesTkBNZrchy2im6lg5D6RRxvn6X
         Le1A==
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
Subject: [PATCH 4.14 090/164] IB/srp: Fix srp_abort()
Date: Sun, 22 Apr 2018 15:52:37 +0200
Message-Id: <20180422135139.111808231@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455092179886788?=
X-GMAIL-MSGID: =?utf-8?q?1598455587287735520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2656,9 +2656,11 @@ static int srp_abort(struct scsi_cmnd *s
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
