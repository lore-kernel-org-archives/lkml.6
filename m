Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80AEC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA0020652
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7Vlwxcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA0020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeJNFYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 01:24:32 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35783 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeJNFYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 01:24:32 -0400
Received: by mail-yw1-f68.google.com with SMTP id y76-v6so6274916ywd.2;
        Sat, 13 Oct 2018 14:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pxAmPRPvhGden/RQb6IbiyK5U6v4ypXghQiByCY4v00=;
        b=R7Vlwxccdu8NP9jC6blTBbDkTqZlCjtLeyMlVON9GAXKk+8FhHk/GLLpTY6zFgC5DH
         emtQpGvwBouiWXrwxZx00eh56/ddtJs2rfVo4iArAx6/ZDEybaEXyd9lK1EkYF04mVAS
         bpTHki/nEr0kiCOwgc21cKQF3t0QXj6HtlP74LoRRat4/OHlSSED+sHAJ0FKH+F4DYOV
         411BVWsf3ogqSXPxxP+MhNg74Ibnb20oo/38KCYZEv3AdjhaOXmwmjORk2JpO+4qpOFi
         S3ahLSTu+qy6jqwKCZ74q2kVbA864q78XG5pGUGuiqtFPfJPLRQwtHm3KytGgk79JxaQ
         BAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pxAmPRPvhGden/RQb6IbiyK5U6v4ypXghQiByCY4v00=;
        b=Aku/WIl5mQFiiBDnag+WNvwGWXLAB+JJicsDbYPxaHftgN5DLY+fCQe9vWjxWtPeC+
         /mcfpFyfFmoG4wK6dhYGsXlN4hXFGL19wflzYmWAAq95L3P80o4NE8HIsHSgw1GKIROW
         TvekcCFncW4ATb6Iff4hajYxxZ1lu68isXHO8k5j9/WzRKkVXDcm+/0qi9VzPJuaXPmn
         V+d4EquWDI0rq9uLqbPi8IBXlv5RS2InP9Prb9Fai7Yul6cwLwv7esoQ/Mobsp1/3cK5
         0+tzcPvF5OTf/Mb8GKuo+3IPtUd/uR6JWSnyaJMsjHkC5kWdg6CPdQTpMU5bYfiot1Ft
         QVqA==
X-Gm-Message-State: ABuFfoh/aLMogOkQyI/d+JYIsB33hGzUVQGRSatEJB6NTkFlcN63a1LL
        +93rH0vHxtTwqYVc//XyrQ==
X-Google-Smtp-Source: ACcGV60hUlhBhimfJicHq4qCEUXumd8yRdwatIEF0jGJx76mVY53uoCW98wTFf/XlmXzEyt1WLdz/g==
X-Received: by 2002:a81:1d96:: with SMTP id d144-v6mr6219899ywd.504.1539467154659;
        Sat, 13 Oct 2018 14:45:54 -0700 (PDT)
Received: from gabell (c-98-229-178-29.hsd1.ma.comcast.net. [98.229.178.29])
        by smtp.gmail.com with ESMTPSA id 138-v6sm1425676ywj.11.2018.10.13.14.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 14:45:54 -0700 (PDT)
Date:   Sat, 13 Oct 2018 17:45:51 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>, Baoquan He <bhe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181013214550.ag5qzokhkrkwnzsy@gabell>
References: <20181010085920.GB5533@zn.tnic>
 <20181010090620.GF25297@MiWiFi-R3L-srv>
 <alpine.DEB.2.21.1810101113070.10278@nanos.tec.linutronix.de>
 <20181010091923.GC5533@zn.tnic>
 <20181010093057.GA22088@MiWiFi-R3L-srv>
 <20181010194443.sgdvplwdnltshwwi@gabell>
 <20181011002955.GJ25297@MiWiFi-R3L-srv>
 <20181011055154.GB6667@localhost.localdomain>
 <20181013201958.zfzv5ahhe3xz7bwi@gabell>
 <20181013203429.GE31650@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013203429.GE31650@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 10:34:29PM +0200, Borislav Petkov wrote:
> On Sat, Oct 13, 2018 at 04:19:59PM -0400, Masayoshi Mizuma wrote:
> > Baoquan and Chao, thank you for your comments!
> > 
> > Boris, the patches has been merged to linux-next.
> 
> First of all, please do not top-post.
> 
> Even if they're in linux-next, that doesn't mean they should go upstream
> while there are still issues to be hammered out.

Got it, thanks.

> 
> In this particular case, if Chao Fan's patchset shapes up in a decent
> form to be upstreamed, we don't need the cmdline parameter anymore, do
> we?
> 
> Because we'll have the SRAT parsing and proper KASLR limits ready and
> working automatically, I'd say.

Yes, but I think we need to arrange the Chao's SRAT parsing to be used
from kernel_randomize_memory() because Chao's approach needs the SRAT
parsing before extract kernel and the padding size calculation needs
the parsing in start_kernel(), so they are living in different life
cycle and space.

Thanks,
Masa
