Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5643DC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D630208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dbHWiMN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D630208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeJPEtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:49:23 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36047 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeJPEtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:49:23 -0400
Received: by mail-yw1-f68.google.com with SMTP id e201-v6so8080027ywa.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6faCqweIkuTWy5VU4l9YjjoSOf4LuGQCWjJ4IVAY5yw=;
        b=dbHWiMN2/YHcsez8K5Rce/ADXqav0rxd7GAEoYm9LL7gNmDAy78x+abikITBntL6ax
         u1wuyyaUYtZRLCBomsP9eS3lhLtpnInQhr35XQZ+DfvaIjSGUzi6UTbfueJIKFTd7KzQ
         auVQxipT5x5JTLIg085cEJoR6CBb4Jl/0L33M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6faCqweIkuTWy5VU4l9YjjoSOf4LuGQCWjJ4IVAY5yw=;
        b=QINo6rmtbigCh0zr43/5AX/NQbQxvxRNMkz6L2mtJgZmT2rspBXaUGFsd0q1y0NZ+U
         MA0AVJ+oruVPX9SNOnK9VhrtbIfYSyzwx7gCeZJZhMMUlpENsFCWQEL6p2mrxPHms7RA
         ZiOQZfv/iCZr8rrk2bPNiY+w5Z0lVgwn46JAnMx3X3Tggw/BODD4N02q06XN6N73GdKc
         hKDL8SWC9vyj6XBMcWOQRRcOTpswxh2GYkzrn97J8zVIl06qRcreU1fwkwcBXZ3vEjMX
         +t+rfXwRZWULlFUXujRn4/cd1fu2YjO5Y9QGgcW7rtIDAeVSgrNfWoiXCK6SaUHzh21i
         ++vw==
X-Gm-Message-State: ABuFfoh1SUnujEhwxbCYpev2NHAQABvfGdrtXZSWxGq3YsEvRdX5rxJ5
        LUp88cUY7LuyEsTvSjZ3oi5kK+ZSurg=
X-Google-Smtp-Source: ACcGV62S5ewm/cRMOfEQlRKH6TN82YHt18RMskDxyp2XZjK0If+PGBzH5nZXuMg2rpiF7FqoYGuKUQ==
X-Received: by 2002:a81:4a55:: with SMTP id x82-v6mr10387315ywa.3.1539637345819;
        Mon, 15 Oct 2018 14:02:25 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id j8-v6sm3202589ywa.17.2018.10.15.14.02.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 14:02:24 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id j75-v6so8070168ywj.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:02:24 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr10273753ywg.353.1539637344226;
 Mon, 15 Oct 2018 14:02:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 14:02:23
 -0700 (PDT)
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D40E4F6@ORSMSX107.amr.corp.intel.com>
References: <1539202053.12644.8.camel@HansenPartnership.com>
 <1539202180.12644.10.camel@HansenPartnership.com> <3908561D78D1C84285E8C5FCA982C28F7D40E4F6@ORSMSX107.amr.corp.intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Oct 2018 14:02:23 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKKK76KRpujbudHQWwtcRHSKEQwBeGMBJf=31WjdCJA4A@mail.gmail.com>
Message-ID: <CAGXu5jKKK76KRpujbudHQWwtcRHSKEQwBeGMBJf=31WjdCJA4A@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 2/3] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 2:04 PM, Luck, Tony <tony.luck@intel.com> wrote:
>> the enforcement clause of the new code of conduct.  Since there is concern
>> that this becomes binding on the release of the 4.19 kernel
>
> Is there some logic behind that concern? What's magic about the release
> of 4.19?

Greg KH said 4.19 was going to be the next LTS. But, regardless, if we
view bugs in the CoC as "just bugs", then can't we also include their
fixes in -stable? It'll land in 4.19.z just like anything else. I
don't think we need to rush anything into 4.19 -- as so many others
have said: it's in our best interest to take the time to get the CoC
right.

-Kees

-- 
Kees Cook
Pixel Security
