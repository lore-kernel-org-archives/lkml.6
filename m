Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FB5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C7C206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C7C206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbeGQSWn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:22:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729730AbeGQSWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:22:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB4DC307D84A;
        Tue, 17 Jul 2018 17:48:59 +0000 (UTC)
Received: from t450s.home (ovpn-116-29.phx2.redhat.com [10.3.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1536608EF;
        Tue, 17 Jul 2018 17:48:58 +0000 (UTC)
Date:   Tue, 17 Jul 2018 11:48:48 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 4/4] PCI: Introduce the disable_acs_redir parameter
Message-ID: <20180717114848.2914d547@t450s.home>
In-Reply-To: <20180717170204.30470-5-logang@deltatee.com>
References: <20180717170204.30470-1-logang@deltatee.com>
        <20180717170204.30470-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 17 Jul 2018 17:49:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 11:02:04 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> In order to support P2P traffic on a segment of the PCI hierarchy,
> we must be able to disable the ACS redirect bits for select
> PCI bridges. The bridges must be selected before the devices are
> discovered by the kernel and the IOMMU groups created. Therefore,
> a kernel command line parameter is created to specify devices
> which must have their ACS bits disabled.
> 
> The new parameter takes a list of devices separated by a semicolon.
> Each device specified will have it's ACS redirect bits disabled.
> This is similar to the existing 'resource_alignment' parameter.
> 
> The ACS Request P2P Request Redirect, P2P Completion Redirect and P2P
> Egress Control bits are disabled which is sufficient to always allow
> passing P2P traffic uninterrupted. The bits are set after the kernel
> (optionally) enables the ACS bits itself. It is also done regardless of
> whether the kernel sets the bits or not seeing some BIOS firmware is known
> to set the bits on boot.
> 
> If the user tries to disable the ACS redirct for a device without the
> ACS capability, a warning is printed to dmesg.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  9 +++
>  drivers/pci/pci.c                               | 76 ++++++++++++++++++++++++-
>  2 files changed, 83 insertions(+), 2 deletions(-)

Thanks for the re-spins!

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
