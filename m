Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE13EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824AF20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SjCPQzes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824AF20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbeJWS24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:28:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43457 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbeJWS24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:28:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id p34-v6so644500lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2qTwb6SxT5BWJgH95AmL+ULCfxhvOZEGfAIGGOjP0Q=;
        b=SjCPQzesgrW9Iskbo0A1vFRYemVAIFutyKdPAI3aBaBt9OyyORvtCMKMrBcAFtQcc/
         8gHxDG4+PGWGRThF/kQ276OagP63xKCogvIGYxzwKrUuQGtCB4MyIcxilP+rQztCLvkH
         gY7vEDeS+y4fInAnxyi0uSzQ0DPHJ1I4Br0IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2qTwb6SxT5BWJgH95AmL+ULCfxhvOZEGfAIGGOjP0Q=;
        b=MaZA78yzdBWpiixR7ls4YcOXE5tKtC3TOUcmpQQnh9/8FY+nLjYBLgNiSWOJg5W1mm
         4KmxY9vUKkE4r3RT9Wla6jEx1dTih2P+y06VDBWTghmTrv+qg1yEuZy+8AyNYixOBtIZ
         NxnjJ4DxPtQKKpLASVkV+QhXMOAmW6CEajGpgS0YXT0KF1kvGZVHFCUvLbGBRurabnd6
         difSAHWUm4LUlr0U6qm0VXk0rpXRzfu9YF2lFYAdmznC/JCXyuHQraMkBJ0AnP8ZCGFf
         U15cYSPGc5IIl8dei0sMD5Rb6Ft8G+sDWstsu1hM9fmEaVm0e1g76HEMUeiha+fAnZg/
         X/7w==
X-Gm-Message-State: ABuFfojVA2YE9hOy74hpRInI1Js1Q7G5HqziM5z2OslYl2yjVCM0x7vw
        DbsoQnpps76E9j9piS7fWRsPA7l9KVa0iFch
X-Google-Smtp-Source: ACcGV61LGuhy/AdyaWtqBbe6dr7bpIn7am2jqAEHJsnjeO+qvl1CBsOlXIMydoAh72AQEIdPomB5jg==
X-Received: by 2002:a19:5349:: with SMTP id h70mr10553782lfb.24.1540289171236;
        Tue, 23 Oct 2018 03:06:11 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id i16-v6sm149716lfj.18.2018.10.23.03.06.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:06:10 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id x24-v6so657227lfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:06:10 -0700 (PDT)
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr12432755lfc.147.1540289169808;
 Tue, 23 Oct 2018 03:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181022193304.GC20677@dhcp-10-175-29-12.vpn.oracle.com>
In-Reply-To: <20181022193304.GC20677@dhcp-10-175-29-12.vpn.oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Oct 2018 11:05:54 +0100
X-Gmail-Original-Message-ID: <CAHk-=whKtd8WArFUjBmszD8-+t5BbbVOwUYqWvgRn49g=f-dpg@mail.gmail.com>
Message-ID: <CAHk-=whKtd8WArFUjBmszD8-+t5BbbVOwUYqWvgRn49g=f-dpg@mail.gmail.com>
Subject: Re: [GIT PULL] (xen-swiotlb) stable/for-linus-4.20
To:     konrad@darnok.org
Cc:     xen-devel@lists.xen.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        joe.jin@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 8:33 PM Konrad Rzeszutek Wilk <konrad@darnok.org> wrote:
>
>   one tiny fix for the Xen SWIOTLB mechanism that occasionally happened with
> devices that didn't allocate size in power of two but rather some odd
> sizes. We neglected to make the memory coherent leading to all kinds of fun crashes.

Pulled,

                  Linus
