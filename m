Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCE4C4161B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 02:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD9B20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 02:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EB8VRTsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD9B20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeKRMNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 07:13:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39830 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeKRMNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 07:13:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so2032877wmc.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 17:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qSHwbJYvaQOZ/Mb0Eh4kmi8g15k6HJSaDtXCCkjRUlI=;
        b=EB8VRTsV6VrkEofW6LZ+lfkNhT6X9i2jHSx4b2YjN34695PdBsd6tPPERImwobOdiH
         kSh+v7UqENH9DxbZFfeLCW9l3j+nmclNKEbL6gWOarfialkdQM6S7YC8VS29IqU2kx5n
         PBKkVA8B6KZuiTBPgfn973qL7JZbDWWn1gWNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qSHwbJYvaQOZ/Mb0Eh4kmi8g15k6HJSaDtXCCkjRUlI=;
        b=KNngK6X+Uq60ynaf4hctUbCp59Ia3DUqa/FZL3KCfQhC3iWIk47fVlh3w3uKGLh4wx
         BNTu1JXOjzescwyDowHh3fWirpfkurgPf5+smY0iWNIRZpFhi0IPzhNK6gJa4TQvIBsV
         NvAVe+cZLggbO3HTEzeFgm+tOavpGW9y/Fy0TjJDJVAqQVHsKzoWhi3b3+dtaya5RjhW
         IHs7sW+J91q4Gn/dwV0854iH98HL1HAJyYuPH9r8LEnEIwRB7w/YjfEWF7kLq4eH6ESr
         SakF3pHG3auS+CwNQI3P8Jb6DswsWfTMW/ppCLJwkDAQ1/D9RrKrAsRDSINgL87jYW2J
         SgCw==
X-Gm-Message-State: AGRZ1gJb0bj+WWMGVLNzu0LRk+TvppdEZfQbhxFWsjWJ+Tb5j0hfWIkL
        BrlrmlLYwGUo/IfxukbROwEM0Q==
X-Google-Smtp-Source: AFSGD/X8YG8Tiep7JwDgDGEOz1auflIkujxNqOOjxUN9Plcu/jEjkIZejG/rHJt79yJsNpvTbmPO7w==
X-Received: by 2002:a1c:85c5:: with SMTP id h188-v6mr2839531wmd.59.1542506066649;
        Sat, 17 Nov 2018 17:54:26 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 134-v6sm31487861wmp.6.2018.11.17.17.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 17:54:26 -0800 (PST)
Subject: Re: [PATCH V2 1/2] clocksource: imx-gpt: add support for ARM64
To:     Anson Huang <anson.huang@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1541379930-14538-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <077105a6-e673-4adb-f2f0-f97a64eff5de@linaro.org>
Date:   Sun, 18 Nov 2018 02:54:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541379930-14538-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 02:10, Anson Huang wrote:
> This patch allows building and compile-testing the i.MX
> GPT driver also for ARM64. The delay_timer is only
> supported on ARMv7.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> no change since V1.

Applied, thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

