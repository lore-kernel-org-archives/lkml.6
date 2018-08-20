Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB84C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDAE21531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml2qO7on"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDAE21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeHTUPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbeHTUPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:15:35 -0400
Received: from [192.168.0.114] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43B6E21473;
        Mon, 20 Aug 2018 16:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534784349;
        bh=PxIEfokOuXhZZtHBGqg/O75RGtpPaNdB+w2/pS8pRGM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ml2qO7onTfVboALy8vuADfiGYWPqX/Sj3L5vHx+TkCysZOmkavh2sYOLbdtuJpHhC
         FbZdl5bmSTDJIwmqt8Py1WFbWVTnMiMP90EBwXZUTVMPZCFl81xMb8EoINhuxQxtDl
         cLrq/XnwN7u2xsrv4fd5AFxLwvPyapZSedkloj9I=
Subject: Re: [PATCH v8 1/2] PCI: pciehp: Ignore link events when there is a
 fatal error pending
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180818065126.77912-1-okaya@kernel.org>
 <20180820092238.kvktwlovc64oa66e@wunner.de>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <c207adfb-ba3d-700b-2935-aab2fe171e6b@kernel.org>
Date:   Mon, 20 Aug 2018 12:59:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820092238.kvktwlovc64oa66e@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/2018 5:22 AM, Lukas Wunner wrote:
>> +
> This differs from v7 of the patch in that*any*  fatal error, not just
> a Surprise Link Down, results in pciehp waiting for the error to clear.
> 
> I'm wondering if that's safe:  Theoretically, the user might quickly
> swap the card in the slot during, say, a Completion Timeout Error,
> and with this patch pciehp would carry on as if nothing happened.

Functionally both patches are identical. The v7 was still allowing
AER/DPC to handle all fatal error events except Surprise Link Down.

Now, second patch (v8 2/2) is masking the surprise link down event
as we have talked before. Therefore, there is no need to filter
out incoming errors by reading the status register and masking the
unwanted bits.

Just to clarify something, this patch will wait for only the FATAL
error events to be handled by the error handling services only.

Completion Timeout is a NONFATAL error event by default unless
somebody tweaks the severity bits.

Anyhow, all FATAL errors cause one sort of link down either
initiated by software (AER) or hardware (DPC).
Therefore, hotplug driver will observe a link down event and
AER/DPC needs to handle the event as usual.
