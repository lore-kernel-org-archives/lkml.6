Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08C9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC2F20665
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfBWN7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:59:18 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:17561 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727988AbfBWN6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:58:53 -0500
X-IronPort-AV: E=Sophos;i="5.58,403,1544482800"; 
   d="scan'208";a="370609508"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 23 Feb 2019 14:58:44 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] meson-gx-socinfo: add missing of_node_put after of_device_is_available
Date:   Sat, 23 Feb 2019 14:20:40 +0100
Message-Id: <1550928043-14889-10-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an of_node_put when a tested device node is not available.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
identifier f;
local idexpression e;
expression x;
@@

e = f(...);
... when != of_node_put(e)
    when != x = e
    when != e = x
    when any
if (<+...of_device_is_available(e)...+>) {
  ... when != of_node_put(e)
(
  return e;
|
+ of_node_put(e);
  return ...;
)
}
// </smpl>

Fixes: a9daaba2965e8 ("soc: Add Amlogic SoC Information driver")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/soc/amlogic/meson-gx-socinfo.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -u -p a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -123,8 +123,10 @@ static int __init meson_gx_socinfo_init(
 		return -ENODEV;
 
 	/* check if interface is enabled */
-	if (!of_device_is_available(np))
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 
 	/* check if chip-id is available */
 	if (!of_property_read_bool(np, "amlogic,has-chip-id"))

