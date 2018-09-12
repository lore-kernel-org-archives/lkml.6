Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69678C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF89213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv5KU9aq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF89213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeIMAQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:16:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55828 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeIMAQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:16:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so3552145wmc.5;
        Wed, 12 Sep 2018 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WLknX/FDxO3x7XKk1pqKQCQVPMTeRDy1k/X+c/5oG0M=;
        b=lv5KU9aq2RILaTChm8LN1anEABhKs2A1E6LlpxDovE+sGpScPIKseY2a5ceuqYfAsi
         CpDBVgLdasreEl1gGXg7sPMa0/fXGfMBTaf1BE8x8kOq+3EQqEStIl8MywHssGJtstv2
         ocgdlU7E61/62xr044moohvH+xrADsM1EY9vWHGgQQk5NmLM1xgCGXE4KC+8hbE/m7nC
         NnO/Kn9Ap+sl/GOgYrTeQdKMWfZItCEHecfPlvC2UTDmtERgFN/pgj3DgS0774PjekuY
         Gg7qJNGd0Tp6DOLwQL8YI9OD0lcAxj7C3krtYei8VGSRJcbhDFSGAmMbB5oZ72QIiyrm
         wfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WLknX/FDxO3x7XKk1pqKQCQVPMTeRDy1k/X+c/5oG0M=;
        b=ZfrYtGyUYT1+i8HFOiBjS2Nu6FZsbAfBGIZWHNpaqEHzsFizX9ft8FkPl8Xih10FVr
         4vdxMuYUwZEf7QdxnjhS936ttoFRIADXB4L2iwqwKE12+tu2UFEfNQkKIqE+ktO+Tt9A
         T64gZ57Vwa5wCljvDEq4r46JHuwd9OoXXJAnAaYE8twQKGQYCs2wRQWPsafz5TYvyiGc
         VKKzxDn/ogDz8MGLSBAhaIhd9T4vEVs3vA6MPS3xXMSlsrmMc8FUxdjymt8Phh+6h4pj
         vMOp+CcLzl2SGfpycC0UICAgw0GwPd6iMA7mi35G2uYeZIJnGbLb6pZkw60xatIuqZEA
         9ZyQ==
X-Gm-Message-State: APzg51CkXFaE+gMETtvjl/LBNnURLWYTI9aj6rSHgNiZ26Zdwb/KCkxW
        krMAaCV2v80pzZMlo8hHYjA=
X-Google-Smtp-Source: ANB0VdbJEt9s3Whs9fbLobpW+gZNuo9gaRZmRK8hxQaUL3wBkalbsqNbZDKwe6d8/JeK1IlI6m90Cw==
X-Received: by 2002:a1c:d98a:: with SMTP id q132-v6mr2566484wmg.78.1536779458593;
        Wed, 12 Sep 2018 12:10:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q5-v6sm3450793wmd.29.2018.09.12.12.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 12:10:57 -0700 (PDT)
Date:   Wed, 12 Sep 2018 21:10:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Eric Anholt <eric@anholt.net>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        James Morse <james.morse@arm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Jim Mattson <jmattson@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Sean Paul <seanpaul@chromium.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/7] perf/urgent fixes
Message-ID: <20180912191054.GA63360@gmail.com>
References: <20180912185509.32187-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912185509.32187-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 02e184476eff848273826c1d6617bb37e5bcc7ad:
> 
>   perf/core: Force USER_DS when recording user stack data (2018-09-10 14:01:46 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.19-20180912
> 
> for you to fetch changes up to 03db8b583d1c3c84963e08e2abf6c79081da5c31:
> 
>   perf tools: Fix maps__find_symbol_by_name() (2018-09-11 14:12:51 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Fix finding a symbol by name when multiple maps use the same backing DSO,
>   so we must first see if that symbol name is in the DSO, then see if it is
>   inside the range of addresses for that specific map (Adrian Hunter)
> 
> - Update the tools copies of UAPI headers, which silences the warnings
>   emitted when building the tools and in some cases, like for the new
>   KVM ioctls, results in 'perf trace' being able to translate that
>   ioctl number to a string (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (1):
>       perf tools: Fix maps__find_symbol_by_name()
> 
> Arnaldo Carvalho de Melo (6):
>       tools headers uapi: Update tools's copy of linux/perf_event.h
>       tools headers uapi: Update tools's copy of asm-generic/unistd.h
>       tools headers uapi: Update tools's copy of drm/drm.h
>       tools headers uapi: Update tools's copies of kvm headers
>       tools headers uapi: Update tools's copy of linux/vhost.h
>       tools headers uapi: Update tools's copy of linux/if_link.h
> 
>  tools/arch/arm/include/uapi/asm/kvm.h   | 13 ++++++++++++
>  tools/arch/arm64/include/uapi/asm/kvm.h | 13 ++++++++++++
>  tools/arch/s390/include/uapi/asm/kvm.h  |  5 ++++-
>  tools/arch/x86/include/uapi/asm/kvm.h   | 37 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/asm-generic/unistd.h |  4 +++-
>  tools/include/uapi/drm/drm.h            |  9 ++++++++
>  tools/include/uapi/linux/if_link.h      | 17 +++++++++++++++
>  tools/include/uapi/linux/kvm.h          |  6 ++++++
>  tools/include/uapi/linux/perf_event.h   |  2 +-
>  tools/include/uapi/linux/vhost.h        | 18 ++++++++++++++++
>  tools/perf/util/map.c                   | 11 ++++++++++
>  11 files changed, 132 insertions(+), 3 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
