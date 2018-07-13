Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B614ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53422084E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="O5Li2mW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53422084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeGMVPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:15:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:32649 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731639AbeGMVPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531515961; x=1563051961;
  h=from:to:cc:subject:date:message-id;
  bh=VIdjDFYwGI36sykXvboTMlRt66TuXEgLxKhFdV4qdNU=;
  b=O5Li2mW7SZ69AQDzYJwTMXrVp9KdYpoqijZ4Dlj9ZV6Gcl3axYZNTFhc
   Be0jHmG73BXASwMX2JbAm8VNrtTP3S1S32rgzMZxCDIzvxns5LapBR11S
   6E9IUSq8k4I0t36hKZ23IbOuvgU0B5NS7x65Ndn1cqievbbNW/ijtDnZO
   DnaUtjXTZYnd+7Tlwaqlq9atcCUgt9jMLZ4GiGLq+TuWwLV7V0fvOE2bP
   ka6jdwMYQEM8XJSSJIEBbaKeVAkprmYBzwddpSW7FGy7guQ+1IRw0mtro
   j37ev7PwuxNPXnYcouQ1zAiopKJbeGNUk7TN2i4+zU6cvJ0b/kMwiBAEY
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,349,1526313600"; 
   d="scan'208";a="180964166"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2018 05:05:59 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Jul 2018 13:47:30 -0700
Received: from penguito-adamm.sdcorp.global.sandisk.com ([10.11.47.13])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Jul 2018 13:58:46 -0700
From:   adam.manzanares@wdc.com
To:     mtk.manpages@gmail.com
Cc:     jmoyer@redhat.com, rgoldwyn@suse.com, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH] io_submit.2: Add IOCB_FLAG_IOPRIO
Date:   Fri, 13 Jul 2018 13:58:31 -0700
Message-Id: <20180713205831.8134-1-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Manzanares <adam.manzanares@wdc.com>

The newly added IOCB_FLAG_IOPRIO aio_flag introduces
new behaviors and return values.

The details of this new feature are posted here:
https://lkml.org/lkml/2018/5/22/809

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 man2/io_submit.2 | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/man2/io_submit.2 b/man2/io_submit.2
index d17e3122a..15e1ecdea 100644
--- a/man2/io_submit.2
+++ b/man2/io_submit.2
@@ -164,14 +164,26 @@ This is the size of the buffer pointed to by
 This is the file offset at which the I/O operation is to be performed.
 .TP
 .I aio_flags
-This is the flag to be passed iocb structure.
-The only valid value is
-.BR IOCB_FLAG_RESFD ,
-which indicates that the asynchronous I/O control must signal the file
+This is the set of flags associated with the iocb structure.
+The valid values are:
+.RS
+.TP
+.BR IOCB_FLAG_RESFD
+Asynchronous I/O control must signal the file
 descriptor mentioned in
 .I aio_resfd
 upon completion.
 .TP
+.BR IOCB_FLAG_IOPRIO " (since Linux 4.18)"
+.\" commit d9a08a9e616beeccdbd0e7262b7225ffdfa49e92
+Interpret the
+.I aio_reqprio
+field as an
+.B IOPRIO_VALUE
+as defined by
+.IR linux/ioprio.h.
+.RE
+.TP
 .I aio_resfd
 The file descriptor to signal in the event of asynchronous I/O completion.
 .SH RETURN VALUE
@@ -196,13 +208,21 @@ The AIO context specified by \fIctx_id\fP is invalid.
 \fInr\fP is less than 0.
 The \fIiocb\fP at
 .I *iocbpp[0]
-is not properly initialized,
-or the operation specified is invalid for the file descriptor
-in the \fIiocb\fP.
+is not properly initialized, the operation specified is invalid for the file
+descriptor in the \fIiocb\fP, or the value in the
+.I aio_reqprio
+field is invalid.
 .TP
 .B ENOSYS
 .BR io_submit ()
 is not implemented on this architecture.
+.TP
+.B EPERM
+The aio_reqprio field is set with the class
+.B IOPRIO_CLASS_RT
+, but the submitting context does not have the
+.B CAP_SYS_ADMIN
+privilege.
 .SH VERSIONS
 .PP
 The asynchronous I/O system calls first appeared in Linux 2.5.
-- 
2.17.1

