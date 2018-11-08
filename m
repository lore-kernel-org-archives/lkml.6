Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A74C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD82A20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z17JAWVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD82A20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeKHS03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:26:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38714 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHS03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:26:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so20299624wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 00:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/YsDHE9CMNb1+2UKSEq+7glbT2IHfxAD8Xwng3F30rY=;
        b=Z17JAWVzLGEwXorq3Cug9XMrpWZCPKt0fn1vVurE5WqBy8oaK2GW752LPWqk91JaaG
         v76Hkf6SVYh41cp9iy2wGbK5JDgLPpHed5UOqHeDCosHj3C85gY+j0Yk6mLQSjE7xq+B
         V5ZNhwRYEdnP/M4WfOOpr6tj2RuE3ROFcZAJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/YsDHE9CMNb1+2UKSEq+7glbT2IHfxAD8Xwng3F30rY=;
        b=EewtAmcOmhb3PE4v8ztpViXVFHaqKlxh2W/QZ2FVr5A8RbqnJ7Bm87xbiB1/1X6jaW
         EYHQnAMJ86Nj1zFWgJW50+gmCviV6XoSzjNnwicEg3VMu+etW0ln7/K3G7P+cwUOlFgi
         WNaO47EpaB4EyyhJl9o0fHgIF1/mXXVuO0aF8TS8BUjM/0M2AqOYIxGf+blsSzmgyH9n
         AzrSJC7wmgRmqe01eVwVImnkZIq9gp7/91SpfIdGWBHDrvCY6PUqJT3+As0ANAlIIwdz
         xfopcurtRJcsKg23nGynbYPFIKdiNYSxAB0HZ82dzFqpc55dV7lSc8k3MkuAelHopZub
         AN5g==
X-Gm-Message-State: AGRZ1gKUsk6kdze40JgLz05xfNgdQwH9wKyn1aVEdvPfZHDA62j9mIX9
        SHIim4BlviHwAtSyFx0cTuuosg==
X-Google-Smtp-Source: AJdET5fioVj8gFcrXKEiEKr04NZP0gd2fwBEUWiL9UfQxSB+YAJ/WErPp6LX4JqBoEvBnbUvVvwF2g==
X-Received: by 2002:adf:e84e:: with SMTP id d14-v6mr3143888wrn.51.1541667119584;
        Thu, 08 Nov 2018 00:51:59 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id 134-v6sm4702792wmp.6.2018.11.08.00.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 00:51:58 -0800 (PST)
Date:   Thu, 8 Nov 2018 16:51:52 +0800
From:   leo.yan@linaro.org
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@redhat.com, Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Question: perf dso support for /proc/kallsyms
Message-ID: <20181108085152.GA1925@leoy-ThinkPad-X240s>
References: <20181102025516.GA25374@leoy-ThinkPad-X240s>
 <20181107141006.GD12870@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107141006.GD12870@krava>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Wed, Nov 07, 2018 at 03:10:06PM +0100, Jiri Olsa wrote:
> On Fri, Nov 02, 2018 at 10:55:16AM +0800, leo.yan@linaro.org wrote:
> > Hi all,
> > 
> > Now I found that if use the command 'perf script' for Arm CoreSight trace
> > data, it fails to parse kernel symbols if we don't specify kernel vmlinux
> > file.   So when we don't specify kernel symbol files then perf tool will
> > roll back to use /proc/kallsyms for kernel symbols parsing, as result it will
> > run into below flow:
> 
> yep, AFAIK if there's no vmlinux found we fallback to /proc/kallsyms
> 
> > 
> >   thread__find_addr_map(thread, cpumode, MAP__FUNCTION, address, &al);
> >   map__load(al.map);
> >   dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
> >     `-> data_read_offset()
> 
> so what is the actual error you see in the perf script?
> unresolved samples? could you please describe your config
> and workload?

So at my side the error is the CoreSight trace decoder fails to
generate samples if the sample has kernel address, thus the decoder
doesn't generate any kernel sample if use kallsyms as dso.

For more detailed info is: the CoreSight decoder needs firstly to get
dso related info by calling dso__data_read_offset() [1], if we use
kallsyms then this function always returns failure then this leads the
docoder to discard all kernel samples.

Regarding to testing case, I can simply run 'uname' program so it can
produce kernel and user space trace data, if I use 'perf script -k
vmlinux' then I can see perf generate samples for kernel related traces,
but if use 'perf script' then only can see samples for user space.

Thanks,
Leo Yan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/cs-etm.c#n302

> > I can observe the function data_read_offset() returns failure, this is caused
> > by checking the offset sanity "if (offset > dso->data.file_size)"  (I pasted
> > the whole function code at below in case you want to get more context for it),
> > but if perf use "/proc/kallsyms" to load kernel symbols, the variable
> > 'dso->data.file_size' will be set to zero thus the sanity checking always
> > thinks the offset is out of the file size bound.
> > 
> > Now I still don't understand how the dso/map support "/proc/kallsyms" and
> > have no idea to fix this issue, though I spent some time to look into it.
> > 
> > Could you give some suggestion for this?  Or even better if you have fixing
> > for this, I am glad to test at my side.
> > 
> > static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
> >                                 u64 offset, u8 *data, ssize_t size)
> > {
> >         if (data_file_size(dso, machine))
> >                 return -1;
> > 
> >         /* Check the offset sanity. */
> >         if (offset > dso->data.file_size)
> >                 return -1;
> > 
> >         if (offset + size < offset)
> >                 return -1;
> > 
> >         return cached_read(dso, machine, offset, data, size);
> > }
> > 
> > Thanks,
> > Leo Yan
