Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC0FC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39C520675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="mANDTWRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfAMUuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:50:52 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:45746 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfAMUuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G2ylaowRHFoeVnJ0Y8zU/k9MQ6/5ZyoxkrkEItAgNWY=; b=mANDTWRIwZrF9YZJSL9wGZyh3
        JdLP34hz2U7cDv9PvfrwQ810GKrTC1J7PxoXiW7ch0td+8prjweTRg9zQ4GvJcaeMoBQBqwgRtj/X
        IlFitoJkZ9fcTugGBTn+8iHfnlcLymLWeuKxpXul+fi3rBnfPJfsT0IJqTfiw0S11VDJQ=;
Received: from pd9e2f68f.dip0.t-ipconnect.de ([217.226.246.143] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gimiV-0004t7-Qn; Sun, 13 Jan 2019 21:50:47 +0100
Date:   Sun, 13 Jan 2019 21:50:36 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 1/5] gnss: sirf: write data to gnss only when the
 gnss device is open
Message-ID: <20190113215036.11c543db@aktux>
In-Reply-To: <20190110120228.GB3430@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
        <20181209195150.5192-2-andreas@kemnade.info>
        <20190110120228.GB3430@localhost>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TluzXNe1aUWo3B.XKM=B_tS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TluzXNe1aUWo3B.XKM=B_tS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jan 2019 13:02:28 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Sun, Dec 09, 2018 at 08:51:46PM +0100, Andreas Kemnade wrote:
> > The api forbids writing data there otherwise. Prepare for the
> > serdev_open()/close() being a part of runtime pm.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v2:
> >  add locking
> >=20
> >  drivers/gnss/sirf.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> > index 2c22836d3ffd..ba663de1db49 100644
> > --- a/drivers/gnss/sirf.c
> > +++ b/drivers/gnss/sirf.c
> > @@ -35,6 +35,12 @@ struct sirf_data {
> >  	struct gpio_desc *wakeup;
> >  	int irq;
> >  	bool active;
> > +	/*
> > +	 * There might be races between returning data and closing the gnss
> > +	 * device.
> > +	 */ =20
>=20
> Please drop this comment, which is too verbose. The mutex protects the
> opened flag, and that could be indicated using a new line above the
> mutex and below the flag, or using a short comment before the mutex.
>=20
> > +	struct mutex gdev_mutex; =20
>=20
> Please rename "mutex". We should be able to reuse this for the serdev
> open count as well, right?

No. we cannot. The problem here is that we would take the same mutex
in a serdev callback and around a serdev call. Then we have things like
that:

[   36.700408] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   36.706970] WARNING: possible circular locking dependency detected
[   36.713531] 5.0.0-rc1-00008-g29801984a0fa #1 Not tainted
[   36.719177] ------------------------------------------------------
[   36.725708] kworker/u2:1/16 is trying to acquire lock:
[   36.731170] (ptrval) (&data->mutex){+.+.}, at: sirf_receive_buf+0x50/0x8=
0 [g]
[   36.739532]=20
[   36.739532] but task is already holding lock:
[   36.745727] (ptrval) (&buf->lock){+.+.}, at: flush_to_ldisc+0x1c/0xcc
[   36.752593]=20
[   36.752593] which lock already depends on the new lock.
[   36.752593]=20
[   36.761230]=20
[   36.761230] the existing dependency chain (in reverse order) is:
[   36.769165]=20
[   36.769165] -> #3 (&buf->lock){+.+.}:
[   36.774658]        mutex_lock_nested+0x18/0x20
[   36.779388]        tty_buffer_flush+0x3c/0xb4
[   36.783996]        tty_ldisc_flush+0x1c/0x30
[   36.788543]        tty_port_close_start+0x17c/0x18c
[   36.793731]        tty_port_close+0x10/0x58
[   36.798187]        ttyport_close+0x40/0x58
[   36.802581]        sirf_set_active+0x1c4/0x2dc [gnss_sirf]
[   36.808410]        sirf_runtime_resume+0x54/0x58 [gnss_sirf]
[   36.814422]        __rpm_callback+0x30/0x194
[   36.818969]        rpm_callback+0x70/0x80
[   36.823242]        rpm_resume+0x58c/0x66c
[   36.827514]        __pm_runtime_resume+0x78/0x94
[   36.832458]        sirf_probe+0x170/0x278 [gnss_sirf]
[   36.837799]        serdev_drv_probe+0x28/0x44
[   36.842437]        really_probe+0x1f0/0x2c0
[   36.846893]        driver_probe_device+0x140/0x15c
[   36.851989]        __driver_attach+0x94/0xd0
[   36.856536]        bus_for_each_dev+0x64/0xa0
[   36.861175]        async_run_entry_fn+0x44/0xfc
[   36.865997]        process_one_work+0x384/0x710
[   36.870819]        worker_thread+0x290/0x3e4
[   36.875366]        kthread+0x13c/0x158
[   36.879364]        ret_from_fork+0x14/0x20
[   36.883697]          (null)
[   36.886688]=20
[   36.886688] -> #2 (&tty->ldisc_sem){++++}:
[   36.892608]        tty_ldisc_lock+0x50/0x74
[   36.897094]        tty_init_dev+0xc0/0x194
[   36.901458]        tty_open+0x308/0x334
[   36.905517]        chrdev_open+0x150/0x184
[   36.909912]        do_dentry_open+0x214/0x37c
[   36.914520]        path_openat+0xdf8/0xfe8
[   36.918884]        do_filp_open+0x3c/0x9c
[   36.923156]        do_sys_open+0xf4/0x1e4
[   36.927429]        kernel_init_freeable+0x370/0x4ac
[   36.932617]        kernel_init+0x8/0x10c
[   36.936798]        ret_from_fork+0x14/0x20
[   36.941131]          (null)
[   36.944122]=20
[   36.944122] -> #1 (&tty->legacy_mutex){+.+.}:
[   36.950347]        mutex_lock_nested+0x18/0x20
[   36.955047]        tty_init_dev+0x38/0x194
[   36.959411]        ttyport_open+0x28/0x140
[   36.963775]        serdev_device_open+0x28/0xa8
[   36.968627]        sirf_serdev_open.part.0+0x10/0x40 [gnss_sirf]
[   36.975006]        sirf_set_active+0x6c/0x2dc [gnss_sirf]
[   36.980743]        sirf_runtime_resume+0x54/0x58 [gnss_sirf]
[   36.986755]        __rpm_callback+0x30/0x194
[   36.991302]        rpm_callback+0x70/0x80
[   36.995574]        rpm_resume+0x58c/0x66c
[   36.999847]        __pm_runtime_resume+0x78/0x94
[   37.004791]        sirf_probe+0x170/0x278 [gnss_sirf]
[   37.010131]        serdev_drv_probe+0x28/0x44
[   37.014770]        really_probe+0x1f0/0x2c0
[   37.019226]        driver_probe_device+0x140/0x15c
[   37.024322]        __driver_attach+0x94/0xd0
[   37.028869]        bus_for_each_dev+0x64/0xa0
[   37.033508]        async_run_entry_fn+0x44/0xfc
[   37.038330]        process_one_work+0x384/0x710
[   37.043151]        worker_thread+0x290/0x3e4
[   37.047698]        kthread+0x13c/0x158
[   37.051666]        ret_from_fork+0x14/0x20
[   37.056030]          (null)
[   37.058990]=20
[   37.058990] -> #0 (&data->mutex){+.+.}:
[   37.064666]        __mutex_lock+0x74/0x9c0
[   37.069030]        mutex_lock_nested+0x18/0x20
[   37.073760]        sirf_receive_buf+0x50/0x80 [gnss_sirf]
[   37.079498]        ttyport_receive_buf+0x58/0xd0
[   37.084411]        flush_to_ldisc+0x94/0xcc
[   37.088867]        process_one_work+0x384/0x710
[   37.093688]        worker_thread+0x290/0x3e4
[   37.098236]        kthread+0x13c/0x158
[   37.102203]        ret_from_fork+0x14/0x20
[   37.106567]          (null)
[   37.109527]=20
[   37.109527] other info that might help us debug this:
[   37.109527]=20
[   37.118011] Chain exists of:
[   37.118011]   &data->mutex --> &tty->ldisc_sem --> &buf->lock
[   37.118011]=20
[   37.128723]  Possible unsafe locking scenario:
[   37.128723]=20
[   37.134979]        CPU0                    CPU1
[   37.139801]        ----                    ----
[   37.144592]   lock(&buf->lock);
[   37.147949]                                lock(&tty->ldisc_sem);
[   37.154418]                                lock(&buf->lock);
[   37.160400]   lock(&data->mutex);
[   37.163940]=20
[   37.163940]  *** DEADLOCK ***
[   37.163940]=20
[   37.170227] 3 locks held by kworker/u2:1/16:
[   37.174743]  #0: (ptrval) ((wq_completion)"events_unbound"){+.+.}, at: p=
roce0
[   37.184356]  #1: (ptrval) ((work_completion)(&buf->work)){+.+.}, at: pro=
cess0
[   37.193786]  #2: (ptrval) (&buf->lock){+.+.}, at: flush_to_ldisc+0x1c/0x=
cc
[   37.201110]=20
[   37.201110] stack backtrace:
[   37.205749] CPU: 0 PID: 16 Comm: kworker/u2:1 Not tainted 5.0.0-rc1-0000=
8-g21
[   37.214508] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[   37.221160] Workqueue: events_unbound flush_to_ldisc
[   37.226501] [<c01109a4>] (unwind_backtrace) from [<c010c63c>] (show_stac=
k+0x)
[   37.234710] [<c010c63c>] (show_stack) from [<c0811670>] (dump_stack+0x90=
/0xc)
[   37.242401] [<c0811670>] (dump_stack) from [<c01853e0>] (print_circular_=
bug.)
[   37.252197] [<c01853e0>] (print_circular_bug.constprop.17) from [<c01879=
b0>])
[   37.262451] [<c01879b0>] (__lock_acquire) from [<c0188e3c>] (lock_acquir=
e+0x)
[   37.270843] [<c0188e3c>] (lock_acquire) from [<c082afd0>] (__mutex_lock+=
0x74)
[   37.278991] [<c082afd0>] (__mutex_lock) from [<c082b934>] (mutex_lock_ne=
sted)
[   37.287506] [<c082b934>] (mutex_lock_nested) from [<bf0330d0>] (sirf_rec=
eive)
[   37.297485] [<bf0330d0>] (sirf_receive_buf [gnss_sirf]) from [<c054c63c>=
] (t)
[   37.307647] [<c054c63c>] (ttyport_receive_buf) from [<c0532260>] (flush_=
to_l)
[   37.316497] [<c0532260>] (flush_to_ldisc) from [<c014ae08>] (process_one=
_wor)
[   37.325286] [<c014ae08>] (process_one_work) from [<c014c300>] (worker_th=
read)
[   37.333984] [<c014c300>] (worker_thread) from [<c01515f0>] (kthread+0x13=
c/0x)
[   37.341827] [<c01515f0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14=
/0x2)
[   37.349487] Exception stack(0xeea17fb0 to 0xeea17ff8)
[   37.354858] 7fa0:                                     00000000 00000000 =
00000
[   37.363525] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000
[   37.372192] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
000000=EF=BF=BD[   62.887756] random: crng init done
M_FCLK=EF=BF=BD=EF=BF=BD00
    DLES[  248.800109] INFO: task kworker/u2:1:16 blocked for more than 120=
 sec.
[  248.807495]       Not tainted 5.0.0-rc1-00008-g29801984a0fa #1
[  248.814575] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this.
[  248.823333] kworker/u2:1    D    0    16      2 0x00000000
[  248.831909] Workqueue: events_unbound flush_to_ldisc
[  248.837310] [<c0829b1c>] (__schedule) from [<c0829ca4>] (schedule+0x98/0=
xb0)
[  248.844909] [<c0829ca4>] (schedule) from [<c082a0f0>] (schedule_preempt_=
disa)
[  248.853912] [<c082a0f0>] (schedule_preempt_disabled) from [<c082b7d4>] (=
__mu)
[  248.863433] [<c082b7d4>] (__mutex_lock) from [<c082b934>] (mutex_lock_ne=
sted)
[  248.872070] [<c082b934>] (mutex_lock_nested) from [<bf0330d0>] (sirf_rec=
eive)
[  248.882202] [<bf0330d0>] (sirf_receive_buf [gnss_sirf]) from [<c054c63c>=
] (t)
[  248.892425] [<c054c63c>] (ttyport_receive_buf) from [<c0532260>] (flush_=
to_l)
[  248.901428] [<c0532260>] (flush_to_ldisc) from [<c014ae08>] (process_one=
_wor)
[  248.910308] [<c014ae08>] (process_one_work) from [<c014c300>] (worker_th=
read)
[  248.919128] [<c014c300>] (worker_thread) from [<c01515f0>] (kthread+0x13=
c/0x)
[  248.927032] [<c01515f0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14=
/0x2)
[  248.934844] Exception stack(0xeea17fb0 to 0xeea17ff8)
[  248.940368] 7fa0:                                     00000000 00000000 =
00000
[  248.949188] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000
[  248.957916] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  248.965118] INFO: task kworker/u2:2:35 blocked for more than 120 seconds.
[  248.972473]       Not tainted 5.0.0-rc1-00008-g29801984a0fa #1
[  248.978820] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this.
[  248.987091] kworker/u2:2    D    0    35      2 0x00000000
[  248.993011] Workqueue: events_unbound async_run_entry_fn
[  248.998809] [<c0829b1c>] (__schedule) from [<c0829ca4>] (schedule+0x98/0=
xb0)
[  249.006256] [<c0829ca4>] (schedule) from [<c082a0f0>] (schedule_preempt_=
disa)
[  249.015167] [<c082a0f0>] (schedule_preempt_disabled) from [<c082b7d4>] (=
__mu)
[  249.024658] [<c082b7d4>] (__mutex_lock) from [<c082b934>] (mutex_lock_ne=
sted)
[  249.033264] [<c082b934>] (mutex_lock_nested) from [<c0532474>] (tty_buff=
er_f)
[  249.042236] [<c0532474>] (tty_buffer_flush) from [<c0531478>] (tty_ldisc=
_flu)
[  249.050994] [<c0531478>] (tty_ldisc_flush) from [<c0533060>] (tty_port_c=
lose)
[  249.060333] [<c0533060>] (tty_port_close_start) from [<c0533080>] (tty_p=
ort_)
[  249.069366] [<c0533080>] (tty_port_close) from [<c054c8d8>] (ttyport_clo=
se+0)
[  249.077758] [<c054c8d8>] (ttyport_close) from [<bf033618>] (sirf_set_act=
ive+)
[  249.087554] [<bf033618>] (sirf_set_active [gnss_sirf]) from [<bf033784>]=
 (si)
[  249.098785] [<bf033784>] (sirf_runtime_resume [gnss_sirf]) from [<c056d9=
8c>])
[  249.108947] [<c056d98c>] (__rpm_callback) from [<c056db60>] (rpm_callbac=
k+0x)
[  249.117187] [<c056db60>] (rpm_callback) from [<c056d7e8>] (rpm_resume+0x=
58c/)
[  249.125366] [<c056d7e8>] (rpm_resume) from [<c056d940>] (__pm_runtime_re=
sume)
[  249.133972] [<c056d940>] (__pm_runtime_resume) from [<bf0332cc>] (sirf_p=
robe)
[  249.143829] [<bf0332cc>] (sirf_probe [gnss_sirf]) from [<c054c1b4>] (ser=
dev_)
[  249.153228] [<c054c1b4>] (serdev_drv_probe) from [<c0562a60>] (really_pr=
obe+)
[  249.161926] [<c0562a60>] (really_probe) from [<c0562dbc>] (driver_probe_=
devi)
[  249.170867] [<c0562dbc>] (driver_probe_device) from [<c0562e6c>] (__driv=
er_a)
[  249.179931] [<c0562e6c>] (__driver_attach) from [<c056104c>] (bus_for_ea=
ch_d)
[  249.188659] [<c056104c>] (bus_for_each_dev) from [<c0154db4>] (async_run=
_ent)
[  249.197692] [<c0154db4>] (async_run_entry_fn) from [<c014ae08>] (process=
_one)
[  249.206939] [<c014ae08>] (process_one_work) from [<c014c300>] (worker_th=
read)
[  249.215728] [<c014c300>] (worker_thread) from [<c01515f0>] (kthread+0x13=
c/0x)
[  249.223663] [<c01515f0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14=
/0x2)
[  249.231414] Exception stack(0xeea7ffb0 to 0xeea7fff8)
[  249.236846] ffa0:                                     00000000 00000000 =
00000
[  249.245635] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000
[  249.254394] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  249.261566] INFO: task modprobe:1100 blocked for more than 120 seconds.
[  249.268646]       Not tainted 5.0.0-rc1-00008-g29801984a0fa #1
[  249.274963] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this.
[  249.283386] modprobe        D    0  1100   1090 0x00000000
[  249.289337] [<c0829b1c>] (__schedule) from [<c0829ca4>] (schedule+0x98/0=
xb0)
[  249.296874] [<c0829ca4>] (schedule) from [<c0155124>] (async_synchronize=
_coo)
[  249.306488] [<c0155124>] (async_synchronize_cookie_domain) from [<c01d01=
48>])
[  249.316619] [<c01d0148>] (do_init_module) from [<c01cedcc>] (load_module=
+0x1)
[  249.325225] [<c01cedcc>] (load_module) from [<c01cf69c>] (sys_finit_modu=
le+0)
[  249.333648] [<c01cf69c>] (sys_finit_module) from [<c0101000>] (ret_fast_=
sysc)
[  249.342407] Exception stack(0xedc6bfa8 to 0xedc6bff0)
[  249.347839] bfa0:                   00497b00 004aabb0 00000004 00496e80 =
00000
[  249.356628] bfc0: 00497b00 004aabb0 14840a00 0000017b 00040000 00000000 =
00000
[  249.365386] bfe0: be9fea48 be9fea38 0048d6c3 b6f3aa42
[  249.370849] INFO: lockdep is turned off.
[  371.680145] INFO: task kworker/u2:1:16 blocked for more than 120 seconds.
[  371.687530]       Not tainted 5.0.0-rc1-00008-g29801984a0fa #1
[  371.694854] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this.
[  371.703643] kworker/u2:1    D    0    16      2 0x00000000
[  371.712249] Workqueue: events_unbound flush_to_ldisc
[  371.717620] [<c0829b1c>] (__schedule) from [<c0829ca4>] (schedule+0x98/0=
xb0)
[  371.725250] [<c0829ca4>] (schedule) from [<c082a0f0>] (schedule_preempt_=
disa)
[  371.734252] [<c082a0f0>] (schedule_preempt_disabled) from [<c082b7d4>] (=
__mu)
[  371.743743] [<c082b7d4>] (__mutex_lock) from [<c082b934>] (mutex_lock_ne=
sted)
[  371.752349] [<c082b934>] (mutex_lock_nested) from [<bf0330d0>] (sirf_rec=
eive)
[  371.762420] [<bf0330d0>] (sirf_receive_buf [gnss_sirf]) from [<c054c63c>=
] (t)
[  371.772674] [<c054c63c>] (ttyport_receive_buf) from [<c0532260>] (flush_=
to_l)
[  371.781616] [<c0532260>] (flush_to_ldisc) from [<c014ae08>] (process_one=
_wor)
[  371.790496] [<c014ae08>] (process_one_work) from [<c014c300>] (worker_th=
read)
[  371.799285] [<c014c300>] (worker_thread) from [<c01515f0>] (kthread+0x13=
c/0x)
[  371.807159] [<c01515f0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14=
/0x2)
[  371.814941] Exception stack(0xeea17fb0 to 0xeea17ff8)
[  371.820434] 7fa0:                                     00000000 00000000 =
00000
[  371.829193] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000
[  371.837921] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  371.845062] INFO: task kworker/u2:2:35 blocked for more than 120 seconds.
[  371.852416]       Not tainted 5.0.0-rc1-00008-g29801984a0fa #1
[  371.858642] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this.
[  371.867065] kworker/u2:2    D    0    35      2 0x00000000
[  371.873077] Workqueue: events_unbound async_run_entry_fn
[  371.878814] [<c0829b1c>] (__schedule) from [<c0829ca4>] (schedule+0x98/0=
xb0)
[  371.886230] [<c0829ca4>] (schedule) from [<c082a0f0>] (schedule_preempt_=
disa)
[  371.895141] [<c082a0f0>] (schedule_preempt_disabled) from [<c082b7d4>] (=
__mu)
[  371.904693] [<c082b7d4>] (__mutex_lock) from [<c082b934>] (mutex_lock_ne=
sted)
[  371.913299] [<c082b934>] (mutex_lock_nested) from [<c0532474>] (tty_buff=
er_f)
[  371.922271] [<c0532474>] (tty_buffer_flush) from [<c0531478>] (tty_ldisc=
_flu)
[  371.931091] [<c0531478>] (tty_ldisc_flush) from [<c0533060>] (tty_port_c=
lose)
[  371.940429] [<c0533060>] (tty_port_close_start) from [<c0533080>] (tty_p=
ort_)
[  371.949523] [<c0533080>] (tty_port_close) from [<c054c8d8>] (ttyport_clo=
se+0)
[  371.957946] [<c054c8d8>] (ttyport_close) from [<bf033618>] (sirf_set_act=
ive+)
[  371.967773] [<bf033618>] (sirf_set_active [gnss_sirf]) from [<bf033784>]=
 (si)
[  371.979064] [<bf033784>] (sirf_runtime_resume [gnss_sirf]) from [<c056d9=
8c>])
[  371.989257] [<c056d98c>] (__rpm_callback) from [<c056db60>] (rpm_callbac=
k+0x)
[  371.997589] [<c056db60>] (rpm_callback) from [<c056d7e8>] (rpm_resume+0x=
58c/)
[  372.005737] [<c056d7e8>] (rpm_resume) from [<c056d940>] (__pm_runtime_re=
sume)
[  372.014373] [<c056d940>] (__pm_runtime_resume) from [<bf0332cc>] (sirf_p=
robe)
[  372.024291] [<bf0332cc>] (sirf_probe [gnss_sirf]) from [<c054c1b4>] (ser=
dev_)
[  372.033752] [<c054c1b4>] (serdev_drv_probe) from [<c0562a60>] (really_pr=
obe+)
[  372.042480] [<c0562a60>] (really_probe) from [<c0562dbc>] (driver_probe_=
devi)
[  372.051452] [<c0562dbc>] (driver_probe_device) from [<c0562e6c>] (__driv=
er_a)
[  372.060516] [<c0562e6c>] (__driver_attach) from [<c056104c>] (bus_for_ea=
ch_d)
[  372.069335] [<c056104c>] (bus_for_each_dev) from [<c0154db4>] (async_run=
_ent)
[  372.078369] [<c0154db4>] (async_run_entry_fn) from [<c014ae08>] (process=
_one)
[  372.087615] [<c014ae08>] (process_one_work) from [<c014c300>] (worker_th=
read)
[  372.096405] [<c014c300>] (worker_thread) from [<c01515f0>] (kthread+0x13=
c/0x)
[  372.104370] [<c01515f0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14=
/0x2)
[  372.112152] Exception stack(0xeea7ffb0 to 0xeea7fff8)
[  372.117645] ffa0:                                     00000000 00000000 =
00000
[  372.126434] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000
[  372.135223] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  372.142395] INFO: task modprobe:1100 blocked for more than 120 seconds.
[  372.149566]       Not tainted 5.0.0-rc1-00008-g29801984a0fa #1
[  372.155853] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this.
[  372.164276] modprobe        D    0  1100   1090 0x00000000
[  372.170257] [<c0829b1c>] (__schedule) from [<c0829ca4>] (schedule+0x98/0=
xb0)
[  372.177825] [<c0829ca4>] (schedule) from [<c0155124>] (async_synchronize=
_coo)
[  372.187469] [<c0155124>] (async_synchronize_cookie_domain) from [<c01d01=
48>])
[  372.197631] [<c01d0148>] (do_init_module) from [<c01cedcc>] (load_module=
+0x1)
[  372.206237] [<c01cedcc>] (load_module) from [<c01cf69c>] (sys_finit_modu=
le+0)
[  372.214660] [<c01cf69c>] (sys_finit_module) from [<c0101000>] (ret_fast_=
sysc)
[  372.223449] Exception stack(0xedc6bfa8 to 0xedc6bff0)
[  372.229003] bfa0:                   00497b00 004aabb0 00000004 00496e80 =
00000
[  372.237701] bfc0: 00497b00 004aabb0 14840a00 0000017b 00040000 00000000 =
00000
[  372.246490] bfe0: be9fea48 be9fea38 0048d6c3 b6f3aa42
[  372.251983] INFO: lockdep is turned off.
[  494.560119] INFO: task kworker/u2:1:16 blocked for more than 120 seconds.
[  494.567535]       Not tainted 5.0.0-rc1-00008-g29801984a0fa #1
[  494.574859] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this.
[  494.583618] kworker/u2:1    D    0    16      2 0x00000000
[  494.592224] Workqueue: events_unbound flush_to_ldisc
[  494.597625] [<c0829b1c>] (__schedule) from [<c0829ca4>] (schedule+0x98/0=
xb0)
[  494.605255] [<c0829ca4>] (schedule) from [<c082a0f0>] (schedule_preempt_=
disa)
[  494.614227] [<c082a0f0>] (schedule_preempt_disabled) from [<c082b7d4>] (=
__mu)
[  494.623718] [<c082b7d4>] (__mutex_lock) from [<c082b934>] (mutex_lock_ne=
sted)
[  494.632324] [<c082b934>] (mutex_lock_nested) from [<bf0330d0>] (sirf_rec=
eive)
[  494.642395] [<bf0330d0>] (sirf_receive_buf [gnss_sirf]) from [<c054c63c>=
] (t)
[  494.652618] [<c054c63c>] (ttyport_receive_buf) from [<c0532260>] (flush_=
to_l)
[  494.661621] [<c0532260>] (flush_to_ldisc) from [<c014ae08>] (process_one=
_wor)
[  494.670471] [<c014ae08>] (process_one_work) from [<c014c300>] (worker_th=
read)
[  494.679260] [<c014c300>] (worker_thread) from [<c01515f0>] (kthread+0x13=
c/0x)
[  494.687133] [<c01515f0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14=
/0x2)
[  494.694915] Exception stack(0xeea17fb0 to 0xeea17ff8)
[  494.700439] 7fa0:                                     00000000 00000000 =
00000
[  494.709228] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000
[  494.717956] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  494.725097] INFO: task kworker/u2:2:35 blocked for more than 120 seconds.
[  494.732391]       Not tainted 5.0.0-rc1-00008-g29801984a0fa #1
[  494.738647] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this.
[  494.747039] kworker/u2:2    D    0    35      2 0x00000000
[  494.753021] Workqueue: events_unbound async_run_entry_fn
[  494.758819] [<c0829b1c>] (__schedule) from [<c0829ca4>] (schedule+0x98/0=
xb0)
[  494.766265] [<c0829ca4>] (schedule) from [<c082a0f0>] (schedule_preempt_=
disa)
[  494.775177] [<c082a0f0>] (schedule_preempt_disabled) from [<c082b7d4>] (=
__mu)
[  494.784698] [<c082b7d4>] (__mutex_lock) from [<c082b934>] (mutex_lock_ne=
sted)
[  494.793304] [<c082b934>] (mutex_lock_nested) from [<c0532474>] (tty_buff=
er_f)
[  494.802276] [<c0532474>] (tty_buffer_flush) from [<c0531478>] (tty_ldisc=
_flu)
[  494.811065] [<c0531478>] (tty_ldisc_flush) from [<c0533060>] (tty_port_c=
lose)
[  494.820373] [<c0533060>] (tty_port_close_start) from [<c0533080>] (tty_p=
ort_)
[  494.829437] [<c0533080>] (tty_port_close) from [<c054c8d8>] (ttyport_clo=
se+0)
[  494.837799] [<c054c8d8>] (ttyport_close) from [<bf033618>] (sirf_set_act=
ive+)
[  494.847595] [<bf033618>] (sirf_set_active [gnss_sirf]) from [<bf033784>]=
 (si)
[  494.858825] [<bf033784>] (sirf_runtime_resume [gnss_sirf]) from [<c056d9=
8c>])
[  494.869018] [<c056d98c>] (__rpm_callback) from [<c056db60>] (rpm_callbac=
k+0x)
[  494.877288] [<c056db60>] (rpm_callback) from [<c056d7e8>] (rpm_resume+0x=
58c/)
[  494.885437] [<c056d7e8>] (rpm_resume) from [<c056d940>] (__pm_runtime_re=
sume)
[  494.894073] [<c056d940>] (__pm_runtime_resume) from [<bf0332cc>] (sirf_p=
robe)
[  494.903961] [<bf0332cc>] (sirf_probe [gnss_sirf]) from [<c054c1b4>] (ser=
dev_)
[  494.913391] [<c054c1b4>] (serdev_drv_probe) from [<c0562a60>] (really_pr=
obe+)
[  494.922119] [<c0562a60>] (really_probe) from [<c0562dbc>] (driver_probe_=
devi)
[  494.931121] [<c0562dbc>] (driver_probe_device) from [<c0562e6c>] (__driv=
er_a)
[  494.940185] [<c0562e6c>] (__driver_attach) from [<c056104c>] (bus_for_ea=
ch_d)
[  494.948974] [<c056104c>] (bus_for_each_dev) from [<c0154db4>] (async_run=
_ent)
[  494.958007] [<c0154db4>] (async_run_entry_fn) from [<c014ae08>] (process=
_one)
[  494.967254] [<c014ae08>] (process_one_work) from [<c014c300>] (worker_th=
read)
[  494.976104] [<c014c300>] (worker_thread) from [<c01515f0>] (kthread+0x13=
c/0x)
[  494.984069] [<c01515f0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14=
/0x2)
[  494.991851] Exception stack(0xeea7ffb0 to 0xeea7fff8)
[  494.997314] ffa0:                                     00000000 00000000 =
00000
[  495.006134] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000
[  495.014892] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  495.022064] INFO: task modprobe:1100 blocked for more than 120 seconds.
[  495.029174]       Not tainted 5.0.0-rc1-00008-g29801984a0fa #1
[  495.035430] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this.
[  495.043853] modprobe        D    0  1100   1090 0x00000000
[  495.049835] [<c0829b1c>] (__schedule) from [<c0829ca4>] (schedule+0x98/0=
xb0)
[  495.057342] [<c0829ca4>] (schedule) from [<c0155124>] (async_synchronize=
_coo)
[  495.066955] [<c0155124>] (async_synchronize_cookie_domain) from [<c01d01=
48>])
[  495.077117] [<c01d0148>] (do_init_module) from [<c01cedcc>] (load_module=
+0x1)
[  495.085693] [<c01cedcc>] (load_module) from [<c01cf69c>] (sys_finit_modu=
le+0)
[  495.094116] [<c01cf69c>] (sys_finit_module) from [<c0101000>] (ret_fast_=
sysc)
[  495.102874] Exception stack(0xedc6bfa8 to 0xedc6bff0)
[  495.108306] bfa0:                   00497b00 004aabb0 00000004 00496e80 =
00000
[  495.117095] bfc0: 00497b00 004aabb0 14840a00 0000017b 00040000 00000000 =
00000
[  495.125885] bfe0: be9fea48 be9fea38 0048d6c3 b6f3aa42
[  495.131378] INFO: lockdep is turned off.
[  617.440093] INFO: task kworker/u2:1:16 blocked for more than 120 seconds.
[  617.447479]       Not tainted 5.0.0-rc1-00008-g29801984a0fa #1
[  617.454589] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this.
[  617.463348] kworker/u2:1    D    0    16      2 0x00000000
[  617.471923] Workqueue: events_unbound flush_to_ldisc
[  617.477325] [<c0829b1c>] (__schedule) from [<c0829ca4>] (schedule+0x98/0=
xb0)
[  617.484954] [<c0829ca4>] (schedule) from [<c082a0f0>] (schedule_preempt_=
disa)
[  617.493927] [<c082a0f0>] (schedule_preempt_disabled) from [<c082b7d4>] (=
__mu)
[  617.503448] [<c082b7d4>] (__mutex_lock) from [<c082b934>] (mutex_lock_ne=
sted)
[  617.512054] [<c082b934>] (mutex_lock_nested) from [<bf0330d0>] (sirf_rec=
eive)
[  617.522155] [<bf0330d0>] (sirf_receive_buf [gnss_sirf]) from [<c054c63c>=
] (t)
[  617.532409] [<c054c63c>] (ttyport_receive_buf) from [<c0532260>] (flush_=
to_l)
[  617.541381] [<c0532260>] (flush_to_ldisc) from [<c014ae08>] (process_one=
_wor)
[  617.550262] [<c014ae08>] (process_one_work) from [<c014c300>] (worker_th=
read)
[  617.559020] [<c014c300>] (worker_thread) from [<c01515f0>] (kthread+0x13=
c/0x)
[  617.566925] [<c01515f0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14=
/0x2)
[  617.574707] Exception stack(0xeea17fb0 to 0xeea17ff8)
[  617.580230] 7fa0:                                     00000000 00000000 =
00000
[  617.588989] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000
[  617.597686] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  617.604858] INFO: lockdep is turned off.

Regards,
Andreas

--Sig_/TluzXNe1aUWo3B.XKM=B_tS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlw7pJwACgkQfb1qx03i
kySxkw//XnDupoKheUgXzY+PvUAoryU1ff8pXZS8nfb5BDwjZhHfGhfjQjwm7TeO
gA2srPN6WlnyMBJxwkem/97q3N8XChrovaQdVTPOtT3Lpr+IBMKgdrYWS4V884SV
qa56bWAzd8NzOVWbMsMJmUyAOrx6kYIi9w/5qwUO1rNYQqhOY9HBrBdk3hGePw5K
m7nkMqT7xo/cyvaY8/mvGo4Ylm/L7Tax6XdYoYEYZoikc/eu0yItj/h2AFvLlwFT
1xUl5YA3BDHa1DgeWE90Cuh9XR7gy7x0C0ku5qPfl4JtscV/+OPgzaQAGZ5PkoNL
u4Y+K+9VV5+YkLBp54k6BWCyH5atIikZ11rsPXmQVhhVP7wi1gK0oQp1iIOD+p9Y
PWCgriPbKXHyckJVVww1aStYdRGm6L3OnT59NRXWaKNF74VcJ7FKfqZVZq5yHRRS
1JM0BPXjmjzbOeOUXDEQlh3WiYQIPM0sKmcAoCV/of9GOkEup3TEv3q2eVbIL3Tc
DoXxaY/n9ZUYKtrxJLZIpVAp6S4UGsymTWVIcZ/8+bmPR3brEDW8Y0bWeNNeJJG7
dtKa8/+faIumbdRriO7ipYUo8JXS4nS0I2p8OfmxP5BPpBjFpJcexxDFQ7i0yTuh
NeoaM63amLk3QPgDdqBmqkkniRkLgkIVvKaTuiIYSv5m9qRYpQw=
=DT8O
-----END PGP SIGNATURE-----

--Sig_/TluzXNe1aUWo3B.XKM=B_tS--
