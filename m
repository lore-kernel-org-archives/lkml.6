Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F01C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D9220820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPv5DUjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D9220820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390743AbeKWACd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:02:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729623AbeKWACd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:02:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F919206B2;
        Thu, 22 Nov 2018 13:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542892993;
        bh=wWElmhBGNcg4k0S0jwGc61FcO0Npxo5y14inY/loU1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPv5DUjAwlJESRM/H4dxSa7R4AcZVzC5ON+JkqJT7FBw/ZNkb6gwy0TKnfS90hqos
         8eKiqu4BLT8sFkQ6X+U3CCDC9IlCZjGxR6WYQkyTpYNKNHN4xaGKfMD9ed0op3maua
         1vyr0gXnFoTe3X92FxHC/sWHBiFy0T9Hhj6h+Z5I=
Date:   Thu, 22 Nov 2018 14:23:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/10] staging: erofs: separate into init_once / always
Message-ID: <20181122132311.GB14300@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-8-gaoxiang25@huawei.com>
 <20181122102339.GG3189@kroah.com>
 <66b90226-5d0e-7344-5220-908aa243b014@huawei.com>
 <20181122110500.GC5287@kroah.com>
 <ef49bf11-b937-46b4-1b9a-c068182aa7d9@huawei.com>
 <20181122112645.GA7527@kroah.com>
 <448b2d41-8156-3fe8-a037-29a31771721e@huawei.com>
 <c6ec315b-6f80-911f-3abe-ee056e730fc9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ec315b-6f80-911f-3abe-ee056e730fc9@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 09:01:31PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2018/11/22 20:00, Gao Xiang wrote:
> > Hi Greg,
> > 
> > On 2018/11/22 19:26, Greg Kroah-Hartman wrote:
> >> Don't make people rebuild your code with different options for
> >> debugging.  That will never work in the 'real world' when people start
> >> using the code.  You need to have things enabled for people all the
> >> time, which is why we have dynamic debugging in the kernel now, and not
> >> a zillion different "DRIVER_DEBUG" build options anymore.
> > Actually, current erofs handle differently for beta users (in eng mode)
> > and commercial users.
> > 
> > CONFIG_EROFS_FS_DEBUG is enable for all beta users, after an observed
> > expression is false, we could get the whole memorydump as early as possible.
> > But for commercial users, there are no such observing points to promise
> > the kernel stability and performance.
> > 
> > It has helped us to find several bug, and I cannot find some alternative way
> > to get the the first scene of the accident...
> 
> I'm about to send v2 of this patchset... I need to get your opinion...
> 
> I think for the current erofs development state, I tend to leave such a
> developping switch because the code could be modified frequently,
> many potential bugs could be avoid when this debugging mode is on and
> it will be dropped after erofs becomes more stable...

You have two competing issues here.  You need to have some sort of debug
build that allows you to get feedback from users, and you need to
provide a solid, reliable system for those not wanting to debug
anything.

If you use a kernel build option, then you can do what you are doing
now, just that do not expect for any user that has problems with the
filesystem, they will rebuild the code just to try to help debug it.
That is going to require run-time debugging to be enabled as they will
not usually have built their own kernel/module at all.

For now, keep doing what you are doing, I just started to worry when I
saw the initial BUG_ON() as we had just talked about these at the
Maintainers summit a few weeks ago, and how we need to get rid of them
from the kernel as they are a crutch that we need to solve.

thanks, and sorry for the noise.  Please resend this series again,

greg k-h
