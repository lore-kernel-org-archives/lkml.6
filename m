Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69EFC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7564B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ur17gp1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7564B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeJDVQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:16:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52432 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeJDVQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:16:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so9255234wmw.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4cX+peGkduMAOVwdLoobODzAL0aRyiYbiXCALuVGouM=;
        b=Ur17gp1TkdM1MqtEonMbwvRgFKVBsL4qjNFYcTDir3D5NYYFMkwN+eef1GkG0HUDNw
         TnHmK7djzYU1xAjtj858jer8wJ6g92V2PxMQuNPONWhxOk/5TBEe2cO6n+qLLLQUbYzz
         lWCsJxxzICiwcMVapOZzuaARNsy0bP0btZtHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4cX+peGkduMAOVwdLoobODzAL0aRyiYbiXCALuVGouM=;
        b=oK2WbvF1kbWu34rG6huYtAXAukD3QuacGH0jIT+yfvBT57U02ixntq6RSt5nnwIkVg
         tNXGQlcl6CozGZJo49GV+mWXyH916iIFhQEDDs3YBEBIx8Q/Tz8v9hCA/SW8Ln8L2hOG
         EzOuKUZ2OoPvYusMPwwM2uHXy8ZmCR+DDRUZxBSK5KjDpmtBe9WUvidQ9wfHbu4d8U0S
         cHyslGipWFseQHXFMZ6ZvsarC8libGozgtm0KIQWjWRddau2Pzk293IerVLtqRQN6y8W
         3seewNb77GUF7PJUl3N6rVFRtB+yNfMEemgRjNQ3ZiARq+phvmo6SeJXpCZLlXP3OqQm
         at3Q==
X-Gm-Message-State: ABuFfoj22aTYVE28hq1IuZLnaw7drsKxZCBbo23wrizizRQgqqJu8T19
        uOFijAXtPyNwZElRiV+7Q88xUw==
X-Google-Smtp-Source: ACcGV61JbhaDLOvshtrFtOUeBij4DMfgWgJx9sQgKY2ClJq+H/x60YGZo7iqKfnBQV0Q52u8MMbJNA==
X-Received: by 2002:a1c:838a:: with SMTP id f132-v6mr5137034wmd.51.1538662971346;
        Thu, 04 Oct 2018 07:22:51 -0700 (PDT)
Received: from mai (101.142.88.92.rev.sfr.net. [92.88.142.101])
        by smtp.gmail.com with ESMTPSA id r131-v6sm4784476wmb.32.2018.10.04.07.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 07:22:50 -0700 (PDT)
Date:   Thu, 4 Oct 2018 16:22:47 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] cpuidle: menu: Compute first_idx when latency_req is
 known
Message-ID: <20181004142247.GA1881@mai>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <2172591.2D0LTaJpaX@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2172591.2D0LTaJpaX@aspire.rjw.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:42:56PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since menu_select() can only set first_idx to 1 if the exit latency
> of the second state is not greater than the latency limit, it should
> first determine that limit.  Thus first_idx should be computed after
> the "interactivity" factor has been taken into account.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewedy-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
