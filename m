Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072F9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C226E20817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxgW6kso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C226E20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390209AbeKLJBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:01:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390085AbeKLIVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:55 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B519A223CA;
        Sun, 11 Nov 2018 22:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975518;
        bh=4aPfBkZXRjBiiryU7Y/4riQQH3CJlihadKwFrgE7bRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxgW6ksoL/yqNXAjmRDNMP01Ur1VNdyzH0mV3ontkwI3LJ8X0rZM/WSxD1LMkIbe3
         fSI4kHj4s1pcxXZhnkzUrCCYDbb+4ymd/xzYa2PbHvc4+c8ABnjueWLAnjHanax86y
         nLnRoIjs3d37al6ExYvV7Av9B6wTKbDannnjNXZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.18 349/350] userns: also map extents in the reverse map to kernel IDs
Date:   Sun, 11 Nov 2018 14:23:33 -0800
Message-Id: <20181111221722.721113385@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit d2f007dbe7e4c9583eea6eb04d60001e85c6f1bd upstream.

The current logic first clones the extent array and sorts both copies, then
maps the lower IDs of the forward mapping into the lower namespace, but
doesn't map the lower IDs of the reverse mapping.

This means that code in a nested user namespace with >5 extents will see
incorrect IDs. It also breaks some access checks, like
inode_owner_or_capable() and privileged_wrt_inode_uidgid(), so a process
can incorrectly appear to be capable relative to an inode.

To fix it, we have to make sure that the "lower_first" members of extents
in both arrays are translated; and we have to make sure that the reverse
map is sorted *after* the translation (since otherwise the translation can
break the sorting).

This is CVE-2018-18955.

Fixes: 6397fac4915a ("userns: bump idmap limits to 340")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Tested-by: Eric W. Biederman <ebiederm@xmission.com>
Reviewed-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/user_namespace.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -974,10 +974,6 @@ static ssize_t map_write(struct file *fi
 	if (!new_idmap_permitted(file, ns, cap_setid, &new_map))
 		goto out;
 
-	ret = sort_idmaps(&new_map);
-	if (ret < 0)
-		goto out;
-
 	ret = -EPERM;
 	/* Map the lower ids from the parent user namespace to the
 	 * kernel global id space.
@@ -1004,6 +1000,14 @@ static ssize_t map_write(struct file *fi
 		e->lower_first = lower_first;
 	}
 
+	/*
+	 * If we want to use binary search for lookup, this clones the extent
+	 * array and sorts both copies.
+	 */
+	ret = sort_idmaps(&new_map);
+	if (ret < 0)
+		goto out;
+
 	/* Install the map */
 	if (new_map.nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS) {
 		memcpy(map->extent, new_map.extent,


