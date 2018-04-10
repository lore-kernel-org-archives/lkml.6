Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49lbwSv381F/7+q4N5BDXOi1obtMfspMRccZb7uPdSB7NeBeCba89bpifL1AJbDKUIriNss
ARC-Seal: i=1; a=rsa-sha256; t=1523399836; cv=none;
        d=google.com; s=arc-20160816;
        b=SqdRMSOiBcBA3YOx7BaVrnHU/linZe4L0AgO3zjy69+hoeYqkM0bII1ACPT/WNE4Kr
         soTxQ8zfPASG15IZn0WZJI8beOBse+gw+ZQEHM4y64urau7XjFa7NSHZ97FZo5TPpDTl
         G0VQ/B4xKs0JugvmVrZH0mOSlh3FEag/knogUu2Dq67sGoyLRF3EQLRutPlMHA2pd3SU
         nAKx1kFzNz4GebVP8g8xML8MJwFqzLnNC5Z5r78XkLEwNO3wFSRhwnazNkQM0JTYy4gF
         EASf/J6gqaR1zZQuE05QSnju1yeRYtLNic21pOKKbHT359yk479g6cikbgziiDDrojXJ
         xhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oYCLZK1n3yUP+YlLm7ClBpGddT5Eeay0eXuZhO4y45Y=;
        b=hRsb8QH+Ib9hFkwK0B/IFckR2HbDyrunQNajikt+DTNf/nfCidv+BHPnAQPEiCUP+v
         RpXkpYFS51duZtXmWxWOq1bcRDAUR4pKU0Mg1QPa2LVL8GNTXhJbclX6qmY7l2p2Pa3/
         Ov/cG9MDa2sp59DbY14MpKAf6d1c9hNe2lr0u+IwngtI3XkZaWAuLpSdHlwcsM/oq8QX
         xDdbAn640zB8pRPGcplt+gyBv2crc8o20wwmSsE483X0TqdUhR8EcC+BuAZXV58wvD1k
         jBqeJ13Nlk9VQWaW/swNjo2A0WJniZuWDsd67qHHF4DllBLnkhp5LejNT/Ubn7ciFOj1
         9AGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Christie <mchristi@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 081/138] tcmu: release blocks for partially setup cmds
Date: Wed, 11 Apr 2018 00:24:31 +0200
Message-Id: <20180410212911.554748451@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400083377091029?=
X-GMAIL-MSGID: =?utf-8?q?1597400506857510196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Christie <mchristi@redhat.com>


[ Upstream commit 810b8153c4243d2012a6ec002ddd3bbc9a9ae8c2 ]

If we cannot setup a cmd because we run out of ring space
or global pages release the blocks before sleeping. This
prevents a deadlock where dev0 has waiting_blocks set and
needs N blocks, but dev1 to devX have each allocated N / X blocks
and also hit the global block limit so they went to sleep.

find_free_blocks is not able to take the sleeping dev's
blocks becaause their waiting_blocks is set and even
if it was not the block returned by find_last_bit could equal
dbi_max. The latter will probably never happen because
DATA_BLOCK_BITS is so high but in the next patches
DATA_BLOCK_BITS and TCMU_GLOBAL_MAX_BLOCKS will be settable so
it might be lower and could happen.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/target_core_user.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -796,6 +796,13 @@ tcmu_queue_cmd_ring(struct tcmu_cmd *tcm
 		int ret;
 		DEFINE_WAIT(__wait);
 
+		/*
+		 * Don't leave commands partially setup because the unmap
+		 * thread might need the blocks to make forward progress.
+		 */
+		tcmu_cmd_free_data(tcmu_cmd, tcmu_cmd->dbi_cur);
+		tcmu_cmd_reset_dbi_cur(tcmu_cmd);
+
 		prepare_to_wait(&udev->wait_cmdr, &__wait, TASK_INTERRUPTIBLE);
 
 		pr_debug("sleeping for ring space\n");
