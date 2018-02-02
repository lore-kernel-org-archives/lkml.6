Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeBBPpZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:45:25 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:54813 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeBBPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:45:15 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
        Tomer Tayar <Tomer.Tayar@cavium.com>,
        "Mintz, Yuval" <Yuval.Mintz@cavium.com>,
        Chad Dupuis <Chad.Dupuis@cavium.com>,
        Manish Rangankar <Manish.Rangankar@cavium.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: qed: use correct strncpy() size
Date: Fri,  2 Feb 2018 16:44:47 +0100
Message-Id: <20180202154500.1616404-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:NkfWICbPC/pJdeAkB3eE3KxqSALmeTBcrC3RidHPT2tcyk5ufv6
 hK53B8E0h8qiE9/tpYlek6VYNoqku41lN6HtM+G+E3sPODN8fqF79jQmJGzoas58Yw45Lw/
 uj4R4gF0BxEg1XQfkzjZQoa8/OZ5faKCDqKqxEFRXUIZuGsfyMc+uK1PKab8LyOckIpxanF
 LE69cZOrYrWX7CqF7F3eA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6n7e43UWz3U=:Jc7tQrEvSZ/ch5qtz2HLHG
 +IiTxGwNMEqjeuQkaxyef0nSexHm86zObrm1vGcpabioI0fNyOY2gZaxNtzfNsh4vrdOuto+o
 IDNYuCTOYDc39WJxs4TU0xxljnE32Ll5QIzVNCGZqbXvH5UcBJvz7yk0dLwWDyi+4W5QMkLOn
 UARBvNy8k/t4aVLumjMJIUDq04wLB7+icigUL4MXomAU9oLhc+wVlkBPBbBx6pQfsFivcci5M
 Z9rqzp5LbTQ16HjrLBq7COdcDlSITJy8b5ETaRLeOXF+LS0tCQjFVKVhpUVyFAk9mEhm1hnJt
 aBdirjkISB6C3mnK7BZnzfSLb232m3of0sI5VMO+znf+KCdj4v72qKfxyf7NojTwTcu6O1zg+
 TBqdgFW3gcOrmuT2EGLN/UvBFDEyZsKgy7z+JJYQvZI6XbItwigA5CGpC9owDA76oAiEEvC3R
 D5u92QOQKdBPtcC+elcMU3JYap/jSPHe5kOvZ6UyP27soV62G3pniRgcUrKE3X9cOHiyfnB0Y
 hZw1/JpfgNPM/lJQ0iEzzNyEsV4QN9TDvvfTlXHy9HmlPL+7+K4uhwwT0y/8tHLJxaEakifOi
 o7crZi6dozrKYDsG9DoTqSLHTY5Ak3dibdG1IGTAM5j3K2ZK4cmIG/k2QpLqQZtL11fmynzPP
 jKqMXMGk7Ydq426lp1XGxUsJr+N/KEHoDQxQvBKOQeEmex15bgu2EDUSXMdUBKm2t6IgjHsB/
 WTAE8kP24jReu79b0+FRqrCgvPYZxUnXR8q5Xw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

passing the strlen() of the source string as the destination
length is pointless, and gcc-8 now warns about it:

drivers/net/ethernet/qlogic/qed/qed_debug.c: In function 'qed_grc_dump':
include/linux/string.h:253: error: 'strncpy' specified bound depends on the length of the source argument [-Werror=stringop-overflow=]

This changes qed_grc_dump_big_ram() to instead uses the length of
the destination buffer, and use strscpy() to guarantee nul-termination.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/qlogic/qed/qed_debug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index f2633ec87a6a..fdf37abee3d3 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -3649,10 +3649,8 @@ static u32 qed_grc_dump_big_ram(struct qed_hwfn *p_hwfn,
 		     BIT(big_ram->is_256b_bit_offset[dev_data->chip_id]) ? 256
 									 : 128;
 
-	strncpy(type_name, big_ram->instance_name,
-		strlen(big_ram->instance_name));
-	strncpy(mem_name, big_ram->instance_name,
-		strlen(big_ram->instance_name));
+	strscpy(type_name, big_ram->instance_name, sizeof(type_name));
+	strscpy(mem_name, big_ram->instance_name, sizeof(mem_name));
 
 	/* Dump memory header */
 	offset += qed_grc_dump_mem_hdr(p_hwfn,
-- 
2.9.0
