Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEC2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F5C208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T96W7VlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F5C208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934922AbeFRQyz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:54:55 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34042 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755335AbeFRQyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:54:53 -0400
Received: by mail-ot0-f196.google.com with SMTP id r18-v6so19294116otk.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 09:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2anUOYEpZ1LGm5FL89PSzd7ca8/J6D9XQGodrdoBlDM=;
        b=T96W7VlD9xOo0NJXfUKp45AjIBx7EWBUAQOJS30QADUH+umnNbM0EfLzOiIlciSuSA
         fovWZ3Ugk5HySuxPH6TVKTLCwVfgXdgWHnDyTHugcDxlNKVzhIOU5owOi9EmO9B/nxoZ
         mKQcF6ZqO5WYapLtilDTrUwn7VjP9ZSUTU3KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2anUOYEpZ1LGm5FL89PSzd7ca8/J6D9XQGodrdoBlDM=;
        b=l7I5+uDewoOm8rBXMDzjFFo2uuVcDi2zrqfQBtitW8RO9o4YC2ZIxmq/g8e31U1lwq
         L30UMbNtlSBrb8nhAiwBLNvqVcLpIeJz9uoWnnVa5xcuKaf6RHr62cBsef98+BHfvmFU
         jTxExb1KWpBzU5NEMTUWJTJoAMpUlvJOxvC+sPctQMpD5fwmb7pwtAQTJEIVS8zW3W5S
         ox3TTCKyMU+DaE/A9BNB6UKtSGRHWgzMCZfLTgn91+7OEBozOcHreI2ldig+vrmss6RS
         Xv7Doyary5PnVbjbvjlNPSYqpamWBzvNC1T8bchpj5CT6VNOBF1yAuhCwtWLOowVPzcY
         joeQ==
X-Gm-Message-State: APt69E2Zs58Y1OV9Mo8DALW6xuOL6ni9ghf2kqw+nLIdJ0IQtde0Nx0q
        c0UAmqLzbX8KYSzB6m40ljlJFOJ/vZA=
X-Google-Smtp-Source: ADUXVKKZp8E3AJzf0cmd+k/yM4Q+4sMMcbdxgrNmpnMkDCnmSo6Ma0rpaE+pcWL9a6etiqeInR0ZNw==
X-Received: by 2002:a9d:750a:: with SMTP id r10-v6mr7824698otk.29.1529340892485;
        Mon, 18 Jun 2018 09:54:52 -0700 (PDT)
Received: from mail-ot0-f174.google.com (mail-ot0-f174.google.com. [74.125.82.174])
        by smtp.gmail.com with ESMTPSA id v8-v6sm15518364oti.35.2018.06.18.09.54.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 09:54:50 -0700 (PDT)
Received: by mail-ot0-f174.google.com with SMTP id l15-v6so19272823oth.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 09:54:50 -0700 (PDT)
X-Received: by 2002:a9d:fba:: with SMTP id d55-v6mr8607742otd.53.1529340889880;
 Mon, 18 Jun 2018 09:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180615210049.126123-1-evgreen@chromium.org> <20180615210049.126123-2-evgreen@chromium.org>
 <20180616071632.GD30558@kroah.com>
In-Reply-To: <20180616071632.GD30558@kroah.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 18 Jun 2018 09:54:13 -0700
X-Gmail-Original-Message-ID: <CAE=gft7Btvacg7iYQkWfMC1Md+5Lgiz1up6QnZnypXd8VVM3-Q@mail.gmail.com>
Message-ID: <CAE=gft7Btvacg7iYQkWfMC1Md+5Lgiz1up6QnZnypXd8VVM3-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] scsi: ufs: Add Configuration Descriptor to sysfs
To:     gregkh@linuxfoundation.org
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        stanislav.nijnikov@wdc.com, Bart.VanAssche@wdc.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 12:16 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 15, 2018 at 02:00:46PM -0700, Evan Green wrote:
> > This change adds the configuration descriptor to the UFS
> > sysfs interface. This is done in preparation for making the
> > interface writable, which will enable provisioning UFS devices
> > via Linux.
> >
> > The configuration descriptor is laid out as a header, then a set of
> > (usually 8) copies of the same descriptor for each unit.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> > Changes since v1:
> >       - Squashed documentation changes into this change.
> >       - Reworked sysfs layout so that instead of a sysfs file for a
> > unit selector and then a common set of unit attributes, each unit in
> > the config descriptor has its own directory. This required a little
> > bit of kobject magic. Alternatively I could use standard device
> > attributes and simply allocate N*M of them from a template. I have
> > that coded up, and can go with that if preferred, but I thought
> > this was a little nicer since it wasted less memory.
>
> Ick, don't use "raw" kobjects please, as userspace will not see them
> correctly in the libraries that track devices and attributes, like
> libudev.
>
> And what is wrong with using configfs?  I thought that was the better
> way to go for something like this.  You are configuring the device,
> which is exactly what configfs was created for, to keep people from
> having to do this type of mess in sysfs.
>
> thanks,
>
> greg k-h

Ok. Sayali's got patches for doing this via configfs, so let's go with his.
-Evan
