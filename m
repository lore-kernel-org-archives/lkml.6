Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30242C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9D72083A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIwL1EDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9D72083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeIAEmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 00:42:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37229 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeIAEmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 00:42:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id 2-v6so5608556pgo.4;
        Fri, 31 Aug 2018 17:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ojr44WcL9JloHkAG32yJd+JB5DekUlgrznnwrkKSSJ0=;
        b=HIwL1EDOpifB9LPjiuImCUovu6gdxbO+p9an9ARPJNqoGshbDu0kLq7M1U5nbtI+jM
         xw97Wx1fUqg4ppq0gda9FqNeJzrRi0cIjxWkEALuD1qqbl+CXSKAQN4KIjBYmASn7KtZ
         V2lm2+Ss+4PSFaBRMN3hOv6T+ne3B5Bijyt3toTvkiFE5T5Ljgdqw51An4x+QU3S2k2X
         vy30jqTcUtXCL9HomopiwKxASpmjEQds29er0ICLgrSDMUoSWEHyZwoHLgiUoEsP+OJh
         X/WM9GJQmP6o4SsKqn/7YAJuzsTi7onTF5bdA9tWDVaWkyn3bWdEI182l/DOFBl2tdXx
         2Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ojr44WcL9JloHkAG32yJd+JB5DekUlgrznnwrkKSSJ0=;
        b=IFqrTuZMj4UftpAtIZn6NesVNjb4dJx8lms4t+8733rDuBmxEFx8q9uHxUnqC7Rmwj
         De1Tcfy0ymwgQGGvHdrM3quMZSGCRX4sSH7lUBMWrKXRSuJEgZiyDWdDEs395Fnbm2X4
         K1nFcCH8MLLnWtjuGnoaAM5OG26Gjf7qQ+rTAEezmIZn76ohnGX+/Jp+/ul8zBG8KTWR
         vRs2WBwS6ccErlMIA4dJwnPn8H+iIGPoz3ptUlSKcIJMuFZlhnBcfRH3WIqWERwQhjpF
         Adwr3CoHEp1GerK9H77wrPZMq16EZ/0Wae1jZP3CguZuVhHitzuE/DApb9h8nUqiILmC
         expw==
X-Gm-Message-State: APzg51BNsXgf9GbEX2tj5zoy0FolFGaQkFcdeD+7Nj7Zn1jbNezWuboz
        uB1CszhcPzxuME/oQQYKvZ4=
X-Google-Smtp-Source: ANB0VdYfujJyHBj4xG8JnXgZZ13Rc3owAURYwZpyxukyJd0Fe95nSJsVF01VLLwnhHyyuG2mtYSeyg==
X-Received: by 2002:a63:cc04:: with SMTP id x4-v6mr16314811pgf.33.1535761923047;
        Fri, 31 Aug 2018 17:32:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:a245])
        by smtp.gmail.com with ESMTPSA id s85-v6sm19047754pfa.116.2018.08.31.17.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 17:32:02 -0700 (PDT)
Date:   Fri, 31 Aug 2018 17:31:59 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] blkcg: change blkg reference counting to use
 percpu_ref
Message-ID: <20180901003159.GK1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-14-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-14-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 30, 2018 at 09:53:54PM -0400, Dennis Zhou wrote:
> @@ -217,6 +240,10 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>  		blkg_get(blkg->parent);
>  	}
>  
> +	ret = percpu_ref_init(&blkg->refcnt, __blkg_release, 0, GFP_KERNEL);

So, while this would work in some configs, you can't depend on RCU
grace period inside percpu_ref.  blkg is now percpu-reference counted
and rcu protected object - it has to explicitly go through a rcu grace
period before release.

Thanks.

-- 
tejun
