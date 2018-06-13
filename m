Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E7D83C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D49C20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGkOYpil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D49C20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934991AbeFMJKw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:10:52 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35848 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934073AbeFMJKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:10:50 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so1173283plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tmJj/AGY7havFFFto6BAqmUv34uYsXwARafmx3s4EDY=;
        b=dGkOYpildd4JZG6OysptjyuaIx3MT3eOj58pAZSoTKeWj9Ji15/m6kiHyjJUDuiKhQ
         Deog+D9cMu7BMOkAODxIm3DPhmteQTbPT/ZD5236uN/j0PNSplLE8gfV+dShWn03NqeZ
         XOK0SpGatPDqZ2ERWGRbdIqykS9GP6O4wWzTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tmJj/AGY7havFFFto6BAqmUv34uYsXwARafmx3s4EDY=;
        b=nC36frsI9c59NETudL4WIkjEAgfcwYtfm/TgBXg689/LNOT0V8ttPxAyvAd+WXz0N+
         NAhLTWnlVjYOnQny8PznMgY7aRI0MOLWSLkZC0C0Kb5xN4Y9kNDv2S1tQq0snEXXAs6T
         Y/eMjhi3v3hVZaEyXYHNuI0dbGhS0C0iJZvJY3TGphVqBR4bktmd4UyK/+ThX+mmVhgO
         SxG6TLN1ATY8tBNO5QUPNMSnIS24bMlhietzPpXWnTvFE8QLqaXmDDYlJxNDl7O66T5H
         wKCtNMQqEHmiebapmzt0iElmetDIHez8UZx4RLvWoEy1SfuDiZ715pDDtaNCKRmgo361
         yYTw==
X-Gm-Message-State: APt69E3+/Dr383BDgG2Bx33+Pav+jMoztfoM9Nqw1A1j3qpRB3UNQXbr
        RafvDds8HXGos52oFOAJRYAdHQ==
X-Google-Smtp-Source: ADUXVKK/bI3BbsUZv8nEm+Q2C+k2gNtTSVeUpZA3H4W0+FxNTpRiZTKLGNnCaBEpYeK//IBq0iSkTQ==
X-Received: by 2002:a17:902:3081:: with SMTP id v1-v6mr4406216plb.266.1528881049821;
        Wed, 13 Jun 2018 02:10:49 -0700 (PDT)
Received: from localhost ([223.226.91.101])
        by smtp.gmail.com with ESMTPSA id u14-v6sm3836874pfd.103.2018.06.13.02.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 02:10:49 -0700 (PDT)
Date:   Wed, 13 Jun 2018 14:40:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180613091047.mfhtgrdypx2qvndp@vireshk-i7>
References: <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
 <20180612125247.GO12217@hirez.programming.kicks-ass.net>
 <16770447-afe3-0fd7-19f9-1bd52c4c8ced@linaro.org>
 <20180612140654.GQ12217@hirez.programming.kicks-ass.net>
 <cce05d92-d51a-ab4f-83f2-37dcdee0cd6a@linaro.org>
 <20180612155841.GT12217@hirez.programming.kicks-ass.net>
 <7190a58e-05f2-216c-8b36-70692fa722bf@linaro.org>
 <20180612173514.GV12217@hirez.programming.kicks-ass.net>
 <20180613085509.s7ktdespfyjpozuu@vireshk-i7>
 <b9dba62b-35df-46a9-a66c-3ec0952109b6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9dba62b-35df-46a9-a66c-3ec0952109b6@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-06-18, 11:03, Daniel Lezcano wrote:
> nr_threads(smpboot) <> nr_threads(idleinject)
> 
> If we are facing races issues, it is because we are trying to avoid
> using locks in the code path. With lock and proper refcounting that
> should be solved, AFAICT there are similar races with inodes.

I am not sure if locking can make things better here. We aren't using them as we
don't really need them AFAIU :)

-- 
viresh
