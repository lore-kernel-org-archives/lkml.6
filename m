Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758869AbeD0Tee (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:34:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757590AbeD0Ted (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:34:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B512600C9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
To: Bjorn Helgaas <helgaas@kernel.org>,
        Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <b62c2a8e-fe14-6d7d-147c-0ce3b0c0ab2f@codeaurora.org>
Date: Fri, 27 Apr 2018 15:34:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for adding me.

On 4/27/2018 3:22 PM, Bjorn Helgaas wrote:
> Sinan mooted the idea of using a "no-wait" path of sending the "don't
> generate hotplug interrupts" command.  I think we should work on this
> idea a little more.  If we're shutting down the whole system, I can't
> believe there's much value in *anything* we do in the pciehp_remove()
> path.
> 
> Maybe we should just get rid of pciehp_remove() (and probably
> pcie_port_remove_service() and the other service driver remove methods)
> completely.  That dates from when the service drivers could be modules that
> could be potentially unloaded, but unloading them hasn't been possible for
> years.

Shutdown path is also used for kexec. Leaving hotplug interrupts pending is
dangerous for the newly loaded kernel as it leaves spurious interrupts
during the new kernel boot.

I think we should always disable the hotplug interrupt on shutdown. We might
think of not waiting for command-completion as a middle-ground or go to polling
path instead of interrupts all the time.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
