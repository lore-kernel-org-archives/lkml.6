Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40A7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B367213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2gT6Ckdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B367213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbeK3B33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:29:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730150AbeK3B31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 186CC205C9;
        Thu, 29 Nov 2018 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501435;
        bh=KN8hxaIFzkBr89gqtihj1rAuMgtAlFI7O5ztYo+R1tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2gT6CkdqFFFYBi3TrPMnHqdy10F/Icy+j5F9WpVSbwmrygzVmdOY4g2PkV4ltSJrZ
         AH4L1A4r+dDL3A8U3KEoOJXkSmtnmM/1c2gDzRrhMKlCoeF9bT05sT6HomAsa+Up83
         DgE4mKAPXCZlzxyj0GWa/nV3S4rdEdoCQoPIitk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aditya Kali <adityakali@google.com>
Subject: [PATCH 4.9 88/92] Revert "evm: Translate user/group ids relative to s_user_ns when computing HMAC"
Date:   Thu, 29 Nov 2018 15:12:57 +0100
Message-Id: <20181129140113.878468514@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit 19339c251607a3defc7f089511ce8561936fee45 upstream.

This reverts commit 0b3c9761d1e405514a551ed24d3ea89aea26ce14.

Seth Forshee <seth.forshee@canonical.com> writes:
> All right, I think 0b3c9761d1e405514a551ed24d3ea89aea26ce14 should be
> reverted then. EVM is a machine-local integrity mechanism, and so it
> makes sense that the signature would be based on the kernel's notion of
> the uid and not the filesystem's.

I added a commment explaining why the EVM hmac needs to be in the
kernel's notion of uid and gid, not the filesystems to prevent
remounting the filesystem and gaining unwaranted trust in files.

Acked-by: Seth Forshee <seth.forshee@canonical.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Aditya Kali <adityakali@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/integrity/evm/evm_crypto.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -152,8 +152,16 @@ static void hmac_add_misc(struct shash_d
 	memset(&hmac_misc, 0, sizeof(hmac_misc));
 	hmac_misc.ino = inode->i_ino;
 	hmac_misc.generation = inode->i_generation;
-	hmac_misc.uid = from_kuid(inode->i_sb->s_user_ns, inode->i_uid);
-	hmac_misc.gid = from_kgid(inode->i_sb->s_user_ns, inode->i_gid);
+	/* The hmac uid and gid must be encoded in the initial user
+	 * namespace (not the filesystems user namespace) as encoding
+	 * them in the filesystems user namespace allows an attack
+	 * where first they are written in an unprivileged fuse mount
+	 * of a filesystem and then the system is tricked to mount the
+	 * filesystem for real on next boot and trust it because
+	 * everything is signed.
+	 */
+	hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
+	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
 	hmac_misc.mode = inode->i_mode;
 	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
 	if (evm_hmac_attrs & EVM_ATTR_FSUUID)


