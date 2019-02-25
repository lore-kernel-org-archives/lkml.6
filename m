Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102E8C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C856820C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129170;
	bh=ENgH4hkH/9xioXn6GEMH8rPXboBKdG0ZVzDgmhTYkZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oz5fF1SuenXCoF6sU4w5D5zTCCDF0fNc68IJRVPkFUyyp4JVgv4SOolCFDIy1nEOC
	 Kfy+QMbLo9ZdOngfqVI4r0/s5fdsAD5yofB+p8N+293WtsaKTtie5xo3xOf76ysfDy
	 pjKGqiZYYgeAIqBFSqr0st4yNawl6e88cL8DxBRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfBYVMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:12:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfBYVMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:12:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62A7C2084D;
        Mon, 25 Feb 2019 21:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129168;
        bh=ENgH4hkH/9xioXn6GEMH8rPXboBKdG0ZVzDgmhTYkZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bs5HUvhsAgib0Hv8P7MfQmnq7bpE7Ftg5HAr8p7ZNhVfqkhndUKBnQ4tV5MdntkPr
         m9tsdouhh+uyj3to/5ePmOpuf8tldn1LhcmgG1dzOPyEETBUS6DpMixdon1p5j0kMX
         eAZ5V8Tv6jpXIrPx9wEy7HA1o4oT8xGRnmbOUavA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.9 01/63] mac80211: Free mpath object when rhashtable insertion fails
Date:   Mon, 25 Feb 2019 22:11:01 +0100
Message-Id: <20190225195035.821914219@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -449,17 +449,15 @@ struct mesh_path *mesh_path_add(struct i
 
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
@@ -489,6 +487,9 @@ int mpp_path_add(struct ieee80211_sub_if
 					    &new_mpath->rhash,
 					    mesh_rht_params);
 
+	if (ret)
+		kfree(new_mpath);
+
 	sdata->u.mesh.mpp_paths_generation++;
 	return ret;
 }


