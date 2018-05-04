Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeEDUPK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 16:15:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeEDUPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 16:15:09 -0400
Date: Fri, 4 May 2018 22:15:04 +0200
From: Darren Hart <dvhart@infradead.org>
To: Mario.Limonciello@dell.com
Cc: lkp@intel.com, kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/platform/x86/dell-smbios-smm.c:99: undefined reference
 to `dcdbas_smi_request'
Message-ID: <20180504201504.GA95465@localhost.localdomain>
References: <201805050216.HVwTWQoD%fengguang.wu@intel.com>
 <66cb778b7f9844eda89d2eec11158acc@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66cb778b7f9844eda89d2eec11158acc@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 06:27:00PM +0000, Mario.Limonciello@dell.com wrote:
> Darren,
> 
> Is this with that fix of mine merged?  

No, your patch is in for-next. I can now move it to fixes and on to Linus this
weekend. Sorry for the delay, in part due to travel this week.

--
Darren

> 
> > -----Original Message-----
> > From: kbuild test robot [mailto:lkp@intel.com]
> > Sent: Friday, May 4, 2018 1:24 PM
> > To: Limonciello, Mario
> > Cc: kbuild-all@01.org; linux-kernel@vger.kernel.org; Darren Hart (VMware)
> > Subject: drivers/platform/x86/dell-smbios-smm.c:99: undefined reference to
> > `dcdbas_smi_request'
> > 
> > Hi Mario,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   625e2001e99e82ea3eb5b0370a428a4328b9166b
> > commit: 25d47027e1003546bfd8964b4423cb39bc2d53e9 platform/x86: dell-
> > smbios: Link all dell-smbios-* modules together
> > date:   8 weeks ago
> > config: x86_64-randconfig-s1-05050043 (attached as .config)
> > compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> > reproduce:
> >         git checkout 25d47027e1003546bfd8964b4423cb39bc2d53e9
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/platform/x86/dell-smbios-smm.o: In function `dell_smbios_smm_call':
> > >> drivers/platform/x86/dell-smbios-smm.c:99: undefined reference to
> > `dcdbas_smi_request'
> > 
> > vim +99 drivers/platform/x86/dell-smbios-smm.c
> > 
> > 549b4930 Mario Limonciello 2017-11-01   84
> > 549b4930 Mario Limonciello 2017-11-01   85  int dell_smbios_smm_call(struct
> > calling_interface_buffer *input)
> > 549b4930 Mario Limonciello 2017-11-01   86  {
> > 549b4930 Mario Limonciello 2017-11-01   87  	struct smi_cmd command;
> > 549b4930 Mario Limonciello 2017-11-01   88  	size_t size;
> > 549b4930 Mario Limonciello 2017-11-01   89
> > 549b4930 Mario Limonciello 2017-11-01   90  	size = sizeof(struct
> > calling_interface_buffer);
> > 549b4930 Mario Limonciello 2017-11-01   91  	command.magic =
> > SMI_CMD_MAGIC;
> > 549b4930 Mario Limonciello 2017-11-01   92  	command.command_address =
> > da_command_address;
> > 549b4930 Mario Limonciello 2017-11-01   93  	command.command_code =
> > da_command_code;
> > 549b4930 Mario Limonciello 2017-11-01   94  	command.ebx =
> > virt_to_phys(buffer);
> > 549b4930 Mario Limonciello 2017-11-01   95  	command.ecx = 0x42534931;
> > 549b4930 Mario Limonciello 2017-11-01   96
> > 549b4930 Mario Limonciello 2017-11-01   97  	mutex_lock(&smm_mutex);
> > 549b4930 Mario Limonciello 2017-11-01   98  	memcpy(buffer, input, size);
> > 549b4930 Mario Limonciello 2017-11-01  @99  	dcdbas_smi_request(&command);
> > 549b4930 Mario Limonciello 2017-11-01  100  	memcpy(input, buffer, size);
> > 549b4930 Mario Limonciello 2017-11-01  101  	mutex_unlock(&smm_mutex);
> > 549b4930 Mario Limonciello 2017-11-01  102  	return 0;
> > 549b4930 Mario Limonciello 2017-11-01  103  }
> > 549b4930 Mario Limonciello 2017-11-01  104
> > 
> > :::::: The code at line 99 was first introduced by commit
> > :::::: 549b4930f057658dc50d8010e66219233119a4d8 platform/x86: dell-smbios:
> > Introduce dispatcher for SMM calls
> > 
> > :::::: TO: Mario Limonciello <mario.limonciello@dell.com>
> > :::::: CC: Darren Hart (VMware) <dvhart@infradead.org>
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

-- 
Darren Hart
VMware Open Source Technology Center
