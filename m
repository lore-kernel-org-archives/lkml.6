Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F0ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147CD2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147CD2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeJYHbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:31:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:11273 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeJYHbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:31:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 16:00:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="81356468"
Received: from mgerlach-mobl.amr.corp.intel.com (HELO [10.0.2.15]) ([10.251.134.207])
  by fmsmga008.fm.intel.com with ESMTP; 24 Oct 2018 16:00:56 -0700
Date:   Wed, 24 Oct 2018 16:00:56 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@mgerlach-VirtualBox
To:     Moritz Fischer <mdf@kernel.org>
cc:     Andreas Puhm <puhm@oregano.at>, Anatolij Gustschin <agust@denx.de>,
        Alan Tull <atull@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
In-Reply-To: <20181024095135.GA1382@archbook>
Message-ID: <alpine.DEB.2.20.1810241545580.2819@mgerlach-VirtualBox>
References: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de> <20181023182649.047f1f93@crub> <3773264cdfcb4c258cc7eebd213302dd@SRV177.busymouse24.de> <20181024095135.GA1382@archbook>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Oct 2018, Moritz Fischer wrote:

> Hi Anatolij, Andreas,
>
> On Tue, Oct 23, 2018 at 06:46:47PM +0000, Andreas Puhm wrote:
>> Hi Anatolij,
>>
>>> The CvP docs says that on some FPGAs (e.g. Arria 10) the assertion of CVP
>>> status can take up to 500ms. However it is not clear whether this delay
>>> might be required after peripheral image configuration and after PCIe
>>> link activation. The diagram describing configuration sequence suggests
>>> that CVP_EN should be polled until it is asserted. I can imaging the
>>> situation that this bit is still not asserted when the device is being
>>> probed. Maybe we should better defer device probing if CVP_EN bit is
>>> cleared? When deferred probing fails again and sufficient period for
>>> CVP_EN bit assertion elapsed, then stop deferred probing and return
>>> -ENODEV?
>>>
>>> Thanks,
>>>
>>> Anatolij
>>
>> Anatolij, thank you for your feedback.
>>
>> My rationale behind the patch is as follows:
>>
>> The CVP_EN is part of the Hard PCIe IP core configuration,
>> and therefore, has a defined and static value right from "the start".
>>
>> Remark in [1, fig 12]
>> " For high density devices such as Intel Cyclone 10 GX,
>> it may be necessary to wait up to 500 ms for the CvP
>> status register bit assertion."
>> According to [2] the Cyclone 10 GX devices achieve proper operation
>> within 100 ms (via the PCIe IP core and CvP).
>>
>> I think (and here the documentation is a bit lacking),
>> that this remark is valid only for other bits of the status register,
>> e.g., CVP_CONFIG_DONE or USERMODE.
>> I also think, that the 500 ms delay is calculated from peripheral + core image programming
>> and that the time for peripheral image programming is far lower than that
>> (i.e., low enough to allow PCI enumeration).
>>
>> But if this actually means that it can take up to 500 ms to program the peripheral image,
>> than such FPGAs would have different problems.
>> I.e., missing the deadline for PCI enumeration.
>> This would need a solution outside of the scope of the
>> altera_cvp module (e.g., soft-reset to re-start enumeration with a stable system).
>>
>> Bottom line:
>> The CVP_EN should be deemed stable when altera_cvp is called,
>> if not,
>> the programming of the Intel/Altera FPGA and PCIe IP core has not been completed in time
>> for the enumeration of the PCI device. Hence it would be questionable or, more likely, would not
>> have completed successfully in the first place, i.e., altera_cvp would not have been called.
>
> Yeah I think this makes sense. If your config space isn't up on boot you
> would run into issues. I agree the docs are soemwhat vague here. Maybe Matthew or Alan can shoot
> an email to their HW folks internally to clarify?

My experience with cvp is with Arria10 and Stratix 10.  The PCIe Hard IP 
gets configured when the IOring gets configured at power on.  The idea is 
that the load of the IOring is very fast, much before the infamous 100ms
PCIe timeout for link training.  When the Hard IP is configured, the 
CVP_EN is set or cleared according to how it was configured.  Yes, you 
will run into issues if config space is not up on boot.  The exact nature 
of the issues is dependent on the platform being used.

For the record, if cvp is not being used then the initial full 
configuration of the FPGA can take much longer than just configuring the 
IOring.  In the worst case, if the initial FPGA image in flash is 
corrupted, it can take a while before the failover image gets configured 
into the fpga.  This might be the explanation for the 500 ms for Cyclone 
10 GX devices.  For an Arria10, the flash failover can take much longer 
than even the 500ms, which has been shown to have issues for many platforms.

Thanks,
Matthew

>
> Thanks,
> Moritz
>
