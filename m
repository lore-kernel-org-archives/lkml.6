Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70980C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411712154E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5N5KHJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411712154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeHOXec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:34:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35902 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeHOXec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:34:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id h12-v6so1003686pgs.3;
        Wed, 15 Aug 2018 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TK5iQzJbEXUv6NiAFa3HpCGNBHvinFMAJM+wzwix/lc=;
        b=T5N5KHJwZknnYflsjTH+Q+tKMBRi/2TGZOgBoexbg/oQ6fCGh108F5zmgQlt09VEKP
         cchujUGvFRkCvLqVA30pEjRPeWGQEHMff/BsHi6XEi2tp5FIyMMZl7rMNFexFMq0fiZl
         CrJW1UkCKY5+xrPjImSypefxidGXuA/62Pj4ufDYXidpv6Zn4Vh8bd6bXVTomdybnHB6
         isolluWdN+B5PVz/USVNQbHr7eQ4mb7GMLklvHT7V9K4/2Kr4cEVoV2LqtQYjuHUpMMW
         JbXwi3cWOgExs+z0S0oduq31RTPyT0oyLQe+q51n2mEBu5x9dbrBd22JgMWdcg3xi+do
         35Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TK5iQzJbEXUv6NiAFa3HpCGNBHvinFMAJM+wzwix/lc=;
        b=dBcAaCZHdlDJm3iNhYVLCk+4LhubiExewx3PapOGmkb/RDxq51j14Z7xs483ekHaIe
         wer26umyhhjBEiAoh0GbKHE+bNJcWarKQoyt66wbHOWa0Ra9wq0WbqYo3mu6LmyGbGOj
         1BZCa5ILCL9+tA3Zxuu2ydShiWDF4DCYKvubGCFle0ZEfrxxojKnKZWY2JIBelpXXTel
         8oEaBEM/VVPPWF70hctLk+u9V9LsVKYqE+8f3PkcLVVLxQWX0YjVokCtzPOwq+q72Cae
         95bbBw5EmB4ItwJe6TKdfuOHYsTyPa7Iu5nlWeyZfTjkny2VlVJKrJt5FsZIcWJPe3i3
         FZoQ==
X-Gm-Message-State: AOUpUlEpJ4rOTTp4horevyUhvuvU4692dxx6LUUDoHveTabOX1qAnUXh
        9bJh+udLQax6d/k4u52hZsM=
X-Google-Smtp-Source: AA+uWPyt8icaPN0b2/9VHvBeUM/JmcgsV6Y/Jo2cg3tkROfxLT9BvQaN8L7OPEkLXS2W94RJKtBKSw==
X-Received: by 2002:a62:3a9d:: with SMTP id v29-v6mr29163035pfj.215.1534365647216;
        Wed, 15 Aug 2018 13:40:47 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h130-v6sm86449378pgc.88.2018.08.15.13.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 13:40:46 -0700 (PDT)
Date:   Wed, 15 Aug 2018 13:40:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     s.gottschall@dd-wrt.com, Sven Joachim <svenjoac@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
Message-ID: <20180815204045.GB18407@roeck-us.net>
References: <20180814171520.883143803@linuxfoundation.org>
 <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
 <87k1orms9i.fsf@turtle.gmx.de>
 <55df6754-ce8c-520a-13f9-c610ac498173@dd-wrt.com>
 <20180815185553.GA18219@roeck-us.net>
 <69700876-f31a-ea0a-bdea-2e82b7a5d308@dd-wrt.com>
 <20180815192630.GA20575@roeck-us.net>
 <CA+55aFzHYYai0ZR3eapEqQzt9KVcg8+bGDSmTmc6CzhpmFVfdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzHYYai0ZR3eapEqQzt9KVcg8+bGDSmTmc6CzhpmFVfdw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 12:42:27PM -0700, Linus Torvalds wrote:
> On Wed, Aug 15, 2018 at 12:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Also seen in mainline. Meaning my non-SMP test builds are broken. Hmm.
> 
> Grr. I think it's due mainly due to commit 447ae3166702 ("x86: Don't

Yes. It was a side effect of adding many more boot tests. Now fixed.
Too late of course.

> include linux/irq.h from asm/hardirq.h"), which exposes a number of
> files that had some dodgy include file dependenencies, and just
> randomly happened to get it right because of that odd include that
> caused problems.
> 
> That commit itself is definitely the right thing to do, but yes, we
> clearly had a lot of cases of things getting core header files
> included purely by luck.
> 
> And because this was all done under embargo, we didn't get the kind of
> test robot coverage we usually get.
> 
> Part of it can also be due to subtle merge issues - even if the
> original branch got good coverage, later changes sometimes ended up
> adding things like that.
> 
> For example, my merge of the L1TF code found that in the meantime,
> arch/x86/kernel/kvmclock.c had added a call to kzalloc(), which used
> to work just fine, but with the header cleanup it turned out that
> kvmclock.c had never included <linux/slab.h>, so now it didn't build
> right.
> 
> And that was just the one I noticed because of my limited build tests.
> 
> And yes, every single developer has CONFIG_SMP in their config, but
> perhaps equally importantly, I suspect CONFIG_SMP ends up getting more
> header files included almost by mistake, so it can _continue_ to hide
> these kinds of incomplete header file includes that just happen to
> work.
> 
> > Anyway, care to send a proper patch ? I am sure Linus will be more
> > than happy to apply it.
> 
> I think "happy" is too strong a word for my state of mind with all
> this, but yes, I'll apply it, and you'll get the glory of fixing some
> configuration that clearly didn't get properly tested.
> 

I went ahead and submitted a patch, with proper attribution. Let me know
if you didn't get it.

> In the meantime, maybe I should just do a "make allmodconfig" and then
> disable SMP and see if that shows anything for me.
> 

I did that and didn't find any other errors.

Guenter
