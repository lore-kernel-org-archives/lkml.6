Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED75AC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFE9213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGJRmNIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFE9213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeJJELO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:11:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39946 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbeJJELO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:11:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id 1-v6so1402551plv.7;
        Tue, 09 Oct 2018 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Wn8c8dAdUkI6QjyWcFHAfsO1yrg/TuzKz1KavsrX/Q=;
        b=FGJRmNIr51vvyMocQ5gF4VjDaXjXiXuAifBcE7Z8/ATQGzZYQndmI9k7pgvqXLwilw
         nlCVRpt3yrxBhiZZ0dGC7HMOIfIwNI1oGtcng+MUl1xbMhDgCfgeovR9mnVDotP7VZeC
         U1lrwyCAlwHEqAjIAW5wxEgDeeZ9v06SpaaEg9WU4j4eT6Uks/u5iysdgsU40vWwXzYw
         s27chkp1MATKCORnQDs9foomNWTPz+md+l87J5/sD68uNz99L5Pg+UuYjbiXjxmoq37d
         U4FwSSManBDK5K5vh3BVu/YNNwwzfYBtPk9KnKUbFJ27JUcGXxfNBF/evA0FbgXDSWBf
         ypEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Wn8c8dAdUkI6QjyWcFHAfsO1yrg/TuzKz1KavsrX/Q=;
        b=WQE+Ypmqy9zK+a79aM3lkFKfSqMloHoCLS5l5rfVnPFPn2rhHBdNpKi9oVYh/rh/LY
         GmnLPao0CE9b73hZoxbKMBsmZx7/gM8MJNZYJJM+n5JEEpyBp1vPlsVUsZfemDiDlPVy
         qFnDKnBJL8r9oNiQOgrelPih0PxmjpACdMJASq/T4m7qcGptouriAVwApO6WS7uf1xi6
         NcuWvG2eYndh+Ich+neFk5zq/+x9O0XhgazXEohh6cMNcN1do+TtlMl60u/s+GPi2no2
         hw57WEzRK6q6mDguA1gmnbc7yv3aDqMY9LLncTr2UT+HDQgludRartobwielhx2BNIpn
         tmHQ==
X-Gm-Message-State: ABuFfojmzQfzUG3srwsxqo2+ueygxvr9klY8wtgd0p7BCVhlJektQOZM
        G8jU9kv2sCMHdChtySogdbI=
X-Google-Smtp-Source: ACcGV63xVdBC831hNiN8sHHRnzZ7fihp9KAK/ry1nPfznQczMjIoCdQi5tqs8ksDEWxPmsAqf4JbEg==
X-Received: by 2002:a17:902:b78c:: with SMTP id e12-v6mr30034528pls.67.1539118348224;
        Tue, 09 Oct 2018 13:52:28 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 84-v6sm40208881pfs.108.2018.10.09.13.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 13:52:27 -0700 (PDT)
Date:   Tue, 9 Oct 2018 13:52:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH] hwmon: (core) Add trace events to _attr_show/store
 functions
Message-ID: <20181009205226.GA11520@roeck-us.net>
References: <20181009182602.3085-1-nicoleotsuka@gmail.com>
 <20181009145721.0669e412@gandalf.local.home>
 <20181009191111.GA6166@Asurada-Nvidia.nvidia.com>
 <20181009154945.65300231@gandalf.local.home>
 <20181009195654.GA7963@Asurada-Nvidia.nvidia.com>
 <20181009203937.GA11222@roeck-us.net>
 <20181009164242.76e397ad@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009164242.76e397ad@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 04:42:42PM -0400, Steven Rostedt wrote:
> On Tue, 9 Oct 2018 13:39:37 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > > Personally a checkpatch warning bugs me more than having an extra
> > > line :)
> > >   
> > Same here. If we no longer believe in the 80-column limit, we should remove it,
> > not use it to hide other problems in the noise.
> 
> Yes, please, can we?
> 
> I personally hate the 80 character limit rule, because I like
> descriptive variables and function names, which itself causes the 80
> character limit to be broken. I find line breaks to avoid that limit
> just makes the code look worse. Or at least up it to 100 chars.
> 

It is a two-edged sword. Downside is that a longer limit also invites
deeply nested loops and conditionals, which I am sure will be used as
argument against raising it.

Feel free to submit a patch to raise the limit to 100; I'll be more
than happy to give it an enthusiastic Reviewed-by:. My personal desire
for conflict isn't strong enough to submit it myself, though.

Guenter
