Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E211C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67FE20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67FE20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=whitequark.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeIGPo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:44:56 -0400
Received: from uruz.whitequark.org ([188.166.218.19]:35904 "EHLO
        uruz.whitequark.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeIGPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:44:56 -0400
Received: by uruz.whitequark.org (Postfix, from userid 1002)
        id C483320ADF; Fri,  7 Sep 2018 11:04:27 +0000 (UTC)
To:     Mario.Limonciello@dell.com
Subject: Re: USB type-C altmode support for UCSI
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 Sep 2018 11:04:27 +0000
From:   whitequark <whitequark@whitequark.org>
Cc:     heikki.krogerus@linux.intel.com, mika.westerberg@linux.intel.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <a2f79cc4d9a0aab4a832de31b7ddc52d@whitequark.org>
References: <1e8398f2c1790890f40b69f12e2934e3@whitequark.org>
 <20180903140623.GD15112@kuha.fi.intel.com>
 <28522bb57c5d8f49416b9174b19b1625@whitequark.org>
 <20180905132429.GB25121@kuha.fi.intel.com>
 <4df3faaee8904d81bf7737b5f2daaff5@ausx13mpc120.AMER.DELL.COM>
 <a2f79cc4d9a0aab4a832de31b7ddc52d@whitequark.org>
Message-ID: <3a666f66d6e342e2971b800caae7c889@whitequark.org>
X-Sender: whitequark@whitequark.org
User-Agent: Roundcube Webmail/1.2.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-05 14:13, whitequark wrote:
> On 2018-09-05 13:50, Mario.Limonciello@dell.com wrote:
>> Some Dell XPS systems do not support that TBT2<->TBT3 adapter. I think 
>> I
>> tried this on XPS 15 9550 and XPS 13 9365 and in both cases it is
>> rejected. I think it has something to do with the PD controller
>> firmware. Same goes if you Plug TB16 dock and to that dock then 
>> connect
>> the adapter + device.
> 
> This is my understanding as well, however I'd like to fix this issue.
> From looking at the BIOS image I can see that the 9360 uses a TPS65982
> USB PD controller. The adapter uses a TPS65983A (confusingly remarked
> by Apple as CD3215B). I've seen reports on the web that there is some
> inherent incompatibility between TPS65982 and TPS65983, however TI is
> for some reason extremely secretive about TPS65983 and I wasn't able
> to get anything definitive about it.
> 
> Anyway, I've reverse engineered a nontrivial part of the TI TPS6598x
> firmware and register layout, however my understanding of Thunderbolt
> and USB PD is not sufficient to proceed.
> 
> Mario, do you think you could get in touch with the people at Dell who
> work with USB PD and ask if:
> 
>   (a) the adapter advertising an altmode with SVID:0x8087 
> VDO:0x00010001
>       is the problem here, and
>   (b) whether configuring the register 0x52 Intel VID Configuration in
>       the adapter's USB PD controller to set TBTModeDataTXSOP=0x0000
>       would help.

I have been able to verify two things by reflashing the adapter with 
upstream
(non-Apple) firmware and experimenting with the configuration:

(a) the altmode with SVID:0x8087 VDO:0x00010001 (16th bit set) means 
that
     this is an altmode advertised by a legacy Thunderbolt (3 to 2) 
adapter.
     So the adapter is fine here.

(b) the Dell USB PD controller doesn't try to negotiate the altmode even 
with
     advertised VDO:0x00000001. Something else is missing in the 
configuration.

-- 
whitequark
