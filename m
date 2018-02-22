Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933673AbeBVSJB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:09:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55278 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933504AbeBVSI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:08:59 -0500
From: Colin King <colin.king@canonical.com>
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: OCTEON: irq: check for null return on kzalloc allocation
Date: Thu, 22 Feb 2018 18:08:53 +0000
Message-Id: <20180222180853.11505-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The allocation of host_data is not null checked, leading to a
null pointer dereference if the allocation fails. Fix this by
adding a null check and return with -ENOMEM.

Fixes: 64b139f97c01 ("MIPS: OCTEON: irq: add CIB and other fixes")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/mips/cavium-octeon/octeon-irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index b993d9f2c9b9..203e1d2a56d5 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2277,6 +2277,8 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 	}
 
 	host_data = kzalloc(sizeof(*host_data), GFP_KERNEL);
+	if (!host_data)
+		return -ENOMEM;
 	raw_spin_lock_init(&host_data->lock);
 
 	addr = of_get_address(ciu_node, 0, NULL, NULL);
-- 
2.15.1
