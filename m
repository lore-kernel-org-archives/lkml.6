Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFABC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2214223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2214223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbeKLUv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:51:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:48596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728350AbeKLUv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:51:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A823B044;
        Mon, 12 Nov 2018 10:59:13 +0000 (UTC)
Date:   Mon, 12 Nov 2018 11:59:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 01/10] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
In-Reply-To: <20181112115419.3e86d8a522b6c7457c036dc9@kernel.org>
Message-ID: <nycvar.YFH.7.76.1811121158340.27368@cbobk.fhfr.pm>
References: <20181110231732.15060-1-namit@vmware.com> <20181110231732.15060-2-namit@vmware.com> <20181112115419.3e86d8a522b6c7457c036dc9@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018, Masami Hiramatsu wrote:

> > text_mutex is currently expected to be held before text_poke() is 
> > called, but we kgdb does not take the mutex, and instead *supposedly* 
> > ensures the lock is not taken and will not be acquired by any other 
> > core while text_poke() is running.
> > 
> > The reason for the "supposedly" comment is that it is not entirely clear
> > that this would be the case if gdb_do_roundup is zero.
> > 
> > This patch creates two wrapper functions, text_poke() and
> > text_poke_kgdb() which do or do not run the lockdep assertion
> > respectively.
> > 
> > While we are at it, change the return code of text_poke() to something
> > meaningful. One day, callers might actually respect it and the existing
> > BUG_ON() when patching fails could be removed. For kgdb, the return
> > value can actually be used.
> 
> Hm, this looks reasonable and good to me.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Yes, I guess this is much better than putting the 'enforcement by comment' 
back in place :)

	Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks.

-- 
Jiri Kosina
SUSE Labs

