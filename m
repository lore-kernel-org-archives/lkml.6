Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CAAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF45620878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jk55sz2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF45620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLFRB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:01:29 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42295 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFRB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:01:29 -0500
Received: by mail-qk1-f195.google.com with SMTP id w12so719291qkb.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 09:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sF9MKBPM0vlnGuDOOzMQt/B7M7nvsFxg6nHAGOGmT08=;
        b=Jk55sz2NRzGlLs/+u+C6zlO+98ic8i8WYnzgLY+3wvMkJDfB0oGTxpdMwrv6RakjZr
         tk1zrLskJdcitOBYwCROLh7TBkCaueiUf8sKLss2q4EmVQwq2uOYMCKpgHoqXSVRjeue
         99VgW2+j9QhwiRB5eMRhvFMt0phrPrXU20BCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sF9MKBPM0vlnGuDOOzMQt/B7M7nvsFxg6nHAGOGmT08=;
        b=WyX57mI5biX0gpr39dgfsIPWgeFc3SCfJg1M7gyPrnSTKqUi+fMTg+hBULxIO5DYp6
         W7NfBSQhKNaIr3j7HgFOfT8E8EYbSbYuiXDXqezCAIN1yXRyia321KefQyuV2+C5xNt6
         sUMxtD7B3iJ9oJZVNGCqiwVooDweNcFbZjlp7PAav7vk0RC6IbQDhS2OuApTuu5kzE9v
         EgCZvCISxmgW2ETOC9AmwGY35qq+hb2ASbMSxSQO9O9zcTb6ZCeBZ6JasF9jDOsJ3jZf
         G1sTxKmOBHnDLTENcm3T/1RZ7MHCy25Z7Bw/6znzA6ySXkoBWfHN49CJNARHdEergnw9
         w2Fg==
X-Gm-Message-State: AA+aEWYju6d0R+/PIxfP0tV9++GL/W/mVzZ6EV6sJFAFyDz2SZrlb8QP
        ffpNmXqyB5aHQ+um2he1bG5Bo4IWMwU=
X-Google-Smtp-Source: AFSGD/UjpYFp/GZhU40sEnky7XxT9MudBu9ByF0kxxxo3C4KB7hLi6cUYw5wo3g3hWpw0myPqBIkfA==
X-Received: by 2002:a37:8604:: with SMTP id i4mr26715904qkd.199.1544115687179;
        Thu, 06 Dec 2018 09:01:27 -0800 (PST)
Received: from puchatek.local (89-67-27-114.dynamic.chello.pl. [89.67.27.114])
        by smtp.gmail.com with ESMTPSA id 64sm370391qke.39.2018.12.06.09.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 09:01:26 -0800 (PST)
Subject: Re: [PATCH] asm-generic: unistd.h: fixup broken macro include.
To:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <ren_guo@c-sky.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Mao Han <han_mao@c-sky.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1544062060-26875-1-git-send-email-ren_guo@c-sky.com>
 <CAK8P3a1UbR3bosJgKAJZVMn-5aJLS1u0t_OAYSU-dzum4EyVMw@mail.gmail.com>
From:   Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=marcin.juszkiewicz@linaro.org; prefer-encrypt=mutual; keydata=
 xsBNBFpUjlUBCACcrMkSqYJk8B5O6vhcdvMM4yMBxil9hqLD6oKoLkgNCGpnb03xtf2dkdbq
 yZJKEpPteoiYof/qrS7VewUcqWpNfuq5Q3x/Aun89CUVU1GZ+mY+nHhiTddSTCswCNhYfY8S
 lu0eCYIeF5xr3xNcvRIQhxvO1y3aLAo7Te7CikfmtpcM/5IEbUX3EXejoUeMlvdXvX19NM6I
 8uX1DO7v9g0CUN+1h+9YOvLIV+bOJ33jlsB2TNystteoBKotJYhIbfBhrLMWLMzBhOPUaTIe
 hlGO3+4CHi82MqowKYxablG29vFSCn6UFyJS25xLSbMflslCFJey8I4Wry33R1dmzT2jABEB
 AAHNMk1hcmNpbiBKdXN6a2lld2ljeiA8bWFyY2luLmp1c3praWV3aWN6QGxpbmFyby5vcmc+
 wsCOBBMBCAA4FiEE8CbDcZeweWDKBjDApkmLmwOs1qMFAlpUjlUCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQpkmLmwOs1qMVDQf/aIA4NIB03g6JqFoTvhrzvc+n5ALveUyRyChY
 QE71qYCRJi+2A8apTGxkJuk15I9bJ8ySnb6Z51MRg81pikfbPpumtUr9l5u0377JwZmKE/wE
 9drdHfiB+0iamr0+XTvADjIwEnRwz+Vts9ydZQ39cyDv9+2CRTpv/2yY8eM037Ftkejr5HSd
 PzHAHYAQ1SZZNQPHOvYhX3DxOeiOAKz5PUtLgosQLGnaXJ0PRPoajTh/pV3OPiiLeY9UfVsK
 h0s6vo5fSFIdYBSpRW6rEvIrvCmh2Ovgwmy7J6UQk5qiP5T+vFfyZDR90Z3o5kAxShLfGpIZ
 sWxSxuxeMf9SU96d0c7ATQRaVI5VAQgAvzQOLdVY5IoLKIFYz99HtW3FD05UiBdaeVrO14mv
 rh7AGqtd1vmMW7kTpnNhCMi2S54oM18ZMDcD0m1bTIVhSKNcrWuaTOQtL5KyDjHb5j1Q+MRJ
 d4M0n4rs+oskGicsvAHqcRh8BVTFbgVetn+GgT58alufWzIWDGpLcW4W0SgkL5/tYxEXDQI0
 +UJqMmoyDxZbIHmNJUxCXIFbxvUm5X5pNfT7sirfH+OzAeUt5PmjiIDW2Z9h/fgn0ybeLdty
 ZHPKLVwVwSZ+R7PE2IknkYfcKBaomLhDCfCqOKM3uX+8UtXyJ9cKQdnDZr+g6/ICveJ5SbtG
 vVXDRBTvt14o3QARAQABwsB2BBgBCAAgFiEE8CbDcZeweWDKBjDApkmLmwOs1qMFAlpUjlUC
 GwwACgkQpkmLmwOs1qMggggAjQ+LfkLRinj6VwYuQrIHxuyOipZi81s5GTeg5S2cIVKzA5V2
 LTCrIREhzJcEfU/wtj0WXhov1cDWt+QJUkJo7PugiWGH74LqSUkjcJl5WLNbhRzdXiTEjCij
 uwNnZjiHMzOzrlOLDZNZ2qdDTthcBVXexKLWzyJtVkWXdbDPUV47zhGzCc+Q1fvWi8aCJGlv
 8GxOIVR8OXEe1TV64dlUCbmcmjcFRQmvJyMwZE28AqhNtKsRlLkY0o5Yn02wkmgRtAbNA9jL
 00ZX+4x0H+Qm8NQG5Ps9Ay7DePwZH21SsWBleOo43xNlbiw+NUOxC+cIK9BJqAqMmCYoUwtT
 j99pMA==
Message-ID: <61957990-17be-f20f-27f1-ada7a820f3ba@linaro.org>
Date:   Thu, 6 Dec 2018 18:01:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1UbR3bosJgKAJZVMn-5aJLS1u0t_OAYSU-dzum4EyVMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 06.12.2018 o 17:14, Arnd Bergmann pisze:
> On Thu, Dec 6, 2018 at 3:07 AM Guo Ren <ren_guo@c-sky.com> wrote:
>>
>> The broken macros make the glibc compile error. If there is no
>> __NR3264_fstat*, we should also removed related definitions.
>>
>> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
>> Signed-off-by: Mao Han <han_mao@c-sky.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> ---
> 
> Thanks for the reminder!
> 
> Marcin had already sent me the same patch a while ago
> and I forgot to apply it. I applied your version now, which
> as a slightly better changelog, so it will be in linux-next
> tomorrow, and I plan to send it after that shows no regressions.

One patch less to keep locally ;D
