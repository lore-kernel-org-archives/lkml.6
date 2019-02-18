Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD76C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF4221904
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497970;
	bh=JKW9zQAikkGlLnKQVsFoolO9Y+11ZHGvrgbhgB5VP1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NKltGuIitrR08CVxTXfhhQbLn3tnclag7ZSOVKCHX7j9OGshttHACTxe2flOHPfBt
	 cGlHGVM6YgWnXq56A7khAldX7lS2V1k04Fx7LU6fsbRY9oejZbSU4b73hUSU6ricn1
	 3oqOdviHP5DiKILLnxT7B14Wrd02MgoFh819OYjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbfBRNwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:52:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731635AbfBRNwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:52:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A19E21901;
        Mon, 18 Feb 2019 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497966;
        bh=JKW9zQAikkGlLnKQVsFoolO9Y+11ZHGvrgbhgB5VP1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfjwIzx9aTdgaI0uxo+lOXSss3CzCHzHLz3SB1m18z9u6N51c6MbqNlp27fnHHIHe
         Yu0Q2Otepw91QHKdyINZyYKaG4Ig9PwA/kdmSrJ5Bz3xUE4wvhqP0KfNEaLGZRPwyn
         5DKOY/gpBsLQrEnZurDccXngK0CQ07BuEZbkLFqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.19 67/85] Revert "nfsd4: return default lease period"
Date:   Mon, 18 Feb 2019 14:43:33 +0100
Message-Id: <20190218133506.397572778@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: J. Bruce Fields <bfields@redhat.com>

commit 3bf6b57ec2ec945e5a6edf5c202a754f1e852ecd upstream.

This reverts commit d6ebf5088f09472c1136cd506bdc27034a6763f8.

I forgot that the kernel's default lease period should never be
decreased!

After a kernel upgrade, the kernel has no way of knowing on its own what
the previous lease time was.  Unless userspace tells it otherwise, it
will assume the previous lease period was the same.

So if we decrease this value in a kernel upgrade, we end up enforcing a
grace period that's too short, and clients will fail to reclaim state in
time.  Symptoms may include EIO and log messages like "NFS:
nfs4_reclaim_open_state: Lock reclaim failed!"

There was no real justification for the lease period decrease anyway.

Reported-by: Donald Buczek <buczek@molgen.mpg.de>
Fixes: d6ebf5088f09 "nfsd4: return default lease period"
Cc: stable@vger.kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfsctl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1239,8 +1239,8 @@ static __net_init int nfsd_init_net(stru
 	retval = nfsd_idmap_init(net);
 	if (retval)
 		goto out_idmap_error;
-	nn->nfsd4_lease = 45;	/* default lease time */
-	nn->nfsd4_grace = 45;
+	nn->nfsd4_lease = 90;	/* default lease time */
+	nn->nfsd4_grace = 90;
 	nn->somebody_reclaimed = false;
 	nn->clverifier_counter = prandom_u32();
 	nn->clientid_counter = prandom_u32();


