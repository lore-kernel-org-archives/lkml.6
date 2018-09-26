Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC94C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3765D2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENhB7k/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3765D2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeIZX0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:26:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37377 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeIZX0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:26:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so7255620pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6uFy7MRmrYLiKaM3bTAisAIN/cvQcENDUe82KGxA6y4=;
        b=ENhB7k/623JGdd8RTeSSY+J3EL8i5SBNdBIRuXnnlXT49xr+JkNeDKtt/NAFzkv0Xb
         I34+xB5Pf2PmG/toscLNcLvRViQHpg9Cabp2TOBAfGdR/ishk+iiyZ45goQ6xSZXW2ts
         v9F2jROeamF+TMDhGBtJdMpup+2OPzxYSSMJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6uFy7MRmrYLiKaM3bTAisAIN/cvQcENDUe82KGxA6y4=;
        b=pjC8L2bhBOW0GN8hJ4+TTrHEbKxouFscr2XxbnfSRi0IVil8alPxBcgN9N10a1iOu4
         Ppurfwk80be11g74Ow11WgFrTsIQ7G3eU3Y6g/BnP3Wff6cVD1peXskMDH19MLrcAkgv
         vIEfH2ZJXu6M9IabhZ0oydHOAMzorjo0O6xHX2SBnIO15rTIRCQpZp59F/rF65GlzuPi
         9fc0vUwb6shTy/RNCGrSNbigfVC7mO+RkzAL3ryoq0El0jle0903c0JpP/A2A6sWz7bd
         YhJWZDuXnpSzbM8TsYftSvehfSQuF+sCj2XMLHQZLheZN1xTr6xoNbxgIodOnPQms/aZ
         ypWg==
X-Gm-Message-State: ABuFfoj52rBQs0fVXofv4nwDRxNAsAt9F5aFdPzb8kMbwCUm7fF7EDsP
        gSIyCiED3M+wFegbOYmesGtWzGYVecg3nA==
X-Google-Smtp-Source: ACcGV61tWNnF/vdWRGYRJgroPy0JuDDUOFUlyN0uh6Wo+iKBvlktClyRjRZuThjFmNJkQ5KfI5XzGA==
X-Received: by 2002:a62:985a:: with SMTP id q87-v6mr7341280pfd.64.1537981929854;
        Wed, 26 Sep 2018 10:12:09 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 1-v6sm12293261pfm.145.2018.09.26.10.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 10:12:08 -0700 (PDT)
Date:   Wed, 26 Sep 2018 10:14:38 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Suman Anna <s-anna@ti.com>, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Loic Pallardy <loic.pallardy@st.com>
Subject: Re: [PATCH] rpmsg: core: add support to power domains for devices
Message-ID: <20180926171438.GA29702@builder>
References: <20180615095939.1331-1-srinivas.kandagatla@linaro.org>
 <a80cce14-9e57-32a2-760f-3d29de009f99@ti.com>
 <91dda9df-8074-925d-dcd3-d7c01e6f2363@st.com>
 <9afb010d-397f-2103-6692-bb4ca55b8236@ti.com>
 <4e1b6773-c4da-4638-eee7-2f996d387903@st.com>
 <0c06bde3-59f2-fad4-90ff-5818e9bab853@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c06bde3-59f2-fad4-90ff-5818e9bab853@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26 Sep 06:06 PDT 2018, Srinivas Kandagatla wrote:
> On 26/09/18 13:48, Arnaud Pouliquen wrote:
> > Sorry something was wrong in my fw used yesterday for testing...so
> > forget my previous status.
> > 
> > I re-tested it and I have the same issue (-ENODEV) with rpmsg device
> > probed on ns announcement rpmsg from remote side.
> > So we confirm the issue.
> 
> 
> A revert patch is in the stable queue now for 4.14 and 4.18 stable.
> http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> Issue reported should be fixed soon!!
> 

Thanks guys!

Regards,
Bjorn
