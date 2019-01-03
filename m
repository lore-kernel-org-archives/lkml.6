Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAF2C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EA92070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519488;
	bh=FUmgK9raiCEkli8W4lOTS/z7Q7G/lBw57SxGp0klolQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SJoiAHQh1be2iQOFK5M0oj95HMdFVPsWrFgCmQA8ljwWTYKxGBj78GfM1tyVB1pzw
	 lH/sEECDYSy5D4ZixJb6MR+xV8XfSZXqJReF2oO6DuzaUVWQr6PucMY9oyAMdZKjsZ
	 lbGEDjKXHueYiil0znsrYkQx2EWtbbICkjSL5sNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfACMoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:44:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730459AbfACMn7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:43:59 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A7C2070D;
        Thu,  3 Jan 2019 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519438;
        bh=FUmgK9raiCEkli8W4lOTS/z7Q7G/lBw57SxGp0klolQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyOTOIC/tYDKMyCldhkIJRb+8a0NgaMhvtRaF1xcppQ+QPQSovSU5C2W/IOYPFBjz
         KVpElW0fJrWZcsRceacKmhOTEaKbS2I2HUMKGx4yoZ8Egwo99lC1YvN5Le7LRlDoAu
         tccX2QCU1j262Bu07naxYUOdkUxn8iDF9RrhUS30=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F1FE40493; Thu,  3 Jan 2019 09:43:56 -0300 (-03)
Date:   Thu, 3 Jan 2019 09:43:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Fix endless wait for child process
Message-ID: <20190103124356.GA32598@kernel.org>
References: <1546501245-4512-1-git-send-email-yao.jin@linux.intel.com>
 <20190103111205.GA26933@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103111205.GA26933@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 03, 2019 at 12:12:05PM +0100, Jiri Olsa escreveu:
> On Thu, Jan 03, 2019 at 03:40:45PM +0800, Jin Yao wrote:
> > We hit a perf stat issue by using following script.
> > 
> >   #!/bin/bash
> > 
> >   sleep 1000 &
> >   exec perf stat -a -e cycles -I1000 -- sleep 5
> > 
> > Since "perf stat" is launched by exec, so the "sleep 1000" would be
> > the child process of "perf stat". The wait4() will not return because
> > it's waiting for the child process "sleep 1000" to be end. So perf
> > stat doesn't return even 5s passed.
> > 
> > This patch lets the perf stat return when the specified child process
> > is end (in this case, specified child process is "sleep 5").
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>

Thanks, tested and applied.

- Arnaldo
