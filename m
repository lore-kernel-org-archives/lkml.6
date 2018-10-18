Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C55FC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098442098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HjQDU+eR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098442098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeJSFXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:23:02 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38496 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbeJSFXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:23:02 -0400
Received: by mail-yw1-f68.google.com with SMTP id d126-v6so12402699ywa.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aI630o9CByu/dJalTsSfpLA6AOVKwKyst10c93P4n8w=;
        b=HjQDU+eRhztt5y9Z5sZfMVkVEGn+VTQjPDN1pV7qKxGtKwMeFp55Lva0Sjf+Ehg3ps
         H/szF8hdUXD1xvXdiwjPBQCkoxgTq/LVzGE/KQI3puYHdBCRbvWjImImWNAjWV/YyAr5
         tgHYf52x5tHnxGYuQvyYO6bS9UskuL+eX07LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aI630o9CByu/dJalTsSfpLA6AOVKwKyst10c93P4n8w=;
        b=WO8/qyaJssZus5Ia99VRE7nY5QsccoeJfDj4cpflA9Fa1FtdNplc8z9FXzPJhJIOba
         UEVoKI+vy1/damqEnJaNyUpgcbwnPSeKkIiBO0Mejj0jScB88eVGeB4QSVZnNYroU9mr
         Cc4cE2CgCkF8WBe62PU/IhnFoIJ6JPUZ73pCb7eGW5GgZEoft3hhIfjMYADBt/NdQc1S
         KA0XOJIh4jk+odq2Hbn1GsEngBcajScJQ3qV86Ux82QtVeU7VEX4hdhX+IpKPgt/lVCl
         XJeaDCFmM79nbQN9vMO73cFOa2epy1plWCgJvNKqS81VErpg/S9WnTH5UD4xRvRbYzbJ
         AzAw==
X-Gm-Message-State: ABuFfoi13VrxnDqt/F7y7no0YwiGSv1XCoFcKzLhuoeW+zr5xqpcDuIa
        FtgZ2I4oEIpvH6kUEuOVFSsR12aPA3A=
X-Google-Smtp-Source: ACcGV63SgdXhOIddT5Egi0UX7+VwI0VR37XEuKmoa7mKJOC9DKToczBXLCapzcU2ywiHK+dlSz3PpQ==
X-Received: by 2002:a0d:ca44:: with SMTP id m65-v6mr1217399ywd.105.1539897607290;
        Thu, 18 Oct 2018 14:20:07 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id y206-v6sm5476619ywg.57.2018.10.18.14.20.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 14:20:05 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id p74-v6so12439545ybc.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:20:05 -0700 (PDT)
X-Received: by 2002:a25:23cd:: with SMTP id j196-v6mr7654730ybj.137.1539897604872;
 Thu, 18 Oct 2018 14:20:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 14:20:04
 -0700 (PDT)
In-Reply-To: <CAGRrVHzd86TYe8sE0S88HObDOXKNAfsX9T=GCo0gkTr2n1wDQw@mail.gmail.com>
References: <20181018002924.GA42803@beast> <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
 <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
 <CAPcyv4gO2zN-ixVE1eLpe4RT1Vkkyp_C+LbGnNVT+gnJG=h3KQ@mail.gmail.com>
 <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com> <CAGRrVHzd86TYe8sE0S88HObDOXKNAfsX9T=GCo0gkTr2n1wDQw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Oct 2018 14:20:04 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ9Eq1vJEV4wooSpA3y6m5zCOZvq2yp+Q51LCnJ_1M=9g@mail.gmail.com>
Message-ID: <CAGXu5jJ9Eq1vJEV4wooSpA3y6m5zCOZvq2yp+Q51LCnJ_1M=9g@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Clarify resource reservation labels
To:     Ross Zwisler <zwisler@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 1:58 PM, Ross Zwisler <zwisler@google.com> wrote:
> On Thu, Oct 18, 2018 at 2:31 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Thu, Oct 18, 2018 at 8:33 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>> > [ add Ross ]
>>
>> Hi Ross! :)
>>
>> > On Thu, Oct 18, 2018 at 12:15 AM Kees Cook <keescook@chromium.org> wrote:
>> >> As for nvdimm specifically, yes, I'd love to get pstore hooked up
>> >> correctly to nvdimm. How do the namespaces work? Right now pstore
>> >> depends one of platform driver data, device tree specification, or
>> >> manual module parameters.
>> >
>> > From the userspace side we have the ndctl utility to wrap
>> > personalities on top of namespaces. So for example, I envision we
>> > would be able to do:
>> >
>> >     ndctl create-namespace --mode=pstore --size=128M
>> >
>> > ...and create a small namespace that will register with the pstore sub-system.
>> >
>> > On the kernel side this would involve registering a 'pstore_dev' child
>> > / seed device under each region device. The 'seed-device' sysfs scheme
>> > is described in our documentation [1]. The short summary is ndctl
>> > finds a seed device assigns a namespace to it and then binding that
>> > device to a driver causes it to be initialized by the kernel.
>> >
>> > [1]: https://www.kernel.org/doc/Documentation/nvdimm/nvdimm.txt
>>
>> Interesting!
>>
>> Really, this would be a way to configure "ramoops" (the persistent RAM
>> backend to pstore), rather than pstore itself (pstore is just the
>> framework). From reading the ndctl man page it sounds like there isn't
>> a way to store configuration information beyond just size?
>
> Ramoops needs a start (mem_address), size (mem_size) and mapping type
> (mem_type), right?  I think we get the first two for free based on the
> size of the namespace, so really we'd just be looking for a way to
> switch between cacheable/noncached memory?

Start and size would be a good starting point, yes. That would let
automatic layout happen, which could be improved in the future.

mem_type just chooses ioremap() ioremap_wc() after the request_mem_region():

        if (!request_mem_region(start, size, label ?: "ramoops")) {
                pr_err("request mem region (0x%llx@0x%llx) failed\n",
                        (unsigned long long)size, (unsigned long long)start);
                return NULL;
        }

        if (memtype)
                va = ioremap(start, size);
        else
                va = ioremap_wc(start, size);

Is this feature "knowable" during probe time? Traditionally all these
details had to be stored separately, but if the nvdimm core knows the
right answer, it could just pass the correct memtype during the
ramoops probe.

> Several of the other modes (BTT and DAX) have space for additional
> metadata in their namespaces.  If we just need a single bit, though,
> maybe we can grab that out of the "flags" field of the namespace
> label.

This feels a bit like a hack? If I want something better than command
line args for ramoops sub-region sizing, I'll probably build a
"header" region starting at mem_address with a magic number, version,
etc.

Thanks for your help!

-Kees

-- 
Kees Cook
Pixel Security
