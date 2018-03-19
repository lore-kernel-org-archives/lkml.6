Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuVP6o5u9enCIfHHUb9j8+QtA1Lf879KT5+hTefmkkp6XnY1YCIULNUBEf2hR9gnPZ97zxx
ARC-Seal: i=1; a=rsa-sha256; t=1521484118; cv=none;
        d=google.com; s=arc-20160816;
        b=JgCX84l4MvuloMaHsBaT7YmXdSPCezQgqFMeZdq77dtcMIk0yCCUmsuDcm5wnpV0yx
         yJVKlW/dg+weDumAHCU3r+UutHCwM0ZKWhBm8BvLsLLzQXIXuxAeI6deKSF1I7BZjm0U
         ZRjNgviYVL8gaj7hMhI5ju5qEeijC+n2HAYLQa3LIJY8rJkUf+HrUl5gZu1BoEK9C42p
         zB2cc3Nd3mysxl9xiYeZ93ZoABkBsNzn0DLTx54NJMXSOB9Dymlrh2qUL+9/dbqmu4Zf
         GH697Qu6jSjM3j1rW7aTRLH2gY19PdCb+iXMooSqXkMQrhLobisXs3qNgbhbGcclbuwK
         lMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kgsK934LiN1ZjexkJLUUlRzVwGnX52RMUqUdGPRl4xQ=;
        b=N/HpWxeN/xLPiigXo5YXJerDIvVtlKsT7iUeq8fOYrUQvOBzD4ZKTEkS809+4CbC4t
         ngem/l5hIayPNT9YAh0ULZgPZSC00n444K5od0NAc+0Pm10OOlP96lBJ/PZ51C9Eakop
         tR3FuLSifgX0+5PgGKZX8pOS6E5jcnxtS1EZp8inrc+eY3mAXh2sfjDSUz5OSWrdLise
         9tNEGsg+6+nuRddK+zOqHsvHdDJ3/8DjntboFr1ehzO3DELfRCWzA+dAXYN/0d64gWYn
         FFMDEpM1jmkp9OlmG4B8YjeWYtmAPfj3U6LiLV/GlanGNreb44PL5tZwTW0gk5ZZhPaz
         rECA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bill Kuzeja <william.kuzeja@stratus.com>,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 238/241] scsi: qla2xxx: Fix extraneous ref on sps after adapter break
Date: Mon, 19 Mar 2018 19:08:23 +0100
Message-Id: <20180319180801.029399990@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391730970735291?=
X-GMAIL-MSGID: =?utf-8?q?1595391730970735291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bill Kuzeja <William.Kuzeja@stratus.com>

commit 4cd3b6ebff8510b2139d64024411207090cfe0a9 upstream.

Hung task timeouts can result if a qlogic board breaks unexpectedly
while running I/O. These tasks become hung because command srb reference
counts are not going to zero, hence the affected srbs and commands do
not get freed. This fix accounts for this extra reference in the srbs in
the case of a board failure.

Fixes: a465537ad1a4 ("qla2xxx: Disable the adapter and skip error recovery in case of register disconnect")
Signed-off-by: Bill Kuzeja <william.kuzeja@stratus.com>
Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_os.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1443,7 +1443,7 @@ qla2x00_loop_reset(scsi_qla_host_t *vha)
 void
 qla2x00_abort_all_cmds(scsi_qla_host_t *vha, int res)
 {
-	int que, cnt;
+	int que, cnt, status;
 	unsigned long flags;
 	srb_t *sp;
 	struct qla_hw_data *ha = vha->hw;
@@ -1473,8 +1473,12 @@ qla2x00_abort_all_cmds(scsi_qla_host_t *
 					 */
 					sp_get(sp);
 					spin_unlock_irqrestore(&ha->hardware_lock, flags);
-					qla2xxx_eh_abort(GET_CMD_SP(sp));
+					status = qla2xxx_eh_abort(GET_CMD_SP(sp));
 					spin_lock_irqsave(&ha->hardware_lock, flags);
+					/* Get rid of extra reference if immediate exit
+					 * from ql2xxx_eh_abort */
+					if (status == FAILED && (qla2x00_isp_reg_stat(ha)))
+						atomic_dec(&sp->ref_count);
 				}
 				req->outstanding_cmds[cnt] = NULL;
 				sp->done(vha, sp, res);
