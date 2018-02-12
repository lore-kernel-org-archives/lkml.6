Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2501154-1518476781-2-10761395341897098453
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518476780; b=JFp6RmV/gGH0EiJaqggaC7pwaIGXprBVaZP3SEG5OLS5LI4
    w9UWr8xBL2Yi6nIPQLmCa9tHh/5hRMa1B8nfbVeaJDFPcph9WkScYFIwNZKOtfOZ
    TIgOHhkLjsjK1fI64DW4WgrGcvBMASg9iXDsuVC/v6CxYYHz3TWTNr1+d6OGpVA0
    8aghrEY9ficYOEMMRIU1ab4iNOOkfIX97yhE/kElMh5e+s/jmpsvhCP6esZMlhr5
    7q7O/0eIZihbXupMFeB6+eL9+WgiJF3i6/4IU+Y0c82je/aMEogL797BNwERD8hs
    9ubNAOJoXKWe3Cd7jSVXECW0D1Gvd7nt2392d2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518476780; bh=/yU9YTK3qgmXGPVh04Y51XjBaW
    bBhbt+rYzcLsgsKOk=; b=w0YQdDppA7X6hsiuFyMlQFCNYvidGmOnmeGuZLOJxP
    G9zNrzXaECzX9304uawWzFJTDbrhf34lqTB3mRXVb+lRvYxq7Y1/mA8KjLcdLHYh
    yLeQabeM9ntnJBAoTjqRIzEQtpGNZ7mjl0+zaCQkeF/TiOkR/LAsE03ExI3+gw58
    ZSoclRUdH6STph5RwzN+LuJxfVg5yH30pV+T7F70lIweRhb2tLyYff/4tD0jFD6h
    UntZSApEe56iG1HPn3+wCdomyuVGPQhC9edXo3ig79PKq/kO8IOAMO/dkVOvXsij
    +Jxfu0oel4JvT6ponoNOQHSXXOQHjK2dQt7ro/g793tQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932378AbeBLXGR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 18:06:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:6746 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932336AbeBLXGR (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 12 Feb 2018 18:06:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,504,1511856000";
   d="scan'208";a="17619324"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-nvdimm@lists.01.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: [PATCH] loop: Fix lost writes caused by missing flag
Date: Mon, 12 Feb 2018 16:05:58 -0700
Message-Id: <20180212230558.5546-1-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following commit:

commit aa4d86163e4e ("block: loop: switch to VFS ITER_BVEC")

replaced __do_lo_send_write(), which used ITER_KVEC iterators, with
lo_write_bvec() which uses ITER_BVEC iterators.  In this change, though,
the WRITE flag was lost:

-       iov_iter_kvec(&from, ITER_KVEC | WRITE, &kvec, 1, len);
+       iov_iter_bvec(&i, ITER_BVEC, bvec, 1, bvec->bv_len);

This flag is necessary for the DAX case because we make decisions based on
whether or not the iterator is a READ or a WRITE in dax_iomap_actor() and
in dax_iomap_rw().

We end up going through this path in configurations where we combine a PMEM
device with 4k sectors, a loopback device and DAX.  The consequence of this
missed flag is that what we intend as a write actually turns into a read in
the DAX code, so no data is ever written.

The very simplest test case is to create a loopback device and try and
write a small string to it, then hexdump a few bytes of the device to see
if the write took.  Without this patch you read back all zeros, with this
you read back the string you wrote.

For XFS this causes us to fail or panic during the following xfstests:

	xfs/074 xfs/078 xfs/216 xfs/217 xfs/250

For ext4 we have a similar issue where writes never happen, but we don't
currently have any xfstests that use loopback and show this issue.

Fix this by restoring the WRITE flag argument to iov_iter_bvec().  This
causes the xfstests to all pass.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Fixes: commit aa4d86163e4e ("block: loop: switch to VFS ITER_BVEC")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: stable@vger.kernel.org
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d5fe720cf149..89d2ee00cced 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -266,7 +266,7 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 	struct iov_iter i;
 	ssize_t bw;
 
-	iov_iter_bvec(&i, ITER_BVEC, bvec, 1, bvec->bv_len);
+	iov_iter_bvec(&i, ITER_BVEC | WRITE, bvec, 1, bvec->bv_len);
 
 	file_start_write(file);
 	bw = vfs_iter_write(file, &i, ppos, 0);
-- 
2.14.3
