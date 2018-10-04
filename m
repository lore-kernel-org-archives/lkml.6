Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C5DC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119DB20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqJzMwaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119DB20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeJDTis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:38:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36942 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbeJDTis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:38:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so8929231wmt.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tLiabrwTuzPUxUuYWAFygrrj583OqVF22kIbu/fsv+s=;
        b=RqJzMwaz2SLJEBrKV7ceweoT1AUUuJzKGP/jM7Kfv1B/L1Jf6xKKzEuK6SU5HQjvnX
         0PvyPhjRLYG09d5BJcAZJPfJSb4LUJkTMQ94Xck2Jm9R7+jTSVWkuebYvR80eg8IjUUB
         Om4JqvyJbQrBTLFORaM7IYFv2wxOaeucQUMBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tLiabrwTuzPUxUuYWAFygrrj583OqVF22kIbu/fsv+s=;
        b=laSWBBAQvyoxeutojC7lvrga4NttJRqubdVJBd/Tjzr3xE2vTaU4WvKECZ/Z3VW80c
         HfUKO0aj58qgWjOTCyBR3BHk0qRD+zKs1zkxHPVaxGrDxYHeaovDZu83pDxfLNVDLxLY
         rVI33evusxxIB6bNWePlvqyOa3pQaTO05cZDNXO8gNGquOKO2uz/LTo5eJy9FcmWzVT2
         TEIuK6/wk+mCnacOStkd1sUBmpamn4vmAZi/nitIKWG21wV/dRJKMi7ksxh6v5Pb1Yc1
         xROwYNxLr6WiIe02zYnQPMQ+fBBiWg5E50adaycKy6Rg5vNgveMsHGPrNYeIsx36C2ID
         w1vQ==
X-Gm-Message-State: ABuFfoi0qKZHO3E8VMpxPgUCHK6MNxSc3dljVQGI33Ltbv09HDCiGr+A
        qQGwGaaFkvq2SpmyZahvXAuiug==
X-Google-Smtp-Source: ACcGV63vfbB+QYtcT8lyzyP7PppNfET+/WSpni/M191oyfdjkv1TU02Pmvae5jkw/tjQDkKW8wy5xw==
X-Received: by 2002:a1c:cc8:: with SMTP id 191-v6mr4489230wmm.55.1538657138260;
        Thu, 04 Oct 2018 05:45:38 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b5-v6sm2499585wrs.62.2018.10.04.05.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 05:45:37 -0700 (PDT)
Date:   Thu, 4 Oct 2018 13:45:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Jonathan Toppins <jtoppins@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v2] kdb: Use strscpy with destination buffer size
Message-ID: <20181004124535.narksjioip7zo7ha@holly.lan>
References: <20180920125914.17920-1-prarit@redhat.com>
 <9192af58-7966-c023-8b19-5b291839a228@linaro.org>
 <78793735-c2ce-62f6-d745-5fc06a17beb1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78793735-c2ce-62f6-d745-5fc06a17beb1@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 08:25:30AM -0400, Prarit Bhargava wrote:
> On 10/02/2018 11:53 AM, Daniel Thompson wrote:
> > On 20/09/2018 13:59, Prarit Bhargava wrote:
> >> gcc 8.1.0 warns with:
> >>
> >> kernel/debug/kdb/kdb_support.c: In function ‘kallsyms_symbol_next’:
> >> kernel/debug/kdb/kdb_support.c:239:4: warning: ‘strncpy’ specified bound
> >> depends on the length of the source argument [-Wstringop-overflow=]
> >>       strncpy(prefix_name, name, strlen(name)+1);
> >>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/debug/kdb/kdb_support.c:239:31: note: length computed here
> >>
> >> Use strscpy() with the destination buffer size, and use ellipses when
> >> displaying truncated symbols.
> >>
> >> v2: Use strscpy()
> >>
> >> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> >> Cc: Jonathan Toppins <jtoppins@redhat.com>
> >> Cc: Jason Wessel <jason.wessel@windriver.com>
> >> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> >> Cc: kgdb-bugreport@lists.sourceforge.net
> >> ---
> >>   kernel/debug/kdb/kdb_io.c      | 15 +++++++++------
> >>   kernel/debug/kdb/kdb_private.h |  2 +-
> >>   kernel/debug/kdb/kdb_support.c | 10 +++++-----
> >>   3 files changed, 15 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> >> index ed5d34925ad0..6a4b41484afe 100644
> >> --- a/kernel/debug/kdb/kdb_io.c
> >> +++ b/kernel/debug/kdb/kdb_io.c
> >> @@ -216,7 +216,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
> >>       int count;
> >>       int i;
> >>       int diag, dtab_count;
> >> -    int key;
> >> +    int key, buf_size, ret;
> >>           diag = kdbgetintenv("DTABCOUNT", &dtab_count);
> >> @@ -336,9 +336,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
> >>           else
> >>               p_tmp = tmpbuffer;
> >>           len = strlen(p_tmp);
> >> -        count = kallsyms_symbol_complete(p_tmp,
> >> -                         sizeof(tmpbuffer) -
> >> -                         (p_tmp - tmpbuffer));
> >> +        buf_size = sizeof(tmpbuffer) - (p_tmp - tmpbuffer);
> >> +        count = kallsyms_symbol_complete(p_tmp, buf_size);
> >>           if (tab == 2 && count > 0) {
> >>               kdb_printf("\n%d symbols are found.", count);
> >>               if (count > dtab_count) {
> >> @@ -350,9 +349,13 @@ static char *kdb_read(char *buffer, size_t bufsize)
> >>               }
> >>               kdb_printf("\n");
> >>               for (i = 0; i < count; i++) {
> >> -                if (WARN_ON(!kallsyms_symbol_next(p_tmp, i)))
> >> +                ret = kallsyms_symbol_next(p_tmp, i, buf_size);
> >> +                if (WARN_ON(!ret))
> >>                       break;
> > I'm getting confused by having two different branches on ret.
> > 
> > Don't get a WARN_ON() when ret == -E2BIG?
> > 
> > 
> 
> Should we WARN on a really long symbol?  I don't think we should as we're
> handling that by truncating the output and adding ellipses below.

It's OK. You describe the behaviour I expect but I was misreading the
code (not realizing that kallsyms_symbol_next() had not become a 0 on
success success function).

However after reviewing the code (properly this time) I wonder if the
WARN_ON() should be improved to match the return value for the function:

  WARN_ON(ret >= 0 && ret < len)

That said, checking the symbol length is pretty paranoid and getting
close to nitpicking so I'll leave it up to you and, with or without, the
change:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
