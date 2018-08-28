Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF52C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD65420891
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvZ3Z6g6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD65420891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbeH1Sbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeH1Sby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:31:54 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9DD220891;
        Tue, 28 Aug 2018 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535467196;
        bh=NvbqN2gGoOSCUDCCcxdmmPz+mX5wO9o0CqokTZLwTL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TvZ3Z6g6Pqz/TPbhnzsnvQy7iaKvAFkFV2h1UGMyqSH93qsdgJfa3MMNTR3Og0Jmo
         0KURJmZHj3/uzrgqW+DGqh5Svwq3soZKdib6XVmk+FPGJIrxCpsDmCJGtdw1SVCKT7
         lyyt9+hvfYl50MA+Jcbtb7kf7t3RHqe6iuEdE/Kw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id ABA5E141C3F; Tue, 28 Aug 2018 11:39:53 -0300 (-03)
Date:   Tue, 28 Aug 2018 11:39:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 4/5] perf/hw_breakpoint: Set breakpoint as disabled in
 modify_user_hw_breakpoint error path
Message-ID: <20180828143953.GL22309@kernel.org>
References: <20180809120305.20693-1-jolsa@kernel.org>
 <20180809120305.20693-5-jolsa@kernel.org>
 <20180809141713.GB22636@redhat.com>
 <20180809163015.GA23170@krava>
 <20180828142914.GJ22309@kernel.org>
 <20180828143823.GM23727@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828143823.GM23727@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 28, 2018 at 04:38:23PM +0200, Jiri Olsa escreveu:
> On Tue, Aug 28, 2018 at 11:29:14AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Aug 09, 2018 at 06:30:15PM +0200, Jiri Olsa escreveu:
> > > On Thu, Aug 09, 2018 at 04:17:13PM +0200, Oleg Nesterov wrote:
> > > > On 08/09, Jiri Olsa wrote:
> > > > > -	if (err)
> > > > > +	if (err) {
> > > > > +		bp->attr.disabled = 1;
> > > > >  		return err;
> > > > 
> > > > Yes, but on the second thought... Can't we simply do
> > 
> > <SNIP>
> > 
> > > > instead of this and the next patch?
> > 
> > <SNIP>
> >  
> > > yep, seems good.. will send new version
> > 
> > Ok, but this is just for 4/5 and 5/5, right?
> 
> I resent v4 yesterday with final changes/acks, in here:
> 
> 7186 r   Aug 27 Jiri Olsa       (1.6K) [PATCHv4 0/5] perf/hw_breakpoint: Fix breakpoint modify

Ok, will search that, sorry for the noise :-)

- Arnaldo
