Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF82C2F3C7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0B52084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078796;
	bh=GzvqODxA+6f4+5xzp67zgFy+DhOH4CCIUTi/sBJbUxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B9+B/2sDn3843cfUExPL5iQt+Tv3D+lO0S3d7ZCeEWIw7wTQZOR9QQ9fZB0fWDuvR
	 lSv31sg3uDNxPf2KLHc/nRMTv2OVGqHDmytXp5Jpf+h+rMK3kjfAF2a7hKgSiyz28k
	 /1lVYaT5Jf7ntgrQWLamVQF8yJh8OyEORBHn/VKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfAUNxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:53:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731202AbfAUNxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:53:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D3212089F;
        Mon, 21 Jan 2019 13:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078791;
        bh=GzvqODxA+6f4+5xzp67zgFy+DhOH4CCIUTi/sBJbUxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JIhiLjm+xyJklWiP9TlrCyy2GcYV3ARNu4hoKwTfvtZs3V7bntQ/jK/ihOtuucJ5T
         GfWTYIxQuPHZ4mJgiKR4v4lmI5nY90T0hJ+uPfWCOVe8j44L/44PJhlkjiP1g+PQbJ
         xPOhhCqyzGhZBRXOZl0M11OrjZyQpLYWjyXuGIaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.14 45/59] selinux: fix GPF on invalid policy
Date:   Mon, 21 Jan 2019 14:44:10 +0100
Message-Id: <20190121122501.774021716@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -730,7 +730,8 @@ static int sens_destroy(void *key, void
 	kfree(key);
 	if (datum) {
 		levdatum = datum;
-		ebitmap_destroy(&levdatum->level->cat);
+		if (levdatum->level)
+			ebitmap_destroy(&levdatum->level->cat);
 		kfree(levdatum->level);
 	}
 	kfree(datum);


