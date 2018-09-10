Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E10BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561C72087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN1EjUwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561C72087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeIJTMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbeIJTMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:12:52 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D72020870;
        Mon, 10 Sep 2018 14:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536589113;
        bh=ln7V2dvnGwwpYktA2KsBpfmqvPUE4A/9rV1/dKWEYIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rN1EjUwop03BLWK3/GNKGa/xfm+VwQ28mkyI4kIERWbCbrha3J4UfK+dHMtpH7HU2
         HCd9q3V0o7aarCTp3gb8KxGdSrQgKAiB2HsxttfWCQcEdw+gq9SbhiqMzKIg2iATvB
         QxnAk24u6m1nHcv+vtgN/Tyiz+coIO8Eu5nvw7Uw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 2D464141FFC; Mon, 10 Sep 2018 11:18:30 -0300 (-03)
Date:   Mon, 10 Sep 2018 11:18:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        tmricht@linux.ibm.com, sandipan@linux.ibm.com,
        brueckner@linux.ibm.com, kim.phillips@arm.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Add watchpoint test
Message-ID: <20180910141830.GI5147@kernel.org>
References: <20180910095811.22892-1-ravi.bangoria@linux.ibm.com>
 <20180910103154.GD15548@krava>
 <20180910134754.GC5147@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910134754.GC5147@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 10, 2018 at 10:47:54AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Sep 10, 2018 at 12:31:54PM +0200, Jiri Olsa escreveu:
> > On Mon, Sep 10, 2018 at 03:28:11PM +0530, Ravi Bangoria wrote:
> > > We don't have perf test available to test watchpoint functionality.
> > > Add simple set of tests: 
> > >  - Read only watchpoint
> > >  - Write only watchpoint
> > >  - Read / Write watchpoint
> > >  - Runtime watchpoint modification
> > > 
> > > Ex on powerpc:
> > >   $ sudo ./perf test 22
> > >   22: Watchpoint                                            :
> > >   22.1: Read Only Watchpoint                                : Ok
> > >   22.2: Write Only Watchpoint                               : Ok
> > >   22.3: Read / Write Watchpoint                             : Ok
> > >   22.4: Modify Watchpoint                                   : Ok
> > 
> > cool, thanks!
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Thanks, applied.

While testing, I got curious, as a 'perf test' user, why one of the
tests had the "Skip" result:

[root@seventh ~]# perf test watchpoint
22: Watchpoint                                            :
22.1: Read Only Watchpoint                                : Skip
22.2: Write Only Watchpoint                               : Ok
22.3: Read / Write Watchpoint                             : Ok
22.4: Modify Watchpoint                                   : Ok
[root@seventh ~]#

I tried with 'perf test -v watchpoint' but that didn't help, perhaps you
could add some message after the "Skip" telling why it skipped that
test? I.e. hardware doesn't have that capability, kernel driver not yet
supporting that, something else?

- Arnaldo
