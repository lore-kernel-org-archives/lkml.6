Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E514C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F75A2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F75A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oregano.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeJYRP7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:15:59 -0400
Received: from mx02.busymouse24.de ([83.246.107.20]:50358 "EHLO
        mx02.busymouse24.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJYRP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 13:15:59 -0400
Received: from maskedhost [127.0.0.1] by mx02.busymouse24.de stage1 with esmtps 
        (Exim MailCleaner) 
        id 1gFbFS-0000tB-8n  
        from <puhm@oregano.at>; Thu, 25 Oct 2018 10:44:10 +0200
Received: from SRV177.busymouse24.de (192.168.100.177) by
 SRV189.busymouse24.de (192.168.100.189) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Thu, 25 Oct 2018 10:44:08 +0200
Received: from SRV177.busymouse24.de ([fe80::f87a:2c8c:90ef:d29a]) by
 SRV177.busymouse24.de ([fe80::f87a:2c8c:90ef:d29a%14]) with mapi id
 15.00.1263.000; Thu, 25 Oct 2018 10:44:08 +0200
From:   Andreas Puhm <puhm@oregano.at>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>
CC:     Anatolij Gustschin <agust@denx.de>, Alan Tull <atull@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
Thread-Topic: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
Thread-Index: AdRqCJx8+DqNmFX1QmK8kME9tbGkZQA09KeAAAcoCvAAHVTngAAbkVcAABXX12k=
Date:   Thu, 25 Oct 2018 08:44:06 +0000
Message-ID: <1540457043890.27497@oregano.at>
References: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
 <20181023182649.047f1f93@crub>
 <3773264cdfcb4c258cc7eebd213302dd@SRV177.busymouse24.de>
 <20181024095135.GA1382@archbook>,<alpine.DEB.2.20.1810241545580.2819@mgerlach-VirtualBox>
In-Reply-To: <alpine.DEB.2.20.1810241545580.2819@mgerlach-VirtualBox>
Accept-Language: de-AT, de-DE, en-US
Content-Language: de-AT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [83.246.107.135]
x-exclaimer-md-config: 1802f3fe-bc94-4301-9dc2-d59a74e6de3a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moritz, Matthew,

>> Hi Anatolij, Andreas,
>>
>> On Tue, Oct 23, 2018 at 06:46:47PM +0000, Andreas Puhm wrote:
>>> Hi Anatolij,
>>>
>>>> The CvP docs says that on some FPGAs (e.g. Arria 10) the assertion of CVP
>>>> status can take up to 500ms. However it is not clear whether this delay
>>>> might be required after peripheral image configuration and after PCIe
>>>> link activation. The diagram describing configuration sequence suggests
>>>> that CVP_EN should be polled until it is asserted. I can imaging the
>>>> situation that this bit is still not asserted when the device is being
>>>> probed. Maybe we should better defer device probing if CVP_EN bit is
>>>> cleared? When deferred probing fails again and sufficient period for
>>>> CVP_EN bit assertion elapsed, then stop deferred probing and return
>>>> -ENODEV?
>>>>
>>>> Thanks,
>>>>
>>>> Anatolij
>>>
>>> Anatolij, thank you for your feedback.
>>>
>>> My rationale behind the patch is as follows:
>>>
>>> The CVP_EN is part of the Hard PCIe IP core configuration,
>>> and therefore, has a defined and static value right from "the start".
>>>
>>> Remark in [1, fig 12]
>>> " For high density devices such as Intel Cyclone 10 GX,
>>> it may be necessary to wait up to 500 ms for the CvP
>>> status register bit assertion."
>>> According to [2] the Cyclone 10 GX devices achieve proper operation
>>> within 100 ms (via the PCIe IP core and CvP).
>>>
>>> I think (and here the documentation is a bit lacking),
>>> that this remark is valid only for other bits of the status register,
>>> e.g., CVP_CONFIG_DONE or USERMODE.
>>> I also think, that the 500 ms delay is calculated from peripheral + core image programming
>>> and that the time for peripheral image programming is far lower than that
>>> (i.e., low enough to allow PCI enumeration).
>>>
>>> But if this actually means that it can take up to 500 ms to program the peripheral image,
>>> than such FPGAs would have different problems.
>>> I.e., missing the deadline for PCI enumeration.
>>> This would need a solution outside of the scope of the
>>> altera_cvp module (e.g., soft-reset to re-start enumeration with a stable system).
>>>
>>> Bottom line:
>>> The CVP_EN should be deemed stable when altera_cvp is called,
>>> if not,
>>> the programming of the Intel/Altera FPGA and PCIe IP core has not been completed in time
>>> for the enumeration of the PCI device. Hence it would be questionable or, more likely, would not
>>> have completed successfully in the first place, i.e., altera_cvp would not have been called.
>>
>> Yeah I think this makes sense. If your config space isn't up on boot you
>> would run into issues. I agree the docs are soemwhat vague here. Maybe Matthew or Alan can shoot
>> an email to their HW folks internally to clarify?
>
>My experience with cvp is with Arria10 and Stratix 10.  The PCIe Hard IP
>gets configured when the IOring gets configured at power on.  The idea is
>that the load of the IOring is very fast, much before the infamous 100ms
>PCIe timeout for link training.  When the Hard IP is configured, the
>CVP_EN is set or cleared according to how it was configured.  Yes, you

So is it correct that the value of CVP_EN can be evaluated by the altera_cvp right in the first call of its probe function
(as would be the case with my proposed patch).

If it is, I will fix the remaining issues with the patch and submit it.

>will run into issues if config space is not up on boot.  The exact nature
>of the issues is dependent on the platform being used.
>
>For the record, if cvp is not being used then the initial full
>configuration of the FPGA can take much longer than just configuring the
>IOring.  In the worst case, if the initial FPGA image in flash is
>corrupted, it can take a while before the failover image gets configured
>into the fpga.  This might be the explanation for the 500 ms for Cyclone
>10 GX devices.  For an Arria10, the flash failover can take much longer
>than even the 500ms, which has been shown to have issues for many platforms.
>
>Thanks,
>Matthew
>
>>
>> Thanks,
>> Moritz
>>

Thanks,
Andreas
