Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230B9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DD820671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6Dsp2P5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DD820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbeGWT0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:26:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35537 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388096AbeGWT0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:26:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so965792pgv.2;
        Mon, 23 Jul 2018 11:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O3ni8bLTEZvj85251EwbeU+0NMyn+mohMG711e1z6GM=;
        b=i6Dsp2P5dakBQFU2WdNK/kFVslfl4b4qoZN2HQ1+HIQxP/rIxfZ1fwFYx7Xl56/t9v
         tY6pNxwpERYe5GkHFJd+tYjPgHbuuwwHgPzyiEMEhqNpIxrgwSdmdeSlqgRCw+0idc1j
         pA4NAzr5dGq4oJ77pirhA3ofE0xIX85eFKTw1BlozgPLjLQUstkf/Y3lh9i200vHDwtX
         AI1fmRU00lkLOKDZaPOf1wrAQ7/c3y4Fj6eXY9gpGORTBVprvCFTVNeEjbmrJ9ELW/Gs
         Ay1MKKp8hQdnqdPc501KrUcfGzKofajfbLdwCgEyeTHS3/9KjObL48LjFQohZOTrWx0F
         hiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=O3ni8bLTEZvj85251EwbeU+0NMyn+mohMG711e1z6GM=;
        b=Z7MojxH1D7tVNsPvcFkGnFTJH3ywZkuUnPBGxQC7Ff+Hoca82Uq9GsO0UW8ERXXfvu
         vUdwbKyNHvkWnQ5MfZswBDpnm1Cxt1dPzX84w8Aewem6YvAe2mOxYCQFC9rs+ySflz6+
         MsPuagcjXBv+OhnOazq5F0b8bZYLH0/JHc976CRMskDValIdxNdIo64QvW4fRgm7+P4B
         cGGkBze0Pt0IHi9eyIqMrutcQw8Cr0GV+IAF249U3ErZBOFXlrqHfQbenJ6XInUmId5O
         NTLxqNsHoCVDNJd0KxMBlPs+7M+8zOuBf8bbgBJbJIfjBdLEqgNNMnv0oZNwBl2r2f8J
         0HeA==
X-Gm-Message-State: AOUpUlHoSlDjZKNYOF3tkJeRxOjRwpwTLTggiP0Df8k0sU3uJ5HLb0fm
        GiVWJpQMUKsUpNVAnU9qVdw=
X-Google-Smtp-Source: AAOMgpd1HqGnpKI0Kb5CsAi1dM8sGITcXY1IQE+uEYUgo1wrrj13InrwjRHDrX9L5SQQmJAZY9s7zQ==
X-Received: by 2002:a62:1016:: with SMTP id y22-v6mr14359173pfi.109.1532370255152;
        Mon, 23 Jul 2018 11:24:15 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s66-v6sm13082263pfe.53.2018.07.23.11.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 11:24:14 -0700 (PDT)
Date:   Mon, 23 Jul 2018 11:24:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Perches <joe@perches.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dev-harsh1998 <harshitjain6751@gmail.com>, trivial@kernel.org,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] touchscreen: elants: Use octal permissions
Message-ID: <20180723182412.GA2964@roeck-us.net>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
 <20180723131954.30739-4-harshitjain6751@gmail.com>
 <20180723133200.GA1167@kroah.com>
 <20180723171831.GC100814@dtor-ws>
 <e257bc89eb082e9fdc342d6f794c15a2805c98a9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e257bc89eb082e9fdc342d6f794c15a2805c98a9.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:25:10AM -0700, Joe Perches wrote:
> On Mon, 2018-07-23 at 10:18 -0700, Dmitry Torokhov wrote:
> > On Mon, Jul 23, 2018 at 03:32:00PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jul 23, 2018 at 06:49:20PM +0530, dev-harsh1998 wrote:
> > > > WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> > > > +static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);
> > > > 
> > > > WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
> > > > +static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw)
> > > > 
> > > > WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> > > > +		.dattr = __ATTR(_field, S_IRUGO,			\
> > > > 
> > > > Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
> > > 
> > > This name doesn't match up with the From: line above :(
> > > 
> > > Please fix up and try again.
> > 
> > dtor@dtor-ws:~/kernel/linux-next$ git grep S_IRU | wc -l
> > 7605
> > 
> > We either need to run a tree-wide script or leave this alone. FWIW I am
> > perfectly fine with either octals or symbolic names so I do not see
> > benefit of doing conversion for code that is not known to be broken.
> 
> About half of those are in one subsystem (drivers/hwmon)
> 
> $ git grep -w S_IRUGO | cut -f1,2 -d'/' | \
>   sort | uniq -c | sort -rn | head -10 | cat -n
>      1	   3846 drivers/hwmon
>      2	    748 drivers/scsi
>      3	    215 drivers/infiniband
>      4	    168 drivers/usb
>      5	    109 drivers/media
>      6	    106 drivers/input
>      7	    102 drivers/platform
>      8	    101 drivers/misc
>      9	    101 drivers/gpu
>     10	     91 drivers/edac
> 
> The generic reason is octal is readable and S_<FOO> is unintelligible.
> 
> https://lkml.org/lkml/2016/8/2/1945
> 

That is Linus' opinion, but not mine. Granted, my opinion doesn't count
much, but enough that I won't waste my time updating the hwmon subsystem
to match the new rules. Rules change all the time, and I am quite sure
checkpatch will find a lot of stuff to complain about (again) in the
hwmon subsystem, after my last spout of cleanup a couple of years ago.
There are much more urgent issues to fix there (such as, for example,
converting the "offending" drivers to the latest API, which would
magically cause most of the offenders to disappear).
No one but me cares about those, so bothering about the use of S_<FOO>
in hwmon seems to be quite pointless. Except, of course, it is quite
useful to have something to point to as bad citizen.

Guenter
