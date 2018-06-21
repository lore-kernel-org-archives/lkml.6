Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437DAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE360208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzkrMAQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE360208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933162AbeFUKf7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:35:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41644 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933120AbeFUKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:35:50 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so2626059wrq.8;
        Thu, 21 Jun 2018 03:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2k+A32QjIQ1kl3aLWy9LQJpPlbaVB/yt7NEo3Yl+A/4=;
        b=qzkrMAQKIfRnJCtL6QeBNAPIMgUwP+zLZF6oUWhPYipNiEODrAcanpBIuLW8raI28u
         CZE74HcnAPNtITsf0isdy9hBH+dv9rCO3BfulT6IANNoPhzOr9yXgdrj3brGBPN48lWK
         2NTSxhwGY6kMx4GcoiArN3aCtpkwKjmodVCxOGSJmCwJA3aWnTbZtaJsj8zXQcIp8QN1
         /S6b6+D7+4YNnDEmFjiaUpqmidL8Yc/ldw5iDwPQX2MyqfO5DB0iLghCpOfI2Ljex1tU
         j5vAzftpfruzYqCZ9hWV1KNVtFwd/s3pqNHN4SDYOfA5Tm7cl+qnk/cugXFLYGUId/mU
         0IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2k+A32QjIQ1kl3aLWy9LQJpPlbaVB/yt7NEo3Yl+A/4=;
        b=bF2ASjTh2P6kJ0qjVKifWkgBUeedSy1YbxnzRCQ48CNxjHxpetavnvVlkhDxPklknf
         Jf4ypTtvzRHgL0r8eqy1JH8nvcgGxT8RVw1NtUIoKdL4WdHjKZgzGbeu7G+DQo5jYrBk
         nvhH9Zai/fPwy1tdO2HdSvmlvYFGZNH5eFc40QPczZTM8W+Qne51JVRvbFCaMaC4WMul
         UDmQagUvfE+2XUhQg/MJ0hYl5/UHZpKcY5ETH8Ectq8zUIBfu03D701YyD0LNjdpBXVB
         Ur2yWbMO+X1mpsSfyE6Susad5TXUTuBK2jpOnHsihctjUbWxooVxhyU5kytSWcEc634/
         5kFA==
X-Gm-Message-State: APt69E3rIM+3y0jna+6x+Oo4QHRVfwVRg5Yq/LfRGX7zd32saHCTQste
        MNpLPwIPgxwWeccdHPRzey0=
X-Google-Smtp-Source: ADUXVKIHf/cRManqa7VKxZqH8jK4YKvcuHghuPa/gIlJxe9Np45MyusT3igDZQ+ahvSsn6iPMTTuWA==
X-Received: by 2002:a5d:4503:: with SMTP id s3-v6mr21379657wrq.191.1529577349441;
        Thu, 21 Jun 2018 03:35:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v15-v6sm1732918wrq.37.2018.06.21.03.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 03:35:48 -0700 (PDT)
Date:   Thu, 21 Jun 2018 12:35:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH -tip v6 26/27] Documentation: kprobes: Add how to change
 the execution path
Message-ID: <20180621103546.GA9212@gmail.com>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
 <152942500680.15209.12374262914863044775.stgit@devbox>
 <706832c5-dab4-f806-96d6-2cdc37203d9d@infradead.org>
 <20180620172637.35916da482442b6ab139c7dc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620172637.35916da482442b6ab139c7dc@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Tue, 19 Jun 2018 09:31:49 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > On 06/19/2018 09:16 AM, Masami Hiramatsu wrote:
> > > Add a section that explaining how to change the execution
> > > path with kprobes and warnings for some arch.
> > > 
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: linux-doc@vger.kernel.org
> > > ---
> > >  Documentation/kprobes.txt |   20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
> > > index 3e9e99ea751b..8a98eed1521b 100644
> > > --- a/Documentation/kprobes.txt
> > > +++ b/Documentation/kprobes.txt
> > > @@ -80,6 +80,26 @@ After the instruction is single-stepped, Kprobes executes the
> > >  "post_handler," if any, that is associated with the kprobe.
> > >  Execution then continues with the instruction following the probepoint.
> > >  
> > 
> > Hi,
> > I have a few small suggestions...
> 
> Hi Randy,
> 
> Thank you for your suggestions!
> All of those are good to me. I'll fix it:)

Could you please send a delta patch on top of your v6 series, with Randy credited, 
etc?

I've applied your series and will push it out once it passes all testing.

Thanks,

	Ingo
