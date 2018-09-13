Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B35C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A76204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUwKchQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A76204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbeIMSwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:52:40 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:45221 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbeIMSwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:52:40 -0400
Received: by mail-qt0-f181.google.com with SMTP id g44-v6so5331713qtb.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 06:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JZSVC7KXPPZ4T6vocifazZPZVO827cqUnOYgaDIE/Pg=;
        b=FUwKchQiXhj6szGp2KRtY2az1OIg+AODXPUJZrysxkTeuijO5ou1/HLpIJQG4BseVX
         ir7hRE2TmfrQ4XOjSFtXJlKM6LP8fFQ0UlM1ngqOQ2zeRZU7p/0iaVnYfZStFcWQAk9B
         qwUrdV2mmn4DFAvmhRsd8dkdWMLS3LHWYrZKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JZSVC7KXPPZ4T6vocifazZPZVO827cqUnOYgaDIE/Pg=;
        b=r4NqPfULIT+/DCR9I7V2NsdiUn2cM9E0O53rHC4sgDNF5VOs5CHe7iJsc5fRaqqBLN
         V5gmNj9bCmpQKXrYQE+DNlIXDKYBTepHyCNKgqqvniUvr7+tVgQrp3CvqoUd1CSmTuxm
         eolB0evYoOOrLo/rj34PwO40X/KbUI8qMn468AFnVLGnJrkjay9uF9PCSZ0DtvuX+ljm
         I4kAUjk7v/gWQGxb/BLMGUbDpWjmMRS491Qgi1b/4VN6q3NqUYWng4pQFcODnR52getS
         3qvGk8dO9kzWbRmvN5OruZIoUfSPvrKaiswbgpH91ijpcGIgxA45AkVchgBGtWJuF5KB
         yIAA==
X-Gm-Message-State: APzg51C/dqeH6a8RtUOKBBLtqOTZOSwTr1earI73g9qCPdha6vJPGhBQ
        Zr3/5X4aVyxXhp0z3caxwpYH4Of2EuhQQQ==
X-Google-Smtp-Source: ANB0Vdbn80KEXnPAmCwL3R2BPU/XmpDmwbwBT6BoU9GHRhCMXYjnNujKRoDTLCJSs1UJBrnFoYK7kA==
X-Received: by 2002:a0c:cc09:: with SMTP id r9-v6mr5234211qvk.95.1536846187529;
        Thu, 13 Sep 2018 06:43:07 -0700 (PDT)
Received: from [192.168.2.120] (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.googlemail.com with ESMTPSA id x40-v6sm2562827qtj.97.2018.09.13.06.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 06:43:06 -0700 (PDT)
Subject: Re: [PATCH 2/2] thermal: imx: handle error path in one place to save
 duplicated code
To:     Anson Huang <Anson.Huang@nxp.com>, rui.zhang@intel.com,
        edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536829986-23702-1-git-send-email-Anson.Huang@nxp.com>
 <1536829986-23702-2-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d60f6f26-9662-c2f0-b801-582099f97cdf@linaro.org>
Date:   Thu, 13 Sep 2018 15:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536829986-23702-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2018 11:13, Anson Huang wrote:
> During probe phase, the error path can be handled in one place and
> use goto method to save many duplicated code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Thanks for this cleanup.

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

