Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F16FECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0109920853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0109920853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=CARNet.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeINREG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:04:06 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:58304 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbeINREG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:04:06 -0400
Received: from [2001:b68:ff:12::131] (port=58872 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1g0mbf-0008Mx-C4; Fri, 14 Sep 2018 13:49:52 +0200
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id 3AD92204FE; Fri, 14 Sep 2018 13:49:51 +0200 (CEST)
Date:   Fri, 14 Sep 2018 13:49:51 +0200
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     drbd-user@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180914114951.GH2153@gavran.carpriv.carnet.hr>
References: <20180907121348.GM26705@gavran.carpriv.carnet.hr>
 <20180907132828.GC11834@soda.linbit>
 <20180907164500.GN26705@gavran.carpriv.carnet.hr>
 <20180907171459.GO26705@gavran.carpriv.carnet.hr>
 <20180908073432.GP26705@gavran.carpriv.carnet.hr>
 <20180910124531.GA31737@soda.linbit>
 <20180910132252.GE26705@gavran.carpriv.carnet.hr>
 <20180910150058.suxehc3uheyho4qx@mac.bytemobile.com>
 <20180910161831.GG26705@gavran.carpriv.carnet.hr>
 <20180913150800.haswzd7t2xccbgvl@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180913150800.haswzd7t2xccbgvl@mac.bytemobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 05:08:00PM +0200, Roger Pau Monné wrote:
> So I have the following patch which I think might solve your issues
> while keeping the reset logic working. Would you mind giving it a try
> with your use case and pvgrub?

Thanks for the patch.  It seems to be having some problems with pvgrub:
machines don't boot past pvgrub and they are using 100% CPU.  Also in
dom0 xenstored is usind 100% CPU - strace reports it is looping in this:

read(26, "\\\240\0\0", 4)               = 4
read(26, "\0\0\0\0L\0\0\0)\0\0\0\35\0\0\0+\\\232`\231\31\1&", 24) = 24
read(26, "/local/domain/0/backend/vbd/1/51712/state", 41) = 41
read(26, "\2\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\1\0\0\0004", 29) = 29
read(26, "\0\330\0\0", 4)               = 4
read(26, "\0\0\0\0L\0\0\0)\0\0\0\35\0\0\0+\\JG\231\31\1&", 24) = 24
read(26, "/local/domain/0/backend/vbd/2/51712/state", 41) = 41
read(26, "\2\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0\0\0\1\0\0\0004", 29) = 29
read(26, "\0\200\1\0", 4)               = 4
read(26, "\0\0\0\0L\0\0\0)\0\0\0\35\0\0\0+\\Z\373\231\31\1&", 24) = 24
read(26, "/local/domain/0/backend/vbd/5/51712/state", 41) = 41
read(26, "\2\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\5\0\0\0\1\0\0\0004", 29) = 29
read(12, "\321\1\0\0", 4)               = 4
write(12, "\321\1\0\0", 4)              = 4

-- 
Valentin
