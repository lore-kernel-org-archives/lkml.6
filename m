Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48175O1Zji/IJKisPxBVT5POrojmkCQrKOiTbXs3hLubfHlXlMY4zQCkUS9Da57jZoBDpT1
ARC-Seal: i=1; a=rsa-sha256; t=1523981078; cv=none;
        d=google.com; s=arc-20160816;
        b=oRWjhuU3qazNER/SMMSFsG4QOYA6elS5YarTEeVruOm0xRgY8vjLpZmMCfnsgE9DQ/
         KF+Bmuxrxk0mw889Qdu6gOhPIe6ndjs4AM8iW3ZfALmTy5iIqvyTm83+XoNZxa1ADnX1
         7YB8pnetWUckQWAYydUg25D2Ltl7Y82jRkUEeFdVDxzf3lEvXeSp/9mtkFBZ46jLC43h
         bgxU9QURudw6AyTyg+fQ2Af3mRjWieulCoBV18YuEoReNeZQ60tZHyGzm+qgOUsgBtGf
         MgeQh2aCR5RlXaaqWGO8YKhhneRk1zbAzQ+Jv0ZARmzvhBuXIf5Y/rFBrCGF48sxrQmM
         Cljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Tx/Pqtg9RfugCyMh9O0h/MKXQfZReCdCN8ICY6qDyxw=;
        b=E51H9s+fNrIQ1/QDl5DwTv1NuULjUHgC4M02/G4Tw0w0xE/oPJv1a7DROvXr9bHGnL
         UC+N2YBCvhGXeaONSbC2w1zNotDI7o9eI59bwAQy36az6nIHhvJ5FH6A+sAjpVfCEewt
         5JwxWsOGlZNX1m7k+Qq8qgFOpCJFpcE+ZE2QoUIGzyzsrdOV70A2we/mRxCcE3+s0Tvo
         t8L3wpaMW/b+5GYfP+GVY2RgWtC5/mnLOQ6K3HoVHtuNOavoiJWppu519X0CzCX+NuLf
         zkoCWeR2OaQAlbl0Xi+2tWKsOPT2SSs3xMPfJTUwJZJV1eLPZ/Vcp9v8J9eDjkScu1cH
         LpYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lucash Stach <l.stach@pengutronix.de>,
	"J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.15 36/53] nfsd: fix incorrect umasks
Date: Tue, 17 Apr 2018 17:59:01 +0200
Message-Id: <20180417155724.893176389@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009814769839475?=
X-GMAIL-MSGID: =?utf-8?q?1598009983158631682?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: J. Bruce Fields <bfields@redhat.com>

commit 880a3a5325489a143269a8e172e7563ebf9897bc upstream.

We're neglecting to clear the umask after it's set, which can cause a
later unrelated rpc to (incorrectly) use the same umask if it happens to
be processed by the same thread.

There's a more subtle problem here too:

An NFSv4 compound request is decoded all in one pass before any
operations are executed.

Currently we're setting current->fs->umask at the time we decode the
compound.  In theory a single compound could contain multiple creates
each setting a umask.  In that case we'd end up using whichever umask
was passed in the *last* operation as the umask for all the creates,
whether that was correct or not.

So, we should just be saving the umask at decode time and waiting to set
it until we actually process the corresponding operation.

In practice it's unlikely any client would do multiple creates in a
single compound.  And even if it did they'd likely be from the same
process (hence carry the same umask).  So this is a little academic, but
we should get it right anyway.

Fixes: 47057abde515 (nfsd: add support for the umask attribute)
Cc: stable@vger.kernel.org
Reported-by: Lucash Stach <l.stach@pengutronix.de>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4proc.c |   12 ++++++++++--
 fs/nfsd/nfs4xdr.c  |    8 +++-----
 fs/nfsd/xdr4.h     |    2 ++
 3 files changed, 15 insertions(+), 7 deletions(-)

--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -32,6 +32,7 @@
  *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
+#include <linux/fs_struct.h>
 #include <linux/file.h>
 #include <linux/falloc.h>
 #include <linux/slab.h>
@@ -252,11 +253,13 @@ do_open_lookup(struct svc_rqst *rqstp, s
 		 * Note: create modes (UNCHECKED,GUARDED...) are the same
 		 * in NFSv4 as in v3 except EXCLUSIVE4_1.
 		 */
+		current->fs->umask = open->op_umask;
 		status = do_nfsd_create(rqstp, current_fh, open->op_fname.data,
 					open->op_fname.len, &open->op_iattr,
 					*resfh, open->op_createmode,
 					(u32 *)open->op_verf.data,
 					&open->op_truncate, &open->op_created);
+		current->fs->umask = 0;
 
 		if (!status && open->op_label.len)
 			nfsd4_security_inode_setsecctx(*resfh, &open->op_label, open->op_bmval);
@@ -603,6 +606,7 @@ nfsd4_create(struct svc_rqst *rqstp, str
 	if (status)
 		return status;
 
+	current->fs->umask = create->cr_umask;
 	switch (create->cr_type) {
 	case NF4LNK:
 		status = nfsd_symlink(rqstp, &cstate->current_fh,
@@ -611,20 +615,22 @@ nfsd4_create(struct svc_rqst *rqstp, str
 		break;
 
 	case NF4BLK:
+		status = nfserr_inval;
 		rdev = MKDEV(create->cr_specdata1, create->cr_specdata2);
 		if (MAJOR(rdev) != create->cr_specdata1 ||
 		    MINOR(rdev) != create->cr_specdata2)
-			return nfserr_inval;
+			goto out_umask;
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
 				     &create->cr_iattr, S_IFBLK, rdev, &resfh);
 		break;
 
 	case NF4CHR:
+		status = nfserr_inval;
 		rdev = MKDEV(create->cr_specdata1, create->cr_specdata2);
 		if (MAJOR(rdev) != create->cr_specdata1 ||
 		    MINOR(rdev) != create->cr_specdata2)
-			return nfserr_inval;
+			goto out_umask;
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
 				     &create->cr_iattr,S_IFCHR, rdev, &resfh);
@@ -668,6 +674,8 @@ nfsd4_create(struct svc_rqst *rqstp, str
 	fh_dup2(&cstate->current_fh, &resfh);
 out:
 	fh_put(&resfh);
+out_umask:
+	current->fs->umask = 0;
 	return status;
 }
 
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -33,7 +33,6 @@
  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#include <linux/fs_struct.h>
 #include <linux/file.h>
 #include <linux/slab.h>
 #include <linux/namei.h>
@@ -683,7 +682,7 @@ nfsd4_decode_create(struct nfsd4_compoun
 
 	status = nfsd4_decode_fattr(argp, create->cr_bmval, &create->cr_iattr,
 				    &create->cr_acl, &create->cr_label,
-				    &current->fs->umask);
+				    &create->cr_umask);
 	if (status)
 		goto out;
 
@@ -928,7 +927,6 @@ nfsd4_decode_open(struct nfsd4_compounda
 	case NFS4_OPEN_NOCREATE:
 		break;
 	case NFS4_OPEN_CREATE:
-		current->fs->umask = 0;
 		READ_BUF(4);
 		open->op_createmode = be32_to_cpup(p++);
 		switch (open->op_createmode) {
@@ -936,7 +934,7 @@ nfsd4_decode_open(struct nfsd4_compounda
 		case NFS4_CREATE_GUARDED:
 			status = nfsd4_decode_fattr(argp, open->op_bmval,
 				&open->op_iattr, &open->op_acl, &open->op_label,
-				&current->fs->umask);
+				&open->op_umask);
 			if (status)
 				goto out;
 			break;
@@ -951,7 +949,7 @@ nfsd4_decode_open(struct nfsd4_compounda
 			COPYMEM(open->op_verf.data, NFS4_VERIFIER_SIZE);
 			status = nfsd4_decode_fattr(argp, open->op_bmval,
 				&open->op_iattr, &open->op_acl, &open->op_label,
-				&current->fs->umask);
+				&open->op_umask);
 			if (status)
 				goto out;
 			break;
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -118,6 +118,7 @@ struct nfsd4_create {
 	} u;
 	u32		cr_bmval[3];        /* request */
 	struct iattr	cr_iattr;           /* request */
+	int		cr_umask;           /* request */
 	struct nfsd4_change_info  cr_cinfo; /* response */
 	struct nfs4_acl *cr_acl;
 	struct xdr_netobj cr_label;
@@ -228,6 +229,7 @@ struct nfsd4_open {
 	u32		op_why_no_deleg;    /* response - DELEG_NONE_EXT only */
 	u32		op_create;     	    /* request */
 	u32		op_createmode;      /* request */
+	int		op_umask;           /* request */
 	u32		op_bmval[3];        /* request */
 	struct iattr	op_iattr;           /* UNCHECKED4, GUARDED4, EXCLUSIVE4_1 */
 	nfs4_verifier	op_verf __attribute__((aligned(32)));
