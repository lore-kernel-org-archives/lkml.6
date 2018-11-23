Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230F5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3D320820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UoHhiKj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3D320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409897AbeKWX2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:28:12 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:37834 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbeKWX2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:28:12 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D97AA10C0ACD;
        Fri, 23 Nov 2018 04:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542977048; bh=pupJ+vnq4yUPjyM9FBKT0G/5a1ZBnXLPypvUbXJpcik=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=UoHhiKj7ujqI86b9Dah0Kxty/HmovfxnGmj8SSaENcvgNgCVQzJ1x5ui54USGNFbc
         NCSy+lR4GFPQE8ut7DLghnw4+ARMcWM49FUIsUF+49BO/XnxnsU2USj0NJSTR+5y18
         up4/OfNncYtxZB21Z6peT0atzD9c5ptQm52vaAYRVWSOH9aadfHeuBXS5wM2uKLvnM
         RL5QWBWbRjTRKNmX1ZAwnoSnQYv5EdGu+ai92hM4d0TyF6vpNPNLuyJ7FMvwBrrDCP
         WuDWUPXv3Si6MDePmnpKtjATlyUCNWJigkkJZLRuY0gUO1On1Slt802P2vddWyNC9E
         D98MRdoUj1xhw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 534CB3CF9;
        Fri, 23 Nov 2018 04:44:08 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 23 Nov 2018 04:44:08 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 23 Nov 2018 13:44:06 +0100
Received: from [10.0.2.15] (10.107.19.33) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 23 Nov
 2018 13:44:05 +0100
Subject: Re: [PATCH] net: stmmac: Move debugfs init/exit to
 ->probe()/->remove()
To:     Thierry Reding <thierry.reding@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20181123122122.18957-1-thierry.reding@gmail.com>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <jose.abreu@synopsys.com>, <netdev@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <9c8443aa-edaa-2398-bdd8-df49f2529cb6@synopsys.com>
Date:   Fri, 23 Nov 2018 12:44:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20181123122122.18957-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.33]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-2018 12:21, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Setting up and tearing down debugfs is current unbalanced, as seen by
> this error during resume from suspend:
>
>     [  752.134067] dwc-eth-dwmac 2490000.ethernet eth0: ERROR failed to create debugfs directory
>     [  752.134347] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: failed debugFS registration
>
> The imbalance happens because the driver creates the debugfs hierarchy
> when the device is opened and tears it down when the device is closed.
> There's little gain in that, and it could be argued that it is even
> surprising because it's not usually done for other devices. Fix the
> imbalance by moving the debugfs creation and teardown to the driver's
> ->probe() and ->remove() implementations instead.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>

Did you test trying to dump "descriptors_status" file when
interface is not open ? I think that's the main reason why this
is not in probe ...

Thanks and Best Regards,
Jose Miguel Abreu
