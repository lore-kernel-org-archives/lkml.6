Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeEQUsq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:48:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54666 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbeEQUso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:48:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7160E609D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
To: Mark Brown <broonie@kernel.org>
Cc: Stephen Boyd <swboyd@chromium.org>, lgirdwood@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, ilina@codeaurora.org
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
 <493c1f5d-df99-ca68-0f90-a7937a696f5d@codeaurora.org>
 <152411734938.46528.9676451637772936597@swboyd.mtv.corp.google.com>
 <20180419120813.GD27188@sirena.org.uk>
 <38f42537-f801-115a-4120-1344a67a0462@codeaurora.org>
 <20180424174111.GH22073@sirena.org.uk>
 <d82ef514-b94f-8ed9-6b1e-e07de2a5f455@codeaurora.org>
 <20180517060948.GI20254@sirena.org.uk>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <6cb2ac52-258c-332b-e912-809d16e14114@codeaurora.org>
Date: Thu, 17 May 2018 13:48:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180517060948.GI20254@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 11:09 PM, Mark Brown wrote:
> On Tue, Apr 24, 2018 at 01:46:21PM -0700, David Collins wrote:
>> The RPMh hardware is aware of the parent-child connections between
>> regulators as well as minimum headroom to ensure stable LDO voltage output
>> for subregulated LDOs.  The intention of having the headroom be a
>> configurable property for processors is to support usecases in which
>> subregulated LDO loads are particularly sensitive to noise and require
>> additional headroom.  Such usecases are board dependent and beyond the
>> baseline configurations set in RPMh hardware.
> 
> So the hardware implementation is some hard coding stuff that doesn't
> really adequately reflect reality?  This seems unfortunate.  However do
> we really need to tell the hardware about the fact that we're adding
> extra headroom - are there actual interactions with non-Linux things
> here?

The RPMh hardware is configured by the boot loader.  The configuration
does reflect reality; however, it cannot handle all configurations at
initialization time.  Specific headroom management typically comes up in
modem usecases for RF supplies that are sensitive to noise.  This feature
allows RPMh masters (application processor, modem processor, etc) to make
requests only for the regulators that they directly care about without
having to worry about power grid parent-child details and setting the
voltage of parent regulators in order to ensure sufficient headroom.

If you really don't like having this feature present in the Linux RPMh
regulator driver, then I'd be ok removing it.  It is not required for
SDM845 which the driver is initially targeting.


>>>> XOB managed regulators physically cannot change voltage.  Therefore, do
>>>> you agree that it is reasonable to use fixed_uV for them?  Note that I
>>>> removed init_data->constraints.apply_uV manipulation in version 2 of this
>>>> patch.
> 
>>> If these regulators can't change voltage then surely we know what
>>> voltage they have without needing it to be specified in DT?
> 
>> In the case of XOB managed LDO regulators, the LDOs physically can be
>> configured to different voltages by the bootloader.  However, the RPMh
>> interface provides no mechanism for the application processor to read or
>> change that voltage.  Therefore, we need a way to specify such voltages in
>> a board specific (as opposed to driver specific) manner (i.e. device tree).
> 
> Is the kernel somehow prevented from varying these voltages?

Yes.  Physically, there exists no RPMh register to read or write the
voltage of LDOs managed via XOB.  Additionally, the kernel running on the
application processor is blocked from configuring the voltage via a direct
SPMI writes by access permissions that crash the system when violated.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
