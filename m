Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB83C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947B42146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1wSxhGNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947B42146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389629AbeK3Bi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732483AbeK3Bi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:38:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 313B5213A2;
        Thu, 29 Nov 2018 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501974;
        bh=5GTV/uNPYmmzougMSUCYronxFxCFZbx7OGYHxGKfpa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1wSxhGNFNgRm8Hqq12/94xw2bwLHa2IFLRIgfY7oTprB+oYVsoPxh0P3ZR267d92n
         19qS+aPz2j11sUUvjWNGuILlFeqlMAndI+onQT/h6kxwmte/+7W4Epj+3Iz95pIdUk
         HPawS7zBVGv5DLRAi6fAL2sLSmfcfMYBLgtYGzfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 4.19 099/110] dax: Avoid losing wakeup in dax_lock_mapping_entry
Date:   Thu, 29 Nov 2018 15:13:10 +0100
Message-Id: <20181129135925.248125334@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <willy@infradead.org>

commit 25bbe21bf427a81b8e3ccd480ea0e1d940256156 upstream.

After calling get_unlocked_entry(), you have to call
put_unlocked_entry() to avoid subsequent waiters losing wakeups.

Fixes: c2a7d2a11552 ("filesystem-dax: Introduce dax_lock_mapping_entry()")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dax.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/fs/dax.c
+++ b/fs/dax.c
@@ -217,6 +217,9 @@ static inline void *unlock_slot(struct a
 	return (void *)entry;
 }
 
+static void put_unlocked_mapping_entry(struct address_space *mapping,
+				       pgoff_t index, void *entry);
+
 /*
  * Lookup entry in radix tree, wait for it to become unlocked if it is
  * exceptional entry and return it. The caller must call
@@ -256,8 +259,10 @@ static void *__get_unlocked_mapping_entr
 		revalidate = wait_fn();
 		finish_wait(wq, &ewait.wait);
 		xa_lock_irq(&mapping->i_pages);
-		if (revalidate)
+		if (revalidate) {
+			put_unlocked_mapping_entry(mapping, index, entry);
 			return ERR_PTR(-EAGAIN);
+		}
 	}
 }
 


