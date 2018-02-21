Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932548AbeBUJm3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:42:29 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34787 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752983AbeBUJm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:42:27 -0500
X-Google-Smtp-Source: AH8x225rUwrf6MhZGc98YS7qwyVLXNs4q/U9V2NDRb2tOLyqG3ublObqctEohMauN230ECI+JTlV7g==
Subject: Re: [Xen-devel] [PATCH 1/9] drm/xen-front: Introduce Xen
 para-virtualized frontend driver
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-2-git-send-email-andr2000@gmail.com>
 <20180221091751.ebczu3kzv6j7zykp@MacBook-Pro-de-Roger.local>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <8caebdda-47ac-a1d8-73d2-7b889c997a5a@gmail.com>
Date: Wed, 21 Feb 2018 11:42:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221091751.ebczu3kzv6j7zykp@MacBook-Pro-de-Roger.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 11:17 AM, Roger Pau Monné wrote:
> On Wed, Feb 21, 2018 at 10:03:34AM +0200, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Introduce skeleton of the para-virtualized Xen display
>> frontend driver. This patch only adds required
>> essential stubs.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> ---
>>   drivers/gpu/drm/Kconfig             |  2 +
>>   drivers/gpu/drm/Makefile            |  1 +
>>   drivers/gpu/drm/xen/Kconfig         | 17 ++++++++
>>   drivers/gpu/drm/xen/Makefile        |  5 +++
>>   drivers/gpu/drm/xen/xen_drm_front.c | 83 +++++++++++++++++++++++++++++++++++++
>>   5 files changed, 108 insertions(+)
>>   create mode 100644 drivers/gpu/drm/xen/Kconfig
>>   create mode 100644 drivers/gpu/drm/xen/Makefile
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front.c
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index deeefa7a1773..757825ac60df 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -289,6 +289,8 @@ source "drivers/gpu/drm/pl111/Kconfig"
>>   
>>   source "drivers/gpu/drm/tve200/Kconfig"
>>   
>> +source "drivers/gpu/drm/xen/Kconfig"
>> +
>>   # Keep legacy drivers last
>>   
>>   menuconfig DRM_LEGACY
>> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
>> index 50093ff4479b..9d66657ea117 100644
>> --- a/drivers/gpu/drm/Makefile
>> +++ b/drivers/gpu/drm/Makefile
>> @@ -103,3 +103,4 @@ obj-$(CONFIG_DRM_MXSFB)	+= mxsfb/
>>   obj-$(CONFIG_DRM_TINYDRM) += tinydrm/
>>   obj-$(CONFIG_DRM_PL111) += pl111/
>>   obj-$(CONFIG_DRM_TVE200) += tve200/
>> +obj-$(CONFIG_DRM_XEN) += xen/
>> diff --git a/drivers/gpu/drm/xen/Kconfig b/drivers/gpu/drm/xen/Kconfig
>> new file mode 100644
>> index 000000000000..4cca160782ab
>> --- /dev/null
>> +++ b/drivers/gpu/drm/xen/Kconfig
>> @@ -0,0 +1,17 @@
>> +config DRM_XEN
>> +	bool "DRM Support for Xen guest OS"
>> +	depends on XEN
>> +	help
>> +	  Choose this option if you want to enable DRM support
>> +	  for Xen.
>> +
>> +config DRM_XEN_FRONTEND
>> +	tristate "Para-virtualized frontend driver for Xen guest OS"
>> +	depends on DRM_XEN
>> +	depends on DRM
>> +	select DRM_KMS_HELPER
>> +	select VIDEOMODE_HELPERS
>> +	select XEN_XENBUS_FRONTEND
>> +	help
>> +	  Choose this option if you want to enable a para-virtualized
>> +	  frontend DRM/KMS driver for Xen guest OSes.
>> diff --git a/drivers/gpu/drm/xen/Makefile b/drivers/gpu/drm/xen/Makefile
>> new file mode 100644
>> index 000000000000..967074d348f6
>> --- /dev/null
>> +++ b/drivers/gpu/drm/xen/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +drm_xen_front-objs := xen_drm_front.o
>> +
>> +obj-$(CONFIG_DRM_XEN_FRONTEND) += drm_xen_front.o
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
>> new file mode 100644
>> index 000000000000..fd372fb464a1
>> --- /dev/null
>> +++ b/drivers/gpu/drm/xen/xen_drm_front.c
>> @@ -0,0 +1,83 @@
>> +/*
>> + *  Xen para-virtual DRM device
>> + *
>> + *   This program is free software; you can redistribute it and/or modify
>> + *   it under the terms of the GNU General Public License as published by
>> + *   the Free Software Foundation; either version 2 of the License, or
>> + *   (at your option) any later version.
>> + *
>> + *   This program is distributed in the hope that it will be useful,
>> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *   GNU General Public License for more details.
> Most Xen drivers in Linux use a dual GPL/BSD license, so that they can
> be imported into other non GPL OSes:
>
> This program is free software; you can redistribute it and/or
> modify it under the terms of the GNU General Public License version 2
> as published by the Free Software Foundation; or, when distributed
> separately from the Linux kernel or incorporated into other
> software packages, subject to the following license:
>
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this source file (the "Software"), to deal in the Software without
> restriction, including without limitation the rights to use, copy, modify,
> merge, publish, distribute, sublicense, and/or sell copies of the Software,
> and to permit persons to whom the Software is furnished to do so, subject to
> the following conditions:
>
> The above copyright notice and this permission notice shall be included in
> all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> IN THE SOFTWARE.
>
> IMO it would be good to release this driver under the same license, so
> it can be incorporated into other OSes.
I am in any way expert in licensing, but the above seems to be
/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
At least this is what I see at [1] for MIT.
Could you please tell which license(s) as listed at [1]
would be appropriate for Xen drivers in terms of how it is
expected to appear in the kernel code, e.g. expected
SPDX-License-Identifier?
> Thanks, Roger.
Thank you,
Oleksandr

[1] https://spdx.org/licenses/
