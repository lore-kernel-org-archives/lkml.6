Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79B6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05F82145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjNrh9NE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05F82145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbeKTDFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:05:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731409AbeKTDFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:05:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8DA206BA;
        Mon, 19 Nov 2018 16:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645695;
        bh=/CeZ3oNN/lXpo68nsw6+FLZwyB5ckAxqzju/wI/+m3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tjNrh9NEBmQBwis6hbyM3T13gAJGdlDXZx/JsOFhQoOok4+mHaojp78oLxHFV7ROd
         4diN43AMUsEPFXrsrUpXO7hysfcgMwWgOPDIEy21BbnS+s96B0rksKfMv7fJ4R+i0D
         5RhCD/+Pg52duOaa/mRhQrcHc9tDDxZwYu4eswOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.18 037/171] ovl: check whiteout in ovl_create_over_whiteout()
Date:   Mon, 19 Nov 2018 17:27:13 +0100
Message-Id: <20181119162625.799535834@linuxfoundation.org>
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

From: Miklos Szeredi <mszeredi@redhat.com>

commit 5e1275808630ea3b2c97c776f40e475017535f72 upstream.

Kaixuxia repors that it's possible to crash overlayfs by removing the
whiteout on the upper layer before creating a directory over it.  This is a
reproducer:

 mkdir lower upper work merge
 touch lower/file
 mount -t overlay overlay -olowerdir=lower,upperdir=upper,workdir=work merge
 rm merge/file
 ls -al merge/file
 rm upper/file
 ls -al merge/
 mkdir merge/file

Before commencing with a vfs_rename(..., RENAME_EXCHANGE) verify that the
lookup of "upper" is positive and is a whiteout, and return ESTALE
otherwise.

Reported by: kaixuxia <xiakaixu1987@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: e9be9d5e76e3 ("overlay filesystem")
Cc: <stable@vger.kernel.org> # v3.18
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/dir.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -461,6 +461,10 @@ static int ovl_create_over_whiteout(stru
 	if (IS_ERR(upper))
 		goto out_unlock;
 
+	err = -ESTALE;
+	if (d_is_negative(upper) || !IS_WHITEOUT(d_inode(upper)))
+		goto out_dput;
+
 	newdentry = ovl_create_temp(workdir, cattr);
 	err = PTR_ERR(newdentry);
 	if (IS_ERR(newdentry))


