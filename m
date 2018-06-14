Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 61315C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0364A208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YcjGQtar";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YcjGQtar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0364A208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754941AbeFNKdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:33:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48382 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754724AbeFNKdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:33:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E6366607BB; Thu, 14 Jun 2018 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528972421;
        bh=MxqVIYAujRh28rJuzkxmsU4O/t4KYy8iYOn2MTFFOi0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YcjGQtarcIUEZgfcERaHA0O7w8aJW2vVGDWjMUg1b1WqNpmGnwIvJS8BpY4+CvPZT
         gM4S3PavqGwYFJC3oRRCwFA29QqcuFZ9F2F3kvub4a0e05r8uPkkz3b2jHuV1+Ahb6
         Z7U/T9qcqxKagPJFtMh3wo9u3R6sHMQM6yjJN33M=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3ED156022C;
        Thu, 14 Jun 2018 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528972421;
        bh=MxqVIYAujRh28rJuzkxmsU4O/t4KYy8iYOn2MTFFOi0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YcjGQtarcIUEZgfcERaHA0O7w8aJW2vVGDWjMUg1b1WqNpmGnwIvJS8BpY4+CvPZT
         gM4S3PavqGwYFJC3oRRCwFA29QqcuFZ9F2F3kvub4a0e05r8uPkkz3b2jHuV1+Ahb6
         Z7U/T9qcqxKagPJFtMh3wo9u3R6sHMQM6yjJN33M=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Jun 2018 06:33:41 -0400
From:   okaya@codeaurora.org
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, linux-pci-owner@vger.kernel.org
Subject: Re: Requirement to get BAR pci_bus_address in user space
In-Reply-To: <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
 <20180614102001.GA20836@lst.de>
 <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
Message-ID: <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-14 06:29, Srinath Mannam wrote:
> ++ Alex Williamson, kvm,
> 
> Hi Christoph,
> 
> Thank you for quick reply.
> 
> If we want to add this in vfio then I think we need to do the same in
> uio case also.
> 
> As I mentioned in previous mail, in the current implementation
> resource information (address and size) is gathering from resource
> named file created in /sys directory.
> So I expect it would be better to have similar method as existing in 
> sysfs.
> 

Can you give some info on why you need the actual bar address value?

> 
> Regards,
> Srinath.
> 
> On Thu, Jun 14, 2018 at 3:50 PM, Christoph Hellwig <hch@lst.de> wrote:
>> The only safe way to use PCI(e) devices in userspace is through vfio.
>> I think that is where you need to take your inquiries.
