Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBE0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9BB20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEQFgAFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9BB20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeLKKTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:19:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33244 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeLKKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:19:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so8636248wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jkOS+QCEdJo7wV+YvHLMQGYbpemDbMOlvhOduaGxWt0=;
        b=LEQFgAFnPB50HlQkp+zY3vYzrcCp9bYzCRfWmdun/wI9KySg7HQD9D5FFkGNDHLV2k
         s0N4pIHhaphEvg7tzMHTz54cO2ggeMDNhnoF40Ht+k/RWwBTOmt1xK/HznqYf6NPRe2N
         OBwVojSj5ooPJRosqKegAOQNAePZcCvWc68L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jkOS+QCEdJo7wV+YvHLMQGYbpemDbMOlvhOduaGxWt0=;
        b=JYP6dBcS9RJ6SfDx+Hz7lLbILYxuNWHVr9gafuVlVJiLYeCdNmrhwG6s+Cz0F9JMZq
         VcPTJGgTWXH5mWvbWZYNFvWt3RM6IfhatMRYdUxQYHGU0Jl/ALQpSvc5AItlXnbMq7ST
         jngSfFFbjgdc0teWMVYrwFNtz7NlsrQo9PN3FIU7lxZCpOT6UmpBln1flLks6TlqCutp
         t+a5kLWI22T9DMKhZU6VdVteIzcyJkg7ApCWU56LgzVTfjhOi9OLjX4WwMw/6a/y/ieG
         0Ub3icG4v5L2t9JNahG1ygw6D8ZQQl9/GiFYb9vTf2KOSJSorn8XuJaI4LP1ZrAlIcTm
         MLOw==
X-Gm-Message-State: AA+aEWY8rzrXbpAaw/3O2Pfk5YpnsGKiXuHMEIFlwrY031Fv2WhHu3Z/
        36/thJAW2FetZGE6K3C+4VfURg==
X-Google-Smtp-Source: AFSGD/WgLSyIhvjCZlq0207RwtLa3sSxyS0hkKp9qdWEMb4bwByqPtznBtQZtPLnzC6MHsyaHN6fGA==
X-Received: by 2002:a1c:384:: with SMTP id 126mr1789953wmd.26.1544523569405;
        Tue, 11 Dec 2018 02:19:29 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id o64sm1848735wmo.47.2018.12.11.02.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 02:19:28 -0800 (PST)
Date:   Tue, 11 Dec 2018 18:19:21 +0800
From:   leo.yan@linaro.org
To:     Lei Wen <adrian.wenl@gmail.com>
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        leiwen@outlook.com
Subject: Re: Coresight etmv4 enable over 32bit kernel
Message-ID: <20181211101921.GD3128@leoy-ThinkPad-X240s>
References: <CALZhoSRaR-eMyr7HKUTDi5oRiJfRZ7x1NRRM49v-nn6U7e9sJg@mail.gmail.com>
 <CANLsYkzTGnPQ3FUPWYc-DOigvzMuTFTGqbbVTqqtVuCQW3esSA@mail.gmail.com>
 <CALZhoSR6QXSUzEY5SuiC96jDAARE-+9=LxNXo4WoZkVcL8gM6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALZhoSR6QXSUzEY5SuiC96jDAARE-+9=LxNXo4WoZkVcL8gM6Q@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lei,

On Tue, Dec 11, 2018 at 05:11:02PM +0800, Lei Wen wrote:
> On Tue, Dec 11, 2018 at 2:02 AM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> > Good day Adrian,
> >
> > On Sat, 8 Dec 2018 at 05:05, Lei Wen <adrian.wenl@gmail.com> wrote:
> > >
> > > Hi Mathieu,
> > >
> > > I am enabling etmv4 coresight over one Cortex-A7 soc, using 32bit kernel.
> > > And I am following [1] to do experiment regarding the addr_range feature.
> >
> > That wiki is very old and after reading it again I seriously consider
> > removing it.  It is still accurate but there are better ways to do
> > things now, i.e perf.  The main openCSD documentation page [2]
> > contains everything you need to know about the integration with perf.
> >
> > [2]. https://github.com/Linaro/OpenCSD/blob/master/HOWTO.md
> >
> > > The default addr_range is set as _stext~_etext, and it works fine with
> > > etb as sink,
> > > and etm as source. I could see there are valid kernel addresses using OpenCSD.
> >
> > I'm really curious about how you use openCSD to validate your traces -
> > can you  expand more on that?
> 
> 
> I just manually replace the cstrace.bin in the
> decoder/tests/snapshots/juno-ret-stck/.
> And modify the register data according to my platform.
> Then produce the decode result by below command:
> ./decoder/tests/bin/builddir/trc_pkt_lister -ss_dir
> decoder/tests/snapshots/test -decode -logfilename 2.ppl

Just remind, you also could refer TC2 platform, I think it can be more
close to your platform with CA7 CPUs.  And except cpu_X.ini files, you
also need to modify snapshot.ini & trace.ini under the snapshot
folder [1].

[1] https://github.com/Linaro/OpenCSD/blob/master/decoder/docs/specs/ARM%20Trace%20and%20Debug%20Snapshot%20file%20format%200v2.pdf

> > I think the results are misleading you since the openCSD library can't
> > readily be used to decode sysfs trace sessions.  The wiki doesn't
> > mention using openCSD to decode traces either.  The only integrated
> > way to use openCSD to decode CoreSight traces is via perf.  Again, the
> > link above will give you all the information you need to do that.
> 
> >
> > >
> > > But while I try to store one small range of address pair, which contain only one
> > > kernel function. It doesn't behavior like what said in [1], the write
> > > pointer would
> > > grows rapidly with the read pointer. And I dump the etb buffer and parse it with
> > > openCSD, finding that there is no I_ASYNC packet in the dump and is fulled with
> > > I_NOT_SYNC.
> > >
> > > So my question is why ETB continue to grow when there is no trigger at all?
> > > Is it normal? I could provide more info if you need it.
> >
> > I am dubious about the validation process and as such can't comment on
> > this.  Please share your results using the perf integration and then
> > I'll be able to have a better idea of what is going on.
> 
> I see... I would try use perf to get more result and get back here.

I verified mainline kernel with perf tool, it can work well on Juno
board for address range filter.  Please ensure you are using a newer
kernel version (e.g 4.16 but not 4.14, 4.14 kernel doesn't contain
cs-etm decoder in perf tool).

[...]

Thanks,
Leo Yan
