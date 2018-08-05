Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7F2C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E70121898
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hv+IykXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E70121898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbeHERYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 13:24:32 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45374 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeHERYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 13:24:31 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so17892123oic.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 08:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vb19Oyv2v4zP66s8RVPlDKjv8CAt7YWeFYapQL1HDKg=;
        b=Hv+IykXGdhDJbS+N87UoS/xcUyzR6po1W09dLnZMCBgniylS55KUE8KHErUYS0ZeRm
         2VV86LV3GEwBmLblMS3+RGdcpCaA6X5g42I53xyNOaWKV+ADeLtWQ4zvrqRlDHLEfTTt
         2evhu9ux1M+Va5OeeJp4nQVYresqKODkLhbtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vb19Oyv2v4zP66s8RVPlDKjv8CAt7YWeFYapQL1HDKg=;
        b=QnOVE0+8lHGOFGPTuxk+YYr709/f/DLRZ4f+8erwE5QJJgYYjho1FFTSgUFKpO59Gb
         yxrpWV18QWT8Pj+ZyUaHqAGebvTQL18v3WmKZZm/eWERl1nnisN8nDjDpH6GO8QCbK+k
         Y5bFYBdoAfq0y4L0sCDkzLHmMqxZ/085Z7Pj20wQXZ5WWSlhNKJd9ZIqy5+fEyH14Xys
         f70TqnyG/SEvbxfam/d7mlXLR5Fpma9M8LGZc7dnpP2TKpl0Wwgln8JGA4Q3Ot1GlUR/
         bfPzZXqzYbZMLsubcRIkOS9M9HDCKxvSuBKWZeX77iC/dgf+OWa4cNtceNtqVgseON1C
         /08A==
X-Gm-Message-State: AOUpUlEKPL3hrimnmNVoCLHovWrGG5B8nfu3zyUW0BwmBISrQZFVtyt+
        JsKlqbCDy+I7MsuBErsT2xYFIQ==
X-Google-Smtp-Source: AA+uWPx0mZ1QtK21cIc05L2oZycwUIg0MDY/fqj00Ke9XJfDRCoVqzKzVZ7iHN+iLGRc0RWoFSDyuw==
X-Received: by 2002:aca:d9c5:: with SMTP id q188-v6mr10279923oig.239.1533482374889;
        Sun, 05 Aug 2018 08:19:34 -0700 (PDT)
Received: from localhost ([2600:3c00::f03c:91ff:fefc:c793])
        by smtp.gmail.com with ESMTPSA id m11-v6sm8474607oif.27.2018.08.05.08.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 08:19:33 -0700 (PDT)
Date:   Sun, 5 Aug 2018 15:19:33 +0000
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.4 000/124] 4.4.146-stable review
Message-ID: <20180805151933.efzi3mawp22p3wex@linode.therub.org>
References: <20180804082702.434482435@linuxfoundation.org>
 <CA+G9fYsZtw-OHh2cKC0VG5zwdKOMvnOx-cAVfp2qfY_drFQ4_Q@mail.gmail.com>
 <20180805134952.GA15972@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180805134952.GA15972@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 03:49:52PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Aug 05, 2018 at 05:24:21PM +0530, Naresh Kamboju wrote:
> > On 4 August 2018 at 14:29, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > This is the start of the stable review cycle for the 4.4.146 release.
> > > There are 124 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Mon Aug  6 08:26:39 UTC 2018.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.146-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > Results from Linaro’s test farm.
> > No regressions on arm64, arm and x86_64.
> 
> Really?  How did you all miss the netfilter bug that was introduced by
> this series?
> 
> Anyway, thanks for testing, but I'm worried...

I took a look through our test suites to see where we may have coverage for
this. There is a netns series of tests in LTP [1], but we've had trouble
getting them running successfully in the past and so they are being skipped. I
don't know if it would have caught this particular issue, but I'll find out,
and also see if we can get them working and running again.

We also run the net/ tests in kselftest, but there aren't that many, and of
course running kselftest the way we do is not a well supported usecase (running
all of 4.17 kselftest against 4.4 kernels, skipping tests that are broken).

So I would ask, how would net/ expect such things to be tested, and what can we
do to help?

Dan

[1] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/containers/netns
