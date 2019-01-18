Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A39C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DF02087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547816367;
	bh=sjd88mt7e9GBovi0n4jVsWEEeBp9BUkwVj9ZqG+Lj4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bqLZk9bYMZ2laZsiOUKKgxyGpnX/y+nGDCtX7sk9i9AK1/Lo0fTXKg7z/OeK5HRVk
	 /RvvkudzYsozK8pm+nU2fnxYuwcZRK1zGD5fTtC9Vl9wV8aaC3Q2+dhz0b1okJatHn
	 rFdHyfbLsocMxgbgwedKDjMsVeoHnTxG2WhAdUS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfARM7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:59:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfARM7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:59:25 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.100.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C67220823;
        Fri, 18 Jan 2019 12:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547816364;
        bh=sjd88mt7e9GBovi0n4jVsWEEeBp9BUkwVj9ZqG+Lj4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cSn6AvQHfWaXCVv5/GyC4eANdk6KMLAUSnKignYP+wK7TrPBtbG/F2oywUXLPOQwW
         PU13V/oQhJhP7G85+z3MC+nrPQBcO7+oAWeFB+CQmi06g/kgFzy33DvtpbYfDtOZ1e
         pX0LsmoxRtgnqAlgfauAKl0UyAw5MblhMgXe2uyM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5FBD441AB5; Fri, 18 Jan 2019 09:59:20 -0300 (-03)
Date:   Fri, 18 Jan 2019 09:59:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf, script: Fix crash with printing mixed trace point
 and other events
Message-ID: <20190118125920.GG5823@kernel.org>
References: <20190117194834.21940-1-andi@firstfloor.org>
 <20190118094919.GA28346@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118094919.GA28346@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 18, 2019 at 10:49:19AM +0100, Jiri Olsa escreveu:
> On Thu, Jan 17, 2019 at 11:48:34AM -0800, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>

> > perf script crashes currently when printing mixed trace points and other
> > events because the trace format does not handle events without trace
> > meta data. Add a simple check to avoid that.

> > % cat > test.c
> > main()
> > {
> >     printf("Hello world\n");
> > }
> > ^D
> > % gcc -g -o test test.c
> > % sudo perf probe -x test 'test.c:3'
> > % perf record -e '{cpu/cpu-cycles,period=10000/,probe_test:main}:S' ./test
> > % perf script
> > <segfault>

> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, tested and applied.

While testing I found something odd, the cycles events are not showing
the CPU and the probe events shows a "negative" CPU column,
investigating.

- Arnaldo
