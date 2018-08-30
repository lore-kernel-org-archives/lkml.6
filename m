Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A8FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CDF205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jtj1MQBW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HnYLipxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CDF205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbeH3SW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:22:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37492 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbeH3SW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:22:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E02660445; Thu, 30 Aug 2018 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535638834;
        bh=eSlm9ES6RAv+gOzZUch0EBt++EW2P5UB4nopY5cp0v8=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=Jtj1MQBWH111CxYdC8bKNq95Zmt1rIE3GNJY79omGnPwyUaBxsM/vc9u4Q5JHkNUv
         fyY9bPO2ryha1CrnPa65x19XsLB6Lq0UCFFyGNqimRSGyh7jwdMVw61FhiyRN2Z/Dl
         BFsVb72Klpo+Dm+ArYG1DKJFyNJ2fWdRieXnEYp4=
Received: from WUFANW10 (c-71-205-14-210.hsd1.co.comcast.net [71.205.14.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wufan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2896360385;
        Thu, 30 Aug 2018 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535638833;
        bh=eSlm9ES6RAv+gOzZUch0EBt++EW2P5UB4nopY5cp0v8=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=HnYLipxNJpWNsh1vS6cemghz+gfm3em8Ih7nLQ5L4qa1P3UT/liNZCnVfYBx2YngH
         /0ZcAzZV+6SSIxOTmJE0giqgtVMCxt7bJkYbsoj/LOCSI9WNrrCrJk5nRlIK1fbh0E
         T6+K/eRt8M7hSFYaNLxnUIJJ42NMml0XnK28w+8w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2896360385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wufan@codeaurora.org
From:   "wufan" <wufan@codeaurora.org>
To:     "'Borislav Petkov'" <bp@alien8.de>
Cc:     <mchehab@kernel.org>, <james.morse@arm.com>,
        <baicar.tyler@gmail.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "'Kani, Toshi'" <toshi.kani@hpe.com>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org> <20180830104307.GC20005@nazgul.tnic>
In-Reply-To: <20180830104307.GC20005@nazgul.tnic>
Subject: RE: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
Date:   Thu, 30 Aug 2018 08:20:32 -0600
Message-ID: <000901d4406c$9d04f360$d70eda20$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHcLsFbwflxxBzVeG17JegIRw3gmALVks7EpLHNfHA=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris, 
 
> If we're going to do this, it needs to be tested on an x86 box which loads
> ghes_edac. Adding Toshi to Cc.
> 
> Otherwise it must remain ARM-specific.

Toshi it would be great if you can help! I'll also test the change in x86 but
not sure if the firmware updates module_handle.

> > +static int ghes_edac_dimm_index(u16 handle)
> 
> get_dimm_smbios_handle()

This function returns an index. So how about get_dimm_smbios_index()?

> > +{
> > +	struct mem_ctl_info *mci;
> > +	int i;
> > +
> > +	if (!ghes_pvt)
> > +		return -1;
> 
> You don't need that test.

Will remove.
 
> > +
> > +	mci = ghes_pvt->mci;
> > +
> > +	if (!mci)
> > +		return -1;
> 
> Ditto.

Will remove

Thanks,
Fan

