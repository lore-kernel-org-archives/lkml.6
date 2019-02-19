Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28769C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA88C21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550590205;
	bh=aKSbayxqAK5EHoq3kVbbvu7DK3Fzt9kE3oPrHPM64ZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=jkLmfjs6PeehtegzZK7/yB/Yk8Fe3SBloFtZK2Y+e3WUYm0/2rVPAIzwnWFCQjgrC
	 eY2a3voneGDq/FdCEX4+urLbPproGGM2elzVRewE4ZfAZ7oX28qT//bbBwJ9U60RUa
	 MLKAmVTEDS0JQbQANTcB1BVk96HDIFiBDUwbGUj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfBSPaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbfBSPaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:30:03 -0500
Received: from quaco.ghostprotocols.net (unknown [179.162.130.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F0DD21736;
        Tue, 19 Feb 2019 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550590202;
        bh=aKSbayxqAK5EHoq3kVbbvu7DK3Fzt9kE3oPrHPM64ZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=edcm6qCa99I9RdKi5AUVYHE2nps/2zJ10a01J0Pl2BbIB1gSSRgQjQaPjXlsWmMRT
         pCKl7FkYo5Oz1Vxvuf3ljnw09p/jh+b95kMpxLfBL+X3XaUDFLnlV7MWSfxdRU4t9Z
         W7kh6lzcKCBfmRVE749TZi2gfkL0WIrn5m23yO2E=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6C56D410D5; Tue, 19 Feb 2019 12:29:59 -0300 (-03)
Date:   Tue, 19 Feb 2019 12:29:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     He Kuang <hekuang@huawei.com>
Cc:     Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Don't shadow inlined symbol with different
 addr range
Message-ID: <20190219152959.GC31177@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219140213.GC6435@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 19, 2019 at 03:02:13PM +0100, Jiri Olsa escreveu:
> On Tue, Feb 19, 2019 at 09:05:31PM +0800, He Kuang wrote:
> > We can't assume inlined symbols with the same name are equal, because
> > their address range may be different. This will cause the symbols with
> > different addresses be shadowed when adding to the hist entry, and lead
> > to ERANGE error when checking the symbol address during sample parse, the
> > addr should be within the range of [sym.start, sym.end].

> > The error message is like: "0x36aea60 [0x8]: failed to process type: 68".

> > The second parameter of symbol__new() is the length of the fake symbol for
> > the inline frame, which is the subtraction of the end and start address of
> > base_sym.

> > Signed-off-by: He Kuang <hekuang@huawei.com>

> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applying and adding the missing Fixes line:

Fixes: aa441895f7b4 ("perf report: Compare symbol name for inlined frames when sorting")

Also added Millian, the author of that patch to the Cc list, so that he
can check this as well if he has the time for doing so.

Please double check that this indeed is when this problem was
introduced,

- Arnaldo
