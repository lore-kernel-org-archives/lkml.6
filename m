Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43808ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97D02064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JCTYNFSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97D02064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJSQ6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:58:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33117 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSQ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:58:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id l14-v6so21767818edq.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fb8u+KD7ky8wr/Rck0MAPBxjyk80mRfFllGxjnSsm4k=;
        b=JCTYNFSXYtQB2N15t8+T0FaCt2+xP56Y/3ITowr8yXWapZ9fnEoAJcJhrYNJJph2/F
         kFVC13oEzakG8cPG+2tPmvsyBOAXogUK6bHZW9UbW6b9155y+z8MTBTXFm5YdhBmy/IF
         T9FRSLG0vaTeIxaKEqWKfdeekjbYG2dmcZ19w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Fb8u+KD7ky8wr/Rck0MAPBxjyk80mRfFllGxjnSsm4k=;
        b=T+Evw9lz12/UnhWRXBbiz1QEY6ECs0KqgpBJJtpn68p6krmedDhHg+mpVPFZQlOMXf
         pLPkXOgDMEBcV5ipLjlSky+9dUKMiITJ7WkiHhDDNS1Sb+EdjgbbpPIB1RNzq0x5h0uR
         ZqTza79h2onQV78ICwYHOeHBLeB+lTvRLXYD4oy8PDeOicx3ILNAkWKjiLIk9tW8bU6y
         RkttbaOucG+6Z7++9cBW6L2tXUjvFlMnb3JWXJGy4ahQ90c7nDaL7+ju3ulb6il3fusq
         92cZz7U/2hyej4hFtYtuMm2+DfVGHL1/xRBrc8kI0FQHGoZ3/RlUWp13WoZ+83r2aaI3
         vq2g==
X-Gm-Message-State: ABuFfogDjzYB6FGCPCbjJY5ATL5/5m74m4wkSRbmvwdvE1VCftSexKoo
        Cb+In8zkRWDFAR78HlLmnYkfH4iY/vo=
X-Google-Smtp-Source: ACcGV62/AFErS1oq6NMU1F9Avj3jsriWC89QorFlNFUq7xXJd+QV8XJSOl+dvXTwiyE38Pa8nRQv4g==
X-Received: by 2002:aa7:c4cb:: with SMTP id p11-v6mr5481309edr.285.1539939191203;
        Fri, 19 Oct 2018 01:53:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c27-v6sm8638364edc.4.2018.10.19.01.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 01:53:10 -0700 (PDT)
Date:   Fri, 19 Oct 2018 10:53:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peng Hao <peng.hao2@zte.com.cn>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Martin Peres <martin.peres@linux.intel.com>
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
Message-ID: <20181019085308.GY31561@phenom.ffwll.local>
Mail-Followup-To: "Koenig, Christian" <Christian.Koenig@amd.com>,
        Guenter Roeck <linux@roeck-us.net>, Peng Hao <peng.hao2@zte.com.cn>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Martin Peres <martin.peres@linux.intel.com>
References: <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
 <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
 <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com>
 <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
 <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <c6880c5b-e259-4923-8d5a-80c620563398@amd.com>
 <20181008174628.GB11442@roeck-us.net>
 <4a1faa3b-8c42-b742-9b55-9d2711f7ecc1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a1faa3b-8c42-b742-9b55-9d2711f7ecc1@amd.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 06:13:56PM +0000, Koenig, Christian wrote:
> Am 08.10.2018 um 19:46 schrieb Guenter Roeck:
> > On Mon, Oct 08, 2018 at 05:22:24PM +0000, Koenig, Christian wrote:
> >> Am 08.10.2018 um 17:57 schrieb Deucher, Alexander:
> >>>>>> One thing I found missing in the discussion was the reference to the
> >>>>>> C standard.
> >>>>>> The C99 standard states in section 6.7.8 (Initialization) clause 19:
> >>>>>> "... all
> >>>>>> subobjects that are not initialized explicitly shall be initialized
> >>>>>> implicitly the same as objects that have static storage duration".
> >>>>>> Clause 21 makes further reference to partial initialization,
> >>>>>> suggesting the same. Various online resources, including the gcc
> >>>>>> documentation, all state the same. I don't find any reference to a
> >>>>>> partial initialization which would leave members of a structure
> >>>>>> undefined. It would be interesting for me to understand how and why
> >>>>>> this does not apply here.
> >>>>>>
> >>>>>> In this context, it is interesting that the other 48 instances of the
> >>>>>> { { 0 } } initialization in the same driver don't raise similar
> >>>>>> concerns, nor seemed to have caused any operational problems.
> >>>>> Feel free to provide patches to replace those with memset().
> >>>>>
> >>>> Not me. As I see it, the problem, if it exists, would be a violation of the C
> >>>> standard. I don't believe hacking around bad C compilers. I would rather
> >>>> blacklist such compilers.
> >> Well then you would need to blacklist basically all gcc variants of the
> >> last decade or so.
> >>
> >> Initializing only known members of structures is a perfectly valid
> >> optimization and well known issue when you then compare the structure
> >> with memcpy() or use the bytes for hashing or something similar.
> >>
> > Isn't that about padding ? That is a completely different issue.
> 
> Correct, yes. But that is the reason why I recommend using memset() for 
> zero initialization.
> 
> See we don't know the inner layout of the structure, could be another 
> structure or an union.
> 
> If it's a structure everything is fine because if you initialize one 
> structure member all other get their default type (whatever that means), 
> but if it's an union.....
> 
> Not sure if compilers still react allergic to that, but its the status 
> I've learned the hard way when the C99 standard came out and it still 
> seems like people are working around that so I recommend everybody to 
> stick with memset().

Went boom:

https://bugs.freedesktop.org/show_bug.cgi?id=108490

Can we revert?

Also, can we properly igt this so that intel-gfx-ci could test this before
it's all fireworks?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
