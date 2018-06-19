Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09727C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9C92083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ExDLquXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9C92083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965097AbeFSFtx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:49:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38533 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeFSFtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:49:51 -0400
Received: by mail-pf0-f195.google.com with SMTP id b74-v6so9355761pfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l+I2aKEMfyf2pkQwDogybELC+o58KMkdznXBKHFBvvo=;
        b=ExDLquXo4ZYSjFqVQZMrNcKnD/gay1xrjjcWWBQSlsyhMzmUftBbCc10OjfrB4omin
         XoIRsP53rv/0EUbj7epc92UUNuUeHBsrnuarDavRvXx4b6CThPhcFUYg9UtXPSkQKLT8
         KNyXVdqvP0+2DuM9nSfqsKYPH8EAjAnkvQaQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l+I2aKEMfyf2pkQwDogybELC+o58KMkdznXBKHFBvvo=;
        b=pzhtI23BmfhO7KsMbBaSLG/PRnoZzL5VNpe1yPziTtRQUKHag4SIBZDnb6ykE8Rb7h
         g8Bj6UViSBN4KBGCE4GPttNIHK6zNb6Zth3zs3A/x9yq0Z6vH97S7mhQv2+IGjW8RM5U
         SFDyJ92WU9Ec6W9aUQFkESnZGCD2Z+bKI9BQULhOInH818eQ/PwvIHAYByzzOw+aoSw0
         +9Mtj6qbDFouVnMYbCzeFNh4VeBiiHPYLzZ0MY2Uk7OvNwxNzIZKCUR7KbRr/wMmsxns
         3EjwwCj9F+X/YJ2YkWv8R45+aPMnMPzXALLkyPBrTJevPPh0HcA1ti41WEY5r21FZwlp
         VCeA==
X-Gm-Message-State: APt69E3vzuv3kQrglLUHDtOy3C0tmMyqox6/W3y2QS7XJ/ZZgIjExgNk
        D94lnDUWa4RoDL0gcOzUxBKrCkLHgAk=
X-Google-Smtp-Source: ADUXVKJycRL7N3t0NYeygAbCbCKxxoDPs1HZ2z+84FoB0mBfrY8SOQkvgCI/Uf6HDP1gIJwVgpfcdg==
X-Received: by 2002:a63:9e42:: with SMTP id r2-v6mr13569895pgo.436.1529387391104;
        Mon, 18 Jun 2018 22:49:51 -0700 (PDT)
Received: from localhost ([122.171.103.96])
        by smtp.gmail.com with ESMTPSA id r86-v6sm437594pfd.154.2018.06.18.22.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 22:49:49 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:19:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V7] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180619054947.5u5gpallmtzkilor@vireshk-i7>
References: <1529054393-27077-1-git-send-email-daniel.lezcano@linaro.org>
 <20180618102245.x5cfei3i7voq65zc@vireshk-i7>
 <bb11af50-1089-43af-abfa-0824e0db1e77@linaro.org>
 <20180618103844.t2minxwc7tiu2qgd@vireshk-i7>
 <883320cc-5677-6612-1565-b5a05b8684e1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883320cc-5677-6612-1565-b5a05b8684e1@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-18, 13:28, Daniel Lezcano wrote:
> for this specific case, we can use the park() callback to set should_run
> to false, no ?

Yep, that can be one option. Or just iterate through all the CPUs in the mask.

-- 
viresh
