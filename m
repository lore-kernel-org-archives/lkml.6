Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD60C5CFC1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955BF20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cREPv35K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955BF20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbeFRCd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:33:56 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:37207 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754426AbeFRCdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:33:54 -0400
Received: by mail-qk0-f178.google.com with SMTP id j12-v6so8616430qkk.4;
        Sun, 17 Jun 2018 19:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/WjzpAZkEAk8bp8eJ3LmXeo1shXlK6zbo53o2vdU2Dg=;
        b=cREPv35KXvUcdc9MYh6v3AmZs2CLDn0+4x/q25bJKhMAkRuMhYNpqoN+kZ0Du1PV+X
         AYVEVDL3U7JZ1PqAsz1j4fB23+AKTvKXouBi910eqDkDfo5rEKKxo2nq8OZu6ifRnPCj
         rlfDmR813ojVwpEJztFgNQy8SlELerQslGezCrGitHwfxoHiL77mLqgbDoOTXtkVYG1u
         l8+iFQe56doZtewlChhao3RvWmj075KwITTw1B0T8wYr/4LVB5r3MHWApF5qZzGG3ot5
         Q0vO9T4TeKlBKJaBVrUrnTEIfYvCAnqC+aVb/tpGXX6/dzDINBFUblXu1RO4XIkpDVhl
         mH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/WjzpAZkEAk8bp8eJ3LmXeo1shXlK6zbo53o2vdU2Dg=;
        b=WZL5ugum0V16jzhBOlIeczUa++WV0p5ncLS8fbwl4ad6FJg/SWASytc6CVTjeI+CrI
         5z40IhuwVD5m0AxbYhmOvLHLxN740s2YB1lTRRx2jSlXjHQ3qqmkHBpbbaeLotEuDt97
         epYJLdh2ycvjBe+4+glsHm62uBjkJE36hUIktOb4T5LFr++Q332Sujlm33trAu0qdzr4
         MlPbV/mro+Nn6N+kE0OEygs/cuuymek/wGuGwYcJ0pBL63lbULmdz/olZLLEOmYhZEux
         GC/JERSnEz7ACx6Q5FxtGOcxIDL28F995a3bqGBNbnwuXouZf1x9teq9Rw4EUzcBsnxx
         U5pQ==
X-Gm-Message-State: APt69E3YAubQ1oEnpFn9DVdegPLu4giAA5SAh0ea95wugIXiteCpG+Ov
        mPIAibc3UW7sXvF3vMaqhzo1H/0SQlekOvdlhpA=
X-Google-Smtp-Source: ADUXVKICNkECmTMqNEzb/MPt50J634gBDccwi39psEiTUX7zjC+Y0o1yj0KMY16fbKljAqAIooDPs3PNRX+kZWZjIwI=
X-Received: by 2002:a37:5e46:: with SMTP id s67-v6mr8622637qkb.202.1529289233452;
 Sun, 17 Jun 2018 19:33:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:3f3d:0:0:0:0:0 with HTTP; Sun, 17 Jun 2018 19:33:52
 -0700 (PDT)
In-Reply-To: <20180617110200.GA19216@kroah.com>
References: <1529163551.16103.16.camel@gmx.de> <20180617093607.GA27652@kroah.com>
 <1529231886.5303.6.camel@gmx.de> <20180617110200.GA19216@kroah.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 18 Jun 2018 12:33:52 +1000
Message-ID: <CAPM=9tzkKWM2wjeQvWG2qKM-xgFwGD3bjWfgmDUDTQO+tXF-ig@mail.gmail.com>
Subject: Re: v4.14.21+: ATOMIC_SLEEP splat bisected to 9428088c90b6 ("drm/qxl:
 reapply cursor after resetting primary")
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mike Galbraith <efault@gmx.de>, Ray Strode <rstrode@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 June 2018 at 21:02, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sun, Jun 17, 2018 at 12:38:06PM +0200, Mike Galbraith wrote:
>> On Sun, 2018-06-17 at 11:36 +0200, Greg KH wrote:
>> >
>> > And if you revert that patch, does everything work again?
>>
>> Yes.
>
> Great, Dave, care to revert this in 4.18 so I can queue up that revert
> in older kernels as well?
>
> thanks,
>
> greg k-h

Hi MIke,

Does
https://patchwork.freedesktop.org/patch/229980/

fix it?

I can queue up a revert asap, but since a revert just brings us back
another broken behaviour, I'd rather we just hurry the fix up.

Dave.
