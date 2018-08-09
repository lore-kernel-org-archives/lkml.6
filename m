Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF711C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D2521F41
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwPTOpg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D2521F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbeHIUMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732330AbeHIUMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:12:23 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A11421F41;
        Thu,  9 Aug 2018 17:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533836789;
        bh=hrnAlqRoxVmE4qfdKnJJoB/8BX0ucvw8QzNbFvzI4ZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwPTOpg87ycTfeZV3/tEK13PePDdPsS1+spHVVbFwtU62Wk4lQi8/y97qVgfFfXEb
         wqhJZ/xzY1EOw7QF6M7R7eP/I7R2vM36Rbl8QZiALTa2JTK+sHgmF1QODhVXnFfttC
         +G3NFw2UT/Q4NuFZm4Sq3I04waxXv+yDhojBUlaY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 36D4C140A1C; Thu,  9 Aug 2018 14:44:10 -0300 (-03)
Date:   Thu, 9 Aug 2018 14:44:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Sandipan Das <sandipan@linux.ibm.com>,
        aneesh.kumar@linux.vnet.ibm.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com
Subject: Re: [PATCH] perf probe powerpc: Fix trace event post-processing
Message-ID: <20180809174410.GD5395@kernel.org>
References: <20180809161929.35058-1-sandipan@linux.ibm.com>
 <1533831952.2wznw8gaoa.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533831952.2wznw8gaoa.naveen@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 09, 2018 at 09:56:24PM +0530, Naveen N. Rao escreveu:
> Sandipan Das wrote:
<SNIP>
> > This can be verified on a powerpc64le system as shown below.
<SNIP>
> > Before:
> >   # perf probe -v -a sys_open
<SNIP>
> >   # perf probe -v -a sys_open%return $retval
<SNIP>
> >   Failed to write event: Invalid argument
> >     Error: Failed to add events. Reason: Invalid argument (Code: -22)
> > After:
> >   # perf probe -v -a sys_open
<SNIP>
> >   Writing event: p:probe/sys_open _text+4276888
> >   Added new event:
> >     probe:sys_open       (on sys_open)
> >   ...
> > 
> >   # perf probe -v -a sys_open%return $retval
<SNIP>
> >   Writing event: r:probe/sys_open__return _text+4276888
> >   Added new event:
> >     probe:sys_open__return (on sys_open%return)
> > Fixes: 99e608b5954c ("perf probe ppc64le: Fix probe location when using DWARF")
> > Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
 
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks, applied!

Excellent commit log message, btw, keep it up.

- arnaldo
