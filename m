Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeB1Nd2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:33:28 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:47909 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbeB1Nd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:33:26 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Jianlin Shi <jishi@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ipv4: avoid unused variable warning for sysctl
Date: Wed, 28 Feb 2018 14:32:48 +0100
Message-Id: <20180228133310.1816221-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:GuEI6Gy/ujjYdIMBRnIPiDzRJncFk19uV4JM3y/8KnEi2t/I7qk
 7OYI3gzWi/YAz/yJwUcJeWT7LGmJ6Xa9Mj2fmORA3CRDz6E5hN4Vqzgf27RvGQJOqL5iPHD
 VX/VKL1yZDBC5H7oJghqlxvU0UD89z4vS2FwmAt/ORMjyIvc4m1oYDucp+8U/lrZ26B3Y9z
 oRCw6dO1fq4J27YWocRhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RJJklWIbVl4=:axdcu3eiCJQjBUxiduACI7
 /GVUcS+Mm67jw8uhlL6yispUWLG+M//FaWqUtOWE0Rzg8syXXIzGjrmhjlxRzSCgrASb9pDwh
 weRe+BaHHxW04aXhQnXzTl51T+IaODjXTb0y28zUC6uGJr67tkcSLcbrW/mIQrhhowjqShAfc
 nJGFYCvK0xOiGRkuEeelNYRKyioN/JHxxC4ObLUgHAzf2WVuafy/ycE3JFPXp68zx5G0KTkOm
 LxW4ffy71UvKUhYplQIHSBp5cDBfGc8QyjZIc86XTC1XgC3HWhGnUugWhXy1kGGq4bb0H3oyW
 4CM5GtPlR7NvLb+ti03mGp4hZ0mS9heFdHwydzLACrOiogDLkVzvPzdz0Kz/Lz6PRW1D+tanE
 ipYXkp0Wlsv3ti844yXHHila73dboNjtdStwZqJW2TXpfLD6g5wbW7gDpjHRkijHWIm/RvG2/
 TQUUDkuOwBMm41afgEsrITT8ECTlZe6n5GAThmPgXyL2NEf/92CO2vm+NP9EJjdIS18SyoPGq
 ONFyQWbDTH4hk6emzmO78Dw8CmOBaDrxTLn2byvE0eXIswe6jRlvGFyggFHuD1dTV5ePbTkvp
 GdOTa9H4o5rWlspzwyuIBFzPAyRJ8oeqiY28CFizZC9NLUOvlXfhgEMxj2s9va+NMlrCUMPt+
 kayPtbrV4NhDj35n7X788dYHomfWzAl9O2exvfusO0o5KL7NknAte8n89yfpuYlUtGeyNmGQW
 hyycxpI9MTwJA/RmaWoLF91Qq7ugxPZEXaBjAQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introudced ip_min_valid_pmtu variable is only used when
CONFIG_SYSCTL is set:

net/ipv4/route.c:135:12: error: 'ip_min_valid_pmtu' defined but not used [-Werror=unused-variable]

This moves it to the other variables like it, to avoid the harmless
warning.

Fixes: c7272c2f1229 ("net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/ipv4/route.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 5c85db355d1f..8d1f5c3a1745 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -132,8 +132,6 @@ static int ip_rt_min_advmss __read_mostly	= 256;
 
 static int ip_rt_gc_timeout __read_mostly	= RT_GC_TIMEOUT;
 
-static int ip_min_valid_pmtu __read_mostly	= IPV4_MIN_MTU;
-
 /*
  *	Interface to generic destination cache.
  */
@@ -2805,6 +2803,7 @@ void ip_rt_multicast_event(struct in_device *in_dev)
 static int ip_rt_gc_interval __read_mostly  = 60 * HZ;
 static int ip_rt_gc_min_interval __read_mostly	= HZ / 2;
 static int ip_rt_gc_elasticity __read_mostly	= 8;
+static int ip_min_valid_pmtu __read_mostly	= IPV4_MIN_MTU;
 
 static int ipv4_sysctl_rtcache_flush(struct ctl_table *__ctl, int write,
 					void __user *buffer,
-- 
2.9.0
