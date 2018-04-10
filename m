Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48ciFQa5OToaGXPC/l5GQWV/E8bqu7VbkmSodAjT0J0psZFBwFV4YJgJ+x5bvQLnHOhhqk1
ARC-Seal: i=1; a=rsa-sha256; t=1523399352; cv=none;
        d=google.com; s=arc-20160816;
        b=HVM/u7UPWrBfn4sBqnGh0IxZ4orcfm3/hvnEzzY5obxtd2DmQp0/pOh42yqERK6Lww
         mnYnALsT5/EtyqyOoIkv4z2xVsANw3sqb5HU7H2sgAVS1qeEKLyrqPlV+6jL7fUIUeOo
         YIfN7uZC6pinypxH+S3c1tFMEDH0NBxaAerfB3Z6AXLsYrFQcm7oeBBDcIwepDo3Yyuc
         EgHnUzcBRREODlOzvqADcTx8qj0bp+oYmnFQkqRAfBuvMheo/dItgmuB6dux342sRT6g
         pmkvujEq9o68Ys3gtLLeBqrLtamitxUvFmWwfyUBa33EnyrVsv2dIU9fsvaQHgUpFg5L
         s4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2W3g3E3oHEL+idXNgy5S3hU/5WgpZCOpxhep77uJ7G4=;
        b=ghkcc83OCJ/CVK/M5Qk9HKsA4OQcQaBHkNflq7+Qs+seoXW8vC376gRER3wtbjjt1Q
         pSoiO3EqWyBPtp9Sdo7MDio9tbrIeYEr54B9K0veBSHsFA1vZ1GOdFlPxOh0J6Tg+dnj
         QwbqrlsgKKO/oT6N75xCMz1jAbK9o7PDJlOeLxP5m7hf1GW76zQYVSxdjwkXW89IwSq6
         uhXVXV2uGZi4OcEcSMmNpIWiNvkAsgKze0U+N32O+W3FDnV6YdKim5AX2XjLy7TzEtn9
         nQL31+jtzCJyd/u1CZqQsVDZl3/eHsirWLwIpHdEUiB9T1rHxMnmlNWnMCuxw1QG18gK
         IC3w==
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
Subject: [PATCH 4.15 058/168] nvme_fcloop: disassocate local port structs
Date: Wed, 11 Apr 2018 00:23:20 +0200
Message-Id: <20180410212802.680195717@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399999553319289?=
X-GMAIL-MSGID: =?utf-8?q?1597399999553319289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
