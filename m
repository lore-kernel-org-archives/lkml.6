Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165403AbeE1NgZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:36:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937216AbeE1Kpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:45:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 098/496] gpu: ipu-v3: prg: fix device node leak in ipu_prg_lookup_by_phandle
Date: Mon, 28 May 2018 11:58:03 +0200
Message-Id: <20180528100323.990349756@linuxfoundation.org>
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

From: Tobias Jordan <Tobias.Jordan@elektrobit.com>

[ Upstream commit 3addaba8141bc6a4f649a48f46e552af32922147 ]

Before returning, call of_node_put() for the device node returned by
of_parse_phandle().

Fixes: ea9c260514c1 ("gpu: ipu-v3: add driver for Prefetch Resolve Gasket")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/ipu-v3/ipu-prg.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -101,11 +101,14 @@ ipu_prg_lookup_by_phandle(struct device
 			mutex_unlock(&ipu_prg_list_mutex);
 			device_link_add(dev, prg->dev, DL_FLAG_AUTOREMOVE);
 			prg->id = ipu_id;
+			of_node_put(prg_node);
 			return prg;
 		}
 	}
 	mutex_unlock(&ipu_prg_list_mutex);
 
+	of_node_put(prg_node);
+
 	return NULL;
 }
 
