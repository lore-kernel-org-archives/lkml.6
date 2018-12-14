Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB16C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642F22080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8EIzMfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642F22080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeLNHYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:24:08 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44413 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNHYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 02:24:05 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so3704017iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 23:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upTfiP7iEd12IBycGzRmU4Z0acUxwmT5c1yFIwWuYd0=;
        b=K8EIzMfCOqFIj4GuH6k/sz4MW9JRkeMr3UaFHSBl2LOp9dRwjtVZstHRthKyikRRVq
         0QktT3jOQssB0Zk378XLCZ3CJnXLu2sM951yv3AlSQZkjJ1lRlcUkfH73z3bgUSj82Ab
         zdhjaXH9NlfNt+QoLb6FnUywZYJWX1l+VX76A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upTfiP7iEd12IBycGzRmU4Z0acUxwmT5c1yFIwWuYd0=;
        b=EJ+rsmC+nMMdaxOJRsFdCa87ROMO7PgIgJQkyU7igVHfZHzwK0kQbUhV6ZREE7hp4O
         /Ui6UPUrZ5FdQ10t1OhDH9T66EkLM654gl8fLJ5dT1ebE4XFhPqhJh315hzRt4pVkmix
         3gxwB//BdttAfz/YobRbGeEAGEi5z9yVQALIhouXnasbER1fUDzfPBJ9RuyZftcGtYOP
         x8ZMyXTOSVTkllI9vzKNB0d51t9zNu3NlPS5Ou8IBp4kcv7b2WxJIvMvuiqchPSv3Ps1
         lcUwifSeL5mdvGTy+DJpAG79NXbv4VJs1ahmqdoMXLNPwk9NDpaMz42uyg/R5BE2Wg1K
         QvmQ==
X-Gm-Message-State: AA+aEWZ4X1t7W/SMwvLsjf13IFFwKRwsxpMex4HkJqzGx2efz+6W0xpc
        8sZAQsqx5y+Ss4wn+50ac0/8W/9nX7XJ+UQsorzO/g==
X-Google-Smtp-Source: AFSGD/VNPhGUiANhgaIurvr9PdLT4FkdhdolieAqsX3nm31QvPxPs+KqsSAdSwf4SoDP+88TkPqB13+n3j+cCz7av/8=
X-Received: by 2002:a5e:cb0b:: with SMTP id p11mr1696773iom.60.1544772245087;
 Thu, 13 Dec 2018 23:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20181213052259.56352-1-cai@lca.pw> <20181214040819.58625-1-cai@lca.pw>
In-Reply-To: <20181214040819.58625-1-cai@lca.pw>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 14 Dec 2018 08:23:54 +0100
Message-ID: <CAKv+Gu80cxx6L3KYyYnsyjbrWN6iTp76jcdBio27b_h+dAzaHw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: invalidate TLB just before turning MMU on
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 at 05:08, Qian Cai <cai@lca.pw> wrote:
> Also tried to move the local TLB flush part around a bit inside
> __cpu_setup(), although it did complete kdump some times, it did trigger
> "Synchronous Exception" in EFI after a cold-reboot fairly often that
> seems no way to recover remotely without reinstalling the OS.

This doesn't make any sense to me. If the system gets into a weird
state out of cold reboot, how could this code be the culprit? Please
check your firmware, and try to reproduce the issue on a system that
doesn't have such defects.
