Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA70C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D962077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="L747lWAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D962077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeJOCfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 22:35:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36950 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeJOCfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 22:35:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id y11-v6so18727379wrd.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 11:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JuhbEV0U6hwhoL05wMR+1rOAMqMihGmwHMLvhRaHFR4=;
        b=L747lWAWt3gdH0jlbv/1R4fMLbdzuBMOPUGHVZUZEbCaKhqly5zsI7tOSrn6V/I6HG
         kNEwNiRMOKdvso0w1jdU86dWuh80pSvP/MGzJ/fMUBq5wwkx4zBNgn8UAEETsq6IfJ2U
         LLldL6xrdHRSzQo6/KBevzgCY5PWkQkhideRB7u/KQtctLwB90igQUfBpy1JxEQsUIx5
         Anu1sSsyzKik/y7+vmak0QG/fSIORBChYCTzVctZlRCNV3XSTrslwA3jRx95xuj8O1TO
         FEbAG9augUq8ZBbXJlMzkpNlLwD+XdiEdG0t9SI+r6URATqYpM3EMFjXdB07NogCfkc7
         FMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JuhbEV0U6hwhoL05wMR+1rOAMqMihGmwHMLvhRaHFR4=;
        b=YBiYhyoaVq76Dmo08LcH3BcRHgYWflqZ8HPMOYPzTNSUIN6+HW7jeSchBB2sy6pxnN
         7tvCEkMc4Uywfmua8DywolLv7rf8SHod+aI57Ni0tq6iCn8gxOvVcqztP/J/idC/KVPP
         hnT8nUFMOGSSOjA4wTw0X4QvbBfFdvF6yguOZ8+rozCKX6dMcrEhU2hnir7p1QzFImqK
         jIzwP5kxCSCSuJR73kkrMX4iSvNhaN4cpzmc8yPn0YYso0VBGiDc/6EIqZxnTdDc/FrD
         vajbNGfknCOCVAdS0Mmr8AZlHzFdsYoJ6BZt66P8IOmJAEgZaqoYuY+z0PDX+x7yr7ly
         UG2g==
X-Gm-Message-State: ABuFfoijXP2dC4E5CwTTRMbvXOkiyiy2og6QB4a4nY25gLNvCNLnB5xk
        noVy1o62Xo70TKolMo7lVVbAHQ==
X-Google-Smtp-Source: ACcGV62FJsx9c+UyYU0Ab+bXleNjCO+VI7UpRPEAHtq8yM0kk8o8VkoMi5TkjG0Ph0XTJHTQxN8RDg==
X-Received: by 2002:adf:be07:: with SMTP id n7-v6mr11328224wrh.267.1539543233485;
        Sun, 14 Oct 2018 11:53:53 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id e67-v6sm7074463wmd.41.2018.10.14.11.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 11:53:52 -0700 (PDT)
Date:   Sun, 14 Oct 2018 20:53:46 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com
Subject: Re: [PATCH 1/2] sysctl: add overflow detection to proc_get_long()
Message-ID: <20181014185345.o6uokigiytqugg6v@brauner.io>
References: <20181014132510.25943-1-christian@brauner.io>
 <20181014132510.25943-2-christian@brauner.io>
 <20181014171855.GW32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181014171855.GW32577@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 06:18:55PM +0100, Al Viro wrote:
> On Sun, Oct 14, 2018 at 03:25:09PM +0200, Christian Brauner wrote:
> 
> > +static unsigned long sysctl_strtoul_lenient(const char *cp, char **endp,
> > +					    unsigned int base, bool *overflow)
> > +{
> > +	unsigned long long result;
> > +	unsigned int rv;
> > +
> > +	cp = _parse_integer_fixup_radix(cp, &base);
> > +	rv = _parse_integer(cp, base, &result);
> > +	if ((rv & KSTRTOX_OVERFLOW) ||
> > +	    (result != (unsigned long long)(unsigned long)result))
> > +		*overflow = true;
> > +	else
> > +		*overflow = false;
> 
> Yecchh...  First of all, the cast back to unsigned long long is completely
> pointless.  What's more,

Sorry, seriously asking: why? This was meant to handle the case where
sizeof(unsigned long long) != sizeof(unsigned long) and I just looked at
_kstrtoul() which does the same:

int _kstrtoul(const char *s, unsigned int base, unsigned long *res)
{
	unsigned long long tmp;
	int rv;

	rv = kstrtoull(s, base, &tmp);
	if (rv < 0)
		return rv;
	if (tmp != (unsigned long long)(unsigned long)tmp)
		return -ERANGE;
	*res = tmp;
	return 0;
}

Sorry, if I'm being dense here.

> 	if (expr)
> 		foo = true;
> 	else
> 		foo = flase;
> is a fairly unidiomatic way to spell foo = expr;
> 
> And... is there anything that would really care if this "overflow" thing had
> been replaced by simply returning ~0UL on such?  That would appear to be
> a lot more natural API...

Yes, I thought about this but I really didn't want to risk breaking
anything that relies on the weird old behavior. We can change it to that
and assume that anything that doesn't explicitly set a maximum value
wants to be capped at ULONG_MAX. Fine with me.
