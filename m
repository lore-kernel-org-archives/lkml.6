Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8308C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B87821476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIhcShzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B87821476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbeJKXIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJKXIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:08:39 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CADCA21470;
        Thu, 11 Oct 2018 15:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272455;
        bh=Nns+9oJdXE3Bx7X9zxrgLzipWYLyWteegI2VKOBQMPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iIhcShzUggtE1jCckcRew0vroX0xMcoSbjcpsv49HKEzC0z3lcGfmi2w3PAYiwZUC
         FdMJ3knJs09Wca+8te/9lhQd7nWyaccsL/3uqxPdnyF7Qz45YT/lkJveFn21ezIg9j
         c1eUvbzuUNOHCQPCa91XdFd0Cnvzz1Cumlqj4he8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 3.18 116/120] jbd2: dont mark block as modified if the handle is out of credits
Date:   Thu, 11 Oct 2018 17:34:57 +0200
Message-Id: <20181011152554.592179884@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit e09463f220ca9a1a1ecfda84fcda658f99a1f12a upstream.

Do not set the b_modified flag in block's journal head should not
until after we're sure that jbd2_journal_dirty_metadat() will not
abort with an error due to there not being enough space reserved in
the jbd2 handle.

Otherwise, future attempts to modify the buffer may lead a large
number of spurious errors and warnings.

This addresses CVE-2018-10883.

https://bugzilla.kernel.org/show_bug.cgi?id=200071

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: Drop the added logging statement, as it's on
 a code path that doesn't exist here]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jbd2/transaction.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1283,11 +1283,11 @@ int jbd2_journal_dirty_metadata(handle_t
 		 * of the transaction. This needs to be done
 		 * once a transaction -bzzz
 		 */
-		jh->b_modified = 1;
 		if (handle->h_buffer_credits <= 0) {
 			ret = -ENOSPC;
 			goto out_unlock_bh;
 		}
+		jh->b_modified = 1;
 		handle->h_buffer_credits--;
 	}
 


