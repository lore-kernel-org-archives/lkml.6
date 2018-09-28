Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5466C2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5466C2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeI1Q27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:28:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51389 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbeI1Q27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:28:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id y25-v6so1622612wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 03:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lGMHxH4BFovP6Taz0P/DUOoqw7PdkG2kKjivxOPydQk=;
        b=TH3Qnc/jJzrNHsf3ufXhQ+ahIYhrH90No2EIaFbJzuH74xX0w0HxQo+oIoM4/EEYtA
         cDLOF4uN0hji+PeZzuPUVVAdyR9KqX9EXjLaE0uPg93/kEkP9yVA96EmqtP8Jzg2uZtp
         LrGOgTuBJlSFpa+17oPatSMl2gg/qhsxS0ww1zyzgX/NyMNfCIF7C+oMmma4OdYEbme7
         qY+MxZuF9iuD2LR87nmc7Hz4hCVAzThs8q5hAB+f3a/hVLS6ATzN/vq27PExt+fLYHuB
         oZeAvvAPwvoiRvZxQ5AY+psf7BSYelUz1hFEJgG4Fu8jiId4MmQgzt0QfVNG3F+sDI1l
         W/JA==
X-Gm-Message-State: ABuFfohnQP68eQrG/CURdgQigVYD+aNU/y0+pDJL4rcKAG4ETwx1paf0
        b6UwDMJpeXUj0Bo+ydgp2LR9
X-Google-Smtp-Source: ACcGV60Uf2bDcvgqQt7B9/bzG/PTbdWNbJAFfUjHk+k1w5aTyFm+PkYZcgBdYl9iDf0ap8OIY79tKQ==
X-Received: by 2002:a1c:5e48:: with SMTP id s69-v6mr1138135wmb.19.1538129157494;
        Fri, 28 Sep 2018 03:05:57 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust844.9-3.cable.virginm.net. [82.17.115.77])
        by smtp.gmail.com with ESMTPSA id y14-v6sm1286222wmi.20.2018.09.28.03.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 03:05:56 -0700 (PDT)
Date:   Fri, 28 Sep 2018 11:05:55 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] slub: extend slub debug to handle multiple slabs
Message-ID: <20180928100555.bvv75beo3c57g6vw@atomlin.usersys.com>
References: <20180920200016.11003-1-atomlin@redhat.com>
 <20180921163412.de1b331a639a8031aaf85d4f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180921163412.de1b331a639a8031aaf85d4f@linux-foundation.org>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
User-Agent: NeoMutt/20180323-113-abcfed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-09-21 16:34 -0700, Andrew Morton wrote:
> On Thu, 20 Sep 2018 21:00:16 +0100 Aaron Tomlin <atomlin@redhat.com> wrote:
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1283,9 +1283,37 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
> >  	/*
> >  	 * Enable debugging if selected on the kernel commandline.
> >  	 */
> 
> The above comment is in a strange place.  Can we please move it to
> above the function definition in the usual fashion?  And make it
> better, if anything seems to be missing.

OK.

> > -	if (slub_debug && (!slub_debug_slabs || (name &&
> > -		!strncmp(slub_debug_slabs, name, strlen(slub_debug_slabs)))))
> > -		flags |= slub_debug;
> > +
> > +	char *end, *n, *glob;
> 
> `end' and `glob' could be local to the loop which uses them, which I
> find a bit nicer.

OK.

> `n' is a rotten identifier.  Can't we think of something which
> communicates meaning?

OK.

> > +	int len = strlen(name);
> > +
> > +	/* If slub_debug = 0, it folds into the if conditional. */
> > +	if (!slub_debug_slabs)
> > +		return flags | slub_debug;
> 
> If we take the above return, the call to strlen() was wasted cycles. 
> Presumably gcc is smart enough to prevent that, but why risk it.

OK.

> > +	n = slub_debug_slabs;
> > +	while (*n) {
> > +		int cmplen;
> > +
> > +		end = strchr(n, ',');
> > +		if (!end)
> > +			end = n + strlen(n);
> > +
> > +		glob = strnchr(n, end - n, '*');
> > +		if (glob)
> > +			cmplen = glob - n;
> > +		else
> > +			cmplen = max(len, (int)(end - n));
> 
> max_t() exists for this.  Or maybe make `len' size_t, but I expect that
> will still warn - that subtraction returns a ptrdiff_t, yes?

I think max_t(size_t, ...) should be appropriate?

I'll address the above and in the next version.


> > +
> > +		if (!strncmp(name, n, cmplen)) {
> > +			flags |= slub_debug;
> > +			break;
> > +		}
> > +
> > +		if (!*end)
> > +			break;
> > +		n = end + 1;
> > +	}
> The code in this loop hurts my brain a bit. I hope it's correct ;)

It works :)



-- 
Aaron Tomlin
