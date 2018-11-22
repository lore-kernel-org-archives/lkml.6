Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B35AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B902D20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS/WLFun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B902D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406738AbeKWGat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:30:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38000 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389373AbeKWGat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:30:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so2328930pfi.5;
        Thu, 22 Nov 2018 11:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5MulkYc/hepjg42jWCETcdE6w1SeAuGKwuBsYxsl3GE=;
        b=XS/WLFunc++K0M14Jb1pcz56BNrmD/sXwEUlnbGsXNRl+M2oDkQG9+IQzdH9LEaMyY
         zy9oni7w4LWR8iiY+kZEGmsB7pfLVJ3imgYYHCzjJNjDFvaF/dnDfeHl7eNosM2QaeLY
         5WkBJAW13npbCVZgOizkCh4GT7eoyiKNO9C348WxuPi7Uqfxr/nD3LEn014aZAWTrKAY
         ZLILqmLrlXxC3Il8teMNok1r/dhCOkFG0ju8DqO6OXFfibUNaUGk+CPH1sv32+h+YjF0
         pmS85FtIfTODCGQn8DFtBzD2L5bvpwuASOqr/+ura4IDpTg9gvpNEFNu5YoKE7CEedg0
         GMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5MulkYc/hepjg42jWCETcdE6w1SeAuGKwuBsYxsl3GE=;
        b=BxnNeayQI3vKq4QgEAe3uMXqVdW0QYSoxYk6sDeN2UrDnZB9cl5XIqCsnP5fUp++7Y
         +pjcFTiB9uNq7TESXLwJ4UXU+VZh6RggvpLkJzsP3+yu20mJpaQk537YG8WC4OGK0e8v
         ac+aRyCMsD9GsOgsHL6Xe8R3RbQDgXA4CjkF3/kpVR9VausE8dUEZGTL72RH8MRglqZS
         ZHFap9Do5lbQhkQD0EzqhsR9UAEVCFlJhQEW+XGhx1Yv5592YkgRpTT7vSoMoGk7K2j+
         t1X7eBnR4UNwGTUIoRlebUFmeAJDbEPnPaVWVgSPSKkoKKzrViJAiThL/ueleSdtXPoi
         mxLg==
X-Gm-Message-State: AA+aEWZH4wsAGy8EifSGxORhj8LuhmL60oPMVq12urBNgqp12k+NaIlc
        K15schuZvmw8MLc7BdjM5Ko=
X-Google-Smtp-Source: AFSGD/UDAH9qBSbYwQfp1Q5jRFGg/FxlvHcIru/pgyq4KFWxqh47u4nndXtnP1nVEbVHHAoOvOirVw==
X-Received: by 2002:a65:520a:: with SMTP id o10mr11654706pgp.276.1542916198136;
        Thu, 22 Nov 2018 11:49:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g65sm165140837pfa.63.2018.11.22.11.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 11:49:57 -0800 (PST)
Subject: Re: [PATCH 4.9 00/59] 4.9.139-stable review
To:     Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org,
        Murilo Fossa Vicentini <muvic@linux.vnet.ibm.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20181121183508.262873520@linuxfoundation.org>
 <b642656d-4b0d-cb68-f862-9d90bacc88cc@roeck-us.net>
 <bf811213-e1ad-d70e-cf9e-57735e359377@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <31eca57c-ffb2-f646-6686-df304e6ce76b@roeck-us.net>
Date:   Thu, 22 Nov 2018 11:49:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bf811213-e1ad-d70e-cf9e-57735e359377@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/18 10:07 AM, Murilo Fossa Vicentini wrote:
> On 22/11/18 14:33, Guenter Roeck wrote:
>> drivers/net/ethernet/ibm/ibmvnic.c: In function 'ibmvnic_xmit':
>> drivers/net/ethernet/ibm/ibmvnic.c:789:40: error: implicit declaration of function 'skb_vlan_tag_present'
>>
>> Caused by 5f51bb855fa1 ("ibmvnic: fix accelerated VLAN handling").
>> Problem is missing include of linux/if_vlan.h, which was added upstream
>> with commit 6052d5e2a1961b ("ibmvnic: Insert header on VLAN tagged
>> received frame").
>>
>> I have no idea if the offending patch fixes 6052d5e2a1961b, if both are
>> independent, if both are needed, or if none is needed.
>> Copying the authors of both patches.
> 
> Both address different parts of the code within the same VLAN functionality, patch 5f51bb855fa1 (or upstream e84b47941e15) is making a change on the transmit side, and the patch I sent upstream (6052d5e2a196) addresses an issue when the system firmware strips the VLAN tag on the receive side.
> 
> In the context of having proper VLAN support for the ibmvnic driver I would say both are needed, although potentially there are other patches needed for this functionality to work properly, for example upstream commit da75e3b6a029 (ibmvnic: Account for VLAN tag in L2 Header descriptor) and upstream commit 8dff66cc4195 (ibmvnic: Account for VLAN tag in L2 Header descriptor).
> 

Not my call to make, but it seems to me that it might be better to drop
the patch from 4.9.y and ask people to use a later kernel if they need
vlan support for the ibmvnic driver.

Thanks,
Guenter
