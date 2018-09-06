Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053EBC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC71D206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC71D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbeIFNxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:53:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbeIFNxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:53:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74D7B402332F;
        Thu,  6 Sep 2018 09:18:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 970C82027EA0;
        Thu,  6 Sep 2018 09:18:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/11] UAPI: bcache: Fix use of embedded flexible array [ver
 #2]
From:   David Howells <dhowells@redhat.com>
To:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Thu, 06 Sep 2018 10:18:51 +0100
Message-ID: <153622553109.14298.2675151087019716165.stgit@warthog.procyon.org.uk>
In-Reply-To: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
References: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 09:18:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 09:18:52 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bkey struct defined by bcache is embedded in the jset struct.  However,
this is illegal in C++ as there's a "flexible array" at the end of the
struct.  Change this to be a 0-length struct instead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Coly Li <colyli@suse.de>
cc: Kent Overstreet <kent.overstreet@gmail.com>
cc: linux-bcache@vger.kernel.org
---

 include/uapi/linux/bcache.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
index 5d4f58e059fd..11863e903bff 100644
--- a/include/uapi/linux/bcache.h
+++ b/include/uapi/linux/bcache.h
@@ -23,7 +23,7 @@ static inline void SET_##name(type *k, __u64 v)			\
 struct bkey {
 	__u64	high;
 	__u64	low;
-	__u64	ptr[];
+	__u64	ptr[0];
 };
 
 #define KEY_FIELD(name, field, offset, size)				\

