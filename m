Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0A0C64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A746F20684
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A746F20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeJEJuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 05:50:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:49662 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727121AbeJEJup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 05:50:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99760AA7C;
        Fri,  5 Oct 2018 02:54:06 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Date:   Fri, 05 Oct 2018 12:53:57 +1000
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        paulmck@linux.vnet.ibm.com, Florian Weimer <fweimer@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH - resend] VFS: use synchronize_rcu_expedited() in namespace_unlock()
In-Reply-To: <20181005014002.GS32577@ZenIV.linux.org.uk>
References: <87y3nyd4pu.fsf@notabene.neil.brown.name> <20171026122743.GX3659@linux.vnet.ibm.com> <b8a1a898-850c-cc7a-2574-1bfd15cc9888@redhat.com> <20171127144125.GF3624@linux.vnet.ibm.com> <87induxd3u.fsf@notabene.neil.brown.name> <87tvm1rxme.fsf@notabene.neil.brown.name> <20181005014002.GS32577@ZenIV.linux.org.uk>
Message-ID: <87r2h5rtmi.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05 2018, Al Viro wrote:

> On Fri, Oct 05, 2018 at 11:27:37AM +1000, NeilBrown wrote:
>>=20
>> The synchronize_rcu() in namespace_unlock() is called every time
>> a filesystem is unmounted.  If a great many filesystems are mounted,
>> this can cause a noticable slow-down in, for example, system shutdown.
>>=20
>> The sequence:
>>   mkdir -p /tmp/Mtest/{0..5000}
>>   time for i in /tmp/Mtest/*; do mount -t tmpfs tmpfs $i ; done
>>   time umount /tmp/Mtest/*
>>=20
>> on a 4-cpu VM can report 8 seconds to mount the tmpfs filesystems, and
>> 100 seconds to unmount them.
>>=20
>> Boot the same VM with 1 CPU and it takes 18 seconds to mount the
>> tmpfs filesystems, but only 36 to unmount.
>>=20
>> If we change the synchronize_rcu() to synchronize_rcu_expedited()
>> the umount time on a 4-cpu VM drop to 0.6 seconds
>>=20
>> I think this 200-fold speed up is worth the slightly high system
>> impact of using synchronize_rcu_expedited().
>>=20
>> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com> (from general rc=
u perspective)
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>=20
>> I posted this last October, then again last November (cc:ing Linus)
>> Paul is happy enough with it, but no other response.
>> I'm hoping it can get applied this time....
>
> Umm...  IIRC, the last one got sidetracked on the other thing in the seri=
es...
> <checks> that was s_anon stuff.  I can live with this one; FWIW, what kind
> of load would trigger the impact of the change?  Paul?

I think you would need a long sequence of umounts to notice anything.
What you would notice is substantially reduced wall-clock time, but
slightly increased CPU time.

The original bug report that lead to this patch was a system with "HUGE
direct automount maps (>23k at this point)".
Stopping autofs (during shutdown) took more minutes than seemed
reasonable.

I noticed it again just recently when working on a systemd issue.  If
you mount thousands of filesystems in quick succession (ClearCase can do
this), systemd processes /proc/self/mountinfo constantly and slows down
the whole process.  When I unmount my test filesystems (mount --bind
/etc /MNT/$1) it takes a similar amount of time, but now it isn't
systemd slowing things down (which is odd actually, I wonder why systemd
didn't notice..) but rather the synchronize_rcu() delays.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlu20kYACgkQOeye3VZi
gbltrg/9GPYC7nNueBBXyCZkKgzcc7aFiiV/czi15zPNrtI/G88+7dUY89ktnJ0J
nVQlQM+6GahsyDdUiz2UBPcmLwP2GEFUYlSKi9RR2jk1avhRtVpw1PQEmD6c1nke
aagZeVaGOrBmHL6Dn4u0Czt040gMAPPrjxxnA2wKzDdwpTVSv5e6DOAVAHnHPoMc
mkRMhpMRuJanZD9OQVr2dR1lkNz3nKh9PIhcTGg9T7OWZVXyc0z68S0y9f5FNnDC
7o0JICRvhH9RNggl3oXB0n4bD3GPg5lfvDWcDG6qx4MGnJnCp2Y6WwSKkJw6c3em
RTVi3dHsl5ioaRoYhAERzMxTO3v2yh2FLgGUUayIaxoPmKByKTKwqzWSL+e97xRU
ZENyd/qzhugCW443vtgNexDNeIp7A2sIcJFmdqlvqgFHa2g7qtEDvF0jIiLEhPnP
njInN49C/RLR4lybeo2QeYJqxikQS8tRuTzvxRtL3dkxnSRTINNjV3W+HlR6aUgI
PrMATbSSsnZGHKOUOlJtOipdcLQEL8FJP9Gn6POEfMo9Id6JOIHuiA9iIQKFsvRR
s2T5jQY3t200twmJcF113xpGzZggZDhl4YaILCYUypB25xgwMczNYdsVrQX07q8F
wPqLBXdY3EzeHt44jlTTriMG98hBOKQ4ZJtpElrcPkSvLuU5bJo=
=iZ89
-----END PGP SIGNATURE-----
--=-=-=--
