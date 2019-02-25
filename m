Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CC2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4871F20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131216;
	bh=7vVZUm8i5X1pqroQhZeO20NSXPjdfp60Kl9KKbDNHyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TAT/6r9hUAjThqvUj4u9ZZzoV1cfdWZeKa/Q08PUJ0JCUVK/zOvTl/UjBJao67vE9
	 gNIJqvTUsYJLMC7wkDz+BrabucT/pt4RsEmSchm1bOCNTCrgRHTERS3io6EyEQh+Vt
	 0ezCYgC5D0c+msdnvvXe9TctTwMJc0NF9/V4AIz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfBYVqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731132AbfBYV2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:28:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 674BB2087C;
        Mon, 25 Feb 2019 21:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130085;
        bh=7vVZUm8i5X1pqroQhZeO20NSXPjdfp60Kl9KKbDNHyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sNRCPR+jx48B2+WvqSIoT8Cd6rYjYkIqqjEEX4pIvpSOfwin/8bYfv/cBEuNwYLRL
         3jgaYKFqqLH32ksvC8PgadweJWUtAwnlx0SqK8gol9p6WyM+NwMEucVNFc+Ju4twTX
         liONRvzNkAiKfQaFSJ0E39uTt/gKSThJROm57dZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.20 010/183] mac80211: Free mpath object when rhashtable insertion fails
Date:   Mon, 25 Feb 2019 22:09:43 +0100
Message-Id: <20190225195056.398128381@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 4ff3a9d14c6c06eaa4e5976c61599ea2bd9e81b2 upstream.

When rhashtable insertion fails the mesh table code doesn't free
the now-orphan mesh path object.  This patch fixes that.

Cc: stable@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/mesh_pathtbl.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -436,17 +436,15 @@ struct mesh_path *mesh_path_add(struct i
 	} while (unlikely(ret == -EEXIST && !mpath));
 	spin_unlock_bh(&tbl->walk_lock);
 
-	if (ret && ret != -EEXIST)
-		return ERR_PTR(ret);
-
-	/* At this point either new_mpath was added, or we found a
-	 * matching entry already in the table; in the latter case
-	 * free the unnecessary new entry.
-	 */
-	if (ret == -EEXIST) {
+	if (ret) {
 		kfree(new_mpath);
+
+		if (ret != -EEXIST)
+			return ERR_PTR(ret);
+
 		new_mpath = mpath;
 	}
+
 	sdata->u.mesh.mesh_paths_generation++;
 	return new_mpath;
 }
@@ -481,6 +479,9 @@ int mpp_path_add(struct ieee80211_sub_if
 		hlist_add_head_rcu(&new_mpath->walk_list, &tbl->walk_head);
 	spin_unlock_bh(&tbl->walk_lock);
 
+	if (ret)
+		kfree(new_mpath);
+
 	sdata->u.mesh.mpp_paths_generation++;
 	return ret;
 }


