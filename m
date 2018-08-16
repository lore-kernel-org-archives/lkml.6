Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4D0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173942147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TkSSLKIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173942147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeHQADw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 20:03:52 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:40047 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeHQADw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 20:03:52 -0400
Received: by mail-vk0-f65.google.com with SMTP id q184-v6so2150172vke.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 14:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UO9LRJwzqqduqzNHjgLRd9IRZdQPAiMYmv3yQW4+S8Q=;
        b=TkSSLKIUSlbNOvlckRYMm0C8WjLhhAwg16J0wh3UxUsJjr3nT/1bizrsNzWcRhKAWT
         U/FzsrTm+9uh5u+du8UMlh3cp4nTq6RUyF53t23AHW7Gk98UehgNpOKH7md28aKrOpmz
         AGsKDM0d81CfHcndUL9CN6phFaytmByKnCtjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UO9LRJwzqqduqzNHjgLRd9IRZdQPAiMYmv3yQW4+S8Q=;
        b=Veq57SkZP2WHyV1TyT6S47m01E4v9CoIrM9uAbFEEg6NFQjeAD+jeVnmHSRVL8Cn67
         ZHKxH5pWQZpx8ZUHT3RBNqkSasC3I96kj8kPFhUTLlrB0TDuQzwtH3JBvhWhp5Z1XNDc
         /gxK2WwCsawUPTw9cwfBnEouabMjZpCudui7wCJ3siEpB+8463Vb4YvrF6Ny0d4q6DZx
         1K13by95L3YyeMBsmGBfb1Hw55LPBoUSDWGQyNw3ezUtOC/G0mJ4ihnffYanYknxIKME
         dBuzt6KYG6Z+8bfJuTk32sNGwbs7D/pM5IXtVmDj8M4Ub4qatFuNj8EybQzVJv3mhOfC
         KW4g==
X-Gm-Message-State: AOUpUlG+ZGaKdVWPE1k8490Y4tga6vQIIwvt8zPsT5GTyZb5uR2i7Zpp
        UA6+gjUapHhBLxcRJxNUyCPLscW7TJ6ilg==
X-Google-Smtp-Source: AA+uWPysn9joEFkfMO0wfVXgt7z3cxRvH+U5RWcj6wWkj7bbuDbnCnqrLGqldaJwhFoGBu5JrNL68w==
X-Received: by 2002:a1f:61c5:: with SMTP id v188-v6mr20586760vkb.19.1534453391273;
        Thu, 16 Aug 2018 14:03:11 -0700 (PDT)
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com. [209.85.213.49])
        by smtp.gmail.com with ESMTPSA id b15-v6sm57067uak.40.2018.08.16.14.03.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 14:03:10 -0700 (PDT)
Received: by mail-vk0-f49.google.com with SMTP id v72-v6so2148965vkd.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 14:03:10 -0700 (PDT)
X-Received: by 2002:a1f:a784:: with SMTP id q126-v6mr20905354vke.70.1534453389723;
 Thu, 16 Aug 2018 14:03:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 14:03:08 -0700 (PDT)
In-Reply-To: <037cd5e2-0d3b-c20f-a444-99087b86706b@codeaurora.org>
References: <20180814170617.100087-1-dianders@chromium.org>
 <20180814170617.100087-2-dianders@chromium.org> <bf70f01d-41ac-dcdc-b503-5e0eb1e70329@codeaurora.org>
 <CAD=FV=VNCOyyq5+xvSudTmtBgPm4-s7gj7GRCvuL5vSmA6yDVA@mail.gmail.com>
 <aa2bd1f6-74b4-a63b-d115-88d6e16ed95d@codeaurora.org> <CAD=FV=WBw2SKgPq8Atb+SkziUku8p7N4GWemHYZZvoMSE0bK9g@mail.gmail.com>
 <20180815111318.GY2414@sirena.org.uk> <CAD=FV=VT6b1SmboyuBSGCnm17HTxxvAL8Hec23Dmc6Yfk5jYOg@mail.gmail.com>
 <037cd5e2-0d3b-c20f-a444-99087b86706b@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Aug 2018 14:03:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UnJMGRan=pOujXFkG2oHZUFoiHvk8om+=31SVu7-y6Mg@mail.gmail.com>
Message-ID: <CAD=FV=UnJMGRan=pOujXFkG2oHZUFoiHvk8om+=31SVu7-y6Mg@mail.gmail.com>
Subject: Re: [PATCH 1/4] regulator: core: If consumers don't call
 regulator_set_load() assume max
To:     David Collins <collinsd@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 16, 2018 at 1:58 PM, David Collins <collinsd@codeaurora.org> wrote:
> Hello Doug,
>
> On 08/16/2018 01:07 PM, Doug Anderson wrote:
>> I'll work on either adding more regulator_set_load() calls to clients
>> or perhaps disabling the "regulator-allow-set-load" for a bunch of
>> rails.  David: presumably if we have a rail that we never need to be
>> on-and-in-low-power-mode can just be left in high power mode all the
>> time?  There should be no advantage of being in low power mode for a
>> regulator that is off, right?
>
> Generally speaking, yes, that is true on both points.  The only caveat is
> that there could be a minor power penalty if APPS votes for OFF+HPM and a
> non-HLOS processor votes for ON+LPM for the same regulator.  This would
> lead to an aggregated state of ON+HPM when only ON+LPM is really needed.

OK, thanks for the confirmation.  ...so if we know that this is a rail
that the non HLOS has no business dealing with then this would be a
nice simplification so we don't need to go add code to all drivers
everywhere when all they want is a simple regulator that turns on and
off.

Presumably we could also add code somewhere in Linux that would
automatically vote for LPM for a regulator that has been disabled if
we had to.

-Doug
