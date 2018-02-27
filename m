Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-351074-1519705913-2-14575037916702856837
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519705912; b=sKGBv4cXK7qCOHgep7y6jDUrM4FsynLhP+aVHgPiC14s5Ub
    6sfLaHHWEi7c4E/y7c7gNgkdilYzsQK8JPijw7T0u5bvsG8OMn6CvQzYIxsCqnX2
    f307I+9Im41LB+FLwiGlCpMe++QyBGSXEQkapWpuFAbMXCMyXFoGjwY4MSd3kXuy
    P/0Cb11/Gfkf07gLgHCufoixSvHrM4JFTkUfOUUXTDGW/jEyMp0r0rqd4r7M7D6D
    hl7zcPsnFFCK6KlilBB0zDziKT0wyb1GIOzJBRT49V2rkvw5+3Zbm5Bnlto3vi51
    YIEpEyohx13WkGJ8B9S70bPlgBs7u7wzkJtshWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519705912; bh=N7Zk4Q1Z+WvEcVsk572k+GFsWhFNvkQOlJqRhRfbvFY=; b=u
    rzMSFnaXYzA0FqYsvhdjwwrRMVywgIyE9BlvRIaPzUB5Wf/yacDaxNTow27CNTh3
    bsAMhC2OiRcQOsT7zmjoXWczemDSNALYZcwtACbq+nlUNL19nWtTahmE6LVRHIz7
    I1X/svqtqKFD8EXRmxaz6k3yRwrvHAMY8ZLoib1yf6aF7BVC72Wz24hvkDyYoQ+0
    /RCaeo/5OsnkfVBdZ5NAGS7vLtzlhcG8jZX0ihqCaz7knO5E3Xfr220V5cm33Tt2
    CMsKqNvdlROq5Ihj7oXqBhCERo0/Fu1GacTcRsY1rE3mXsnUroD31i8ceBTcDYu5
    7mPVQnxUwRoolcyNJQwrg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeB0E3b (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 23:29:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:42250 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbeB0E31 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 23:29:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="20559846"
Subject: [PATCH v4 05/12] ext4,
 dax: define ext4_dax_*() infrastructure in all cases
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jan Kara <jack@suse.com>
Date: Mon, 26 Feb 2018 20:20:21 -0800
Message-ID: <151970522183.26729.1211859822335015752.stgit@dwillia2-desk3.amr.corp.intel.com>
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

In preparation for fixing S_DAX to be defined in the CONFIG_FS_DAX=n +
CONFIG_DEV_DAX=y case, move the definition of these routines outside of
the "#ifdef CONFIG_FS_DAX" guard. This is also a coding-style fix to
move all ifdef handling to header files rather than in the source. The
compiler will still be able to determine that all the related code can
be discarded in the CONFIG_FS_DAX=n case.

Cc: Jan Kara <jack@suse.com>
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/ext4/file.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index fb6f023622fe..51854e7608f0 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -34,7 +34,6 @@
 #include "xattr.h"
 #include "acl.h"
 
-#ifdef CONFIG_FS_DAX
 static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -60,7 +59,6 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	file_accessed(iocb->ki_filp);
 	return ret;
 }
-#endif
 
 static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -70,10 +68,8 @@ static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
-#ifdef CONFIG_FS_DAX
 	if (IS_DAX(file_inode(iocb->ki_filp)))
 		return ext4_dax_read_iter(iocb, to);
-#endif
 	return generic_file_read_iter(iocb, to);
 }
 
@@ -179,7 +175,6 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	return iov_iter_count(from);
 }
 
-#ifdef CONFIG_FS_DAX
 static ssize_t
 ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
@@ -208,7 +203,6 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ret = generic_write_sync(iocb, ret);
 	return ret;
 }
-#endif
 
 static ssize_t
 ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
