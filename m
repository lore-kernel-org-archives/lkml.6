Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE15C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB4A2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548752875;
	bh=C+lsyp5bNbWdKIDpj7EmIXJQs3y5TPpUFHkA9mTUw0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E9sL3tMhwhrtXRjnfqSdEcqksyrSPPHO2Tuwa9FYZAvvp4A5yrLNzP1OOBP7Cn8kz
	 xSxjc2w7yb7EkWzHQzCVT1M86FqUlfH9Z1ccOlY925eu3MaGLTwG9HZcxDUkyTkRYT
	 QNIXwmuIpkJeoIdALx+cMDcRipp/YT8Jzeu+5e1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfA2JHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:07:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfA2JHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:07:53 -0500
Received: from quaco.ghostprotocols.net (ovpn-brq.redhat.com [213.175.37.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 552C72084A;
        Tue, 29 Jan 2019 09:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548752872;
        bh=C+lsyp5bNbWdKIDpj7EmIXJQs3y5TPpUFHkA9mTUw0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=owWOZr+b54eJ2xmvbWOwM3eUbJOvi1Ml2+r/YnGrusellsqPmRPHZ7Ll7ACXBbaZn
         tuMnKPJhqgvTFLXU/gOxTEGzryCfQ8aAoROi9KqKe/yPs45mOYl7Ux1n3Ugk/INJMB
         325wE0J9411cUITFPpfViNv4LrSkEPqrn5SaN86E=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A62294034F; Tue, 29 Jan 2019 10:07:50 +0100 (CET)
Date:   Tue, 29 Jan 2019 10:07:50 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Clifton <nickc@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] perf tools: Filter out hidden symbols from labels
Message-ID: <20190129090750.GE4344@kernel.org>
References: <20190115135354.11572-1-jolsa@kernel.org>
 <960f0b83-a623-67a6-ab55-d56139d10ba2@redhat.com>
 <20190115173838.GB31411@krava>
 <20190128133526.GD15461@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128133526.GD15461@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 28, 2019 at 02:35:26PM +0100, Jiri Olsa escreveu:
> On Tue, Jan 15, 2019 at 06:38:38PM +0100, Jiri Olsa wrote:
> > On Tue, Jan 15, 2019 at 04:13:16PM +0000, Nick Clifton wrote:
> > >   Just to be awkward, if you are going to ignore STV_HIDDEN 
> > >   symbols then you should probably also ignore STV_INTERNAL ones
> > >   as well...  Annobin does not generate them, but you never know,
> > >   one day some other tool might create some.

> > sounds good, thanks
 
> there were no objections for rfc, sending patch

I don't see a problem, Nick, can you provide an Acked-by, or better yet,
a Reviewed-by so that Jiri can collect in this patch and I can push it
to perf/urgent?

Thanks,

- Arnaldo
 
> thanks,
> jirka
> 
> 
> ---
> When perf is built with annobin plugin (RHEL8 build) extra symbols
> are added to its binary:
> 
>   # nm perf | grep annobin | head -10
>   0000000000241100 t .annobin_annotate.c
>   0000000000326490 t .annobin_annotate.c
>   0000000000249255 t .annobin_annotate.c_end
>   00000000003283a8 t .annobin_annotate.c_end
>   00000000001bce18 t .annobin_annotate.c_end.hot
>   00000000001bce18 t .annobin_annotate.c_end.hot
>   00000000001bc3e2 t .annobin_annotate.c_end.unlikely
>   00000000001bc400 t .annobin_annotate.c_end.unlikely
>   00000000001bce18 t .annobin_annotate.c.hot
>   00000000001bce18 t .annobin_annotate.c.hot
>   ...
> 
> those symbols have no use for report or annotation and should be skipped.
> Moreover they interfere with dwarf unwind test on ppc arch, where they
> are mixed with checked symbols and test fails:
> 
>   # perf test dwarf -v
>   59: Test dwarf unwind                                     :
>   --- start ---
>   test child forked, pid 8515
>   unwind: .annobin_dwarf_unwind.c:ip = 0x10dba40dc (0x2740dc)
>   ...
>   got: .annobin_dwarf_unwind.c 0x10dba40dc, expecting test__arch_unwind_sample
>   unwind: failed with 'no error'
> 
> The annobin symbols are defined as NOTYPE/LOCAL/HIDDEN:
> 
>   # readelf -s ./perf | grep annobin | head -1
>     40: 00000000001bce4f     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_init.c
> 
> They can still pass the check for the label symbol. Adding
> check for HIDDEN and INTERNAL (as suggested by Nick below)
> visibility and filter out such symbols.
> 
> >   Just to be awkward, if you are going to ignore STV_HIDDEN
> >   symbols then you should probably also ignore STV_INTERNAL ones
> >   as well...  Annobin does not generate them, but you never know,
> >   one day some other tool might create some.
> 
> Link: http://lkml.kernel.org/n/tip-4yuna6qhhg0df3q147cjdyuu@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/symbol-elf.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 66a84d5846c8..03cb8c6d620a 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -87,6 +87,11 @@ static inline uint8_t elf_sym__type(const GElf_Sym *sym)
>  	return GELF_ST_TYPE(sym->st_info);
>  }
>  
> +static inline uint8_t elf_sym__visibility(const GElf_Sym *sym)
> +{
> +	return GELF_ST_VISIBILITY(sym->st_other);
> +}
> +
>  #ifndef STT_GNU_IFUNC
>  #define STT_GNU_IFUNC 10
>  #endif
> @@ -111,7 +116,9 @@ static inline int elf_sym__is_label(const GElf_Sym *sym)
>  	return elf_sym__type(sym) == STT_NOTYPE &&
>  		sym->st_name != 0 &&
>  		sym->st_shndx != SHN_UNDEF &&
> -		sym->st_shndx != SHN_ABS;
> +		sym->st_shndx != SHN_ABS &&
> +		elf_sym__visibility(sym) != STV_HIDDEN &&
> +		elf_sym__visibility(sym) != STV_INTERNAL;
>  }
>  
>  static bool elf_sym__filter(GElf_Sym *sym)
> -- 
> 2.17.2

-- 

- Arnaldo
