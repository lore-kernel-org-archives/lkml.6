Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C7AECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A45B20833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ztu31OOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A45B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeJYEri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbeJYEri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:47:38 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 556302082F;
        Wed, 24 Oct 2018 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540412288;
        bh=XA/Xls01qVFw0yeWTND+dWiPXtIP9U6BcQOysBULn+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ztu31OOuQjkx2PKJ9qtmPEJ7evu+/Wd0UqG2jlecJ18nmwbP4a0FxxnpG8a8HswWL
         ougf+FP4M6ARYmwg4q6BwIlTRmlxmZw8YjegFGEg9XVX03hwLre9KJBCYfEubLdnjs
         pi+fySky/0hG/UWIqwQExyZ7JugnzzGCci8/C7eQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 0380D142C5F; Wed, 24 Oct 2018 17:18:04 -0300 (-03)
Date:   Wed, 24 Oct 2018 17:18:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Benjamin Peterson <benjamin@python.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace beautify: Beautify flags of mount(2) and
 umount(2).
Message-ID: <20181024201804.GG15106@kernel.org>
References: <20180828035344.31500-1-benjamin@python.org>
 <20180830182848.GE6097@kernel.org>
 <1535665851.2058334.1491869472.4E860103@webmail.messagingengine.com>
 <1539143546.2716467.1536750504.65ADF11A@webmail.messagingengine.com>
 <20181010125506.GH10775@kernel.org>
 <1540262435.2865915.1551182688.3057DD9D@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540262435.2865915.1551182688.3057DD9D@webmail.messagingengine.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 22, 2018 at 07:40:35PM -0700, Benjamin Peterson escreveu:
> 
> 
> On Wed, Oct 10, 2018, at 05:55, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Oct 09, 2018 at 08:52:26PM -0700, Benjamin Peterson escreveu:
> > > Hi Arnaldo,
> > > Did you get a chance to look at this again?

> > Thanks, for pinging me about it, will check.
 
> Will the main part of my patch manage to make the cut for 4.20?

The functionality will, but I'm implementing it differently, the model
you used to create the patch is being phased out, now we're unsing a
model that create tables from the header files where those flags are
defined, so that when a new one gets added, we get it included
automatically, please take a look at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/trace.mount_flags

More specifically this one:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/trace.mount_flags&id=341628af5643adbaa78097d528f34b4b16aa908f

That will be used by one like tools/perf/trace/beauty/pkey_alloc.c, that
goes looking if the bits are set and if so, get the strings from the
table, etc.

In time pkey_alloc__scnprintf_access_rights() will be further
generalized, as all it needs is a strarray + the flags integer to
produce a simbolic or-ed flags string.

Sorry for taking so long, kept being sidetracked with other stuff...

- Arnaldo
