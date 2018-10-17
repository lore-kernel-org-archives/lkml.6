Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3E3ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141DE208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDYHeb55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141DE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeJREX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbeJREXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:23:55 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A21F0205C9;
        Wed, 17 Oct 2018 20:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539807993;
        bh=zpT7UireD1ItP5RiktIpblweOZprE+CUfevI/Lmaa1k=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=PDYHeb55KtGc+CSKy0mVjMIvJM4VrvdL8uSKIt4Nevwhje880pKmXzrYlP2RcVdSy
         LCycqjFJxalnuW0xpFqzvXsLXYvVI1Peg5xb2OO7slh3Un1EdpLnp47wv8Sx34BIxF
         WovOROrusOCl1tsm2t5O6hCtoZxI8iJB/w7p+y7s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        sayalil@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181005172732.203793-1-evgreen@chromium.org>
Cc:     Evan Green <evgreen@chromium.org>
References: <20181005172732.203793-1-evgreen@chromium.org>
Message-ID: <153980799299.5275.16452063085933398872@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] scsi: ufs: Schedule clk gating work on correct queue
Date:   Wed, 17 Oct 2018 13:26:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2018-10-05 10:27:32)
> With commit 10e5e37581fc ("scsi: ufs: Add clock ungating to a separate
> workqueue"), clock gating work was moved to a
> separate work queue with WQ_MEM_RECLAIM set, since clock
> gating could occur from a memory reclaim context. Unfortunately,
> clk_gating.gate_work was left queued via schedule_delayed_work,
> which is a system workqueue that does not have WQ_MEM_RECLAIM set.
> Because ufshcd_ungate_work attempts to cancel gate_work, the
> following warning appears:
> =

> [   14.174170] workqueue: WQ_MEM_RECLAIM ufs_clk_gating_0:ufshcd_ungate_w=
ork is flushing !WQ_MEM_RECLAIM events:ufshcd_gate_work
> [   14.174179] WARNING: CPU: 4 PID: 173 at kernel/workqueue.c:2440 check_=
flush_dependency+0x110/0x118
> [   14.205725] CPU: 4 PID: 173 Comm: kworker/u16:3 Not tainted 4.14.68 #1
> [   14.212437] Hardware name: Google Cheza (rev1) (DT)
> [   14.217459] Workqueue: ufs_clk_gating_0 ufshcd_ungate_work
> [   14.223107] task: ffffffc0f6a40080 task.stack: ffffff800a490000
> [   14.229195] PC is at check_flush_dependency+0x110/0x118
> [   14.234569] LR is at check_flush_dependency+0x110/0x118
> [   14.239944] pc : [<ffffff80080cad14>] lr : [<ffffff80080cad14>] pstate=
: 60c001c9
> [   14.333050] Call trace:
> [   14.427767] [<ffffff80080cad14>] check_flush_dependency+0x110/0x118
> [   14.434219] [<ffffff80080cafec>] start_flush_work+0xac/0x1fc
> [   14.440046] [<ffffff80080caeec>] flush_work+0x40/0x94
> [   14.445246] [<ffffff80080cb288>] __cancel_work_timer+0x11c/0x1b8
> [   14.451433] [<ffffff80080cb4b8>] cancel_delayed_work_sync+0x20/0x30
> [   14.457886] [<ffffff80085b9294>] ufshcd_ungate_work+0x24/0xd0
> [   14.463800] [<ffffff80080cfb04>] process_one_work+0x32c/0x690
> [   14.469713] [<ffffff80080d0154>] worker_thread+0x218/0x338
> [   14.475361] [<ffffff80080d527c>] kthread+0x120/0x130
> [   14.480470] [<ffffff8008084814>] ret_from_fork+0x10/0x18
> =

> The simple solution is to put the gate_work on the same WQ_MEM_RECLAIM
> work queue as the ungate_work.
> =

> Fixes: 10e5e37581fc ("scsi: ufs: Add clock ungating to a separate workque=
ue")
> Signed-off-by: Evan Green <evgreen@chromium.org>
> =

> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

