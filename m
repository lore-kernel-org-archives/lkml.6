Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755568AbeDZKqU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:46:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55268 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754630AbeDZKqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:46:17 -0400
X-Google-Smtp-Source: AB8JxZokYNJOIA9tccZZ4ErpKXk7jBv0zRMtaKo1bT/Yb5L4VTU9ZYPmSi3BpGbjliDHGANADLz0lA==
From: Tobias Regnery <tobias.regnery@gmail.com>
To: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: alexey.kodanev@oracle.com, Tobias Regnery <tobias.regnery@gmail.com>
Subject: [PATCH net-next] geneve: fix build with modular IPV6
Date: Thu, 26 Apr 2018 12:36:36 +0200
Message-Id: <20180426103636.16113-1-tobias.regnery@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c40e89fd358e ("geneve: configure MTU based on a lower device") added
an IS_ENABLED(CONFIG_IPV6) to geneve, leading to the following link error
with CONFIG_GENEVE=y and CONFIG_IPV6=m:

drivers/net/geneve.o: In function `geneve_link_config':
geneve.c:(.text+0x14c): undefined reference to `rt6_lookup'

Fix this by adding a Kconfig dependency and forcing GENEVE to be a module
when IPV6 is a module.

Fixes: c40e89fd358e ("geneve: configure MTU based on a lower device")
Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
---
 drivers/net/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 891846655000..a029b27fd002 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -198,6 +198,7 @@ config VXLAN
 config GENEVE
        tristate "Generic Network Virtualization Encapsulation"
        depends on INET && NET_UDP_TUNNEL
+       depends on IPV6 || !IPV6
        select NET_IP_TUNNEL
        select GRO_CELLS
        ---help---
-- 
2.17.0
