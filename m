Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00460C64EBC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2E20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7cJEhwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF2E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJEJNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 05:13:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34103 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeJEJNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 05:13:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12-v6so11285351otl.1;
        Thu, 04 Oct 2018 19:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yp45rWFEnMDh40D433CB4RpMppqb125ALS7H//aP1BU=;
        b=b7cJEhwV3BrFmxynly+U2KSpgQ/ktE0XDPgiHgdRwie/hyKB6DvuxWdpO0AVM8m/Ed
         6OYh5cr08BXpyXAOBrziClPAXw+hxj9I6spSycvauKQhVdwRyOV8x1+aHcN80WD2G2hL
         ROWw9GS+mV4Ob/P6URyjS0MPxeW1pEmSDuKBDux9O1Sz6M5vFMOu9LeTdro+KJ9iPuq/
         uUrO18FDXoPs2QTXU9bvon8+ZBBavu9+T+jHCE+q/oC3lCFEVNz5LbW27WJsynblnHUA
         41tmy5oY7DtBKVVt0vJgxcE0iWGLcQzpU/GGmzmsp3Bb1ml2hidb/Rf4v+ZeScPua+uC
         7rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yp45rWFEnMDh40D433CB4RpMppqb125ALS7H//aP1BU=;
        b=sdDsYU8zQlS4lxxeXWbFQK/aM8Dh7Ct9J5Gi64kQCWuZjcc9a9AMvqAn0PmCBNImhb
         lgfWxB/sTe+jlhlZaGduCfhgp2bgBPP2HaLrmjOFg7fUIW4ZTbDJye0bEMve6kQG3FEp
         ugGS0Luw6B9+mCczFOG6AzKSSlFP1TswT79oZ0dHTpbyAWPhZniMEf6vyJycVW4gcBFv
         JoawCzVx1Xce+DmtW4YGLtHaT7Ktrpn/EpWnrUdukoBYvcnO6UDoeiDyogmt4Z24yDv4
         VBFxFel0Ao/DH3O0yB7UYOvB1tHViAr4mGzNkLLGiBHS25TKTZWQEUMArWXCxMxoGFxz
         Hiag==
X-Gm-Message-State: ABuFfojrNdxiLKJaPlupYokZxS95fAGEJhL7sAOxyMEprGngr9w6/yWl
        XPruQ43iaE2uNO9AbLSjUkDOrkLlfFan6hjBbK0=
X-Google-Smtp-Source: ACcGV632KL6vmCzEYHRnXAbfDL0jw3PMNgDTBUq4Hwu4x5C2AU4B45kLMWBo7feUtoouFsoWjVT50Zm7ddOdOn0eJFs=
X-Received: by 2002:a9d:63d6:: with SMTP id e22-v6mr5516801otl.233.1538705796196;
 Thu, 04 Oct 2018 19:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180928020816.11251-1-leobras.c@gmail.com> <20180928020816.11251-4-leobras.c@gmail.com>
 <1538118915.3593.4.camel@HansenPartnership.com> <CADvQ+rGQenkoE0xCRTwjA5BuKZbZ2Upkyx=+qWFUGnUcit-aCQ@mail.gmail.com>
 <1538628062.18776.5.camel@HansenPartnership.com>
In-Reply-To: <1538628062.18776.5.camel@HansenPartnership.com>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Thu, 4 Oct 2018 23:16:24 -0300
Message-ID: <CADvQ+rG0WQjFTU=A4tAACvqFevw51DX_-yq2-9j78T8pSrjcXQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Well it's not really that persuasive.  Most people simply let the build
> run to completion, but if you have a problem with a job control 3h
> timelimit, then create a job that kills itself at 2:59 and then
> resubmits itself.  That will produce a complete build in 3h chunks
> without any need to call sub Makefiles.
>

Humm, I probably should have explained better how GitlabCI works.
It works creating a docker container that have a limited lifespan of 3h max.
After that the time is over, this container ceases to exist, leaving no build
objects, only the console log. So there is no way of 'resuming' the building
from where it stopped. I used the 'job' term because it's how they call it,
and I understand it's easily confused with bash jobs.

> All of our Makefiles are coded assuming the upper level can prevent
> descent into the lower ones.  You're proposing to change that
> assumption, requiring a fairly large patch set, which doesn't really
> seem to provide a huge benefit.
>
> James

I understand your viewpoint.
But what I propose is not to change that assumption, but instead give some
Makefiles the aditional ability to be called directly and still not build stuff
if they were not enabled in .config.

But, why these chosen Makefiles, and not all of them?
Granularity.
What I am trying to achieve with this patchset is the ability of building
smaller sets of drivers without accidentally building what is not enabled
on .config.
And, in my viewpoint, building a single drivers/DRIVERNAME is small enough to
be fast in most situations.

This change is not supposed to bother the usual way of building the kernel, and
it is not even supposed to add overhead to kernel compilation. And it would,
at least, solve my problem with the 3h limit, and enable the tool
I am building on GiltabCI to help other developers.

Thanks for reading,

Leonardo Bras
