Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F25C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0200B2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnI5jtzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0200B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeK3Nmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:42:32 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34592 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeK3Nmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:42:32 -0500
Received: by mail-oi1-f196.google.com with SMTP id h25so3541853oig.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 18:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Axev834yRx7ZCsXLYPXHnuu+iX1TwQTTk8ffcEj8EM=;
        b=PnI5jtzsxX6GMx107ZR///Vr6HkkS3DNK2VL9AyqB+G8NhwWtA6W2JbAwMChk3Mn4j
         RLni/JWJDBks6rn7gxrqH16wCKIcqy6VCsjcmZhxBJwShjE7M+wzf1/go16Smcu4PYI0
         hU1ncZ2+f+EIIvx2z2S29ROecmSPXRe2gQZmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Axev834yRx7ZCsXLYPXHnuu+iX1TwQTTk8ffcEj8EM=;
        b=YWL0kQWrR6M7mh/zyR1uG+Eyju1sF5tAtJW06oaZfP/Y4y/+QZiNN3cMT7yMdvFBMi
         8RErbLOIWADJHXtxPFVtFt769BjfEPrwslgYs6heGWbMscAwjY1a7+rcEFQFa6eSyCfM
         K/vkJaxSJoqY1KdSojX08FaRhmF9V+R/kG5O7tSVJ4bycNGDxXsND6l+XSmQBmQPXIZa
         eDTQ1CBtB2Wnuk0W3+WJgbcp5gYKPR/PsXKP/BF8lSptdIXjZ6DwetRpz84zBPXbD8Zr
         s/0J1nQXk8FYRay9CGLdQszk2YS+C5jeUlnXUE3JxjOrahq8nfDihPvGmwdGyuafX2Lr
         B2cQ==
X-Gm-Message-State: AA+aEWZD78ZY/SLhs3itv/JTueQNCUJ+6aD66wdeDQ4k//j8IlPC5oo4
        RhvDKgUjI5GB8lLYcerBC0FuvA==
X-Google-Smtp-Source: AFSGD/W2q9tuqcqhgbUUiQn4OTFvXTLTR6C7YoDnEuuTx5QR0L5zJHgxNTx0i6n/UW3yHKwKh4Zvyw==
X-Received: by 2002:aca:3141:: with SMTP id x62mr2264244oix.194.1543545290233;
        Thu, 29 Nov 2018 18:34:50 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:d408:b2c2:72bf:467a])
        by smtp.gmail.com with ESMTPSA id e42sm4863102oth.36.2018.11.29.18.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 18:34:49 -0800 (PST)
Date:   Thu, 29 Nov 2018 20:34:47 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kbuild test robot <lkp@intel.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] drm: msm: Check cmd_db_read_aux_data() for failure
Message-ID: <20181130023447.GE32306@hector.attlocal.net>
References: <20181129163826.178670-1-swboyd@chromium.org>
 <20181129223600.GC32306@hector.attlocal.net>
 <20181129224234.GD32306@hector.attlocal.net>
 <20181130131201.6fc91dcd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130131201.6fc91dcd@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 01:12:01PM +1100, Stephen Rothwell wrote:
> Hi Andy,
> 
> On Thu, 29 Nov 2018 16:42:34 -0600 Andy Gross <andy.gross@linaro.org> wrote:
> >
> > On Thu, Nov 29, 2018 at 04:36:00PM -0600, Andy Gross wrote:
> > > On Thu, Nov 29, 2018 at 08:38:26AM -0800, Stephen Boyd wrote:  
> > > > We need to check the call to cmd_db_read_aux_data() for the error case,
> > > > so that we don't continue and use potentially uninitialized values for
> > > > 'pri_count' and 'sec_count'. Otherwise, we get the following compiler
> > > > warnings:
> > > > 
> > > >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c: In function 'a6xx_gmu_rpmh_arc_votes_init.isra.12':
> > > >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:943:12: warning: 'pri_count' is used uninitialized in this function [-Wuninitialized]
> > > >      pri_count >>= 1;
> > > >                ^~~
> > > >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:948:12: warning: 'sec_count' may be used uninitialized in this function
> > > > [-Wmaybe-uninitialized]
> > > >      sec_count >>= 1;
> > > >                ^~~
> > > > 
> > > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > Cc: Evan Green <evgreen@chromium.org>
> > > > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > > > Cc: Rob Clark <robdclark@gmail.com>
> > > > Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>  
> > 
> > On second thought, this needs to go through drm tree.
> 
> Why?  The commit that introduces the warnings is only in the qcom

Sorry, I wasn't thinking it through earlier.  Yes, due to the two patches in our
tree changing the API, this needs to go through my tree.  I asked Rob to ack
it so I could take it in.  He did that and now it's been added to my pull and
also pushed to -next.

Sorry for the confusion on my part.

Andy
