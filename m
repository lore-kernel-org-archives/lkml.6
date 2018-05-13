Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeEMTtw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 15:49:52 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45866 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeEMTtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 15:49:50 -0400
X-Google-Smtp-Source: AB8JxZp9dzb1jZRoaXik2R74vE4gYw9T7XgFhsENPDwEfNRPdIVwwgnmIn0hMy697YsA2/A/Xvrz1g==
From: Anders Roxell <anders.roxell@linaro.org>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] net: ipv4: ipconfig: fix unused variable
Date: Sun, 13 May 2018 21:48:30 +0200
Message-Id: <20180513194830.29946-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PROC_FS isn't set, variable ipconfig_dir isn't used.
net/ipv4/ipconfig.c:167:31: warning: ‘ipconfig_dir’ defined but not used [-Wunused-variable]
 static struct proc_dir_entry *ipconfig_dir;
                               ^~~~~~~~~~~~
Move the declaration of ipconfig_dir inside the CONFIG_PROC_FS ifdef to
fix the warning.

Fixes: c04d2cb2009f ("ipconfig: Write NTP server IPs to /proc/net/ipconfig/ntp_servers")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 net/ipv4/ipconfig.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index d839d74853fc..86c9f755de3d 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -163,9 +163,6 @@ static u8 ic_domain[64];		/* DNS (not NIS) domain name */
  * Private state.
  */
 
-/* proc_dir_entry for /proc/net/ipconfig */
-static struct proc_dir_entry *ipconfig_dir;
-
 /* Name of user-selected boot device */
 static char user_dev_name[IFNAMSIZ] __initdata = { 0, };
 
@@ -1292,6 +1289,8 @@ static int __init ic_dynamic(void)
 #endif /* IPCONFIG_DYNAMIC */
 
 #ifdef CONFIG_PROC_FS
+/* proc_dir_entry for /proc/net/ipconfig */
+static struct proc_dir_entry *ipconfig_dir;
 
 /* Name servers: */
 static int pnp_seq_show(struct seq_file *seq, void *v)
-- 
2.17.0
