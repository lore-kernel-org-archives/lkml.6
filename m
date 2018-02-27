Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-351074-1519705946-2-6365248406300968744
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519705945; b=fr9t33Zg+k9N1GnGWU6758OlaG/mo+esYVMHxSBqCOvAw25
    trbPmVQBF8dSR8fNZN2nlGA4vTxpZDUXGTQA0XOt+XbyQauSbW7yGkrEb+wqo9mn
    tYQt8SOGCp4hGVKN7vupo+Fw/SeC4Z7G+7OO6MF43NxYNO67QVwHnm5H0shSa0EU
    ubbDFHuGDobifM/BzYcYbjo3K1hJ0l9r5WcTmun8INbK4/nMKVYj62GLPCJ08VDs
    Doi4KxO81UVw69DNubRKiAzT1hQuGXiiXug+4sgbq5Hu+ugCcNTelH+cy9GVWJOw
    SIpbChxP7JM9UiuegzkeWZZ5wlN9Rw0fynABEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519705945; bh=7UCf6spm4yGXGg8DrN1jP+pfwOFMv+Ae1bAjGSHmVbk=; b=k
    RhOlkoSUpi0+fAh3wYzy1i3Omwg2xPy7pwGlirbp9t7UI802LNs9U8fsvWk6VO+r
    OsAeJY4iDpRMSQ1hQhSatjzh/2HXfbk4AlVLY7fCxIotoFe1CiNQUb7ZxsYIHKJN
    uw0TyfovzNW/RgdoLqVgx3yij30h6qiS59sgVB+TF9D8K+ik64pxGX4S1AoXimPC
    I1+8nLz9PH/F1hNLlTRV7mPD5PLDSPUSoFjIBs2PiYUMKhvp9CgAekar3xdziEvb
    OLJzQtg83tTLnJNTH9GxsRT7B5FkPr+0HdSwf0GsBSw2+vrBiC/auaUF9AW89FOe
    A/RZuipMkt/DX1IRj6a1A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeB0E3N (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 23:29:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:32552 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751591AbeB0E3L (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 23:29:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="33879271"
Subject: [PATCH v4 02/12] dax: introduce IS_DEVDAX() and IS_FSDAX()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "supporter:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        linux-mm@kvack.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Mon, 26 Feb 2018 20:20:05 -0800
Message-ID: <151970520551.26729.12707678649514382892.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The current IS_DAX() helper that checks the S_DAX inode flag is
ambiguous, and currently has the broken assumption that the S_DAX flag
is only non-zero in the CONFIG_FS_DAX=y case. In preparation for
defining S_DAX to non-zero in the  CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y
case, introduce two explicit helpers to replace IS_DAX().

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org (supporter:XFS FILESYSTEM)
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Reported-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/fs.h |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 79c413985305..bd0c46880572 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1909,6 +1909,28 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
 				 (inode)->i_rdev == WHITEOUT_DEV)
 
+static inline bool IS_DEVDAX(struct inode *inode)
+{
+	if (!IS_ENABLED(CONFIG_DEV_DAX))
+		return false;
+	if ((inode->i_flags & S_DAX) == 0)
+		return false;
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
+	if (S_ISCHR(inode->i_mode))
+		return false;
+	return true;
+}
+
 static inline bool HAS_UNMAPPED_ID(struct inode *inode)
 {
 	return !uid_valid(inode->i_uid) || !gid_valid(inode->i_gid);
