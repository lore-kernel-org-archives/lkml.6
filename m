Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622FDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA392083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550771561;
	bh=JbV4OYw1Bqb3mdLJcWNodnvtjVFApIVXgeTDmuMut+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bZbzIEEbdNwhqLc5GWOUA9lcMpR2Cq3yE7ErPieXuEf5qBLmltkwm22gOq+kSLBAU
	 aOgaQbr40nWBcYU1T5PqahYyOIV87ypdjAv2KqBTBVRy6O4+Lw5kETbngWpwhoFB4r
	 UideCm+KklQK6EFiW8INRnL+nVAtZbpqy7O16cRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfBURwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:52:39 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44433 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBURwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:52:38 -0500
Received: by mail-yw1-f67.google.com with SMTP id x21so11133694ywx.11;
        Thu, 21 Feb 2019 09:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=99V/TpmgY16yPJsDDUmemDd6inHJjzEgGkZndTVMWVg=;
        b=nm4TiY9FR6sv5OKDkBq6gijoc1hDHHK9HW3D1uSBYHmnOxYmuEFa+fnQ3qD+pFyMxe
         mcfd5/rxY2Q6MQw1YL/GangZwhJpGeNIfrt3UeWrT66lqQ/qYIhY/3SlTCdJmJBdj180
         JcRXAU9DQiRmRsd+geVkJSpxH0f8keQrrrWiDhT+etvMUnMtJO6egea1Q+8aaSmpuZHf
         fEPXkd5o/MW9H/+k7SdndmYBn7pCmZ05bhXYBDVrxroacKxSUwDUJJ4FAMvUQ9udad2C
         QI1OM7lpaS7j4a4fM0EYhekVfXsxuAbd0NKb9eLLE6LBojE0OrU0x6TErgVPySAg6tQ2
         ln4g==
X-Gm-Message-State: AHQUAuZLBNe2GDe7k24m70mRlLgae51ZPcX/a/sOexRnxwgP9r2m2mWG
        hbY6Q9Fif+6QU8603vv6yUM=
X-Google-Smtp-Source: AHgI3Iba/AdQPCbk/G4qADTHaORk9J/C2OLzr+4P/KowRGCzzPF+tbxqmDmZA7n7IbKbacVuJH087Q==
X-Received: by 2002:a0d:f881:: with SMTP id i123mr34197689ywf.453.1550771557819;
        Thu, 21 Feb 2019 09:52:37 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id j65sm7277830ywf.21.2019.02.21.09.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 09:52:35 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 21 Feb 2019 09:52:32 -0800
Date:   Thu, 21 Feb 2019 09:52:32 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, netdev@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] sysctl: Fix proc_do_large_bitmap for large input buffers
Message-ID: <20190221175232.GM11489@garbanzo.do-not-panic.com>
References: <53be40fc-6ec4-c714-a64e-f69c96f7058f@redhat.com>
 <76eca432-8dfc-18f3-4977-567ac1707ff5@sandeen.net>
 <20190221151854.GJ11489@garbanzo.do-not-panic.com>
 <72a6d9bc-cfb9-a21a-960d-bb01331c0dd7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a6d9bc-cfb9-a21a-960d-bb01331c0dd7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:47:49AM -0600, Eric Sandeen wrote:
> On 2/21/19 9:18 AM, Luis Chamberlain wrote:
> > On Wed, Feb 20, 2019 at 05:35:04PM -0600, Eric Sandeen wrote:
> >> Here's a pretty hacky test script to test this code via
> >> ip_local_reserved_ports
> > 
> > Thanks Eric!
> > 
> > So /proc/sys/net/ipv4/ip_local_reserved_ports is a production knob, and
> > if we wanted to stress test it with a selftest it could break other self
> > tests or change the system behaviour. Because of this we have now have
> > lib/test_sysctl.c, and we test this with the script:
> > 
> > tools/testing/selftests/sysctl/sysctl.sh
> > 
> > Any chance you can extend lib/test_sysctl.c with a new respective bitmap
> > knob,
> 
> Done

Thanks!

> > and add a respective test? This will ensure we don't regress
> > later. 0-day runs sysctl.sh so it should catch any regressions in the
> > future.
> 
> As you know, learning somebody else's test harness infra is a PITA. ;)
> Can you find me off-list and give me a hand with this?

Sure, its actually quite simple, just as root, run the script.

  Luis
