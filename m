Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC57CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67067223B6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q+LIukTk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hys9Bi+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67067223B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933102AbeGCPtx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:49:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45478 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbeGCPtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:49:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4D1AD601A8; Tue,  3 Jul 2018 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530632990;
        bh=5Zy6B5pUlaqsWFf8tqUNa8Z981ARt3SA3eKTk1RWR6Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q+LIukTkMMAj8/Wb+WCqX/F82KDLzxxXUla6CWwfkG3QyjSPR9DAJnx1hMUWI7YUo
         29mJ0Y4YFUeRQGNdYdtntDdBa+AXTBis2q7XbxmM7W5n9UIijl8ozI1K7udxTP0Dd0
         TWPd0SScoH2MIbpX9kTgdRGfAGScFWbIUnbroURk=
Received: from [192.168.0.117] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C1EA601A8;
        Tue,  3 Jul 2018 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530632989;
        bh=5Zy6B5pUlaqsWFf8tqUNa8Z981ARt3SA3eKTk1RWR6Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hys9Bi+6rd9DiQoQHj2rLnrodeJdCvlsS0DIHaKIRd/Y93jArUWHgxVaofApkB8y3
         Eo8htqP5WTEx0u6hHVZjYCm3fYYP9I5isBCPFBn52HwaZ7HptfjT/JM+iybkiWYwqg
         dmVRwL7sBDROlINMSyy9ZbPmLQSwdQK2lfS6pLSU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C1EA601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
To:     poza@codeaurora.org, Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703143434.GA4086@wunner.de>
 <fda77cee8e379f2e9b7ab55fefe17cad@codeaurora.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <867e1f69-8b77-ecb0-d4e3-ab0636a49a2e@codeaurora.org>
Date:   Tue, 3 Jul 2018 11:49:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <fda77cee8e379f2e9b7ab55fefe17cad@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/2018 11:12 AM, poza@codeaurora.org wrote:
> if (!pci_probe_reset_slot(dev->slot))
> {
>     pci_reset_slot(dev->slot)
>     result = reset_link(udev, service); >> in this case aer_root_reset must not call pci_reset_bridge_secondary_bus()
> } else
>     result = reset_link(udev, service); >> in this case aer_root_reset must call pci_reset_bridge_secondary_bus() [since bridge is not hotplug capable)

Here are two different flow for two different FATAL error sources

dpc_irq
	link is down due to DPC
	pcie_do_fatal_recovery()
		pci_reset_slot()
			mask hotplug IRQ
			secondary bus reset
			unmask hotplug IRQ
			undefined behavior as link went down due to DPC
		dpc_reset_link()
			undefined behavior secondary bus reset happened
					   while a DPC event is pending
			link may or may not be up at this moment
			recover the link via DPC way if HW can cope with this undefined behavior.


aer_irq
	link is up
	pcie_do_fatal_recovery()
		pci_reset_slot()
			mask hotplug IRQ
			secondary bus reset
			unmask hotplug IRQ
			link goes up
		aer_reset_link()
			secondary bus reset
			hotplug link down interrupt again

I tried to change pci_reset_slot() such that we do

mask hotplug IRQ
go to AER/DPC reset_link based on error source
unmask hotplug IRQ

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
