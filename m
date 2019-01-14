Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974BCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7024920657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfANDZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:25:31 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56080 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbfANDZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 22:25:31 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CECD18FEB597A05AEB81;
        Mon, 14 Jan 2019 11:25:28 +0800 (CST)
Received: from hisi.inhuawei.com (100.106.241.83) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 14 Jan 2019 11:25:21 +0800
Date:   Mon, 14 Jan 2019 11:24:45 +0800
From:   Zang Leigang <zangleigang@hisilicon.com>
To:     Avri Altman <Avri.Altman@wdc.com>
CC:     John Stultz <john.stultz@linaro.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>, Wei Li <liwei213@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: ufshcd_queuecommand() triggering after ufshcd_suspend()?
Message-ID: <20190114032444.GA124121@hisi.inhuawei.com>
References: <CALAqxLURfQcSy2w7F7NCPtGaChka4U5LmvufLd0VZ73S=AzHkA@mail.gmail.com>
 <SN6PR04MB4925CA2AFE5F060469E6F018FC850@SN6PR04MB4925.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <SN6PR04MB4925CA2AFE5F060469E6F018FC850@SN6PR04MB4925.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [100.106.241.83]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

  I think there are two different issues:

  1. clk_gating's state(including state's trace event) and is_suspended is not
     wrapped by ufshcd_is_clkgating_allowed which Hisilicon's kirin platoform
     soc does not need but is set and checked in a regular path.
  2. I think SCSI is necessary to block queue to stop sending to ufs after
     system suspend or, add a new state for ufs like UFSHCD_STATE_SUSPENDING
     or what else. hba->is_sys_suspended is too late to stop ufshcd_queuecommand

On Fri, Jan 11, 2019 at 06:39:56AM +0000, Avri Altman wrote:
> +Zang
> 
> Thanks,
> Avri
> 
> 
> 
> ________________________________________
> From: John Stultz <john.stultz@linaro.org>
> Sent: Friday, January 11, 2019 1:02:21 AM
> To: Sahitya Tummala; Christoph Hellwig; Wei Li; Martin K. Petersen
> Cc: Evan Green; Avri Altman; Vijay Viswanath; lkml; linux-scsi@vger.kernel.org
> Subject: ufshcd_queuecommand() triggering after ufshcd_suspend()?
> 
> Hey all,
>   Frequently, since support for the HiKey960's UFS code landed in
> 4.19, I've noticed the following warning on reboot:
> 
> [   23.086860] WARNING: CPU: 0 PID: 2507 at
> drivers/scsi/ufs/ufshcd.c:2460 ufshcd_queuecommand+0x59c/0x5a8
> [   23.096256] Modules linked in:
> [   23.099313] CPU: 0 PID: 2507 Comm: kworker/0:1H Tainted: G S
>         5.0.0-rc1-00068-g3f81a19 #273
> [   23.108873] Hardware name: HiKey960 (DT)
> [   23.112802] Workqueue: kblockd blk_mq_requeue_work
> [   23.117591] pstate: 80400005 (Nzcv daif +PAN -UAO)
> [   23.122378] pc : ufshcd_queuecommand+0x59c/0x5a8
> [   23.126990] lr : ufshcd_queuecommand+0x58c/0x5a8
> [   23.131600] sp : ffffff8015e1ba80
> [   23.134907] x29: ffffff8015e1ba80 x28: ffffffc217f94048
> [   23.140214] x27: 0000000000000010 x26: ffffffc217a7c8b8
> [   23.145520] x25: ffffffc217a7c000 x24: ffffffc217a7ceb0
> [   23.150827] x23: 0000000000000000 x22: ffffffc217a7c808
> [   23.156133] x21: ffffffc217f94120 x20: 0000000000000010
> [   23.161440] x19: ffffff801186d000 x18: ffffff801186db08
> [   23.166746] x17: 0000000000000000 x16: 0000000000000000
> [   23.172053] x15: ffffff8095e1b7c7 x14: 692064616574736e
> [   23.177360] x13: 6928204e4f5f534b x12: 4c43203d21206574
> [   23.182666] x11: 6174732e676e6974 x10: 61675f6b6c633e2d
> [   23.187973] x9 : 61626820646e616d x8 : 6d6f636575657571
> [   23.193280] x7 : 0000000000000000 x6 : ffffff801186e000
> [   23.198586] x5 : ffffff801186e270 x4 : ffffff8010096dc0
> [   23.203894] x3 : 0000000000010000 x2 : 47dd99afde511d00
> [   23.209201] x1 : 0000000000000000 x0 : 0000000000000000
> [   23.214509] Call trace:
> [   23.216952]  ufshcd_queuecommand+0x59c/0x5a8
> [   23.221220]  scsi_queue_rq+0x5b4/0x880
> [   23.224964]  blk_mq_dispatch_rq_list+0xb0/0x510
> [   23.229492]  blk_mq_sched_dispatch_requests+0xf4/0x198
> [   23.234626]  __blk_mq_run_hw_queue+0xb4/0x120
> [   23.238978]  __blk_mq_delay_run_hw_queue+0x110/0x200
> [   23.243937]  blk_mq_run_hw_queue+0xb8/0x118
> [   23.248114]  blk_mq_run_hw_queues+0x58/0x78
> [   23.252291]  blk_mq_requeue_work+0x140/0x168
> [   23.256560]  process_one_work+0x158/0x468
> [   23.260564]  worker_thread+0x50/0x460
> [   23.264222]  kthread+0x104/0x130
> [   23.267447]  ret_from_fork+0x10/0x1c
> [   23.271017] ---[ end trace 45f1ee04059cdf00 ]---
> 
> Since the warning is triggering from the WARN_ON(hba->clk_gating.state
> != CLKS_ON) line, I annotated the clk_gating.state changes, and am
> seeing on reboot:
>   vdc: Waited 0ms for vold
>   sd 0:0:0:3: [sdd] Synchronizing SCSI cache
>   sd 0:0:0:2: [sdc] Synchronizing SCSI cache
>   sd 0:0:0:1: [sdb] Synchronizing SCSI cache
>   sd 0:0:0:0: [sda] Synchronizing SCSI cache
>   ufshcd_suspend: setting clk_gating.state CLKS_OFF
>   ufshcd_queuecommand hba->clk_gating.state != CLKS_ON (instead its 0)
> <warning splat>
> 
> So it seems like ufshcd_suspend() is has run, but then the workqueue
> (occasionally) fires afterwards triggering the issue.
> 
> Maybe should something in ufshcd_queuecommand be checking the
> clk_gating.is_suspended flag before proceeding?
> 
> Other ideas?  The logic all seems to be in the generic code, but I'm
> not sure if maybe the ufs-hisi.c code is mis-managing something?
> 
> thanks
> -john

-- 
Thanks,
Zang Leigang
