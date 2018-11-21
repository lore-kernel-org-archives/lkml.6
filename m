Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77058C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413AB2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFzpM/rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413AB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeKUOeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:34:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36528 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeKUOet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:34:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id y6-v6so3460590plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 20:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jD4EvHrCedZPR1eexDzPL2ORdf7F23ZT49Cve3Do4Jk=;
        b=VFzpM/rj99cZDp3qxZIIexfY6MTuhoR1JaSE5kx7ieQNUZRAhWc9EBtlpfK12IN8Lw
         7V8mvks/IQdAw+FBdU6iaLfSsFIu4W5nJ+856AvK6OdGEWtCru/JE79pKqI/7/CG1YHA
         AV4YQ2peacZ5dmHOxHOjbKpp56Ow6O84Tl734=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jD4EvHrCedZPR1eexDzPL2ORdf7F23ZT49Cve3Do4Jk=;
        b=rVw/X0fOqIskhGsONpQwB4Z7ypR7U8kwS0k36Dc4PfMeoMAKXF8XNo9XirHprQBWUf
         uJtVW6AMp8/LuUCxbkScXNTZ0ZBcOWssszWOezGBqhyI8tA9yeCNhFiR2LNnSrYbFOe7
         US7iFFMIHQ1VXtI0TmoO/P2kr91A2zJKQ8+nD253H/CEDJxDtcVXSGkamdoRCs/MuLWB
         n23+rB8SwJXByHxXwkjh0JarONAUk3jj7jyPk6tRhmtlGaICeHGizvvxrALsPenOEmdx
         TjtQs5AyYzoSkJu247R3ZHTEDBhPcDriGHTxsWivOA6wVzQmF43OFr5p0jpM3e4cC1jw
         YeUw==
X-Gm-Message-State: AGRZ1gL+NBcMgK/2wWckR1y72DasXrm1FlSwrNU3lNQnjh9YYyhv9KiP
        7T0pq/d7MB3GNW8XMs6o/vCgQg==
X-Google-Smtp-Source: AJdET5dSYVv/OYuLZcPm682fOnYbEGXb48aLJ5I+vClFCRu/muv+BzGEIYtFozKmakVA82Owt2SSyQ==
X-Received: by 2002:a62:d449:: with SMTP id u9-v6mr5181318pfl.116.1542772929966;
        Tue, 20 Nov 2018 20:02:09 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id t78-v6sm80135659pfk.59.2018.11.20.20.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 20:02:09 -0800 (PST)
Date:   Wed, 21 Nov 2018 09:32:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: powernv: add of_node_put()
Message-ID: <20181121040204.yjlnxaulet3o5u3r@vireshk-i7>
References: <20181120160530.21015-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120160530.21015-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-18, 11:05, Yangtao Li wrote:
> The of_find_node_by_path() returns a node pointer with refcount
> incremented,but there is the lack of use of the of_node_put() when
> done.Add the missing of_node_put() to release the refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Changes in v2
> -update changelog
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
