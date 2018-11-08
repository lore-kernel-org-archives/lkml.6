Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D32CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E1220818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q0BtwzS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E1220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeKIDIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:08:37 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33516 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeKIDIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:08:36 -0500
Received: by mail-it1-f193.google.com with SMTP id p11-v6so2342699itf.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 09:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdYF3WX3GJAY0kanvw201TBbKXMrlke2gUcOPt/8g8c=;
        b=Q0BtwzS9i0uXnSMZNmNl8gwVXuSQbdCrM8x2W8oYKA4/XBi02mzkXWg+GdsDS61dz7
         N12JEEoas3U0c1dZ/eRnN8cHJgB8GgDV4ol9SPH0Cs3+Ha7X+RMB2RNCcisBd5LMMRUS
         hjNLY0GgTI+TxRyd+p3SaCm+Odt91x2OuzMws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdYF3WX3GJAY0kanvw201TBbKXMrlke2gUcOPt/8g8c=;
        b=kTazzlIZf5n729sU19mABBDw5IU62ahdxx2cSfKyxzhocLf/JbAq9ItBTd90ipfdfi
         RE3fGXFrF564sO+WzrDcNfyWHV73/yADLkio1Esej66pLIVgvHXDBsXf4R3iEOKv5XnX
         JCVily5J2uh31WcHoywwCwXoLspNDufZGwG5/1uSy01k39uRSP2BeNUKfqXD67ZZh1Af
         hASSZq0J872FPz7KzkGKzPP9Blf0VqG682u9fkoqVdnaOm2b1cKicFBVeiVatsQ5YVeF
         M1u7aKjMRYJkygeHUC++sW7zZPR6Qftj6EAKQ5YRxmEUCBpXcq4/tEe0CKOh/hbrVw/v
         KPqw==
X-Gm-Message-State: AGRZ1gIH3rt5hs583psGTOoaNYylUHj6s8Nb4B4gfg6fL3Gp1OJGP6Xn
        BUL/IZ5QZW+DASZNs4Q9jRpnjIHTQGE=
X-Google-Smtp-Source: AJdET5d9biBFG1ffBkp4MAMZZhVTFPFalRBofy7MCdjWicge6yzWJpZvZzk3XoIqBfqt8ykF3b3BcQ==
X-Received: by 2002:a02:a98e:: with SMTP id q14-v6mr4879559jam.109.1541698324837;
        Thu, 08 Nov 2018 09:32:04 -0800 (PST)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id h137-v6sm2108517itb.39.2018.11.08.09.30.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 09:31:30 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id d80-v6so15241816iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 09:30:58 -0800 (PST)
X-Received: by 2002:a6b:d541:: with SMTP id x1-v6mr4659579ioc.113.1541698256286;
 Thu, 08 Nov 2018 09:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20181107185643.240346-1-briannorris@chromium.org>
 <7f2ef494f4a2aba1845a157da8fec449@codeaurora.org> <b1a64bd66fa25f274af8c018c6fc02f4@codeaurora.org>
In-Reply-To: <b1a64bd66fa25f274af8c018c6fc02f4@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 8 Nov 2018 09:30:43 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOqJ1-G2amyu7sJCnzKf1oY_2j9Qw4WS0VTf8EqGr6Uqw@mail.gmail.com>
Message-ID: <CA+ASDXOqJ1-G2amyu7sJCnzKf1oY_2j9Qw4WS0VTf8EqGr6Uqw@mail.gmail.com>
Subject: Re: [PATCH REGRESSION] Revert "ath10k: add quiet mode support for QCA6174/QCA9377"
To:     govinds@codeaurora.org
Cc:     rmanohar@codeaurora.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        yyuwang@codeaurora.org, pillair@codeaurora.org,
        stable <stable@vger.kernel.org>,
        linux-wireless-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 8:32 PM Govind Singh <govinds@codeaurora.org> wrote:
> On 2018-11-08 03:00, Rajkumar Manoharan wrote:
> > On 2018-11-07 10:56, Brian Norris wrote:
> >> This reverts commit cfb353c0dc058bc1619cc226d3cbbda1f360bdd3.
> >>
> >> WCN3990 firmware does not yet implement this feature, and so it
> >> crashes
> >> like this:
> >>
> >>   fatal error received: err_qdi.c:456:EX:wlan_process:1:WLAN
> >> RT:207a:PC=b001b4f0
> >>
> >> This feature can be re-implemented with a proper service bitmap or
> >> other
> >> feature-discovery mechanism in the future. But it should not break
> >> working boards.
> >>
> > Brian,
> >
> > The change "ath10k: add quiet mode support for QCA6174/QCA9377" was
> > merged even
> > before full WCN3990 device support was added in ath10k. How come it
> > could be regression
> > for WCN3990. I know both are sharing same WMI-TLV interface but
> > reverting this
> > will break QCA6174/QCA9377. no?

I don't see how the revert would "break" QCA6174 -- QCA6174 worked
just fine without this feature and should continue to do so.

> This regression is found while we switched from 4.18 + WCN3990
> back-ports to 4.19.

^^ What Govind said. WCN3990 support has been trickling in over a few
releases, and it doesn't seem kosher to allow people to submit
regressions in the midst of that.

> > I would prefer to handle this within WMI callback or upper layer.
> >
>
> IMO, we should use (WMI_SERVICE_THERMAL_MGMT | WMI_SERVICE_THERM_THROT )
> service bitmap check and call
> ath10k_thermal_set_throttling only if fw supports THERMAL THROTTLE
> feature. But we need to ensure all
> available ath10k fw's are reporting this service.

And the above notes from Govind highlight this -- if the feature was
not protected by the appropriate service flags, then we can't be sure
that you didn't break a bunch of other firmware releases out there.
Linux should not break for everyone just because you spun a firmware
release.

Of course, I'll leave it up to Kalle as to how he wants to mediate
this. And if you come up with a solid patch soon that can fix this
without dropping the feature, then so be it.

Brian
