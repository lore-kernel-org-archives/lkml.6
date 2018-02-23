Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227DQnsTKuUIUeIFvysLFJ9qhDusVF6oSWlDvBguUaAkdv0fzVaQyjBCt91K/5HAHAknyqeq
ARC-Seal: i=1; a=rsa-sha256; t=1519412112; cv=none;
        d=google.com; s=arc-20160816;
        b=p0dz5iiBC8Q2Bm+6z7HDQrQEkPhPnbwOvWZagwQQlRhEZW/vu3XZSz7QDo0LkxQOvM
         XmGlR2ykl843qjf7mH10t5PDAWl+wplKSKaWQRVkwEf9YKI/Y0bUs9x3S/3AFeZt6s2k
         VzVmnbeJIp5KOHxmo30U5qAiqPMTb+CtTgFmWwqmwk9cEvnLw1qMJcABlBRCbDogDYja
         Mr3Kob4Dr/gSiV7PEKUBWM7oAYRUD07Qqzptha7SYryA7EWCVjFeXvTzEIkro2aL50RK
         IoKZhQgc95Ct2csmYY66Sp1tjGLOqiE+JPRw/JNSUfV5CAjOrtrg7QwK/T83Wp8K0Dgq
         EXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YJd3sDklvdLj9Kd5n/weKR4+t+xNP9GfwuJHKX4hBHI=;
        b=dNTlNQvrVXzZUxh+0LKlieWWFTLrQWmDx8u1GGv1jSfJhvJKkAJEves2hUY3SakX8T
         dpYg/Yee0sACjMygX2mKXQKpILZr3FVt6iOCdBL9ex6tDlIGIxxtZjoyk+FtVFZVt3sc
         Cf4+RqXBwJTH8KzbWftiaiGjO67hCe9EuPKm3fZqIFkDIBxVriqSD7A4QUqv3mAUoS08
         Mr91ezLblH3su56OlGn6ktnrpQ1GTA2Dyi9ok9AvZYdP/jy7Z9if1vxhkjMfNQOxjLBj
         l6LABNAnBBvIm74HFS85DijthyUdqIRhNsYLenX9KSjyB2Mu0fTqE5PSh36Fp6qnC7R7
         ErCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH 4.14 130/159] scsi: bfa: fix type conversion warning
Date: Fri, 23 Feb 2018 19:27:18 +0100
Message-Id: <20180223170758.844236686@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219074998819559?=
X-GMAIL-MSGID: =?utf-8?q?1593219074998819559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 48d83282db077f93b2cf40de120f4d6f29eb293b upstream.

A regression fix introduced a harmless type mismatch warning:

drivers/scsi/bfa/bfad_bsg.c: In function 'bfad_im_bsg_vendor_request':
drivers/scsi/bfa/bfad_bsg.c:3137:35: error: initialization of 'struct bfad_im_port_s *' from 'long unsigned int' makes pointer from integer without a cast [-Werror=int-conversion]
  struct bfad_im_port_s *im_port = shost->hostdata[0];
                                   ^~~~~
drivers/scsi/bfa/bfad_bsg.c: In function 'bfad_im_bsg_els_ct_request':
drivers/scsi/bfa/bfad_bsg.c:3353:35: error: initialization of 'struct bfad_im_port_s *' from 'long unsigned int' makes pointer from integer without a cast [-Werror=int-conversion]
  struct bfad_im_port_s *im_port = shost->hostdata[0];

This changes the code back to shost_priv() once more, but encapsulates
it in an inline function to document the rather unusual way of
using the private data only as a pointer to the previously allocated
structure.

I did not try to get rid of the extra indirection level entirely,
which would have been rather invasive and required reworking the entire
initialization sequence.

Fixes: 45349821ab3a ("scsi: bfa: fix access to bfad_im_port_s")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/bfa/bfad_bsg.c |    4 ++--
 drivers/scsi/bfa/bfad_im.c  |    6 ++++--
 drivers/scsi/bfa/bfad_im.h  |   10 ++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -3136,7 +3136,7 @@ bfad_im_bsg_vendor_request(struct bsg_jo
 	struct fc_bsg_reply *bsg_reply = job->reply;
 	uint32_t vendor_cmd = bsg_request->rqst_data.h_vendor.vendor_cmd[0];
 	struct Scsi_Host *shost = fc_bsg_to_shost(job);
-	struct bfad_im_port_s *im_port = shost->hostdata[0];
+	struct bfad_im_port_s *im_port = bfad_get_im_port(shost);
 	struct bfad_s *bfad = im_port->bfad;
 	struct request_queue *request_q = job->req->q;
 	void *payload_kbuf;
@@ -3359,7 +3359,7 @@ bfad_im_bsg_els_ct_request(struct bsg_jo
 {
 	struct bfa_bsg_data *bsg_data;
 	struct Scsi_Host *shost = fc_bsg_to_shost(job);
-	struct bfad_im_port_s *im_port = shost->hostdata[0];
+	struct bfad_im_port_s *im_port = bfad_get_im_port(shost);
 	struct bfad_s *bfad = im_port->bfad;
 	bfa_bsg_fcpt_t *bsg_fcpt;
 	struct bfad_fcxp    *drv_fcxp;
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -546,6 +546,7 @@ int
 bfad_im_scsi_host_alloc(struct bfad_s *bfad, struct bfad_im_port_s *im_port,
 			struct device *dev)
 {
+	struct bfad_im_port_pointer *im_portp;
 	int error = 1;
 
 	mutex_lock(&bfad_mutex);
@@ -564,7 +565,8 @@ bfad_im_scsi_host_alloc(struct bfad_s *b
 		goto out_free_idr;
 	}
 
-	im_port->shost->hostdata[0] = (unsigned long)im_port;
+	im_portp = shost_priv(im_port->shost);
+	im_portp->p = im_port;
 	im_port->shost->unique_id = im_port->idr_id;
 	im_port->shost->this_id = -1;
 	im_port->shost->max_id = MAX_FCP_TARGET;
@@ -748,7 +750,7 @@ bfad_scsi_host_alloc(struct bfad_im_port
 
 	sht->sg_tablesize = bfad->cfg_data.io_max_sge;
 
-	return scsi_host_alloc(sht, sizeof(unsigned long));
+	return scsi_host_alloc(sht, sizeof(struct bfad_im_port_pointer));
 }
 
 void
--- a/drivers/scsi/bfa/bfad_im.h
+++ b/drivers/scsi/bfa/bfad_im.h
@@ -69,6 +69,16 @@ struct bfad_im_port_s {
 	struct fc_vport *fc_vport;
 };
 
+struct bfad_im_port_pointer {
+	struct bfad_im_port_s *p;
+};
+
+static inline struct bfad_im_port_s *bfad_get_im_port(struct Scsi_Host *host)
+{
+	struct bfad_im_port_pointer *im_portp = shost_priv(host);
+	return im_portp->p;
+}
+
 enum bfad_itnim_state {
 	ITNIM_STATE_NONE,
 	ITNIM_STATE_ONLINE,
