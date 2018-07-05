Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D14C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD5C210E0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD5C210E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754371AbeGEQbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:31:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754180AbeGEQbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:31:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90604406F8B2;
        Thu,  5 Jul 2018 16:31:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9E9876CE;
        Thu,  5 Jul 2018 16:31:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/4] cachefiles: Wait rather than BUG'ing on "Unexpected
 object collision"
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     kiran.modukuri@gmail.com, carmark.dlut@gmail.com,
        vegard.nossum@gmail.com, linux-kernel@vger.kernel.org,
        neilb@suse.com, aderobertis@metrics.net, dhowells@redhat.com,
        dja@axtens.net
Date:   Thu, 05 Jul 2018 17:31:30 +0100
Message-ID: <153080829041.5496.6336874857121191833.stgit@warthog.procyon.org.uk>
In-Reply-To: <153080826773.5496.7106875523806885716.stgit@warthog.procyon.org.uk>
References: <153080826773.5496.7106875523806885716.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 05 Jul 2018 16:31:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 05 Jul 2018 16:31:33 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>

If we meet a conflicting object that is marked FSCACHE_OBJECT_IS_LIVE in
the active object tree, we have been emitting a BUG after logging
information about it and the new object.

Instead, we should wait for the CACHEFILES_OBJECT_ACTIVE flag to be cleared
on the old object (or return an error).  The ACTIVE flag should be cleared
after it has been removed from the active object tree.  A timeout of 60s is
used in the wait, so we shouldn't be able to get stuck there.

Signed-off-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/namei.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index b5d6dd72dfa0..af2b17b21b94 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -192,7 +192,6 @@ static int cachefiles_mark_object_active(struct cachefiles_cache *cache,
 		pr_err("\n");
 		pr_err("Error: Unexpected object collision\n");
 		cachefiles_printk_object(object, xobject);
-		BUG();
 	}
 	atomic_inc(&xobject->usage);
 	write_unlock(&cache->active_lock);

