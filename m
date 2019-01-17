Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C6BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932E620855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547731579;
	bh=yKvky8E4Nm1jthZwE/JbLv4cRdicncJi3szgaxFAUfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SZ6F+0cBl1pv4u241GjZYVr/mB7jDcJqD4RbRSvjM4RDYlyNZBqUZbHRX9iHinn44
	 lx/J0Yf57H/Klwhr1JVoroYiELaGb9vG9y5W92rqzE+HjrPoKROVeEE7Yn1CiGbYpG
	 rlAMoTRCeiiNGTLdqp0S9X6zK2GCyXfTPNJ/FlFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfAQN0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:26:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfAQN0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:26:17 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 236DE20657;
        Thu, 17 Jan 2019 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547731576;
        bh=yKvky8E4Nm1jthZwE/JbLv4cRdicncJi3szgaxFAUfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFTT0O74OpIilQM38QAPwcMcP612RCY7Iz0u39kX2d8K254ntUN9z4LAQkSvrurae
         AjaaJ0HwtKjn8a2QLRklqfOXvFVfuTkOqeARIuwug+yB/F6KrP5dVCg3JsWSGlMwPm
         lUbShHclpHmxG0qyWFyhA86iHPZ0PGtY8azOIrj0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 180D141AB5; Thu, 17 Jan 2019 10:26:13 -0300 (-03)
Date:   Thu, 17 Jan 2019 10:26:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Clifton <nickc@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@lge.com
Subject: Re: [RFC] perf tools: Filter out hidden symbols from labels
Message-ID: <20190117132612.GI11922@kernel.org>
References: <20190115135354.11572-1-jolsa@kernel.org>
 <960f0b83-a623-67a6-ab55-d56139d10ba2@redhat.com>
 <20190115163540.GA20159@kernel.org>
 <20190116043735.GA31070@sejong>
 <35bf274a-f91e-1b4f-398a-dbe6f4105dfd@redhat.com>
 <20190116133117.GA2243@kernel.org>
 <db34cf8a-d929-ffe1-91a5-ed3da0c6df86@redhat.com>
 <20190116160422.GH2243@kernel.org>
 <d33966dd-6146-f73a-ee01-693767a7f538@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d33966dd-6146-f73a-ee01-693767a7f538@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 17, 2019 at 10:25:24AM +0000, Nick Clifton escreveu:
> Hi Arnaldo,
> 
> >>> Humm, is -fno-omit-frame-pointer there by any chance? :-)
> 
> > Would be interestint to have that info, as we could hint the user that
> > backtraces should be done with something else than '--call-graph fp' :-)
> 
> OK, well I have added the feature to annobin 8.67, now in Fedora
> rawhide.  Unfortunately it will take a while before the information
> actually gets into binaries, since the new data is only recorded
> when a package is rebuilt.  So basically you are looking at Fedora 30
> at the earliest.

That is not a problem, I have containers for rawhide, so I can just go
ahead and do a podman pull + build, build some binary, and then add the
feature, the warning will get into effect when that note is found and
userspace callchains are used without DWARF info for such binaries.
 
> If you want to see the plugin in action, build something on a rawhide
> system (or a mock chroot) using the gcc command line option -fplugin=annobin.

Right, that is what I'll do as soon as I get the time.

> (Make sure that you have annobin-8.67 installed).  Then once the binary 
> is built run "readelf --wide --notes <file> | grep omit" to see the 
> omit-frame-pointer notes.

Thanks for the hints, I'll get you CCed when I get to work on this.

- Arnaldo
