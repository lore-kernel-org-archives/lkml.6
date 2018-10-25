Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8981EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA132075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dZMi7eL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA132075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeJYV5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:57:48 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:33450 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeJYV5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:57:48 -0400
Received: by mail-lf1-f42.google.com with SMTP id w16-v6so4668037lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n0XiY71BQA5IW19+FY0R2tz7wOgs0cKLrpImNJZtMWs=;
        b=dZMi7eL0nZKPoKX5RcOxWSVQWUZF+2yQuIZAl9z7yM4nkMIV3k1ChFKtniYy6ngvgC
         8P8Gi0AWshvFLPmCslhdvy+/YExuntkipuy+oxdn7Et9j1EEy02Rp/YU924k36fNWe6S
         PCFCn9mA3W3TSPH/RV+zcV2hLM2THTzlLO1GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n0XiY71BQA5IW19+FY0R2tz7wOgs0cKLrpImNJZtMWs=;
        b=p3o8AfbrHuPQtSJC92e9M32cjxEWvAn8MZzVeLQXVtZacF/y1LnLiW688KQxI5gRa7
         zLd0TMxV5+A68rhe0UHooXIr01ajJj2rbZ81WC1NOcbOS0BuzRJewIoDniZ3ZiZMNeLy
         OrNInUGEfSbDj64+YLk0VfAW3Spc+jJgBt/jK4nqeeOGZ1F738PSUIqMWFkrUtcpEaoF
         1aiS9sKd65wQpGn4PXvdXU+HkLfv4PKuO9Dv2tpSmu3wiImv9Ghph080vj4yDpsmlEom
         9PlNSpwjsfSVqzpYHB9R+NaWLFmkvsLPhOhCzw3MfBDXAsW6TKEdvFmPa18+wSFXg5Cd
         77+A==
X-Gm-Message-State: AGRZ1gKMB+brckvg9bFJhzv8kzu4+n/gCqrbkzRidlqj4MUypu0QDadn
        cDdTm1bWtJ/7o5revZHJjx9/d3n4Dd4HJhX5
X-Google-Smtp-Source: AJdET5ea/HLIGLMx7xa0RBfnwB4PZBSlfGiLKOcwXfP3tpLjGcAE5nhwzj+FuDDyIEHIZ/V/w81eqg==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr1233451lfb.72.1540473901736;
        Thu, 25 Oct 2018 06:25:01 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id g72-v6sm1254080lfl.21.2018.10.25.06.25.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 06:25:01 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id o14-v6so8225054ljj.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:25:00 -0700 (PDT)
X-Received: by 2002:a2e:7f14:: with SMTP id a20-v6mr1253773ljd.148.1540473900376;
 Thu, 25 Oct 2018 06:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1810231337400.23511@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1810231337400.23511@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 06:24:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMd0G3qJybMapew1=zxR1obJ8kTR-EXkmO6Lhe6Gu_FA@mail.gmail.com>
Message-ID: <CAHk-=wjMd0G3qJybMapew1=zxR1obJ8kTR-EXkmO6Lhe6Gu_FA@mail.gmail.com>
Subject: Re: [GIT PULL] HID for 4.20
To:     jikos@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        benjamin.tissoires@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 4:43 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> - rumble support for Xbox One S, from Andrey Smirnov
> - high-resolution support for Logitech mice, from Harry Cutts
> - support for recent devices requiring the HID parse to be
>   able to cope with tag report sizes > 256

Pulled,

                Linus
