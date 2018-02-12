Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbeBLS6e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:58:34 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:46990 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbeBLS6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:58:33 -0500
X-Google-Smtp-Source: AH8x2254QPSRa26ht+SUNVBKcO2WfrEpA9IYZaPkHY0uZluxRTYhzzujFxVWbnZoet5TZzXK0rIS5FO4T6bs+DTLqmE=
MIME-Version: 1.0
In-Reply-To: <20180212094500.22nvzzzpy6vrbqgc@wunner.de>
References: <cover.1518338788.git.lukas@wunner.de> <CAHbf0-Fhi9j5H7VTxF84SENQph+UQE2zRbi2Q-u_DAMh6x+eSg@mail.gmail.com>
 <20180211192314.GA22869@wunner.de> <20180211194154.GB22869@wunner.de>
 <CAHbf0-HSNJmXs_Nm+bbcfUifoLEpFsMSpM96a-pVfLFMNz3GFw@mail.gmail.com>
 <20180212033947.GA19049@wunner.de> <CAHbf0-GFdw9M8rv0+xHms9_HdcK_cgHak7G1ugtz0ch1_k6=vQ@mail.gmail.com>
 <20180212094500.22nvzzzpy6vrbqgc@wunner.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 Feb 2018 13:58:32 -0500
Message-ID: <CADnq5_OaLNDZ10wzaqKGKkkjGVNLSTBPP76tch0aJY_mJ-EV4Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix deadlock on runtime suspend in DRM drivers
To: Lukas Wunner <lukas@wunner.de>
Cc: Mike Lothian <mike@fireburn.co.uk>,
        Ismo Toijala <ismo.toijala@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dave Airlie <airlied@redhat.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Peter Wu <peter@lekensteyn.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 4:45 AM, Lukas Wunner <lukas@wunner.de> wrote:
> On Mon, Feb 12, 2018 at 09:03:26AM +0000, Mike Lothian wrote:
>> On 12 February 2018 at 03:39, Lukas Wunner <lukas@wunner.de> wrote:
>> > On Mon, Feb 12, 2018 at 12:35:51AM +0000, Mike Lothian wrote:
>> > > I've not been able to reproduce the original problem you're trying to
>> > > solve on amdgpu thats with or without your patch set and the above
>> > > "trigger" too
>> > >
>> > > Is anything else required to trigger it, I started multiple DRI_PRIME
>> > > glxgears, in parallel, serial waiting the 12 seconds and serial within
>> > > the 12 seconds and I couldn't reproduce it
>> >
>> > The discrete GPU needs to runtime suspend, that's the trigger,
>> > so no DRI_PRIME executables should be running.  Just let it
>> > autosuspend after boot.  Do you see "waiting 12 sec" messages
>> > in dmesg?  If not it's not autosuspending.
>>
>> Yes I'm seeing those messages, I'm just not seeing the hangs
>>
>> I've attached the dmesg in case you're interested
>
> Okay the reason you're not seeing deadlocks is because the output poll
> worker is not enabled.  And the output poll worker is not enabled
> because your discrete GPU doesn't have any outputs:
>
> [    0.265568] [drm:dc_create] *ERROR* DC: Number of connectors is zero!
>
> The outputs are only polled if there are connectors which have the
> DRM_CONNECTOR_POLL_CONNECT or DRM_CONNECTOR_POLL_DISCONNECT flag set.
> And that only ever seems to be the case for VGA and DVI.
>
> We know based on bugzilla reports that hybrid graphics laptops do exist
> which poll outputs with radeon and nouveau.  If there are no laptops
> supported by amdgpu whose discrete GPU has polled connectors, then
> patch [5/5] would be unnecessary.  That is for Alex to decide.

Most hybrid laptops don't have display connectors on the dGPU and we
only use polling on analog connectors, so you are not likely to run
into this on recent laptops.  That said, I don't know if there is some
OEM system out there with a VGA port on the dGPU in a hybrid laptop.
I guess another option is to just disable polling on hybrid laptops.

Alex

>
> However that is very good to know, so thanks a lot for your testing
> efforts, much appreciated!
>
> Kind regards,
>
> Lukas
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
