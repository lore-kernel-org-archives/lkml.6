Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4162C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A2820645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A2820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeIDU35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:29:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726015AbeIDU35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:29:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE3E57721E;
        Tue,  4 Sep 2018 16:04:11 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-125.brq.redhat.com [10.40.204.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 616F32026988;
        Tue,  4 Sep 2018 16:04:10 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     devel@linuxdriverproject.org
Cc:     linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH] tools: hv: fcopy: set 'error' in case an unknown operation was requested
Date:   Tue,  4 Sep 2018 18:04:07 +0200
Message-Id: <20180904160407.13925-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 04 Sep 2018 16:04:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 04 Sep 2018 16:04:12 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'error' variable is left uninitialized in case we see an unknown operation.
As we don't immediately return and proceed to pwrite() we need to set it
to something, HV_E_FAIL sounds good enough.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
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
2.14.4

