Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5442C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E5D20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570146;
	bh=N7bLjQU0nI/WdEot0OKhtPXvCwEInbD14YR79QM/g+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bPwiyNB62tnDct2J9pGW+rf7aD6NpLWEPOZrV8AWpKj2nez1H0Y/jyT3Km4S8vQYD
	 /Xd1C1AIYEWjCycSdHYUsMHh/flQPAhf8ok1UI0HZIPAftB6jTScPCMlUJf3m7FUBK
	 M2jrdDsTI63KIX/gi/4Op2xOjTGB9VKkXV7OH8x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbfAOQfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:35:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfAOQfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:35:44 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B2C20657;
        Tue, 15 Jan 2019 16:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570143;
        bh=N7bLjQU0nI/WdEot0OKhtPXvCwEInbD14YR79QM/g+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gtlNCGjKLrY24EsN+VHtjdVF5oGgn7k9VPFqYH+4c13p9V442HUbCBZ9fCwxNh5I7
         9Vrmup/LgS+fqpLOimYXrCw7ZvBCNqi1GkMkQRIqsmlCC0qvxb0StsFl3Hw13dQ3gZ
         aWb/0Du5KYhCzHBjmhl40JSIv3XnAn6+FH6QPOGU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 896ED41AB5; Tue, 15 Jan 2019 13:35:40 -0300 (-03)
Date:   Tue, 15 Jan 2019 13:35:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Clifton <nickc@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC] perf tools: Filter out hidden symbols from labels
Message-ID: <20190115163540.GA20159@kernel.org>
References: <20190115135354.11572-1-jolsa@kernel.org>
 <960f0b83-a623-67a6-ab55-d56139d10ba2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960f0b83-a623-67a6-ab55-d56139d10ba2@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 15, 2019 at 04:13:16PM +0000, Nick Clifton escreveu:
> Hi Jiri,
> 
> > When perf is built with annobin plugin (RHEL8 build) extra symbols
> > are added to its binary:
> 
>   A bit of background for those wondering why annobin is creating
>   these symbols:  Annobin is a plugin for gcc that records data 
>   about how object file were built.  It is specifically designed 
>   to be able to cope with files that are built using multiple
>   different sets of optimization options.  (Eg because of #pragma
>   directives or function specific optimization attributes).  It
>   generates notes to cover each compiled region of code, and it
>   needs the symbols in order to be able to determine exactly which
>   areas in a linked binary were compiled with which options.

Humm, it would be nice for perf annotate to show those options when one
navigates the annotation, something like press some hotkey and see the
optimization flags used. Is there any library that gets those
annotations and put them in some linked list that we could use in
tools/perf/?

- Arnaldo
 
>   In the course of developing this plugin I encountered various
>   problems with tools not expecting to find extra symbols in a
>   binary.  Hence I made the symbols local, hidden and with no type.
>   It was the best I could do to say "ignore these symbols - they
>   are not meant to be seen by anyone but annobin".
> 
> 
> > +		elf_sym__visibility(sym) != STV_HIDDEN;
> 
>   Just to be awkward, if you are going to ignore STV_HIDDEN 
>   symbols then you should probably also ignore STV_INTERNAL ones
>   as well...  Annobin does not generate them, but you never know,
>   one day some other tool might create some.
> 
> Cheers
>   Nick
> 
> 
> 

-- 

- Arnaldo
