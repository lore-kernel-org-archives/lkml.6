Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+FpEbAWE1shvFrGEjmlvfxp88+2iz7jjB5iJsnhcCwKdDEWJGlgIGAkPs5p3LRZhOgshwJ
ARC-Seal: i=1; a=rsa-sha256; t=1523399729; cv=none;
        d=google.com; s=arc-20160816;
        b=VTmHXM5pezsGAnyWoHfqDX3tN7QBUE9tuWKrVCQoqsq+jU6ADH2rBFJ0G8b3jdgbud
         ybN1sk77FFGEx/9K/CBonk22+bFKR6tAiQBJ5bnk/ZAG5s2jOZkQhrX9aQgXOwam3zsy
         tVWehaftYqxGx9Q27wiONw7pjVdDvccZkiKoNnrMeGyt/ktbd42uZmDrZcaCZFPCiZsx
         ZnEdoerhWFNINDbSTullck1RCF15ObWRs1nqDMOVF0Bh+LoNCYjr4lB392ab/K++Ybr/
         Ry3hqH+aBdhrrdufeWw3qPq0TE68p6xPNw4wh33HMODnx+zs815s+bI+GTVxTTaK4b9C
         +mJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=32f89VvVA52Kq2/GKrrpj3mQzS8zd0xYRcFwJeY65p8=;
        b=yEi6Cj4GBBTWXBsBV4vk45BuardXE4DBNPhu7CPpSsYqX+sCiEP67uvrBRXXmgPfvr
         5gGhAo5cEftWEsQB6ivly7rJV9tdt71GwJNCp+RJQoTmNoKJGW/HXOjNt2YGWwsSxS1H
         RneeQG2a1hZj20EFAqC7FjY6+KpaYx0YxHYw7WJEhePi8/CBzSnHMNiXTc9NHhrqGqd3
         BviZoxlt5S8xF5fmxJNcsBhgq5ZqjPqinGTFtSHAFghn+v8CkcrxTRSb6tS0JJDOej7G
         jDT4SkahsrM6ePKEYbCUB9lpC+8yEQ2E6BW/mW9nViwFB0+jE9KPlIdmfMh1gt2+DTNn
         1O7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 043/138] nvme_fcloop: disassocate local port structs
Date: Wed, 11 Apr 2018 00:23:53 +0200
Message-Id: <20180410212907.112110104@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399999553319289?=
X-GMAIL-MSGID: =?utf-8?q?1597400394293361461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>


[ Upstream commit 6fda20283e55b9d288cd56822ce39fc8e64f2208 ]

The current fcloop driver gets its lport structure from the private
area co-allocated with the fc_localport. All is fine except the
teardown path, which wants to wait on the completion, which is marked
complete by the delete_localport callback performed after
unregister_localport.  The issue is, the nvme_fc transport frees the
localport structure immediately after delete_localport is called,
meaning the original routine is trying to wait on a complete that
was just freed.

Change such that a lport struct is allocated coincident with the
addition and registration of a localport. The private area of the
localport now contains just a backpointer to the real lport struct.
Now, the completion can be waited for, and after completing, the
new structure can be kfree'd.

Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/target/fcloop.c |   35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -204,6 +204,10 @@ struct fcloop_lport {
 	struct completion unreg_done;
 };
 
+struct fcloop_lport_priv {
+	struct fcloop_lport *lport;
+};
+
 struct fcloop_rport {
 	struct nvme_fc_remote_port *remoteport;
 	struct nvmet_fc_target_port *targetport;
@@ -657,7 +661,8 @@ fcloop_nport_get(struct fcloop_nport *np
 static void
 fcloop_localport_delete(struct nvme_fc_local_port *localport)
 {
-	struct fcloop_lport *lport = localport->private;
+	struct fcloop_lport_priv *lport_priv = localport->private;
+	struct fcloop_lport *lport = lport_priv->lport;
 
 	/* release any threads waiting for the unreg to complete */
 	complete(&lport->unreg_done);
@@ -697,7 +702,7 @@ static struct nvme_fc_port_template fcte
 	.max_dif_sgl_segments	= FCLOOP_SGL_SEGS,
 	.dma_boundary		= FCLOOP_DMABOUND_4G,
 	/* sizes of additional private data for data structures */
-	.local_priv_sz		= sizeof(struct fcloop_lport),
+	.local_priv_sz		= sizeof(struct fcloop_lport_priv),
 	.remote_priv_sz		= sizeof(struct fcloop_rport),
 	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
 	.fcprqst_priv_sz	= sizeof(struct fcloop_ini_fcpreq),
@@ -728,11 +733,17 @@ fcloop_create_local_port(struct device *
 	struct fcloop_ctrl_options *opts;
 	struct nvme_fc_local_port *localport;
 	struct fcloop_lport *lport;
-	int ret;
+	struct fcloop_lport_priv *lport_priv;
+	unsigned long flags;
+	int ret = -ENOMEM;
+
+	lport = kzalloc(sizeof(*lport), GFP_KERNEL);
+	if (!lport)
+		return -ENOMEM;
 
 	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
 	if (!opts)
-		return -ENOMEM;
+		goto out_free_lport;
 
 	ret = fcloop_parse_options(opts, buf);
 	if (ret)
@@ -752,23 +763,25 @@ fcloop_create_local_port(struct device *
 
 	ret = nvme_fc_register_localport(&pinfo, &fctemplate, NULL, &localport);
 	if (!ret) {
-		unsigned long flags;
-
 		/* success */
-		lport = localport->private;
+		lport_priv = localport->private;
+		lport_priv->lport = lport;
+
 		lport->localport = localport;
 		INIT_LIST_HEAD(&lport->lport_list);
 
 		spin_lock_irqsave(&fcloop_lock, flags);
 		list_add_tail(&lport->lport_list, &fcloop_lports);
 		spin_unlock_irqrestore(&fcloop_lock, flags);
-
-		/* mark all of the input buffer consumed */
-		ret = count;
 	}
 
 out_free_opts:
 	kfree(opts);
+out_free_lport:
+	/* free only if we're going to fail */
+	if (ret)
+		kfree(lport);
+
 	return ret ? ret : count;
 }
 
@@ -790,6 +803,8 @@ __wait_localport_unreg(struct fcloop_lpo
 
 	wait_for_completion(&lport->unreg_done);
 
+	kfree(lport);
+
 	return ret;
 }
 
