Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205CBC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48F92147A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfOO06pS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48F92147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeHVPy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:54:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34988 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbeHVPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:54:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so1477682wre.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2BIiDmyj4Pg4BouLPrVbqaMaqGcC1+M+JIWNxWnRHhY=;
        b=FfOO06pSwNOs2vBMhIH4QnkgNhZZroGUgeUVwaKXerf86g4a1FAwdQalgMyKdGns83
         jG389wbakJLt3N2Xf0MOlpZiGh5sBU7/TMCQlHNTLcAFI+aARHcTVgq0UzUpk501D8bH
         /ORkiuQYn7VtO0gemr3OCPYgUsA3U2UVOX5XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2BIiDmyj4Pg4BouLPrVbqaMaqGcC1+M+JIWNxWnRHhY=;
        b=pA0mc9RWi68C3AlJAbVq/wsdeeyI6Osbe3uYuTtsADUfwR37iWuuUoboMwodw2rFux
         6KCC4idx1qWWrLGhmks+Q77jNlvAr7kCIo1Po85h/fwktWu5WIzfj5k7sFW4O/ixlsQP
         Km+1Z22VMWkZVfxc0clj8BYJDihjCvQcETC5OW52CDCeX8rGz/9puCkb508hJreeefpt
         WdfCsNO561xnXYOnVns1h4mvCD2vdd4DZAO4MZwcmuNbtAgIcpzIqHL+vCgbQsQQigmW
         5ncuEA8VvF6h1e1eBQXgSXrkdwUfhoGH4rgo2BqYMKlOISTmpkBWBrAZ76nmufjNgAn7
         9fjw==
X-Gm-Message-State: AOUpUlH21lpR3V402TaAJ+90RuoJ82QRibXGgbAeBM+y3bjN7PcYQFpK
        etAc3zmGXUqOPhExv5Ut/qw/Uw==
X-Google-Smtp-Source: AA+uWPwqKW1MNydPXMSmml1EKXh7PUJTGMFEqgtIM4PnDNybeO7hdY16GzFS2go+OKsEQs6fGqe20A==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr34351175wrm.213.1534940981729;
        Wed, 22 Aug 2018 05:29:41 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id q5-v6sm3005990wmd.29.2018.08.22.05.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 05:29:41 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] venus: firmware: move load firmware in a separate
 function
To:     Vikash Garodia <vgarodia@codeaurora.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, arnd@arndb.de,
        bjorn.andersson@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        acourbot@chromium.org, linux-media-owner@vger.kernel.org
References: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
 <1533562085-8773-3-git-send-email-vgarodia@codeaurora.org>
 <8ffd63d9-ba9f-44b2-e1c0-7edce167fd9c@linaro.org>
 <4ad5d921a54256bccfd7030a3f0893d8@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <a065f811-d0ea-41d8-822b-92d5f9d0a8f3@linaro.org>
Date:   Wed, 22 Aug 2018 15:29:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4ad5d921a54256bccfd7030a3f0893d8@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 08/21/2018 08:29 PM, Vikash Garodia wrote:
> Hi Stanimir,
> 
> On 2018-08-21 17:38, Stanimir Varbanov wrote:
>> Hi Vikash,
>>
>> On 08/06/2018 04:28 PM, Vikash Garodia wrote:
> 
> <snip>
> 
>>> -int venus_boot(struct device *dev, const char *fwname)
>>> +static int venus_load_fw(struct venus_core *core, const char *fwname,
>>> +            phys_addr_t *mem_phys, size_t *mem_size)
>>
>> fix indentation
> Please let me know which indentation rule is missed out here. As per last
> discussion, the parameters on next line should start from open parenthesis.
> I see the same being followed above.
> Also i have been running checkpatch script and it does not show up any
> issue.

run checkpatch with --strict option please.

> Any other script which can be executed to ensure the coding guidelines ?
> 
> <snip>
> 


-- 
regards,
Stan
