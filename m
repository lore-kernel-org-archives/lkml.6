Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48q+/3eV2B40SDloqMqdglPkZgrEhMyrPhb5Aje8DqtDTKjC5563eFR0v4i5Rb4IPHbCf42
ARC-Seal: i=1; a=rsa-sha256; t=1523473425; cv=none;
        d=google.com; s=arc-20160816;
        b=viWADR9v60MMFlQTTLmf4mkas5voe76lBkcO32NwGPpjtU2wRjDhXXEMAdu/jXFavz
         UbVpesJopAMEcWBL3NgrtpDeq2XoVIGfvUgzW7Gf1N4Un+0afNQs51I7fyq+a6h7k+XH
         ie3h4xYjLyFqHLeGMFbDP6mHRwDjCh/RMUHlsp1T2crq7nDsinCngVFkaw316k4iQlBa
         qCcvLuzx/hZVTj5uF4IaYyhuOkcCtI3yjbYA8YBcgocrARLXw0fXXw/iFNJdMnSkHTOm
         7P8HD/nNSmhEAnBaITrndxMQ9MD+DW+INVCgAWjCA/z2ibL8aLNEieBKDEM3/J5kPdSY
         VUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bCEfoGLl6jvDCKlBy24evDAuWtpceRiH/ldLkfL4F/s=;
        b=qWyAnmyjkuzyaBWeNxO4dg510TF+V3OEq3UE7OE7D9ivuRgjf7PKG5arhTC7SZsIl9
         TO/bPD3Fkya+phWbg4vXlPA+/J4Vd0um+u9VjccXwNy6aNuh+iDn7Iohb4yqDeKHHZYl
         GAj5KNskGOzrOwT1J8RlTvSGNoD16wD8GCUU7/Cfn5c8QrV7jcHQq+9lA4quwMbOFCfj
         /Fx8JLUQMnPZFoFq9FSJLe9BDfe5PrSkCv6f1kvx/6Eds2sr7ZfAyZ35/EcmcR3VglSJ
         FXiZj5LLd6zeXSrRmw3RZX9gbue5FrlhP+FRoiOFQkJ1wBhAcmhV8RWLPh/S0CN3VDFe
         N/Fw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Netanel Belgazal <netanel@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 242/310] net: ena: fix race condition between submit and completion admin command
Date: Wed, 11 Apr 2018 20:36:21 +0200
Message-Id: <20180411183632.888271625@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477670921492479?=
X-GMAIL-MSGID: =?utf-8?q?1597477670921492479?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Netanel Belgazal <netanel@amazon.com>


[ Upstream commit 661d2b0ccef6a63f48b61105cf7be17403d1db01 ]

Bug:
"Completion context is occupied" error printout will be noticed in
dmesg.
This error will cause the admin command to fail, which will lead to
an ena_probe() failure or a watchdog reset (depends on which admin
command failed).

Root cause:
__ena_com_submit_admin_cmd() is the function that submits new entries to
the admin queue.
The function have a check that makes sure the queue is not full and the
function does not override any outstanding command.
It uses head and tail indexes for this check.
The head is increased by ena_com_handle_admin_completion() which runs
from interrupt context, and the tail index is increased by the submit
function (the function is running under ->q_lock, so there is no risk
of multithread increment).
Each command is associated with a completion context. This context
allocated before call to __ena_com_submit_admin_cmd() and freed by
ena_com_wait_and_process_admin_cq_interrupts(), right after the command
was completed.

This can lead to a state where the head was increased, the check passed,
but the completion context is still in use.

Solution:
Use the atomic variable ->outstanding_cmds instead of using the head and
the tail indexes.
This variable is safe for use since it is bumped in get_comp_ctx() in
__ena_com_submit_admin_cmd() and is freed by comp_ctxt_release()

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -232,11 +232,9 @@ static struct ena_comp_ctx *__ena_com_su
 	tail_masked = admin_queue->sq.tail & queue_size_mask;
 
 	/* In case of queue FULL */
-	cnt = admin_queue->sq.tail - admin_queue->sq.head;
+	cnt = atomic_read(&admin_queue->outstanding_cmds);
 	if (cnt >= admin_queue->q_depth) {
-		pr_debug("admin queue is FULL (tail %d head %d depth: %d)\n",
-			 admin_queue->sq.tail, admin_queue->sq.head,
-			 admin_queue->q_depth);
+		pr_debug("admin queue is full.\n");
 		admin_queue->stats.out_of_space++;
 		return ERR_PTR(-ENOSPC);
 	}
