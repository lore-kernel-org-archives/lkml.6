Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43520ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13D220852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBoOtjNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13D220852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbeGWSUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:20:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35361 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388699AbeGWSUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:20:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6-v6so847313pgv.2;
        Mon, 23 Jul 2018 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nmUr9Cb74F9fIXP3P9WCnn03xoD4AehDWD0zbZrre7Q=;
        b=eBoOtjNX8WIDZbJDjHx98kTVlNGm637aJKRJBriACM030Fib1EN+Ft65hdLoARTR68
         laqkpllLuRlXEQIkxFKBr99+wXEslyB7WUJJ0CpM1dye7mLxBoxofyCLY5Rd90wok1+/
         pXxiyy/Kxq+KGBmPWr0CkiBpNFZoBeEu6dadXw/1o2ACX6ahz29fi2I7ufgqbMW+8CWc
         9nDSSO+kuJhbaKF05ubKiS38SnDr7ctplL5SNq/UfVsLmPbIIJn1bRahYjcKPI45xLKp
         0qsQCFmdaHw5hCvT6VMIyKfqTexYbFvNwdqMPPPqBXFyXKxIFZCoWQQ9/fsiIXi67A/u
         MUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nmUr9Cb74F9fIXP3P9WCnn03xoD4AehDWD0zbZrre7Q=;
        b=e3uK3QYR+2hswpk2D7KXQOcoS78Yg04jW8PmfGQvnga8SPATr8SBsSFs+cGsxnCaL7
         TYjSShQjAFePm6wv29BynayEFmObu48UsPUtSq2IbY4MmP+i1S5y+0nXDXoN2Rbj+oiX
         wH4Hd5kwS+YHaYNl4ZJp2XsKOEazcpAFRiSRu9eymWiCCdkOD4FhOBf0wihdfpcEu+3L
         ap7VyaoVwDr2jG7ieEzbwaekSgNbtaaH9UQG0rFPpBrzFkf/q8IWZsPgzeh51Vnxd/K7
         Lk8nS/KUryMGBlbHG7JIBRVivGbw6c7u+6GirkiP53O07NDKPYOnNDdUB2Acl5bkG1w4
         jLBw==
X-Gm-Message-State: AOUpUlH8BXkyX8f65CpeuzWWEjaOop4NSZX1qdzyubTwsQYMu1vU+o3z
        kfn3uEshdmlGT/M3Fo3RJC0=
X-Google-Smtp-Source: AAOMgpfjcZM39sGPIbY7oB4riQ0bxH2TiWAWz2F9gQpwGIHHqzxXUYWSq/SfT0Yrmrr8syvNjSanYQ==
X-Received: by 2002:a63:db4f:: with SMTP id x15-v6mr738490pgi.214.1532366314485;
        Mon, 23 Jul 2018 10:18:34 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id b73-v6sm18812762pfl.152.2018.07.23.10.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:18:33 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:18:31 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dev-harsh1998 <harshitjain6751@gmail.com>, trivial@kernel.org,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Joe Perches <joe@perches.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] touchscreen: elants: Use octal permissions
Message-ID: <20180723171831.GC100814@dtor-ws>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
 <20180723131954.30739-4-harshitjain6751@gmail.com>
 <20180723133200.GA1167@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723133200.GA1167@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 03:32:00PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 23, 2018 at 06:49:20PM +0530, dev-harsh1998 wrote:
> > WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> > +static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);
> > 
> > WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
> > +static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw)
> > 
> > WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> > +		.dattr = __ATTR(_field, S_IRUGO,			\
> > 
> > Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
> 
> This name doesn't match up with the From: line above :(
> 
> Please fix up and try again.

dtor@dtor-ws:~/kernel/linux-next$ git grep S_IRU | wc -l
7605

We either need to run a tree-wide script or leave this alone. FWIW I am
perfectly fine with either octals or symbolic names so I do not see
benefit of doing conversion for code that is not known to be broken.

Thanks.

-- 
Dmitry
