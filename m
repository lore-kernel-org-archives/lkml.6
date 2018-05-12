Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeELSvH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 14:51:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeELSvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 14:51:06 -0400
Subject: Re: drivers/platform/x86/dell-smbios-smm.c:99: undefined reference to
 `dcdbas_smi_request'
To: Darren Hart <dvhart@infradead.org>, kbuild test robot <lkp@intel.com>
Cc: Mario Limonciello <mario.limonciello@dell.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
References: <201805121703.jgrY5zId%fengguang.wu@intel.com>
 <20180512183207.GA5102@fedora>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <97a38f51-31ab-f346-051b-b8bed4eca641@infradead.org>
Date: Sat, 12 May 2018 11:51:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180512183207.GA5102@fedora>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2018 11:32 AM, Darren Hart wrote:
> On Sat, May 12, 2018 at 05:28:05PM +0800, kbuild test robot wrote:
>> Hi Mario,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   f0ab773f5c96c29a5227234c4b5a820f5591b74d
>> commit: 25d47027e1003546bfd8964b4423cb39bc2d53e9 platform/x86: dell-smbios: Link all dell-smbios-* modules together
>> date:   9 weeks ago
>> config: x86_64-randconfig-s5-05121617 (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
>> reproduce:
>>         git checkout 25d47027e1003546bfd8964b4423cb39bc2d53e9
> 
> This failure:
> 
> $ zcat config.gz | grep DCDBAS
> CONFIG_DCDBAS=m            <----------
> 
> $ zcat config.gz | grep SMBIOS
> CONFIG_DELL_SMBIOS=y       <----------
> ddCONFIG_DELL_SMBIOS_WMI=y
> CONFIG_DELL_SMBIOS_SMM=y   <----------
> 
> Is no longer possible as of:
> 
> cc69c88 platform/x86: dell-smbios: Resolve dependency error on DCDBAS
> 
> +#
> +# If the DELL_SMBIOS_SMM feature is enabled, the DELL_SMBIOS driver
> +# becomes dependent on the DCDBAS driver. The "depends" line prevents a
> +# configuration where DELL_SMBIOS=y while DCDBAS=m.
> +#
>  config DELL_SMBIOS
>         tristate "Dell SMBIOS driver"
> +       depends on DCDBAS || DCDBAS=n
> 

and but yet, in linux-4.17-rc4, with this posted config file (after
using:  yes '' |make oldconfig), we can see:

WARNING: unmet direct dependencies detected for DELL_SMBIOS
  Depends on [m]: X86 [=y] && X86_PLATFORM_DEVICES [=y] && (DCDBAS [=m] || DCDBAS [=m]=n) && (ACPI_WMI [=y] || ACPI_WMI [=y]=n)
  Selected by [y]:
  - DELL_WMI [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI_WMI [=y] && DMI [=y] && INPUT [=y] && (ACPI_VIDEO [=y] || ACPI_VIDEO [=y]=n)

CONFIG_DELL_SMBIOS=y
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
# CONFIG_DELL_LAPTOP is not set
CONFIG_DELL_WMI=y
CONFIG_DELL_WMI_DESCRIPTOR=y
CONFIG_ACPI_WMI=y
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=m


I'll stare at it some (more), but no promises.

-- 
~Randy
