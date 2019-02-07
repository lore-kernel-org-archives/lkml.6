Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971B2C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618612084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCsh2wOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfBGEIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:08:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36700 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfBGEII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 23:08:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so4188818plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 20:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oe6CHy5kVVxLnzuV/JO6wOHCV2blRstih5wPBxrJ8o0=;
        b=kCsh2wOs8jp8h+ZOJhfvTVfG07C8yWJrNOBx3ZTwwptp6bmL8VoxgOkovzTJEKu6k/
         /8wjVei/dMPiXtEzT8DddaQUKWAhP/jMgaPfIeeTLvdJ73XXJkuNIqjOMlUl0uiu6L+O
         R0TM7RmSD5XzDb9YPpRMm0PDJ0PGv3ksbOeoopBG5dzzAZduzm48O8s+cBdUK2i3fxO1
         L84HQUWc4CExz77UH4M+TtjWJdQuftp6zdNGMNeph0lELyGruDwLifDL0KmTTwcEgzjE
         PmaowDpLpp/v2L6GVEEZPTE+fGDhXo0sd4p75RlVAi8whyGYjMxEKTlsrRsAokNkyb8n
         cPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oe6CHy5kVVxLnzuV/JO6wOHCV2blRstih5wPBxrJ8o0=;
        b=AFAJadiPjfhvrE2mz0pWFtMCRxWafya0exWtJig4QMhU4JrKIvxOVLfHKtDxe7ThYI
         4e65VJ/pWN9ZVa1ByWGdeBqodH/SWkX8GJ4u4uJ5tM4cJPoJJCTpBGFoy65d2v/OPWKF
         0L78jwxHkTfkViYClp0ZOrZj+X9NYBOdjkhv4sUjLr+e3QLfw5JqgW3dIH5VmsnN+fEC
         n0MB6G2uq2zgh29hZDMB8H46ffMBufSOn+1Nzx4bv1oRa2pA9V4Topu6N7ObeEyFKrWB
         VjCnKOeGIeZuTUXHeISzH/K2E6HSlxeBRd4EjxFj7B6zak6T52SIiSCgG/J67an816GG
         jUag==
X-Gm-Message-State: AHQUAuZ8OVA9nt20xz3apSnC2ZnGLtGSmBSrWlhhAPoZq1MVnkIbL1Ua
        tgFbu/wL7I8OP2WyxoPeT8/g0Q==
X-Google-Smtp-Source: AHgI3IYBrG4YfPCSVfMNpwUv4aEIummWC8IQbiiR9AFRu4hbiwXG3SfHj8Iv4v/j5MwpXnpOr4xZxQ==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr14668526plp.34.1549512487925;
        Wed, 06 Feb 2019 20:08:07 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id 125sm10293184pfg.39.2019.02.06.20.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 20:08:07 -0800 (PST)
Date:   Thu, 7 Feb 2019 09:38:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Taniya Das <tdas@codeaurora.org>, CK Hu <ck.hu@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] cpufreq: mediatek: Register an Energy Model
Message-ID: <20190207040805.og4t2s5ycuy6hqab@vireshk-i7>
References: <20190205175225.25923-1-mka@chromium.org>
 <20190205175225.25923-2-mka@chromium.org>
 <20190206101316.fr7z4ffr4ck4l4aj@queper01-lin>
 <20190206181659.GI117604@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206181659.GI117604@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-02-19, 10:16, Matthias Kaehlcke wrote:
> You are prefectly right, I missed the obvious and didn't get my hands
> on hardware yet for testing.
> 
> So much for screwing up a one-liner ... I'll send a fix.
> 
> I thought Viresh already applied the patch, however in opp/linux-next
> I currently only see the other one of this series for qcom-hw, so it
> seems sending a new version rather than a fix-up patch is the way to
> go.

Yeah, I dropped it after Quentin reported the issue.

-- 
viresh
