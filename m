Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29794C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D022A20882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxdW1GGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D022A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388460AbeGXMRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:17:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388241AbeGXMRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:17:47 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC21320882;
        Tue, 24 Jul 2018 11:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532430711;
        bh=eMVrwzgIBHouClke94neqAhscAmgbKbg45ZCwVnq93M=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=PxdW1GGGWnkuh6K+yGjNCTQdQvRHG/6y74vpBFYb9JsYiaNwcbAEXwyNmEr53cftQ
         3ugnk2x4iZosk2Y0mNxTvxnjXsssxcXBagRQpI1jk49iVWUn4hHZXAIAA+k/2d5uXd
         0Cv/437rMVU511azwgZRDLWaN3R9etVOhqMGt3Vo=
Received: by mail-wm0-f53.google.com with SMTP id s9-v6so2122073wmh.3;
        Tue, 24 Jul 2018 04:11:50 -0700 (PDT)
X-Gm-Message-State: AOUpUlGj+gVSb5fbQqXbmGH27ZmO4Z291vRvWGjrm67VE1m5nXUY7GSc
        ULM5T4b49Q3HtFcrTST6FfnrgjQtQ+6ksDH7FUQ=
X-Google-Smtp-Source: AAOMgpclJrfuo6eRe1eGfPiQiqgNIkiiDXxwjqhEaNxg2ccVBLth0WX2J6WFjbrsNCdIdJi0Q2zRwrnRrpeoc+3YX/A=
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr1784489wmm.117.1532430709171;
 Tue, 24 Jul 2018 04:11:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 04:11:48
 -0700 (PDT)
In-Reply-To: <5ef968e1cb2a473cad97f6bfead369ca@AcuMS.aculab.com>
References: <20180723162020.6221-1-krzk@kernel.org> <5ef968e1cb2a473cad97f6bfead369ca@AcuMS.aculab.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 24 Jul 2018 13:11:48 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdveQeg_M42v69m9vBEz2SaJE0_BZNRUqGLt4Ve+ZLYSg@mail.gmail.com>
Message-ID: <CAJKOXPdveQeg_M42v69m9vBEz2SaJE0_BZNRUqGLt4Ve+ZLYSg@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: fs-enet: Use generic CRC32 implementation
To:     David Laight <David.Laight@aculab.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 July 2018 at 13:05, David Laight <David.Laight@aculab.com> wrote:
> From: Krzysztof Kozlowski
>> Sent: 23 July 2018 17:20
>> Use generic kernel CRC32 implementation because it:
>> 1. Should be faster (uses lookup tables),
>
> Are you sure?
> The lookup tables are unlikely to be in the data cache and
> the 6 cache misses kill performance.
> (Not that it particularly matters when setting up multicast hash tables).

Good point, so this statement should be rather "Could be faster"... I
did not run any performance tests so this is not backed up by any
data.

I think the main benefit is rather easier code maintenance by removing
duplicated, custom code.

>> 2. Removes duplicated CRC generation code,
>> 3. Uses well-proven algorithm instead of coding it one more time.
> ...
>>
>> Not tested on hardware.
>
> Have you verified that the old and new functions give the
> same result for a few mac addresses?
> It is very easy to use the wrong bits in crc calculations
> or generate the output in the wrong bit order.

I copied the original code and new one onto a different driver and run
this in a loop for thousands of data input (although not all possible
MAC combinations). The output was the same. I agree however that real
testing would be important.

Best regards,
Krzysztof
