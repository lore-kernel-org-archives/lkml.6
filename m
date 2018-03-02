Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuNnkz1SB1PLMHGkhmGH6TBEi1Zp2y3WvGt1U4iBalN8cIiFnIsX+aLA5hQSP6jmMoIj7v7
ARC-Seal: i=1; a=rsa-sha256; t=1519981376; cv=none;
        d=google.com; s=arc-20160816;
        b=CVi7RvnqqWsCITUftvkuW8hOEIncGxMMbQD2U+2XYdJUFF1Xd/H9lPKGmNH+6RDNyt
         um8pPwA0vKj4frrVuLPTOlFoOSW9KpYWxOZlhzIW18g866PXV3D1uJL98pp2gtNRGVC0
         46FEDt3sW0vn4j5YUOGFtRbS7KU4letzIRM7sjRWtcrX1w87cDbq0kz2Wb4zQ3Ri8g2r
         XGbB+IpUnXxpu9pEz9GL+zepGYcPYsIkhtUKmJFvS+VrD3pIlW3UsLQY1vRvTbT4hzo/
         dE8O8TkFWMa2Dt0X6dcnandhbbB12POQrsPdeZmthVU3P6yb8kGSdj2QnodJmw4HENd4
         CBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6UIZN3MxFuL4/lmLrQHaFadRsW9Pia0zVeIvftviC20=;
        b=dzkpQ3va+gdtyHhpHRfKghPKXDQ15aLSai3/qNuYcI1L6CsJbdVtW6AwvkjLC8v2yG
         w0fISI0a/BoTqEQ/D8nmZYv6CvaZowOLnjfA/Ieu7wCEbeRRkEE/ifTnXNSBvKV+nRIu
         psC4CGjuHF+H3iV5enoDMveEhEbSkkYexHNgSXv+9fD/k9TyctEs06LW0Zp49ICxRIE3
         e8cjZvhY057tC8SvqvxyhqlN/xXyBL0cDy02VRKBMhhuysE7Pb3scC15/4CGsiBg3ikn
         8Fewb5ahzIYJWfkf/jRSfzoGKEhr1FIDKy7M4L0MaSJwRdIkDvkl6wkNr30ZCt6fntiZ
         /t+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Aliaksei Karaliou <akaraliou.dev@gmail.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 073/115] xfs: quota: check result of register_shrinker()
Date: Fri,  2 Mar 2018 09:51:16 +0100
Message-Id: <20180302084506.813770544@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815297009213787?=
X-GMAIL-MSGID: =?utf-8?q?1593815992250050648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aliaksei Karaliou <akaraliou.dev@gmail.com>


[ Upstream commit 3a3882ff26fbdbaf5f7e13f6a0bccfbf7121041d ]

xfs_qm_init_quotainfo() does not check result of register_shrinker()
which was tagged as __must_check recently, reported by sparse.

Signed-off-by: Aliaksei Karaliou <akaraliou.dev@gmail.com>
[darrick: move xfs_qm_destroy_quotainos nearer xfs_qm_init_quotainos]
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_qm.c |   45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -48,7 +48,7 @@
 STATIC int	xfs_qm_init_quotainos(xfs_mount_t *);
 STATIC int	xfs_qm_init_quotainfo(xfs_mount_t *);
 
-
+STATIC void	xfs_qm_destroy_quotainos(xfs_quotainfo_t *qi);
 STATIC void	xfs_qm_dqfree_one(struct xfs_dquot *dqp);
 /*
  * We use the batch lookup interface to iterate over the dquots as it
@@ -695,9 +695,17 @@ xfs_qm_init_quotainfo(
 	qinf->qi_shrinker.scan_objects = xfs_qm_shrink_scan;
 	qinf->qi_shrinker.seeks = DEFAULT_SEEKS;
 	qinf->qi_shrinker.flags = SHRINKER_NUMA_AWARE;
-	register_shrinker(&qinf->qi_shrinker);
+
+	error = register_shrinker(&qinf->qi_shrinker);
+	if (error)
+		goto out_free_inos;
+
 	return 0;
 
+out_free_inos:
+	mutex_destroy(&qinf->qi_quotaofflock);
+	mutex_destroy(&qinf->qi_tree_lock);
+	xfs_qm_destroy_quotainos(qinf);
 out_free_lru:
 	list_lru_destroy(&qinf->qi_lru);
 out_free_qinf:
@@ -706,7 +714,6 @@ out_free_qinf:
 	return error;
 }
 
-
 /*
  * Gets called when unmounting a filesystem or when all quotas get
  * turned off.
@@ -723,19 +730,7 @@ xfs_qm_destroy_quotainfo(
 
 	unregister_shrinker(&qi->qi_shrinker);
 	list_lru_destroy(&qi->qi_lru);
-
-	if (qi->qi_uquotaip) {
-		IRELE(qi->qi_uquotaip);
-		qi->qi_uquotaip = NULL; /* paranoia */
-	}
-	if (qi->qi_gquotaip) {
-		IRELE(qi->qi_gquotaip);
-		qi->qi_gquotaip = NULL;
-	}
-	if (qi->qi_pquotaip) {
-		IRELE(qi->qi_pquotaip);
-		qi->qi_pquotaip = NULL;
-	}
+	xfs_qm_destroy_quotainos(qi);
 	mutex_destroy(&qi->qi_tree_lock);
 	mutex_destroy(&qi->qi_quotaofflock);
 	kmem_free(qi);
@@ -1601,6 +1596,24 @@ error_rele:
 }
 
 STATIC void
+xfs_qm_destroy_quotainos(
+	xfs_quotainfo_t	*qi)
+{
+	if (qi->qi_uquotaip) {
+		IRELE(qi->qi_uquotaip);
+		qi->qi_uquotaip = NULL; /* paranoia */
+	}
+	if (qi->qi_gquotaip) {
+		IRELE(qi->qi_gquotaip);
+		qi->qi_gquotaip = NULL;
+	}
+	if (qi->qi_pquotaip) {
+		IRELE(qi->qi_pquotaip);
+		qi->qi_pquotaip = NULL;
+	}
+}
+
+STATIC void
 xfs_qm_dqfree_one(
 	struct xfs_dquot	*dqp)
 {
