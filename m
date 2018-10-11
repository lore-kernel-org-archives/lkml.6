Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EC9C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228C020841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMCTaqFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228C020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbeJLE7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:59:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35174 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbeJLE7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:59:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id e187-v6so10964699wmf.0;
        Thu, 11 Oct 2018 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TZ/XjSZEURH8lk59EVbHXcBZEWeH44yu85s6JWLw80Y=;
        b=CMCTaqFpJB9wmyrr0pyCsDUgGu8xhtOaqnM4umPioVa/7Q6aos8V4YK/QHuGmG1fPZ
         14Yjz70OWf+RrPG4I58jMweU+EpUsUP/kqEQNKE0GJXhBlaCBdmd9Lhhn3xbk33wNFOj
         hsZU43I7c3nZ+vv2FLjMYIjHzs+LIanpoilAOKB6VJ9jtFd+/hwFhjDOTAOxZ6hP+6T+
         BM9OBiVj/+mmV8hWTlu95660QlGroDJUygVlqccHWjvTQFB/GSyjl56RqrqQ4PdCp8sZ
         PzGsczJ2m9xtaOrgmJGOYQqPPuQcs623W84iawH8cBqC+YQAHJaxQP84zN6IFUTJhEgv
         P1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZ/XjSZEURH8lk59EVbHXcBZEWeH44yu85s6JWLw80Y=;
        b=QoauXvp55VO91DGklYxlH1Nb771dkViQOEEMXH1eda448kF6OjZpjDCK3pcKUEchUN
         hmb7fhiXSvRGw5S14gts5WclBjR1Bt4UUBHXTvstKhQicQShgFj1RkODFkj/J4Wzk5Yr
         CVz14mxkyf191nanWZMioL7WeJxK7ulS8j+t4pwXrfRIArkAHrPMuq6D8QQnnUliPMhy
         FH0y/r1+NtgV6Zr1+o3xalEzTERIlAPabHSgdNzoR7/sKMkqS6n7xnbvIPavfuWxb/ZF
         TLBCQEQP9cJj914ptRHKzwFSNji4cGf1+f6CdcRkKTC7cYU1wkb0EkKMno8f3LNnj9qz
         8FlQ==
X-Gm-Message-State: ABuFfohb2o9EyYxhadY+4PiQPvsdAHKmTksnQ1onAo/vgfhsgbxHn/1V
        PEWe4Jy0ewKStQfmI9qysg==
X-Google-Smtp-Source: ACcGV61BoxDKS4bZQSVbYpcOQDhF/SzSQNKgSi4qtSjTCjjgckjnclFsKd5JmVPi1AM3wpHfuyONxQ==
X-Received: by 2002:a1c:3795:: with SMTP id e143-v6mr3175212wma.9.1539293409303;
        Thu, 11 Oct 2018 14:30:09 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id a11-v6sm6957076wrp.3.2018.10.11.14.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 14:30:08 -0700 (PDT)
Date:   Fri, 12 Oct 2018 00:30:06 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
Subject: Re: [PATCH] proc: fix proc-self-map-files selftest for arm
Message-ID: <20181011213006.GA13485@avx2>
References: <20181011184359.15627-1-rafael.tinoco@linaro.org>
 <20181011205601.GA32757@avx2>
 <20181011210256.GE2401@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181011210256.GE2401@uranus.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:02:56AM +0300, Cyrill Gorcunov wrote:
> On Thu, Oct 11, 2018 at 11:56:01PM +0300, Alexey Dobriyan wrote:
> > 
> > As the comment in the beginning says this test is specifically for addresss 0.
> > Maybe it should be ifdeffed with __arm__ then.
> 
> Is there some other reason than allocating non-mergable VMA?

IIRC the reason is to test address 0 as it is effectively banned
for userspace so if it will be broken, it will be broken silently
for a long time.

As for "unmergeable" libc here doesn't map /dev/zero. I know how to
avoid even theoretical breakage by creating binaries by hand but it
will be probably too much.
