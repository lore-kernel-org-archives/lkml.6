Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt3aE0CQBY1jmpmQMtTaZhO3BkLpXHJ05eQadlj8GihAZQuCLKvxFXbuqEeER+S7r3Au4xt
ARC-Seal: i=1; a=rsa-sha256; t=1521483661; cv=none;
        d=google.com; s=arc-20160816;
        b=asbnDCx7dbrTz3eb/ADuqTlUB9I8np3lhGML2gLESzjRb0rBWkOlFcaL0QcZtn4LYG
         kL6VzRexrD3gxz1eK2xXcWLoK/VXs8ohNfoUesTsyYT4MP9jfqRPgFcR4jzarQJ2FJN+
         IxsBHZU7tShV5e7ngl94TQlxufQqoUrL+L/3q39HvraQ5qec4LAdZ6H6pSQwXXfDmJ8X
         g9Q1jQ0EBkDBHrw4KHxfboB8NQO75RJnnAt8wn4+nsuhOnvfhxqLgFPxKEi0/0P/VVvG
         NQcqtyreyO0yIy41PSJVqX1g4EyfVq7QcS7Hm0v2sYhoLE0VhepNk6ELhR8XtbkOToFt
         WMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0dolgLdlsnFktHgrWxEXxK2M5uIeO7c2MZbVq8j1QzQ=;
        b=jrZsIdetAUH+QOAu+wreGKS85lfGF8QTtSo4X7jqtShCFRxW4AYPBvHGBpcDllG9Na
         70Hu2mL/cdeHbHilj9ssf/5Cq3KI4zHufDT7Geh+eOc6dxzKGUWJY0cvWCX53SbjPwe0
         LCLjnE5ZU7RgyT6AHgZjhKRK6ZeJdeSELe8lUpYWr2H/5ofxUMnJ3Skf0+CzX+r0Rsys
         MwJ0HT2P+njA3C7n3BeLQ0ItXXwMY0ecTuNS4QRvEQiXi4g0yO/ysp9B8yvfjJT1jhpT
         19kpltiw8n8+oa9pH9fGsIxnIyKKgaDmX4S/W+bLTpT0a7ekiOrrQHg1vT013mZHZedH
         WlKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
	Tomas Henzl <thenzl@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 071/241] scsi: be2iscsi: Check tag in beiscsi_mccq_compl_wait
Date: Mon, 19 Mar 2018 19:05:36 +0100
Message-Id: <20180319180754.142621693@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391251922765045?=
X-GMAIL-MSGID: =?utf-8?q?1595391251922765045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jitendra Bhivare <jitendra.bhivare@broadcom.com>


[ Upstream commit eb419229be58dc6d4a3a814116a265908e088c39 ]

scsi host12: BS_1377 : mgmt_invalidate_connection Failed for cid=256
BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
IP: [<ffffffff81332ebf>] __list_add+0xf/0xc0
PGD 0
Oops: 0000 [#1] SMP
Modules linked in:
...
CPU: 9 PID: 1542 Comm: iscsid Tainted: G               ------------ T 3.10.0-514.el7.x86_64 #1
Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 09/12/2016
task: ffff88076f310fb0 ti: ffff88076bba8000 task.ti: ffff88076bba8000
RIP: 0010:[<ffffffff81332ebf>]  [<ffffffff81332ebf>] __list_add+0xf/0xc0
RSP: 0018:ffff88076bbab8e8  EFLAGS: 00010046
RAX: 0000000000000246 RBX: ffff88076bbab990 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff880468badf58 RDI: ffff88076bbab990
RBP: ffff88076bbab900 R08: 0000000000000246 R09: 00000000000020de
R10: 0000000000000000 R11: ffff88076bbab5be R12: 0000000000000000
R13: ffff880468badf58 R14: 000000000001adb0 R15: ffff88076f310fb0
FS:  00007f377124a880(0000) GS:ffff88046fa40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000000771318000 CR4: 00000000001407e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Stack:
ffff88076bbab990 ffff880468badf50 0000000000000001 ffff88076bbab938
ffffffff810b128b 0000000000000246 00000000cf9b7040 ffff880468bac7a0
0000000000000000 ffff880468bac7a0 ffff88076bbab9d0 ffffffffa05a6ea3

Call Trace:
[<ffffffff810b128b>] prepare_to_wait+0x7b/0x90
[<ffffffffa05a6ea3>] beiscsi_mccq_compl_wait+0x153/0x330 [be2iscsi]
[<ffffffff810b1600>] ? wake_up_atomic_t+0x30/0x30
[<ffffffffa05981b1>] beiscsi_ep_disconnect+0x91/0x2d0 [be2iscsi]
[<ffffffffa0202ffa>] iscsi_if_ep_disconnect.isra.14+0x5a/0x70 [scsi_transport_iscsi]
[<ffffffffa02042fb>] iscsi_if_recv_msg+0x113b/0x14a0 [scsi_transport_iscsi]
[<ffffffff811dffd8>] ? __kmalloc_node_track_caller+0x58/0x290
[<ffffffffa02046ee>] iscsi_if_rx+0x8e/0x1f0 [scsi_transport_iscsi]
[<ffffffff815a351d>] netlink_unicast+0xed/0x1b0
[<ffffffff815a38fe>] netlink_sendmsg+0x31e/0x690
[<ffffffff815a03e4>] ? netlink_rcv_wake+0x44/0x60
[<ffffffff815a19e3>] ? netlink_recvmsg+0x1e3/0x450

beiscsi_mccq_compl_wait gets called even when MCC tag allocation failed
for mgmt_invalidate_connection.  mcc_wait is not initialized for tag 0
so causes crash in prepare_to_wait.

Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Reviewed-by: Tomas Henzl <thenzl@redhat.com>
Reviewed-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/be2iscsi/be_cmds.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/scsi/be2iscsi/be_cmds.c
+++ b/drivers/scsi/be2iscsi/be_cmds.c
@@ -246,6 +246,12 @@ int beiscsi_mccq_compl_wait(struct beisc
 {
 	int rc = 0;
 
+	if (!tag || tag > MAX_MCC_CMD) {
+		__beiscsi_log(phba, KERN_ERR,
+			      "BC_%d : invalid tag %u\n", tag);
+		return -EINVAL;
+	}
+
 	if (beiscsi_hba_in_error(phba)) {
 		clear_bit(MCC_TAG_STATE_RUNNING,
 			  &phba->ctrl.ptag_state[tag].tag_state);
