Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AC7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F91526A79
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVuRVOEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F91526A79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeFZVPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeFZVPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:15:03 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62C8F26A79;
        Tue, 26 Jun 2018 21:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530047702;
        bh=espXtzyLa31t9kWH6RN5tDLQ1KS5Ic3Ws233VJCMTsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iVuRVOEk2zyIYgwBZhzy/0CFuKWkP0r17mMS1d+/GMI4UK9BjVGfqg1NMK8MGZaRu
         g4LqKJxSc0ke9qqzpx6XaN+QhFgCQpMqO2BQOXaf0GrTVzLWuJC5btFsmFqgRuoljW
         8asB0Qcf8tmArdGQ6apAZ4C0t/AUuBP2EjSTYO9Q=
Date:   Tue, 26 Jun 2018 16:15:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: Re: [lkp-robot] [bisect done] ef1433f717 [    7.049860] BUG: unable
 to handle kernel NULL pointer dereference at 0000004c
Message-ID: <20180626211501.GC181504@bhelgaas-glaptop.roam.corp.google.com>
References: <20180626011007.GI11011@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626011007.GI11011@yexl-desktop>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 09:10:07AM +0800, kernel test robot wrote:
> 
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit ef1433f717a2c63747a519d86965d73ff9bd08b3
> Author:     Kishon Vijay Abraham I <kishon@ti.com>
> AuthorDate: Mon Apr 2 18:59:35 2018 +0530
> Commit:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CommitDate: Fri May 18 16:40:50 2018 +0100
> 
>     PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry
>     
>     In order to be able to provide correct driver_data for pci_epf device,
>     a separate configfs entry for each pci_epf_device_id table entry in
>     pci_epf_driver is required.
>     
>     Add support to create configfs entry for each pci_epf_device_id
>     table entry here.
>     
>     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>     Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

From the .config below:

  # CONFIG_PCI_ENDPOINT_CONFIGFS is not set

From include/linux/pci-ep-cfs.h:

  #ifdef CONFIG_PCI_ENDPOINT_CONFIGFS
  ...
  #else
  static inline struct config_group *pci_ep_cfs_add_epf_group(const char *name)
  {
        return 0;
  }

From ef1433f717a2:

  +       id = driver->id_table;
  +       while (id->name[0]) {
  +               group = pci_ep_cfs_add_epf_group(id->name);
  +               mutex_lock(&pci_epf_mutex);
  +               list_add_tail(&group->group_entry, &driver->epf_group);

Obviously group == 0 and the list_add_tail() is a NULL pointer
dereference.

Looks like we need either some sort of #ifdef CONFIG_PCI_ENDPOINT_CONFIGFS
in __pci_epf_register_driver() and pci_epf_unregister_driver(), or
higher-level interfaces and corresponding stubs that add/remove all
the IDs.

Bjorn
