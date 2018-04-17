Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ZMPzZ2HiB8eLZLAAQHaWVy/y6oizoWL0PuWyZO2kAzVuRGaazghV4UmXhuRFN51+n2W2+
ARC-Seal: i=1; a=rsa-sha256; t=1523980906; cv=none;
        d=google.com; s=arc-20160816;
        b=PqNXcHtMd8PKs+uAYVXezgbIE29M9/+1mxj4vmCn2zoSGYIVtV6HtAMXr0lYzuIhDL
         HuUuJpwaTLDEjYYS1966P8TpIUDFw5cji2Wf+zO9HBWKi3Wltn8Vxu/v20Aq3YbaQvVH
         6sxhIyyTs3XwO72YN/bpiwYa3Hkm4AlCN9s22CEBU5hsX7JYSO/VpI60hMhpbTE5VUDV
         C7gwCGN5CM2sCnlVxXJgv7jHB+LQC3dRuy41Y1xCFMVX6NMc88xxMr94KGnEkYRfWQeY
         Cix+UffuYC3TNuYv/NXQlH4uV+JnKF5Uu6fOXSD+kWTHk/h1/p/apu88bKiqnzGwiZBV
         F1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tCGneiZJOcQvUPJ8PiyMxLnlL2GVXMvvB8nGOxVxa74=;
        b=eAZ+qvV4S2rCAiOYXzFHANs/7PMhXIFVQ+jvIyek3H7z1VpNj/JzEtbRtw5wXJMBzM
         fCp4lkuVIUpnvqUBL76aKA3z1iLQjQbsn1bcdzkscOS1Y4w9U7ZM1g8T3ED5d+J15uQd
         mgRUzUqSyTlwBlKXQNHRQ0Yk9K0WE7hfcwCcclWv7vWpvvY6aqpxlT/+/kDfa98gyGln
         76nqJKIcbXsGDZK2VvU3b4g/V+fPPu1t9M2HWShIXLheG2rG5vxBr015oXQ0mtggOELK
         Ih6USdzFwizpjTqz08qNRAne5COjv9RmHVcPf1AlmmRZ9XB3b/jVNQi9r0lVrqs+i/ye
         Aeyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eddie Horng <eddiehorng.tw@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.16 46/68] ovl: set i_ino to the value of st_ino for NFS export
Date: Tue, 17 Apr 2018 17:57:59 +0200
Message-Id: <20180417155751.212310899@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009803364663242?=
X-GMAIL-MSGID: =?utf-8?q?1598009803364663242?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 695b46e76b62447e506cddc87e088236498008e5 upstream.

Eddie Horng reported that readdir of an overlayfs directory that
was exported via NFSv3 returns entries with d_type set to DT_UNKNOWN.
The reason is that while preparing the response for readdirplus, nfsd
checks inside encode_entryplus_baggage() that a child dentry's inode
number matches the value of d_ino returns by overlayfs readdir iterator.

Because the overlayfs inodes use arbitrary inode numbers that are not
correlated with the values of st_ino/d_ino, NFSv3 falls back to not
encoding d_type. Although this is an allowed behavior, we can fix it for
the case of all overlayfs layers on the same underlying filesystem.

When NFS export is enabled and d_ino is consistent with st_ino
(samefs), set the same value also to i_ino in ovl_fill_inode() for all
overlayfs inodes, nfsd readdirplus sanity checks will pass.
ovl_fill_inode() may be called from ovl_new_inode(), before real inode
was created with ino arg 0. In that case, i_ino will be updated to real
upper inode i_ino on ovl_inode_init() or ovl_inode_update().

Reported-by: Eddie Horng <eddiehorng.tw@gmail.com>
Tested-by: Eddie Horng <eddiehorng.tw@gmail.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Fixes: 8383f1748829 ("ovl: wire up NFS export operations")
Cc: <stable@vger.kernel.org> #v4.16
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/inode.c |   21 +++++++++++++++++----
 fs/overlayfs/util.c  |    8 +++++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -459,9 +459,20 @@ static inline void ovl_lockdep_annotate_
 #endif
 }
 
-static void ovl_fill_inode(struct inode *inode, umode_t mode, dev_t rdev)
+static void ovl_fill_inode(struct inode *inode, umode_t mode, dev_t rdev,
+			   unsigned long ino)
 {
-	inode->i_ino = get_next_ino();
+	/*
+	 * When NFS export is enabled and d_ino is consistent with st_ino
+	 * (samefs), set the same value to i_ino, because nfsd readdirplus
+	 * compares d_ino values to i_ino values of child entries. When called
+	 * from ovl_new_inode(), ino arg is 0, so i_ino will be updated to real
+	 * upper inode i_ino on ovl_inode_init() or ovl_inode_update().
+	 */
+	if (inode->i_sb->s_export_op && ovl_same_sb(inode->i_sb))
+		inode->i_ino = ino;
+	else
+		inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
 	inode->i_flags |= S_NOCMTIME;
 #ifdef CONFIG_FS_POSIX_ACL
@@ -597,7 +608,7 @@ struct inode *ovl_new_inode(struct super
 
 	inode = new_inode(sb);
 	if (inode)
-		ovl_fill_inode(inode, mode, rdev);
+		ovl_fill_inode(inode, mode, rdev, 0);
 
 	return inode;
 }
@@ -710,6 +721,7 @@ struct inode *ovl_get_inode(struct super
 	struct inode *inode;
 	bool bylower = ovl_hash_bylower(sb, upperdentry, lowerdentry, index);
 	bool is_dir;
+	unsigned long ino = 0;
 
 	if (!realinode)
 		realinode = d_inode(lowerdentry);
@@ -748,13 +760,14 @@ struct inode *ovl_get_inode(struct super
 		if (!is_dir)
 			nlink = ovl_get_nlink(lowerdentry, upperdentry, nlink);
 		set_nlink(inode, nlink);
+		ino = key->i_ino;
 	} else {
 		/* Lower hardlink that will be broken on copy up */
 		inode = new_inode(sb);
 		if (!inode)
 			goto out_nomem;
 	}
-	ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev);
+	ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev, ino);
 	ovl_inode_init(inode, upperdentry, lowerdentry);
 
 	if (upperdentry && ovl_is_impuredir(upperdentry))
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -279,12 +279,16 @@ void ovl_dentry_set_redirect(struct dent
 void ovl_inode_init(struct inode *inode, struct dentry *upperdentry,
 		    struct dentry *lowerdentry)
 {
+	struct inode *realinode = d_inode(upperdentry ?: lowerdentry);
+
 	if (upperdentry)
 		OVL_I(inode)->__upperdentry = upperdentry;
 	if (lowerdentry)
 		OVL_I(inode)->lower = igrab(d_inode(lowerdentry));
 
-	ovl_copyattr(d_inode(upperdentry ?: lowerdentry), inode);
+	ovl_copyattr(realinode, inode);
+	if (!inode->i_ino)
+		inode->i_ino = realinode->i_ino;
 }
 
 void ovl_inode_update(struct inode *inode, struct dentry *upperdentry)
@@ -299,6 +303,8 @@ void ovl_inode_update(struct inode *inod
 	smp_wmb();
 	OVL_I(inode)->__upperdentry = upperdentry;
 	if (inode_unhashed(inode)) {
+		if (!inode->i_ino)
+			inode->i_ino = upperinode->i_ino;
 		inode->i_private = upperinode;
 		__insert_inode_hash(inode, (unsigned long) upperinode);
 	}
