Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C111C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27E52089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079507;
	bh=Jyt+9W8uKbUBKGNlD9c8zRkAcVhNGchBv0Vm5n8vGV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qInt7CBC4yXox2PNbVBVV4A+/yG0AQDHNii5e8gyq5t+zVGltklBv99FJkG0ISCXL
	 WURxoOKOvG0WtW79F5Od7QhOm932C9FMX2QZ981p4uatZNzBVyfOkHr6qXgqQDSx6d
	 tW/XCUN5EZId1ylN+F6jLu4KYMavB17xR5nlkCv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfAUOFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732640AbfAUOB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:01:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A092C2089F;
        Mon, 21 Jan 2019 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079287;
        bh=Jyt+9W8uKbUBKGNlD9c8zRkAcVhNGchBv0Vm5n8vGV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y5luE4noYeCb8vcTB92RaNa3H9GMTQZPBFrXdfBhCKZIsMEnFyL25qQ6KWh3R+DwB
         nVMzbZOMTvEVCIPedbCM0moOLj2iuJnoe4LJrVS+Vyq25s8KpTU+R033RV9wT9n5Rr
         Zj7wMCZUbj4PNm3raOrwVGpRgoMkK3iJdJBDrnYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.19 71/99] selinux: fix GPF on invalid policy
Date:   Mon, 21 Jan 2019 14:49:03 +0100
Message-Id: <20190121134916.696654490@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

From: Stephen Smalley <sds@tycho.nsa.gov>

commit 5b0e7310a2a33c06edc7eb81ffc521af9b2c5610 upstream.

levdatum->level can be NULL if we encounter an error while loading
the policy during sens_read prior to initializing it.  Make sure
sens_destroy handles that case correctly.

Reported-by: syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/policydb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -732,7 +732,8 @@ static int sens_destroy(void *key, void
 	kfree(key);
 	if (datum) {
 		levdatum = datum;
-		ebitmap_destroy(&levdatum->level->cat);
+		if (levdatum->level)
+			ebitmap_destroy(&levdatum->level->cat);
 		kfree(levdatum->level);
 	}
 	kfree(datum);


