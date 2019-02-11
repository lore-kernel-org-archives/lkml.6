Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776D0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EEF21B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQ2AJskV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfBKQPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:15:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38833 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfBKQPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:15:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id v26so17892488wmh.3;
        Mon, 11 Feb 2019 08:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=H7yfy1o+RpuXfDtk8j+KsO/uzl/JEpDRaJbGio8J5J4=;
        b=fQ2AJskVbNA2cLKHz6/NUMEaJ0cBTemdjhrIHpH/New/czeq8Obi+QGCMG0+7W7r1S
         AxyP2C1I36f7iGxc4rs4xfP/ojDsQEUru0C3w6X94s1mkFiwOUPDk2muxsr+8j3PAaMv
         BbloIx+LzorT44ok3V8vZvdT8ovBZzpASu1tMqT8bR0E00BfiTXmX7br0k6RutQBd5Ny
         Iiyhw61MNV59macj4O4Zydrf+qv91BLY9xs7Y4sidIaJz9I8QSmfLZ8KAtyIUBG1geC7
         rOJtoMWG38R2itMohtYRKl9OMyVE/eH3t7BdW8q3ZdonREIFKm7+jKFcVyfvns06/DMh
         dTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=H7yfy1o+RpuXfDtk8j+KsO/uzl/JEpDRaJbGio8J5J4=;
        b=i0I9I09EeFBSNd0ooqnikGqfEBtJKrzzFNznF1YASie29aAv4hB/iXS9ey1SDXcaB6
         vAbIFspWUzGHV2rU1Wel2KP6Hpcqd5SP0VnQzFPDrFvLSuMUcGJwCk5bn/R+KYrclhj1
         7HuzT0jA6j9LPXA5HyS9kTP+iFTTQM/3kWw0df85qIjgLGEuIYTvHyglslMBHO84i3s+
         hT50UQCI06USaN6dm1QNss+N3TUwhjvvWm5sOegRo+8f2VLK2xIe3vftY1r2BPswPaNP
         fFwrj+GsPHBTgbQQTNDzZhalUwsj1zaQ72+Utw5PkzskqEq91zGlgAfOaAMSS7+CKXuZ
         cDrA==
X-Gm-Message-State: AHQUAuZ6GIpncdh9czNZsxn2TR+i+5LQyZeKvi0wmAXpfLgqWpxP4acz
        2BU/VKBZs7HKiWgUW1317Z0=
X-Google-Smtp-Source: AHgI3IY/wTj3QxusPROn9DEgTX2RMn5pjTh+MPKP3XyJHcH69xe2xUmaOzvGLSuEAgtlH/jUauQgPg==
X-Received: by 2002:a1c:99c3:: with SMTP id b186mr175186wme.79.1549901746609;
        Mon, 11 Feb 2019 08:15:46 -0800 (PST)
Received: from [192.168.1.100] ([93.51.16.173])
        by smtp.gmail.com with ESMTPSA id k2sm1665050wmj.45.2019.02.11.08.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 08:15:45 -0800 (PST)
Message-ID: <b45065a61ac79add6dfa9d63131faf6f3761cb6b.camel@gmail.com>
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
From:   AngeloGioacchino Del Regno <kholk11@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Date:   Mon, 11 Feb 2019 17:15:45 +0100
In-Reply-To: <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
         <20190211105755.GB30880@fuggles.cambridge.arm.com>
         <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
         <874c702b8af760aa8fae38d478c79e3ecba00515.camel@gmail.com>
         <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno lun, 11/02/2019 alle 14.59 +0000, Marc Zyngier ha scritto:
> On 11/02/2019 14:29, AngeloGioacchino Del Regno wrote:
> 
> [...]
> 
> > Also, just one more thing: yes this thing is going ARM64-wide and
> > - from my findings - it's targeting certain Qualcomm SoCs, but...
> > I'm not sure that only QC is affected by that, others may as well
> > have the same stupid bug.
> > 
> 
> At the moment, only QC SoCs seem to be affected, probably because
> everyone else has debugged their hypervisor (or most likely doesn't
> bother with shipping one).
> 

Between all the ARM SoCs, as far as I know, the only (?) ones using
actual "smartphones", so actually provisioned SoCs, for upstream
development are using Qualcomm SoCs.. of which, some development
boards are not entirely security enabled, or have got newer firmwares
which can't be used on production phones etc, so.. that's why I said
that I'm not sure that only QC is affected.
It's just relative to what we currently know, but looking at, for
example, MediaTek, I'm not sure that the only bugged hypervisor is on
QC (because MTK is very similar on certain aspects).
I mean, it's highly possible that some other is affected and we don't
know (and we possibly don't care...).

> In all honesty, we need some information from QC here: which SoCs are
> affected, what is the exact nature of the bug, can it be triggered
> from

It'd be wonderful if Qualcomm gives us some information about that.
Would really be helpful and nice from them.

> EL0. Randomly papering over symptoms is not something I really like
> doing, and is likely to generate problems on unaffected systems.
> 
> Thanks,
> 
> 	M.

I also don't like "randomly papering over symptoms", I totally agree
with you on that... but this change potentially generating problems on
unaffected systems is something I don't really agree on: this is a
partial revert of a commit that was done purely to introduce some
vmlinux (relatively small) size saving on ARM64 and no other reason
(as far as I can read on the original commit), so I really don't think
that my partial revert could ever harm anything.
Though, this is a personal opinion, I can be right, but I can obviously
be totally wrong on that.

Though I have to make this clear: if there's another (better/cleaner)
solution to this issue, I'd be totally happy (and, of course, curious
too) to see it!

