Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbeC3PYa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 11:24:30 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35840 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbeC3PY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 11:24:29 -0400
X-Google-Smtp-Source: AIpwx49NAixyXC4TwVaTiWSgHfo2s1pOdGSWeNbZ5d0taa67+2sW+6cijXpQrjc+VJU0Ku6kJoXA3A==
Subject: Re: [PATCH V7 00/13] drivers: Boot Constraint core
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
        s.hauer@pengutronix.de, l.stach@pengutronix.de, shawnguo@kernel.org,
        fabio.estevam@nxp.com, nm@ti.com, xuwei5@hisilicon.com,
        robh+dt@kernel.org, olof@lixom.net
References: <cover.1519380923.git.viresh.kumar@linaro.org>
 <20180322012606.vuaemu3pvpeojtwr@vireshk-mac-ubuntu>
 <20180323150420.GA21152@kroah.com>
From: Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cbcfeb15-d940-f066-739d-25adfe09f019@linaro.org>
Date: Fri, 30 Mar 2018 18:24:25 +0300
MIME-Version: 1.0
In-Reply-To: <20180323150420.GA21152@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Viresh,

On 03/23/2018 05:04 PM, Greg Kroah-Hartman wrote:
> On Thu, Mar 22, 2018 at 09:26:06AM +0800, Viresh Kumar wrote:
>> On 23-02-18, 15:53, Viresh Kumar wrote:
>>> Problem statement:
>>>
>>> Some devices are powered ON by the bootloader before the bootloader
>>> handovers control to Linux. It maybe important for some of those devices
>>> to keep working until the time a Linux device driver probes the device
>>> and reconfigure its resources.
>>>
>>> A typical example of that can be the LCD controller, which is used by
>>> the bootloaders to show image(s) while the platform is booting into
>>> Linux.  The LCD controller can be using some resources, like clk,
>>> regulators, etc, that are shared between several devices. These shared
>>> resources should be configured to satisfy need of all the users.  If
>>> another device's (X) driver gets probed before the LCD controller driver
>>> in this case, then it may end up disabling or reconfiguring these
>>> resources to ranges satisfying the current users (only device X) and
>>> that can make the LCD screen unstable.
>>>
>>> Another case can be a debug serial port enabled from the bootloader.
>>>
>>> Of course we can have more complex cases where the same resource is
>>> getting used by two devices while the kernel boots and the order in
>>> which devices get probed wouldn't matter as the other device will surely
>>> break then.
>>
>> And we have a _real_ use case for this complex scenario as well.
>>
>> Georgi (cc'd) is currently working[1] on implementing generic support for the
>> interconnect bus, which tries to play with the bandwidth of the bus based on how
>> much are the requirements from different parts of the SoC. The 4th version was
>> posted recently by him, and things are looking good/positive.
>>
>> The bootloader configures the interconnect to provide sufficient bandwidth for
>> all the devices which are used during boot, few of them are the CPUs, serial and
>> the LCD controller. As the kernel starts taking control of things, the drivers
>> being probed start putting their requirements on the interconnect bus.  Because
>> the interconnect doesn't have any representation from the devices which are not
>> yet initialized by the kernel, the interconnect core incorrectly reduces the
>> bandwidth of the bus to a level unacceptable to the devices running currently,
>> like the CPUs and this makes kernel boot awfully slow. This is not an ordering
>> problem as no matter which device we probe first, we are going to break
>> something else.

The interconnect core takes requests from consumer drivers for their
bandwidth needs and configures the hardware to keep the lowest possible
power profile. I think that the boot constraint patches would be useful
to make a board run at maximum performance during boot, until all
consumer drivers are probed and all bandwidth requests are taken into
account.

>> Georgi already tried using the boot constraint patches to solve this complex
>> problem, and its a perfect fit.

These patches solve a common problem for different subsystems, so it
makes sense to handle it into the driver core, instead of leaving each
subsystem to do their own hacks.

> I'm delaying this as I still don't see that "perfect fit" yet.  If there
> are add-on patches that take better advantage of this, great, let's see
> those, but right now, it feels like you are the only one wanting this.
> And the increased complexity overall seems not really worth it yet :(

The interconnect code is still under review, but on the next submission
i will include a patch to make use of the boot constraints, so that we
hopefully move this forward.

Thanks,
Georgi
