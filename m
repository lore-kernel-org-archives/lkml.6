Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9EFC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FFE213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS01Pvec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FFE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJIAj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJIAj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:39:59 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D417213A2;
        Mon,  8 Oct 2018 17:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539019634;
        bh=dFeIITYrqZFxp/VTY2hT8wuRXHy4K9n+4SM9ouM459Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MS01PvecgSC2F/hfLKU9g/0jC7m2AXTohuvPP76vnT3ofWzFHQOxfckkopXWntIrY
         HvvZx3RgW6VbOaGl5UBncWgKhCCqE8tca67kNAnndCwBHF7yo3pvNvqVEfwZf6Vh+s
         WMrQBrniLzVOwsGXVdJNvnJGQnuWtFAfaKKbjGUI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 92856141DDC; Mon,  8 Oct 2018 14:27:10 -0300 (-03)
Date:   Mon, 8 Oct 2018 14:27:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Subject: Re: [PATCH v4] tools/lib/traceevent: Separate out tep_strerror() for
 strerror_r() issues
Message-ID: <20181008172710.GN3541@kernel.org>
References: <20181005121816.484e654f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005121816.484e654f@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 05, 2018 at 12:18:16PM -0400, Steven Rostedt escreveu:
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> While working on having PowerTop use libtracevent as a shared object
> library, Tzvetomir hit "str_error_r not defined". This was added by commit
> c3cec9e68f12d ("tools lib traceevent: Use str_error_r()") because
> strerror_r() has two definitions, where one is GNU specific, and the other
> is XSI complient. The strerror_r() is in a wrapper str_error_r() to keep the
> code from having to worry about which compiler is being used.
> 
> The problem is that str_error_r() is external to libtraceevent, and not part
> of the library. If it is used as a shared object then the tools using it
> will need to define that function. I do not want that function defined in
> libtraceevent itself, as it is out of scope for that library.
> 
> As there's only a single instance of this call, and its in the traceevent
> library's own tep_strerror() function, we can copy what was done in perf,
> and create yet another external file that undefs _GNU_SOURCE to use the more
> portable version of the function. We don't need to worry about the errors
> that strerror_r() returns. If the buffer isn't big enough, we simply
> truncate it.

Thanks, applied, replacing the previous version since this is still not
in tip.

- Arnaldo
