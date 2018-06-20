Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10CFC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678ED20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8ublxzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678ED20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754023AbeFTGTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:19:34 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41315 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbeFTGTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:19:31 -0400
Received: by mail-pf0-f194.google.com with SMTP id a11-v6so1059710pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 23:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hs4HRDO2PcGbW+s/nGj3XlSX67PwCXHo9tSUo6251dY=;
        b=D8ublxzNupC00ZpZbcc32+1Qf+gL+BDVae1poL/kgOxPrtlN8inz9AlYYk+Vdi8XBI
         Si6KGQ7ix8lk7plBoZubn6XQtvish5KTgLyYOkScNbmwnK8B4z+vrVN+Sn/c0sRMoJbe
         EqQtvmsSWBhBKx/mBWYp95aQb2S1nas+ONTuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hs4HRDO2PcGbW+s/nGj3XlSX67PwCXHo9tSUo6251dY=;
        b=jxic+hNHkQS6yzqckvtbQHa3EPE+1JuwZsCrH/Kd42GLGHSSi4gc9NOSREHR0aNUUD
         ERx97DFaBTFcJx7u/CYCKnjnO0Grzer0nUPHHkxKwodmKRtRrqytHfbzosT07XRbVJUR
         tw0SeIGvJq2cty7VHogswSgWn37NpObSFU+vjsY/d+3bfcYwSuSuE7NTPQhgoeWs64r0
         pK4Lz5pzjMjK2ZeVw1babShMMej9dNteToUSGmtSwJUi3NKoqLWIq8gagoId8fgo+Gra
         /yHTpMNPFTPxhAw8nC299CbBmZ119mG/bvbE6l2kILxsvsBnBp396OL+nDfiIapNTABu
         EbvA==
X-Gm-Message-State: APt69E1P+QwIYeVuH/Y7urbs97pQXwcFqzKgYHLCMFyS+uXosoJ7oJ+a
        /hml5Zi4D5Iy7+UlhN1kBN7G0A==
X-Google-Smtp-Source: ADUXVKIeHoTIl/JXeJuK+em2AjeTq+buswbWdOJ6CUkthOEvoRPUF3fYCzXCcX2vlvV17YWXWeJafQ==
X-Received: by 2002:a65:4cc3:: with SMTP id n3-v6mr17270126pgt.98.1529475570642;
        Tue, 19 Jun 2018 23:19:30 -0700 (PDT)
Received: from localhost ([122.171.103.96])
        by smtp.gmail.com with ESMTPSA id h9-v6sm2946577pfj.77.2018.06.19.23.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 23:19:29 -0700 (PDT)
Date:   Wed, 20 Jun 2018 11:49:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] PM / Domains: Rename opp_node to np
Message-ID: <20180620061928.6vlvyhakzocpakth@vireshk-i7>
References: <3d3687c030535189885d84c57dbffb034c4461c2.1528953706.git.viresh.kumar@linaro.org>
 <7511c9837569aec34c56e0a40364f2f3c16563b6.1529475153.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7511c9837569aec34c56e0a40364f2f3c16563b6.1529475153.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-06-18, 11:45, Viresh Kumar wrote:

The subject should be "[PATCH V2 1/2] ***" instead.

-- 
viresh
