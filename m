Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeFEJMx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:12:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42182 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751507AbeFEJMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:12:40 -0400
Subject: Re: [PATCH] usb: xhci: remove the code build warning
To: Thierry Reding <thierry.reding@gmail.com>
CC: Greg KH <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <jonathanh@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1528216500-14172-1-git-send-email-gengdongjiu@huawei.com>
 <20180605084019.GA8665@kroah.com>
 <e2b3ea42-ab55-a1b5-567a-1a57a5f45b5c@huawei.com>
 <20180605090606.GA20649@ulmo>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <d0492f83-f835-db95-915f-5f7cab9b64c9@huawei.com>
Date: Tue, 5 Jun 2018 17:12:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180605090606.GA20649@ulmo>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w559CuDN028825

On 2018/6/5 17:06, Thierry Reding wrote:
> On Tue, Jun 05, 2018 at 04:54:17PM +0800, gengdongjiu wrote:
>>
>>
>> On 2018/6/5 16:40, Greg KH wrote:
>>> On Wed, Jun 06, 2018 at 12:35:00AM +0800, Dongjiu Geng wrote:
>>>> Initialize the 'err' variate to remove the build warning,
>>>> the warning is shown as below:
>>>>
>>>> drivers/usb/host/xhci-tegra.c: In function ‘tegra_xusb_mbox_thread’:
>>>> drivers/usb/host/xhci-tegra.c:552:6: warning: ‘err’ may be used uninitialized in this function [-Wuninitialized]
>>>> drivers/usb/host/xhci-tegra.c:482:6: note: ‘err’ was declared here
>>>>
>>>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>>>> ---
>>>
>>> Any hint as to what commit caused this warning to show up?
>>
>> It seems below commit:
>>
>> commit e84fce0f8837496a48d11086829bdbe170358b7a
>> Author: Thierry Reding <treding@nvidia.com>
>> Date:   Thu Feb 11 18:10:48 2016 +0100
>>
>>     usb: xhci: Add NVIDIA Tegra XUSB controller driver
>>
>>     Add support for the on-chip XUSB controller present on Tegra SoCs. This
>>     controller, when loaded with external firmware, exposes an interface
>>     compliant with xHCI. This driver loads the firmware, starts the
>>     controller, and is able to service host-specific messages sent by the
>>     controller's firmware.
>>
>>     The controller also supports USB device mode as well as powergating
>>     of the SuperSpeed and host-controller logic when not in use, but
>>     support for these is not yet implemented.
>>
>>     Based on work by:
>>       Ajay Gupta <ajayg@nvidia.com>
>>       Bharath Yadav <byadav@nvidia.com>
>>       Andrew Bresticker <abrestic@chromium.org>
>>
>>     Cc: Mathias Nyman <mathias.nyman@intel.com>
>>     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>     Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>     Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> I've never seen this warning before. It's also a false positive in that
> technically the mailbox message will always have at least one bit set in
> "mask". However, I don't see how the compiler could know about it, given
> that the data comes from an external source, so I think this makes sense
> as a hint to the compiler. So:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> Can you provide more detail on what exact version of which compiler you
> used that triggered this? I wonder why it's never presented itself with
> the compiler that I use.

Below is the detailed version of compiler that I used.

$ sudo lsb_release -a
Distributor ID: Ubuntu
Description:    Ubuntu 14.04.5 LTS
Release:        14.04
Codename:       trusty

$ arm-linux-gnueabi-gcc -v
Using built-in specs.
COLLECT_GCC=arm-linux-gnueabi-gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc-cross/arm-linux-gnueabi/4.7/lto-wrapper
Target: arm-linux-gnueabi
Configured with: ../src/configure -v --with-pkgversion='Ubuntu/Linaro 4.7.3-12ubuntu1' --with-bugurl=file:///usr/share/doc/gcc-4.7/README.Bugs --enable-languages=c,c++,go,fortran,objc,obj-c++ --prefix=/usr --program-suffix=-4.7 --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --with-gxx-include-dir=/usr/arm-linux-gnueabi/include/c++/4.7.3 --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-gnu-unique-object --disable-libmudflap --disable-libitm --enable-plugin --with-system-zlib --enable-objc-gc --with-cloog --enable-cloog-backend=ppl --disable-cloog-version-check --disable-ppl-version-check --enable-multiarch --enable-multilib --disable-sjlj-exceptions --with-arch=armv5t --with-float=soft --disable-werror --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=arm-linux-gnueabi --program-prefix=arm-linux-gnueabi- --includedir=/usr/arm-linux-gnueabi/include
Thread model: posix
gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1)

> 
> Thierry
> 
