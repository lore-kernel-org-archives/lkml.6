Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7F5C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C39F218AF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217784;
	bh=a11V7MEueFQl58GX/ZIQz44G1F9YQSMxxXDGBZ9skk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fx+GqvHAUt0uz/odIHSBRMjw1aYGKLLtu+EMLF4xYX3qxRiI+wU6raYs6P36HQ6fv
	 J2uOYm8VuF+Gzm25SrZrsz03E5WsWqxNMeSonhXzDNOa7qBE65aSwWLk+1kL2oAgoq
	 ccS61JmjJv9Y0VnultyiIa2XoSn8hDhZWOLOj1qY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404298AbfAKOnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:43:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404279AbfAKOm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:42:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2CF206B7;
        Fri, 11 Jan 2019 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217778;
        bh=a11V7MEueFQl58GX/ZIQz44G1F9YQSMxxXDGBZ9skk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmW+qn9kR8Tal6E5ePrsg3bcF6uwhlCdfUQqYLpzc4e0+i0BxSymcNf1B5XA9aA6C
         iQvo8UdaifJIMd+wN47DlMpYLNJym1rgJjOoisLM1qDqQpNDAgiE0DLn0BWbCJ25/U
         3/jo9en/dZ/tMisdrQCIVHoajaeSAS1Q+G9JLrGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Burt Holzman <burt@fnal.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.20 09/65] memcg, oom: notify on oom killer invocation from the charge path
Date:   Fri, 11 Jan 2019 15:14:55 +0100
Message-Id: <20190111131057.589328993@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

From: Michal Hocko <mhocko@suse.com>

commit 7056d3a37d2c6aaaab10c13e8e69adc67ec1fc65 upstream.

Burt Holzman has noticed that memcg v1 doesn't notify about OOM events via
eventfd anymore.  The reason is that 29ef680ae7c2 ("memcg, oom: move
out_of_memory back to the charge path") has moved the oom handling back to
the charge path.  While doing so the notification was left behind in
mem_cgroup_oom_synchronize.

Fix the issue by replicating the oom hierarchy locking and the
notification.

Link: http://lkml.kernel.org/r/20181224091107.18354-1-mhocko@kernel.org
Fixes: 29ef680ae7c2 ("memcg, oom: move out_of_memory back to the charge path")
Signed-off-by: Michal Hocko <mhocko@suse.com>
Reported-by: Burt Holzman <burt@fnal.gov>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com
Cc: <stable@vger.kernel.org>	[4.19+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memcontrol.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1666,6 +1666,9 @@ enum oom_status {
 
 static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 {
+	enum oom_status ret;
+	bool locked;
+
 	if (order > PAGE_ALLOC_COSTLY_ORDER)
 		return OOM_SKIPPED;
 
@@ -1700,10 +1703,23 @@ static enum oom_status mem_cgroup_oom(st
 		return OOM_ASYNC;
 	}
 
+	mem_cgroup_mark_under_oom(memcg);
+
+	locked = mem_cgroup_oom_trylock(memcg);
+
+	if (locked)
+		mem_cgroup_oom_notify(memcg);
+
+	mem_cgroup_unmark_under_oom(memcg);
 	if (mem_cgroup_out_of_memory(memcg, mask, order))
-		return OOM_SUCCESS;
+		ret = OOM_SUCCESS;
+	else
+		ret = OOM_FAILED;
+
+	if (locked)
+		mem_cgroup_oom_unlock(memcg);
 
-	return OOM_FAILED;
+	return ret;
 }
 
 /**


