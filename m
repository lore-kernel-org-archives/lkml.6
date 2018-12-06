Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39C8C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769FD21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107426;
	bh=OboAAzRK4GuOHQz+m3z/bYVCPdICGl4zIbMDCO2FlFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ViTFSGVScShIkOyEIhKUeX+prp/wU0BqwLMRDGmubC1kFcxUEYUJQQfXzQKp4zCH2
	 RSQIMPfAfQvAF/VfTIPUFEj4rlwB95ZFnS/I75RvQKIy4rUE2jZsqDYSW+DZ5xVfUT
	 QllDVErb0y5DmfP0TP+0BkPNV9Nff5K96UKz2vEk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769FD21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbeLFOnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbeLFOnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83ED120661;
        Thu,  6 Dec 2018 14:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107418;
        bh=OboAAzRK4GuOHQz+m3z/bYVCPdICGl4zIbMDCO2FlFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2v9DacGc6dHxxnoys8saZnxZIjne6M5g3qmRpDOGtN9oJA++i/97Kx6LciLDNGnx
         miK/j27F3FoMvCF8lBXRmQEsMuDDQXYVE/a9iYrz7F6SqBK8orUanoJxNuzqjXYyLO
         JNB0CrSgvLnKkJPD0CPn5vF9pjr+O1pG1AshiSzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.14 53/55] mm: hide incomplete nr_indirectly_reclaimable in /proc/zoneinfo
Date:   Thu,  6 Dec 2018 15:39:27 +0100
Message-Id: <20181206143004.604880125@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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

From: Roman Gushchin <guro@fb.com>

[fixed differently upstream, this is a work-around to resolve it for 4.14.y]

Yongqin reported that /proc/zoneinfo format is broken in 4.14
due to commit 7aaf77272358 ("mm: don't show nr_indirectly_reclaimable
in /proc/vmstat")

Node 0, zone      DMA
  per-node stats
      nr_inactive_anon 403
      nr_active_anon 89123
      nr_inactive_file 128887
      nr_active_file 47377
      nr_unevictable 2053
      nr_slab_reclaimable 7510
      nr_slab_unreclaimable 10775
      nr_isolated_anon 0
      nr_isolated_file 0
      <...>
      nr_vmscan_write 0
      nr_vmscan_immediate_reclaim 0
      nr_dirtied   6022
      nr_written   5985
                   74240
      ^^^^^^^^^^
  pages free     131656

The problem is caused by the nr_indirectly_reclaimable counter,
which is hidden from the /proc/vmstat, but not from the
/proc/zoneinfo. Let's fix this inconsistency and hide the
counter from /proc/zoneinfo exactly as from /proc/vmstat.

BTW, in 4.19+ the counter has been renamed and exported by
the commit b29940c1abd7 ("mm: rename and change semantics of
nr_indirectly_reclaimable_bytes"), so there is no such a problem
anymore.

Cc: <stable@vger.kernel.org> # 4.14.x-4.18.x
Fixes: 7aaf77272358 ("mm: don't show nr_indirectly_reclaimable in /proc/vmstat")
Reported-by: Yongqin Liu <yongqin.liu@linaro.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmstat.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1500,6 +1500,10 @@ static void zoneinfo_show_print(struct s
 	if (is_zone_first_populated(pgdat, zone)) {
 		seq_printf(m, "\n  per-node stats");
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+			/* Skip hidden vmstat items. */
+			if (*vmstat_text[i + NR_VM_ZONE_STAT_ITEMS +
+					 NR_VM_NUMA_STAT_ITEMS] == '\0')
+				continue;
 			seq_printf(m, "\n      %-12s %lu",
 				vmstat_text[i + NR_VM_ZONE_STAT_ITEMS +
 				NR_VM_NUMA_STAT_ITEMS],


