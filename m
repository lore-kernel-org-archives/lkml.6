Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48NgylT3JTFtw0++u14F1VXoBVBHEWMlIM8mZK+Ul3AG+Jp/Fu6VgOquK+cVbpr87g0uEOz
ARC-Seal: i=1; a=rsa-sha256; t=1523473129; cv=none;
        d=google.com; s=arc-20160816;
        b=WKkLvvxPh0IT9srn9fv6atvuhgkk87v6RYFunMOMZdqh5ZIDZMtBU7n+UlN7DrRqNF
         S5y9Mur9wEKv+nZc5jxMvwJUd4DrFRq4Jz8c19Rj19uBBo6+VLFxLPSOh9oxXdCMzjNN
         Yed1sgcsyuiHm8mOiGMIu80jiYx2feUBkkIfIHXRjMBCYlJ8IfuwYwrXBsB32CEAD/vB
         /XOKVGsLcyw8pW1RJKID7U2loeXqTpdDYW2cuEslWXbiCQ7w3Kpm2sRge9PJf8M2Mzpj
         KXFSJc8atIPT/L87rbOtHia+qCbE1f7XULbI+uQkXW+32mJgux8APlQdD4UlqdiZEQGj
         VS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6p2INwaVB7CJ+IgP/r7uspESiJP5bARXuutw5OnFUHM=;
        b=EOwvhhdaWB7PV3INCI1xhBwJDt8+DrBvQUqYqAAZXeE+ryJQCwgwKuEf2ilhNCflFH
         aUGGoAWWf8CiB/XIZduu+fcxllOETTuOcgjuS2d+4F7iP5xw4Ye3qFqOS/CMmyQ/VcBO
         Idi40S9+vqyx7s9ZOmfIItnac6E1fivK5toXHwm+E8mokvxSQC8HIXOzz8N+HcMQaD/6
         MC516OBsdWMDoUlhQIAdbXH4MWgRivI4Wb/gXPZn4c4TUsbmDfVW6gJCWfJ0/GJqsJxy
         UcZ3ghKcN0QLDs4z6sgfcp85lXQdJtbi1NgnuLFbPx/r7Iid+T3UaDgqCQBLgLmYOicW
         3VDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maurizio Lombardi <mlombard@redhat.com>,
	Chad Dupuis <chad.dupuis@cavium.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 105/310] scsi: bnx2fc: fix race condition in bnx2fc_get_host_stats()
Date: Wed, 11 Apr 2018 20:34:04 +0200
Message-Id: <20180411183626.735524927@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476148506229450?=
X-GMAIL-MSGID: =?utf-8?q?1597477360663336085?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maurizio Lombardi <mlombard@redhat.com>


[ Upstream commit c2dd893a3b0772d1c680e109b9d5715d7f73022b ]

If multiple tasks attempt to read the stats, it may happen that the
start_req_done completion is re-initialized while still being used by
another task, causing a list corruption.

This patch fixes the bug by adding a mutex to serialize the calls to
bnx2fc_get_host_stats().

WARNING: at lib/list_debug.c:48 list_del+0x6e/0xa0() (Not tainted)
Hardware name: PowerEdge R820
list_del corruption. prev->next should be ffff882035627d90, but was ffff884069541588

Pid: 40267, comm: perl Not tainted 2.6.32-642.3.1.el6.x86_64 #1
Call Trace:
 [<ffffffff8107c691>] ? warn_slowpath_common+0x91/0xe0
 [<ffffffff8107c796>] ? warn_slowpath_fmt+0x46/0x60
 [<ffffffff812ad16e>] ? list_del+0x6e/0xa0
 [<ffffffff81547eed>] ? wait_for_common+0x14d/0x180
 [<ffffffff8106c4a0>] ? default_wake_function+0x0/0x20
 [<ffffffff81547fd3>] ? wait_for_completion_timeout+0x13/0x20
 [<ffffffffa05410b1>] ? bnx2fc_get_host_stats+0xa1/0x280 [bnx2fc]
 [<ffffffffa04cf630>] ? fc_stat_show+0x90/0xc0 [scsi_transport_fc]
 [<ffffffffa04cf8b6>] ? show_fcstat_tx_frames+0x16/0x20 [scsi_transport_fc]
 [<ffffffff8137c647>] ? dev_attr_show+0x27/0x50
 [<ffffffff8113b9be>] ? __get_free_pages+0xe/0x50
 [<ffffffff812170e1>] ? sysfs_read_file+0x111/0x200
 [<ffffffff8119a305>] ? vfs_read+0xb5/0x1a0
 [<ffffffff8119b0b6>] ? fget_light_pos+0x16/0x50
 [<ffffffff8119a651>] ? sys_read+0x51/0xb0
 [<ffffffff810ee1fe>] ? __audit_syscall_exit+0x25e/0x290
 [<ffffffff8100b0d2>] ? system_call_fastpath+0x16/0x1b

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Acked-by: Chad Dupuis <chad.dupuis@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/bnx2fc/bnx2fc.h      |    1 +
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c |   10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/scsi/bnx2fc/bnx2fc.h
+++ b/drivers/scsi/bnx2fc/bnx2fc.h
@@ -191,6 +191,7 @@ struct bnx2fc_hba {
 	struct bnx2fc_cmd_mgr *cmd_mgr;
 	spinlock_t hba_lock;
 	struct mutex hba_mutex;
+	struct mutex hba_stats_mutex;
 	unsigned long adapter_state;
 		#define ADAPTER_STATE_UP		0
 		#define ADAPTER_STATE_GOING_DOWN	1
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -670,15 +670,17 @@ static struct fc_host_statistics *bnx2fc
 	if (!fw_stats)
 		return NULL;
 
+	mutex_lock(&hba->hba_stats_mutex);
+
 	bnx2fc_stats = fc_get_host_stats(shost);
 
 	init_completion(&hba->stat_req_done);
 	if (bnx2fc_send_stat_req(hba))
-		return bnx2fc_stats;
+		goto unlock_stats_mutex;
 	rc = wait_for_completion_timeout(&hba->stat_req_done, (2 * HZ));
 	if (!rc) {
 		BNX2FC_HBA_DBG(lport, "FW stat req timed out\n");
-		return bnx2fc_stats;
+		goto unlock_stats_mutex;
 	}
 	BNX2FC_STATS(hba, rx_stat2, fc_crc_cnt);
 	bnx2fc_stats->invalid_crc_count += hba->bfw_stats.fc_crc_cnt;
@@ -700,6 +702,9 @@ static struct fc_host_statistics *bnx2fc
 
 	memcpy(&hba->prev_stats, hba->stats_buffer,
 	       sizeof(struct fcoe_statistics_params));
+
+unlock_stats_mutex:
+	mutex_unlock(&hba->hba_stats_mutex);
 	return bnx2fc_stats;
 }
 
@@ -1348,6 +1353,7 @@ static struct bnx2fc_hba *bnx2fc_hba_cre
 	}
 	spin_lock_init(&hba->hba_lock);
 	mutex_init(&hba->hba_mutex);
+	mutex_init(&hba->hba_stats_mutex);
 
 	hba->cnic = cnic;
 
