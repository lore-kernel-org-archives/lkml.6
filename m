Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+rDA6bR98HR3ejMJetvz8ooRawTLbCEmk6LLgy3tjYXlSe5Num0Ox+u7mrANNnqHBd13gZ
ARC-Seal: i=1; a=rsa-sha256; t=1523399344; cv=none;
        d=google.com; s=arc-20160816;
        b=m7dGgGtCUxbLxs0NIhqMJr+iieCYlOyWc1JoPL8kI9B9Q5Ewh6JvmeWdEhE8avYiN6
         7PKLZnDDum9SAq7Pu4C4CkSdNuykJS4ZL+npoK7uuJO5df5YD4hC8EKVw9gCXR1+yHMd
         B2VetIBhZLSA0RXA+HXbsZo3gRrt+v/Ui8fcX54xgN4dIOEexigsd3/sfzIuJpwqxfk6
         sEemjYTCp2A4MdYkfbiFD/zU2f/w8ThK8WQcLRg0Qsx40RwKT6fe5w7wCKUU0s6Tlc4s
         ts3m+5Dcy6r3nppwMCHFF6fUV21LRJU4ML48w7K0Xx71wKq8bz0rzEKJmi9bah1wH4Bo
         CAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=V9P+xnDmHyfVi0u3LA35F8D6EyjSyuU1sR9ExEYNwP0=;
        b=xo3U7o5JnNm6CR50UEOFAPj5YLi2N6sL3NiLIR/xZCc5IF72JJ4YLMbguo/2N7v3xp
         ZgjT3iIybXiCeVGfes7snLceqDDk9HISyEkq64zXcdCB09pYj3ypldgrPjvpZjQ7iq/5
         Wb7p+PH2DarW8Sb+fSeq3e1R0ZZX6FZo201S7asnIxsDJsxgOydcPnN2gsUOuFeVfdwZ
         hXPiKni2Et2F/unihSVuI6+Yjo1GaFQhjKf7mgmRQ4IvGgn3sM5nYJy7QqvZR/OJpv8x
         OI0KXrH7OwUzA6efb0kbyNkVF5bHO1dMBqhubEXDSVXimdcpCgd5UNHf63hG9OYP0Vhs
         oJ/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roy Shterman <roys@lightbitslabs.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <maxg@mellanox.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 055/168] nvme-fabrics: protect against module unload during create_ctrl
Date: Wed, 11 Apr 2018 00:23:17 +0200
Message-Id: <20180410212802.545411901@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399991153206972?=
X-GMAIL-MSGID: =?utf-8?q?1597399991153206972?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roy Shterman <roys@lightbitslabs.com>


[ Upstream commit 0de5cd367c6aa2a31a1c931628f778f79f8ef22e ]

NVMe transport driver module unload may (and usually does) trigger
iteration over the active controllers and delete them all (sometimes
under a mutex).  However, a controller can be created concurrently with
module unload which can lead to leakage of resources (most important char
device node leakage) in case the controller creation occured after the
unload delete and drain sequence.  To protect against this, we take a
module reference to guarantee that the nvme transport driver is not
unloaded while creating a controller.

Signed-off-by: Roy Shterman <roys@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/fabrics.c |   17 +++++++++++++----
 drivers/nvme/host/fabrics.h |    2 ++
 drivers/nvme/host/fc.c      |    1 +
 drivers/nvme/host/rdma.c    |    1 +
 drivers/nvme/target/loop.c  |    1 +
 5 files changed, 18 insertions(+), 4 deletions(-)

--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -493,7 +493,7 @@ EXPORT_SYMBOL_GPL(nvmf_should_reconnect)
  */
 int nvmf_register_transport(struct nvmf_transport_ops *ops)
 {
-	if (!ops->create_ctrl)
+	if (!ops->create_ctrl || !ops->module)
 		return -EINVAL;
 
 	down_write(&nvmf_transports_rwsem);
@@ -869,32 +869,41 @@ nvmf_create_ctrl(struct device *dev, con
 		goto out_unlock;
 	}
 
+	if (!try_module_get(ops->module)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	ret = nvmf_check_required_opts(opts, ops->required_opts);
 	if (ret)
-		goto out_unlock;
+		goto out_module_put;
 	ret = nvmf_check_allowed_opts(opts, NVMF_ALLOWED_OPTS |
 				ops->allowed_opts | ops->required_opts);
 	if (ret)
-		goto out_unlock;
+		goto out_module_put;
 
 	ctrl = ops->create_ctrl(dev, opts);
 	if (IS_ERR(ctrl)) {
 		ret = PTR_ERR(ctrl);
-		goto out_unlock;
+		goto out_module_put;
 	}
 
 	if (strcmp(ctrl->subsys->subnqn, opts->subsysnqn)) {
 		dev_warn(ctrl->device,
 			"controller returned incorrect NQN: \"%s\".\n",
 			ctrl->subsys->subnqn);
+		module_put(ops->module);
 		up_read(&nvmf_transports_rwsem);
 		nvme_delete_ctrl_sync(ctrl);
 		return ERR_PTR(-EINVAL);
 	}
 
+	module_put(ops->module);
 	up_read(&nvmf_transports_rwsem);
 	return ctrl;
 
+out_module_put:
+	module_put(ops->module);
 out_unlock:
 	up_read(&nvmf_transports_rwsem);
 out_free_opts:
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -108,6 +108,7 @@ struct nvmf_ctrl_options {
  *			       fabric implementation of NVMe fabrics.
  * @entry:		Used by the fabrics library to add the new
  *			registration entry to its linked-list internal tree.
+ * @module:             Transport module reference
  * @name:		Name of the NVMe fabric driver implementation.
  * @required_opts:	sysfs command-line options that must be specified
  *			when adding a new NVMe controller.
@@ -126,6 +127,7 @@ struct nvmf_ctrl_options {
  */
 struct nvmf_transport_ops {
 	struct list_head	entry;
+	struct module		*module;
 	const char		*name;
 	int			required_opts;
 	int			allowed_opts;
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3380,6 +3380,7 @@ nvme_fc_create_ctrl(struct device *dev,
 
 static struct nvmf_transport_ops nvme_fc_transport = {
 	.name		= "fc",
+	.module		= THIS_MODULE,
 	.required_opts	= NVMF_OPT_TRADDR | NVMF_OPT_HOST_TRADDR,
 	.allowed_opts	= NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_CTRL_LOSS_TMO,
 	.create_ctrl	= nvme_fc_create_ctrl,
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2018,6 +2018,7 @@ out_free_ctrl:
 
 static struct nvmf_transport_ops nvme_rdma_transport = {
 	.name		= "rdma",
+	.module		= THIS_MODULE,
 	.required_opts	= NVMF_OPT_TRADDR,
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -686,6 +686,7 @@ static struct nvmet_fabrics_ops nvme_loo
 
 static struct nvmf_transport_ops nvme_loop_transport = {
 	.name		= "loop",
+	.module		= THIS_MODULE,
 	.create_ctrl	= nvme_loop_create_ctrl,
 };
 
