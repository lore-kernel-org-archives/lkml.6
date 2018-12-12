Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F200C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C097C20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjbpO9G3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C097C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeLLFXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:23:14 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:44493 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeLLFXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:23:14 -0500
Received: by mail-pf1-f180.google.com with SMTP id u6so8285858pfh.11;
        Tue, 11 Dec 2018 21:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NdhHtunc0mPDPS1AqI1t2fu4Kvz8ngB/Bdb79qDrQIw=;
        b=IjbpO9G3zrIPda/GOlGIjBiOP2k2sqg/bHNom7kjNIn2qklTOF2yET73/QJ/o/euRe
         Y6mksp6z01GIt/Q9bWU2aQKFV9ouhm7xOmP+5cVZky9HS5RILEKIN4LzEecqy9wzLp/c
         vxichjB1uAkdXYUBzBgNanSQ0GJgUd3jX1x0BKeCBCl4PPQffvzhrr2FEiT1V+hAD5JY
         kTFjuAlCTIa0mxdbesY9Y8xITlrzW7a34WPUChMvFcgvYWM1kHKwkH1y6n27hPlXqzy4
         XhgsOsT6czLj0hNgxm0xvpVANfJtT7PELh3PTqkUjFlrGN5FlES1MYDBqu3fy1UpomdP
         MfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NdhHtunc0mPDPS1AqI1t2fu4Kvz8ngB/Bdb79qDrQIw=;
        b=Aweio5nqEOOS7X5GbMNOyd3CyRBLD7bmUb2xzTrdcmqa97dAyH+SESBUwylEU9M/Z1
         toI6NdzgVcx3aZe55dKvVpgLTjECd3WY/4oJU+iWMrUAjrfYc0EEBRh4GbadfzEZ6+/q
         RuELq0tOb+UMUnxHseXNeuSmyqbg0TRQ+iXh33LSU/YG8RMGUnXpPeR4MSGZ6fiWjXaN
         CpxBisGql9F21z/SAoRiI9Z8G+Aqihnfah8wvu5ymCZRUJazUHmtGhfJ56w5aFbfEZ+i
         kTBrir3nGNdo/Q+VktHMJdkM1YbvC70VAcC8s/YnC//ksu1ydjqJJ/Mt0oPUqDZh4Ga6
         o12A==
X-Gm-Message-State: AA+aEWay91Z9AsjFLhCDbzdAcH95VkIkhukMNvyvQm7Nwctoe17hlIro
        /omYfZ92wkT1hkGMB2hwinE=
X-Google-Smtp-Source: AFSGD/W/FbqDGCXb1TkRphFG5sV08y+6psDRJIyqv4baYLirQW/BoLCq7XWRTQD+jgSLIEjOJShocg==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr19287285pfn.125.1544592193057;
        Tue, 11 Dec 2018 21:23:13 -0800 (PST)
Received: from localhost ([211.246.69.141])
        by smtp.gmail.com with ESMTPSA id j21sm13975318pfn.175.2018.12.11.21.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 21:23:11 -0800 (PST)
Date:   Wed, 12 Dec 2018 14:23:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Wang <wonderfly@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv3] panic: avoid deadlocks in re-entrant console drivers
Message-ID: <20181212052308.GG431@jagdpanzerIV>
References: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
 <20181031122736.epbxu424l3xagge5@pathway.suse.cz>
 <20181101014821.GB502@jagdpanzerIV>
 <20181101080808.n73lrlnjd65nk4qf@pathway.suse.cz>
 <20181122131202.nkcurdt5k6jrhowa@pathway.suse.cz>
 <CAJmjG2-_8T6uJP54-+gUG7Aq7kNqkAKAEXbzzV9JVKyZFRh4GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmjG2-_8T6uJP54-+gUG7Aq7kNqkAKAEXbzzV9JVKyZFRh4GQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/11/18 16:53), Daniel Wang wrote:
> Is it okay to tag this commit with `Cc: stable@vger.kernel.org` so
> that it'll get applied to the stable trees once merged into Linux's
> tree, if it's not too late? Otherwise I'll follow up on the stable
> merges separately. Thanks for making the changes anyway.

My bad! I should have Cc-ed stable on that one, sorry. I guess now it
would be easier to wait and follow up once it gets merged.

	-ss
