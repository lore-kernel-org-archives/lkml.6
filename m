Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937675AbeE1Koi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937511AbeE1Koc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:44:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 078/496] IB/uverbs: Fix possible oops with duplicate ioctl attributes
Date: Mon, 28 May 2018 11:57:43 +0200
Message-Id: <20180528100323.063680185@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matan Barak <matanb@mellanox.com>

[ Upstream commit 4d39a959bc1f3d164b5a54147fdeb19f84b1ed58 ]

If the same attribute is listed twice by the user in the ioctl attribute
list then error unwind can cause the kernel to deref garbage.

This happens when an object with WRITE access is sent twice. The second
parse properly fails but corrupts the state required for the error unwind
it triggers.

Fixing this by making duplicates in the attribute list invalid. This is
not something we need to support.

The ioctl interface is currently recommended to be disabled in kConfig.

Signed-off-by: Matan Barak <matanb@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/uverbs_ioctl.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -59,6 +59,9 @@ static int uverbs_process_attr(struct ib
 			return 0;
 	}
 
+	if (test_bit(attr_id, attr_bundle_h->valid_bitmap))
+		return -EINVAL;
+
 	spec = &attr_spec_bucket->attrs[attr_id];
 	e = &elements[attr_id];
 	e->uattr = uattr_ptr;
