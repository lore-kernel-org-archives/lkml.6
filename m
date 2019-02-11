Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83F0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867332184A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="LR5JdxAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfBKVcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:32:54 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43961 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfBKVcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:32:53 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so336395eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V6d1YLoUREI+bC7/ZgN7EbrA9AS3ePXM4h7fJTU7/Ag=;
        b=LR5JdxAkM1ux2oT8XwGcTR12jwH3rBhGGwkRoyMK37zGBdQCwAY5blifNd/L7wXp0r
         n9iTac+tf+FJw/T6x72Mq5apabbcjkb2io7XI4UNcz/92sJm59QYDWhldmA8YioDBJB9
         xwXq2NgvwD6AwF8kYobw0vt0fnYMHqz7RM/ShxtwfhaQSLx5vqR4PodXkbjq5+4dkwjA
         /kaE2455EFAycgHJq/xO4f1BkO2hvupUepHtGZF07TUPevXxUwm/7COaR9C0O7NkZtwT
         V1dhqbw2sNeV/FMhPVNjNRLxrprdzxA7QvfQfKa24zPLDnPEtwZzXjL4UhI5i1IivXc9
         NIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V6d1YLoUREI+bC7/ZgN7EbrA9AS3ePXM4h7fJTU7/Ag=;
        b=Mf7hhN8220oRc4w2NrbUCsZ/S5YjB+s1oQf6XnSKGQ/CUdQ7IIZfSXeuOA6XjnphdX
         tvkSEeZKAYsTRJRAfIbfsLmB5YIO5yHbRhctuSKdj43+tNEamIRvanjyP/73l1KUSo7h
         TV+piJ0+1R4fPemYPKPh/Ylkwxsifc80nRVUsiSOvo1wnraSHcG7vkzA0jIULZiSkpue
         1FoZDTNJZoRAv2N1I4FmzB/XlwtUXk+nvhW/zV7TijRosVx0y89unYGgTo1qNigOa9KR
         LKeocP6TwKj+zJ5OFyBIEfowmRunVXfaEOBBDjLvcNW6k1X/n+KRB231fMCAZpXeU84E
         CiRw==
X-Gm-Message-State: AHQUAubI6SEtHh4UArLshWyDj0qaXYIa7SQ3ZkAKJqLr3JlNxfpyBPUw
        lPObO7vRlbzkgHtBpR/INemORA==
X-Google-Smtp-Source: AHgI3Iaa9RUHWVuM61yGq2/vBVsDXMFFWFDynpx2M90MaSFHH1vYN90tG/K382GQeBEdx7mpP6WMFw==
X-Received: by 2002:aa7:ce13:: with SMTP id d19mr205830edv.15.1549920771990;
        Mon, 11 Feb 2019 13:32:51 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:76e:9ed:e1af:663e:9c0b])
        by smtp.gmail.com with ESMTPSA id f1sm1689620ejl.65.2019.02.11.13.32.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Feb 2019 13:32:51 -0800 (PST)
Date:   Mon, 11 Feb 2019 22:32:50 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        longman@redhat.com, linux@dominikbrodowski.net,
        keescook@chromium.org, joe.lawrence@redhat.com,
        ebiederm@xmission.com, linux-api@vger.kernel.org
Subject: Re: + sysctl-return-einval-if-val-violates-minmax.patch added to -mm
 tree
Message-ID: <20190211213249.lta2pithpf5w6w7m@brauner.io>
References: <20190211210632.Nfd0f%akpm@linux-foundation.org>
 <20190211211716.GA31039@avx2>
 <20190211211917.kq2ahdkhoe36obhp@brauner.io>
 <20190211212523.GU11489@garbanzo.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211212523.GU11489@garbanzo.do-not-panic.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 01:25:23PM -0800, Luis Chamberlain wrote:
> On Mon, Feb 11, 2019 at 10:19:19PM +0100, Christian Brauner wrote:
> > On Tue, Feb 12, 2019 at 12:17:16AM +0300, Alexey Dobriyan wrote:
> > > On Mon, Feb 11, 2019 at 01:06:32PM -0800, akpm@linux-foundation.org wrote:
> > > 
> > > > @@ -2848,8 +2848,10 @@ static int __do_proc_doulongvec_minmax(v
> > > 
> > > > -			if ((min && val < *min) || (max && val > *max))
> > > > -				continue;
> > > > +			if ((min && val < *min) || (max && val > *max)) {
> > > > +				err = -EINVAL;
> > > 
> > > I was asked to return ERANGE in kstrto*().
> > 
> > I think we discussed ERANGE vs EINVAL and decided EINVAL because there
> > was precedence for other sysctls already.
> 
> Can you do a proper audit and see?

If you look at proc_get_long() right now you can see that when the
buffer we use to parse the number is exceeded we return EINVAL. In short
if you do right now:

echo 1844674407370955161600000 > /proc/sys/fs/file-max

that would exceed the buffer in proc_get_long() and you already get
EINVAL for all such cases. If we now change this to ERANGE we would
return:

echo 18446744073709551616      > /proc/sys/fs/file-max -> ERANGE
echo 1844674407370955161600000 > /proc/sys/fs/file-max -> EINVAL

which would be very confusing. For consistency we should use EINVAL.

See kernel/sysctl.c:

/* We don't know if the next char is whitespace thus we may accept
 * invalid integers (e.g. 1234...a) or two integers instead of one
 * (e.g. 123...1). So lets not allow such large numbers. */
if (len == TMPBUFLEN - 1)
        return -EINVAL;

Christian
