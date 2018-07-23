Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36E2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8539120671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8539120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeGXALm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 20:11:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725198AbeGXALm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 20:11:42 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54B22550CF;
        Mon, 23 Jul 2018 23:08:13 +0000 (UTC)
Received: from t450s.home (ovpn-116-105.phx2.redhat.com [10.3.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1291C309128B;
        Mon, 23 Jul 2018 23:08:13 +0000 (UTC)
Date:   Mon, 23 Jul 2018 17:08:12 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: NVMe device specific reset quirk
Message-ID: <20180723170812.177a7161@t450s.home>
In-Reply-To: <20180723224507.GA11656@localhost.localdomain>
References: <20180723221533.4371.90064.stgit@gimli.home>
        <20180723222431.4371.25962.stgit@gimli.home>
        <20180723224507.GA11656@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 23 Jul 2018 23:08:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 16:45:08 -0600
Keith Busch <keith.busch@intel.com> wrote:

> On Mon, Jul 23, 2018 at 04:24:31PM -0600, Alex Williamson wrote:
> > Take advantage of NVMe devices using a standard interface to quiesce
> > the controller prior to reset, including device specific delays before
> > and after that reset.  This resolves several NVMe device assignment
> > scenarios with two different vendors.  The Intel DC P3700 controller
> > has been shown to only work as a VM boot device on the initial VM
> > startup, failing after reset or reboot, and also fails to initialize
> > after hot-plug into a VM.  Adding a delay after FLR resolves these
> > cases.  The Samsung SM961/PM961 (960 EVO) sometimes fails to return
> > from FLR with the PCI config space reading back as -1.  A reproducible
> > instance of this behavior is resolved by clearing the enable bit in
> > the configuration register and waiting for the ready status to clear
> > (disabling the NVMe controller) prior to FLR.
> > 
> > As all NVMe devices make use of this standard interface and the NVMe
> > specification also requires PCIe FLR support, we can apply this quirk
> > to all devices with matching class code.  
> 
> Shouldn't this go in the nvme driver's reset_prepare/reset_done callbacks?

The scenario I'm trying to fix is device assignment, the nvme driver
isn't in play there.  The device is bound to the vfio-pci driver at the
time of these resets.  Thanks,

Alex
