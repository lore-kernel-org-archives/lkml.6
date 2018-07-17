Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EB9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71916206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V+DycCNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71916206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbeGQU6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:58:33 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40608 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbeGQU6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:58:33 -0400
Received: by mail-lf0-f68.google.com with SMTP id y200-v6so1784841lfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JM9XbvE+zDLC+PJHHQcAAA4nSmIKUx3AIK/gbccPAdY=;
        b=V+DycCNE9pS+AVZe36Gh8G22wciyXFdQdCp20Z5D3kybMsvEdExbG1iiKX1bV5KI4y
         T25hRFZS3BzY9uWN9Ola+KFxlPVC8rgXN1Bxb9haECFruE1BaFFsxwwYW5cD5c0jjX3k
         Uw9FRbw8JXr1hdOJRqntxoA2GX1TBz6RUwVSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JM9XbvE+zDLC+PJHHQcAAA4nSmIKUx3AIK/gbccPAdY=;
        b=UnPo0gHle/4LhiX67VzvFoFVQ8Qg6ublzr/DH/TpoP1rfjCNlZm0MiSjMHuxO+SMpW
         ypb0xGiTgn/HDCyTez27Gv8nxa5LPITdjmlD6Z3PTs/paZFEGv5RE8wg6GV2KA79ck7H
         sJ3qibH9bLqQaDKPos9LdyTo/4EGa0+UyGoV/5NXdLy69dwqYElWBCil7iM5Y6IgpvMM
         RpxUw64E+gEQVt16zUec95hGU7w8DyY5vVBo3yz/ETBxpi9ehPMsZKHzWt26FSrrzL86
         BU3zF93KtsNudM9+p8dyQmVCBiHPXV4h100p7roIRmNWrrCZGXwt4e+jw5oaWAkEfvU0
         Q15g==
X-Gm-Message-State: AOUpUlElDCWnSMvUOgs8SHYLE3bFTeX53UrNo3BEivmsw2E8QvyaPCC9
        AoVHVo3KpzMT26d1QgjNkoOsS84sKDk=
X-Google-Smtp-Source: AAOMgpcTcw5Ce/KAVg6Z++r5hlPTWTBAupSdkH8p10ihLf8fG+C3fIWNuViEZ685rqjWt0M53EbgRA==
X-Received: by 2002:a19:f70d:: with SMTP id z13-v6mr2085063lfe.33.1531859053647;
        Tue, 17 Jul 2018 13:24:13 -0700 (PDT)
Received: from mail-lf0-f53.google.com (mail-lf0-f53.google.com. [209.85.215.53])
        by smtp.gmail.com with ESMTPSA id n17-v6sm294199ljb.82.2018.07.17.13.24.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 13:24:12 -0700 (PDT)
Received: by mail-lf0-f53.google.com with SMTP id j8-v6so1787181lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:24:12 -0700 (PDT)
X-Received: by 2002:a19:10c4:: with SMTP id 65-v6mr2258198lfq.113.1531859052137;
 Tue, 17 Jul 2018 13:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
 <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
 <CAE=gft5U1-Jo-GvTF7sNAV3Q565AmuUrHpmBdxUL+UwkKxesqA@mail.gmail.com>
 <0dce9e9c-4f93-9857-72ee-f65ff195c41a@codeaurora.org> <CAE=gft6_=SQjgv7_kHXKJKa8_45NKKFwwE7UaXsijPpMd35LOg@mail.gmail.com>
 <4cb931e199599314829f5ff750797c88fc123f1f.camel@wdc.com>
In-Reply-To: <4cb931e199599314829f5ff750797c88fc123f1f.camel@wdc.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 17 Jul 2018 13:23:35 -0700
X-Gmail-Original-Message-ID: <CAE=gft6zm2mw3rnNuktDe0NWs-NM1CFQw1BUeGhaBi3eoEDXBg@mail.gmail.com>
Message-ID: <CAE=gft6zm2mw3rnNuktDe0NWs-NM1CFQw1BUeGhaBi3eoEDXBg@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs provisioning
To:     Bart.VanAssche@wdc.com
Cc:     sayalil@codeaurora.org, Vinayak Holikatti <vinholikatti@gmail.com>,
        linux-kernel@vger.kernel.org, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, cang@codeaurora.org,
        martin.petersen@oracle.com, subhashj@codeaurora.org,
        linux-scsi@vger.kernel.org, vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, jejb@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 5:04 PM Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
>
> On Mon, 2018-07-16 at 16:46 -0700, Evan Green wrote:
> > I see Bart has chimed in on the next series with a suggestion to break
> > out each field into individual files within configfs. Bart, what are
> > your feelings about converting to a binary attribute? I remember when
> > I did my sysfs equivalent of this patch, somebody chimed in indicating
> > a "commit" file might be needed so that the new configuration could be
> > written in one fell swoop. One advantage of the binary attribute is
> > that it writes the configuration atomically.
>
> Hello Evan,
>
> I may be missing some UFS background information. But since a configfs interface
> is being added I think the same rule applies as to all Linux kernel user space
> interfaces, namely that it should be backwards compatible. Additionally, if
> anyone ever will want to use this interface from a shell script, I think that
> it will be much easier to write multiple ASCII attributes than a single binary
> attribute.
>

Hi Bart,
I'm unsure about the compatibility aspect for binary attributes that
essentially represent direct windows into hardware. I suppose this
comes down to who this interface is most useful to. Hypothetically
lets say a future revision of UFS adds fields to the configuration
descriptor, but is otherwise backwards compatible. If this interface
is primarily for OEMs initializing their devices in the factory, then
I'd argue they'd want the most direct window to the configuration
descriptor. These folks probably just have a configuration they want
to plunk into the hardware, and would prefer being able to write all
fields over having some sort of compatibility restriction. If, on the
other hand, this is used by long-running scripts that stick around for
years without modification, then yes, it seems like it would be more
important to stay compatible, and have smarts in the kernel to make
writes of old descriptors work in new devices.

At least for myself, I fall into the category of someone who just
needs to plunk a configuration descriptor in once, and would prefer
not to have to submit kernel changes if the descriptor evolves
slightly. It also seemed a little odd that this patch now spends a
bunch of energy converting ASCII into bytes, just to write it without
modification into the hardware, and convert back again to ASCII for
reads.

We plan to use a script for provisioning, and could easily handle
ASCII or rawbytes:

# Some bytes, ready to go with the interface today...
some_bytes="00 01 02 03"

# Same bytes, now in binary format
bytes_fmt=$(echo " $some_bytes" | sed 's/ /\\x/g')
/usr/bin/printf "$bytes_fmt" > /configfs/ufs_provision

I'm not dead set on binary, since as above I could do it either way,
but it seemed worth at least talking through. Let me know what you
think.
-Evan
