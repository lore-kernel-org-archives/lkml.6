Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F80C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9642086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548764017;
	bh=+MH16JEkCjpoIYtv44+PhFbEfMY/XHZ4D9jZoqltlRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wMh62Y8yZvpVPRzhQsLCi9jXTTpogVqAC7aHp+EMHolUVXlWNYY0BGBEdZUOA5QG1
	 z/ShUIHFPcXgnYFg3PByVjPJdj7vd0gpk5utUvsNV/PFA9UZ3m5pb5d3cCjHLDCHSR
	 etnSzaZsXuTBEmiUsJ950AbFZLl54DUmQOLo/vlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfA2MNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:13:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfA2MNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:13:35 -0500
Received: from quaco.ghostprotocols.net (ovpn-brq.redhat.com [213.175.37.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F365A2086C;
        Tue, 29 Jan 2019 12:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548764014;
        bh=+MH16JEkCjpoIYtv44+PhFbEfMY/XHZ4D9jZoqltlRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvPDnw+F/6FAgnKHBkXKglFQlNPQZwNNh+vOHnS/b+V5IfGWOTcRve+IbvT14+Lh1
         wt9E+PQy2rcUvLI+PTG+5ALcskm1YW3OMVnDoeAHHD0N1hdNoE0RxbiJvcpzEjzZXt
         mgooiFbugRNxHKzhs9WELjvNq40XeOQ/kogQ4EaA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 41DD54034F; Tue, 29 Jan 2019 13:13:32 +0100 (CET)
Date:   Tue, 29 Jan 2019 13:13:32 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] perf: enable compression of record mode trace to
 save storage space
Message-ID: <20190129121332.GL4344@kernel.org>
References: <b834df0e-26b5-3f8c-7a43-18f675fb7434@linux.intel.com>
 <20190129104543.GJ4344@kernel.org>
 <20190129105337.GA17762@kernel.org>
 <de604869-4d2e-689c-39ba-368d444c809a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de604869-4d2e-689c-39ba-368d444c809a@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 29, 2019 at 02:39:00PM +0300, Alexey Budankov escreveu:
> Hi,
> On 29.01.2019 13:53, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jan 29, 2019 at 11:45:43AM +0100, Arnaldo Carvalho de Melo escreveu:
> >> Em Mon, Jan 28, 2019 at 09:40:28AM +0300, Alexey Budankov escreveu:
> >>> The patch set implements runtime trace compression for record mode and 
> >>> trace file decompression for report mode. Zstandard API [1] is used for 
> >>> compression/decompression of data that come from perf_events kernel 
> >>
> >> Interesting, wasn't aware of this zstd library, I wonder if we can add
> >> it and switch the other compression libraries we link against, so that
> >> we're not adding one more library to the dep list of perf but removing
> >> some instead, do you think this would be possible?
> 
> Replacing of incorporated compression APIs was not evaluated or tested in 
> the scope of this patch set work. However according to their numbers in the 
> docs and the numbers that we have got during testing Zstd API outperforms 
> the exiting compression libraries as in terms of speed as in terms of 
> compression ratio (at least libz). Backward compatibility needs to be taken
> into account so that old perf files would open by newer perf tool versions.

Right, I'm not talking in the scope of this patch, its just that while
looking at it, I notice that we're adding yet another compression
library and its description seemed to imply it would support the other
compression formats, which I've learned its not the case, so nevermind.

I'm not talking about using just zstd, as what we mostly do with the
compression libraries is to decompress, not compress, for instance, we
need to uncompress kernel modules to get to its symbols, do annotation
with it, etc.

- Arnaldo
 
> -Alexey
> 
> >>
> >>   $ ldd ~/bin/perf | wc -l
> >>   30
> >>   $ ldd ~/bin/perf | grep z
> >> 	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f3dcc356000)
> >> 	libz.so.1 => /lib64/libz.so.1 (0x00007f3dcb2aa000)
> >> 	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f3dcb218000)
> >>   $
> >>
> >> Humm, from the github page it says:
> >>
> >> -----
> >> The project is provided as an open-source dual BSD and GPLv2 licensed C
> >> library, and a command line utility producing and decoding .zst, .gz,
> >> .xz and .lz4 files. Should your project require another programming
> >> language, a list of known ports and bindings is provided on Zstandard
> >> homepage.
> >> -----
> >>
> >> So it would cover just liblzma and libz, right?
> > 
> > Nevermind;
> > 
> > [acme@quaco perf]$ zstdcat ~/git/perf/perf-5.0.0-rc2.tar.xz
> > zstd: /home/acme/git/perf/perf-5.0.0-rc2.tar.xz: xz/lzma file cannot be uncompressed (zstd compiled without HAVE_LZMA) -- ignored
> > 
> > So it handles those formats, _if_ linked with those libraries, duh.
> > 
> > - Arnaldo
> > 

-- 

- Arnaldo
