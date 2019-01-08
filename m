Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD137C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85207218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546953811;
	bh=PYCLY+E0xZwbZqwV/rw5kmcEkjLKtCUrnvXMXBFeYGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DoDtKb0L5k7OdC/XxSTR7jCTc5pL59IbU8JbHo+KWZiUgOXzc7k2EoQJiSWLtdlRM
	 JDWnAOYj2Ocs8LviP+7VRq05v2YQoWMmINx7Xn7d8sKEFZ8S/anExjp3+uEny+lo0w
	 egbH7F96JcCqH4lTaxY9mDUAd+OV9U1Pfd2r+xNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfAHNXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:23:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfAHNXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:23:30 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4921C206B6;
        Tue,  8 Jan 2019 13:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546953809;
        bh=PYCLY+E0xZwbZqwV/rw5kmcEkjLKtCUrnvXMXBFeYGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ceS2b0aHBH1rRU3RrLCmyoS4gNfEH6eN19ToW0zU3vRq/lPcn/cSiIOiSyI8QfUr9
         5X0+5hU5ryYTSL7DVaKsFrEDxw21f4Vwf03Zxap+Gl0NtlTChlR+v2/bQS9keJXwVk
         oK3QoQnU6jIWP8EKNyye0IfJm0ztOy7gTrgcYCng=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E5C9240355; Tue,  8 Jan 2019 10:23:26 -0300 (-03)
Date:   Tue, 8 Jan 2019 10:23:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de
Subject: Re: [PATCH v3 0/2] perf tests: Check for ARM [vectors] page
Message-ID: <20190108132326.GC28965@kernel.org>
References: <20181221034337.26663-1-f.fainelli@gmail.com>
 <20190101173926.GA15729@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190101173926.GA15729@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 01, 2019 at 06:39:26PM +0100, Jiri Olsa escreveu:
> On Thu, Dec 20, 2018 at 07:43:35PM -0800, Florian Fainelli wrote:
> > I just painfully learned that perf would segfault when
> > CONFIG_KUSER_HELPERS is disabled because it unconditionally makes use of
> > it. This patch series adds an ARM test for that by leveraging the
> > existing find_vdso_map() function and making it more generic and capable
> > of location any map within /proc/self/maps.
> > 
> > Changes in v3:
> > 
> > - remove find_vdso_map() call find_map() with VDSO__MAP_NAME
> > 
> > Changes in v2:
> > 
> > - use strlen() instead of sizeof() -1 since we made the page name a
> >   parameter
> > - use TEST_OK/TEST_FAIL in lieu of 0/-1
> > - added an error message indicating CONFIG_KUSER_HELPERS might be
> >   disabled
> > 
> > Florian Fainelli (2):
> >   perf tools: Make find_vdso_map() more modular
> >   perf tests: Add a test for the ARM 32-bit [vectors] page
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
