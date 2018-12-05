Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BDDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B08C20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFIpX0NY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B08C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeLEG6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbeLEG6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:58:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46FAA2082B;
        Wed,  5 Dec 2018 06:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543993133;
        bh=AyaT41T+tAKZ1oLE3JU0YEIIcRB8V7bb0UMHGRGjlxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFIpX0NYbPSL43VBlWLfVd7B/dQLeCC6RSSey2bk2sowoItcpURzrWh4O4npVroF7
         U1Ubiz5rs5PHXDrlNic3YsHp3XmEUC0sAWfzGoesF0W+pPnwYtuvKK3Hx8g6QVJUsV
         6VQnycRa2RdnlvqqKLfL9RBh1q2Xk3FrFPoQ+Mjw=
Date:   Wed, 5 Dec 2018 07:58:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net, Yuchung Cheng <ycheng@google.com>,
        Nandita Dukkipati <nanditad@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.19 000/139] 4.19.7-stable review
Message-ID: <20181205065851.GA16346@kroah.com>
References: <20181204103649.950154335@linuxfoundation.org>
 <716b46ef-03da-9656-92fd-3823f31f5ce6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <716b46ef-03da-9656-92fd-3823f31f5ce6@linaro.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 07:09:46PM -0200, Rafael David Tinoco wrote:
> On 12/4/18 8:48 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.7 release.
> > There are 139 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Dec  6 10:36:22 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.7-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> During functional tests for this v4.19 release, we faced a PANIC,
> described bellow, but unlikely related to this specific v4.19 version.
> 
> First a WARN() at tcp_output.c:
> 
> tcp_send_loss_probe():
> ...
> 	/* Retransmit last segment. */
> 	if (WARN_ON(!skb))
> 		goto rearm_timer;
> ...
> 
> [  173.557528] WARNING: CPU: 1 PID: 0 at
> /srv/oe/build/tmp-rpb-glibc/work-shared/juno/kernel-source/net/ipv4/tcp_output.c:2485
> tcp_send_loss_probe+0x164/0x1e8
> [  173.571425] Modules linked in: crc32_ce crct10dif_ce fuse
> [  173.576804] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.7-rc1 #1
> [  173.583014] Hardware name: ARM Juno development board (r2) (DT)

So only this one machine saw this failure?

If you can reproduce it again, bisection would be great to do if
possible.

thanks,

greg k-h
