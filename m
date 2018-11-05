Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F0CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE49F2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cC5b9w64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE49F2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbeKFGiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:38:54 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35322 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:38:54 -0500
Received: by mail-ed1-f66.google.com with SMTP id d6-v6so8768694edi.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 13:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HS4Aju5GFnrf8tyDrkKUFltwJc+IxN+9c6+1D0ef2k0=;
        b=cC5b9w64exAfqn5IsWqCRhPMrjN5mbicVVFKgluljZdUM+9uGMsaVi7ku1Gv2KZlek
         tbS0x+1A8AQOxOzmyLSiddSzsCj1PLuO5FINMvV0D+l/GJzeHtvIHvn40XqjkZtIB8Vb
         U8pARzhN+HVCo+yl7txc7JLd4LGUW914XGPGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HS4Aju5GFnrf8tyDrkKUFltwJc+IxN+9c6+1D0ef2k0=;
        b=CNVJvEtmb7YeNx9ZryHSTTqJC8D5eY3lhVIB+urnu3CKeEWqReChascgowdybEVZ3j
         6839P3mULTFJoKgsW4qGlqdjedXl3fe50FqXEC4uor7qp+V2MHGacPQjU/jrTGk7HrJp
         Z/+CUEEkHsI2xHWOtM5AKjlu9PBftJqmdD/kKXBjCk6jfeE7jQwSvFiIjMa+ExalCVRa
         ngBLk8qaUiqfKhimHlqyFaAATd4EDu7Vxtv34pA8ibmI/n8IJRYaj8GjKvlW37HOYaWh
         7dtGSyMNZZGp16HV4RiXQdLLAoQl5diYrcP+bnRnDwbbfxxBmrS+2QxDiD3v4r1NjVCs
         zHiA==
X-Gm-Message-State: AGRZ1gKe2kxiWQA3G7gLnPRuijcVi4Omo06a7PG7Xa6ZWMm/+3PRBd/i
        zoc4IdP+/STXyTNwzs79QUj7P0qRzVU=
X-Google-Smtp-Source: AJdET5fQUlkRq+vRkl0D4WPrRuVNE1Ana79y3uRdGx3X38RDDtb5ydnkTArncaOf0h3Djr60H1WEeg==
X-Received: by 2002:a05:6402:1609:: with SMTP id f9mr8017386edv.35.1541452635616;
        Mon, 05 Nov 2018 13:17:15 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id j9-v6sm6473732edk.88.2018.11.05.13.17.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 13:17:13 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id d15-v6so5724792edr.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 13:17:13 -0800 (PST)
X-Received: by 2002:a50:c907:: with SMTP id o7-v6mr18992724edh.6.1541452633046;
 Mon, 05 Nov 2018 13:17:13 -0800 (PST)
MIME-Version: 1.0
References: <20181013005504.46399-1-briannorris@chromium.org> <20181105130403.93B6560600@smtp.codeaurora.org>
In-Reply-To: <20181105130403.93B6560600@smtp.codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 5 Nov 2018 13:17:00 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMz37pOFjeETM_xUQSBuLvki6G==v=RUO1T5G1t6Yv+dg@mail.gmail.com>
Message-ID: <CA+ASDXMz37pOFjeETM_xUQSBuLvki6G==v=RUO1T5G1t6Yv+dg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ath10k: snoc: remove 'wcn3990' from generic resource handling
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, govinds@codeaurora.org,
        Doug Anderson <dianders@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 5:04 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> This patchset (I think it was with the first patch, but not sure) had some
> conflicts but 3-way merge was able to automatically solve them. Please check
> the end result anyway:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=77adda81e264e0c93af9570ac4ada82a5d0f5d99

I see the same. There were some unrelated changes to this file that
you merged to your pending tree in the meantime. The end result looks
fine to me. Thanks for the heads up.

Brian
