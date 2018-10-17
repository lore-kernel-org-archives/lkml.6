Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08712C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA3A205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA3A205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeJQLI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:08:57 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:44682
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbeJQLIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:08:40 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id CcHhgp7VmM0DPCcHhged9E; Tue, 16 Oct 2018 20:14:09 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gCcHh-0000Dc-0u; Tue, 16 Oct 2018 20:14:09 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Stable@vger.kernel.org
Subject: [PATCH 5/5] Tools: hv: kvp: Fix a warning of buffer overflow with gcc 8.0.1
Date:   Wed, 17 Oct 2018 03:14:06 +0000
Message-Id: <20181017031406.773-5-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181017031406.773-1-kys@linuxonhyperv.com>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfPn+tlSGFom0noQShjvm2HXO+z7VdaPgc1tmAxstN5iJ60TiJtpoZQPDZqt9Z9snG8+/0pVcrarVsmvkjTCGtMgJgursML9S4gYaC2RFjJxIXpYsnMw9
 fvdTahNGm4b/Xj6vtodNMnWDqa36C0Z6TtJRKsxQMvtUW83cZhyIcrEiSMnsro5tFQj+dyK9wch2b3db9vZFZL6D/YwAkXPkeHSJDwmOmsUr4EBVUYQQJa2Q
 3euAQipj2+OJUicdS6YedMCSVdLnsqZqnKDNWTslkfMIpfH0LJAKwK6Hn9DxKHA70gAValZIMFOWf472YNg3BjOcpXVvOsDK095tiV7Rlq0I5ugFuXYcaiim
 0YXI0Q5KUPbyaRE8uZxjJmHnvfoBItVVt4WImP868mimQH9lCi429bSuCrQsqiNr0AyIRtrZwJYXMf/iyBev2z88eix4ICxbawRRgMYHJaiSkYNgh2XooJtD
 BSJm3V43eZf5ztxUATX2XXlErz/s/Acv7E6P8bHK0Rzjh3Tlc3f8MJcjjwo9UGN4iEEP/k/o+d+4J4lvmkwnA+EhJF8qGRRWvt71ljNHeibTrmuAb2OpoeWM
 PWkewaoJPY+R4V4Q2wupNpriyKOqyt25GWEgitgZfAYl0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

The patch fixes:

hv_kvp_daemon.c: In function 'kvp_set_ip_info':
hv_kvp_daemon.c:1305:2: note: 'snprintf' output between 41 and 4136 bytes
into a destination of size 4096

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 tools/hv/hv_kvp_daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index bbb2a8ef367c..b7c2cf7eaba5 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1176,7 +1176,7 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	int error = 0;
 	char if_file[PATH_MAX];
 	FILE *file;
-	char cmd[PATH_MAX];
+	char cmd[PATH_MAX * 2];
 	char *mac_addr;
 
 	/*
-- 
2.18.0

