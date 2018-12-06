Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAF6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9C12146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVLVzAlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9C12146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeLFFqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:46:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39520 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeLFFqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:46:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so21948060wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 21:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9edkJWCLt7sQ9fhpxgG40pGGEUkb70TMl96x5JqM0ZM=;
        b=DVLVzAlx4WAet+GkDXPI5Ps5vDzDGT61PsUO2+Z1ojWgf8aAzvk9+nq7pqfIjimruo
         n1uQK4TpHXdUJHOLQosYhMoW6QdzkTa6Wzd/X3/+Zlu8sdLrvi9GXD/wdIqwl/udTnF/
         9V0iGGlWb2yYsW45QPyqyTurZlFbQzNeLtjzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9edkJWCLt7sQ9fhpxgG40pGGEUkb70TMl96x5JqM0ZM=;
        b=INYXjhVgyvRcV/N/6Exu/4Ac+3QMd46+jeevNjWaBCiuZIfxJ87siCybwPTNo19DvM
         u4M31tn9Ha1T8y44kz2E58AYqIeaMzbclRZkV1jKOdYhI+fqWvXH72xAmH6rB7+9ICfO
         TT8LsylHRZLicVxibDBPWP6VSmEHwSG5UF+/otfPGY/Chh5/mg5Oay6f2px2+1gfTGeX
         RvZOukfVjQ1CtVpNvy3onXPnlZ0nQ/puwUdxZwWtuoU0WlqCv//CqZqMmyapIan2eie8
         un8BCRxCmEVie6qwCKg8UZvMSFjWXiIe+2cR/nvzia0nIwhSMaf97vHKsf+OEPs+FBIt
         zF8w==
X-Gm-Message-State: AA+aEWayx38bIYb0ZGVcvOUIov5GsUhibiuyj39397u/J+DGSMTrW7yW
        yVUSKSzDhCxyU9KDb4bEmiV40g==
X-Google-Smtp-Source: AFSGD/VuEOIcHI/jN4Id4UlWwF4tisVfSHnLXO6O1tGZL5lvC6F7/0zizlv4NHMtABF7jOgTeLn6Dw==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr22847147wrd.20.1544075162336;
        Wed, 05 Dec 2018 21:46:02 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id n6sm11468423wmk.9.2018.12.05.21.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 21:46:01 -0800 (PST)
Date:   Thu, 6 Dec 2018 13:45:53 +0800
From:   leo.yan@linaro.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Al Grant <Al.Grant@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v1 3/5] perf cs-etm: Support for NO_SYNC packet
Message-ID: <20181206054553.GB4244@leoy-ThinkPad-X240s>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-4-git-send-email-leo.yan@linaro.org>
 <20181119182759.GA608@xps15>
 <20181205033145.GA15964@leoy-ThinkPad-X240s>
 <CANLsYkyMb58D9JetJN4BdVcaTmurPRqd5BZy99zX=5DA0J9wDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkyMb58D9JetJN4BdVcaTmurPRqd5BZy99zX=5DA0J9wDA@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:48:45AM -0700, Mathieu Poirier wrote:

[...]

> > So I think there still have some difference between TRACE_ON and
> > NO_SYNC packets, TRACE_ON packet indicates the start of trace and it's
> > also possible caused by tracing discontinuity; NO_SYNC packets usually
> > caused by an unsynchronised state.  But both of them presents
> > discontinuity in perf trace data.
> >
> > I prefer to use two different packet types to present them, this can
> > let the code to be more readable and easier to be maintained later.
> 
> Absolutely.  Make sure to get to the bottom of the story with Mike
> and/or Robert before sending your next patchset.

Sure, will sync with Mike/Rob.

Thanks,
Leo Yan
