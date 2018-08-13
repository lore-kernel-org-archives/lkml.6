Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A773AC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6AB21759
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mMOdQ62g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6AB21759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeHMKKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:10:05 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:42636 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeHMKKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:10:05 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7D7Sjxk028129
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:28:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7D7Sjxk028129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534145325;
        bh=3WlZH5OeH8BMPgCrX2sx7IpGMKeAwUTZt2na8LqkYJI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=mMOdQ62gyM0krDUMjfWULxJNg3Oof6jx+PEqGW0vFGBW27DTkfIU43BUKcmLWMxTe
         Phh6z0ZqkUaxpIrvUDA2fp9busj+CD6a1M6hiFFXsZC/OLTbj4JMC0a8hGT82J6MF6
         6NX6OVTkEtoIulCpSsq77vlk15MY+WUXhO89ZVOt9dEVRwbCEOWGn1DwHXLVv3HEGC
         3JvqArLAkn6xXQgSDF4qvmaPwga7dz0A8RLvzQR3YLoJDaIMqmAN0b3xBp0moRyOvS
         57aP+8j+B7IbL9+EvojOuI2UM/fAQs89GXsttRUPS3TUDs7RHeo7vn3ACvpTi6dlIK
         jSHl86gfY3M/A==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id f4-v6so8134328uao.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 00:28:45 -0700 (PDT)
X-Gm-Message-State: AOUpUlHN8LqirdrqJskh5jRU0wooHoLJYScI4lslnJu0KoYXa/VlSGYr
        KI1ETMuD+jHBHq9O0eEseELWf97AMPjalzLpkxo=
X-Google-Smtp-Source: AA+uWPwrDiCVabg5ePM7t1PjZQXvfup0YAtAejkjujqkQeov4SPtYKIsGh4Cg+ApsMOFWK4E4IOsJ5QCfBqc0TTtV+g=
X-Received: by 2002:a1f:5347:: with SMTP id h68-v6mr10498392vkb.141.1534145324408;
 Mon, 13 Aug 2018 00:28:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 00:28:04
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1808102230410.2806@hadrien>
References: <20180810133636.8340-1-efremov@linux.com> <20180810202555.11034-1-efremov@linux.com>
 <alpine.DEB.2.20.1808102230410.2806@hadrien>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 13 Aug 2018 16:28:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNASH0ypRWi01zUX2WCfG_KkjfLuRNSqhnQFyWAH+6iFHvA@mail.gmail.com>
Message-ID: <CAK7LNASH0ypRWi01zUX2WCfG_KkjfLuRNSqhnQFyWAH+6iFHvA@mail.gmail.com>
Subject: Re: [PATCH v2] coccicheck: return proper error code on fail
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-11 5:31 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
>
>
> On Fri, 10 Aug 2018, efremov@linux.com wrote:
>
>> From: Denis Efremov <efremov@linux.com>
>>
>> If coccicheck fails, it should return an error code distinct from zero
>> to signal about an internal problem. Current code instead of exiting with
>> the tool's error code returns the error code of 'echo "coccicheck failed"'
>> which is almost always equals to zero, thus failing the original intention
>> of alerting about a problem. This patch fixes the code.
>>
>> Found by Linux Driver Verification project (linuxtesting.org).
>>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
>
> OK, I get it now.  Thanks.
>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>


Applied to linux-kbuild. Thanks!


>> ---
>>  scripts/coccicheck | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>> index 9fedca611b7f..e04d328210ac 100755
>> --- a/scripts/coccicheck
>> +++ b/scripts/coccicheck
>> @@ -128,9 +128,10 @@ run_cmd_parmap() {
>>       fi
>>       echo $@ >>$DEBUG_FILE
>>       $@ 2>>$DEBUG_FILE
>> -     if [[ $? -ne 0 ]]; then
>> +     err=$?
>> +     if [[ $err -ne 0 ]]; then
>>               echo "coccicheck failed"
>> -             exit $?
>> +             exit $err
>>       fi
>>  }
>>
>> --
>> 2.17.1
>>
>>



-- 
Best Regards
Masahiro Yamada
