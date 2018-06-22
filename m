Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9AFC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA68C24575
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pCVPyW/v";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UNAb77NO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA68C24575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934023AbeFVQEI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:04:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeFVQEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:04:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 40AA860AFF; Fri, 22 Jun 2018 16:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529683445;
        bh=UgkMRQ9YzVRTr/yFymVoDYJLVIAuQ5mjwDNqMVRZGlI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pCVPyW/vo4G9yuKA0PXmzfPRaVf46u2LCTX0/RaTAN9737PNYxe731Bi1PdGe8C2h
         OdwJebhxtxvJFla2Jr/vbKWw+SZq2kOEkKyCSM3lCm943wqv/4kQJPDdR26fs5Rgsr
         LzOaDoYIlOQZ8DrMV3ZS8DGy/VfFSMBz8H55Kee0=
Received: from [192.168.0.117] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A608605FD;
        Fri, 22 Jun 2018 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529683444;
        bh=UgkMRQ9YzVRTr/yFymVoDYJLVIAuQ5mjwDNqMVRZGlI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UNAb77NOU7r4l25V11wYoOnyy8AtA5QeaL9RQKscRHh5JMCC8n4XFVHB/jZtLBPQB
         L3QfgOlAULsCb0r9VV1L+4IKsLt9RgOkqIulqvDtFNfssMHhuu9/tzr5tcgacJb+WZ
         ehKigAyOIhth0E8WUzIum0lQxQrUwE2X+YLEK5n0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A608605FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, sulrich@codeaurora.org,
        timur@codeaurora.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Alex Williamson <alex.williamson@redhat.com>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
 <20180619214346.GD33049@bhelgaas-glaptop.roam.corp.google.com>
 <2593baec-8a28-a3e7-7ebf-7c21addda0b8@codeaurora.org>
 <20180622140125.GD108993@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <98c4531b-0b64-b9e1-ef95-562d1613d893@codeaurora.org>
Date:   Fri, 22 Jun 2018 12:04:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622140125.GD108993@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/2018 10:01 AM, Bjorn Helgaas wrote:
>> Since Oza's DPC/AER patch to refactor fatal error handling, both
>> hotplug driver and AER/DPC driver will try removing devices and
>> perform enumeration on link events/AER events.
>>
>> Perfect environment for race condition without a change.
> Yeah, this looks like a bit of a mess.  I guess we're getting two
> interrupts (AER interrupt and hotplug interrupt) and we should
> coordinate their handling somehow.  I don't have a proposal.  This
> race could happen independent of the device reset paths, of course.

I was hoping for pci_reset_slot() to avoid this but it turns out
the root port does not have any slot pointers set on my system even though
hotplug is enabled. 

Slot pointer is only set for the child objects.

https://patchwork.kernel.org/patch/10351515/

 * A PCI bus may host multiple slots, each slot may support a reset mechanism
 * independent of other slots.  For instance, some slots may support slot power
 * control.  In the case of a 1:1 bus to slot architecture, this function may
 * wrap the bus reset to avoid spurious slot related events such as hotplug.
 * Generally a slot reset should be attempted before a bus reset.  All of the
 * function of the slot and any subordinate buses behind the slot are reset
 * through this function.  PCI config space of all devices in the slot and
 * behind the slot is saved before and restored after reset.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
