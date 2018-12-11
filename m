Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093D1C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE0E2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+a9OcOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE0E2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeLKOkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:40:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40617 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKOkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:40:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so14195095oth.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 06:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8h97DuT0MBx9loXjcSrMN+imn6MuDC6J319x0ZsFJZM=;
        b=e+a9OcOuoCEd6qXQ60fjfA6PEzhOfAfXDFkpbkKFXKwKru559EmE9xeCYKgunGwXLz
         O3+B9MGke1IZgeuyB5v18nbtmRoYoV4a4fQNlobbkJMcR20hPg2dgqCJjrfDA9lnA4Bh
         NlaEBuPn2R1sUtg4NTOMJPCfP00kT+XuarJHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8h97DuT0MBx9loXjcSrMN+imn6MuDC6J319x0ZsFJZM=;
        b=SPvfdkps86UH/n1Sw+TX7bPsjfNEz8EdX2bwc8ZP/+JyUIYKGO1MSWxOsj5fT+kKi8
         IN4jFFhjLd/yC4zpZzSFsvUiREsxXDWft1KDgA4Ya1VHU2SgM9Hnu+u3DM7OcLB5P+o7
         cnKAa0faLCt3i7717qTW9jfKHRYNnVPCokm9AdjHa3//VqgeTr8R0OK2Vh9Mi7+Z1uV4
         BwQMvuVIfEvWc4g+K9xc/2FqelkRj2WcTrCKSiAIT4jakHFNm/euLTX35y0Ak7y0cMGc
         quXfaC0VDBxH3M6tKBINDNfKsANaSdfdIGLydjNJ1+ZNRCm12yjp4QXStAIm8uQ7kWG2
         2U7w==
X-Gm-Message-State: AA+aEWYtKtflEQck1lqNroAfFNbrz416OyCPHwZSam5cx4b3Z63vwI0u
        wYU/H7FRq6oBxLN4dMwYvVhIjw==
X-Google-Smtp-Source: AFSGD/X2OFEpy7kbyAYWioTAFUf62S4T1lV+m1tWWtEMbr/PlhBhm7L/2UIxQxSrOjHv1P0nbdhrOA==
X-Received: by 2002:a9d:17ca:: with SMTP id j68mr10821150otj.268.1544539248361;
        Tue, 11 Dec 2018 06:40:48 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:79bb:a266:cd71:3186])
        by smtp.gmail.com with ESMTPSA id u109sm6354021otb.8.2018.12.11.06.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:40:47 -0800 (PST)
Date:   Tue, 11 Dec 2018 08:40:46 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     arm@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] Qualcomm Driver updates for 4.21 - Part 2
Message-ID: <20181211144046.GB25288@hector.attlocal.net>
References: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
 <1544245994-4228-2-git-send-email-andy.gross@linaro.org>
 <c575fb97-4b19-5143-66f8-3a4874aa7c17@linaro.org>
 <20181210190513.GA25288@hector.attlocal.net>
 <84d1b299-2898-2df3-8b78-f9510f7bc229@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84d1b299-2898-2df3-8b78-f9510f7bc229@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:36:48PM +0200, Stanimir Varbanov wrote:
> 
> 
> On 10.12.18 г. 21:05 ч., Andy Gross wrote:
> >On Mon, Dec 10, 2018 at 02:20:47PM +0200, Stanimir Varbanov wrote:
> >>Hi Andy,
> >>
> >>On 12/8/18 7:13 AM, Andy Gross wrote:
> >>>The following changes since commit b601f73130a375c912d9f2ec93c5f3cea5d6a3da:
> >>>
> >>>   drm: msm: Check cmd_db_read_aux_data() for failure (2018-11-29 17:41:53 -0600)
> >>>
> >>>are available in the git repository at:
> >>>
> >>>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.21-2
> >>>
> >>>for you to fetch changes up to 92def04bd7b46f5b186f985d5c9d3804858c3c2f:
> >>>
> >>>   MAINTAINERS: Change Todor Tomov's email address (2018-12-05 16:45:34 -0600)
> >>>
> >>>----------------------------------------------------------------
> >>>Qualcomm ARM Based Driver Updates for v4.21 Part 2
> >>>
> >>>* Fix MAINTAINERS email address for Todor
> >>>* Fix SCM compilation error
> >>>
> >>>----------------------------------------------------------------
> >>>Jonathan Marek (1):
> >>>       firmware: qcom: scm: fix compilation error when disabled
> >>>
> >>>Todor Tomov (1):
> >>>       MAINTAINERS: Change Todor Tomov's email address
> >>
> >>I saw this patch is applied also in media_tree.git, not sure that is
> >>problem though.
> >
> >Which one?  The maintainer or the scm?
> 
> the maintainer one.

Ah ok.  I can drop that and resend the PR.  Not a big deal.

Olof,Arnd, Kevin,

Hold off on this one until I send a revised pull request.


Thanks!
Andy
