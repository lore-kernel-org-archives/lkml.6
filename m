Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFE4C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D6220846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOYY9Psl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D6220846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933129AbeFULfZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:35:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52293 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932949AbeFULfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:35:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so4620510wmb.2;
        Thu, 21 Jun 2018 04:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QV7ktrao0ufzn45bQDvyr2JXCsXqE/vOsoJ9a17nLec=;
        b=oOYY9Psl1mQIwkl6vtGhwwbIC6lBRhpfclq4yN0za35ROWukfiTlZgKDJ9OFkIWD7d
         j4GShuf9CkiaZEhJR9NR+Omk5K5nd4A7txjt7/kfUjFcyfkrRcTNp8bC6ph/ZJaU+wm8
         6ib4m3MRCFq8/MCo1cgyZvM37mdZMWB5YBjwQDZhR+EKzaVJVoyBKCBZgnBvL+O5Bn76
         aVV81kdz01JN1YJmoVVuotJTizeCG9pP1nQ68vsz+L4oEBE1+zkpuvLvWgd3m5gqdguL
         HO2aK1dOzbLMHwgEA4EG+xylPo5ThF+CNwthacakQmtauThyKL7ObrH3/6KLPDAAjLia
         Mw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QV7ktrao0ufzn45bQDvyr2JXCsXqE/vOsoJ9a17nLec=;
        b=RBrhykWCT+m4SfNZ8um1QZvkkIYqhh3vJ6L3XnpctBGvh2g3W3KCr2tZbpmxdJB1s/
         F/f0rbr6zBiaiO1XZaru6aBRfue8iv235keXuRqmZtF7Me/MwT/viw5yZK5vcQokCkBZ
         toBqL4KD01KFNTR89lv71ET7/uUDaeTAxnRvz3BkWM5fDxO1GRWEIEsuX824Gy460wSc
         v7vTwH+K5EqVDGDbP+kvA5cL1hOWVrQ0RzeyFyJGi6Q5GpEbk9zX+isu868spEtXMAiD
         6FQNDheL8vz6CMVdgdgxcmzZ9PiReF4BFLOcE5n25B1gwXnrONBTSHAcE6hTYFM2Iy/5
         3rCg==
X-Gm-Message-State: APt69E2i/CPl0az3I+Jol7rUAX1FLUlYz1wzuErI3LwerNrYdksoM4b0
        i8AXz0wKAA/AivUhR4OpDq5bsNaKTQS+ewYDFt8=
X-Google-Smtp-Source: ADUXVKKJG3JOF3gaKzLhz6gkcd8XrA11Ro2sdOIh2WOMlI9ji1oyraRdUlOHX2m3mW31cbm+FrqIQ3xfGzcARApNSUY=
X-Received: by 2002:aa7:d299:: with SMTP id w25-v6mr21329248edq.13.1529580922104;
 Thu, 21 Jun 2018 04:35:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a1c5:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 04:35:21
 -0700 (PDT)
In-Reply-To: <20180621113031.gv53yv3g46uaetwm@pali>
References: <s5hk1r01acc.wl-tiwai@suse.de> <20180615190959.pqipwnm6a3tf3lxc@pali>
 <s5hmuvvtdmi.wl-tiwai@suse.de> <20180616154309.ualrx2py6ndr5xgz@pali>
 <s5hh8m2u3cp.wl-tiwai@suse.de> <20180618102806.vwm4rhvxhn6hi43z@pali>
 <s5ha7rsz8i8.wl-tiwai@suse.de> <20180618112121.cl76a3oozsbbbqnb@pali>
 <20180618112618.hcwiacfzzu4swwd2@pali> <s5h1sd4xg3t.wl-tiwai@suse.de> <20180621113031.gv53yv3g46uaetwm@pali>
From:   Damjan Georgievski <gdamjan@gmail.com>
Date:   Thu, 21 Jun 2018 13:35:21 +0200
Message-ID: <CAEk1YH6-b3HtBN335XNxeYRWCCsBm52kC95_EZH3B4G-_TP5Pw@mail.gmail.com>
Subject: Re: [ibm-acpi-devel] ThinkPad T480s & LED_MUTE, LED_MICMUTE
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, ibm-acpi-devel@lists.sourceforge.net,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I applied them to Debian's kernel (with slightly modification) and they
> are working fine. Via "alsamixer -c 0" I can change "Mic Mute-LED Mode"
> to "Follow Capture" and then led is ON only when microphone is ON.
> Recording from microphone is working in both configurations.

hm this is the opposite of how it works on my T450s and X1, where the
led is ON when microphone is muted.
(I do wish the led would be ON when the microphone is not muted ie. listening)



-- 
damjan
