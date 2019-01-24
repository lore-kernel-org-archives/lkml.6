Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF95C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A09721909
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358536;
	bh=ap/1FXivhVVlvG/MLOwLRGWojSf2YCs2zp7NONk5n5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iyVgeN7lOScTqkkPWlyC/KFKDElMP0WWYzg+T7NKYdI5880GZiF8nDSFUBOlGEaK0
	 43rXEK/3uPRBV4IY8FAFSBiZiY3PG8ONY6dGj/4k6BNd/tB7AjlomPRyR9M9RRkX49
	 SA5dulBukBaRim2NLOZ9bHefRNCD5/RkjEfZh3qE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfAXTfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732366AbfAXTfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:35:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6860A21906;
        Thu, 24 Jan 2019 19:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358531;
        bh=ap/1FXivhVVlvG/MLOwLRGWojSf2YCs2zp7NONk5n5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQV/k7VYktj8JxoDC7ER8l3093YkBJ3YHW2o3Jcik5qixZWzRx46CNQyARZwMPy5g
         95+H7JJeAKjU0CP2ddBVH2JU9ibO0oYljjEFMzKhi2AzOT9L/O41BToREak8BHgUSr
         AojdR5FNkqnFAlpAs3sUB3CS4iKSFzs6YYPynGDk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 041/106] pstore/ram: Do not treat empty buffers as valid
Date:   Thu, 24 Jan 2019 20:19:58 +0100
Message-Id: <20190124190209.049178443@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

[ Upstream commit 30696378f68a9e3dad6bfe55938b112e72af00c2 ]

The ramoops backend currently calls persistent_ram_save_old() even
if a buffer is empty. While this appears to work, it is does not seem
like the right thing to do and could lead to future bugs so lets avoid
that. It also prevents misleading prints in the logs which claim the
buffer is valid.

I got something like:

	found existing buffer, size 0, start 0

When I was expecting:

	no valid data in buffer (sig = ...)

This bails out early (and reports with pr_debug()), since it's an
acceptable state.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/ram_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 0792595ebcfb..3c777ec80d47 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -496,6 +496,11 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 	sig ^= PERSISTENT_RAM_SIG;
 
 	if (prz->buffer->sig == sig) {
+		if (buffer_size(prz) == 0) {
+			pr_debug("found existing empty buffer\n");
+			return 0;
+		}
+
 		if (buffer_size(prz) > prz->buffer_size ||
 		    buffer_start(prz) > buffer_size(prz))
 			pr_info("found existing invalid buffer, size %zu, start %zu\n",
-- 
2.19.1



