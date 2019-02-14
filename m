Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7067DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC652075B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MinnkTeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393203AbfBNSc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:32:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46763 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfBNSc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:32:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so3496892pfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5xQOegI4u/xuqYSzbDdAl9GftxcoF2/7X75z+FZaHb4=;
        b=MinnkTeZrQRi1VwybMT7JTCMuH05puJENLDAKJYQYoj6zER+MDO21tE5hEYfhmBv8A
         d5LHfeFCfBqIjslYMlYRVZl3IEQFBWRLnp28Ex4FOlnRhXTdpyq5u/14oDWZ7OpiV0UG
         JhOqRpG3WfwN3wM0vTvWJEsg+S8I2VbwUYPjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5xQOegI4u/xuqYSzbDdAl9GftxcoF2/7X75z+FZaHb4=;
        b=UJxy1tnZ+THt5axSbgOJMdaeWmwq1DBrurjtamhFthfcDEIHCZ03H4KEcUNPLv1iPG
         IVwdyeI/4JfClLgoI/4BNQI/VTak2n9m4ybpuIJ+HexK0A5CmcpPEf2jvLm7wINX+zU+
         XQUlawawxhO1PkxyM5v0Im+vylD5Iebgnb/8x27CuucfbM+48+j5Tr1ReFg/IPzTccFL
         ttIU0CrLCLugJLGvHYlkOZhcIOUpYbpO4hJt8u1BtuifYfPg3sMM5UHkkSb1Ky3a9ZlR
         tsnmdmT0ge8sqPnYPl7QnbMx+scQPEx4yK1v828ix71ZEWcNe7Ni3Ndm2DgFH8ej4cjq
         xSGg==
X-Gm-Message-State: AHQUAuZKp1dSaGQ6MBQtku0HQPdxlhGohV2P2K/LoDqCqOzckax5cxFG
        Sb87lPs8vJrAPbjKo5tdPzG6+Q==
X-Google-Smtp-Source: AHgI3IbOIxqJPByKNvYtnQLJVAgdbWU3OSBZv1JimsletvEWuNNriBWHSj8oKZHctGM6VJIAmQ4kwA==
X-Received: by 2002:a62:520b:: with SMTP id g11mr5534426pfb.53.1550169178039;
        Thu, 14 Feb 2019 10:32:58 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p7sm4953997pfa.22.2019.02.14.10.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 10:32:57 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:32:57 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 3/4] PM / devfreq: Add devfreq_governor_start/stop()
Message-ID: <20190214183257.GB117604@google.com>
References: <20190214013042.254790-1-mka@chromium.org>
 <20190214013042.254790-4-mka@chromium.org>
 <CAGTfZH0cQhBLDx91VArMQ52z+iJAsfb2Zvk5nJSCqSM=aPhK0A@mail.gmail.com>
 <CAGTfZH1w=T+TY=bpqwHwLnxgzykcfrEv09iZuoUWwKFDAHK7Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGTfZH1w=T+TY=bpqwHwLnxgzykcfrEv09iZuoUWwKFDAHK7Zw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Thu, Feb 14, 2019 at 11:32:40PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> When I contributed the something to devfreq.c, if the newly added functions
> are internal/static, just added the function without 'devfreq_' prefix
> in order to distinguish them from the exported function as following:
> - find_available_min_freq()
> - find_available_max_freq()
> - set_freq_table()
> 
> So, the governor_start/stop are the static function used only in devfreq.c,
> in order to sustain the consistency of function naming, I recommened
> that changes them as following:
> - devfreq_governor_start -> governor_start
> - devfreq_governor_stop -> governor_stop

Sounds good, I'll update this in the next version.

Thanks

Matthias
