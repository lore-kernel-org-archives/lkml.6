Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DC8C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE9E208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcDpkal3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE9E208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404800AbeKLIYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:24:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731242AbeKLIYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:24:38 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE1921707;
        Sun, 11 Nov 2018 22:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975680;
        bh=4goLLtNh8Q3aGv/hg+Qak8fRI/tslYzYZFOvGlgK4i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcDpkal31Vl6O2U4d3kRmN1DH1EfvcPF96Rp27dY+UmKdAZE8vwc4rJifpwmBi1XI
         3NPSKyU7FlcL2tu5l4FNLvRmriDA5bqYnCCaQw9DdvPsgJMXXb4qhsa9mkR8zPT4BF
         I3SsuvLSbShSA2X15n2gYziQjmqGJhfTYdjcTGrQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Shilong <wshilong@ddn.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.9 090/141] ext4: propagate error from dquot_initialize() in EXT4_IOC_FSSETXATTR
Date:   Sun, 11 Nov 2018 14:25:49 -0800
Message-Id: <20181111221640.676346099@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
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

From: Wang Shilong <wshilong@ddn.com>

commit 182a79e0c17147d2c2d3990a9a7b6b58a1561c7a upstream.

We return most failure of dquota_initialize() except
inode evict, this could make a bit sense, for example
we allow file removal even quota files are broken?

But it dosen't make sense to allow setting project
if quota files etc are broken.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ioctl.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -345,7 +345,9 @@ static int ext4_ioctl_setproject(struct
 	}
 	brelse(iloc.bh);
 
-	dquot_initialize(inode);
+	err = dquot_initialize(inode);
+	if (err)
+		return err;
 
 	handle = ext4_journal_start(inode, EXT4_HT_QUOTA,
 		EXT4_QUOTA_INIT_BLOCKS(sb) +


