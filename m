Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F93C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222BF208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2UXnsvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222BF208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936335AbeFORP0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:15:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35668 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936136AbeFORPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:15:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id j15-v6so5143760wme.0;
        Fri, 15 Jun 2018 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fwpHOSlnP3CPR3MbRzez0NLz9c5gJGMoiJTW97Az1R8=;
        b=i2UXnsvBy8FPMDUQtcj7P3DFJcVScrcwCoeCjFgSdRizzjlf8zCqwqrewN58XWdGgc
         NPTVRGKbNPwSQIcRH/PDq/6WSqt8ZaAmwZvz3NEKNeoLYgJl2stkaKDXjcs5NOsW40fQ
         pqfFtVnayF96wp7/eOWwhaQLDmeu4JqcTN45M0yFKJPYIkbfZPxve7c7GMb4wySK0+1L
         lW+Ywch0F+xY+u09C8qviVXu0wm4ETbv1D+bx5x+As1HupwfllImBlorv4qNzuDUi3sY
         ISHIggUEBP7gnaHyVCKAVVkdQXPoqWfl2hIzHG1e5k1kJKOQ8oPcTWjEdNSz4MjuhQ4+
         2V7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fwpHOSlnP3CPR3MbRzez0NLz9c5gJGMoiJTW97Az1R8=;
        b=CqhJJu9uaa1aGUURusNTTqRF8KmW5mGAEDc4D/wUrbDKXtwV1LKxJuT8tfgjrqrUiU
         fsoesnhmanuBv/J1wpXWklEvJzPxSbxEmWJrtqU87h5+sPxmVl3zcOrayZ5sFfOz1XfY
         B1t6/+5f1Rqo2qygAP7xPO8xRAD3UyfDYRiYcxyrajd2mpwp8gJnJj8uh/IIuu1oOjKH
         KRergiC1ab6jkH1i88BBJdTKyLcus0jlnuh6E7PFtN85VqvDqvp8EBoGWX6pkbQ8lvjj
         i0I0HOpQHlnMr8Sj/tIjjE+B4AEq6C262aoAQzJ5A16+tG2WuQpYAOmFtCoSS37AC/N+
         0BXg==
X-Gm-Message-State: APt69E0bWoHU2vY5X/2XDVWaejbeSr2dlk3nLRIVlrgjekFOls1kV75T
        8plr4tuEyFLP37ucPG3nmUvd
X-Google-Smtp-Source: ADUXVKJ8wml+mWZ8hROjmuEfjgEB1U5yQWKzy4DY5+TAthEDREw0sxcHKVL/RhdJ6OM9veGYyAsRIQ==
X-Received: by 2002:a1c:ec84:: with SMTP id h4-v6mr1952080wmi.154.1529082923662;
        Fri, 15 Jun 2018 10:15:23 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id i6-v6sm8589141wrr.2.2018.06.15.10.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 10:15:23 -0700 (PDT)
Date:   Fri, 15 Jun 2018 20:15:21 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: Make inline name size calculation automatic
Message-ID: <20180615171521.GA4417@avx2>
References: <20180614200956.GB7137@avx2>
 <15003.1529008242@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15003.1529008242@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 09:30:42PM +0100, David Howells wrote:
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > > Require a minimum inline name size of 33+1 to allow for names that look
> > > like two hex numbers with a dash between.
> > 
> > Why 34? /proc will fallback to separate allocation for name anyway.
> 
> See above comment.  I ran find on /proc and there were a bunch of files whose
> names were "<hex>-<hex>".  Allow for 16-char hex addresses and add a NUL char
> to that and you get 34.

Those must be /proc/*/map_files symlinks. If that's the case,
they don't have PDEs allocated.
