Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B30C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8272081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAsChPpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8272081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbeKFQw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:52:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45379 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbeKFQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 11:52:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so8043022lfa.12;
        Mon, 05 Nov 2018 23:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4DS0e1/Mx7JE2alqTDAlfQ7FsMrVaa/GA9priE5a6/U=;
        b=FAsChPpmmQXC3L0uJan3VFsPlIQ/1eJhSnG1zSxmBcouejDuf82yWvrn2QDXslBxit
         HPDK+o7FjhvlyL0wPmiSatZJTESIJjJrgdI5i1p6DOUBWpLoTIfJ9Ik1OcoFmMRHTp3G
         Z/IsADYPvBmsCTnrnXUP4azseRyu5G0pW2kUsocLW978uHTuzuw40HaFHdeaQ2O7Fa+b
         yjL74ebUIjyifu7vQIB68CdhNYpoYydQKkxho5p4DtguA1c3QKF0XAhTaRpIwZ6ritzt
         z/cgMZieYvlzSBBcUtPzTtco6Td3v6TQNaacBN1F6rl+p8t4HX4xiQgbYYLCXH/iVmOy
         OlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4DS0e1/Mx7JE2alqTDAlfQ7FsMrVaa/GA9priE5a6/U=;
        b=YspT3PF2AkBXNfT6by5aBdv/4JZaBVbCz9L30LQizw9+0f8Z165UlXjs7/qzCg7uGI
         uZ7DAUMK7q+lW3/SX1wEq2+c0wv9c61aigzJmjFBczmzyhPblF2Im8+uxDW+T4+phD5V
         dINJwmIganKaWtt98Kp0+w1uKaZUWRV2HWylO04C+kN67NMskn/83dL3E672C/UQfMxs
         qzed9/BcHin7GzYigWSvviuoMzIqyTk31y+Y5izQAkVZohSyOK1DvtkHpMFYaKn23xES
         F+ji3aA4uP8tWYhdb2luYCs0fFfPChZ1GTAUD+GPHfBl1uLxi4XbTUiPDEGfdkhbPjpE
         1ymA==
X-Gm-Message-State: AGRZ1gIusq+VMc5kIVG3m8sVriIWYemjZToMB92CXO/iFrO01P5O15QG
        pE70Xuw6HHzisfx88OK+kTmS3w8Szh7KqPJkbes=
X-Google-Smtp-Source: AJdET5cL8gvm7QeXo9hPunN38WdfX9v8fWFAcfGZ0H/uHfPcICd4Z7x0WdZrYF4IV5bVBLeLCSjcCzNKwrM5r0bCs6g=
X-Received: by 2002:a19:2a4b:: with SMTP id f72mr13561663lfl.139.1541489341895;
 Mon, 05 Nov 2018 23:29:01 -0800 (PST)
MIME-Version: 1.0
References: <CAAGb-1fPZsJRqa4C3zDiatqE2sPAV8m-pGBoG+z=3nAd+Koj-A@mail.gmail.com>
In-Reply-To: <CAAGb-1fPZsJRqa4C3zDiatqE2sPAV8m-pGBoG+z=3nAd+Koj-A@mail.gmail.com>
From:   Jack Wang <jack.wang.usish@gmail.com>
Date:   Tue, 6 Nov 2018 08:28:50 +0100
Message-ID: <CA+res+SDaTwjkKQpnREP1dW8XmtQsk7NGLj=heYGbGeL3Dr-OQ@mail.gmail.com>
Subject: Re: BUG: aio/direct-io data corruption in 4.7
To:     shapiro.gregory@gmail.com
Cc:     hch@infradead.org, jnicklin@blockbridge.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregory.shapiro@kaminario.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Shapiro <shapiro.gregory@gmail.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=
=885=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:19=E5=86=99=E9=81=93=EF=
=BC=9A
>
> Hello, my name is Gregory Shapiro and I am a newbie on this list.
> I recently encountered data corruption as I got a kernel to
> acknowledge write ("io_getevents" system call with a correct number of
> bytes) but undergoing write to disk failed.
> After investigating the problem I found it is identical to issue found
> in direct-io.c mentioned the bellow thread.
> https://lore.kernel.org/lkml/20160921141539.GA17898@infradead.org/
> Is there a reason proposed patch didn't apply to the kernel?
> When can I expect it to be applied?
> Thanks,
>  Gregory

Hi Gregory,

Thanks for your info.
Have you tried with latest kernel other than 4.7, is the problem still ther=
e?

Could you share your test case?

Regards,
Jack Wang
