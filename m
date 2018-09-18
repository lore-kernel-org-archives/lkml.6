Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39496ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CDD21508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nq7FzMie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CDD21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbeIRXGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:06:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35911 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbeIRXGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:06:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so1357358pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T5TNtvrrVuUacQA/cfQDaoSHMlF5WW9l/86hOcy4RM4=;
        b=nq7FzMieYieGX6uMSC70R4DqdPhe5xYOtdgQi97NW+Lon6VG/A5I/gVlV4l1dFLDtd
         UE7QhaUI/+MNjxG+q5vjePJL+L4aIi6JsxuzuF3twLtyhdTGIZCEUHl6ie0YcIOtNQ8E
         7N0joAM3zPWyIy1hpn3BdXFoBB77MNOJrJuTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T5TNtvrrVuUacQA/cfQDaoSHMlF5WW9l/86hOcy4RM4=;
        b=Z1A9l1fixI8QtExbG3TsiOkkCkM3Wvb3keEnbTcFHdAM0SRvY+3mqjAcM3XzjE912y
         DnE9TDPD7Bu97caJTFEY5gCsRwcTqimtF6K4zE0IKlv5mjrcBQyrDQsYOBnhAeIKEO/T
         DiMswN2cqXvCBmG2EJKNJ6LGdzQOCENKtOKG5D47O1OiuiTh+pQSSWLbAJyvRFUI1RTo
         6PhZqvkJCCTeLVB3j9wIuGaSQzRx0mGG4IdmlzJk1o2MmbpIWc1/ifepVoxJGR7/TtSn
         DJtu5KxmfR6R35tdIxSqxPaCv9zINWCSD/65N+EP1hAyHQUH2ywfMVdc3sge9wLp6P5c
         aQFw==
X-Gm-Message-State: APzg51BTVoToQXSx3tddxkHwHLNuh716JuX3f+rrBrmKB9Dd7VTnwbX5
        B0XGMDeLcB6cSMml7tMX/22DsA==
X-Google-Smtp-Source: ANB0VdYQYpyhnh/dbd8TE2ahCvNqWzKoKJxl5yt8ADYTjWI2geCgX3ChoLCLjr17Pl/UMHmtL2fpqQ==
X-Received: by 2002:a62:cc41:: with SMTP id a62-v6mr31812443pfg.131.1537291963167;
        Tue, 18 Sep 2018 10:32:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id d132-v6sm28870974pgc.93.2018.09.18.10.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 10:32:42 -0700 (PDT)
Date:   Tue, 18 Sep 2018 10:32:42 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/sysrq: Make local variable 'killer' in
 sysrq_handle_crash() global
Message-ID: <20180918173242.GP22824@google.com>
References: <20180917213304.44476-1-mka@chromium.org>
 <a75e8a5d-25d0-83b8-6f7c-b80e69985b60@suse.cz>
 <ebea1697-cf33-675b-172c-3e80303a9ee9@codeaurora.org>
 <20180918072037.GA4442@kroah.com>
 <ccc91067-9718-8eb8-c197-b9c560daa5ce@codeaurora.org>
 <20180918091702.GA10846@kroah.com>
 <32bf1760-4967-a37a-6a17-3f7d5f6e071e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32bf1760-4967-a37a-6a17-3f7d5f6e071e@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 11:51:55AM +0200, Jiri Slaby wrote:
> On 09/18/2018, 11:17 AM, Greg Kroah-Hartman wrote:
> > My question is why we just don't call panic() here instead of trying to
> > duplicate the logic of that function here.  Why is that happening?
> 
> Historically (before d6580a9f1), we had crash_kexec called() from here.
> To be honest, I see no reason not to call panic() or crash_kexec() again
> if there is any issue with the former (I cannot foresee one).

It seems in the end we don't need to change anything for Clang. With
-fno-delete-null-pointer-checks the NULL pointer access is not
'optimized' away, support for this option landed recently in upstream
LLVM, and it is already set in the kernel.

Using panic() instead of roll-your-own-crash still seems a desirable
improvement though.
