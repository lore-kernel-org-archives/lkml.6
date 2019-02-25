Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C37C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A767921734
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129465;
	bh=/PjvaWH6dIUx5OXrOzopxJHNYzOZNauvYmZ/lgD7N9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y8lSCnpq5KzZaN+dX5wVW5qLL7CeGCYCHMiuBnb5Z1T1ZrNWqhQoXmBbdXhfP9pU0
	 Ilt7/CIHIP1Br15KIFaBN03sJs5omD371sg2+sC9J2RmAqX1M6RkMsrLoq08wrAUbJ
	 C7RwD8AL0RSJCviMUf5kdhlGufwJ1hUNJLeNQbII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfBYVRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:17:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbfBYVRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:17:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDC992173C;
        Mon, 25 Feb 2019 21:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129458;
        bh=/PjvaWH6dIUx5OXrOzopxJHNYzOZNauvYmZ/lgD7N9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7KH6OrjRaxAFsVl4ZS4+HPEJX59or1h362UuYrXDjQ9U7RVtOH4izhFAewQV/Cnr
         NxPkUQ9Op+XymCV3SzdJIeVmDqbJBYDOkPKobCZ5SHBsQhxjitAT1myT5SXNXg8kxq
         ANXJ8UnIFYEVEPHrEiO3MCH8Al4UMQeJH0qRVmSs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 05/71] mac80211: Free mpath object when rhashtable insertion fails
Date:   Mon, 25 Feb 2019 22:11:07 +0100
Message-Id: <20190225195034.970599447@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -448,17 +448,15 @@ struct mesh_path *mesh_path_add(struct i
 
 	} while (unlikely(ret == -EEXIST && !mpath));
 
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
@@ -488,6 +486,9 @@ int mpp_path_add(struct ieee80211_sub_if
 					    &new_mpath->rhash,
 					    mesh_rht_params);
 
+	if (ret)
+		kfree(new_mpath);
+
 	sdata->u.mesh.mpp_paths_generation++;
 	return ret;
 }


