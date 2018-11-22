Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC4BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1A720684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7FC+6v2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1A720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394402AbeKVVKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:10:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33115 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388144AbeKVVKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:10:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so9089100plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 02:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Ipo4Ypedi2KS6xt9+ZzOVJRgi9LSYD3F8v6Tac958A=;
        b=Z7FC+6v2TM3+c03OU+LDOp4LRxnHOX1qNQHtJYstrkK5npEIogshXejpUE6iqs144P
         opRJDtFpQn/J3iuB4q4Zfanh3lXHIcL/KpzCCPpe7YsGEgO/ZLk3BigFFOctrEPpqfMe
         npPcjTUEB27CRQhcD3ANGdv4ipikTfYnyCyMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Ipo4Ypedi2KS6xt9+ZzOVJRgi9LSYD3F8v6Tac958A=;
        b=baO1FNBaQSbvaeYoQz5qTNwFckhI5sDEDNhp61LgkJWbizHkO/SjeDIa1EpHOlJY92
         AyOAHqx0VbRTF+R85d+EypGioVFdVKnO3+k4BXjuh3cp1n6yin0UWNpgbegDEvzKJWra
         p/ZhvJJ7gJRVkL6QkBn+h5IMWa+bp3qSW+2iYPSt4b6ELRnk9AvScooRtrkY8LKOymdm
         4YpHTMDZbGCzH8JJOuuzhB0iad8G37RqPo4EAYlRLpz3RHQjXPFJlglGmBiwbiwmaLQ/
         kbWFZv+pEHF0pGhaRgZeWel5hsqIwyApZ9gWGGWdwrt3YoHWbzoVQER/cpMB4PyxlEFV
         IM1g==
X-Gm-Message-State: AA+aEWZ/+2jq6aMIVdSm3epCowr9aK4T7UEZgOdXGeBkTIhUT5Bbq4Ln
        Nba9FxvMRhmcaNxKZ2R4kw/iJQ==
X-Google-Smtp-Source: AFSGD/UVsb/npHZPw5KSuaydvR1kSD+C/hfiL7eGetruG6EhvExGQqliezJVNXC/NcZI+vASeLK1Mw==
X-Received: by 2002:a17:902:780c:: with SMTP id p12mr10486742pll.197.1542882677680;
        Thu, 22 Nov 2018 02:31:17 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id w80-v6sm79686744pfk.11.2018.11.22.02.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 02:31:17 -0800 (PST)
Date:   Thu, 22 Nov 2018 16:01:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/4] base/drivers/topology: Default dmpis-mhz if they are
 not set in DT
Message-ID: <20181122103114.epqwwta5ug7v5l55@vireshk-i7>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <1540830201-2947-4-git-send-email-daniel.lezcano@linaro.org>
 <20181030085845.az2dstibnrcl7im4@vireshk-i7>
 <3c3890d2-8b46-797d-328f-bd5dee11b22d@linaro.org>
 <20181122042900.u6eefkbw32vvi6xm@vireshk-i7>
 <b507cf16-aa78-303e-7459-ad380266317e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b507cf16-aa78-303e-7459-ad380266317e@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-18, 11:29, Daniel Lezcano wrote:
> Oh ... actually raw_capacity is not needed at all!

It is required as another routine writes some values to it I believe :)

-- 
viresh
