Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EF5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F80620855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544449201;
	bh=qoxjddS7BhzXuN0dXrsJok5Y0tEf1PtnXxr5pBq1vvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EEZrwX/gE9HqGDXNhjTX5CNLri1alyUjYuV0TgQfDVcnx9tqVpYofh6Seg60FQN0O
	 tmB4c2xdnLYVRmogyL3jNk2+/lvTxZByDMduEeOoyiyohZJrQ4n9XbT0iTc7WHUI6N
	 AQVP6fgXV1DmMxQ9DG6JRdXl3o/mQqDSEFoIiBD4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F80620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeLJNkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:40:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbeLJNkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:40:00 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 134F42084E;
        Mon, 10 Dec 2018 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544449199;
        bh=qoxjddS7BhzXuN0dXrsJok5Y0tEf1PtnXxr5pBq1vvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jHWBey+vc+1XfaoO738B6eY3ikSSRbkFCg+zUrXNMXlM7whhgNZ3L+vTcBf0kmLLc
         TvrdkMHEKwNgUR/QOj1WJGEM8opAmysPp8+odKPb47lo4NYxo+jYD3CHTUFYZwR3Xg
         j+ALWEIuE8bo4djx7VwTJEr7c3i43oRgFlWN/bWc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 02AE54042C; Mon, 10 Dec 2018 10:39:55 -0300 (-03)
Date:   Mon, 10 Dec 2018 10:39:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] perf auxtrace: Alter addr_filter__entire_dso() to work
 if there are no symbols
Message-ID: <20181210133955.GF32567@kernel.org>
References: <20181127084634.12469-1-adrian.hunter@intel.com>
 <20181127124226.GC15747@kernel.org>
 <67587a92-200c-ac7a-67bd-20df06cdd41b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67587a92-200c-ac7a-67bd-20df06cdd41b@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 10, 2018 at 03:17:05PM +0200, Adrian Hunter escreveu:
> On 27/11/18 2:42 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Nov 27, 2018 at 10:46:34AM +0200, Adrian Hunter escreveu:
> >> addr_filter__entire_dso() uses the first and last symbols from a dso,
> >> and so does not work when there are no symbols.  Alter it to filter the
> >> whole file instead.

> > I'm splitting this patch into a first prep one that renames and exports
> > the static function dso__data_file_size() and a second that does what
> > this commig log message states.

> > The reason is that sometimes we find out that the main part of the patch
> > is wrong and we then decide to revert the patch, only to realize that
> > the exported function is by that time already used elsewhere.
 
> Thanks for looking at this, but did it get lost?  I don't see it in your tree.

Yeah, my bad, thanks for the reminder, did the split and added to my
perf/core branch,

Also I'm adding this:

  Cc: Masami Hiramatsu <mhiramat@kernel.org>
  Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
  Fixes: 1b36c03e3569 ("perf record: Add support for using symbols in address filters")

So that people that were involved in the patch that introduced this
feature gets notified of this fix, also for backporters to take notice,
please try to do this in the future.

Thanks,

- Arnaldo
