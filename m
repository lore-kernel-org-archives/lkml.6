Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A525C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4236121736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867132;
	bh=l8DHyLL9bbUQHiZK02k2EnHdUCbaZIYgBckkGw8wocc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fG4wToA7T+dt1mazjm8NnxuitsifnZBus7PNb7bb+uzqGM88ssoqmmuG/hQ1iUVP9
	 VZUHXSIhSDkXc3WV3VITzOrhYzRw53OhZ1UUlNHZv7CaUTLbZ8wqjX3XpKyuMmr4rR
	 ENebf3b1QNk9Dbp3OohyybhM0kTnHESeKVkRsYMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfAGNSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbfAGM6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:58:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32BE121855;
        Mon,  7 Jan 2019 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865909;
        bh=l8DHyLL9bbUQHiZK02k2EnHdUCbaZIYgBckkGw8wocc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=apYV8J4SIk86soOTQXB0InWtH7JFknOG6QB7sSvhHqX2vXmyMmglQ/TQwumnXRafv
         q1o8XQ6BmKMAFLN3VJj2G1DPicNiPCXnKpXYf2rvGfYE0hTykSZRfvpNolU3lnCAFz
         i5CTfvMaGrXqNFtOu0IPLwbeftWusIkXVSH6JoRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH 4.19 155/170] MIPS: OCTEON: mark RGMII interface disabled on OCTEON III
Date:   Mon,  7 Jan 2019 13:33:02 +0100
Message-Id: <20190107104511.246060303@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit edefae94b7b9f10d5efe32dece5a36e9d9ecc29e upstream.

Commit 885872b722b7 ("MIPS: Octeon: Add Octeon III CN7xxx
interface detection") added RGMII interface detection for OCTEON III,
but it results in the following logs:

[    7.165984] ERROR: Unsupported Octeon model in __cvmx_helper_rgmii_probe
[    7.173017] ERROR: Unsupported Octeon model in __cvmx_helper_rgmii_probe

The current RGMII routines are valid only for older OCTEONS that
use GMX/ASX hardware blocks. On later chips AGL should be used,
but support for that is missing in the mainline. Until that is added,
mark the interface as disabled.

Fixes: 885872b722b7 ("MIPS: Octeon: Add Octeon III CN7xxx interface detection")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: stable@vger.kernel.org # 4.7+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/cavium-octeon/executive/cvmx-helper.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -286,7 +286,8 @@ static cvmx_helper_interface_mode_t __cv
 	case 3:
 		return CVMX_HELPER_INTERFACE_MODE_LOOP;
 	case 4:
-		return CVMX_HELPER_INTERFACE_MODE_RGMII;
+		/* TODO: Implement support for AGL (RGMII). */
+		return CVMX_HELPER_INTERFACE_MODE_DISABLED;
 	default:
 		return CVMX_HELPER_INTERFACE_MODE_DISABLED;
 	}


