Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C69C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14272089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBpZrzRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14272089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbeJQBQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:16:07 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCC8020658;
        Tue, 16 Oct 2018 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710681;
        bh=mkXFjRtG8cchR2MSPeYi1VmAOlAUiFk+OaIV6nxMKVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBpZrzRMKdNyR/TO/HT1x2rNtJ1FXINzK3RWUR9AjpiLDcm5uDNOBpXMruIP/WHCo
         KkqoF0mNT4YlGlGqSQzJQWf66qkS8cUPQTN7i5Mx0iSOIScIDMqSQHEE0XkXYQVuyc
         +wqz6JHal+pRw7snWFqQp9TpUxrkTM68J1CbzqGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH 4.9 14/71] ext4: Fix error code in ext4_xattr_set_entry()
Date:   Tue, 16 Oct 2018 19:09:11 +0200
Message-Id: <20181016170540.127292570@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
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

From: Daniel Rosenberg <drosen@google.com>

ext4_xattr_set_entry should return EFSCORRUPTED instead of EIO
for corrupted xattr entries.

Fixes b469713e0c0c ("ext4: add corruption check in ext4_xattr_set_entry()")

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Apply to 4.9

 fs/ext4/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -657,7 +657,7 @@ ext4_xattr_set_entry(struct ext4_xattr_i
 		next = EXT4_XATTR_NEXT(last);
 		if ((void *)next >= s->end) {
 			EXT4_ERROR_INODE(inode, "corrupted xattr entries");
-			return -EIO;
+			return -EFSCORRUPTED;
 		}
 		if (last->e_value_size) {
 			size_t offs = le16_to_cpu(last->e_value_offs);


