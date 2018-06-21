Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F14C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528B920883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/wpomLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528B920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932755AbeFUFBS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 01:01:18 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34303 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932419AbeFUFBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 01:01:17 -0400
Received: by mail-pl0-f65.google.com with SMTP id g20-v6so993738plq.1;
        Wed, 20 Jun 2018 22:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gu8DbW5B02kQSSNKxifD7WrdyoROIRWOpIwG5auqgJc=;
        b=A/wpomLixEXOo77lBg8SOqjSMgfhez14qEU9F2J8gRt/31m/drqV/M7DVqe8REncDB
         DwDGs5G9inpLBnuL/Ww5J7wAjWDCtB35h84VMUn6Uh2mwJyCKupX0Vi3bFIgpUs122zy
         2cj4y+OrSrkXBbEeTGafvsiGvcvjr6BAwCcfrxxu2KNhvcqPwkaoyM0Rqdi53ijy2xbO
         5Y29QN1Y+Q5phs72pCAZmv7u3xmIzmzQBacH/tr5/V5LcWZJCoyVF+iyJsFjMQKaby9p
         yVwm92OwHrNDE+tfTgZMj6lKPnxEwWSBJ5KqFHj1Qha5mLegqb45a2knBmRTEJZJLwO6
         ADTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gu8DbW5B02kQSSNKxifD7WrdyoROIRWOpIwG5auqgJc=;
        b=YDu4X4QZmYbh1lI7YJnrR6/Zn2UKe2md3O5IfadEnuwBYj0odjs0wg+NDabbw341KK
         +g4KVx0vdeVOgtRa+22tj0BV/DusW9gyjM2Bu70D+64lcShDlebP2LXHCUYUuRgMwaHR
         SH97KLbIVuwAPzed2LVTyrik30LBAf9JLggb6i6BoZ93FmUSG4wp6qYJHrlM0CvQudZI
         /FeCTiNu26O1QiPspvrUcSX9wDUeRun4z8h7Fttlqb/oC2aozUxH3YT7Mce/lEg4IXDK
         0C8n2wYFBq9jhom+7Fm2YG3bPGGD+3wnNDgULyIvCaxHiTpyvD/2KXtSX/PwKuJ83cAX
         K7Gg==
X-Gm-Message-State: APt69E2lzJ5VL6Rbg4xXPXFUilib+06XiIfBIB9R7A3ZoJfEHLXjRD11
        JqacR/iGU/ueuxYa7WNcrY8=
X-Google-Smtp-Source: ADUXVKJ2xNgXno68Dr900rG2qUmtgaJZRVM6wThgtXdt9kvdN8QMlWrWGTo5S3QxM2r+Bv2hUd5ubg==
X-Received: by 2002:a17:902:aa83:: with SMTP id d3-v6mr26626201plr.323.1529557276523;
        Wed, 20 Jun 2018 22:01:16 -0700 (PDT)
Received: from [192.168.43.97] ([1.1.125.71])
        by smtp.gmail.com with ESMTPSA id z26-v6sm8035536pfd.60.2018.06.20.22.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 22:01:15 -0700 (PDT)
Subject: Re: [PATCH] arm: dts: socfpga: denali needs nand_x_clk too
To:     Richard Weinberger <richard@nod.at>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        yamada.masahiro@socionext.com,
        "See, Chin Liang" <chin.liang.see@intel.com>
References: <20180619120719.26921-1-richard@nod.at>
 <ba7b5ee8-c9f0-45a1-67ec-3d1f510f6c24@gmail.com>
 <1846662.BtIxBD6EoV@blindfold>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <cc717803-97c7-6afd-8cf1-2b4a95fa94e6@gmail.com>
Date:   Thu, 21 Jun 2018 06:41:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1846662.BtIxBD6EoV@blindfold>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 07:27 AM, Richard Weinberger wrote:
> Marek,
> 
> Am Mittwoch, 20. Juni 2018, 06:52:09 CEST schrieb Marek Vasut:
>> On 06/19/2018 02:07 PM, Richard Weinberger wrote:
>>> The denali NAND flash controller needs at least two clocks to operate,
>>> nand_clk and nand_x_clk.
>>> Since 1bb88666775e ("mtd: nand: denali: handle timing parameters by
>>> setup_data_interface()") nand_x_clk is used to derive timing settings.
>>>
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>> Strictly speaking denali needs a ecc_clk too, but AFAIK such a clock
>>> is not present on this SoC.
>>> But my SoCFPGA knowledge is very limited.
>>>
>>> Thanks,
>>> //richard
>>
>> It looks sane, but I cannot test it right now, since I'm on vacation.
>> I hope Dinh/Chin can jump in.
> 
> The patch was tested by me. So, at least it is not completely untested.
> BTW: I forgot to mention that it depends on Masahiro's Denali fixes.

Then that's perfect.

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

-- 
Best regards,
Marek Vasut
