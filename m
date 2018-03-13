Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuL/XlbypGxNlpEBUXZdsoUHVnOWI/WO95OjHBZn8Tr5rI8HPKJgWGLBiHhciTZTGUZKBYH
ARC-Seal: i=1; a=rsa-sha256; t=1520955266; cv=none;
        d=google.com; s=arc-20160816;
        b=eEfImGYW9WLf4k8WTcwuzZb/uCBCOjbJzqI4XvWI1oV1iZkp8r/3bf+74Jpzk2hyJX
         hvwcl0frIzmjsh0XJGGpdCwq8oRG1g8OrBY5xmLOHt0k+HdlHcOgmbNQFU0KAsMuwzpl
         pxO/nZg6u34fMWbr0+PPl/WPRzpbgYb5Tz2k42dGSQkEd1CMrez0sv8X1kpUJFFXIzHh
         Q4YuRBtqC/0KCw4XvG20d+Y4ql48bbkZv8jrND8yVq1ZnlhWMXZJNcoga06AUwxi2LkA
         cBZhw1sPIxksSPYqnJ1nojgAc+5VRoGoBt/KuSy/kZRl2Q6XERDCmECjR/8qNzVlq3LH
         vSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YYoF8mEbo4AwMzBExDCRd7sn+PqUy/LU2lmC9JUeRso=;
        b=faKshRILSvJevqekSoFrfecl8PNbwP1W4mKIwnNF9KcKoOT7yy41ay5XzgebVAobNw
         E8nVSScLczoWCZ1Y9nwp9u8HdUOanHa11C2gj7u6O1WEInqRHJQ0VOAVSp6+TirqAcy5
         gsryK1ot0OLgv1KJBO3GROFT+GoprQxadVwqURFUXVSVQfXOg76baO1pCAVvFGJQSkmQ
         0j766/JqJ/qng9wF172WmLRO3Uy3nD0HK6bTOASeIPFjNnvwrGNi7m7nbzQSeIxsPaWA
         p6jslCtEDlb4QqnMgzum0xpC7/BEucjQf+VjnbzPmcix8g2dUROvnVwwIjWcV1PA/CBB
         sqzQ==
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
Subject: [PATCH 4.15 145/146] pNFS: Prevent the layout header refcount going to zero in pnfs_roc()
Date: Tue, 13 Mar 2018 16:25:12 +0100
Message-Id: <20180313152331.265397479@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837189810166785?=
X-GMAIL-MSGID: =?utf-8?q?1594837189810166785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
 	if (refcount_dec_and_lock(&lo->plh_refcount, &inode->i_lock)) {
@@ -1241,10 +1244,12 @@ retry:
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
@@ -1312,10 +1317,12 @@ out_noroc:
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
 
