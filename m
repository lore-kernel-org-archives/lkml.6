Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeB0Ty7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 14:54:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751716AbeB0Ty6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 14:54:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65FC20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
Date: Tue, 27 Feb 2018 11:54:57 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: jgross@suse.com, boris.ostrovsky@oracle.com
cc: sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pvcalls-front: 64-bit align flags
Message-ID: <alpine.DEB.2.10.1802271150020.4239@sstabellini-ThinkPad-X260>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are using test_and_* operations on the status and flag fields of
struct sock_mapping. However, these functions require the operand to be
64-bit aligned on arm64. Currently, only status is 64-bit aligned.

Make flags 64-bit aligned by introducing an explicit padding field.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index ca5b773..aa07b2a 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -78,6 +78,7 @@ struct sock_mapping {
 #define PVCALLS_STATUS_BIND          1
 #define PVCALLS_STATUS_LISTEN        2
 			uint8_t status;
+			uint8_t pad[7];
 		/*
 		 * Internal state-machine flags.
 		 * Only one accept operation can be inflight for a socket.
