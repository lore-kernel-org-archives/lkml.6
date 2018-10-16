Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CAAC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA03A2148C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYm44XIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA03A2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeJQHnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:43:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44331 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJQHnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:43:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id 63-v6so27482413wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hPIoSrvRcbSJCz3GHNF0wOBtHTQ3lAluXDKcZbwwSrs=;
        b=eYm44XIl7KwakrfWqtvampCEsK8d1lgWQrMXMTLD/QEmXFEwUoSEoDxQ5IFdD/0krn
         ZkExuLjHF+6UKuOQ3BEwmlkK9Y5okwOuCHggCErkx6WcO4aIPg16fnn3vT1rjVNkZvf7
         w3VY0jGmG0O+OW5YTuyVORfbbcuEm0Co0JzYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hPIoSrvRcbSJCz3GHNF0wOBtHTQ3lAluXDKcZbwwSrs=;
        b=tx/0J/C2QE/ECCBl6dBx82YR4DfZPSeCnNREUfhXmYrOQtylS0NglkkwhE6p9q6kAS
         lx6w1O6T2Vhd1EIOrK34XRV4TaUltOooUVxetjdVPHYzEmGD/zBVU+IMl9zbVL5H81Xg
         ipmv97wO4/Tdy8eVEXmu6q4LCbQJIsM5g8lOOpNslfJV3YHok0izCUn47oUy675JbLxy
         B16RXi4ZPUCI3awFTZzY8jGfzEXEQekcaTHk3faIGWSFaKTkAIlsYpQzLX3i5MxUV66h
         /GgKwlEcYReagcLcTCoEFj7XwNzfReVAtVmPVWxsbFHHhz1zeCL6EOaPZNdBai+8xNhd
         ktyQ==
X-Gm-Message-State: ABuFfojooACIeMEgEaWDqOMKAksbmHzt7qaDlOmFJ8uh5IT5Oj54bBxE
        QJ8B7VVbFS0o2UA8t49/TWCoOT1uSdgZPfcYUz6GTQ==
X-Google-Smtp-Source: ACcGV60ad4W/ZrREyTlmFc1segtd+WpFCss9bRsW9Y9fCT9TNoIJYahDq+qVDx2DxIBjjDUZ0Nd1VABRQZRwdEVwSYM=
X-Received: by 2002:adf:a194:: with SMTP id u20-v6mr13092008wru.50.1539733811673;
 Tue, 16 Oct 2018 16:50:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Tue, 16 Oct 2018 16:50:10
 -0700 (PDT)
In-Reply-To: <CALAqxLXYTZZ12haKHGwnTBqPgkv_JF8=fiiJrD9OWRFdcXf0Sw@mail.gmail.com>
References: <1538434698-1042-1-git-send-email-john.stultz@linaro.org>
 <yq17eiiwobx.fsf@oracle.com> <CALAqxLXYTZZ12haKHGwnTBqPgkv_JF8=fiiJrD9OWRFdcXf0Sw@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 16 Oct 2018 16:50:10 -0700
Message-ID: <CALAqxLX0Q3Yo-75CDdG4g7i5G=i5OPi01ApYyJO6wTn4CSCkPA@mail.gmail.com>
Subject: Re: [RESEND][PATCH] scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Wei Li <liwei213@huawei.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 3:48 PM, John Stultz <john.stultz@linaro.org> wrote:
> On Mon, Oct 15, 2018 at 8:41 PM, Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
>>
>> John,
>>
>>> Hynix ufs has deviations on hi36xx platform which will result in ufs
>>> bursts transfer failures.
>>
>> Is this specific to the particular implementation on hi36xx or all SK
>> Hynix implementations?
>
> I'd have to defer to Wei Li on that question.
>
> Wei Li?

Just to short-cut things a bit, as this is probably an obvious
followup: if it is hi36xx specific, how would you suggest a such a
targeted quirk be added?  I'm not sure I see how to get to the
ufs_dev_desc from the ufs-hisi.c code.

thanks
-john
