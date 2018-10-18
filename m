Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8FFC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EED20866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OJKJM4mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EED20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeJSGWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:22:03 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46628 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeJSGWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:22:03 -0400
Received: by mail-yb1-f194.google.com with SMTP id o8-v6so12502514ybk.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WL+65fHZJMhjomCygOdPCa7sNrNqtEDXQqB61H0jtXc=;
        b=OJKJM4muBxy4LdFBXnLsC6gbeZgm3Qo2s1nlB0wVFejXTLohN2hHRxJNU7Umia4eNo
         5uAVzVbFTPtHaA3cF6GdvSnRy7rXXGd4KmS0XKi0U1Ykc48cqf2qShFS5KGsL+muW3SK
         guQEZy2rNy0uQmyawT36s6JDlD9hRXNf0MrUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WL+65fHZJMhjomCygOdPCa7sNrNqtEDXQqB61H0jtXc=;
        b=FLTjlKOkEmCSbJYwm/IDh5Wby9Dl5k0+9x1rkPk5BHqThJAUD7Z8IwtC3PF2ER3iwr
         3XkirO4Ij0z9ztrQBIJB51fM9AripWbedjcreRgfkuOAXMApY7pA5UcTlkhQ0BQ7ciXU
         5L32ijVGNrEabLkGr4h+SfAQI7PZ+d20W2fODUiRmSYpIYYKuqbdTYsOGyXihrfR+LG3
         RAuxvPi8Mifi0aAKJJ2hIKy/fsikTJa9BAmKWieKepCU87pOCxNjmEMhzxtX4ISCT2EZ
         QCp3wvm+0QBeRaIF/zKFHt7TNtCfpPonc+6DJXpU3Q8sUsvVGgbyzZtLvmCscP+/pr9k
         obtg==
X-Gm-Message-State: ABuFfoiMDHTIfo1DIexfd/Q6r/0zcWCAJO6VE76eoplzbfDMCU6N9hUl
        r6AjuF4skhJV/4Zs+B9vyMJJhnqPWCo=
X-Google-Smtp-Source: ACcGV604GHEYoBWT1TS0FV6xqt0p0h++rtnIk7/+NfrVThYAu2r4n8H7ee5aLHNu5XLWH3Mdn/TIcw==
X-Received: by 2002:a25:1643:: with SMTP id 64-v6mr19841861ybw.189.1539901137676;
        Thu, 18 Oct 2018 15:18:57 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1375172ywj.81.2018.10.18.15.18.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 15:18:56 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id j75-v6so12449435ywj.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:18:55 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr21386638ywf.237.1539901135329;
 Thu, 18 Oct 2018 15:18:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 15:18:54
 -0700 (PDT)
In-Reply-To: <CAPcyv4jzic5zd1AJci439zWzJ0-nP_vf3k7Xzkm7AGvvge8SEA@mail.gmail.com>
References: <20181018002924.GA42803@beast> <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
 <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
 <CAPcyv4gO2zN-ixVE1eLpe4RT1Vkkyp_C+LbGnNVT+gnJG=h3KQ@mail.gmail.com>
 <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com> <CAPcyv4jzic5zd1AJci439zWzJ0-nP_vf3k7Xzkm7AGvvge8SEA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Oct 2018 15:18:54 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+Ne7cJBWp0Tzp++c+iOTgT5SeZCE0wVOR1xcmaQJDKiw@mail.gmail.com>
Message-ID: <CAGXu5j+Ne7cJBWp0Tzp++c+iOTgT5SeZCE0wVOR1xcmaQJDKiw@mail.gmail.com>
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

On Thu, Oct 18, 2018 at 2:35 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Thu, Oct 18, 2018 at 1:31 PM Kees Cook <keescook@chromium.org> wrote:
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
>>
>> ramoops will auto-configure itself and fill available space using its
>> default parameters, but it might be nice to have a way to store that
>> somewhere (traditionally it's part of device tree or platform data).
>> ramoops could grow a "header", but normally the regions are very small
>> so I've avoided that.
>>
>> I'm not sure I understand the right way to glue ramoops_probe() to the
>> "seed-device" stuff. (It needs to be probed VERY early to catch early
>> crashes -- ramoops uses postcore_initcall() normally.)
>
> Irk, yeah, that's early. On some configurations we can't delineate
> namespaces until after ACPI has come up. Ideally the address range
> would be reserved and communicated in the memory-map from the BIOS.

Yeah, I'm wondering if I should introduce a mode for ramoops where it
walks the memory regions looking for persistent ram areas, and uses
the first available. Something like "ramoops.mem_address=first
ramoops.mem_size=NNN"

> I cringe at users picking addresses because someone is going to enable
> ramoops on top of their persistent memory namespace and wonder why
> their filesystem got clobbered. Should attempts to specify an explicit
> ramoops range that intersects EfiPersistentMemory fail by default? The
> memmap=ss!nn parameter has burned us many times with users picking the
> wrong address, so I'd be inclined to hide this ramoops sharp edge from
> them.

Yeah, this is what I'm trying to solve. I'd like ramoops to find the
address itself, but it has to do it really early, so if I can't have
nvdimm handle it directly, will having regions already allocated with
request_mem_region() "get along" with the rest of nvdimm?

-Kees

-- 
Kees Cook
Pixel Security
