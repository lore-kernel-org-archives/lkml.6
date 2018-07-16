Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B99ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248EA20850
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WiiBm0LD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248EA20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeGPE5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:57:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40824 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeGPE5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:57:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id e13-v6so12290281pff.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 21:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0VHuiUF3ypM8eD1fesUW4mJTpjBis/8HH9j4n6SRdTA=;
        b=WiiBm0LDKgeElIttXVuLL3UpmzqYzrYMAL4SXBVKH7xh8+EEiFrYwrbMoytQhSjRe4
         hHo++ythRB2hVePdFo4bDFkgC2gIHCZna6nyeS0k1LNrHe2seSNJMd700Mv55Xfd3mFy
         BSUsEmxLX9855itiuuqr974MwT5KgHg8idXeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0VHuiUF3ypM8eD1fesUW4mJTpjBis/8HH9j4n6SRdTA=;
        b=ZEQOoPoIhzKWwcZz03vKKbqUgeWwHp0GDMjlwAPuvPSXgi+dL8sWuoinMN9MJ0EQFT
         rKJwJogOXiYWquXlvDmW+tOIQIbalnZUP3cVBzE1dhNTRERtS3KoXim5OWZ1wCVh9ZZY
         VF2Vv60/5v1upTpWJnt6syGNu28DLmoGHo1SvglRgjEoqyIbEh7d99Sq8zrfiy1xJZgc
         jGfVJPA5ZBzXAJGDasNcUrjl/4Y8janWFyaA9gAsN2KkaLTRTfXtTEo9x6AnmoE+78AG
         8fPQBK3ZGCrG36so35wkKF27gBXdwmMKhO+FaoaXt+WIBOTIiw8ig03L5ohAXD/vxCuC
         APJA==
X-Gm-Message-State: AOUpUlGYUB6maczrGJkZpuQw0GMY2KvIOcZ+V9rP8tLZnVlZKmdk3eRC
        59rj/4+Abqeehf6BlQQaEM9Y5A==
X-Google-Smtp-Source: AAOMgpf7JfRgUR4lpLykmYUBLFfAwxFbdoFcwM6BKJQa4ED2ERqwK9GJrJdujHDP8laKexfWSc+85Q==
X-Received: by 2002:a65:4344:: with SMTP id k4-v6mr14098240pgq.409.1531715525649;
        Sun, 15 Jul 2018 21:32:05 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id h24-v6sm2523395pfk.113.2018.07.15.21.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 21:32:04 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:02:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>,
        Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] OPP: Support multiple power-domains per device
Message-ID: <20180716043203.gyedmithp4xa7p3u@vireshk-i7>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-18, 11:49, Viresh Kumar wrote:
> Hi,
> 
> This series improves the OPP core (and a bit of genpd core as well) to
> support multiple phandles in the "required-opps" property, which are
> only used for multiple power-domains per device for now.
> 
> We still don't propagate the changes to master domains for the
> sub-domains, but this patchset is an important stepping stone for that
> to happen.
> 
> Tested on Hikey960 after faking some power domains for CPUs.

Ulf, can you please help review this stuff ? 

-- 
viresh
