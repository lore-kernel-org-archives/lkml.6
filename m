Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19C0C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A33217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359580;
	bh=XevcfxG2dDFBnZnrplg6g6ZPumaR+EeSrzkdw3ZFQEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zeNWCvCmF7QRtzduMFqLGJQNFNrqCEGPBpLTxXpQe0RHjl03N7SZlnii6absZKbhM
	 ZpG1qRICSPb/P1lGPV8pGEt3DWyDdJFdYAgJOakUzoM36AYAPTQlJ3kN/iSlRiNnUe
	 sibVAnolbCSO+pb+0BrCwWBVxwQLM9apPPudj+XY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbfAXTii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:38:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730387AbfAXTih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:38:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A952521906;
        Thu, 24 Jan 2019 19:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358716;
        bh=XevcfxG2dDFBnZnrplg6g6ZPumaR+EeSrzkdw3ZFQEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lk0ULyU2P+LxraKSSoLovn9WJITLYQfjgfuUN9HCjNDd/COtOltQYesNOb1taWRs+
         F6LD67J9rWdzQN7Sfj6i3BKe1zeNUBslWTTa7GTETkh+GdJQhDapYoga7Wmh72m4J7
         Sp+QoS7ok6XZpCR1hhI6VeejDPYiOKOVxD2qITLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jonas Danielsson <jonas@orbital-systems.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 059/106] mmc: atmel-mci: do not assume idle after atmci_request_end
Date:   Thu, 24 Jan 2019 20:20:16 +0100
Message-Id: <20190124190210.173972294@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

[ Upstream commit ae460c115b7aa50c9a36cf78fced07b27962c9d0 ]

On our AT91SAM9260 board we use the same sdio bus for wifi and for the
sd card slot. This caused the atmel-mci to give the following splat on
the serial console:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 538 at drivers/mmc/host/atmel-mci.c:859 atmci_send_command+0x24/0x44
  Modules linked in:
  CPU: 0 PID: 538 Comm: mmcqd/0 Not tainted 4.14.76 #14
  Hardware name: Atmel AT91SAM9
  [<c000fccc>] (unwind_backtrace) from [<c000d3dc>] (show_stack+0x10/0x14)
  [<c000d3dc>] (show_stack) from [<c0017644>] (__warn+0xd8/0xf4)
  [<c0017644>] (__warn) from [<c0017704>] (warn_slowpath_null+0x1c/0x24)
  [<c0017704>] (warn_slowpath_null) from [<c033bb9c>] (atmci_send_command+0x24/0x44)
  [<c033bb9c>] (atmci_send_command) from [<c033e984>] (atmci_start_request+0x1f4/0x2dc)
  [<c033e984>] (atmci_start_request) from [<c033f3b4>] (atmci_request+0xf0/0x164)
  [<c033f3b4>] (atmci_request) from [<c0327108>] (mmc_start_request+0x280/0x2d0)
  [<c0327108>] (mmc_start_request) from [<c032800c>] (mmc_start_areq+0x230/0x330)
  [<c032800c>] (mmc_start_areq) from [<c03366f8>] (mmc_blk_issue_rw_rq+0xc4/0x310)
  [<c03366f8>] (mmc_blk_issue_rw_rq) from [<c03372c4>] (mmc_blk_issue_rq+0x118/0x5ac)
  [<c03372c4>] (mmc_blk_issue_rq) from [<c033781c>] (mmc_queue_thread+0xc4/0x118)
  [<c033781c>] (mmc_queue_thread) from [<c002daf8>] (kthread+0x100/0x118)
  [<c002daf8>] (kthread) from [<c000a580>] (ret_from_fork+0x14/0x34)
  ---[ end trace 594371ddfa284bd6 ]---

This is:
  WARN_ON(host->cmd);

This was fixed on our board by letting atmci_request_end determine what
state we are in. Instead of unconditionally setting it to STATE_IDLE on
STATE_END_REQUEST.

Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/atmel-mci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index be53044086c7..fbc56ee99682 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1954,13 +1954,14 @@ static void atmci_tasklet_func(unsigned long priv)
 			}
 
 			atmci_request_end(host, host->mrq);
-			state = STATE_IDLE;
+			goto unlock; /* atmci_request_end() sets host->state */
 			break;
 		}
 	} while (state != prev_state);
 
 	host->state = state;
 
+unlock:
 	spin_unlock(&host->lock);
 }
 
-- 
2.19.1



