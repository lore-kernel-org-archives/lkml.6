Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B04C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A752620661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A752620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeLIWTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:19:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35542 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbeLIVz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:26 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72n-0002im-K7; Sun, 09 Dec 2018 21:55:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003fm-St; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Oleg Nesterov" <oleg@redhat.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Kemi Wang" <kemi.wang@intel.com>, "Jann Horn" <jannh@google.com>,
        "Christoph Lameter" <clameter@sgi.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Andy Lutomirski" <luto@kernel.org>, "Roman Gushchin" <guro@fb.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.154984836@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 301/328] mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 58bc4c34d249bf1bc50730a9a209139347cfacfe upstream.

5dd0b16cdaff ("mm/vmstat: Make NR_TLB_REMOTE_FLUSH_RECEIVED available even
on UP") made the availability of the NR_TLB_REMOTE_FLUSH* counters inside
the kernel unconditional to reduce #ifdef soup, but (either to avoid
showing dummy zero counters to userspace, or because that code was missed)
didn't update the vmstat_array, meaning that all following counters would
be shown with incorrect values.

This only affects kernel builds with
CONFIG_VM_EVENT_COUNTERS=y && CONFIG_DEBUG_TLBFLUSH=y && CONFIG_SMP=n.

Link: http://lkml.kernel.org/r/20181001143138.95119-2-jannh@google.com
Fixes: 5dd0b16cdaff ("mm/vmstat: Make NR_TLB_REMOTE_FLUSH_RECEIVED available even on UP")
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Roman Gushchin <guro@fb.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Christoph Lameter <clameter@sgi.com>
Cc: Kemi Wang <kemi.wang@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/vmstat.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -864,6 +864,9 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_SMP
 	"nr_tlb_remote_flush",
 	"nr_tlb_remote_flush_received",
+#else
+	"", /* nr_tlb_remote_flush */
+	"", /* nr_tlb_remote_flush_received */
 #endif /* CONFIG_SMP */
 	"nr_tlb_local_flush_all",
 	"nr_tlb_local_flush_one",

