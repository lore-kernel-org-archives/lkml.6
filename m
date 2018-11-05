Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53373C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134422085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhGQ907s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134422085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbeKFBvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:51:53 -0500
Received: from mail-yb1-f172.google.com ([209.85.219.172]:44893 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbeKFBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:51:53 -0500
Received: by mail-yb1-f172.google.com with SMTP id p144-v6so4027205yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8hrjh+rf7zQH2sGjQ6NuVoGNz4ChSSoB1qihJsjBu8Q=;
        b=EhGQ907sHjOO6wLsoTzTllaUlYjSMgZZSqvm64NSlKF9CsqBj90gioyWyeMLcVB1X9
         2UVfdNAmKdz542Vz16c/QvlMpQ4Reuz/TyklkojeUSdjoBff/6OgISaF9r6SXxc4ZpE1
         w7ulW0h/NxRw0OvxtwLRWyoBnnL8N83ZtAFxFeGmPqRf4c+1bhFPUlPJbFGuOFy1nMR1
         JmH2sn2S9R7LaLu3VyvTM+PRtMTDKaiAu/QZ7WUdMafrSiImFrGLm/5ZaQgNq1/Z5zGQ
         HrNDGrH2JWjqK1AsDT67gmnN1hezYK6IVa8N6GXWXKWHK0LD31KPQWDWnj8j+ucSSfu4
         IfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8hrjh+rf7zQH2sGjQ6NuVoGNz4ChSSoB1qihJsjBu8Q=;
        b=YyQ4OVG49qG92Ai3BAowoMvhmr0XOYqcTM82jC+S25wCkefB72qZDyppiryF7/uGhG
         eKCobIA1O+i2Fbcq4TTGAHooKRaxXHHIlOq2I9lvWsrqVimV2wK2APR8sCEHJ3x3HulP
         1VxrKwf9ndtOrQA6hazZWuJqUaCJ/PnzpTmd+JMTdn0aDD8fP487VwbS5TJr+MTWGTrv
         Q/5hUKF06d0LuR8gpS5oZjm+wR6D1W5Yneditx1q4tcNrzsuioOVjwhXgRdT1a0I9d2O
         XLoyZFvy1G+ABAh6km2ZRLXU/iYxbz72nQamTbt0ej3rD+d6vDAdZKi72KTB66az0X7Y
         7CIg==
X-Gm-Message-State: AGRZ1gIKaI4ry8HlIj/zdX+FyEzLxlnKWgIeCJihnxVXl5Z3DxVKHhE+
        6LPGyqkjtccB4AzMbIcABYI=
X-Google-Smtp-Source: AJdET5e0tX+DWBhjfhCEibMMgWIwjb1CMcGUi9d9gQLcRJ4pIWAFlSTdKdyOm1JHc5VsJq3k5/iylg==
X-Received: by 2002:a25:cb53:: with SMTP id b80-v6mr21675221ybg.303.1541435484454;
        Mon, 05 Nov 2018 08:31:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:b217])
        by smtp.gmail.com with ESMTPSA id 123-v6sm10884002ywx.15.2018.11.05.08.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:31:23 -0800 (PST)
Date:   Mon, 5 Nov 2018 08:31:21 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     guro@fb.com, axboe@kernel.dk, dennis@kernel.org,
        hannes@cmpxchg.org, dennisszhou@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove unnecessary unlikely()
Message-ID: <20181105163121.GJ4182586@devbig004.ftw2.facebook.com>
References: <20181104022741.2518-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181104022741.2518-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 10:27:41PM -0400, Yangtao Li wrote:
> WARN_ON() already contains an unlikely(), so it's not necessary to use
> unlikely.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied to cgroup/for-4.21.

Thanks.

-- 
tejun
