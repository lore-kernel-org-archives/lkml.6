Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F00C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0DE20813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PxIoJz4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0DE20813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeJXDAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:00:50 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:32926 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbeJXDAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:00:50 -0400
Received: by mail-ua1-f66.google.com with SMTP id j13so903474ual.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gRwRnowQUdebqJquGJ2dlNqPe6oRvqB59+nwpcwBaeU=;
        b=PxIoJz4Hdri5js2L5BmhOC17lToXCZYKBVIFVqB7uVmV6kRfeVCkmRw/EWvA7irKbB
         zUIP3n3qbvhOrHOdLT8j4Vc4YJb6ws29ouydJno4IWDu6jxD2c6he02lhNuVdjMq0kSq
         K8Lab7g4PJUWPWTZjGOKRoIl/osaBMJ9gJ6tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRwRnowQUdebqJquGJ2dlNqPe6oRvqB59+nwpcwBaeU=;
        b=KjBdYup8a3AdR0WqMvd0SVbheoth31w9LDlgWRA2ULSaWcb9iIe88qID2eFOlSCyRm
         Oim8CHuE3xwuzF+9Y2xT+P09+9QRDknW2BrdlFCIwbG37oWpOFo5SgYSLcEgtqCgQ6PQ
         e/xyrF+IsuO/IBG9BlEDEEMfPBQu/p/y9fI+LeEVxD32p5iYxOPshvzlVH/5zyoHL1pr
         pdeL52vEmD53wsIGZHHwSUUEzd2X3x2k4QEXoR+O4/pFOOsYaGEf3jXO8ZWdUdTZq4md
         75Gs2wS6uVFz5f9SqGxxTEz9jhlmRvcF9+umW6KdBe8jvSdn+1j4xoOtu62XyhnRIFKQ
         BagQ==
X-Gm-Message-State: ABuFfoiTzL8tdgLfxv2EeheTH6dNiNqAwXjFm5N0OS2svUA2jg7zK2Wk
        Y2SOuXPr/YmsESkIjgQqxKAiiEi1Q8c=
X-Google-Smtp-Source: ACcGV603Ol4HaMIlHzIXs6sdNMIthUFBrt9Ovye9Xpb+Zq2uvm8+w0OveZjJOMWlgPxM7WehwQfEcw==
X-Received: by 2002:ab0:5c61:: with SMTP id a33mr22064648uag.59.1540319776449;
        Tue, 23 Oct 2018 11:36:16 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id i10-v6sm469905vke.41.2018.10.23.11.36.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 11:36:15 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id l6so1508714vsj.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 11:36:15 -0700 (PDT)
X-Received: by 2002:a67:b20e:: with SMTP id b14mr20587054vsf.121.1540319774697;
 Tue, 23 Oct 2018 11:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <1539622953-4188-1-git-send-email-rplsssn@codeaurora.org>
In-Reply-To: <1539622953-4188-1-git-send-email-rplsssn@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 Oct 2018 11:36:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XB9diR_n1TB4+wUjVaRf0VAmCMgkSbtuOSNO5pkrQ8zg@mail.gmail.com>
Message-ID: <CAD=FV=XB9diR_n1TB4+wUjVaRf0VAmCMgkSbtuOSNO5pkrQ8zg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add PSCI cpuidle low power states
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 15, 2018 at 10:02 AM Raju P.L.S.S.S.N
<rplsssn@codeaurora.org> wrote:
> +               idle-states {
> +                       entry-method = "psci";
> +
> +                       C0_CPU_SPC: c0_spc {

nit: all these nodes should have dashes instead of spaces in the node
names (labels can still have spaces).  AKA:

C0_CPU_SPC: c0-spc {


> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x40000003>;
> +                               entry-latency-us = <350>;
> +                               exit-latency-us = <461>;
> +                               min-residency-us = <1890>;
> +                               local-timer-stop;
> +                               idle-state-name = "pc";

It seems weird that the idle state with the node name "spc" has the
name "pc" and the idle state with the node name "pc" has the name
"rail pc".  Can this be more consistent or is there a reason why they
need to be mismatched?

Also: AAHTUFSWDKWTM (acronyms are hard to understand for someone who
doesn't know what they mean).  If you really need to use an the
acronyms "PC" and "SPC" please document them somewhere.  In the very
least the commit message, but having a comment in the file is good
too.  ...or (even better) don't use the acronym and spell out what
you're talking about.  Please correct me if I'm wrong, but I don't
think it's obvious what the "PC" and "SPC" idle states mean.


-Doug
