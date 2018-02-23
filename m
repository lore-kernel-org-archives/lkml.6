Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226FAr9On4QYmLKx5UkSVFwDTSLscIta0umg9kakv4EDRsUX3Nogc/RQ+HRTXI/MnKGm3uDa
ARC-Seal: i=1; a=rsa-sha256; t=1519412109; cv=none;
        d=google.com; s=arc-20160816;
        b=WB2xbr8SXgSANrJVGqYflIdKhBX1fUpGWeQwBrhCklTuZQJ2eIi2y/sS9+EicjGU9v
         EnN+iBWEBfQA2MTq2BQSbZ1YaXnMenX6u1zO/yxZMbz/lcHmPBu+rn+0FGfnlSrFrmXh
         QloImOx1h06SisDs3BGKfCUpNu0CuYmZ9Qcin48RUeIOYcZ5DhN5HWEsEUgJvdD9mbSG
         4yoJ30xSfbh3MkeHPU18hge5BfajzW5hHS+R+QH8pZkwn5Ai73hm07TPJOEoX/gRLxxn
         c0QoDcoFZdH75M9TXQ1HfDX/lv6Edbpw4/qkCTo2w3qILcKg7A1yrdNQJvw8XpFSn8lG
         ABSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QFqzfnDF7gPEIv/BosN7g2+1QXoWX+J25c8g30k+Sl8=;
        b=weJNkJdOwNyeP33bosHad3+LR4kJ09bIRGxm50ho68/zjVnpSZNkRL66d711DjfkMO
         xkeioHSQkGlni22pt3KMC+iToDRBKoUSPkAItO0/bFhJ4mkJoZEMHyOBGivP3a72grI2
         eD2dXjT4IssuycL2+RphLsmBvkz8tZ9vNtKYuDUuZehEsWdJMP9NZh0X3H2D3neN4bTT
         Fw4xoQ+HdXFEcP8gmbEfOP94xVtxRLrPriokwJDlSf0KHZcnsvMN82xZD3HJMm5oRWvi
         vSzgAzplLusGUInzAW+e7GkLQ896qvJNS8kDJJ0Nod2xSmXom0IJdlLYaMSi/DWtGELQ
         7i7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 129/159] scsi: bfa: fix access to bfad_im_port_s
Date: Fri, 23 Feb 2018 19:27:17 +0100
Message-Id: <20180223170758.729710454@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219072011124530?=
X-GMAIL-MSGID: =?utf-8?q?1593219072011124530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>


[ Upstream commit 45349821ab3a8d378b8f37e52c6fe1aa1b870c47 ]

Commit 'cd21c605b2cf ("scsi: fc: provide fc_bsg_to_shost() helper")'
changed access to bfa's 'struct bfad_im_port_s' by using shost_priv()
instead of shost->hostdata[0].

This lead to crashes like in the following back-trace:

task: ffff880046375300 ti: ffff8800a2ef8000 task.ti: ffff8800a2ef8000
RIP: e030:[<ffffffffa04c8252>]  [<ffffffffa04c8252>] bfa_fcport_get_attr+0x82/0x260 [bfa]
RSP: e02b:ffff8800a2efba10  EFLAGS: 00010046
RAX: 575f415441536432 RBX: ffff8800a2efba28 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8800a2efba28 RDI: ffff880004dc31d8
RBP: ffff880004dc31d8 R08: 0000000000000000 R09: 0000000000000001
R10: ffff88011fadc468 R11: 0000000000000001 R12: ffff880004dc31f0
R13: 0000000000000200 R14: ffff880004dc61d0 R15: ffff880004947a10
FS:  00007feb1e489700(0000) GS:ffff88011fac0000(0000) knlGS:0000000000000000
CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007ffe14e46c10 CR3: 00000000957b8000 CR4: 0000000000000660
Stack:
 ffff88001d4da000 ffff880004dc31c0 ffffffffa048a9df ffffffff81e56380
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[] bfad_iocmd_ioc_get_info+0x4f/0x220 [bfa]
[] bfad_iocmd_handler+0xa00/0xd40 [bfa]
[] bfad_im_bsg_request+0xee/0x1b0 [bfa]
[] fc_bsg_dispatch+0x10b/0x1b0 [scsi_transport_fc]
[] bsg_request_fn+0x11d/0x1c0
[] __blk_run_queue+0x2f/0x40
[] blk_execute_rq_nowait+0xa8/0x160
[] blk_execute_rq+0x77/0x120
[] bsg_ioctl+0x1b6/0x200
[] do_vfs_ioctl+0x2cd/0x4a0
[] SyS_ioctl+0x74/0x80
[] entry_SYSCALL_64_fastpath+0x12/0x6d

Fixes: cd21c605b2cf ("scsi: fc: provide fc_bsg_to_shost() helper")
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Michal Koutný <mkoutny@suse.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/bfa/bfad_bsg.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -3135,7 +3135,8 @@ bfad_im_bsg_vendor_request(struct bsg_jo
 	struct fc_bsg_request *bsg_request = job->request;
 	struct fc_bsg_reply *bsg_reply = job->reply;
 	uint32_t vendor_cmd = bsg_request->rqst_data.h_vendor.vendor_cmd[0];
-	struct bfad_im_port_s *im_port = shost_priv(fc_bsg_to_shost(job));
+	struct Scsi_Host *shost = fc_bsg_to_shost(job);
+	struct bfad_im_port_s *im_port = shost->hostdata[0];
 	struct bfad_s *bfad = im_port->bfad;
 	struct request_queue *request_q = job->req->q;
 	void *payload_kbuf;
@@ -3357,7 +3358,8 @@ int
 bfad_im_bsg_els_ct_request(struct bsg_job *job)
 {
 	struct bfa_bsg_data *bsg_data;
-	struct bfad_im_port_s *im_port = shost_priv(fc_bsg_to_shost(job));
+	struct Scsi_Host *shost = fc_bsg_to_shost(job);
+	struct bfad_im_port_s *im_port = shost->hostdata[0];
 	struct bfad_s *bfad = im_port->bfad;
 	bfa_bsg_fcpt_t *bsg_fcpt;
 	struct bfad_fcxp    *drv_fcxp;
