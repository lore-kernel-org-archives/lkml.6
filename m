Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3426FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF0E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9J8qR7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF0E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeKTC56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:57:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731202AbeKTC54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7AE82086A;
        Mon, 19 Nov 2018 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645229;
        bh=rCpwJcpYF9kpU+NGDnMhKEmDAYY6Qdv1HT6cnDjoXj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9J8qR7rZwH7QP7ymd2Afl22rVX46gMsvNMcS/uTAF+0vH1imBTBhBn7u/8jZ+B3V
         WdiIPFmhhrkGY6qkC5zDuECP/drXFmnWNL3OfaVET9FXFMq0U6d54usTOUwiX3vGlz
         Km30m0YU8lZCQhCi5U/mvyTfWhGsnv3vP1zBR8Zk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.19 085/205] libceph: bump CEPH_MSG_MAX_DATA_LEN
Date:   Mon, 19 Nov 2018 17:26:32 +0100
Message-Id: <20181119162631.461772588@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 94e6992bb560be8bffb47f287194adf070b57695 upstream.

If the read is large enough, we end up spinning in the messenger:

  libceph: osd0 192.168.122.1:6801 io error
  libceph: osd0 192.168.122.1:6801 io error
  libceph: osd0 192.168.122.1:6801 io error

This is a receive side limit, so only reads were affected.

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/ceph/libceph.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -81,7 +81,13 @@ struct ceph_options {
 
 #define CEPH_MSG_MAX_FRONT_LEN	(16*1024*1024)
 #define CEPH_MSG_MAX_MIDDLE_LEN	(16*1024*1024)
-#define CEPH_MSG_MAX_DATA_LEN	(16*1024*1024)
+
+/*
+ * Handle the largest possible rbd object in one message.
+ * There is no limit on the size of cephfs objects, but it has to obey
+ * rsize and wsize mount options anyway.
+ */
+#define CEPH_MSG_MAX_DATA_LEN	(32*1024*1024)
 
 #define CEPH_AUTH_NAME_DEFAULT   "guest"
 


