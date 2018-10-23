Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A4C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF86320652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF86320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeJXAvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:51:00 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57062 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbeJXAvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:51:00 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42ff0r3k9Gz1rRDs;
        Tue, 23 Oct 2018 18:26:52 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42ff0r34bfz1qr2r;
        Tue, 23 Oct 2018 18:26:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 3ifOWvpBSAuE; Tue, 23 Oct 2018 18:26:50 +0200 (CEST)
X-Auth-Info: Q3Kw6ftxvg8yJ+l63vhv1j2LTIdg/MzY9Mdc9w8oNsw=
Received: from crub (p508DEB69.dip0.t-ipconnect.de [80.141.235.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 23 Oct 2018 18:26:50 +0200 (CEST)
Date:   Tue, 23 Oct 2018 18:26:49 +0200
From:   Anatolij Gustschin <agust@denx.de>
To:     Andreas Puhm <puhm@oregano.at>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
Message-ID: <20181023182649.047f1f93@crub>
In-Reply-To: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
References: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Mon, 22 Oct 2018 13:15:34 +0000
Andreas Puhm puhm@oregano.at wrote:
...
>Full description:
>The altera_cvp probe function only checks, 
>if the Altera/Intel PCI device configuration space contains a vendor
>specific entry (VSEC Capability Header 0x000b) at offset 0x200.
> But the probe function does not verify, if the PCI device (and further
>the FPGA), for which it has been called, actually supports the Configure-
>via-Protocol feature.
>
>The PCI device (FPGA) can explicitly disable the Configur-via-Protocol
>(CvP) feature by setting the CVP_EN bit, index 20 of CVP_STATUS register,
>to '0'.
>As the altera_cvp probe function does not check this it registers the
>device in any way.

The CvP docs says that on some FPGAs (e.g. Arria 10) the assertion of CVP
status can take up to 500ms. However it is not clear whether this delay
might be required after peripheral image configuration and after PCIe
link activation. The diagram describing configuration sequence suggests
that CVP_EN should be polled until it is asserted. I can imaging the
situation that this bit is still not asserted when the device is being
probed. Maybe we should better defer device probing if CVP_EN bit is
cleared? When deferred probing fails again and sufficient period for
CVP_EN bit assertion elapsed, then stop deferred probing and return
-ENODEV?

Thanks,

Anatolij
