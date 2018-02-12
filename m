Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518412639; cv=none;
        d=google.com; s=arc-20160816;
        b=zjcVd4+XpNqAhyyeQdnHwvJRYK42e58sokk9SJr87yoU1YB78p4sCknW5B/L5d/DSV
         pn/T7iNCw5wmSuJ0OCxTgkPuLpZaEYnldGGNXt95k+awmB70xC9jxqOTi/6Bv5CQqx88
         MSxCRtXlYvS9uCNv+egvDkfvCBIfTEtgFJrNyDU40pcxx/1sTKTMzAkOg9Jj1fmL7WSC
         iCiCDXEXYo515H+vuLy09yD16yB5CajwBms/JsVzkWsjIMNHtSvZsOEZwoRnnaNUXFvx
         efw41XBt4NEm89UR1OTPey1BVJR+i9T0Vs62J07TP+FblWr34KgdUTdtLp/AcpmdIRwd
         jMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=B7eddgQ2fGlz7MNVOtGON1OIZLIyyZdsrEn1FPOB0qQ=;
        b=NGgG8k0uJpk7mRWSVlH8Qg4CIKLK9BqY3id/j4qx76eNN5RrHJuwd2hQN5gaEmmBOS
         i5IOnP/qyEvvDJ2zmnF+4O2W6W6UBEAO7PZC58ETkeYleE7PJPzOiwnp01/ULJASVHtu
         Tdr1OpbYtRD9lMCBtL851e0N2yJ1kXyxXEdK46rzYtJjs7RABniC/vHGTiwzQbLwE63N
         bpJ6jz23Mbw9+qvCeFp+JYGjRYOcdQ+L9rOSjT6TJfe2mad5CnhW+7lxaHEgi05XBsCJ
         0Lp+Y8tcYFCt/KNerdeCouWnWTLMRVA3NoKJmAEjjrezQfWkcaZM1lvVWxRgRx6W0Yjn
         KqtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pJ+Oa51r;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pJ+Oa51r;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x226Q2dD9HejjSV76PH2ILIQYiGq2YYIjb18lRAYeDne6qv1LZuHsQiUW5v8au1/8lcj6GZgB7g==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Jeremy Kerr <jk@ozlabs.org>,
	Christopher Bostic <cbostic@linux.vnet.ibm.com>,
	Brad Bishop <bradleyb@fuzziesquirrel.com>,
	Edward James <eajames@us.ibm.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 08/10] fsi: master: Clarify master lifetimes & fix use-after-free in hub master
Date: Mon, 12 Feb 2018 15:45:47 +1030
Message-Id: <20180212051549.8575-9-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212051549.8575-1-joel@jms.id.au>
References: <20180212051549.8575-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592171051914795065?=
X-GMAIL-MSGID: =?utf-8?q?1592171051914795065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeremy Kerr <jk@ozlabs.org>

Once we call fsi_master_unregister, the core will put_device,
potentially freeing the hub master. This change adds a comment
explaining the lifetime of an allocated fsi_master.

We then add a reference from the driver to the hub master, so it stays
around until we've finished ->remove().

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Tested-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-master-hub.c | 21 ++++++++++++++++++---
 drivers/fsi/fsi-master.h     | 15 +++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 5e4cd3134bc0..5885fc4a1ef0 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -288,10 +288,19 @@ static int hub_master_probe(struct device *dev)
 	hub_master_init(hub);
 
 	rc = fsi_master_register(&hub->master);
-	if (!rc)
-		return 0;
+	if (rc)
+		goto err_release;
+
+	/* At this point, fsi_master_register performs the device_initialize(),
+	 * and holds the sole reference on master.dev. This means the device
+	 * will be freed (via ->release) during any subsequent call to
+	 * fsi_master_unregister.  We add our own reference to it here, so we
+	 * can perform cleanup (in _remove()) without it being freed before
+	 * we're ready.
+	 */
+	get_device(&hub->master.dev);
+	return 0;
 
-	kfree(hub);
 err_release:
 	fsi_slave_release_range(fsi_dev->slave, FSI_HUB_LINK_OFFSET,
 			FSI_HUB_LINK_SIZE * links);
@@ -306,6 +315,12 @@ static int hub_master_remove(struct device *dev)
 	fsi_slave_release_range(hub->upstream->slave, hub->addr, hub->size);
 	of_node_put(hub->master.dev.of_node);
 
+	/*
+	 * master.dev will likely be ->release()ed after this, which free()s
+	 * the hub
+	 */
+	put_device(&hub->master.dev);
+
 	return 0;
 }
 
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index 18bd4ad79356..ee0b46086026 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -37,6 +37,21 @@ struct fsi_master {
 
 #define dev_to_fsi_master(d) container_of(d, struct fsi_master, dev)
 
+/**
+ * fsi_master registration & lifetime: the fsi_master_register() and
+ * fsi_master_unregister() functions will take ownership of the master, and
+ * ->dev in particular. The registration path performs a get_device(), which
+ * takes the first reference on the device. Similarly, the unregistration path
+ * performs a put_device(), which may well drop the last reference.
+ *
+ * This means that master implementations *may* need to hold their own
+ * reference (via get_device()) on master->dev. In particular, if the device's
+ * ->release callback frees the fsi_master, then fsi_master_unregister will
+ * invoke this free if no other reference is held.
+ *
+ * The same applies for the error path of fsi_master_register; if the call
+ * fails, dev->release will have been invoked.
+ */
 extern int fsi_master_register(struct fsi_master *master);
 extern void fsi_master_unregister(struct fsi_master *master);
 
-- 
2.15.1
