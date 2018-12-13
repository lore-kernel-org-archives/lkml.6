Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CFCC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669B120870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="cmtNbrLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669B120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeLMUwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:52:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34989 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLMUwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:52:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so3400387wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 12:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BpNv9ccLyR9E1IN+AlajsDMHnXXbLFU5paJ5yRuJZE4=;
        b=cmtNbrLbiZVQwl6JRkzUN683oQIjG7w9pb43+mMy2zRi3S7N9rawMDwoKJzIWskwsX
         jBJYt/ap8D3Am+4hgrrlpG+sMEztpcM8eOZu9ml94TdHHztlY9p/LGdnvQ/kxwwysERZ
         TvbPxrKf2xTXOyo51Anh8pmW/T4d4+AJiFAuloWYUDGUNKiOjnNO3war1iedvslgdeye
         B27dan/iELzq9OI2Wva0rdK3Q/e5dcP+WvLMRG5vcpGYb76gJAy2uf6Q875yjSOpRm5c
         dE+1pkyGMN8o2/uHWnvxUkAuF4/1SBpcG3LRdpLyxTmMJUpd2OHYrbFkHUtlsHLAXfgB
         FqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BpNv9ccLyR9E1IN+AlajsDMHnXXbLFU5paJ5yRuJZE4=;
        b=ToQ4/oKajCJC9zboM3pagH3ttJVuespWU8FbD8JoUuwkHSJKy/Z1MBMHipGEmBcOYQ
         1KOTt98jmWnIS9z4KTV65LN7y8Rs6m3Nn93pO3e2WrBxCrcE+PgbRv5033M+qyXchxmN
         ZWWpFQrq9Vytcl8sitOqRHGlo9eJpxR5S8SVlqXR5gQFskgmK4TQ4pw7CJMO68WHvs8O
         7DrLAJpoLwvkeUeNwlCfjVLwWlv13LQaDzpPRNxASwyiJ5Zw4lv0JVzQT4OKeuplKaTW
         HGucDXk1HgzI2TVktm5Q3X9vbP63KwtpdGsAz+eaYDz9GEj/SRVPdNG6ecDgzUwlYI+A
         vj8Q==
X-Gm-Message-State: AA+aEWaUUestNYO4AzwmGWv5Eg4NIQJ7fdADDJkYQ5B72NIN/ecDG6oI
        8CdZBj0a8llDqgAHPHYWeFHT4w==
X-Google-Smtp-Source: AFSGD/W5x7JbG9Dc8ym8Oh9DzY6GcjJbE9M4OO2XsA7DGeOf0BUhGOC8wCr5M7hf0s9m4Is2hee8Jw==
X-Received: by 2002:adf:d112:: with SMTP id a18mr279928wri.17.1544734325050;
        Thu, 13 Dec 2018 12:52:05 -0800 (PST)
Received: from brauner.io ([2a02:8070:88c2:4000:69e7:45c9:1529:166d])
        by smtp.gmail.com with ESMTPSA id o64sm2493876wmo.47.2018.12.13.12.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 12:52:04 -0800 (PST)
Date:   Thu, 13 Dec 2018 21:52:03 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Todd Kjos <tkjos@google.com>, Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        joel@joelfernandes.org, darrick.wong@oracle.com,
        david@fromorbit.com, kilobyte@angband.pl,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        chouryzhou@tencent.com
Subject: Re: [PATCH v1] binder: implement binderfs
Message-ID: <20181213205201.d4stjhypnseb3ska@brauner.io>
References: <20181207232509.31771-1-christian@brauner.io>
 <CAHRSSEzxR2wRw9UxaKkXTZ7cu989+70-V07PxMm6o+BfLTQ=6w@mail.gmail.com>
 <20181212125126.4lhnjvrvaz5wwpib@brauner.io>
 <20181213175626.GB7218@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213175626.GB7218@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 06:56:26PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 12, 2018 at 01:51:27PM +0100, Christian Brauner wrote:
> > > > Cc: Martijn Coenen <maco@android.com>
> > > > Cc: Todd Kjos <tkjos@google.com>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > Do we plan to bring this into mergeable shape before Christmas? I'm
> > happy to do it. :)
> 
> I haven't had the chance to give it a good review yet, but you should at
> least fix up the kbuild warnings that the 0-day bot sent you :)

__user is what's confusing kbot here. You want me to wait for your
review or send out a v2 right now? :)

Thanks!
Christian
