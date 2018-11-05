Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BA8C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505912085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T9XdktTh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T9XdktTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505912085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeKERkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:40:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54104 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKERkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:40:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AF3CD6044B; Mon,  5 Nov 2018 08:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541406108;
        bh=WQTbjpR0PRLdjA76qJDJ0MakhUnOJ3ltB4aXX6EVO4A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T9XdktThz7p9HDW0tejmvHFM0rxeE8EhwIgMGI785G31OyBlXoJkXQZUbpw54evpf
         KXAoKf+h/dN7vlQM7yTDRuU7UajuyVyms62Y867u3Dg8IlhKpo+qT93YcrsCdpUZ3Z
         g6/eiKXFpG3bA2Jf4T4IoF1rDqHJvROznfu4f/Yw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 358176044B;
        Mon,  5 Nov 2018 08:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541406108;
        bh=WQTbjpR0PRLdjA76qJDJ0MakhUnOJ3ltB4aXX6EVO4A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T9XdktThz7p9HDW0tejmvHFM0rxeE8EhwIgMGI785G31OyBlXoJkXQZUbpw54evpf
         KXAoKf+h/dN7vlQM7yTDRuU7UajuyVyms62Y867u3Dg8IlhKpo+qT93YcrsCdpUZ3Z
         g6/eiKXFpG3bA2Jf4T4IoF1rDqHJvROznfu4f/Yw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 05 Nov 2018 16:21:48 +0800
From:   tengfei@codeaurora.org
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, will.deacon@arm.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm: kernel: add support for detecting armv8 cpu cache
 information
In-Reply-To: <20181018085609.GI30658@n2100.armlinux.org.uk>
References: <1539843407-7439-1-git-send-email-tengfei@codeaurora.org>
 <20181018085609.GI30658@n2100.armlinux.org.uk>
Message-ID: <8a260ff92ceaf2c673327fd390780434@codeaurora.org>
X-Sender: tengfei@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

     our team team was trying to check L1, L2 cache size with adb 
commands help on 32bit ARMv8 platform, so we submit this patch.

Thanks,
Tengfei Fan

On 2018-10-18 16:56, Russell King - ARM Linux wrote:
> On Thu, Oct 18, 2018 at 02:16:47PM +0800, Teng Fei Fan wrote:
>> This patch adds support for cacheinfo on 32bit ARMv8 platform.
>> Add support for detecting cpu cache information cpu cache information
>> via sysfs for 32bit armv8 platform. And export to sysfs then userspace
>> can get from /sys/devices/system/cpu/cpuX/cache.
> 
> You don't explain why this is needed.
> 
> We don't do this for previous 32-bit CPUs, so why should we do this
> for ARMv8 running on a 32-bit kernel?
