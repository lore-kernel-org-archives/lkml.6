Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7634C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F0D206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F0D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeK2Hgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:36:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:60242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbeK2Hgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:36:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 999C3AD2C;
        Wed, 28 Nov 2018 20:18:32 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Howells <dhowells@redhat.com>
Date:   Thu, 29 Nov 2018 07:18:23 +1100
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fscache: fix race between enablement and dropping of object
In-Reply-To: <10285.1543417950@warthog.procyon.org.uk>
References: <87r2gd44hu.fsf@notabene.neil.brown.name> <10285.1543417950@warthog.procyon.org.uk>
Message-ID: <878t1dot0w.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Wed, Nov 28 2018, David Howells wrote:

> NeilBrown <neilb@suse.com> wrote:
>
>> It was observed that a process blocked indefintely in
>> __fscache_read_or_alloc_page(), waiting for FSCACHE_COOKIE_LOOKING_UP
>> to be cleared via fscache_wait_for_deferred_lookup().
>
> Was there a backtrace for that?

Yes.
PID: 29360  TASK: ffff881ff2ac0f80  CPU: 3   COMMAND: "zsh"
 #0 [ffff881ff43efbf8] schedule at ffffffff815e56f1
 #1 [ffff881ff43efc58] bit_wait at ffffffff815e64ed
 #2 [ffff881ff43efc68] __wait_on_bit at ffffffff815e61b8
 #3 [ffff881ff43efca0] out_of_line_wait_on_bit at ffffffff815e625e
 #4 [ffff881ff43efd08] fscache_wait_for_deferred_lookup at ffffffffa04f2e8f
[fscache]
 #5 [ffff881ff43efd18] __fscache_read_or_alloc_page at ffffffffa04f2ffe
[fscache]
 #6 [ffff881ff43efd58] __nfs_readpage_from_fscache at ffffffffa0679668 [nfs]
 #7 [ffff881ff43efd78] nfs_readpage at ffffffffa067092b [nfs]
 #8 [ffff881ff43efda0] generic_file_read_iter at ffffffff81187a73
 #9 [ffff881ff43efe50] nfs_file_read at ffffffffa066544b [nfs]
#10 [ffff881ff43efe70] __vfs_read at ffffffff811fc756
#11 [ffff881ff43efee8] vfs_read at ffffffff811fccfa
#12 [ffff881ff43eff18] sys_read at ffffffff811fda62
#13 [ffff881ff43eff50] entry_SYSCALL_64_fastpath at ffffffff815e986e

This is in SLES12-SP2 which is based on Linux-4.4

>
>> This leaves a window where something else can set FSCACHE_COOKIE_LOOKING_UP
>
> Attempting to enable the cookie again would have that effect.
>
>> There is some uncertainty in this analysis, but it seems to be fit the
>> observations.  Adding the wake in this patch will be handled correctly
>> by __fscache_read_or_alloc_page(), as it checks if ->backing_objects
>> is empty again, after waiting.
>
> That should work.  The read op should just then fail with -ENOBUFS, causing
> the netfs to issue the read over the network instead.
>
> I think there's a more elegant solution to be had, but it'll take some thought
> as to how to achieve it.

Please let me know when you come up with something.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlv++BEACgkQOeye3VZi
gbllvg/8ClneaZb2Z6t91/2nsysmvPrjyQf9sRFHDeP5YegsBVMuw7OfLgolii6W
y8Ty3IU5baQ00APyHGHGYeOpGio/bK9q9lNi9FjS0vAvVy6RMFfxYAuP9030oURH
J9RVnjR687w1S7MiA4S3zF3avfes1xwOK1ZF8XCvVW1hnTNXanYUVo8fOj2Y8rOC
j3B1Ol2L2aEOUKtInfnCZkiJz6nZyNOH23S8KE2BgP+Wjan+OkzPDHlR4Qtph33k
OE0NZdTzhzmlI2KCb9AqDHtCgKC/xBxLL0JOMXRVMdbXQKxFA4Y1YAmBjarBpkz6
FLkKHEseTYzJ4FYW/8WPtlbZxDVAAXmTdvXGh/jcCzpsboxHtMnc6tP8V0Y4VJFs
+4/TR+hrLiP2ixs013e8KIJXV56h1dL4ovMmhjgMk/dI4KohSh7fus3360s66lt0
q1pzO9dO1wpAr/asT2C65lp0u99Va3k/6+uxOcfXCiiFtBwiwzG1HyzXWpW30Vvn
nv6wSlELv+lY0pcCYZlpbsIjjjujrf01mLVg9mHOIK0lBAyZFAfqBjw9gS4YMmV5
vWLSJFKmKczDxTCElM1nrWWEGnpqkEWVLhxKR0BNims8u4L7jSj3xIM2pPs3770x
Q3dcZEYiyORVEH4l2ks+1XSwvxf/gsiUOEiMuYzo/4NB8j2l0oI=
=G0SK
-----END PGP SIGNATURE-----
--=-=-=--
