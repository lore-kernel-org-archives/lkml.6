Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB10C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5FD23F44
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5FD23F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753993AbeGFOck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:32:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49076 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753804AbeGFOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:32:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 064F7278EF8
Date:   Fri, 6 Jul 2018 16:32:34 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Richard Hughes <rhughes@redhat.com>,
        Aaron Skomra <Aaron.Skomra@wacom.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: remove possible deadlock when unregistering
 power_supply
Message-ID: <20180706143234.dpge6enymaasx7ei@earth.universe>
References: <20180625075148.22140-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o5rntxnxfn4z2br2"
Content-Disposition: inline
In-Reply-To: <20180625075148.22140-1-benjamin.tissoires@redhat.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o5rntxnxfn4z2br2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 25, 2018 at 09:51:48AM +0200, Benjamin Tissoires wrote:
> If a device gets removed right after having registered a power_supply nod=
e,
> we might enter in a deadlock between the remove call (that has a lock on
> the parent device) and the deferred register work.
>=20
> Allow the deferred register work to exit without taking the lock when
> we are in the remove state.
>=20
> Stack trace on a Ubuntu 16.04:
>=20
> [16072.109121] INFO: task kworker/u16:2:1180 blocked for more than 120 se=
conds.
> [16072.109127]       Not tainted 4.13.0-41-generic #46~16.04.1-Ubuntu
> [16072.109129] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [16072.109132] kworker/u16:2   D    0  1180      2 0x80000000
> [16072.109142] Workqueue: events_power_efficient power_supply_deferred_re=
gister_work
> [16072.109144] Call Trace:
> [16072.109152]  __schedule+0x3d6/0x8b0
> [16072.109155]  schedule+0x36/0x80
> [16072.109158]  schedule_preempt_disabled+0xe/0x10
> [16072.109161]  __mutex_lock.isra.2+0x2ab/0x4e0
> [16072.109166]  __mutex_lock_slowpath+0x13/0x20
> [16072.109168]  ? __mutex_lock_slowpath+0x13/0x20
> [16072.109171]  mutex_lock+0x2f/0x40
> [16072.109174]  power_supply_deferred_register_work+0x2b/0x50
> [16072.109179]  process_one_work+0x15b/0x410
> [16072.109182]  worker_thread+0x4b/0x460
> [16072.109186]  kthread+0x10c/0x140
> [16072.109189]  ? process_one_work+0x410/0x410
> [16072.109191]  ? kthread_create_on_node+0x70/0x70
> [16072.109194]  ret_from_fork+0x35/0x40
> [16072.109199] INFO: task test:2257 blocked for more than 120 seconds.
> [16072.109202]       Not tainted 4.13.0-41-generic #46~16.04.1-Ubuntu
> [16072.109204] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [16072.109206] test            D    0  2257   2256 0x00000004
> [16072.109208] Call Trace:
> [16072.109211]  __schedule+0x3d6/0x8b0
> [16072.109215]  schedule+0x36/0x80
> [16072.109218]  schedule_timeout+0x1f3/0x360
> [16072.109221]  ? check_preempt_curr+0x5a/0xa0
> [16072.109224]  ? ttwu_do_wakeup+0x1e/0x150
> [16072.109227]  wait_for_completion+0xb4/0x140
> [16072.109230]  ? wait_for_completion+0xb4/0x140
> [16072.109233]  ? wake_up_q+0x70/0x70
> [16072.109236]  flush_work+0x129/0x1e0
> [16072.109240]  ? worker_detach_from_pool+0xb0/0xb0
> [16072.109243]  __cancel_work_timer+0x10f/0x190
> [16072.109247]  ? device_del+0x264/0x310
> [16072.109250]  ? __wake_up+0x44/0x50
> [16072.109253]  cancel_delayed_work_sync+0x13/0x20
> [16072.109257]  power_supply_unregister+0x37/0xb0
> [16072.109260]  devm_power_supply_release+0x11/0x20
> [16072.109263]  release_nodes+0x110/0x200
> [16072.109266]  devres_release_group+0x7c/0xb0
> [16072.109274]  wacom_remove+0xc2/0x110 [wacom]
> [16072.109279]  hid_device_remove+0x6e/0xd0 [hid]
> [16072.109284]  device_release_driver_internal+0x158/0x210
> [16072.109288]  device_release_driver+0x12/0x20
> [16072.109291]  bus_remove_device+0xec/0x160
> [16072.109293]  device_del+0x1de/0x310
> [16072.109298]  hid_destroy_device+0x27/0x60 [hid]
> [16072.109303]  usbhid_disconnect+0x51/0x70 [usbhid]
> [16072.109308]  usb_unbind_interface+0x77/0x270
> [16072.109311]  device_release_driver_internal+0x158/0x210
> [16072.109315]  device_release_driver+0x12/0x20
> [16072.109318]  usb_driver_release_interface+0x77/0x80
> [16072.109321]  proc_ioctl+0x20f/0x250
> [16072.109325]  usbdev_do_ioctl+0x57f/0x1140
> [16072.109327]  ? __wake_up+0x44/0x50
> [16072.109331]  usbdev_ioctl+0xe/0x20
> [16072.109336]  do_vfs_ioctl+0xa4/0x600
> [16072.109339]  ? vfs_write+0x15a/0x1b0
> [16072.109343]  SyS_ioctl+0x79/0x90
> [16072.109347]  entry_SYSCALL_64_fastpath+0x24/0xab
> [16072.109349] RIP: 0033:0x7f20da807f47
> [16072.109351] RSP: 002b:00007ffc422ae398 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
> [16072.109353] RAX: ffffffffffffffda RBX: 00000000010b8560 RCX: 00007f20d=
a807f47
> [16072.109355] RDX: 00007ffc422ae3a0 RSI: 00000000c0105512 RDI: 000000000=
0000009
> [16072.109356] RBP: 0000000000000000 R08: 00007ffc422ae3e0 R09: 000000000=
0000010
> [16072.109357] R10: 00000000000000a6 R11: 0000000000000246 R12: 000000000=
0000000
> [16072.109359] R13: 00000000010b8560 R14: 00007ffc422ae2e0 R15: 000000000=
0000000
>=20
> Reported-and-tested-by: Richard Hughes <rhughes@redhat.com>
> Tested-by: Aaron Skomra <Aaron.Skomra@wacom.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

Thanks, added Fixes: tag and queued to power-supply-fixes.

-- Sebastian

--o5rntxnxfn4z2br2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/fX4ACgkQ2O7X88g7
+poaPhAAl+j/TrAOMvgiZ/b9549sVzXw4MSo844NlhLkjEyJ/3YKmcWM6YKV2KAj
r2EtvbfkDDV+YwUf0gZt3H9v6rUo16aK7h91dPugPXMdQN+yYp7lap1iprvnsjDJ
cVXcfW5/GE8nuuHaicXgcepnqZu4uMNMuzYrMxhczL2k8UMZNQA23EU3wDi6yvU+
UdFW7P20COsnt9oV/HwEQYD+FIKf175sXPsrkXfqbCg2IpGXcDYu/XfeopWzp3WM
om0wz1Yr4jnuO9GM3+n1LgNVg27XhEkjBiJyZcaLx+11Juxa/LXuEMqE77S5Wy/G
Z+jtudYOn3linvVc2g08W2f4EBqmBEjHz6oKGfXafcx/SP8RDwM+eQbzl/gJEVAA
5czvb6dLvlItpvj5dwF6zSmH50d4AfzGDwbLKXAcbsItDNB3yvtlkfN4f0cE4czq
6uQ16ODI7JAmf1yV/MbS46NlHOiCFQWcIJuZ8sdHedj3Te/PT7PEthlBpDTX/DV5
xUeUegpIye7XJLigd/9j37lmpChDD2nx5TuCgsxwLAbjXeSniSSTbO7q85AdtPa5
brs+QRKDZn6YNn3TYfpNxoZ5EgI+hEj6EI3vh+bbeLuda/07UPhpHC8trvMQAOic
33FM2YAAr2WGrfmGANpvuv67zYKP1Fp1TdyO4QvJxXjybOqNME4=
=KcNO
-----END PGP SIGNATURE-----

--o5rntxnxfn4z2br2--
