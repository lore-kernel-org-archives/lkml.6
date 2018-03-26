Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeCZIjM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:39:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:15083 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeCZIjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:39:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="41248456"
Message-ID: <1522053544.23017.109.camel@linux.intel.com>
Subject: Re: [PATCH v4 0/5] Support qcom pinctrl protected pins
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org
Date: Mon, 26 Mar 2018 11:39:04 +0300
In-Reply-To: <20180323163453.96495-1-swboyd@chromium.org>
References: <20180323163453.96495-1-swboyd@chromium.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-23 at 09:34 -0700, Stephen Boyd wrote:
> This patchset proposes a solution to describing the
> valid                                                                 
>           
> pins for a pin controller in a generic way so that
> qcom                                                                  
>       
> platforms can expose the pins that are really
> available.                                                            
>                 
>                                                                       
>                                                               
> Typically, this has been done by having drivers and
> firmware                                                              
>           
> descriptions only use pins they know they have access to, and
> that                                                                  
> still works now because we no longer read the pin direction
> at                                                                    
>   
> boot. But there are still some userspace drivers and debugfs
> facilities                                                            
>  
> that don't know what pins are available and attempt to read
> everything                                                            
>   
> they can. On qcom platforms, this may lead to a system hang, which
> isn't                                                            
> very nice behavior, even if root is the only user that can trigger
> it.                                                              
>                                                                       
>                                                               
> The proposal is to describe the valid pins and then not allow things
> to                                                             
> cause problems by using the invalid pins. Obviously, the firmware
> may                                                               
> mess this up, so this is mostly a nice to have feature or a safety
> net                                                              
> so that things don't blow up
> easily.                                                               

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> Changes from v3:
>  * Split out allocation of mask into subroutine
>  * Moved that allocation to kmalloc_array()
>  * Updated qcom driver to simplifiy ACPI logic and fix mem leak
> 
> Changes from v2:
>  * Renamed binding to 'gpio-reserved-ranges'
>  * Reworked gpiolib patch to not use irqdomains
>  * Update qcom driver patch to use new valid_mask field
>                                                                       
>                                                               
> Changes from
> v1:                                                                   
>                                                  
>  * Pushed into gpiolib-of core under irq valid line
> logic                                                                 
>           
>  * Fixed up qcom driver patch to free stuff properly and remove custom
> code                                                         
>  * Dropped export patch as it got picked
> up                                                                    
>                      
>  * Renamed binding to 'reserved-gpio-ranges'   
> 
> 
> Stephen Boyd (5):
>   dt-bindings: gpio: Add a gpio-reserved-ranges property
>   gpiolib: Extract mask allocation into subroutine
>   gpiolib: Change bitmap allocation to kmalloc_array
>   gpiolib: Support 'gpio-reserved-ranges' property
>   pinctrl: qcom: Don't allow protected pins to be requested
> 
>  .../devicetree/bindings/gpio/gpio.txt         |  7 +-
>  drivers/gpio/gpiolib-of.c                     | 24 +++++++
>  drivers/gpio/gpiolib.c                        | 66 +++++++++++++++++-
> -
>  drivers/pinctrl/qcom/pinctrl-msm.c            | 65 +++++++++++++++++-
>  include/linux/gpio/driver.h                   | 16 +++++
>  5 files changed, 167 insertions(+), 11 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
