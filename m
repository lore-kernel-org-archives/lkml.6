Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566BFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E162087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfHltsGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E162087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeJKD6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbeJKD6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:58:47 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BB132087A;
        Wed, 10 Oct 2018 20:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539203698;
        bh=+SGEj3Cpe9xAQcHHbNiUC/B8w0fTNzRogbIVNMdhYqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfHltsGMtblpUHpAv2WoQ9zcou+u6dH+JVlDPg2NAtlsA9VPdb7dLilHf9u2o0Rml
         Dn3EcZPRSFvz2MNjJjdhlwrdvymJpXNv1D5U1lUlvVSRkxQfW2OsUxuQXAly4RmFQ/
         Tab6LM7upZgObshzTCubdT8DFDcG33FieGXfiMlg=
Date:   Wed, 10 Oct 2018 22:34:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>, stable@vger.kernel.org
Subject: Re: [GIT PULL] vsprintf: Fix off-by-one bug in bstr_printf()
 processing dereferenced pointers
Message-ID: <20181010203455.GB6979@kroah.com>
References: <20181010091803.16e5312c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010091803.16e5312c@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 09:18:03AM -0400, Steven Rostedt wrote:
> 
> Linus (aka Greg),
> 
> It was reported that trace_printk() was not reporting properly
> values that came after a dereference pointer.
> 
> trace_printk() utilizes vbin_printf() and bstr_printf() to keep the
> overhead of tracing down. vbin_printf() does not do any conversions
> and just stors the string format and the raw arguments into the
> buffer. bstr_printf() is used to read the buffer and does the conversions
> to complete the printf() output.
> 
> This can be troublesome with dereferenced pointers because the reference
> may be different from the time vbin_printf() is called to the time
> bstr_printf() is called. To fix this, a prior commit changed vbin_printf()
> to convert dereferenced pointers into strings and load the converted
> string into the buffer. But the change to bstr_printf() had an off-by-one
> error and didn't account for the nul character at the end of the string
> and this corrupted the rest of the values in the format that came after
> a dereferenced pointer.
> 
> 
> Please pull the latest trace-v4.19-rc5 tree, which can be found at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> trace-v4.19-rc5
> 
> Tag SHA1: b5fc80d980ae316323e88c165084deef39afd168
> Head SHA1: 62165600ae73ebd76e2d9b992b36360408d570d8
> 

Now merged, thanks.

greg k-h

