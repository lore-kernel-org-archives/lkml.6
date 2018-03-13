Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvDzz/Gb962/ahQGB0dIW3wrN5gUBmxbJo0KPATJvCHGysFqtITOprWU1zo0eCBirzIsv5U
ARC-Seal: i=1; a=rsa-sha256; t=1520955439; cv=none;
        d=google.com; s=arc-20160816;
        b=pkyl44Llb/DmKN4TMTj32yTm6fesnjvIOXo7Q9+bD0VaHI3fBDfZngobdTXFJWQ74c
         RJ9/8wurAugDSqhiNHAfkuq+ZX/AtUbv7Q6JvRfpHRf6AdRvnJ7O8nYNqDTebVF7QH0f
         ccKDZyYzdcXZZuic2me8b7PcpV9Ss1DJnG1X5YVHO+OcKlsH2StBpp3cOBW9L3lf/WU+
         lH4qA9r4LMc5gjRdFSUKtNSqQkK0cEWNd8/CsuHlK7EHCNIbu3ntrLe5oNeHCNnOV4Cl
         cAqnvvu0lxqa31peCU77mbWTT8GMIiexgwYiww1YVrLJxXQFYT+PTMs4CMQZ2EMmGg2s
         azEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Xk62voB0XWm0aqpecCVOAtWjW/Xvn9XDEgzhBGRjcMo=;
        b=VCyN2t2uxLIa3r1iQiTWyZOgMG1I24m1Jr/FH1LwOR1QZRzr/4XZn2GIrq5TA03q+P
         0aSqIYXNe+W1dPECajuNAigDNT48NOzroN++UAm8IXrXTW43sGbWy78UqviR3PVo+D1U
         V5WSEYR/yc9fvH8tEMGv4fBkIsmRx7MKqQR17RgdFYs7kAx0i4Z6au7E2AokFlKAXeDh
         XKqro8bmN+4Er4ccyT9HLQq/LqeGTuIDmjshZ14wwgYtrJFt+kpUhBLjuqvJ8xV9aWOC
         vPbf2Ed5DjMCisE4v/gXpfblgxcNZiR/2dsb/XDU8CD4ruCYZIocKuj5xPZKmKeCnyxO
         8ysw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.14 044/140] pNFS: Prevent the layout header refcount going to zero in pnfs_roc()
Date: Tue, 13 Mar 2018 16:24:07 +0100
Message-Id: <20180313152501.064209567@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837189810166785?=
X-GMAIL-MSGID: =?utf-8?q?1594837370699685842?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>

commit 9c6376ebddad585da4238532dd6d90ae23ffee67 upstream.

Ensure that we hold a reference to the layout header when processing
the pNFS return-on-close so that the refcount value does not inadvertently
go to zero.

Reported-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Cc: stable@vger.kernel.org # v4.10+
Tested-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/pnfs.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -292,8 +292,11 @@ pnfs_detach_layout_hdr(struct pnfs_layou
 void
 pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 {
-	struct inode *inode = lo->plh_inode;
+	struct inode *inode;
 
+	if (!lo)
+		return;
+	inode = lo->plh_inode;
 	pnfs_layoutreturn_before_put_layout_hdr(lo);
 
 	if (atomic_dec_and_lock(&lo->plh_refcount, &inode->i_lock)) {
@@ -1223,10 +1226,12 @@ retry:
 	spin_lock(&ino->i_lock);
 	lo = nfsi->layout;
 	if (!lo || !pnfs_layout_is_valid(lo) ||
-	    test_bit(NFS_LAYOUT_BULK_RECALL, &lo->plh_flags))
+	    test_bit(NFS_LAYOUT_BULK_RECALL, &lo->plh_flags)) {
+		lo = NULL;
 		goto out_noroc;
+	}
+	pnfs_get_layout_hdr(lo);
 	if (test_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags)) {
-		pnfs_get_layout_hdr(lo);
 		spin_unlock(&ino->i_lock);
 		wait_on_bit(&lo->plh_flags, NFS_LAYOUT_RETURN,
 				TASK_UNINTERRUPTIBLE);
@@ -1294,10 +1299,12 @@ out_noroc:
 		struct pnfs_layoutdriver_type *ld = NFS_SERVER(ino)->pnfs_curr_ld;
 		if (ld->prepare_layoutreturn)
 			ld->prepare_layoutreturn(args);
+		pnfs_put_layout_hdr(lo);
 		return true;
 	}
 	if (layoutreturn)
 		pnfs_send_layoutreturn(lo, &stateid, iomode, true);
+	pnfs_put_layout_hdr(lo);
 	return false;
 }
 
