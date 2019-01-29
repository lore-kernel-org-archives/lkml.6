Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C29C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCDE2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548758747;
	bh=m890sqsbql7NsFBw0OoOGjF5FJzH/V8ExVi5p4Vgk9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=asPttLUV8+p2cZl1/ok6buSH7/g9MlqVfy9FrpJju12iV473/sS//ycPbR9HbYGZM
	 qjhZw2rs8n4ULVpOztOjNIyGEYJgUZ/lFXZYuXqoiUGjcZieVN85AtG6EVYf+dT8Em
	 xVP0lOy75BbAvjIOlzWMUCwOH3GGOV38aG5FTfWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfA2Kpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:45:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfA2Kpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:45:45 -0500
Received: from quaco.ghostprotocols.net (ovpn-brq.redhat.com [213.175.37.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1CCC20881;
        Tue, 29 Jan 2019 10:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548758745;
        bh=m890sqsbql7NsFBw0OoOGjF5FJzH/V8ExVi5p4Vgk9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QWjXpAEJkzolR+fHN5DkhJv3qxgFlMn5NWJGGBvq0FZVuusIPrp23Ial45SxGCrDk
         SkkHcLyzWOjEhcnBpjVBdAF8k9FeixdsH6Tq3994ZfoFybKwRZ71qcQOgvI/JBM8UI
         QXY9Y3vwOGCd7He9Wcw4+aognudEE0qDlOUpT8nw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 36F384034F; Tue, 29 Jan 2019 11:45:43 +0100 (CET)
Date:   Tue, 29 Jan 2019 11:45:43 +0100
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
Message-ID: <20190129104543.GJ4344@kernel.org>
References: <b834df0e-26b5-3f8c-7a43-18f675fb7434@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b834df0e-26b5-3f8c-7a43-18f675fb7434@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 28, 2019 at 09:40:28AM +0300, Alexey Budankov escreveu:
> The patch set implements runtime trace compression for record mode and 
> trace file decompression for report mode. Zstandard API [1] is used for 
> compression/decompression of data that come from perf_events kernel 

Interesting, wasn't aware of this zstd library, I wonder if we can add
it and switch the other compression libraries we link against, so that
we're not adding one more library to the dep list of perf but removing
some instead, do you think this would be possible?

  $ ldd ~/bin/perf | wc -l
  30
  $ ldd ~/bin/perf | grep z
	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f3dcc356000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f3dcb2aa000)
	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f3dcb218000)
  $

Humm, from the github page it says:

-----
The project is provided as an open-source dual BSD and GPLv2 licensed C
library, and a command line utility producing and decoding .zst, .gz,
.xz and .lz4 files. Should your project require another programming
language, a list of known ports and bindings is provided on Zstandard
homepage.
-----

So it would cover just liblzma and libz, right?

- Arnaldo
