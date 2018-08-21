Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE26C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B40214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B40214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHUNPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:15:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbeHUNPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:15:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21DD74075180;
        Tue, 21 Aug 2018 09:55:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-147.rdu2.redhat.com [10.10.123.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 740562157F49;
        Tue, 21 Aug 2018 09:55:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 6/6] proc: Set correct userns for new proc super created by
 a new pid_namespace
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Andrei Vagin <avagin@gmail.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Aug 2018 10:55:37 +0100
Message-ID: <153484533695.1183.7796797839895873922.stgit@warthog.procyon.org.uk>
In-Reply-To: <153484529922.1183.17405985592221413059.stgit@warthog.procyon.org.uk>
References: <153484529922.1183.17405985592221413059.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 21 Aug 2018 09:55:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 21 Aug 2018 09:55:38 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Fix the setting up a new proc superblock for a new pid_namespace such that
the user_ns for that proc superblock needs to be taken from the new
pid_namespace and not the active process.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/proc/root.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 1d6e5bfa30cc..1419b48a89ab 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -315,6 +315,11 @@ int pid_ns_prepare_proc(struct pid_namespace *ns)
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	if (fc->user_ns != ns->user_ns) {
+		put_user_ns(fc->user_ns);
+		fc->user_ns = get_user_ns(ns->user_ns);
+	}
+
 	ctx = fc->fs_private;
 	if (ctx->pid_ns != ns) {
 		put_pid_ns(ctx->pid_ns);

