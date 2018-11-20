Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6BCC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A30206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="causubHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A30206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeKUEfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:35:48 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33967 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeKUEfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:35:48 -0500
Received: by mail-qk1-f195.google.com with SMTP id a132so3416030qkg.1;
        Tue, 20 Nov 2018 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P3GqPkO2lYkTGily+voGd+zaChSnpbMaoctm3VXIpgk=;
        b=causubHdPnUhSDv/ISzoaFvFGS46PBzlZpf976UTnSjl3c2LhMmWXr2T7skAJuNC8B
         dsjOPJIntx4v7/K1noE5BjSIQXZrDIqzGoXX09Y5btaEV/QPm3DzWqTLtuUj8pSuMwds
         D6L0JQ6OrD2z3JZwHeGSvPqGiZMPBj/1hbABPFg5azkIZKGbVUuv/zbLowf3c7KiG+ZX
         BuKBO4JES74/LhLG4VgWiohPd4lPbS2ftDD7vgiMHpNdj+TSUpRc8sjKDTj35RS6THpB
         q50lTuBCn4/2yRxdbk5s3q4gN0bTXxCx53vcw41YpW25ocKH4mGES1pTL4lSowgU5eIz
         GLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P3GqPkO2lYkTGily+voGd+zaChSnpbMaoctm3VXIpgk=;
        b=fZ84tGTMgUPdkY2ZVs2jjWfGt++248Qici4lZe3jN+exkOi+kMz6su9hALpPyZ9Yv7
         UYuTdgVyhLn7aGplN11Gg9DjmIWnm3Q3Vo/Cbg4kwtJRho2KqsIWWiwlqhmgnoA9EW2G
         dzifnAAfybnCKjZfnjIykFXshEvD+somLtSav2EzCWEva51iuXTFTsBmcuL6gd+BvFmS
         /fcUs2vK1nnDGrXpeYdGF2sGGzI5W+1WNFu22bs5qa8R/m/XGjYfyDbbIA8DNiezZWjO
         Q8BIOLiC74tQkYEcZ8t0NemQTVKwFllr4ORlflq24T1QCCnC7cnzO8fg/1yumTZuknXt
         i8hw==
X-Gm-Message-State: AA+aEWZyEdYttuRcGfrd9gyL9LHuHgNNK7h5SmiMxnpVpESeQPV/e0Fd
        F+82y+mETdljWmgZjGTQmVQ=
X-Google-Smtp-Source: AFSGD/Um/zwjfMVLf2+qpUTvlXzzsjAsONUZHbusABw+uQFvxbX4xCsi1gdaCdlNDzQoetk7aL2qnA==
X-Received: by 2002:a37:c12:: with SMTP id 18mr2617487qkm.317.1542737123354;
        Tue, 20 Nov 2018 10:05:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:4b6a])
        by smtp.gmail.com with ESMTPSA id i26sm31075704qtc.13.2018.11.20.10.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 10:05:22 -0800 (PST)
Date:   Tue, 20 Nov 2018 10:05:20 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 4/7] cgroup: cgroup v2 freezer
Message-ID: <20181120180520.GZ2509588@devbig004.ftw2.facebook.com>
References: <20181117003830.15344-1-guro@fb.com>
 <20181117003830.15344-5-guro@fb.com>
 <20181120162529.GU2509588@devbig004.ftw2.facebook.com>
 <20181120163304.GA21462@tower.DHCP.thefacebook.com>
 <20181120163604.GX2509588@devbig004.ftw2.facebook.com>
 <20181120164349.GB21462@tower.DHCP.thefacebook.com>
 <20181120164859.GY2509588@devbig004.ftw2.facebook.com>
 <20181120173858.GC21462@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120173858.GC21462@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 20, 2018 at 05:39:03PM +0000, Roman Gushchin wrote:
> Yeah, it's a good point. I've thought about it mostly in the fork() context,
> where if freezing of a cgroup races with fork(), it makes no sense to
> switch the cgroup state back and forth. But that case is different, as
> the child will be trapped just on the return path from fork() call.

I think it'd be best to tie the task counter transitions to cgroup
state update and propagation so that the state is always reflective of
the task states.

Thanks.

-- 
tejun
