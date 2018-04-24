Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeDXUq1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 16:46:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59170 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDXUqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 16:46:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 193DB6071A
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
From: David Collins <collinsd@codeaurora.org>
Message-ID: <d82ef514-b94f-8ed9-6b1e-e07de2a5f455@codeaurora.org>
Date: Tue, 24 Apr 2018 13:46:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180424174111.GH22073@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2018 10:41 AM, Mark Brown wrote:
> On Fri, Apr 20, 2018 at 12:28:21PM -0700, David Collins wrote:

>> RPMh hardware enforces the requested minimum headroom voltage for all
>> regulators with a parent.  It has full knowledge of the parent-child
>> connections of regulators on the board (as programmed by the bootloader).
>> It automatically reconfigures the parent voltage when needed as a result
>> of requests changing the voltage of any of its child regulators.
> 
> If the hardware has full knowledge of all these constraints and enforces
> them transparently then why does the kernel care that it's doing that?
> Doesn't it defeat the point of it doing all this stuff if we have to
> know about it?

The RPMh hardware is aware of the parent-child connections between
regulators as well as minimum headroom to ensure stable LDO voltage output
for subregulated LDOs.  The intention of having the headroom be a
configurable property for processors is to support usecases in which
subregulated LDO loads are particularly sensitive to noise and require
additional headroom.  Such usecases are board dependent and beyond the
baseline configurations set in RPMh hardware.


>>> Ideally future versions of the RPM will have improved interfaces,
>>> there's a bunch of problems like this :(
> 
>> Do you have a preference for qcom,regulator-initial-microvolt vs a generic
>> framework supported regulator-initial-microvolt property for configuring a
>> specific voltage at registration time?  We'll need to have support for one
>> or the other in order for the qcom_rpmh-regulator driver to be functional.
> 
> This is basically specific to Qualcomm, I can't off hand think of any
> other devices with similar issues.

I will go with qcom,regulator-initial-microvolt then.


>>> Yes, constraints that specify a single voltage are done by setting min
>>> and max to the same value.  fixed_uV is *only* for regulators that have
>>> a physically fixed voltage.
> 
>> XOB managed regulators physically cannot change voltage.  Therefore, do
>> you agree that it is reasonable to use fixed_uV for them?  Note that I
>> removed init_data->constraints.apply_uV manipulation in version 2 of this
>> patch.
> 
> If these regulators can't change voltage then surely we know what
> voltage they have without needing it to be specified in DT?

In the case of XOB managed LDO regulators, the LDOs physically can be
configured to different voltages by the bootloader.  However, the RPMh
interface provides no mechanism for the application processor to read or
change that voltage.  Therefore, we need a way to specify such voltages in
a board specific (as opposed to driver specific) manner (i.e. device tree).

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
