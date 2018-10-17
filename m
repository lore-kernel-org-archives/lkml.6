Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FB4ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC54204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GF1l6v1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC54204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeJREED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:04:03 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37284 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbeJREED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:04:03 -0400
Received: by mail-vs1-f66.google.com with SMTP id r83so21600148vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 13:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X9gRrZG04pxHNBkosxy9k6dxyM5/HCNs238NB5+dtpY=;
        b=GF1l6v1R558umPwxFYpJLZS0Tw3YwenxeAd1a+RGI/2V3d5a+Zwg/P9WiN9gfuvkzG
         OS5mmIzR3Ci8aYlN0njUnDSm1tPIWGupy6aWN9kDXDr9q86HtaSvE2QSuerOpyC0Hbcm
         SCmVRkec2HNfrsK6Bp3sUL5rC9ko2Y77IWliQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9gRrZG04pxHNBkosxy9k6dxyM5/HCNs238NB5+dtpY=;
        b=BQYoXaonmUtUzB/0SexffIxvIolFscpfUhVnpCV4pKAVGSDld0ZmiMbX54G7+luMiv
         /53iG1tt6ZECgW8v/f+219FsRmkFJD0SApFdaoyCj6i8kdPQbDEMYlm3HnIYVt4gsNsU
         4p5o3V04tB62ZuMFi/P23lNYzfQm/Oy4GBMoR053LlxXU9DHPnJEL+dc7bsVGFhqgFjg
         KhWmDiVq00eouDAIJ9bZqrYiyzLtOihmCPYMDYoVuEP3d4fbdhfETzgxRcZKsdWyfDIT
         fXD1WFHMMaHFaG41IfLxJk7lLajUyo/F4C9rKbrDa7oaJH6g6swuq1kfBaYzWO91WMsP
         o2fA==
X-Gm-Message-State: ABuFfoijvGw+9sStPI8mrnGgDBHZgzTDXPDkxw+bgQdhUvGQ7I9tMxLg
        mjbVEI0CM7V/Ykrq9N46wzoOde3r5pg=
X-Google-Smtp-Source: ACcGV60m3w85kJVPEgdJGpDSiqpVrxbNXpJefXYTV43vUvsNbh0+JYXhK3MidT7969xPNOCt/Sr2dg==
X-Received: by 2002:a67:43c7:: with SMTP id q190mr11152855vsa.128.1539806804350;
        Wed, 17 Oct 2018 13:06:44 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id b77sm1178589vka.21.2018.10.17.13.06.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 13:06:43 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id m5so21602459vsk.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 13:06:43 -0700 (PDT)
X-Received: by 2002:a67:6604:: with SMTP id a4mr11122499vsc.42.1539806802350;
 Wed, 17 Oct 2018 13:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181005172732.203793-1-evgreen@chromium.org>
In-Reply-To: <20181005172732.203793-1-evgreen@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Oct 2018 13:06:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UR2b4XoyhKz6XpBByQ=MKNq-qyPjbLTNaLfSmzNXkgMQ@mail.gmail.com>
Message-ID: <CAD=FV=UR2b4XoyhKz6XpBByQ=MKNq-qyPjbLTNaLfSmzNXkgMQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: Schedule clk gating work on correct queue
To:     Evan Green <evgreen@chromium.org>
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        sayalil@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 5, 2018 at 10:28 AM Evan Green <evgreen@chromium.org> wrote:
>
> With commit 10e5e37581fc ("scsi: ufs: Add clock ungating to a separate
> workqueue"), clock gating work was moved to a
> separate work queue with WQ_MEM_RECLAIM set, since clock
> gating could occur from a memory reclaim context. Unfortunately,
> clk_gating.gate_work was left queued via schedule_delayed_work,
> which is a system workqueue that does not have WQ_MEM_RECLAIM set.
> Because ufshcd_ungate_work attempts to cancel gate_work, the
> following warning appears:
>
> [   14.174170] workqueue: WQ_MEM_RECLAIM ufs_clk_gating_0:ufshcd_ungate_work is flushing !WQ_MEM_RECLAIM events:ufshcd_gate_work
> [   14.174179] WARNING: CPU: 4 PID: 173 at kernel/workqueue.c:2440 check_flush_dependency+0x110/0x118
> [   14.205725] CPU: 4 PID: 173 Comm: kworker/u16:3 Not tainted 4.14.68 #1
> [   14.212437] Hardware name: Google Cheza (rev1) (DT)
> [   14.217459] Workqueue: ufs_clk_gating_0 ufshcd_ungate_work
> [   14.223107] task: ffffffc0f6a40080 task.stack: ffffff800a490000
> [   14.229195] PC is at check_flush_dependency+0x110/0x118
> [   14.234569] LR is at check_flush_dependency+0x110/0x118
> [   14.239944] pc : [<ffffff80080cad14>] lr : [<ffffff80080cad14>] pstate: 60c001c9
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
>
> The simple solution is to put the gate_work on the same WQ_MEM_RECLAIM
> work queue as the ungate_work.
>
> Fixes: 10e5e37581fc ("scsi: ufs: Add clock ungating to a separate workqueue")
> Signed-off-by: Evan Green <evgreen@chromium.org>
>
> ---
>  drivers/scsi/ufs/ufshcd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Seems sane to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
