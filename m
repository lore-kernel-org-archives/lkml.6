Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF05C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CB12077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CB12077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=CARNet.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeIGV47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:56:59 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:40275 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbeIGV47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:56:59 -0400
Received: from [2001:b68:ff:12::131] (port=50902 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1fyKLT-0005UR-Ub; Fri, 07 Sep 2018 19:15:00 +0200
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id C4B75202E0; Fri,  7 Sep 2018 19:14:59 +0200 (CEST)
Date:   Fri, 7 Sep 2018 19:14:59 +0200
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     drbd-user@lists.linbit.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20180907171459.GO26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
 <20180907120337.GB11834@soda.linbit>
 <20180907121348.GM26705@gavran.carpriv.carnet.hr>
 <20180907132828.GC11834@soda.linbit>
 <20180907164500.GN26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907164500.GN26705@gavran.carpriv.carnet.hr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 06:45:00PM +0200, Valentin Vidic wrote:
> Adding a dump_stack in drbd_release gives two possible code paths,
> both from xen_blkback and the first one from workqueue being the
> problematic one:

In fact the first one is the original code path before I modified
blkback.  The problem is it gets executed async from workqueue so
it might not always run before the call to drbdadm secondary.

> [  530.698782] CPU: 0 PID: 4 Comm: kworker/0:0 Tainted: G           O    4.9.0-8-amd64 #1 Debian 4.9.110-3+deb9u4
> [  530.698783] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 09/12/2016
> [  530.698784] Workqueue: events xen_blkif_deferred_free [xen_blkback]
> [  530.698785]  0000000000000000 ffffffff81331e54 ffff883f82143800 ffff883f741b5660
> [  530.698787]  ffffffffc03a309e ffff883f741b5580 ffffffff81245ca8 0000000281a186b5
> [  530.698789]  000000008935f100 8412ffa31a64cc4c 000000000000020a ffff883fa6218280
> [  530.698791] Call Trace:
> [  530.698792]  [<ffffffff81331e54>] ? dump_stack+0x5c/0x78
> [  530.698805]  [<ffffffffc03a309e>] ? drbd_release+0x1e/0x40 [drbd]
> [  530.698810]  [<ffffffff81245ca8>] ? __blkdev_put+0x1e8/0x2a0
> [  530.698813]  [<ffffffffc055d6b8>] ? xen_vbd_free.isra.9+0x48/0x60 [xen_blkback]
> [  530.698814]  [<ffffffffc055d6f7>] ? xen_blkif_deferred_free+0x27/0x70 [xen_blkback]
> [  530.698816]  [<ffffffff81092fea>] ? process_one_work+0x18a/0x420
> [  530.698817]  [<ffffffff810932cd>] ? worker_thread+0x4d/0x490
> [  530.698818]  [<ffffffff81093280>] ? process_one_work+0x420/0x420
> [  530.698820]  [<ffffffff81099329>] ? kthread+0xd9/0xf0
> [  530.698822]  [<ffffffff81099250>] ? kthread_park+0x60/0x60
> [  530.698823]  [<ffffffff81615df7>] ? ret_from_fork+0x57/0x70

-- 
Valentin
