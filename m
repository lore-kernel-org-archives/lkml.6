Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B06C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB66218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549483094;
	bh=XtDOB3EcRzWi/IOMKeI5rN2yTPw39I2vsL4ZFz7RJKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TIZ8ugB3k0uJs4MD0AOSLdntyhjNfb3PscUZ7C8arzkAR258Te7eqrUguhDlkQ05W
	 EvXVmDagPZQ1y+Mw9x7kLG7tlQgnsSJk57NQGsugSSxj+VpH1tsUUhnIBpjBOGVbAN
	 m+l0KFKl9xdzfA6LdOKSx5gHxAx1SqgPAzm4yEzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfBFT6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:58:12 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46616 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfBFT6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:58:12 -0500
Received: by mail-yw1-f68.google.com with SMTP id n12so3616908ywn.13;
        Wed, 06 Feb 2019 11:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r8FQrPKG6TU6Tj0AK9rnqo1l6pvv4Z/Y/PYMLHN21PM=;
        b=XIO8TLF3EmKqeO+Umi3nT/8kLnCk7+s6/739eDtYcknzUJWMxAYA3KBEPtmYscq51a
         F7Um2VTKvAgrzAqw4AFOArvyJMuClslZKENjWKRBzyzJkpz/mkQt79IJdQd2vnVZB9qU
         /RWSwR8dMmUWlQnhc396Hrl4d35mlVY5exMXQujEaPj12krbxd80k1mZR8RSJwEissrY
         KNAO9RfPeN+nKcYQugd4vSq6xe18lsQpgaaXBc4KV6wNYpGVQ6QVBs1gsky9CSky3EYN
         2PnlWNJmmhcyd87Zp16KNp8Jn8oceU/xONRa/9LTvhVq8rfXEbn1c/GEsOfXKO7m3lFK
         xA3A==
X-Gm-Message-State: AHQUAubchLouQ68rgZaHTvO7XpeQ9k9p9zmT7tODuU0ZLIOaoEZFK2M1
        D75pGm3Isk1zFHvoU6ABpJQ=
X-Google-Smtp-Source: AHgI3IZZQwachc6PnCwpQ/a97KwlCJN3DeUdphErlgiCtbsNntJK3KhMrVsIHkT/SZGjgzh0epYi5w==
X-Received: by 2002:a0d:e045:: with SMTP id j66mr10045927ywe.33.1549483090885;
        Wed, 06 Feb 2019 11:58:10 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id z139sm2807573ywa.36.2019.02.06.11.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 11:58:09 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Wed, 06 Feb 2019 11:58:07 -0800
Date:   Wed, 6 Feb 2019 11:58:07 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        yzaikin@google.com, brendanhiggins@google.com
Subject: Re: [PATCH 2/2] kernel/sysctl.c: define minmax conv functions in
 terms of non-minmax versions
Message-ID: <20190206195807.GG11489@garbanzo.do-not-panic.com>
References: <20181227111231.12912-1-zev@bewilderbeest.net>
 <20181227111231.12912-3-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227111231.12912-3-zev@bewilderbeest.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 05:12:30AM -0600, Zev Weiss wrote:
> do_proc_do[u]intvec_minmax_conv() had included open-coded versions of
> do_proc_do[u]intvec_conv(), though the signed one omitted the check
> that the value is in [INT_MIN, INT_MAX].  Rather than increase the
> duplication further by copying the additional check, we can instead
> refactor both to be defined in terms of their non-bounded counterparts
> (plus the added check).

The code below looks fine, however it is a rather intrusive check.
Let's isntead open code the new bound check and Cc stable, and then
after we can get creative with the wrapper use.

Can you confirm the open coded version fixes the issues, and then
the other change does not regress? If you can include an annotation
as to since *when* this was broken by annotating it on your CC stable
note it would be useful for stable maintainers. Likewise if you can
add a respective Fixes: tag that would be appreciated if you can easily
find it.

The stable tag annotation can be placed on top of all the tags, for
instance if the first broken commit was in v4.1 then:

	Cc: <stable@vger.kernel.org> # v4.1+

Thanks for the fix and expanding on the tests!

  Luis
