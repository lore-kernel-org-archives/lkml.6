Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208E1C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 04:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14042081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 04:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns/sa64d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14042081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeKBOAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 10:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbeKBOAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 10:00:05 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB4722081B;
        Fri,  2 Nov 2018 04:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541134455;
        bh=hseyn7PX8vtDFZexQtRsEksFn+9//cxCWN6Vr09UPaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ns/sa64dAQTE1q38hUwChFjTRMDS0VUa2Abn07o46K2YnNaq98eLJ+G1rsjObRT0r
         0I7QvGhuhG2IPAVj0+gmD1+Pxy0i5YYmGnXaSDv4E/A73clX1AREwEUEcX3onDF/8k
         F2qt3XxRqzN8CLrfKkTGiTv7QnBHrjFkGm1SeYTo=
Date:   Fri, 2 Nov 2018 05:54:13 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression
 caused by incorrect clean-up
Message-ID: <20181102045412.GB11843@kroah.com>
References: <20181018050835.27828-1-kys@linuxonhyperv.com>
 <20181018050932.27932-1-kys@linuxonhyperv.com>
 <20181018050932.27932-3-kys@linuxonhyperv.com>
 <CY4PR21MB077329FE239A11054FFDD661D7F60@CY4PR21MB0773.namprd21.prod.outlook.com>
 <PU1P153MB0169588D48E567E0551D4A9FBFCD0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181101185638.GB10263@kroah.com>
 <PU1P153MB01690D11050FBDACD205EC6EBFCE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB01690D11050FBDACD205EC6EBFCE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 07:22:28PM +0000, Dexuan Cui wrote:
> > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > Sent: Thursday, November 1, 2018 11:57
> > To: Dexuan Cui <decui@microsoft.com>
> > 
> > On Wed, Oct 31, 2018 at 11:23:54PM +0000, Dexuan Cui wrote:
> > > > From: Michael Kelley <mikelley@microsoft.com>
> > > > Sent: Wednesday, October 24, 2018 08:38
> > > > From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>  Sent:
> > Wednesday,
> > > > October 17, 2018 10:10 PM
> > > > > From: Dexuan Cui <decui@microsoft.com>
> > > > >
> > > > > In kvp_send_key(), we do need call process_ib_ipinfo() if
> > > > > message->kvp_hdr.operation is KVP_OP_GET_IP_INFO, because it turns
> > out
> > > > > the userland hv_kvp_daemon needs the info of operation, adapter_id
> > and
> > > > > addr_family. With the incorrect fc62c3b1977d, the host can't get the
> > > > > VM's IP via KVP.
> > > > >
> > > > > And, fc62c3b1977d added a "break;", but actually forgot to initialize
> > > > > the key_size/value in the case of KVP_OP_SET, so the default key_size of
> > > > > 0 is passed to the kvp daemon, and the pool files
> > > > > /var/lib/hyperv/.kvp_pool_* can't be updated.
> > > > >
> > > > > This patch effectively rolls back the previous fc62c3b1977d, and
> > > > > correctly fixes the "this statement may fall through" warnings.
> > > > >
> > > > > This patch is tested on WS 2012 R2 and 2016.
> > > > >
> > > > > Fixes: fc62c3b1977d ("Drivers: hv: kvp: Fix two "this statement may fall
> > > > through" warnings")
> > > > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > > > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > > > > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > > > > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > > > > Cc: <Stable@vger.kernel.org>
> > > > > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > > > > ---
> > > > >  drivers/hv/hv_kvp.c | 26 ++++++++++++++++++++++----
> > > > >  1 file changed, 22 insertions(+), 4 deletions(-)
> > > > >
> > > > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > >
> > > Hi Greg,
> > > Can you please take a look at this patch?
> > 
> > Nope, I'm not the hv maintainer, they need to look at this and ack it,
> > not me :)
> > 
> > greg k-h
> 
> Hi Greg,
> KY has added his Signed-off-by in the mail.
> 
> I'll ask the other HV maintainers to take a look as well.

Ok, then I'll look at it after 4.20-rc1 is out, nothing I can do until
then anyway...

thanks,

greg k-h
