Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E1EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099D9208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S9zJ6BHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099D9208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeH0RzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:55:14 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44639 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeH0RzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:55:13 -0400
Received: by mail-yw1-f65.google.com with SMTP id l9-v6so5589214ywc.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wj/ntfMH1aXHXmf8ycogpilKRiyvb6Bx+uVsUwBwse8=;
        b=S9zJ6BHD0JfFOanSxo3egzfLmvedTQsaT3TqDlxu4MMDas7uscVl+VqjVouhKE9Lnf
         j9dtnoSF7w5tvwCBkU9VqpsH7+T070kwucH6DCzj0ah33gyUh1LIe4OrmToizdzsPLvr
         wYAFcQOJt369VSXC45rPN7rlaF1pI8JgP+HpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wj/ntfMH1aXHXmf8ycogpilKRiyvb6Bx+uVsUwBwse8=;
        b=EOLhz20EoPx/hw+247x3Q+0W0m1WG//Zwx9d+zuChmaXT2PIOBXfbSb4nbJCCm5FQh
         0T35elFxiB0Eg+EWZM5qsJO1yfOCGPMZ8vFCJ06phst/eDdzHuf1ZfyNcBoFJoJWtGQN
         Q5bcA2umLk9J95O7oIgsL280Iet7pKGoS33Vf3ZA3ir0BAIix4PJI+GnRYr3/bD6RqCV
         IADv76mPo9fVIp2+Nwd2g6r21H2y3PXKIttuw7Iqn0yaRoXxbPzxuRcSvQoSemBFqNbs
         oWdSCxgY4LvK4NDUZ1OqJAwMcyhdnByXgSVakYVrpb+H9OBGpRgva4up/VHMzxGa7Uav
         kkbg==
X-Gm-Message-State: APzg51AJI2nl5N/v3I0KD63Mn3qsU7vJ8bUzwE3tOWdzek4ZAyISBOgx
        fWkmuP299eZeDdZ5t8E+8BNcjPEa2oM=
X-Google-Smtp-Source: ANB0VdYfFohefRilyuu8bf9osyd2aZpDJNBOV65o9e5aYfFSSh6547EL06kJNPuZc2ouOBilmyRo2Q==
X-Received: by 2002:a81:30c9:: with SMTP id w192-v6mr7260149yww.45.1535378905607;
        Mon, 27 Aug 2018 07:08:25 -0700 (PDT)
Received: from mail-yb0-f175.google.com (mail-yb0-f175.google.com. [209.85.213.175])
        by smtp.gmail.com with ESMTPSA id m82-v6sm7007380ywc.29.2018.08.27.07.08.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 07:08:24 -0700 (PDT)
Received: by mail-yb0-f175.google.com with SMTP id l16-v6so6043903ybk.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:08:23 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr6931735ybh.209.1535378903175;
 Mon, 27 Aug 2018 07:08:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 07:08:22
 -0700 (PDT)
In-Reply-To: <d68f13e6-339a-2a40-9c0d-7549cd9aabb3@mojatatu.com>
References: <20180826055801.GA42063@beast> <20180826061534.GT6515@ZenIV.linux.org.uk>
 <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
 <5c88b08d-b9ca-f3df-ae78-cf685ee6723a@mojatatu.com> <CAGXu5jJZ-BfJPA+m1BOuVVQxPb8SXpSRo+F2cVTF62C9JTyRXQ@mail.gmail.com>
 <d68f13e6-339a-2a40-9c0d-7549cd9aabb3@mojatatu.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 27 Aug 2018 07:08:22 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJD++hegH4j0ajZNejg8mgcHjqVyjveWj9BFaXwRCV_dQ@mail.gmail.com>
Message-ID: <CAGXu5jJD++hegH4j0ajZNejg8mgcHjqVyjveWj9BFaXwRCV_dQ@mail.gmail.com>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 4:46 AM, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> On 2018-08-26 5:56 p.m., Kees Cook wrote:
>>
>> On Sun, Aug 26, 2018 at 10:30 AM, Jamal Hadi Salim <jhs@mojatatu.com>
>> wrote:
>>>
>>> We should add an nla_policy later.
>>
>>
>> What's the right way to do that for cases like this?
>
>
> Meant something like attached which you alluded-to in your comments
> would give an upper bound (Max allowed keys is 128).

The problem is that policy doesn't parse the contents: "nkeys"
determines the size, so we have to both validate minimum size (to be
sure the location of "nkeys" is valid) and check that the size is at
least nkeys * struct long. I don't think there is a way to do this
with the existing policy language.

-Kees

-- 
Kees Cook
Pixel Security
