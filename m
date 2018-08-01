Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4399FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85F7208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="kh7qpAzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85F7208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389955AbeHARsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:48:17 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:57198 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389643AbeHARsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:48:16 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 1AAD63BD509;
        Wed,  1 Aug 2018 18:01:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1533139311;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b7JlAWZjdGrJSsM1f8OHLM6Yr72DXJyhTcKPst6E3cI=;
        b=kh7qpAzPkcF1DDCvMWxNlS9MYvE5ZvpTYmaKPbQN463VNcpau11wtW7d5oms+ROX/E4Fk1
        aipPi9ZAA2zzygB7JF5mGPNHRsvbW/7/K7/d0s42eMOZ/eX2/VRDLjlVW/feGfEDPDbZk7
        +S7UKKNcPOl7RCWzCZlpNROIUTVKu1g=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 1AAD63BD509
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 01 Aug 2018 18:01:50 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Prarit Bhargava <prarit@redhat.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        sironi@amazon.de
Subject: Re: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D38B681@ORSMSX110.amr.corp.intel.com>
References: <d8ac835211e5649b5494141a0decc3bc@natalenko.name>
 <b84518d4-fc78-ca2a-7bde-ad6b5f6a7d83@redhat.com>
 <0a4c663887ecc1672d9927ed7256485b@natalenko.name>
 <20180801152926.GB13988@nazgul.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7D38B681@ORSMSX110.amr.corp.intel.com>
Message-ID: <84058a7359c55f2af16a85398df85a36@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.6
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1533139311;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b7JlAWZjdGrJSsM1f8OHLM6Yr72DXJyhTcKPst6E3cI=;
        b=TmcOBsX/rDUTjgp0JXXWkdcP2aIZV6DYQBqSYh+b8T0dZwf4KDkoJMoki2xS7gft65mtu0
        Zw+f1LjnY3vPa4VZnsgJNWH544SXm8wApQIllYuEc6v8uJdJTENbTsbrqJyQTBKScAjZVk
        PsA4FdaJMmBcTvNkMA01j8IGWUrAOek=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1533139311; a=rsa-sha256;
        cv=none;
        b=LmmgWqOioZil+dRUoOVMxRc9WT5XQI5k86aWa7RC7+aEvysMggb0XLQ708tJj6ynzzKABjA9QwQ/MnSw9Y0RzjdLC0cMziJGRmcgmsmOMeWvlM2WdVPWhVMwctCXcbhFi0N15EQflCRcJjSqOlziXv1UbWNnL5GCn0xNdYUTu2c=
ARC-Authentication-Results: i=1; vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 01.08.2018 17:59, Luck, Tony wrote:
>> There's no reliable way to get the old microcode revision which was
>> overwritten during the upgrade. If dmesg gets overwritten you lose, 
>> like
>> in all the other gazillion cases where you lose information due to 
>> that.
> 
> The primary requirement here is that we report the version of the 
> microcode
> in use at the time of a crash. Keeping history of all updates seems to 
> me to
> beyond the scope of the kernel's responsibilities.
> 
> It's not like these updates appear out of the ether. You have to go out 
> and
> grab a new package and install it.  User land can keep track of this 
> much
> more easily than the kernel.

I don't mind doing the right thing at all. It is just to inform you that 
it was found to be useful.

Also, [1].

Thanks ☺.

[1] https://xkcd.com/1172/

-- 
   Oleksandr Natalenko (post-factum)
