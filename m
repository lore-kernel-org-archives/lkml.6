Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3970C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB0A2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB0A2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733135AbeHWMRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:17:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732308AbeHWMRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:17:35 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9763D941;
        Thu, 23 Aug 2018 08:48:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 107/324] nfp: bpf: dont stop offload if replace failed
Date:   Thu, 23 Aug 2018 09:52:53 +0200
Message-Id: <20180823075001.182966381@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 68d676a089625daed9d61df56ac63b5cd7189efe ]

Stopping offload completely if replace of program failed dates
back to days of transparent offload.  Back then we wanted to
silently fall back to the in-driver processing.  Today we mark
programs for offload when they are loaded into the kernel, so
the transparent offload is no longer a reality.

Flags check in the driver will only allow replace of a driver
program with another driver program or an offload program with
another offload program.

When driver program is replaced stopping offload is a no-op,
because driver program isn't offloaded.  When replacing
offloaded program if the offload fails the entire operation
will fail all the way back to user space and we should continue
using the old program.  IOW when replacing a driver program
stopping offload is unnecessary and when replacing offloaded
program - it's a bug, old program should continue to run.

In practice this bug would mean that if offload operation was to
fail (either due to FW communication error, kernel OOM or new
program being offloaded but for a different netdev) driver
would continue reporting that previous XDP program is offloaded
but in fact no program will be loaded in hardware.  The failure
is fairly unlikely (found by inspection, when working on the code)
but it's unpleasant.

Backport note: even though the bug was introduced in commit
cafa92ac2553 ("nfp: bpf: add support for XDP_FLAGS_HW_MODE"),
this fix depends on commit 441a33031fe5 ("net: xdp: don't allow
device-bound programs in driver mode"), so this fix is sufficient
only in v4.15 or newer.  Kernels v4.13.x and v4.14.x do need to
stop offload if it was transparent/opportunistic, i.e. if
XDP_FLAGS_HW_MODE was not set on running program.

Fixes: cafa92ac2553 ("nfp: bpf: add support for XDP_FLAGS_HW_MODE")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/bpf/main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/bpf/main.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/main.c
@@ -73,10 +73,10 @@ nfp_bpf_xdp_offload(struct nfp_app *app,
 
 	ret = nfp_net_bpf_offload(nn, prog, running, extack);
 	/* Stop offload if replace not possible */
-	if (ret && prog)
-		nfp_bpf_xdp_offload(app, nn, NULL, extack);
+	if (ret)
+		return ret;
 
-	nn->dp.bpf_offload_xdp = prog && !ret;
+	nn->dp.bpf_offload_xdp = !!prog;
 	return ret;
 }
 


