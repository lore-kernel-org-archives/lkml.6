Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22301C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3F223C71
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQfITfiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3F223C71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933578AbeGCIeh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:34:37 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45096 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932471AbeGCIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:34:34 -0400
Received: by mail-pg0-f67.google.com with SMTP id z1-v6so627622pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O3/IEoJuHM99uBghCekOnF9P7irem72rUYBnY43Wh+4=;
        b=FQfITfiRMhPdxT4KQjLYvV81JJQDYMFMAcf43U39olhhvXMzxW1I7eLAW/NeaOAq6O
         2yFv6hrScV8/mZPVsGdfq9fSN6GMNKOh/movUMly2q2Im8CIkL2ri6YL2svqlESn8qXu
         zZnBRfIJhU07CEWQFjsSx5pCZuZ9nH2KAKcXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O3/IEoJuHM99uBghCekOnF9P7irem72rUYBnY43Wh+4=;
        b=Pwoh26MREQvOPo0WXQYcGZ7G27dTXuPkSvl65QfX6uA+nCJjGvjiLGWdKP8GilMzh6
         9TWJBDmjzpe9KQTq8jH5/y1vUN0Ftv7pm5KQ8iDHj3CBczt6Vdod7QLmY+vdbNxvxvOm
         q0XX4CgGcaogUxpN1VwbSmWvikVkSuoE8R1LmLF0mxKYn/1Y1x8pUv3hSWrg2ZyYwaGK
         9I31akkjlfSqWty1Y0Hpj17cedAhi8dIKxHoQ3MdfKopuAgK4iQ+bzIodRoi3f3e9sCJ
         nCSyqkJkuYuOoQ3GYBIOQw9wukYse5Po3MTUJGUvKTWhjjCg2N4MHoJlgceBhOm5AzhT
         HgNA==
X-Gm-Message-State: APt69E2ft8IQPwwKggc3H5P1qmcxSCJ5YwgcGz8ez6sE1Beo1awvQWVg
        JEga8dlDs45opgF/TheHxBvncA==
X-Google-Smtp-Source: ADUXVKIpCRD9qhOxMb9Q67Qeed6BMEyLKiGmQJZYBvoXXxP0KNRQN0LwDLViE8hft9C5TvpY09nv2w==
X-Received: by 2002:a65:43cb:: with SMTP id n11-v6mr24442460pgp.234.1530606874300;
        Tue, 03 Jul 2018 01:34:34 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id v89-v6sm3262415pfd.64.2018.07.03.01.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 01:34:33 -0700 (PDT)
Date:   Tue, 3 Jul 2018 14:04:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] arm64: dts: freescale: Add missing cooling device
 properties for CPUs
Message-ID: <20180703083431.l4rbnept2lwjocol@vireshk-i7>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <e4504945d2b684fae2850bbcf03a6d02917a8c8a.1527225682.git.viresh.kumar@linaro.org>
 <CAAQ0ZWRsroAAKRyxdd9ZCreriAjdBecmJy01sRy+6i_iQsMKgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAQ0ZWRsroAAKRyxdd9ZCreriAjdBecmJy01sRy+6i_iQsMKgw@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-07-18, 15:34, Shawn Guo wrote:
> Please use my kernel.org email address for future patches.

As there were many patches I relied on get_maintainers to do that
stuff and it didn't pick you up by default. Maybe try fixing
MAINTAINERS to add an entry against your email id ?

-- 
viresh
