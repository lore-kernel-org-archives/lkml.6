Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55C9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A437620645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570841;
	bh=uGceRQP/HPWt6RAjs5cr5YoGgzqVK759EHT1rB0tC6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uL2NaFKHu8D0Cp1q1oIG5qP4NsMOOQ26ScrgHtUJ0d9W2AZ0qisDmTUZppIv74Dfj
	 Vg2UB3HU9H/ir0Hk7xvz1rTXy9mAJgepTNVwls3jJbiGDpIm0u7UCALpsg+YgpWiSO
	 Jzf3ny2FuFNqF8VZAzOBsjS5l3OsDvLy2lkWPmrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbfAOQrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:47:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729219AbfAOQpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:45:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B7A20645;
        Tue, 15 Jan 2019 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570735;
        bh=uGceRQP/HPWt6RAjs5cr5YoGgzqVK759EHT1rB0tC6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgL/B8+txGoRFpKhl5eCruIXDYR5HsV9xveUjWAnFeBIO8mIMuVNWk1R6Z4FaVRV9
         5W5vvSCCUhfZPBaA9wVln9ME6CVdOsMYN0ULsrZbGtSUNC6eMvYIZyD4qPHzbBxRDu
         h9CGLlSYo9TI0jkp5roNmDDXz3c5ry7C0dzHTLNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.20 51/57] ext4: track writeback errors using the generic tracking infrastructure
Date:   Tue, 15 Jan 2019 17:36:32 +0100
Message-Id: <20190115154913.872921555@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit 95cb67138746451cc84cf8e516e14989746e93b0 upstream.

We already using mapping_set_error() in fs/ext4/page_io.c, so all we
need to do is to use file_check_and_advance_wb_err() when handling
fsync() requests in ext4_sync_file().

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/fsync.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -164,6 +164,9 @@ int ext4_sync_file(struct file *file, lo
 			ret = err;
 	}
 out:
+	err = file_check_and_advance_wb_err(file);
+	if (ret == 0)
+		ret = err;
 	trace_ext4_sync_file_exit(inode, ret);
 	return ret;
 }


