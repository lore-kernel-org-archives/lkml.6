Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E7FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6F9208B4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T788MoqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6F9208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbeHAXcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:32:53 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34071 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbeHAXcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:32:53 -0400
Received: by mail-qt0-f193.google.com with SMTP id m13-v6so151856qth.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R8LoDlBgBzG0IhNTvlYK3b1w91hZxR7DIj5KJGZCT5s=;
        b=T788MoqHoWrO77BZIEit+XrWmKrcn/gRSJAtDl1MAqvXZPMPm59zZUbffN3IwE01Gd
         syBp0hfLez9MHFPG9QRPQKj88BzhAUESbwb/z3gdiL6ebj9nPrDroCAEmeOnPL0LLJ+y
         td5YoceaPPHbzfxFRRpxxk0faNjf0TCwTEOwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R8LoDlBgBzG0IhNTvlYK3b1w91hZxR7DIj5KJGZCT5s=;
        b=bS41H1Kjx/6Uc3rIt9nd5/i7z5kj/mOaSuEwi/cBWr/VkHCDzpYfqa5qpvPjbGzR/V
         6wqN9TeE8PTLKT2g4DDsuwvqxITKKNCAnR7BwI5OHh5Z/ZlKDuQ9jJUx6uXo7fzPodtn
         BqD+1V6Y4sQOwag7wlHC1FFhG0JXHqE4Cad7FEi+vtgEWZSkxMsMx9kYPaw1kBv4CMQl
         zMY3If1VntJyvDP9QEKc07GZ3z2JxwvCenr7awdB/oHoeuIrtWQFLOBHT6cfz5zSepgS
         OSJN1LkFNfdfiaRhhadhplsSkTEUiCwit8ewRQtGDsxuXYSQfRyPvmizLIJq3LRHpGb2
         uARQ==
X-Gm-Message-State: AOUpUlHoDPcG296U7kmFmF0H/YyjUfWu7S2zhLo+Endp55SxVeLYaq/H
        C4UYBK2Ui6q9yQjLafyHJtJi1l/YfIx9/g==
X-Google-Smtp-Source: AAOMgpcGAuX5/ozrgNIqVMs/4IPm9L+dOzTI2PZS7uF1XEi89gEtpV557LkF0OQRy87YhjehSQyk9g==
X-Received: by 2002:aed:3c34:: with SMTP id t49-v6mr102888qte.404.1533159903065;
        Wed, 01 Aug 2018 14:45:03 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 14-v6sm69965qty.57.2018.08.01.14.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 14:45:02 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
To:     Andrew Lunn <andrew@lunn.ch>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
 <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
 <20180801184659.GG30658@n2100.armlinux.org.uk>
 <9af7e7a3-54d4-8802-f64a-fc4f9c49c8b9@broadcom.com>
 <20180801200712.GD19257@lunn.ch>
 <20180801202313.GH30658@n2100.armlinux.org.uk>
 <20180801203846.GE19257@lunn.ch>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <8133c1f0-addc-5c48-7a6a-44b0d106c425@broadcom.com>
Date:   Wed, 1 Aug 2018 14:45:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180801203846.GE19257@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Russell,

On 18-08-01 01:38 PM, Andrew Lunn wrote:
> On Wed, Aug 01, 2018 at 09:23:14PM +0100, Russell King - ARM Linux wrote:
>> On Wed, Aug 01, 2018 at 10:07:12PM +0200, Andrew Lunn wrote:
>>> You might want to consider adding clk_optional_get() and
>>> devm_clk_optional_get().
>>
>> I think there's attempts to add such APIs but I don't think it's
>> trivial - it seems to require a _lot_ of discussion.
>>
>> I think part of that is because of the quirky use of error codes.
>> If you look at clk_get(), it calls __of_clk_get_by_name() which
>> returns:
>>
>>  -ENOENT if DT is disabled
>>  -ENOENT if the device has no DT node
>>  -EPROBE_DEFER if the lookup in DT succeeds but there's no registered
>>    clock
>>  -EINVAL if the device has a DT node but the lookup of the name
>>    failed (in otherwords, the optional clock was omitted)
>>  -ENOENT if the clocks = property has not enough clocks for the
>>     clock-names property
>>  -ENOMEM if we fail to allocate the clk
>>  -ENOENT if __clk_get() fails
> 
> That makes it hard. I added phy_optional_get() early on, when the
> error cases were simple. Hopefully they remain simple...
> 
>       Andrew
> 
I traced the devm_clk_get() and ran into various error codes, so I
figured I should return error on all the other errors (like ENOMEM, EINVAL
& EPROBE_DEFER) but 'ENOENT'.

But, looking at the errors from Russell's email, it looks like I
should look for both 'ENOENT' and 'EINVAL' and consider both these
errors as 'clock not specified' ?

Can I do something like this in the code for this patchset:

md->core_clk = devm_clk_get(&pdev->dev, NULL);
if (md->core_clk == ERR_PTR(-ENOENT) || md->core_clk == ERR_PTR(-EINVAL)) {
	/* clock is optional, without it the default
	 * rate divider register values will be used
	 */
	md->core_clk = NULL;
} else if (IS_ERR(md->core_clk)) {
	return PTR_ERR(md->core_clk);
} else {
	rc = clk_prepare_enable(md->core_clk);
	...
}

Thanks
Arun
