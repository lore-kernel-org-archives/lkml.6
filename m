Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802185-2-13572234176649135920
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802184; b=IAiGCYdTLDR2yB9p3Q0HXpWXZSDKUXvBxoollKxY+KiZd0I
    Ar3aRioA+FCEm/XlG4ckK6Ysk/RdBnYleNehDhvvAbAJm97aZh69TpMzDYKjkbgC
    /T4cJ8TgdQVLrAXV/nMfi08LiaPGa3q+uKuElLagNUmqGpb6rDX6hc7CzQoigSGj
    PbQFOCK2D089RlEbCYonEw8LwqUlSIU2FcMCKdvOA6T+mi4IAJ5PvkSThCAvsjAh
    P2KnHCRZ24ONqb+Up8hQ1ccD5/jRtbsv69IpES8eURm1fyACfwyvONnmaZg55wEk
    PYZBwx7UPQACu7YPmHbqwLF7JHVv/QD06oUHN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802184; bh=8Xw8b92N97xANLFJyW4txNvaHQ
    i3cWG4SP24m9+q144=; b=Rvq984xUrr2Z9n0dL2Mi0/wVwZcXkiJCbrdbDm4A+K
    CH899NId+cDfl3CjpQVPXCnWL5Rw1vJkrrQ3AxOkMvlSCHcV6u/P7+PGlSlQlWUa
    1dFVFGER2+yvkOwCLqqx+cU1J8WWdNhY1Yhzi9JF/3eQ+ZRXWSMYvSX/BQIcEEnr
    a1DsZHzrMXd/789OCBbtZtkfIgt4WR0kW/tEph7gjcywGOjE/BXgsEHRL6lMESCQ
    L7qFpbJvwx2qVnNQ0i06TZr5JuOmnFIvgzfxohZPNBywapuumfZkxfrKtcJaH8/A
    kYG1oDXb17daq7bekXotl6jzC0ysHyFKAl0/NjLN26/w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeCWKtb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:49:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933376AbeCWKOt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 45/97] NFS: dont try to cross a mountpount when there isnt one there.
Date: Fri, 23 Mar 2018 10:54:32 +0100
Message-Id: <20180323094200.159240849@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>


[ Upstream commit 99bbf6ecc694dfe0b026e15359c5aa2a60b97a93 ]

consider the sequence of commands:
 mkdir -p /import/nfs /import/bind /import/etc
 mount --bind / /import/bind
 mount --make-private /import/bind
 mount --bind /import/etc /import/bind/etc

 exportfs -o rw,no_root_squash,crossmnt,async,no_subtree_check localhost:/
 mount -o vers=4 localhost:/ /import/nfs
 ls -l /import/nfs/etc

You would not expect this to report a stale file handle.
Yet it does.

The manipulations under /import/bind cause the dentry for
/etc to get the DCACHE_MOUNTED flag set, even though nothing
is mounted on /etc.  This causes nfsd to call
nfsd_cross_mnt() even though there is no mountpoint.  So an
upcall to mountd for "/etc" is performed.

The 'crossmnt' flag on the export of / causes mountd to
report that /etc is exported as it is a descendant of /.  It
assumes the kernel wouldn't ask about something that wasn't
a mountpoint.  The filehandle returned identifies the
filesystem and the inode number of /etc.

When this filehandle is presented to rpc.mountd, via
"nfsd.fh", the inode cannot be found associated with any
name in /etc/exports, or with any mountpoint listed by
getmntent().  So rpc.mountd says the filehandle doesn't
exist. Hence ESTALE.

This is fixed by teaching nfsd not to trust DCACHE_MOUNTED
too much.  It is just a hint, not a guarantee.
Change nfsd_mountpoint() to return '1' for a certain mountpoint,
'2' for a possible mountpoint, and 0 otherwise.

Then change nfsd_crossmnt() to check if follow_down()
actually found a mountpount and, if not, to avoid performing
a lookup if the location is not known to certainly require
an export-point.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/vfs.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -92,6 +92,12 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, s
 	err = follow_down(&path);
 	if (err < 0)
 		goto out;
+	if (path.mnt == exp->ex_path.mnt && path.dentry == dentry &&
+	    nfsd_mountpoint(dentry, exp) == 2) {
+		/* This is only a mountpoint in some other namespace */
+		path_put(&path);
+		goto out;
+	}
 
 	exp2 = rqst_exp_get_by_name(rqstp, &path);
 	if (IS_ERR(exp2)) {
@@ -165,16 +171,26 @@ static int nfsd_lookup_parent(struct svc
 /*
  * For nfsd purposes, we treat V4ROOT exports as though there was an
  * export at *every* directory.
+ * We return:
+ * '1' if this dentry *must* be an export point,
+ * '2' if it might be, if there is really a mount here, and
+ * '0' if there is no chance of an export point here.
  */
 int nfsd_mountpoint(struct dentry *dentry, struct svc_export *exp)
 {
-	if (d_mountpoint(dentry))
+	if (!d_inode(dentry))
+		return 0;
+	if (exp->ex_flags & NFSEXP_V4ROOT)
 		return 1;
 	if (nfsd4_is_junction(dentry))
 		return 1;
-	if (!(exp->ex_flags & NFSEXP_V4ROOT))
-		return 0;
-	return d_inode(dentry) != NULL;
+	if (d_mountpoint(dentry))
+		/*
+		 * Might only be a mountpoint in a different namespace,
+		 * but we need to check.
+		 */
+		return 2;
+	return 0;
 }
 
 __be32
