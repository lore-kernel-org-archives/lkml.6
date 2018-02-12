Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518412584; cv=none;
        d=google.com; s=arc-20160816;
        b=mNEWjqBzsRDEtdAKr9zCo3DYohrE1wIe6BUi7rIKU5y+5f7KD0qLUY3SpeqhISuCor
         c5Yo5OkvcTD7gTgseaxPja5zxPG4v2TvlIMKFDE4cVOHwmA6Rnm9wBow4zpfNTZCuprb
         +9Thp8KkrIWHPSUXtIfQZenWGfpIiCtFEedKB5mh8KNhd9PAELttOvJavHDaQC+lKlc8
         YSHx0VSua24HrJfMtCvCx0bv/gwcdpxyxdJpx8tUUL8+tewofOdNTKGS4RAeXLTFi7lp
         G9CL+e23Co0ODKCXhZBSJrSeJc//6qe5Os5VW+BjXpy2cPlgm8gL79iUDm9sllQ/pJrT
         o+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=0YPgz20WbaJ8Kb2Eg5km6ffNOOB9VrrQBKR2xwjRQkM=;
        b=yvnAziZYKRZqfMLltzARlmYSlxBa6GIR1p4m3hYN+zq5HCnOuBay128AWWXopjkaZR
         2Z/PWe+gTEMvALoaq6alBCysG7MIn1gy1rqzYRzvzFuTA5bTf5UEB/5ov93BqIl/PWht
         eVoToJe/Nr1kyiXjk7mmnyZAffn/gZVRX0YL4a4L5ElZABVqwIkolF0dp5GanhQphaW5
         OYGXg6rCbYRZJIr1jUkKBcCJ7DCLfFXIA6aITrO7lKpYVYOxiXtva467J+LiIz78/S9R
         tjn8BfD1raRSA0fef13zfrauts/OG43m89a8jk8ZZkhMgnSU19bnOGGrPqCbTERnA1hu
         CpiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=h3/EOd54;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=h3/EOd54;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x2272I9R9bPQTDuNYYv9JfccwaNNZlcfFqh8Vy4Cm0oAT97+k5Ijf40XXVZgwWCPKiNJRkGjl6g==
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
Subject: [PATCH 01/10] fsi: Add fsi_master_rescan()
Date: Mon, 12 Feb 2018 15:45:40 +1030
Message-Id: <20180212051549.8575-2-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212051549.8575-1-joel@jms.id.au>
References: <20180212051549.8575-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592170994131935355?=
X-GMAIL-MSGID: =?utf-8?q?1592170994131935355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeremy Kerr <jk@ozlabs.org>

We'll want non-core fsi code to trigger a rescan, so introduce a
non-static fsi_master_rescan() function. Use this for the existing
unscan/scan behaviour too.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Christopher Bostic <clbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c   | 10 ++++++++--
 drivers/fsi/fsi-master.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index e318bf8c623c..6e5aa9b26665 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -762,14 +762,20 @@ static void fsi_master_unscan(struct fsi_master *master)
 	device_for_each_child(&master->dev, NULL, fsi_master_remove_slave);
 }
 
+int fsi_master_rescan(struct fsi_master *master)
+{
+	fsi_master_unscan(master);
+	return fsi_master_scan(master);
+}
+EXPORT_SYMBOL_GPL(fsi_master_rescan);
+
 static ssize_t master_rescan_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct fsi_master *master = to_fsi_master(dev);
 	int rc;
 
-	fsi_master_unscan(master);
-	rc = fsi_master_scan(master);
+	rc = fsi_master_rescan(master);
 	if (rc < 0)
 		return rc;
 
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index 12f7b119567d..18bd4ad79356 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -40,4 +40,6 @@ struct fsi_master {
 extern int fsi_master_register(struct fsi_master *master);
 extern void fsi_master_unregister(struct fsi_master *master);
 
+extern int fsi_master_rescan(struct fsi_master *master);
+
 #endif /* DRIVERS_FSI_MASTER_H */
-- 
2.15.1
