Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BCAC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA3F2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVmua0BH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA3F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeJKXD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJKXD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:03:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32B972087A;
        Thu, 11 Oct 2018 15:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272175;
        bh=mfZO2Q3c7XTyGnaKIB3+DeTfvaZaceSMeUH/Du7ABwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVmua0BHtGVxLluy9xajUB2lGdGAdFUo5Yeeq7eFSluN0P6alg87xabGXmvTvVRte
         8eynvci5QRBSgFBYbathu/Wlsk4ASToO2n9OCAZMYUC6kCI9IWNFfjt/b/ebqhvU3A
         zhuYXnjGReya6izxU9lH5M9echNC4EAi6Se6mMs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Dongyang <dongyangli@ddn.com>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 3.18 016/120] ext4: dont mark mmp buffer head dirty
Date:   Thu, 11 Oct 2018 17:33:17 +0200
Message-Id: <20181011152550.241891546@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Dongyang <dongyangli@ddn.com>

commit fe18d649891d813964d3aaeebad873f281627fbc upstream.

Marking mmp bh dirty before writing it will make writeback
pick up mmp block later and submit a write, we don't want the
duplicate write as kmmpd thread should have full control of
reading and writing the mmp block.
Another reason is we will also have random I/O error on
the writeback request when blk integrity is enabled, because
kmmpd could modify the content of the mmp block(e.g. setting
new seq and time) while the mmp block is under I/O requested
by writeback.

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/mmp.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -48,7 +48,6 @@ static int write_mmp_block(struct super_
 	 */
 	sb_start_write(sb);
 	ext4_mmp_csum_set(sb, mmp);
-	mark_buffer_dirty(bh);
 	lock_buffer(bh);
 	bh->b_end_io = end_buffer_write_sync;
 	get_bh(bh);


