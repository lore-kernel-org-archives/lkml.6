Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939407AbeE1Oum (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937238AbeE1K2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:28:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Allen Hubbe <Allen.Hubbe@dell.com>, Dave Jiang <dave.jiang@intel.com>,
        Jon Mason <jdmason@kudzu.us>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 061/329] ntb_transport: Fix bug with max_mw_size parameter
Date: Mon, 28 May 2018 11:59:50 +0200
Message-Id: <20180528100247.886564316@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit cbd27448faff4843ac4b66cc71445a10623ff48d ]

When using the max_mw_size parameter of ntb_transport to limit the size of
the Memory windows, communication cannot be established and the queues
freeze.

This is because the mw_size that's reported to the peer is correctly
limited but the size used locally is not. So the MW is initialized
with a buffer smaller than the window but the TX side is using the
full window. This means the TX side will be writing to a region of the
window that points nowhere.

This is easily fixed by applying the same limit to tx_size in
ntb_transport_init_queue().

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ntb/ntb_transport.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -996,6 +996,9 @@ static int ntb_transport_init_queue(stru
 	mw_base = nt->mw_vec[mw_num].phys_addr;
 	mw_size = nt->mw_vec[mw_num].phys_size;
 
+	if (max_mw_size && mw_size > max_mw_size)
+		mw_size = max_mw_size;
+
 	tx_size = (unsigned int)mw_size / num_qps_mw;
 	qp_offset = tx_size * (qp_num / mw_count);
 
