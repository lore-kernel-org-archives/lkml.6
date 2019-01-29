Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AE9C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA362184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfA2RZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:25:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:20273 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfA2RZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:25:31 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 09:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="120431335"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jan 2019 09:25:30 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4D1D13011E7; Tue, 29 Jan 2019 09:25:30 -0800 (PST)
Date:   Tue, 29 Jan 2019 09:25:30 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] perf: enable compression of record mode trace to
 save storage space
Message-ID: <20190129172530.GT6118@tassilo.jf.intel.com>
References: <b834df0e-26b5-3f8c-7a43-18f675fb7434@linux.intel.com>
 <20190129104543.GJ4344@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129104543.GJ4344@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 11:45:43AM +0100, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 28, 2019 at 09:40:28AM +0300, Alexey Budankov escreveu:
> > The patch set implements runtime trace compression for record mode and 
> > trace file decompression for report mode. Zstandard API [1] is used for 
> > compression/decompression of data that come from perf_events kernel 
> 
> Interesting, wasn't aware of this zstd library, I wonder if we can add
> it and switch the other compression libraries we link against, so that
> we're not adding one more library to the dep list of perf but removing
> some instead, do you think this would be possible?

Sadly we can't because perf needs the existing libraries to uncompress
modules, and they might be compressed with zlib or bzip2. zstd cannot
uncompress those formats.

-Andi
