Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D8FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF7C2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvw+Qvn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF7C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeGRJMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:12:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38943 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeGRJMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:12:07 -0400
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so7264237oib.6;
        Wed, 18 Jul 2018 01:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gbBupZM07/fZOi8UjGpynCJsGGRFoUIYIj+VDKmKmtE=;
        b=uvw+Qvn7z3r+CukYqeq9+84/OTLUspdPTYHThb0JeHMIVpjcXyN4OCdKDhJdYNgNvO
         cvqOOErEjIVvNNqTOkgarTZYJ1pKx7iSCTdVAeVSXGLk+D6mDT3askTVGzveJswN49Ne
         OrRv5dhPgFnCaDM4mgaX66D1YKlYDax6dRB+/5wLuwvPp2ggb1NJywYZPIXUY2egaE0d
         lUB0fJhEFGSLOlNqwirwCPQY5Xx4DQJqZZM3NCV9KmkPlwHf4oE7eNj88o7/VQoOsMYg
         SYk8NPlTgY1WkFszRAVK5k4D2obnlFeXk8Ar9yp+CKr+QEx3lFYosOyyNAD67y4o2qme
         SUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gbBupZM07/fZOi8UjGpynCJsGGRFoUIYIj+VDKmKmtE=;
        b=r5C1gR454TD6K+SCi9GTLMufSXK8UwA9wto7GCw0pIcEygdvW52W8jCXOi8G3elGuR
         25aKjr2ZTGscxsZPMRsK+sBiqHa8SS+xuV6PXUDs0TxUJCTl/kY0P+V5DrxZ1uVaKcKj
         EDOuwEZzEWaWNrWWXCWJTgoaBCH5fIiW3xcQaU1N4JAHfLFIW4pIwKukEQHeoAqdh/Om
         e6G4mqCmLQxsL8ObAdKUKYX1QJRqWxRI/sTBIYrf75F2bhNDAWn1o7m+3OQC/1yBi25N
         CiZVFnAuBPKDMr8dKtyAXvx06htm8xgQ+iiVr19/IroFcjmGOqPaxyjNhgXoEQpIjiac
         JBow==
X-Gm-Message-State: AOUpUlFR9otxAfNWqVxNfuToHVligyxSfcrWCjGLGj1qm3TJgVEF2muF
        ODcQTzsZPVTdaVPmYz1w4Zqj0yFmewmfsWl8SBo=
X-Google-Smtp-Source: AAOMgpfF6ezL1pPQhPcPtst0U5ND7t37du0ZNseH7H4PweLw1gQ1qK64+T2++xOCE9TXqsS8fA7aeO/LdFJleC64+js=
X-Received: by 2002:aca:b841:: with SMTP id i62-v6mr5198823oif.358.1531902918920;
 Wed, 18 Jul 2018 01:35:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 01:35:18
 -0700 (PDT)
In-Reply-To: <20180718082505.GB16072@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com> <20180716235936.11268-2-lyude@redhat.com>
 <20180717071641.GA5411@wunner.de> <d7c25a7f41df70685c0c4726315592d1d9b561ff.camel@redhat.com>
 <20180717182041.GA18363@wunner.de> <CAJZ5v0g8O8J0U8V-gLMe+NnTd3xgZ5_pjr9p2oci7yAfW54B-A@mail.gmail.com>
 <20180718082505.GB16072@wunner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Jul 2018 10:35:18 +0200
X-Google-Sender-Auth: M9uyVHAyOb1XHlaUGBqnIaGYp90
Message-ID: <CAJZ5v0hVKsW2Cx7WVaDzdR8Rg-GeN4LQ76V+UFAHkR-yDWTEOA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback recursion
 in suspend/resume paths
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:25 AM, Lukas Wunner <lukas@wunner.de> wrote:
> On Wed, Jul 18, 2018 at 09:38:41AM +0200, Rafael J. Wysocki wrote:
>> On Tue, Jul 17, 2018 at 8:20 PM, Lukas Wunner <lukas@wunner.de> wrote:
>> > Okay, the PCI device is suspending and the nvkm_i2c_aux_acquire()
>> > wants it in resumed state, so is waiting forever for the device to
>> > runtime suspend in order to resume it again immediately afterwards.
>> >
>> > The deadlock in the stack trace you've posted could be resolved using
>> > the technique I used in d61a5c106351 by adding the following to
>> > include/linux/pm_runtime.h:
>> >
>> > static inline bool pm_runtime_status_suspending(struct device *dev)
>> > {
>> >         return dev->power.runtime_status == RPM_SUSPENDING;
>> > }
>> >
>> > static inline bool is_pm_work(struct device *dev)
>> > {
>> >         struct work_struct *work = current_work();
>> >
>> >         return work && work->func == dev->power.work;
>> > }
>> >
>> > Then adding this to nvkm_i2c_aux_acquire():
>> >
>> >         struct device *dev = pad->i2c->subdev.device->dev;
>> >
>> >         if (!(is_pm_work(dev) && pm_runtime_status_suspending(dev))) {
>> >                 ret = pm_runtime_get_sync(dev);
>> >                 if (ret < 0 && ret != -EACCES)
>> >                         return ret;
>> >         }
> [snip]
>>
>> For the record, I don't quite like this approach as it seems to be
>> working around a broken dependency graph.
>>
>> If you need to resume device A from within the runtime resume callback
>> of device B, then clearly B depends on A and there should be a link
>> between them.
>>
>> That said, I do realize that it may be the path of least resistance,
>> but then I wonder if we can do better than this.
>
> The GPU contains an i2c subdevice for each connector with DDC lines.
> I believe those are modelled as children of the GPU's PCI device as
> they're accessed via mmio of the PCI device.
>
> The problem here is that when the GPU's PCI device runtime suspends,
> its i2c child device needs to be runtime active to suspend the MST
> topology.  Catch-22.

I see.

This sounds like a case for the ignore_children flag, maybe in a
slightly modified form, that will allow the parent to be suspended
regardless of the state of the children.

I wonder what happens to the I2C subdevices when the PCI device goes
into D3.  They are not accessible through MMIO any more then, so how
can they be suspended then?  Or do they need to be suspended at all?

> I don't know whether or not it's necessary to suspend the MST topology.
> I'm not an expert on DisplayPort MultiStream transport.

Me neither. :-)
