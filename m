Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CC7C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E7224626
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gZb/bpzm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fr/KkUNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E7224626
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031594AbeGARYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:24:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50254 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeGARYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:24:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 46AA0607DC; Sun,  1 Jul 2018 17:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530465873;
        bh=rPbBth+H/qhtim7GpzNE4SaqHusjypkYA8CpLage9CY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gZb/bpzmaxMAk1R7OnmQRfcwSesRB/yUbD/9PhMrQUyYiyMhgkzDZl6E+3ldumAIH
         zVU/Rm21vBOtlC3poge0zaZZQkr+sR/E1D5zd+PkSeLCtjqa3itS8XWQ3+gzKdpaAR
         5qu6u8osjaqppz/n8ZTvh/QQO68RcU+wuP3dA+hU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id ADB9F60BE7;
        Sun,  1 Jul 2018 17:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530465868;
        bh=rPbBth+H/qhtim7GpzNE4SaqHusjypkYA8CpLage9CY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fr/KkUNs054Nav8jNoBkR1/9dmhcNr3Wv9N4oGB6Bgp0MAIApkLV9dT+FdM7Qtm+j
         EECL58BMl4MDtMraCta4VOJTEltfCcgmBVGfiuvB1w1GjILBtyHJpPA2vqFZOJu7l+
         Qq6dL3Gqn1t5+4HxrllyxhGweS9cy+ZF20a/n8Rw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 01 Jul 2018 13:24:28 -0400
From:   okaya@codeaurora.org
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 7/7] PCI: Handle link reset via hotplug if supported
In-Reply-To: <20180701171443.GA28249@wunner.de>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
 <1530214274-21139-7-git-send-email-okaya@codeaurora.org>
 <20180701171443.GA28249@wunner.de>
Message-ID: <7d0180b065e4a06a644ee754fb34b702@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-01 13:14, Lukas Wunner wrote:
> On Thu, Jun 28, 2018 at 03:31:05PM -0400, Sinan Kaya wrote:
>> +static pci_ers_result_t pciehp_reset_link(struct pci_dev *pdev)
>> +{
>> +	struct pcie_device *pciedev;
>> +	struct controller *ctrl;
>> +	struct device *devhp;
>> +	struct slot *slot;
>> +	int rc;
>> +
>> +	devhp = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_HP);
>> +	pciedev = to_pcie_device(devhp);
>> +	ctrl = get_service_data(pciedev);
>> +	slot = ctrl->slot;
>> +
>> +	rc = reset_slot(slot->hotplug_slot, 0);
>> +
>> +	return !rc ? PCI_ERS_RESULT_RECOVERED : PCI_ERS_RESULT_DISCONNECT;
>> +}
> 
> This looks like a bit of a detour.  There's a "struct pci_slot *slot"
> pointer in struct pci_dev.  Any reason not to simply call:
> 
> 	rc = reset_slot(pdev->slot->hotplug_slot)

pdev here is the bridge. Slot pointers are only valid for children 
objects.


> 
> Lukas
