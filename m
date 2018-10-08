Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902A3C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4050821479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4PIyY9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4050821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeJIA7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:59:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39653 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIA7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:59:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so8389694pfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZY8bZ2xBQFg51chSva81weSb+0yW1O0m/mdCnEL7dJo=;
        b=l4PIyY9iJtb8ufEdPEpDpVxo0doPZaj4jEG4mIuYY78gjuje53dZJO3t7VpPaOiHiX
         9ARKDwciWtOc/kCMsCFPOe+ritrjl66GZjOhlP8ZIjQGIMvr7i1pIb88D+voFpYW2sJg
         PRmOVRBt0JgYPtM/sdWVAlLxwP7Kuc3T5eMhKWMvOGdfi3Kkwol2cgStNiJZnaiNXfan
         qKByDKfd1SAJNYqNmpOnZpg/OM/vlMILP6LOkznRMBAA0pygI66e8Dto/LuRDfzmGmQa
         +PCrbubvjzypwr/x4Wu7Dln6Plu53pImdysyVlQSKlwetVtjHGrPtM6Yp4rs4QKQhFRr
         KeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZY8bZ2xBQFg51chSva81weSb+0yW1O0m/mdCnEL7dJo=;
        b=Ulvmw227KZjndDZRH7pE8JdZM728TKe9Fm1/eXICBFHPf7hsViwKi3dAVXO/vMp9ie
         3bkw0pq7w8O9v1q6+fkx/3sYYzgbRMdQfwpZIUXPabup7NhrHJQhLLHVpRxVZhv638Ib
         ui51JNfb5bYhOSIoc2QUp3M8/n9VPjUm07vbNvxJ7imKRokYLP7UmOKVgfldR5aDguWO
         CMMzc063kpXX6azp2CoQ9BBS5Ke8cpOL1pI4gOhBByyYTXVRKCBwpMpyWCu5PRempGXj
         n2YNdIuc7qBWaQcU2Gj0PPlbVFcZ/RQNJ+IjXTjadrhRAnkvKIJfhqI7d7gjUEwDylaV
         1zgw==
X-Gm-Message-State: ABuFfohjNZv/SDHtbyu1y4GgCOcZbBUvhoCC2U4eW277WztWYM1O0lQd
        60VNhMWt+20LmS2/U73NDDc=
X-Google-Smtp-Source: ACcGV62GFVGu+HSesRyk6PYWl7mxDQLIkexPqbGaDT/VvpSdEe+5XPFEDMJwWH/b9DAme4I/qDinVg==
X-Received: by 2002:a62:7501:: with SMTP id q1-v6mr25982302pfc.225.1539020789909;
        Mon, 08 Oct 2018 10:46:29 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j15-v6sm21227884pfn.52.2018.10.08.10.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 10:46:29 -0700 (PDT)
Date:   Mon, 8 Oct 2018 10:46:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
Message-ID: <20181008174628.GB11442@roeck-us.net>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
 <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
 <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
 <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com>
 <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
 <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <c6880c5b-e259-4923-8d5a-80c620563398@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6880c5b-e259-4923-8d5a-80c620563398@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 05:22:24PM +0000, Koenig, Christian wrote:
> Am 08.10.2018 um 17:57 schrieb Deucher, Alexander:
> >>>> One thing I found missing in the discussion was the reference to the
> >>>> C standard.
> >>>> The C99 standard states in section 6.7.8 (Initialization) clause 19:
> >>>> "... all
> >>>> subobjects that are not initialized explicitly shall be initialized
> >>>> implicitly the same as objects that have static storage duration".
> >>>> Clause 21 makes further reference to partial initialization,
> >>>> suggesting the same. Various online resources, including the gcc
> >>>> documentation, all state the same. I don't find any reference to a
> >>>> partial initialization which would leave members of a structure
> >>>> undefined. It would be interesting for me to understand how and why
> >>>> this does not apply here.
> >>>>
> >>>> In this context, it is interesting that the other 48 instances of the
> >>>> { { 0 } } initialization in the same driver don't raise similar
> >>>> concerns, nor seemed to have caused any operational problems.
> >>> Feel free to provide patches to replace those with memset().
> >>>
> >> Not me. As I see it, the problem, if it exists, would be a violation of the C
> >> standard. I don't believe hacking around bad C compilers. I would rather
> >> blacklist such compilers.
> 
> Well then you would need to blacklist basically all gcc variants of the 
> last decade or so.
> 
> Initializing only known members of structures is a perfectly valid 
> optimization and well known issue when you then compare the structure 
> with memcpy() or use the bytes for hashing or something similar.
> 

Isn't that about padding ? That is a completely different issue.

Guenter
