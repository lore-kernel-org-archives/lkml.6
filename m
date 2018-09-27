Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75FBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878FF21580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878FF21580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeI0Pgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:36:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56228 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeI0Pgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:36:49 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 47AD31113;
        Thu, 27 Sep 2018 09:19:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        David Howells <dhowells@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Stephan Mueller <smueller@chronox.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <james.morris@microsoft.com>
Subject: [PATCH 4.14 36/64] Revert "uapi/linux/keyctl.h: dont use C++ reserved keyword as a struct member name"
Date:   Thu, 27 Sep 2018 11:03:53 +0200
Message-Id: <20180927090255.195180674@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lubomir Rintel <lkundrak@v3.sk>

commit 8c0f9f5b309d627182d5da72a69246f58bde1026 upstream.

This changes UAPI, breaking iwd and libell:

  ell/key.c: In function 'kernel_dh_compute':
  ell/key.c:205:38: error: 'struct keyctl_dh_params' has no member named 'private'; did you mean 'dh_private'?
    struct keyctl_dh_params params = { .private = private,
                                        ^~~~~~~
                                        dh_private

This reverts commit 8a2336e549d385bb0b46880435b411df8d8200e8.

Fixes: 8a2336e549d3 ("uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Randy Dunlap <rdunlap@infradead.org>
cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
cc: Stephan Mueller <smueller@chronox.de>
cc: James Morris <jmorris@namei.org>
cc: "Serge E. Hallyn" <serge@hallyn.com>
cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: <stable@vger.kernel.org>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/keyctl.h |    2 +-
 security/keys/dh.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -65,7 +65,7 @@
 
 /* keyctl structures */
 struct keyctl_dh_params {
-	__s32 dh_private;
+	__s32 private;
 	__s32 prime;
 	__s32 base;
 };
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -307,7 +307,7 @@ long __keyctl_dh_compute(struct keyctl_d
 	}
 	dh_inputs.g_size = dlen;
 
-	dlen = dh_data_from_key(pcopy.dh_private, &dh_inputs.key);
+	dlen = dh_data_from_key(pcopy.private, &dh_inputs.key);
 	if (dlen < 0) {
 		ret = dlen;
 		goto out2;


