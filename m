Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB20C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EB72147C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/ulH4lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EB72147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbeJKXQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbeJKXQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:16:17 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23272213A2;
        Thu, 11 Oct 2018 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272911;
        bh=laIkM84aONZVakKrgsZskITd1bb90Ys03C1xdU//3oI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/ulH4lo5ioSqVNbte7Syy5zl4nB54Xd6jTbHulOqcWHI2jYzb+tM/qWmc2nh0THD
         sZlWz6mhXiallHN61oq6GmoIzKpVp/4XJcK4cTIrED89gDuI7JWqFtX/38kIkB0pQN
         B6Z7Rv43J7sz3KDyJRP+MFlbcf8L75f/XjvC8O/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Christoph Lameter <clameter@sgi.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.18 04/44] mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly
Date:   Thu, 11 Oct 2018 17:39:42 +0200
Message-Id: <20181011152452.733926275@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
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
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmstat.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1275,6 +1275,9 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_SMP
 	"nr_tlb_remote_flush",
 	"nr_tlb_remote_flush_received",
+#else
+	"", /* nr_tlb_remote_flush */
+	"", /* nr_tlb_remote_flush_received */
 #endif /* CONFIG_SMP */
 	"nr_tlb_local_flush_all",
 	"nr_tlb_local_flush_one",


