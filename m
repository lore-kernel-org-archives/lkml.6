Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA3EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D44E20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JxYxXUhH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JxYxXUhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D44E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeH3UsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:48:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41036 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeH3UsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:48:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E7E99606FC; Thu, 30 Aug 2018 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535647504;
        bh=GQbSECvWPy/sMZMrfexKcA3dkDTayHaPZFXhm2yYqwQ=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=JxYxXUhH6Tu3CBw3hiKxJlmTfHiK077RBwe33gMmLm8jdbE2+plyTcoLPMOHQp2gU
         RganjJo3fBHMbifCxBH6FrV/gy5LWuFz2tHLiK3N9m/+GY2ATeB2myueE7jfZ0f7rz
         lCB/qV00kZtRCrGXkkPiTxqiXOqoNA5TALhNAvS0=
Received: from WUFANW10 (c-71-205-14-210.hsd1.co.comcast.net [71.205.14.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wufan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3B4D60541;
        Thu, 30 Aug 2018 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535647504;
        bh=GQbSECvWPy/sMZMrfexKcA3dkDTayHaPZFXhm2yYqwQ=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=JxYxXUhH6Tu3CBw3hiKxJlmTfHiK077RBwe33gMmLm8jdbE2+plyTcoLPMOHQp2gU
         RganjJo3fBHMbifCxBH6FrV/gy5LWuFz2tHLiK3N9m/+GY2ATeB2myueE7jfZ0f7rz
         lCB/qV00kZtRCrGXkkPiTxqiXOqoNA5TALhNAvS0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3B4D60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wufan@codeaurora.org
From:   "wufan" <wufan@codeaurora.org>
To:     "'James Morse'" <james.morse@arm.com>
Cc:     <mchehab@kernel.org>, <bp@alien8.de>, <baicar.tyler@gmail.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org> <c70fa799-bc9f-64c8-e151-088ca8c3ed3e@arm.com> <000f01d4406f$6ce8f160$46bad420$@codeaurora.org> <1ac15a80-6f9a-cf9d-8e79-37d10549a4ca@arm.com>
In-Reply-To: <1ac15a80-6f9a-cf9d-8e79-37d10549a4ca@arm.com>
Subject: RE: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
Date:   Thu, 30 Aug 2018 10:45:03 -0600
Message-ID: <001101d44080$cd2a73d0$677f5b70$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHcLsFbwflxxBzVeG17JegIRw3gmAF/6qNxAafQzrECfu/PJqSbbaRw
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> > For ghes_edac the bank/device is informational, and nothing would go
> > wrong if the bank/device numbers are the same as another entry. But
> > the handle is now critical for DIMM lookup, thus pull it out.
> 
> Is printing the handle to the kernel log critical?
> 
> I'd expect something collecting errors to read from sysfs, not dmesg. I
> thought the whole point here was to update the per-dimm counters in sysfs.

No, printing out the handle is not critical. What I meant is because the 
information is critical it would be nice to have it available for debugging 
purpose. Otherwise it would be hard to find the handle if bank/device
is not accurate. 

Thanks,
Fan

