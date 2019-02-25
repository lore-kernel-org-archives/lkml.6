Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8EFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CED0213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130106;
	bh=6reO+Yyop2P70NTsb/K8RHdFJsty+To66rzOgTG/OcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FJk9Fo3RJRQ4yuOWm5Z9X3QP0SJYKzn/r4KobFv9KkeGlv7Y83asADzChbj0ty/UE
	 CoMbWdM+pnXoEBbb1rflnTBxYbFkj5RFyKKxt0mrrrdq/3yuFi74+xYIeR8i25Illj
	 G/qR7aFdoAFHlAobb2rTXTRbC4VQHU9P8KDQjvyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfBYV2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731818AbfBYV2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:28:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B5532084D;
        Mon, 25 Feb 2019 21:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130094;
        bh=6reO+Yyop2P70NTsb/K8RHdFJsty+To66rzOgTG/OcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eeytoi8yyrmwJPgwkLN65i3LFHNPvg/jrjLY6BcfFetdpIktMqBrhGXLVODNDNaX4
         eEvdJvJGz9M7lhRcdIoyJfMeol+JN6RC3eyJOlsraveuViaYxRE25WglSG+D48hgA0
         0XBfPjOrYyNJQLtT8vepGZFKAjx0bPpfA0wukzuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.20 013/183] ceph: avoid repeatedly adding inode to mdsc->snap_flush_list
Date:   Mon, 25 Feb 2019 22:09:46 +0100
Message-Id: <20190225195056.893530517@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yan, Zheng <zyan@redhat.com>

commit 04242ff3ac0abbaa4362f97781dac268e6c3541a upstream.

Otherwise, mdsc->snap_flush_list may get corrupted.

Cc: stable@vger.kernel.org
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/snap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -616,7 +616,8 @@ int __ceph_finish_cap_snap(struct ceph_i
 	     capsnap->size);
 
 	spin_lock(&mdsc->snap_flush_lock);
-	list_add_tail(&ci->i_snap_flush_item, &mdsc->snap_flush_list);
+	if (list_empty(&ci->i_snap_flush_item))
+		list_add_tail(&ci->i_snap_flush_item, &mdsc->snap_flush_list);
 	spin_unlock(&mdsc->snap_flush_lock);
 	return 1;  /* caller may want to ceph_flush_snaps */
 }


