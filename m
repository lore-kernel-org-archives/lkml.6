Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D814C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28972213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGd6el7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28972213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeJKPwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:52:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45661 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbeJKPwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:52:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id q5-v6so8609890wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z3dsbi/Ugvl/xxSl6hRtCDRruBpNJG7wLYfh8aYSd2o=;
        b=YGd6el7Uby8BBOH5u7PzwbR7Rz49VSLgryeiU1Ub/DfAmZ6e5YoDpiXR6+pLV86SV8
         1l/RXk8eo7QkNY/Tb3LI0zb8HvFDlcGG7sgTKTMO9Td1BB//TsUUMk9gLsi5tuupYoQw
         QcwoYC/Add9xAbmG4z2/47t43xubRvkR3uaEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z3dsbi/Ugvl/xxSl6hRtCDRruBpNJG7wLYfh8aYSd2o=;
        b=BC2fLUkxWS0pokgCSjLR6UXkcDSUZ/JxO7qpehmrDDnifHb+4n6FH3KsfVBsyHBwaO
         LDodw2c/GnG79JzqOP6aSwin1FMg68Q1uaL20wxBdA7SXziZisgW9tl8Qn3MVriOweEP
         v0vYDnkxTw1+P56yIHF7h8thtMLMhxfyOqquZZ5J69niP75LHowwFU8dRuKWOPvFLFjb
         Kx4mzaEajmsr/pNO8kyH9dtzzaPkrj6mOdwTt10mDOKsccq3yRq+MRidpWtOlB196AGk
         F1V753awjfiuxucIU/GGvRuigl04RHu253BUnTCcnn8qwL4AMoVmUlM9PmXj8pcjapP9
         7oSw==
X-Gm-Message-State: ABuFfoiDBvs7DZHgDC6nju8afr2qVYssOu2LEFbtvEbYtP1suCOf+OUC
        Q6usDFBRuFxpKmaWfSFg2a0tAi4TMw4=
X-Google-Smtp-Source: ACcGV6138uOVyFe6hfIER4hbyFf4Ovyr7Tm6S1hezAL+0pLceCYgoV7QU3ryz2q7TJiV8qHmUp/vAg==
X-Received: by 2002:adf:eec4:: with SMTP id a4-v6mr644518wrp.242.1539246370217;
        Thu, 11 Oct 2018 01:26:10 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id z7-v6sm6840668wrg.52.2018.10.11.01.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 01:26:09 -0700 (PDT)
Subject: Re: [PATCH] media: venus: support VB2_USERPTR IO mode
To:     Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20181011064608.37435-1-acourbot@chromium.org>
 <CAPBb6MXXwCOP6w7WdAFXdbmBLWKFp9gVDUW=uE=UFGiq_jPakg@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <93410466-ae47-b3ef-98ed-7cfe24a91776@linaro.org>
Date:   Thu, 11 Oct 2018 11:26:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MXXwCOP6w7WdAFXdbmBLWKFp9gVDUW=uE=UFGiq_jPakg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 10/11/2018 09:50 AM, Alexandre Courbot wrote:
> Please ignore this patch - I did not notice that a similar one has
> been sent before. 

The difference is that you made it for decoder as well. Do you need
userptr for decoder?


-- 
regards,
Stan
