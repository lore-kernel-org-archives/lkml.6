Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021B6C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB2B2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcLk8Stl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB2B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeLDLBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbeLDLBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B599B2146D;
        Tue,  4 Dec 2018 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921262;
        bh=G7ZtIQyJIz/tY3XGx5QttbixJV2i9CRPDjfYB8fg/DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tcLk8StlGCpYr+6E6viiSAy9LK9/uTeHEKoxBuA96hzDti96pMTcrihboQjP80QRu
         D1ohHx4ZWLI1jjKiEaLgWojYJRud1SgT4PMuGxyfSTt8hSCxlK55jhTDNs3z5tYamV
         lnV/Bq8BJHBkiENz0vuZpNd/cw1gACGgah1zw4Hs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, xingaopeng <xingaopeng@huawei.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.19 117/139] ext2: initialize opts.s_mount_opt as zero before using it
Date:   Tue,  4 Dec 2018 11:49:58 +0100
Message-Id: <20181204103655.454888182@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

From: xingaopeng <xingaopeng@huawei.com>

commit e5f5b717983bccfa033282e9886811635602510e upstream.

We need to initialize opts.s_mount_opt as zero before using it, else we
may get some unexpected mount options.

Fixes: 088519572ca8 ("ext2: Parse mount options into a dedicated structure")
CC: stable@vger.kernel.org
Signed-off-by: xingaopeng <xingaopeng@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext2/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -895,6 +895,7 @@ static int ext2_fill_super(struct super_
 	if (sb->s_magic != EXT2_SUPER_MAGIC)
 		goto cantfind_ext2;
 
+	opts.s_mount_opt = 0;
 	/* Set defaults before we parse the mount options */
 	def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
 	if (def_mount_opts & EXT2_DEFM_DEBUG)


