Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5014FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2318B2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762974;
	bh=VSpRlaNW2xA/OZgaM2J82lpQjYuC/hz/654/fRRedR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0vMFshw99G2Z6n1EwXQMMJe/QtScIf6VtRvMxzqYf0DUxASbtTvvVb5fvJUnmYu0F
	 1Mc5lrRwQpQEbe3cNq0C7wwmOR6k1vJESR9uIwYBOkqmReJBe3FnnZIWTUG7FSZ+HB
	 ym43j5AbzSMFi+1vGZ+o95Cy5YUJpSaCjnytc8wE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbfA2L4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:56:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731569AbfA2LuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:50:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DBD92086C;
        Tue, 29 Jan 2019 11:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762601;
        bh=VSpRlaNW2xA/OZgaM2J82lpQjYuC/hz/654/fRRedR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFxIbP+22basrOiI/siHfi322KJ8/r/XnAL69AkC50d/TSyrj753uqizx02JAW57L
         P77MQ32kJyNdK8YXd0FxKlHiw3MaL1TvEL80B9cSayfs9DYlRaGJQkVTVislkuaKkH
         6jmOP3s9YZPYCKmidybtDyBJBb+3KpjF+kVUMXw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joao Martins <joao.m.martins@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.14 62/68] x86/xen/time: set pvclock flags on xen_time_init()
Date:   Tue, 29 Jan 2019 12:36:24 +0100
Message-Id: <20190129113137.576594862@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

From: Joao Martins <joao.m.martins@oracle.com>

commit b888808093113ae7d63d213272d01fea4b8329ed upstream.

Specifically check for PVCLOCK_TSC_STABLE_BIT and if this bit is set,
then set it too on pvclock flags. This allows Xen clocksource to use it
and thus speeding up xen_clocksource_read() callers (i.e. sched_clock())

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/time.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -373,6 +373,7 @@ static const struct pv_time_ops xen_time
 
 static void __init xen_time_init(void)
 {
+	struct pvclock_vcpu_time_info *pvti;
 	int cpu = smp_processor_id();
 	struct timespec tp;
 
@@ -396,6 +397,14 @@ static void __init xen_time_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TSC);
 
+	/*
+	 * We check ahead on the primary time info if this
+	 * bit is supported hence speeding up Xen clocksource.
+	 */
+	pvti = &__this_cpu_read(xen_vcpu)->time;
+	if (pvti->flags & PVCLOCK_TSC_STABLE_BIT)
+		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
+
 	xen_setup_runstate_info(cpu);
 	xen_setup_timer(cpu);
 	xen_setup_cpu_clockevents();


