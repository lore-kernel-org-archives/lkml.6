Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47741C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FF423E51
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A/NjmqA6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A/NjmqA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FF423E51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeGCNba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:31:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeGCNb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:31:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A0A55607DC; Tue,  3 Jul 2018 13:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530624687;
        bh=iDh4Mz7ebQ3o6YCVWyuS/iCKZqnwbTS9AhT24PUtUgw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A/NjmqA6AAXuV6d0uljoVAOfEOB9qLutxYuhVj+h7pvQ5rHiBVaNQilSsP8zFv3JD
         3o84zzuFc7iWgSnYlOnI07gktx7OgsVCqVtwOpptX4I1IPvmrAy2piKIJoeEZr+o05
         rzYkhR2lj9m7Wp8wgbaBiFagsunnaGWtA/cmvYJw=
Received: from [192.168.0.117] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F315E605A4;
        Tue,  3 Jul 2018 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530624687;
        bh=iDh4Mz7ebQ3o6YCVWyuS/iCKZqnwbTS9AhT24PUtUgw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A/NjmqA6AAXuV6d0uljoVAOfEOB9qLutxYuhVj+h7pvQ5rHiBVaNQilSsP8zFv3JD
         3o84zzuFc7iWgSnYlOnI07gktx7OgsVCqVtwOpptX4I1IPvmrAy2piKIJoeEZr+o05
         rzYkhR2lj9m7Wp8wgbaBiFagsunnaGWtA/cmvYJw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F315E605A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
To:     poza@codeaurora.org
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
 <2640af5e-f00f-d814-425d-78ac57714f6d@codeaurora.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <bd04c9d1-6dfe-3071-69f9-beb0d649b6c0@codeaurora.org>
Date:   Tue, 3 Jul 2018 09:31:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2640af5e-f00f-d814-425d-78ac57714f6d@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/2018 9:25 AM, Sinan Kaya wrote:
>> what if we only have conditional enumeration ?  (leaving removing devices followed by SBR as is) ?
>>
Sorry, I think I didn't quite get your question. 

Are you asking about the enumeration following link up while keeping the
current code as is?

Issue is observing hotplug link down event in the middle of AER recovery as in
my previous reply.

If we mask hotplug interrupts before secondary bus reset via my patch,
then hotplug driver will not observe both link up and link down interrupts.

If we don't mask hotplug interrupts, we have a race condition.

I hope I answered your question.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
