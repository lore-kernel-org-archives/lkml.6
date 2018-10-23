Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3891DC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E333B20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQRxG2vD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E333B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeJXESk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:18:40 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44646 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJXESk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:18:40 -0400
Received: by mail-yw1-f67.google.com with SMTP id t78-v6so1069197ywg.11;
        Tue, 23 Oct 2018 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kosRG1nnY5WSZUG+c3N8EbuqwT9HCSm5prVMq9msGRA=;
        b=SQRxG2vDrXwE6VzhVF/HxLP0kcVxI6JdLX8gxfs+P4l6IdIzAtLJQGO6dnCRUNDa90
         qCHGA51xR/sYUz//6/6CFvLN8YDkp2e0gn6ru47oaYhEJyJZsZhnqT/mEBtyoOiyJNhb
         dOEvowBEZab+nMBhI4/FV3IrmhHGgz5/VV9AgxPMXmuHqzJCyN/eeXF3MZsZ3EsH9FGO
         xqD9yMTUa+R99BfQPihWNIHytWGCH300r/ll6LYIzwyeqCuiqZOFuqDJnobTPNMnaYJq
         buuUlYkpz6RLS+gjNU7cG41bYjFy9i3fk0WMbpJH/yAlK+bJ8yM0lV8TW8rzUSzyPw2Y
         f/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kosRG1nnY5WSZUG+c3N8EbuqwT9HCSm5prVMq9msGRA=;
        b=L4PtpJeKk0Vn2KBi1MYRIhyQPJqfJu54/kQrlwMW9GgB1L528p0WLJlKXxpI7WVKcS
         e3OKMO7XYTZZLe1aw+zo6v0PoK4QGEZ9kNS7ihHMTbpuH4PhXjwmBAoHuFD7fGVBRtKc
         eP5gd6dGob6bhpp/kI57xZO9FXHaVpJsKJxi8cwo7dQW+l2G+p1PD2ttR6X699uhyR0J
         howc5lkREV7OYtK9VSaPgd0RYuvzP72zPJnPMP7l7EqSuRJX6Yq6DOidn6n7QzquHW3a
         BOFGgMbnvwIU8L1tPzIp8mYFBpnt4ujyavqVJ2J89LCPLNQZLB0YQJ0V/7/xzn2D28X5
         PdDg==
X-Gm-Message-State: AGRZ1gKwxbaP5O0arwmyJCSxwZTRdeW4I/x29Zyxt/r4Gn5DwP7SSiI4
        0HZMk0eo5yoojBDB6AnmHVg=
X-Google-Smtp-Source: AJdET5digMX9hxs1JRMVtafCCu70zA0PS0WUV/VaRQgK34ia+e28tBr+1O1R7ZDEDqlfyPiorMdPRg==
X-Received: by 2002:a81:72d5:: with SMTP id n204-v6mr3111546ywc.57.1540324428578;
        Tue, 23 Oct 2018 12:53:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:c0bc])
        by smtp.gmail.com with ESMTPSA id s200-v6sm577207ywg.61.2018.10.23.12.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:53:47 -0700 (PDT)
Date:   Tue, 23 Oct 2018 12:53:45 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Rami Rosen <ramirose@gmail.com>
Cc:     pandit.parav@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] rdmacg: fix a typo in rdmacg documentation
Message-ID: <20181023195345.GB4182586@devbig004.ftw2.facebook.com>
References: <20181023150106.7332-1-ramirose@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023150106.7332-1-ramirose@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 06:01:06PM +0300, Rami Rosen wrote:
> This patch fixes a typo in RDMA cgroup documentation.
> 
> Signed-off-by: Rami Rosen <ramirose@gmail.com>

Applied to cgroup/for-4.20.

Thanks.

-- 
tejun
