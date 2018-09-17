Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E445ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8F820685
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8F820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeIQJla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:41:30 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:41848
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbeIQJla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 05:41:30 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 1kw5gSHI9nFs21kw5gjcuQ; Sun, 16 Sep 2018 21:14:57 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1g1kw5-0002zY-F0; Sun, 16 Sep 2018 21:14:57 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/2] tools: hv: fcopy: set 'error' in case an unknown operation was requested
Date:   Mon, 17 Sep 2018 04:14:55 +0000
Message-Id: <20180917041455.11455-2-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180917041455.11455-1-kys@linuxonhyperv.com>
References: <20180917041352.11402-1-kys@linuxonhyperv.com>
 <20180917041455.11455-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfDh+ulmjiMC20UAxGFt/MWlXFR/65bplrvfLbcVzXeKdDB5GO7K0Fai6TlkU0y5lUo9g591QjJ1inasIqQX/Ees7WfXciBWTkymB1Vffy0kwYOkrmHec
 bJ9Iyr+TzpdlQUBWE5FnA1jXebqdxraS3WjaiPuzp+h1+m6NHtumOdfhelBW35E+nKmfVEsehEDo/YLoU3ZgVNAfelLIqIr1ob61ND975AcyNs55yj0xGv3z
 n7rKxe3Y4fmxahjg512S6zQjPDwb2ewTComQU0f+2Amj4AWwToTCM5XftZoEqkCZElbEPfvPF+Y8CyT6QWMJ8ObD2kAYxpz6YRrAOo7/6IyQj5FRxjDPjkQi
 0LAJtD4YEAWsW1HfDNho0L6lnFsGzaoQrD1uLg4nyyBxhrPSmubnCYOFqC/eMA74PjPThPk0V3iFg/X1kx0v5+2IpGcCAQV3UXamjrB00ghaDVdWvDSijzDn
 qKD6L4O7d/5ODRhgsDxaZSyrLyx+MmZNpF/dB0fOTfNcHBHU/g7oWFimwQC9Z8FXDBhTUM/bJrfcuuN8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

'error' variable is left uninitialized in case we see an unknown operation.
As we don't immediately return and proceed to pwrite() we need to set it
to something, HV_E_FAIL sounds good enough.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 tools/hv/hv_fcopy_daemon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/hv/hv_fcopy_daemon.c b/tools/hv/hv_fcopy_daemon.c
index d78aed86af09..8ff8cb1a11f4 100644
--- a/tools/hv/hv_fcopy_daemon.c
+++ b/tools/hv/hv_fcopy_daemon.c
@@ -234,6 +234,7 @@ int main(int argc, char *argv[])
 			break;
 
 		default:
+			error = HV_E_FAIL;
 			syslog(LOG_ERR, "Unknown operation: %d",
 				buffer.hdr.operation);
 
-- 
2.18.0

