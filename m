Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075B2C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E3820896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyLdJkae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E3820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932689AbeFQI1N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 04:27:13 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34734 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbeFQI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 04:27:10 -0400
Received: by mail-pl0-f65.google.com with SMTP id g20-v6so7458051plq.1;
        Sun, 17 Jun 2018 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=otHDokM3AQ3Bt9ycdAEpolsZFlDdrdWUum9h3+69LpI=;
        b=VyLdJkaeq+wGJhcQ6gmIBHZ74r6NDdxUo1FeekmA1ODTyvHlHaE8wcx0KJoBsKn7fu
         YtjrCSJqXnujVPyhWQGKUa9hwYoqol6f3N0KcQjbrYCd8qgjeGFlrMjvQdemSNRnVRVb
         1jZsHCyH+xXlxPrRtBG5O1j6zGYXIsbbo6odnFxjTHBHbZaxhQTPoQSwy6iI4dgdCo/M
         +gHK/+6NtvxXurSmAuy0dBYSbagZMhzMBK9m1liizr9zxKmo9GM5FYVhzH/uS4zXnTlr
         Cllk2Ix10Oc/Zje0hivWIEeAj0eDDjNtOGq6i/cTziM0qAtaYSe+K9/zheMkHQUoILov
         /1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=otHDokM3AQ3Bt9ycdAEpolsZFlDdrdWUum9h3+69LpI=;
        b=X0KIGzVGt+RtZG0Q1pQjYtFaqOuelevuTBST15CsAuIR4pR1M9O8GgvbamH+TAjHYh
         NSuHv0KVqYF4eXXCnXs8XYzggq9QDK5tNzKppXvOlsnKeBPSOsJwhDmJeofjY05SA06M
         c2Io8mObLqqUfJF9+aEmMLEAWC7yBtvEkzKjRN6wias1+WDmIjEBpR/BDOgCUvMuVIKR
         2jsVfFoEUsNP+LX0lcr9J/wjmOO8mqggx+IwSLEMhWJBaaXtMwTcrOmTq3AHwu1mTf8a
         H85pgSQh1WnuaO8mAhxCprETOtGu3b4zyRwZQP8sjKxMrVCxglY+ax8XurIzfR3UAExv
         fIjw==
X-Gm-Message-State: APt69E2RsjOOB9Ir6AEcCQjzNlPWSGAeoW6ibNDcx/NS/GOGG7/6nsRF
        J0EafytnDJ30pV+OSrhICQA=
X-Google-Smtp-Source: ADUXVKLJTSF3xM9jO/ixJ06f7ZXGuQxTDG8sHGMqCl5lXFr6QPey7Fs54naJ61JH51fnRY/3komoeg==
X-Received: by 2002:a17:902:868b:: with SMTP id g11-v6mr9065712plo.305.1529224029830;
        Sun, 17 Jun 2018 01:27:09 -0700 (PDT)
Received: from nishad ([106.51.24.189])
        by smtp.gmail.com with ESMTPSA id b22-v6sm17298619pfi.144.2018.06.17.01.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 01:27:09 -0700 (PDT)
Date:   Sun, 17 Jun 2018 13:57:01 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wilc1000: Fix type of argument in
 ieee80211_is_action()
Message-ID: <20180617082700.GA2594@nishad>
References: <20180610071013.GA8771@nishad>
 <20180612131413.qlv3wes43obfbmhe@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612131413.qlv3wes43obfbmhe@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 04:14:13PM +0300, Dan Carpenter wrote:
> On Sun, Jun 10, 2018 at 12:40:17PM +0530, Nishad Kamdar wrote:
> > Type used is unsigned char but expected is restricted __le16.
> > Warning reported by sparse. Part of eudyptula challenge.
> > 
> 
> The code is buggy, but this fix just papers over it.  We discussed this
> code earlier.
> 
> https://lkml.org/lkml/2018/6/5/304
> 
> regards,
> dan carpenter
> 

Ok, I will look at the discussion. Thanks for the review.

regards,
nishad kamdar
