Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2297825-1520018149-2-13032804188052999206
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520018147; b=KxxlYbU51IuswUjb3OKwxSjo68llhJPPc3HBODRTe2txHMp
    bVYYfPtczP1k1pQrZhBBSHuzpIPDkS8/CCBIgJPu0LCK4rTqxVJGTA6gEpZ+pcnB
    PX+p/NafoS67wr+kc9uxbPpAUyZDDjIwQVjCZ3bVu61BXciKF0jm0vHNgeTn1HLk
    BEVHcI2sfhyJl5m5SS4Pp0k9+bxuHvJdsexZddgv8x+IberZMKiyNtpyRW8ANT2O
    AtO8yjKoGXEiQ2G2tKM79Sj4jQMo+dzQ3Het4IOmQOy/xAsKBHpVLwI1pejtHWtD
    dyxVcDuUzkAY1s8atcWrmMqKPCWh5L+/yOs6T6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520018147; bh=Hhhu/8+HWBL0A7i2E4Qu43/EN7uCC0MrFyET/cxd9Y0=; b=U
    iDI3KpNbmou8Bs+k2sM6ts613abwI/LQ4F2aKEI2ykdv4JRWYl/8NKNb5WEkHVJS
    53vsC5Ik2MDGoPyvXwgxmAzshD+ukCaFjk/AmkRD6xc/wnYiDFO2EzOVrWqo9sSp
    FjlpUaLBAV9aoqclF8GP6bYNkoLcxg/FtoUTvEs5RshDShL2QQ+P4xrv7BY58Sm/
    GgWpCGI6/14I579HRNpxzYibrvLUfK1uF1kMxJlIMLM9++nop0ATFKMUfl3SzAA0
    08gUnE3rDS+BnPnIXUh5OWs9i4xZ5PlRxOA0gvW+vjeqcCNec/Pyz/+HtKfM6AEs
    iSWoYk0+trS+k/n4xLp4w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426302AbeCBTPo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 14:15:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:4817 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423640AbeCBTPn (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 14:15:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,413,1515484800";
   d="scan'208";a="22401525"
Subject: [PATCH v6] dax: introduce IS_DEVDAX() and IS_FSDAX()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date: Fri, 02 Mar 2018 11:06:36 -0800
Message-ID: <152001757529.22146.17936438768625217740.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <CAPcyv4iu32ja_vPiN=E0DP7_PFaj887XQ48EOMupE0Q4p1dCkQ@mail.gmail.com>
References: <CAPcyv4iu32ja_vPiN=E0DP7_PFaj887XQ48EOMupE0Q4p1dCkQ@mail.gmail.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The current IS_DAX() helper that checks if a file is in DAX mode serves
two purposes. It is a control flow branch condition for DAX vs
non-DAX paths and it is a mechanism to perform dead code elimination. The
dead code elimination is required in the CONFIG_FS_DAX=n case since
there are symbols in fs/dax.c that will be elided. While the
dead code elimination can be addressed with nop stubs for the fs/dax.c
symbols that does not address the need for a DAX control flow helper
where fs/dax.c symbols are not involved.

Moreover, the control flow changes, in some cases, need to be cognizant
of whether the DAX file is a typical file or a Device-DAX special file.
Introduce IS_DEVDAX() and IS_FSDAX() to simultaneously address the
file-type control flow and dead-code elimination use cases. IS_DAX()
will be deleted after all sites are converted to use the file-type
specific helper.

Note, this change is also a pre-requisite for fixing the definition of
the S_DAX inode flag in the CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case.
The flag needs to be defined, non-zero, if either DAX facility is
enabled.

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Reported-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v5:
* add comments to clarify the S_ISCHR() checks (Darrick)

 include/linux/fs.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 79c413985305..751975b8b29b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1909,6 +1909,30 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
 				 (inode)->i_rdev == WHITEOUT_DEV)
 
+static inline bool IS_DEVDAX(struct inode *inode)
+{
+	if (!IS_ENABLED(CONFIG_DEV_DAX))
+		return false;
+	if ((inode->i_flags & S_DAX) == 0)
+		return false;
+	/* regular files with S_DAX are filesystem-dax instances */
+	if (!S_ISCHR(inode->i_mode))
+		return false;
+	return true;
+}
+
+static inline bool IS_FSDAX(struct inode *inode)
+{
+	if (!IS_ENABLED(CONFIG_FS_DAX))
+		return false;
+	if ((inode->i_flags & S_DAX) == 0)
+		return false;
+	/* character devices with S_DAX are device-dax instances */
+	if (S_ISCHR(inode->i_mode))
+		return false;
+	return true;
+}
+
 static inline bool HAS_UNMAPPED_ID(struct inode *inode)
 {
 	return !uid_valid(inode->i_uid) || !gid_valid(inode->i_gid);
