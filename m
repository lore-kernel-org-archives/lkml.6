Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA3CC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F5020685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z18SQVnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F5020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbeKUDTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:19:08 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39507 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUDTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:19:07 -0500
Received: by mail-yw1-f65.google.com with SMTP id v8-v6so1028878ywh.6;
        Tue, 20 Nov 2018 08:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8CU25lHrO1FY40uNdnhUc0zkm2QTX3yunP2lI1VdBs8=;
        b=Z18SQVnDdQYOEqxh50XaL/a0dCPfQDq3LYrNEJEsQ4VgKNuNiHTSp/aWZEW+8y9xnZ
         wlJD9Ecum4v9RaJZeSKkaSYUUX0tjJOHh2sJqcYTwYg44yGi7i9jZ92miXUIx0vn4Mh+
         DEvl0K0xChGinDY8TUwnBeOohpWKrWobfcnCVt2d/pspLSxYxz42cLXD65RKKp7LL4VF
         EPc73qV1x/fTMOFGNsnkFwc4gM+QHgHbYeaRKaRwUv+Xk0Q9hyC5p9/hHdksrT5wZl6b
         HM3xGjrW3ooHf9r0ytPyicI3KAOGMILG+R+668HI2OM92/Ly+/MlVvnHJqKjjqdc9UC2
         BfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8CU25lHrO1FY40uNdnhUc0zkm2QTX3yunP2lI1VdBs8=;
        b=tvMIhZu1CrcSsEWxB541V5a8XgoDEJxiEyjPyGh85RduMeh1y7yC8z4yDzppysZ6mA
         8Mn62hUhPc12riLO2YBXN+dP4PZiijyOaBWZZNpGB+Bg5cEoBcExNz3VCIZZX0N6bM3R
         xUioer6t+1joUQK+jBiDecZTwliOWi0R+rMDm6DxRurCKHxhj6bCLB+dFggiOq7RxOD0
         wQ73isjiaQPDq6Y9uLzHaRaPxe7dLL0Q6OGqziDpmk+vwdG0/wmsjm3RTUPOaPdzSzoI
         HzydNSdtSCyikxBDoLYMDWeQJ5DygoKTwqY0S+rqDEnvOIP8YWSYCYb0BsKBdUXSznEu
         n9ig==
X-Gm-Message-State: AGRZ1gJgSYtVfNxsa0HZCBiIoNzMwbdgrt2IMJHsIVplylYjY9/lG3bo
        1C6cgINVHI+K7GGNFHh8LI15507a
X-Google-Smtp-Source: AJdET5eZ+R/dLEAKZZmsN9Yd2psfp6+pw/V1ag823wmndZGRHY9ksB+zo2YbLa/I6Q7xV3isO2YFJA==
X-Received: by 2002:a81:7744:: with SMTP id s65-v6mr2704868ywc.149.1542732542141;
        Tue, 20 Nov 2018 08:49:02 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:4b6a])
        by smtp.gmail.com with ESMTPSA id k80sm4926637ywe.61.2018.11.20.08.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:49:01 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:48:59 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 4/7] cgroup: cgroup v2 freezer
Message-ID: <20181120164859.GY2509588@devbig004.ftw2.facebook.com>
References: <20181117003830.15344-1-guro@fb.com>
 <20181117003830.15344-5-guro@fb.com>
 <20181120162529.GU2509588@devbig004.ftw2.facebook.com>
 <20181120163304.GA21462@tower.DHCP.thefacebook.com>
 <20181120163604.GX2509588@devbig004.ftw2.facebook.com>
 <20181120164349.GB21462@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120164349.GB21462@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 20, 2018 at 04:43:52PM +0000, Roman Gushchin wrote:
> > But that wouldn't udpate the cgroup's frozen state and generate
> > notifications, right?
> 
> Why? The task will be eventually trapped into cgroup_enter_frozen(),
> and from there cgroup_update_frozen() will be called.

Because the cgroup is no longer frozen?

> You are right, that notification will not be issued, because the cgroup
> is not changing its state (frozen->frozen). I'm not sure that it makes
> sense to change the cgroup state back and forth in this case. Are there
> any reasons I'm missing?

Imagine the task being trapped in nfs or wherever and not getting into
the freezer for an extended period of time.  That'd make the frozen
state reporting observably and obviously wrong when seen from userland
which can lead to other issues.

But, above all, because the cgroup is not frozen - it may have active
running tasks in it at that point.

Thanks.

-- 
tejun
