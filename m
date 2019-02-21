Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DC6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345282083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550762341;
	bh=7W+mwZgfrpQK37FjHAaNHcxyjAT0Nm/W6lJSc52E/zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sJrOe1jhNy1I06IAJUlOYtkUb7i9lxciAxqDQfJpkvI1I/p34xAF13s1FGcsahmTQ
	 pIJeRBFL6FlqkWRtSRSco55B9iq2X64cgP72Kc99TFanqZgrhWxE+OEkvdEOk1uQX5
	 HKn7CJrOcca5bbQ2V5UnEBZwm6ObR5Sibb/PV9qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfBUPTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:19:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37127 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUPS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:18:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id q3so6949145pll.4;
        Thu, 21 Feb 2019 07:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YidAc/GoTVUX/8OegPrX96ZaUFBqzwe/YT7gCS30oSs=;
        b=uLL6pY1DqbvEgfABKCmBWCc/BM2y6g+/Cr5u2cWP0r7ll04/qGAfSMjhiJogUWyu2R
         llkDRkfFH5vql3SsfMoxTqLQUEOvWcmLbNwFGagF/dbiS4zMW18h/EoaX8PqQ0P/Bq53
         iMZ/mpyvkgsLSyrHfT8UWl7LyHReHloFMz8tfuhz9Ql4tht4BMbMXPyj1z3ri9owIP03
         AfORgOf9dmv5EQ3aVnP/3A2ytBFNy9bYuy6zPk3JgPmEg5LNZdAR0HCao1BG030l3pjW
         WKUlYcoMS5A4Wa6sketHLTlVH/0MuXyRvVC7d7s5Dviv7a347UC1uLiF6xE+1lXxQXON
         g+XA==
X-Gm-Message-State: AHQUAubOkMlswNkNr0/aobhLj8zaRtH8592LNVAScZVvi/epblLIYvVp
        gtkqFjQYiqGGlsE7b19dYWCv5ZBIZN8=
X-Google-Smtp-Source: AHgI3IZbmPOkkPnjMBh3VfukqhjMHEs1w9OeVGW/o8idzA0fDnXBcr9Zks9/tyjzLhY/LU7dJUkJbA==
X-Received: by 2002:a17:902:6a3:: with SMTP id 32mr43089330plh.319.1550762338743;
        Thu, 21 Feb 2019 07:18:58 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id t12sm55412945pgq.68.2019.02.21.07.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:18:56 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 21 Feb 2019 07:18:54 -0800
Date:   Thu, 21 Feb 2019 07:18:54 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Sandeen <sandeen@sandeen.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, netdev@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] sysctl: Fix proc_do_large_bitmap for large input buffers
Message-ID: <20190221151854.GJ11489@garbanzo.do-not-panic.com>
References: <53be40fc-6ec4-c714-a64e-f69c96f7058f@redhat.com>
 <76eca432-8dfc-18f3-4977-567ac1707ff5@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76eca432-8dfc-18f3-4977-567ac1707ff5@sandeen.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 05:35:04PM -0600, Eric Sandeen wrote:
> Here's a pretty hacky test script to test this code via
> ip_local_reserved_ports

Thanks Eric!

So /proc/sys/net/ipv4/ip_local_reserved_ports is a production knob, and
if we wanted to stress test it with a selftest it could break other self
tests or change the system behaviour. Because of this we have now have
lib/test_sysctl.c, and we test this with the script:

tools/testing/selftests/sysctl/sysctl.sh

Any chance you can extend lib/test_sysctl.c with a new respective bitmap
knob, and add a respective test? This will ensure we don't regress
later. 0-day runs sysctl.sh so it should catch any regressions in the
future.

If you can think of other ways to test the knob that would be great too.

  Luis
