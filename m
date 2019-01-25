Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3319C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9125B218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kXV8zZyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfAYQoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:44:15 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38448 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAYQoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:44:14 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0PGiC9O125814;
        Fri, 25 Jan 2019 10:44:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548434652;
        bh=2xuWbti2TkwBGgOARo7CTytDNC7Lc7rfcuxG70oI0ZY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kXV8zZyuZu0/ewU9J8ilVr1Pd2XGnRBYxSQxKdNXm0NedruQHKmM92i9J+6HJDO90
         nZg1OIA0tAE9zqrhSWcMWL88q4rCdnE/CBVKrrcz3StMkL4BIzqJHEPef8MQmd9Ngd
         kT/9/Zxk+EZlEjguiEc9RTzVXMGD+TwVnUBcWZng=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0PGiCc7121793
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Jan 2019 10:44:12 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 25
 Jan 2019 10:44:12 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 25 Jan 2019 10:44:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0PGiCK4012367;
        Fri, 25 Jan 2019 10:44:12 -0600
Date:   Fri, 25 Jan 2019 10:44:12 -0600
From:   Bin Liu <b-liu@ti.com>
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Fix potential NULL dereference
Message-ID: <20190125164412.GJ18982@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190123175142.12604-1-matwey@sai.msu.ru>
 <CAJs94EaFU+9stV5CW138eLvxnERR9VRaoLDci86gDMRW63LNfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJs94EaFU+9stV5CW138eLvxnERR9VRaoLDci86gDMRW63LNfA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 09:47:02PM +0300, Matwey V. Kornilov wrote:
> By the way, why do we need to store the qh in urb->hcpriv?
> qh can always be accessible through urb->ep->hcpriv
> Wouldn't it be better to drop entire urb->hcpriv usage?

I am not sure why. The code is there since the first commit in a decade
ago. But I tend to agree with you.

In a quick search for urb->hcpriv and urb->ep->hcpriv, based on the
usage in core/hcd.c, it seems to me that urb->hcpriv should not be
changed in each controller driver, but I see both have been used in most
controller drivers. I will leave this to others to educate me.

Regards,
-Bin.
