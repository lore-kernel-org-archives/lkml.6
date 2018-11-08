Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD23ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDE220818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsuUujmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDE220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbeKIHgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbeKIHgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:36 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 007C120892;
        Thu,  8 Nov 2018 21:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714348;
        bh=gZgzQQnKU6YjV1AdLCTxMmFhJhYaEwaZeY+EHTUBDic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsuUujmcm+zX9+IjAbU2edvjqEsA0mnENfkaWcp1YD1Ime0+WW05v6zBwSdKMEtam
         2utHE3gGrJObJSfqyqfve4j3DLNWML/uu/zS43rpuvV3uWEdePN1Qu1NP5udu5KTbS
         Go8mB7D/K0wyk5bpNqri0ffhMsfFMv0rDf9MsctU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 026/114] btrfs: cleaner_kthread() doesnt need explicit freeze
Date:   Thu,  8 Nov 2018 13:50:41 -0800
Message-Id: <20181108215101.483013816@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 838fe1887765f4cc679febea60d87d2a06bd300e ]

cleaner_kthread() is not marked freezable, and therefore calling
try_to_freeze() in its context is a pointless no-op.

In addition to that, as has been clearly demonstrated by 80ad623edd2d
("Revert "btrfs: clear PF_NOFREEZE in cleaner_kthread()"), it's perfectly
valid / legal for cleaner_kthread() to stay scheduled out in an arbitrary
place during suspend (in that particular example that was waiting for
reading of extent pages), so there is no need to leave any traces of
freezer in this kthread.

Fixes: 80ad623edd2d ("Revert "btrfs: clear PF_NOFREEZE in cleaner_kthread()")
Fixes: 696249132158 ("btrfs: clear PF_NOFREEZE in cleaner_kthread()")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ae6e3a30e61e..a2001abbe379 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1820,7 +1820,7 @@ static int cleaner_kthread(void *arg)
 		 */
 		btrfs_delete_unused_bgs(root->fs_info);
 sleep:
-		if (!try_to_freeze() && !again) {
+		if (!again) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			if (!kthread_should_stop())
 				schedule();
-- 
2.17.1



