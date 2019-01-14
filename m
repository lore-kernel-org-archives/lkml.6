Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E531C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC7220645
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547508808;
	bh=U3e+1Fb6qz7svlcIw4TpOVLvmKelxkCIUibWIWdliYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XhqHi5wy/5TJOxYfewWRQUJOCeocoed/cQK8zc4jxzqiiKXiTxWPxF4TeDeCJ6RVy
	 2ztTn2xPXJHW2bhzJ+dI4duOuPogDn6F4qHkT6O8uqsJ+NsoVz+Iq90oHwE/jrOI+f
	 Tw1IgPGJMEByj9qfy/kn9qR5ODPkPRZnuv9rEhvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfANXd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:33:26 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:37525 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfANXd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:33:26 -0500
Received: by mail-oi1-f176.google.com with SMTP id y23so720760oia.4;
        Mon, 14 Jan 2019 15:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBkMmrV4BsD4+iMGevYPl/uLA6v4gUft6wFJf4Z3ap0=;
        b=dE9BxXf0CJl8oZNik8mPH/VggDsK7A1/ECb7dA9DQvSrYC/pDXYM1MziS7iAxD0nii
         yel9ByF6w1FBa/bd4R4O+R8rgACHYYfHKEc/jzLl/dOTKlGW43HSNWiELhvF10FjSrTC
         vHt2IZJrkG/XDtt5gr4uB5l2vPnBa5LsOT9RdIfZaToo64FsfHVK7GeNIgleZ4Dh+wYA
         1HyH7BR29rSYtKK7kSmhZth9HgxSWH+rDXVUKawBepZWHXR2CMOrlERxd+Z02lSsFh4T
         sEYokqIZqXAbnJr9v7A91pG5fZvSV/05IXipjZx6npAuU9ey+q9jNXuZUR1XgJIMN8cj
         uoKg==
X-Gm-Message-State: AJcUukfmP/kXKKfrEh3bdSfp7hIup/lbJekQ8ZpB8G9Nj5pu7PcTKHLl
        9JZZ2UhC8kznOROfNvxtcdnnOAXp3A/NZi0S9Og=
X-Google-Smtp-Source: ALg8bN65UsPPlcSvsUOn/lRN7sLNDLdg/yGcP7QqiMDeWadSbugT2mDQe900MZAUaMf4XMJCjihlfTqLna5/Ie1YBT0=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr497067oic.33.1547508805113;
 Mon, 14 Jan 2019 15:33:25 -0800 (PST)
MIME-Version: 1.0
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan> <e89ee355-3d87-1fe7-a1ff-91a1dd43177b@linaro.org>
 <CAJZ5v0hPnoLzJPRgE43NrB2Vt4BZYx=jgw_-WHoAiBQvhviY1A@mail.gmail.com> <8e1593ee-5a68-c0a1-50e4-6fedb6f3ec5a@linaro.org>
In-Reply-To: <8e1593ee-5a68-c0a1-50e4-6fedb6f3ec5a@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Jan 2019 00:33:13 +0100
Message-ID: <CAJZ5v0jB+_arUAL-rscJvH1Ej2SJA0TmbKS3Uh-2My2L=HDswg@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 11:39 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> sorry for the delay.
>
> On 10/01/2019 11:20, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> >>>       if (entered_state >= 0) {
> >>> +             s64 diff, delay = drv->states[entered_state].exit_latency;
> >>> +             int i;
> >>> +
> >>>               /*
> >>>                * Update cpuidle counters
> >>>                * This can be moved to within driver enter routine,
> >>> @@ -260,6 +262,33 @@ int cpuidle_enter_state(struct cpuidle_d
> >>>               dev->last_residency = (int)diff;
> >>
> >> Shouldn't we subtract the 'delay' from the computed 'diff' in any case ?
> >
> > No.
> >
> >> Otherwise the 'last_residency' accumulates the effective sleep time and
> >> the time to wakeup. We are interested in the sleep time only for
> >> prediction and metrics no ?
> >
> > Yes, but 'delay' is the worst-case latency and not the actual one
> > experienced, most of the time, and (on average) we would underestimate
> > the sleep time if it was always subtracted.
>
> IMO, the exit latency is more or less constant for the cpu power down
> state. When it is the cluster power down state, the first cpu waking up
> has the worst latency, then the others have the same has the cpu power
> down state.
>
> If we can model that, the gray area you mention below can be reduced.
> There are platform where the exit latency is very high [1] and not
> taking it into account will give very wrong metrics.

That is kind of a special case, though, and there is no way for the
cpuidle core do distinguish it from all of the other cases.

> > The idea here is to only count the wakeup as 'above' if the total
> > 'last_residency' is below the target residency of the idle state that
> > was asked for (as in that case we know for certain that the CPU has
> > been woken up too early) and to only count it as 'below' if the
> > difference between 'last_residency' and 'delay' is greater than or
> > equal to the target residency of a deeper idle state (as in that case
> > we know for certain that the CPU has been woken up too late).
> >
> > Of course, this means that there is a "gray area" in which we are not
> > really sure if the sleep time has matched the idle state that was
> > asked for, but there's not much we can do about that IMO.
>
> There is another aspect of the metric which can be improved, the 'above'
> and the 'below' give an rough indication about the correctness of the
> prediction but they don't tell us which idle state we should have
> selected (we can be constantly choosing state3 instead of state1 for
> example).
>
> It would be nice to add a 'missed' field for each idle states, so when
> we check if there is a 'above' or a 'below' condition, we increment the
> idle state 'missed' field for the idle state we should have selected.

That's a governor's job however.  That's why there is the ->reflect
governor callback after all, among other things.
