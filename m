Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuNMBCXBiiZi4RYMZxXp262meNbkpc/FywNnPqYL2edjR9RlOv3RA+L2Q2RVppmUnrkq16L
ARC-Seal: i=1; a=rsa-sha256; t=1519981059; cv=none;
        d=google.com; s=arc-20160816;
        b=Ch54gdMFi6hELnu5f4tYbJd0Iv7Aj/EhJKrJs46lxyBqPs2JMIWr5gIdTCF4C7rvtz
         bT8SxuENBzqL6SfhMaUZriCKm4c5VtqcX9x7wVUKprFodBsDVfcW6wQV7BGxc2cDx7e3
         P77KnDUv34zKoC22M/OmzzCPljVX06BtcuFJuVyaAQcZ+KqaxZXNCrgDCkVCqpGuTdsi
         l0HvARFw9kOMPj9TE687ZLxCUAOL/aKtIKJ26Ps1o2RPsubX2cljZxxI0FRkdEBuIQXq
         swd6EPJaEMrBNYpOsLgGOAJSlEyYwsx7+1hxnrtyDNguZbEZS0Gpws/ZfpKoY+WD/vWG
         JVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=laKkc0PL38Rn5822rEkI1pHTZG1KW//kmZMqqJXJZTc=;
        b=nl/A4+wRz/zUYCDHOJuRkSfyzni9HlgoYWu8tuNwyQ/a5wMmdxd0hLzHEmlF3Uh/8I
         AdShJ6UItNLWQGd4uarDQdkaf0qLh5YMqBkZdjPz0CUtKD2nvagKJR3EOGsZ46bnFD7d
         M8HjeAwI6N3n7KgANE0sL2ww6zGyAauZNPqqQ2zIqeDIMe1czXKIetUnWl/Y68j7qWEY
         9/GjmNzJrQfUlfmHhiWf5Er2uh2tcllt4qhxPiEAY6KfK8SMh2usdNN8ymIbgpW4BgG2
         A4Igntm+P67nbq0Dwv2O4V7XPTy/C0SEEA5RNGt3o+oZjdwRxR+4oA6+JjWZ3t53w9c0
         BnsQ==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 37/56] xfs: quota: check result of register_shrinker()
Date: Fri,  2 Mar 2018 09:51:23 +0100
Message-Id: <20180302084451.455627353@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815297009213787?=
X-GMAIL-MSGID: =?utf-8?q?1593815659930004198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aliaksei Karaliou <akaraliou.dev@gmail.com>


[ Upstream commit 3a3882ff26fbdbaf5f7e13f6a0bccfbf7121041d ]

xfs_qm_init_quotainfo() does not check result of register_shrinker()
which was tagged as __must_check recently, reported by sparse.

Signed-off-by: Aliaksei Karaliou <akaraliou.dev@gmail.com>
[darrick: move xfs_qm_destroy_quotainos nearer xfs_qm_init_quotainos]
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_qm.c |   45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -47,7 +47,7 @@
 STATIC int	xfs_qm_init_quotainos(xfs_mount_t *);
 STATIC int	xfs_qm_init_quotainfo(xfs_mount_t *);
 
-
+STATIC void	xfs_qm_destroy_quotainos(xfs_quotainfo_t *qi);
 STATIC void	xfs_qm_dqfree_one(struct xfs_dquot *dqp);
 /*
  * We use the batch lookup interface to iterate over the dquots as it
@@ -694,9 +694,17 @@ xfs_qm_init_quotainfo(
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
@@ -705,7 +713,6 @@ out_free_qinf:
 	return error;
 }
 
-
 /*
  * Gets called when unmounting a filesystem or when all quotas get
  * turned off.
@@ -722,19 +729,7 @@ xfs_qm_destroy_quotainfo(
 
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
@@ -1621,6 +1616,24 @@ error_rele:
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
