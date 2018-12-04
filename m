Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BEAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D3A2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu7K84Hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D3A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeLDK7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:59:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeLDK7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:59:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D4C52087F;
        Tue,  4 Dec 2018 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921184;
        bh=FZlZSpNN0GhV+Cpypco6qSxAsNMs0ut3aXXbZjATTws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hu7K84HdYlCvV2LwUFTfbl0+wYFaNHh2Erd+rNK2RhBuWGna8C/1tK6WaO4jNb+6E
         nIwbzQ+Jl5v+XQZlyOMvwrDhyZ35qVputmDDnxxMfjMCFYsdx7QyRJ5Rq8V4gbSK7P
         UDFWSi4c5mmYshKSerK+de+SmV6NWGuWCcw0KmNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Pan Bian <bianpan2016@163.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 078/139] btrfs: relocation: set trans to be NULL after ending transaction
Date:   Tue,  4 Dec 2018 11:49:19 +0100
Message-Id: <20181204103653.365230294@linuxfoundation.org>
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

From: Pan Bian <bianpan2016@163.com>

commit 42a657f57628402c73237547f0134e083e2f6764 upstream.

The function relocate_block_group calls btrfs_end_transaction to release
trans when update_backref_cache returns 1, and then continues the loop
body. If btrfs_block_rsv_refill fails this time, it will jump out the
loop and the freed trans will be accessed. This may result in a
use-after-free bug. The patch assigns NULL to trans after trans is
released so that it will not be accessed.

Fixes: 0647bf564f1 ("Btrfs: improve forever loop when doing balance relocation")
CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Pan Bian <bianpan2016@163.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/relocation.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3963,6 +3963,7 @@ static noinline_for_stack int relocate_b
 restart:
 		if (update_backref_cache(trans, &rc->backref_cache)) {
 			btrfs_end_transaction(trans);
+			trans = NULL;
 			continue;
 		}
 


