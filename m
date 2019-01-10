Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B591C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D67520675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIfTFNWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfAJANE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:13:04 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46036 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfAJANE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:13:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so10451577qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=F2DKBpfL8hd4zEaAUPCu7YhS0w4KpnJ8pve5IA7F9m8=;
        b=ZIfTFNWFLbpHaJ3knOoOK/DRLAknYAjbWevj8TlidJPYvi8i4kWTh37iH1nfU7tCaz
         tzrDV+ao2a5KEFyvVHcu+SoRKHOjPhVl5OJLQ+cAVV1UJuKW2pv0vEtq4ldDnxzdYY2G
         jJ36LvFVr8SX+CICKzMNEAW43wu+AcNXWxn2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=F2DKBpfL8hd4zEaAUPCu7YhS0w4KpnJ8pve5IA7F9m8=;
        b=apnMPdZwWdDO/Owo07+WsBH5JJpTR5CvLePy3NiJ1zwUl2Hl+yelCTL4TCV7xfbl1v
         7k1kZgrBMhiXa2/SM89k1Kpx78wY64El/vP46laSHAn/41qXrRLfsD7XOkhOORYZYm0h
         XPa3wypwcooIp7pPBWZWaqsqLYli1t9Rrm+TcvoTTe99A5h+MaqSRZUw0fojPhSX/3T1
         AOApOU4W3i8s6HSsW0EmuqnO2JUN54Zxx7lUN5XNn3CmVhIVEe5heIMUvxd5qUm4L1gw
         d+RErlRvnz5kh7nZ5b0NM/j4nLExq/KJQIx1AJI8vXF9P8SHDC3a8Ult/luzFCaC1mzA
         PVMg==
X-Gm-Message-State: AJcUukczFjMoaZZGLRdimiiBJLDnjwAqzQlIQ/nXVLSWy1IlMYopkRTI
        fo+gMmeUFba5YR4lvCE4ihaSgo1tWHE=
X-Google-Smtp-Source: ALg8bN6OHGwU8r/I2clR1HksHkrJF70Es7Ho+8wWTE8psLDli/mh4x88j+4b4XMvEzn3O+ZDIBr7Uw==
X-Received: by 2002:a0c:a9da:: with SMTP id c26mr7580877qvb.140.1547079183447;
        Wed, 09 Jan 2019 16:13:03 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id d85sm5635396qkb.89.2019.01.09.16.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:13:02 -0800 (PST)
Date:   Wed, 9 Jan 2019 19:13:01 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Dave Mielke <Dave@mielke.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] vcs: poll(): cope with a deallocated vt
In-Reply-To: <20190109035504.8413-6-nicolas.pitre@linaro.org>
Message-ID: <nycvar.YSQ.7.76.1901091853070.2635@knanqh.ubzr>
References: <20190109035504.8413-1-nicolas.pitre@linaro.org> <20190109035504.8413-6-nicolas.pitre@linaro.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019, Nicolas Pitre wrote:

> When VT_DISALLOCATE is used on a vt, user space waiting with poll() on
> the corresponding /dev/vcs device is not awakened. This is now fixed by
> returning POLLHUP|POLLERR to user space.
> 
> Also, in the normal screen update case, we don't set POLLERR anymore as
> POLLPRI alone is a much more logical response in a non-error situation,
> saving some confusion on the user space side. The only known user app
> making use of poll() on /dev/vcs* is BRLTTY which is known to cope with
> that change already, so the risk of breakage is pretty much nonexistent.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

That patch introduced a small unwanted behavior change that I intend to 
fix in a follow-up patch (it will be tagged [PATCH 7/6]). I prefer to go 
with a separate patch rather than respinning this one as this gives me 
the opportunity to separately document said behavior.

Nicolas
