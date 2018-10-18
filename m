Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC5BC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFCF21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SxMkuQhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFCF21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeJSHBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:01:31 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45168 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeJSHBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:01:31 -0400
Received: by mail-yb1-f193.google.com with SMTP id d9-v6so12527661ybr.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WWHnXqPKIP17PqxcSJBOeGJuXsbwfnen//+n7CQoS00=;
        b=SxMkuQhT4Z6qdZHgNfhenFfaAEVccpilYe6SL/ABSFGrPsLiOlXB8iX/iQrAJdWq8g
         lnZRA5on9WDNpOFtWh/lFH+UAKx81rStglJsITNSZJnAeh2WyTZzGJ3SpRsHawy5M61Q
         QyvwSwiA0jcO7HmgueI28hEfRo/XHZgYfD/OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WWHnXqPKIP17PqxcSJBOeGJuXsbwfnen//+n7CQoS00=;
        b=DSk5pzicVq1bsWDpgIAwxavpQWi7fd7dmDJx3LYBVZJH247slkmXVAo6JxkHzBPFqN
         tM0JE/6Vv2FD7QHd9M1aITxhKby/3y4ZwlVVhjZplPMIO39Iemujn27tEg4BjYtefIYf
         DYifvhQs7poFQH9gmOwCmRoch62DFjXoW9lKV+BiXQYNwzqCOsqnW5TSzH/90tpBlZdv
         iHXXV+qbkmhq9KpfxfMAAHyM0byRM6UvA5Fe313LcqI3B/w2thwS4l+HXbKH1uqZXlZK
         kpvewJDLZRCaHuwlbLk8wvoQnevqoUDiL46C4S6Ti8l4LPzHcNty1wkN7nwUNtTjHubD
         im0Q==
X-Gm-Message-State: ABuFfoisOHugf2ze8l0DO4q2dDXBCerY9Z9QN9zbvjJSzwTpYzIySeAP
        EoNsLnXmNL7iRsq6tG0Xg4VJO/8MCLs=
X-Google-Smtp-Source: ACcGV60Bp6VZATc+fpg0isnW5Ky2KJO5GwYgFm7+GMEa+4EqquF4vigMqEpIFndmOvVNryddJAI6UQ==
X-Received: by 2002:a25:b103:: with SMTP id g3-v6mr7451172ybj.191.1539903498282;
        Thu, 18 Oct 2018 15:58:18 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id w201-v6sm5821342ywa.79.2018.10.18.15.58.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 15:58:16 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id j75-v6so12481200ywj.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:58:16 -0700 (PDT)
X-Received: by 2002:a81:9b83:: with SMTP id s125-v6mr20292435ywg.47.1539903496000;
 Thu, 18 Oct 2018 15:58:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 15:58:15
 -0700 (PDT)
In-Reply-To: <CAPcyv4jYiEregTvHV83ogc19vWSd56T-OgwePxKD9n4ym-gr+A@mail.gmail.com>
References: <20181018002924.GA42803@beast> <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
 <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
 <CAPcyv4gO2zN-ixVE1eLpe4RT1Vkkyp_C+LbGnNVT+gnJG=h3KQ@mail.gmail.com>
 <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com>
 <CAPcyv4jzic5zd1AJci439zWzJ0-nP_vf3k7Xzkm7AGvvge8SEA@mail.gmail.com>
 <CAGXu5j+Ne7cJBWp0Tzp++c+iOTgT5SeZCE0wVOR1xcmaQJDKiw@mail.gmail.com>
 <CAPcyv4hyZFRog8EBvhnO0bz3ryVNX=udupgnFUSZDgUBN23YWg@mail.gmail.com>
 <CAGXu5j+q4_+vQx8fcJgGUzne0PH33isZofkQ3YR6eL2kUO=Njg@mail.gmail.com> <CAPcyv4jYiEregTvHV83ogc19vWSd56T-OgwePxKD9n4ym-gr+A@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Oct 2018 15:58:15 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLtmb3qinZnX3rScUJLUFdf+pRDVPjy=CS4KUtW9tLHtw@mail.gmail.com>
Message-ID: <CAGXu5jLtmb3qinZnX3rScUJLUFdf+pRDVPjy=CS4KUtW9tLHtw@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Clarify resource reservation labels
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 3:33 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Thu, Oct 18, 2018 at 3:26 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Thu, Oct 18, 2018 at 3:23 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> > On Thu, Oct 18, 2018 at 3:19 PM Kees Cook <keescook@chromium.org> wrote:
>> >>
>> >> On Thu, Oct 18, 2018 at 2:35 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> >> > On Thu, Oct 18, 2018 at 1:31 PM Kees Cook <keescook@chromium.org> wrote:
>> > [..]
>> >> > I cringe at users picking addresses because someone is going to enable
>> >> > ramoops on top of their persistent memory namespace and wonder why
>> >> > their filesystem got clobbered. Should attempts to specify an explicit
>> >> > ramoops range that intersects EfiPersistentMemory fail by default? The
>> >> > memmap=ss!nn parameter has burned us many times with users picking the
>> >> > wrong address, so I'd be inclined to hide this ramoops sharp edge from
>> >> > them.
>> >>
>> >> Yeah, this is what I'm trying to solve. I'd like ramoops to find the
>> >> address itself, but it has to do it really early, so if I can't have
>> >> nvdimm handle it directly, will having regions already allocated with
>> >> request_mem_region() "get along" with the rest of nvdimm?
>> >
>> > If the filesystem existed on the namespace before the user specified
>> > the ramoops command line then ramoops will clobber the filesystem and
>> > the user will only find out when mount later fails. All the kernel
>> > will say is:
>> >
>> >     dev_warn(dev, "could not reserve region %pR\n", res);
>> >
>> > ...from the pmem driver, and then the only way to figure who the
>> > conflict is with is to look at /proc/iomem, but the damage is already
>> > likely done by that point.
>>
>> Yeah, bleh. Okay, well, let's just skip this for now, since ramoops
>> doesn't do _anything_ with pmem now. No need to go crazy right from
>> the start. Instead, let's make it work "normally", and if someone
>> needs it for very early boot, they can manually enter the mem_address.
>>
>> How should I attach a ramoops_probe() call to pmem?
>
> To me this looks like it would be a nvdimm glue driver whose entire
> job is to attach to the namespace, fill out some
> ramoops_platform_data, and then register a "ramoops" platform_device
> for the ramoops driver to find.

That sounds right, yes. I'm happy to help review/test/etc.

-Kees

-- 
Kees Cook
Pixel Security
