Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835E9C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAB320665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAB320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oregano.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbeJXDL2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:11:28 -0400
Received: from mx01.busymouse24.de ([83.246.107.19]:49084 "EHLO
        mx01.busymouse24.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbeJXDL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:11:28 -0400
Received: from maskedhost [127.0.0.1] by mx01.busymouse24.de stage1 with esmtps 
        (Exim MailCleaner) 
        id 1gF1ha-000B8Z-4G  
        from <puhm@oregano.at>; Tue, 23 Oct 2018 20:46:50 +0200
Received: from SRV177.busymouse24.de (192.168.100.177) by
 SRV177.busymouse24.de (192.168.100.177) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Tue, 23 Oct 2018 20:46:49 +0200
Received: from SRV177.busymouse24.de ([fe80::f87a:2c8c:90ef:d29a]) by
 SRV177.busymouse24.de ([fe80::f87a:2c8c:90ef:d29a%14]) with mapi id
 15.00.1263.000; Tue, 23 Oct 2018 20:46:49 +0200
From:   Andreas Puhm <puhm@oregano.at>
To:     Anatolij Gustschin <agust@denx.de>
CC:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
Thread-Topic: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
Thread-Index: AdRqCJx8+DqNmFX1QmK8kME9tbGkZQA09KeAAAcoCvA=
Date:   Tue, 23 Oct 2018 18:46:47 +0000
Message-ID: <3773264cdfcb4c258cc7eebd213302dd@SRV177.busymouse24.de>
References: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
 <20181023182649.047f1f93@crub>
In-Reply-To: <20181023182649.047f1f93@crub>
Accept-Language: de-AT, de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [83.246.107.135]
x-exclaimer-md-config: 1802f3fe-bc94-4301-9dc2-d59a74e6de3a
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anatolij,

> Von: Anatolij Gustschin [mailto:agust@denx.de]
> Gesendet: Dienstag, 23. Oktober 2018 18:27
> An: Andreas Puhm <puhm@oregano.at>
> Cc: Moritz Fischer <mdf@kernel.org>; Alan Tull <atull@kernel.org>; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
> Betreff: Re: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled devices
> 
> Hi Andreas,
> 
> On Mon, 22 Oct 2018 13:15:34 +0000
> Andreas Puhm puhm@oregano.at wrote:
> ...
> >Full description:
> >The altera_cvp probe function only checks,
> >if the Altera/Intel PCI device configuration space contains a vendor
> >specific entry (VSEC Capability Header 0x000b) at offset 0x200.
> > But the probe function does not verify, if the PCI device (and further
> >the FPGA), for which it has been called, actually supports the Configure-
> >via-Protocol feature.
> >
> >The PCI device (FPGA) can explicitly disable the Configur-via-Protocol
> >(CvP) feature by setting the CVP_EN bit, index 20 of CVP_STATUS register,
> >to '0'.
> >As the altera_cvp probe function does not check this it registers the
> >device in any way.
> 
> The CvP docs says that on some FPGAs (e.g. Arria 10) the assertion of CVP
> status can take up to 500ms. However it is not clear whether this delay
> might be required after peripheral image configuration and after PCIe
> link activation. The diagram describing configuration sequence suggests
> that CVP_EN should be polled until it is asserted. I can imaging the
> situation that this bit is still not asserted when the device is being
> probed. Maybe we should better defer device probing if CVP_EN bit is
> cleared? When deferred probing fails again and sufficient period for
> CVP_EN bit assertion elapsed, then stop deferred probing and return
> -ENODEV?
> 
> Thanks,
> 
> Anatolij

Anatolij, thank you for your feedback.

My rationale behind the patch is as follows:

The CVP_EN is part of the Hard PCIe IP core configuration,
and therefore, has a defined and static value right from "the start".

Remark in [1, fig 12]
" For high density devices such as Intel Cyclone 10 GX, 
it may be necessary to wait up to 500 ms for the CvP
status register bit assertion."
According to [2] the Cyclone 10 GX devices achieve proper operation
within 100 ms (via the PCIe IP core and CvP).

I think (and here the documentation is a bit lacking), 
that this remark is valid only for other bits of the status register,
e.g., CVP_CONFIG_DONE or USERMODE.
I also think, that the 500 ms delay is calculated from peripheral + core image programming
and that the time for peripheral image programming is far lower than that 
(i.e., low enough to allow PCI enumeration).

But if this actually means that it can take up to 500 ms to program the peripheral image, 
than such FPGAs would have different problems.
I.e., missing the deadline for PCI enumeration. 
This would need a solution outside of the scope of the
altera_cvp module (e.g., soft-reset to re-start enumeration with a stable system).

Bottom line: 
The CVP_EN should be deemed stable when altera_cvp is called, 
if not, 
the programming of the Intel/Altera FPGA and PCIe IP core has not been completed in time
for the enumeration of the PCI device. Hence it would be questionable or, more likely, would not
have completed successfully in the first place, i.e., altera_cvp would not have been called.

[1] "Intel(r) Cyclone(r) 10 GX CvP Initialization over PCI Express User Guide", 2018.01.02
[2] "Intel(r) Cyclone(r) 10 GX Device Overview", 2017.05.08

With best regards,
Andreas
