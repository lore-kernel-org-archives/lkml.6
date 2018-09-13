Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602ECC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E6720853
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiMnEFJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E6720853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeINAHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:07:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42526 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeINAHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:07:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so3073699pff.9;
        Thu, 13 Sep 2018 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D+tLcYepA+7PxAGF6WlL6+mmCZM8avXl6D2VNWHeTuY=;
        b=kiMnEFJC3c5lb68xpGZUzc6BEWG75NIZH1eu8e4hpKg0oWp10FI7kYQZ/8MFFTOZ9I
         QnxpDVOA3vuNMI/bPowMf5U+R62PP5rTeDVfeUkA1yEDxNP9VcPmPOrakStB6HSPKCAm
         furJ7mlZPs8W2/5iAGZx7MgjjwMngvYZHCHweSP3T5Qn3P7cc0WlP4qE3olSZJx2lF45
         zXkPtyjamGnsxVqhVrHYVhtNMEFcsNHHchGpvn5LS8p2/vg2bmEgnt9e9oQnqb9b6Chd
         kzS9BmrUGmJb+cSKp9hwDLp5xOuLBD60mcqEvna5SQtZEmwD1WVYQ95UfjM2SF6DH4Q8
         wLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D+tLcYepA+7PxAGF6WlL6+mmCZM8avXl6D2VNWHeTuY=;
        b=f03FKrZ6OTRYZhS5Xl5tlCo7Y1J5Hb4wfoAoloudrBGMdWTm+4fGUrE45X7nZPxcR/
         C6zzsEFx3pwoeZ/1mo3qXYNA1Iw1QeQF+e2Ix8lgrIjaTuwkDJCFOllKd7CWqjCUWCEy
         4cUocg44ojAMNRkak5okXy9zJNprJGE0oR8azCUpfmgzIpYyNQReezlBfSowgqr+fa97
         0f7RhtJGMVlBwBSkarPh/IS9WhnNwbIp8Y1aCOSx3fShY+ByK+AENOUc1jafAkfGi8Me
         GzQMv7M15z4aVjqpg2YmtMCAHjwUOClSetvgLv0ixZqr9RkhxLJF/3gwPAeELbtH+XcX
         MQuw==
X-Gm-Message-State: APzg51ADWlVjrwRJ2B5mpwEAJW1KweP+3CkOT5YB+HlAEXzZLdhaUeeM
        ybAQPVZ7FhNP+EZtv6pbzJI=
X-Google-Smtp-Source: ANB0VdZMCINFcrfhwqcLR3mKRcGW+uagkVjeOyukvvHTuVruxmbADXcKoDMZqIzNb/dq8PNMnRWc8Q==
X-Received: by 2002:a63:fd06:: with SMTP id d6-v6mr8153965pgh.348.1536864993802;
        Thu, 13 Sep 2018 11:56:33 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::6:2d6d])
        by smtp.gmail.com with ESMTPSA id v72-v6sm9169863pfj.22.2018.09.13.11.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:56:32 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:56:31 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>
Subject: Re: [RFC/fix] Re: libbpf build broken on musl libc (Alpine Linux)
Message-ID: <20180913185629.su22fnimluoezntg@ast-mbp>
References: <20180910172903.GB15516@kernel.org>
 <20180911122218.0d2eb3f9@cakuba>
 <20180911121543.GB22689@kernel.org>
 <20180911212451.hvnyfwyvcs4yojqy@ast-mbp>
 <20180913183240.GF30969@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913183240.GF30969@kernel.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:32:40PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 11, 2018 at 02:24:53PM -0700, Alexei Starovoitov escreveu:
> > On Tue, Sep 11, 2018 at 09:15:43AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Sep 11, 2018 at 12:22:18PM +0200, Jakub Kicinski escreveu:
> > > > On Mon, 10 Sep 2018 14:29:03 -0300, Arnaldo Carvalho de Melo wrote:
> > > > > After lunch I'll work on a patch to fix this, 
> > > > Any luck?
> 
> > > Well, we need to apply the patch below and make tools/lib/str_error_r.c
> > > live in a library that libbpf and perf is linked to.
>  
> > do you want us to take the patch or you're applying it yourself?
> 
> Please do some testing with my perf/libbpf+str_error_r branch, it has
> two patches to get this fixed, the one I sent and a prep one making
> libbpf link against libapi.
> 
> [acme@jouet perf]$ git log --oneline -2
> a7ab924b7fec (HEAD -> perf/urgent, acme.korg/perf/libbpf+str_error_r) tools lib bpf: Use str_error_r() to fix the build in Alpine Linux
> fb4a79e04c2b tools lib bpf: Build and link to tools/lib/api/

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/libbpf%2bstr_error_r&id=fb4a79e04c2b37ee873a3b31a3250925cf466fff
we cannot do this.
lib/api is GPL we cannot use it in LGPL library.

