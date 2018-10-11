Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A34C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6280621470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR4fwajR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6280621470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbeJKXMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730276AbeJKXMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:12:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2672120652;
        Thu, 11 Oct 2018 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272701;
        bh=yo6+wdDUUjYqdd+uMSlaBhPefiuIh+UHpmzttyuMCis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JR4fwajRZLf9gY2PL0lf5KYEUnpOKwKglNP2IuZgaQwH8uZMcQKyvMtm3yXH/ScF0
         JYSpnyg6S0yUwLPDRyVvZEfC7Yqze3bi3s28ghkJ82RuMzrthHIKgB6jvaoP+yk7uh
         pSCDTySYS6l92SUrgScyq2SAAzHvkMEwT0bphOBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, fenghua.yu@intel.com,
        tony.luck@intel.com, acme@kernel.org, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, hpa@zytor.com
Subject: [PATCH 4.14 01/45] perf/core: Add sanity check to deal with pinned event failure
Date:   Thu, 11 Oct 2018 17:39:28 +0200
Message-Id: <20181011152508.938155855@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Reinette Chatre <reinette.chatre@intel.com>

commit befb1b3c2703897c5b8ffb0044dc5d0e5f27c5d7 upstream.

It is possible that a failure can occur during the scheduling of a
pinned event. The initial portion of perf_event_read_local() contains
the various error checks an event should pass before it can be
considered valid. Ensure that the potential scheduling failure
of a pinned event is checked for and have a credible error.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: acme@kernel.org
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/6486385d1f30336e9973b24c8c65f5079543d3d3.1537377064.git.reinette.chatre@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/core.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3757,6 +3757,12 @@ int perf_event_read_local(struct perf_ev
 		goto out;
 	}
 
+	/* If this is a pinned event it must be running on this CPU */
+	if (event->attr.pinned && event->oncpu != smp_processor_id()) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/*
 	 * If the event is currently on this CPU, its either a per-task event,
 	 * or local to this CPU. Furthermore it means its ACTIVE (otherwise


