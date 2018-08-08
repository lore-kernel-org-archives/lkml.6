Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A9FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3237121A53
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj/71jYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3237121A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbeHHW3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbeHHW3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:29:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2650D21797;
        Wed,  8 Aug 2018 20:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533758869;
        bh=OnMd1yex4jooJ9vdzdtNK8NwVZm164OKiUbG5AiE4F4=;
        h=Date:From:To:Cc:Subject:From;
        b=Nj/71jYuUFy9qDMtmNKaJH6Ls1GPoNF55eNM36VtOiBYw1fzhMntMiAOTXUM7PZFY
         lco5jjmflQoMUREv+9gGW7J4KH1lyeMzXtYdirLjVGCmEXZk8HARSMUaCv2NNbPk2Y
         yqnS0kLilLxEUrprUwgWL+ktNe5vdL1lNCqzBzeE=
Date:   Wed, 8 Aug 2018 15:07:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Tony Luck <tony.luck@intel.com>
Subject: sb_edac.c lacks PCI domain support?
Message-ID: <20180808200747.GA219159@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think sb_edac.c (and probably other EDAC stuff) lacks PCI domain
support.  I notice messages like this:

  [   14.370256] pci 0000:ff:13.5: [8086:6fad] type 00 class 0x088000
  [   14.980481] pci 0000:bf:13.5: [8086:6fad] type 00 class 0x088000
  [   15.590646] pci 0000:7f:13.5: [8086:6fad] type 00 class 0x088000
  [   16.200498] pci 0000:3f:13.5: [8086:6fad] type 00 class 0x088000
  [   17.928243] pci 0001:ff:13.5: [8086:6fad] type 00 class 0x088000
  [   18.538876] pci 0001:bf:13.5: [8086:6fad] type 00 class 0x088000
  [   19.149211] pci 0001:7f:13.5: [8086:6fad] type 00 class 0x088000
  [   19.759431] pci 0001:3f:13.5: [8086:6fad] type 00 class 0x088000
  ...
  [   54.298058] EDAC sbridge: Duplicated device for 8086:6fad
  [   54.298062] EDAC sbridge: Failed to register device with error -19.

on a large system (see [1]).  It looks like sbridge_get_onedevice()
looks up things based on the PCI bus number, but it ignores the PCI
domain (aka segment) number, and I suspect it thinks 0000:ff:13.5 and
0001:ff:13.5 are duplicates.

  sbridge_get_all_devices
    while (...)
      do
	sbridge_get_onedevice
	  pdev = pci_get_device(...)
	  sbridge_dev = get_sbridge_dev(pdev->bus->number, ...)
	  if (sbridge_dev->pdev[sbridge_dev->i_devs])
	    printk("Duplicated device ...")
	    return -ENODEV                   # -19
      while (pdev ...)

It looks like 88ae80aa609c ("EDAC, skx_edac: Handle systems with
segmented PCI busses") fixes a similar problem; maybe that should
be applied elsewhere in EDAC as well?

Why doesn't EDAC use the standard pci_register_driver() interface?
That would avoid issues like this.  It would also avoid the potential
conflict of another driver operating on the device at the same time.

[1] https://bugzilla.kernel.org/attachment.cgi?id=277759 (attachment
to unrelated bug https://bugzilla.kernel.org/show_bug.cgi?id=200765)
