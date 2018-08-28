Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E4CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25752087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WxTMF9qF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25752087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeH2D2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:28:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47730 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeH2D2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ch37FjB/2HtlITQvCWYTMQcaJohMsL9lzagYvks6G7w=; b=WxTMF9qFDRGjcx4lvljsW1zCjz
        JTqyjC0wGNSAJckjb2h1sJY8lrV8GjlRNuztRu8aYo2RmER8DDJBmCTFQp2zji0XzTLacwYJtLVtv
        KCi5zgAln4W90kulixm0vvmfwNxoFzHwS1OTxzIUo/UqMbg+LzhtxVvBfX0YPzFuqtRsMZvrkvoLk
        MGv+lNdFu3Lot3H0n5Ia0X0D8hL/czvaUrF1SFS9SdNEyNsuS3AZ8nifwQtBYzEJnCQUTl2Jfnhgn
        Wbqgci1toGAYZrg9tneUECMPHe88ucypx+SjMWsx8uLD/tsS7ZSMmb4WQ9ANPff4xcYGOJLPKwLLF
        san3d+xg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1funUt-0005gK-2O; Tue, 28 Aug 2018 23:34:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH resend] uapi/linux/keyctl.h: don't use C++ reserved keyword as
 a struct member name
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
Date:   Tue, 28 Aug 2018 16:34:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Since this header is in "include/uapi/linux/", apparently people
want to use it in userspace programs -- even in C++ ones.
However, the header uses a C++ reserved keyword ("private"),
so change that to "dh_private" instead to allow the header file
to be used in C++ userspace.

Fixes https://bugzilla.kernel.org/show_bug.cgi?id=191051
Fixes: ddbb41148724 ("KEYS: Add KEYCTL_DH_COMPUTE command")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: stable@vger.kernel.org
---
 include/uapi/linux/keyctl.h |    2 +-
 security/keys/dh.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- lnx-416.orig/include/uapi/linux/keyctl.h
+++ lnx-416/include/uapi/linux/keyctl.h
@@ -65,7 +65,7 @@
 
 /* keyctl structures */
 struct keyctl_dh_params {
-	__s32 private;
+	__s32 dh_private;
 	__s32 prime;
 	__s32 base;
 };
--- lnx-416.orig/security/keys/dh.c
+++ lnx-416/security/keys/dh.c
@@ -307,7 +307,7 @@ long __keyctl_dh_compute(struct keyctl_d
 	}
 	dh_inputs.g_size = dlen;
 
-	dlen = dh_data_from_key(pcopy.private, &dh_inputs.key);
+	dlen = dh_data_from_key(pcopy.dh_private, &dh_inputs.key);
 	if (dlen < 0) {
 		ret = dlen;
 		goto out2;


