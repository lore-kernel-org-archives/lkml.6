Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58EEC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A830A20861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A830A20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeIFNxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:53:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbeIFNxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:53:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0937E87927;
        Thu,  6 Sep 2018 09:18:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB53B2022AAC;
        Thu,  6 Sep 2018 09:18:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/11] UAPI: drm: Fix use of C++ keywords as structural
 members [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Thu, 06 Sep 2018 10:18:29 +0100
Message-ID: <153622550941.14298.18224012706200881807.stgit@warthog.procyon.org.uk>
In-Reply-To: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
References: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 06 Sep 2018 09:18:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 06 Sep 2018 09:18:31 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i810 and msm drm drivers use C++ keywords as structural members.  Fix
this by inserting an anonymous union that provides an alternative name and
then hide the reserved name in C++.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Rob Clark <robdclark@gmail.com>
cc: David Airlie <airlied@linux.ie>
cc: linux-arm-msm@vger.kernel.org
cc: dri-devel@lists.freedesktop.org
cc: freedreno@lists.freedesktop.org
---

 include/uapi/drm/i810_drm.h |    7 ++++++-
 include/uapi/drm/msm_drm.h  |    7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/uapi/drm/i810_drm.h b/include/uapi/drm/i810_drm.h
index d285d5e72e6a..617d79ec3fc5 100644
--- a/include/uapi/drm/i810_drm.h
+++ b/include/uapi/drm/i810_drm.h
@@ -266,7 +266,12 @@ typedef struct _drm_i810_copy_t {
 #define PR_MASK              (0x7<<18)
 
 typedef struct drm_i810_dma {
-	void *virtual;
+	union {
+#ifndef __cplusplus
+		void *virtual;
+#endif
+		void *_virtual;
+	};
 	int request_idx;
 	int request_size;
 	int granted;
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index c06d0a5bdd80..e99bab72d58c 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -148,7 +148,12 @@ struct drm_msm_gem_cpu_fini {
  */
 struct drm_msm_gem_submit_reloc {
 	__u32 submit_offset;  /* in, offset from submit_bo */
-	__u32 or;             /* in, value OR'd with result */
+	union {
+#ifndef __cplusplus
+		__u32 or;	/* in, value OR'd with result */
+#endif
+		__u32 _or;	/* in, value OR'd with result */
+	};
 	__s32 shift;          /* in, amount of left shift (can be negative) */
 	__u32 reloc_idx;      /* in, index of reloc_bo buffer */
 	__u64 reloc_offset;   /* in, offset from start of reloc_bo */

