Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90A51625709
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7D620892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRnNB8aP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7D620892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbeG3T13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:27:29 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:46263 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbeG3T13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:27:29 -0400
Received: by mail-yw0-f196.google.com with SMTP id e23-v6so4686611ywe.13;
        Mon, 30 Jul 2018 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2GUU2NQxPe+c5GHCdzu0ZJwdHlbVGMaZie+kRtpGjyI=;
        b=oRnNB8aPWbfW1sKOERCxwdKy5HH738RdZ7KEXB7jauHElr680EK9s5FGpqz/2JejVN
         5/3I2hyM2gQp4PJ5CsOwwnOZqDd7JMsRMV2uakaab5DcDfUACwAe3/qIjt7RzGd+gVH2
         i5hEOS1UBX40YdQVb5cg/M0crv88ahLVdAXWhQ88uTBoDxYG6QMOIim77tL4xSadgghz
         bmRd4Segi+pMkuh+HevNormpOAV/kDSIUoRUH9OprFzY1s2qkeJWg5XcOXlIDX+v1v63
         ZUoWJyEELZSMYR7HCT1N3tiK3gfFauiRUwNErxaAoW2rrzCqbQM3fISqRUpTlTDOgPH/
         7VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2GUU2NQxPe+c5GHCdzu0ZJwdHlbVGMaZie+kRtpGjyI=;
        b=hupcZC0mA0h6KMvQn5c8ndigm7WqdH3C3IcrzVbNCQnpyHzwHzxr9Y1uUT63BdF6tO
         d/gf5LacI8sFUgqXgKHT07SQK0VQhTLQG8TMRaLfBLTs04fgBOe0z5KfOSaKZPB4iWaa
         pi+BEYhZJ3ezIZqxUMyoNbpEb0nmFvoKhmlXNsfjkjg++HTEWRtCIt+5OxXV9BqOZqs6
         DHZv67T6P8pcQHF72DUECjZIU2ry4XV5dqX3RI7Kk+m22VcdjNI3Bw4kDXpy+hbHOvSQ
         TaImOF2IsmSTYIrHsDAmIYNI8q2W3spbebdt8l6rd3Pwub3EAtrqkN685p4I6Vvdeesw
         GAIA==
X-Gm-Message-State: AOUpUlFAcEWEahQoT9Wofey/SR5IEeqa292bYtBkpRyzjriOC8jmIWE4
        q21QT1IbfKe7iOCUJPSUy7M=
X-Google-Smtp-Source: AAOMgpcYeCVHmVoJsk64cuoQwZl8VvBnMCYITgIlSd2nteztBMD4h4nG3X5vlHvl79arFG46qP1bfQ==
X-Received: by 2002:a81:502:: with SMTP id 2-v6mr9644734ywf.139.1532973083360;
        Mon, 30 Jul 2018 10:51:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:4bfe])
        by smtp.gmail.com with ESMTPSA id w199-v6sm4768474ywd.104.2018.07.30.10.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 10:51:22 -0700 (PDT)
Date:   Mon, 30 Jul 2018 10:51:20 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory,
 and IO v2
Message-ID: <20180730175120.GJ1206094@devbig004.ftw2.facebook.com>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180727220123.GB18879@amd>
 <20180730154035.GC4567@cmpxchg.org>
 <20180730173940.GB881@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730173940.GB881@amd>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 30, 2018 at 07:39:40PM +0200, Pavel Machek wrote:
> > I'd rather have the internal config symbol match the naming scheme in
> > the code, where psi is a shorter, unique token as copmared to e.g.
> > pressure, press, prsr, etc.
> 
> I'd do "pressure", really. Yes, psi is shorter, but I'd say that
> length is not really important there.

This is an extreme bikeshedding without any relevance.  You can make
suggestions but please lay it to the rest.  There isn't any general
consensus against the current name and you're just trying to push your
favorite name without proper justifications after contributing nothing
to the project.  Please stop.

Thanks.

-- 
tejun
