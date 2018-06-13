Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 33A86C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5892087E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5892087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935816AbeFMW3m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:29:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:60145 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935256AbeFMW3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:29:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4362EADCC;
        Wed, 13 Jun 2018 22:29:40 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     James Simmons <jsimmons@infradead.org>
Date:   Thu, 14 Jun 2018 08:29:28 +1000
Cc:     Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>,
        Doug Oucharek <dougso@me.com>,
        Amir Shehata <amir.shehata@intel.com>
Subject: Re: [PATCH v2 01/25] staging: lustre: libcfs: restore UMP handling
In-Reply-To: <alpine.LFD.2.21.1806132248500.12664@casper.infradead.org>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org> <1527603725-30560-2-git-send-email-jsimmons@infradead.org> <87muwiuiuz.fsf@notabene.neil.brown.name> <alpine.LFD.2.21.1806132248500.12664@casper.infradead.org>
Message-ID: <87h8m6ialz.fsf@notabene.neil.brown.name>
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

On Wed, Jun 13 2018, James Simmons wrote:

>> > With the cleanup of the libcfs SMP handling all UMP handling
>> > was removed. In the process now various NULL pointers and
>> > empty fields are return in the UMP case which causes lustre
>> > to crash hard. Restore the proper UMP handling so Lustre can
>> > properly function.
>>=20
>> Can't we just get lustre to handle the NULL pointer?
>> Is most cases, the pointer is accessed through an accessor function, and
>> on !CONFIG_SMP, that can be a static inline that doesn't even look at
>> the pointer.
>
> Lots of NULL pointer checks for a structure allocated at libcfs module=20
> start and only cleaned up at libcfs removal is not a clean approach.
> So I have thought about it and I have to ask why allocate a global
> struct cfs_cpu_table. It could be made static and fill it in which would
> avoid the whole NULL pointer issue. Plus for the UMP case why allocate
> a new cfs_cpu_table with cfs_cpt_table_alloc() which is exactly like
> the default UMP cfs_cpu_table. Instead we could just return the pointer
> to the static default cfs_cpt_tab every time. We still have the NULL
> ctb_cpumask field to deal with. Does that sound like a better solution
> to you? Doug what do you think?

I'm not convinced there will be lots of NULL pointer checks - maybe one
or two.  Most the accesses to the structure are inside helper
functions which are empty inlines in the UP build.

However I don't object to a static cfs_cpt_tab if that turns out to make
some code simpler.   I would want it to be clear up-front which code was
simplified so that an informed decision could be made.

Thanks,
NeilBrown


>=20=20
>> I really think this is a step backwards.  If you can identify specific
>> problems caused by the current code, I'm sure we can fix them.
>>=20
>> >
>> > Signed-off-by: James Simmons <uja.ornl@yahoo.com>
>> > Signed-off-by: Amir Shehata <amir.shehata@intel.com>
>> > Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7734
>>=20
>> This bug doesn't seem to mention this patch at all
>>=20
>> > Reviewed-on: http://review.whamcloud.com/18916
>>=20
>> Nor does this review.
>
> Yeah its mutated so much from what is in the Intel tree.
> I do believe it was the last patch to touch this.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlshmskACgkQOeye3VZi
gbkCyw/8DHMh+/vX07Z8VbS+vKTIfYGW1lcLo9Q7cZ4/2PPf9CaEjs0TXxpqW2Kn
L4TPlbH5mAW+CNDEcwGW7BPO74nGFpVQ3k1gU1seJm5lf5zutytH0r7SqKZIO7dQ
QaiukvUoUdFboaJ5P2VCrzePbFP9MdM/jvDFAn3gmOYD68FmY9MD5u/tqk2vSLnF
qJTFsIX3/e/HWRfNPQzDXWVxsL7sJNVnurpxq/i4QtKvg4BawWYUeV9Ix3Kqxtn9
lBmCiIfHRa4nu9vPmYS2LJNHoPxujUkF7IyJLsU09yg1nJiolNf0/m4l4pPQTZ5C
UaVF639xTxbF5ZKT5FNgOIplOjADEpbIFZ6LdyAyySgPwMbjW3J2BCR0GNpOjHON
0MxXwJE6BRnLuPA/TtV5hv3MCQTFZCRba+Q/krnumL91XTX0M5EBmElXmpwgWT59
4srSRyUvkFNF853m6irGt4H6N14DFIIkINNYd1G7ZMOD8JTGAhnXqWPKlOnw0pjG
nSkmdUeBUbFTxGsTUd5OIKar0E5G0nbdpIMQGNMKOst3BE3jDUVzeyElIX9TSRVm
iyM5jvSW4Zp9Uloqr0cB4NRo4qidu4TGcHsSTstts9pWvrfDjKwCTXkNVgBPP1kM
Z5E6AsQag0nqdrX3P1K8289orzLvz+Ev2y5NLPYYOOGbJmFXNVA=
=tx9D
-----END PGP SIGNATURE-----
--=-=-=--
