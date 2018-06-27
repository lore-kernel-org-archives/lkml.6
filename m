Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F15CC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E23826323
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E23826323
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753620AbeF0KZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:25:11 -0400
Received: from foss.arm.com ([217.140.101.70]:57820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752565AbeF0KZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:25:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 970BE7A9;
        Wed, 27 Jun 2018 03:25:09 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E77123F5C0;
        Wed, 27 Jun 2018 03:25:07 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:26:42 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     kernel test robot <lkp@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: Re: [lkp-robot] [bisect done] ef1433f717 [    7.049860] BUG: unable
 to handle kernel NULL pointer dereference at 0000004c
Message-ID: <20180627102620.GA7893@red-moon>
References: <20180626011007.GI11011@yexl-desktop>
 <20180626211501.GC181504@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626211501.GC181504@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 04:15:01PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 26, 2018 at 09:10:07AM +0800, kernel test robot wrote:
> > 
> > Greetings,
> > 
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > 
> > commit ef1433f717a2c63747a519d86965d73ff9bd08b3
> > Author:     Kishon Vijay Abraham I <kishon@ti.com>
> > AuthorDate: Mon Apr 2 18:59:35 2018 +0530
> > Commit:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > CommitDate: Fri May 18 16:40:50 2018 +0100
> > 
> >     PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry
> >     
> >     In order to be able to provide correct driver_data for pci_epf device,
> >     a separate configfs entry for each pci_epf_device_id table entry in
> >     pci_epf_driver is required.
> >     
> >     Add support to create configfs entry for each pci_epf_device_id
> >     table entry here.
> >     
> >     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >     Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> 
> From the .config below:
> 
>   # CONFIG_PCI_ENDPOINT_CONFIGFS is not set
> 
> From include/linux/pci-ep-cfs.h:
> 
>   #ifdef CONFIG_PCI_ENDPOINT_CONFIGFS
>   ...
>   #else
>   static inline struct config_group *pci_ep_cfs_add_epf_group(const char *name)
>   {
>         return 0;
>   }
> 
> From ef1433f717a2:
> 
>   +       id = driver->id_table;
>   +       while (id->name[0]) {
>   +               group = pci_ep_cfs_add_epf_group(id->name);
>   +               mutex_lock(&pci_epf_mutex);
>   +               list_add_tail(&group->group_entry, &driver->epf_group);
> 
> Obviously group == 0 and the list_add_tail() is a NULL pointer
> dereference.
> 
> Looks like we need either some sort of #ifdef CONFIG_PCI_ENDPOINT_CONFIGFS
> in __pci_epf_register_driver() and pci_epf_unregister_driver(), or
> higher-level interfaces and corresponding stubs that add/remove all
> the IDs.

Yes, probably augment pci_ep_cfs_add_epf_group() to take a driver
pointer so that adding a group is a NOP on !CONFIG_PCI_ENDPOINT_CONFIGFS.

Kishon can you please post a fix as soon as you can, thanks.

Lorenzo
