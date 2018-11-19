Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC28C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47AC2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5fz5h6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47AC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbeKTDG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:06:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732796AbeKTDG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:06:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CADE21104;
        Mon, 19 Nov 2018 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645736;
        bh=wKyhKdQgokNLP+SXRkyqVcj/mWLryQy9T21+1wwFY9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5fz5h6jFFLB8TYeVb67oBKj1cTA8Y5KZtqTJ5tKV45qwIbU2kWi9Hf+UEVt/wGk2
         euQVbjxYm0XfvfRKTe1k/vby25HK/o7snXWM7J3RE/ut143tVz7GsgN5bLxO9CfMk2
         m0uj9uCmceEHM0u61Jbq7BUERUobeGjyovHfUF4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.18 069/171] Revert "ceph: fix dentry leak in splice_dentry()"
Date:   Mon, 19 Nov 2018 17:27:45 +0100
Message-Id: <20181119162630.930175478@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yan, Zheng <zyan@redhat.com>

commit efe328230dc01aa0b1269aad0b5fae73eea4677a upstream.

This reverts commit 8b8f53af1ed9df88a4c0fbfdf3db58f62060edf3.

splice_dentry() is used by three places. For two places, req->r_dentry
is passed to splice_dentry(). In the case of error, req->r_dentry does
not get updated. So splice_dentry() should not drop reference.

Cc: stable@vger.kernel.org # 4.18+
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/inode.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1135,8 +1135,12 @@ static struct dentry *splice_dentry(stru
 	if (IS_ERR(realdn)) {
 		pr_err("splice_dentry error %ld %p inode %p ino %llx.%llx\n",
 		       PTR_ERR(realdn), dn, in, ceph_vinop(in));
-		dput(dn);
-		dn = realdn; /* note realdn contains the error */
+		dn = realdn;
+		/*
+		 * Caller should release 'dn' in the case of error.
+		 * If 'req->r_dentry' is passed to this function,
+		 * caller should leave 'req->r_dentry' untouched.
+		 */
 		goto out;
 	} else if (realdn) {
 		dout("dn %p (%d) spliced with %p (%d) "


