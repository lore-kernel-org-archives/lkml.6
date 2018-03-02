Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELselOMKEqn0YCzpT4njSccI7lOyTB3sAADJtP0sCGBuy5EkLgY2Oea0aCH82nNkEo4J/A1F
ARC-Seal: i=1; a=rsa-sha256; t=1519981393; cv=none;
        d=google.com; s=arc-20160816;
        b=RIVr7jJnw/ZZZJ9BMTeCgaMdD+CjkqVi63YPiTGDlgM3WQJqbbL3d1l51hJyLYVZUy
         crXVe4R8iOMsIat/9Vq5vsGSaevjioM82kV+KAQqjDsRS691f3lg4IsyzGVH6FK+v1sK
         rPJybBlbYGWiX0YJe4F3cQiPiYGZi5p2K82cDoSbzhfreliOQ2TWqbjyKLoAJnK23O3K
         RWY5MRH42FYL2y2zTSJBpoYMFxN3bJK1GTCEBkbj9vEOUG8St+/Y/kkZsfIhjo9I67FE
         j3HT4jCpotoB3JLAHNaT91IxKsiK7J8pE6Uos/gXXTrQwdkBnNgLPSwZUOuol011AbJm
         kf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Jvfr65MVtcYhayRXd5LbcAnrCjya4tH4UFqLnrRk6Zw=;
        b=tJdbCJShkviTBccqVkOOKwdym4n8pcM818kIZmlVEXnbnP6/m7DjF3dIGjqB5pAfKu
         iEjhvl7PJIH4Vv2Mk7vEpu4riqznApZrCaKZ6SOgc0mbF0VAVmPz6QHPY/2I0eHJ0fp0
         ikglp+b7I62Zl/lOaLtuuKBfRQYjP/eyBUR8TshzDbLfni3He06G3ceD63AqDb9VaxjA
         VI4yX4JFVH+/bREge5FIrN+MSw9ee5bjv3VlOVja0QeWxMCbLqUI3ppiNwygVq1VzIDt
         wsPAEIzGdBpD9qQzlsc/ur3l8D9rtZTDwpG1r3rbSZ+xGIrmbr5xhWlDtZDYYHx4WfLa
         OW7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Bloch <markb@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 078/115] RDMA/netlink: Fix locking around __ib_get_device_by_index
Date: Fri,  2 Mar 2018 09:51:21 +0100
Message-Id: <20180302084507.012059475@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816009749752146?=
X-GMAIL-MSGID: =?utf-8?q?1593816009749752146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>


[ Upstream commit f8978bd95cf92f869f3d9b34c1b699f49253b8c6 ]

Holding locks is mandatory when calling __ib_device_get_by_index,
otherwise there are races during the list iteration with device removal.

Since the locks are static to device.c, __ib_device_get_by_index can
never be called correctly by any user out side the file.

Make the function static and provide a safe function that gets the
correct locks and returns a kref'd pointer. Fix all callers.

Fixes: e5c9469efcb1 ("RDMA/netlink: Add nldev device doit implementation")
Fixes: c3f66f7b0052 ("RDMA/netlink: Implement nldev port doit callback")
Fixes: 7d02f605f0dc ("RDMA/netlink: Add nldev port dumpit implementation")
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/core_priv.h |    2 -
 drivers/infiniband/core/device.c    |   18 +++++++++++-
 drivers/infiniband/core/nldev.c     |   54 ++++++++++++++++++++++++------------
 3 files changed, 54 insertions(+), 20 deletions(-)

--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -314,7 +314,7 @@ static inline int ib_mad_enforce_securit
 }
 #endif
 
-struct ib_device *__ib_device_get_by_index(u32 ifindex);
+struct ib_device *ib_device_get_by_index(u32 ifindex);
 /* RDMA device netlink */
 void nldev_init(void);
 void nldev_exit(void);
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -134,7 +134,7 @@ static int ib_device_check_mandatory(str
 	return 0;
 }
 
-struct ib_device *__ib_device_get_by_index(u32 index)
+static struct ib_device *__ib_device_get_by_index(u32 index)
 {
 	struct ib_device *device;
 
@@ -145,6 +145,22 @@ struct ib_device *__ib_device_get_by_ind
 	return NULL;
 }
 
+/*
+ * Caller is responsible to return refrerence count by calling put_device()
+ */
+struct ib_device *ib_device_get_by_index(u32 index)
+{
+	struct ib_device *device;
+
+	down_read(&lists_rwsem);
+	device = __ib_device_get_by_index(index);
+	if (device)
+		get_device(&device->dev);
+
+	up_read(&lists_rwsem);
+	return device;
+}
+
 static struct ib_device *__ib_device_get_by_name(const char *name)
 {
 	struct ib_device *device;
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -142,27 +142,34 @@ static int nldev_get_doit(struct sk_buff
 
 	index = nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
 
-	device = __ib_device_get_by_index(index);
+	device = ib_device_get_by_index(index);
 	if (!device)
 		return -EINVAL;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
+	if (!msg) {
+		err = -ENOMEM;
+		goto err;
+	}
 
 	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET),
 			0, 0);
 
 	err = fill_dev_info(msg, device);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
+	if (err)
+		goto err_free;
 
 	nlmsg_end(msg, nlh);
 
+	put_device(&device->dev);
 	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+
+err_free:
+	nlmsg_free(msg);
+err:
+	put_device(&device->dev);
+	return err;
 }
 
 static int _nldev_get_dumpit(struct ib_device *device,
@@ -220,31 +227,40 @@ static int nldev_port_get_doit(struct sk
 		return -EINVAL;
 
 	index = nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
-	device = __ib_device_get_by_index(index);
+	device = ib_device_get_by_index(index);
 	if (!device)
 		return -EINVAL;
 
 	port = nla_get_u32(tb[RDMA_NLDEV_ATTR_PORT_INDEX]);
-	if (!rdma_is_port_valid(device, port))
-		return -EINVAL;
+	if (!rdma_is_port_valid(device, port)) {
+		err = -EINVAL;
+		goto err;
+	}
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
+	if (!msg) {
+		err = -ENOMEM;
+		goto err;
+	}
 
 	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET),
 			0, 0);
 
 	err = fill_port_info(msg, device, port);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
+	if (err)
+		goto err_free;
 
 	nlmsg_end(msg, nlh);
+	put_device(&device->dev);
 
 	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+
+err_free:
+	nlmsg_free(msg);
+err:
+	put_device(&device->dev);
+	return err;
 }
 
 static int nldev_port_get_dumpit(struct sk_buff *skb,
@@ -265,7 +281,7 @@ static int nldev_port_get_dumpit(struct
 		return -EINVAL;
 
 	ifindex = nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
-	device = __ib_device_get_by_index(ifindex);
+	device = ib_device_get_by_index(ifindex);
 	if (!device)
 		return -EINVAL;
 
@@ -299,7 +315,9 @@ static int nldev_port_get_dumpit(struct
 		nlmsg_end(skb, nlh);
 	}
 
-out:	cb->args[0] = idx;
+out:
+	put_device(&device->dev);
+	cb->args[0] = idx;
 	return skb->len;
 }
 
