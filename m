Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeEDKDU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:03:20 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:14388 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeEDKDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:03:18 -0400
Subject: Re: [PATCH v9 07/27] ARM: davinci: dm355: add new clock init using
 common clock framework
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-8-david@lechnology.com>
 <d9633747-0c50-2934-d3b2-ba745f021077@ti.com>
 <18b7b217-7ccb-d2dd-8f2c-ba3ba0e5d893@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <093052da-08b8-fe68-d319-254ae1da4d0d@ti.com>
Date: Fri, 4 May 2018 15:31:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <18b7b217-7ccb-d2dd-8f2c-ba3ba0e5d893@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 May 2018 09:14 PM, David Lechner wrote:
> On 05/03/2018 10:34 AM, Sekhar Nori wrote:
>> On Friday 27 April 2018 05:47 AM, David Lechner wrote:
>>> This adds the new board-specific clock init in mach-davinci/dm355.c
>>> using the new common clock framework drivers.
>>>
>>> The #ifdefs are needed to prevent compile errors until the entire
>>> ARCH_DAVINCI is converted.
>>>
>>> Also clean up the #includes since we are adding some here.
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>
>> I am having trouble booting DM355 EVM with the series applied.
>> Still to debug what is going wrong.
> 
> Can you dump the PLL registers using /sys/kernel/debug/clk/... ?

I was able to get to ramdisk shell if I set clk_ignore_unused. Here is 
the dump:

root@dm355-evm:/sys/kernel/debug# cat clk/clk_summary 
                                 enable  prepare  protect                               
   clock                          count    count    count        rate   accuracy   phase
----------------------------------------------------------------------------------------
 ref_clk                              1        1        0    24000000          0 0  
    oscin                             3        3        0    24000000          0 0  
       pll2_sysclkbp                  0        0        0     3000000          0 0  
       pll2_prediv                    2        2        0     3000000          0 0  
          pll2_pllout                 1        1        0   342000000          0 0  
             pll2_postdiv             1        1        0   342000000          0 0  
                pll2_pllen            0        0        0   342000000          0 0  
       pll1_sysclkbp                  0        0        0     8000000          0 0  
       pll1_auxclk                    4        5        0    24000000          0 0  
          timer2                      1        4        0    24000000          0 0  
          timer1                      0        0        0    24000000          0 0  
          timer0                      2        2        0    24000000          0 0  
          pwm2                        0        0        0    24000000          0 0  
          pwm1                        0        0        0    24000000          0 0  
          pwm0                        0        0        0    24000000          0 0  
          uart1                       1        4        0    24000000          0 0  
          uart0                       1        4        0    24000000          0 0  
          i2c                         0        3        0    24000000          0 0  
          rto                         0        0        0    24000000          0 0  
          pwm3                        0        0        0    24000000          0 0  
          timer3                      0        0        0    24000000          0 0  
       pll1_prediv                    2        2        0     3000000          0 0  
          pll1_pllout                 1        1        0   432000000          0 0  
             pll1_postdiv             1        1        0   432000000          0 0  
                pll1_pllen            0        0        0   432000000          0 0  
 pll2_sysclk2                         1        1        0           0          0 0  
 pll2_sysclk1                         0        0        0           0          0 0  
 pll1_sysclk4                         1        3        0           0          0 0  
    vpss_slave                        0        1        0           0          0 0  
    vpss_master                       0        1        0           0          0 0  
 pll1_sysclk3                         1        1        0           0          0 0  
    vpss_dac                          0        0        0           0          0 0  
 pll1_sysclk2                         4        5        0           0          0 0  
    gpio                              1        1        0           0          0 0  
    spi0                              0        3        0           0          0 0  
    uart2                             1        4        0           0          0 0  
    asp0                              0        0        0           0          0 0  
    mmcsd0                            0        0        0           0          0 0  
    aemif                             1        1        0           0          0 0  
    spi2                              0        0        0           0          0 0  
    usb                               0        0        0           0          0 0  
    asp1                              0        0        0           0          0 0  
    mmcsd1                            0        0        0           0          0 0  
    spi1                              0        0        0           0          0 0  
 pll1_sysclk1                         2        2        0           0          0 0  
    mjcp                              0        0        0           0          0 0  
    arm                               1        1        0           0          0 0  

and the dump with current master:

root@dm355-evm:/sys/kernel/debug# cat davinci_clocks 
ref_clk           users= 7      24000000 Hz
  pll1            users= 7 pll 432000000 Hz
    pll1_sysclk1  users= 1 pll 216000000 Hz
      arm_clk     users= 1 psc 216000000 Hz
      mjcp        users= 0 psc 216000000 Hz
    pll1_sysclk2  users= 3 pll 108000000 Hz
      uart2       users= 1 psc 108000000 Hz
      asp0        users= 0 psc 108000000 Hz
      asp1        users= 0 psc 108000000 Hz
      mmcsd0      users= 0 psc 108000000 Hz
      mmcsd1      users= 0 psc 108000000 Hz
      spi0        users= 0 psc 108000000 Hz
      spi1        users= 0 psc 108000000 Hz
      spi2        users= 0 psc 108000000 Hz
      gpio        users= 1 psc 108000000 Hz
      aemif       users= 1 psc 108000000 Hz
      usb         users= 0 psc 108000000 Hz
    pll1_sysclk3  users= 0 pll  27000000 Hz
      vpss_dac    users= 0 psc  27000000 Hz
    pll1_sysclk4  users= 0 pll 108000000 Hz
      vpss_master users= 0 psc 108000000 Hz
      vpss_slave  users= 0 psc 108000000 Hz
    pll1_aux_clk  users= 3 pll  24000000 Hz
      clkout1     users= 0      24000000 Hz
      uart0       users= 1 psc  24000000 Hz
      uart1       users= 1 psc  24000000 Hz
      i2c         users= 0 psc  24000000 Hz
      pwm0        users= 0 psc  24000000 Hz
      pwm1        users= 0 psc  24000000 Hz
      pwm2        users= 0 psc  24000000 Hz
      pwm3        users= 0 psc  24000000 Hz
      timer0      users= 1 psc  24000000 Hz
      timer1      users= 0 psc  24000000 Hz
      timer2      users= 1 psc  24000000 Hz
      timer3      users= 0 psc  24000000 Hz
      rto         users= 0 psc  24000000 Hz
    pll1_sysclkbp users= 0 pll   8000000 Hz
      clkout2     users= 0       8000000 Hz
  pll2            users= 0 pll 342000000 Hz
    pll2_sysclk1  users= 0 pll 342000000 Hz
    pll2_sysclkbp users= 0 pll   3000000 Hz
      clkout3     users= 0       3000000 Hz

I didn't have time today to analyze these myself. Hope it helps.

Thanks,
Sekhar
