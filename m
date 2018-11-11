Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C122C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46857214F1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1LaNpDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46857214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391393AbeKLI25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:28:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405022AbeKLIZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:25:15 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87FCD224B3;
        Sun, 11 Nov 2018 22:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975717;
        bh=ucBViScH4sqlT3AFQA9WPDaxaH8oFZ1v0dbgItMO+s4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1LaNpDWVI4/idx9P2lk6/9cT3VY3d6wNQRP5XJZWP8RYdRtGzSbN79MFY1od+uMS
         JNUSgLdbcmWS7/LycuOT1y4n9bp/FlsljPgpUELTw3318SeeBOPQhpV9wv9Lq5PXuZ
         J43lJEWDXQAOVoyso6ERcovmkvTX4/VamvtFeec0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.9 116/141] MIPS: OCTEON: fix out of bounds array access on CN68XX
Date:   Sun, 11 Nov 2018 14:26:15 -0800
Message-Id: <20181111221643.956252172@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit c0fae7e2452b90c31edd2d25eb3baf0c76b400ca upstream.

The maximum number of interfaces is returned by
cvmx_helper_get_number_of_interfaces(), and the value is used to access
interface_port_count[]. When CN68XX support was added, we forgot
to increase the array size. Fix that.

Fixes: 2c8c3f0201333 ("MIPS: Octeon: Support additional interfaces on CN68XX")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20949/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v4.3+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/cavium-octeon/executive/cvmx-helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -67,7 +67,7 @@ void (*cvmx_override_pko_queue_priority)
 void (*cvmx_override_ipd_port_setup) (int ipd_port);
 
 /* Port count per interface */
-static int interface_port_count[5];
+static int interface_port_count[9];
 
 /* Port last configured link info index by IPD/PKO port */
 static cvmx_helper_link_info_t


