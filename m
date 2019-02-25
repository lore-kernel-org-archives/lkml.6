Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0907FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2B7213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129178;
	bh=bSxdIlcHSQca0Ah/rQhfFUTc5EUJYt82dlO5Dpa8I2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aWfPqra+65F3jut+/9IkED2KKeorJcyf7hjw7aB/LqxNt/QfTXT9yEA7DC44+YaSv
	 tOZJwNUefVTKRXTsJMNWZjnLQ10Le/3uBGQ9ANrbxJF3swvNIC7VKTXUBKYXokLy27
	 1ez7SmaGC9m5O05bJr9nM+0IcwHnMmlv4FRlB9BA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfBYVM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:12:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfBYVMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:12:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D73BF2084D;
        Mon, 25 Feb 2019 21:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129174;
        bh=bSxdIlcHSQca0Ah/rQhfFUTc5EUJYt82dlO5Dpa8I2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbm18G6a5uyq+enlrWO9nUZ1Let/uCC+AJzl8ZKp0C6wNcEb4e1AI3kce7qfaMCd/
         ohA43BKU2IVcVcdjJjZedimVP5B9kM7qcAYarm/6vHpSqk47WANvCMVmt+LelhrSg5
         dIC3miJSrb6QlBwjBOP28ni1f88hBPnfRjflwTZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.9 03/63] ceph: avoid repeatedly adding inode to mdsc->snap_flush_list
Date:   Mon, 25 Feb 2019 22:11:03 +0100
Message-Id: <20190225195035.979517388@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -609,7 +609,8 @@ int __ceph_finish_cap_snap(struct ceph_i
 	     capsnap->size);
 
 	spin_lock(&mdsc->snap_flush_lock);
-	list_add_tail(&ci->i_snap_flush_item, &mdsc->snap_flush_list);
+	if (list_empty(&ci->i_snap_flush_item))
+		list_add_tail(&ci->i_snap_flush_item, &mdsc->snap_flush_list);
 	spin_unlock(&mdsc->snap_flush_lock);
 	return 1;  /* caller may want to ceph_flush_snaps */
 }


