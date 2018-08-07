Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CB7C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5599B215F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5599B215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeHHBgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:36:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:41576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726975AbeHHBgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:36:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56D23ADC0;
        Tue,  7 Aug 2018 23:20:11 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Date:   Wed, 08 Aug 2018 09:20:02 +1000
Subject: [PATCH] NFS: Use an appropriate work queue for direct-write completion
cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <878t5hydb1.fsf@notabene.neil.brown.name>
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


When a direct-write completes, a work_struct is schedule to handle
the completion.
When NFS is being used for swap, the direct write might be a swap-out,
so memory allocation can block until the write completes.
The work queue currently used is not WQ_MEM_RECLAIM, so tasks
can block waiting for memory - this leads to deadlock.

So use nfsiod_workqueue instead.  This will always have a running
thread, and work items should never block waiting for memory.

Signed-off-by: Neil Brown <neilb@suse.com>
=2D--
 fs/nfs/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 621c517b325c..aa12c3063bae 100644
=2D-- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -758,7 +758,7 @@ static void nfs_direct_write_schedule_work(struct work_=
struct *work)
=20
 static void nfs_direct_write_complete(struct nfs_direct_req *dreq)
 {
=2D	schedule_work(&dreq->work); /* Calls nfs_direct_write_schedule_work */
+	queue_work(nfsiod_workqueue, &dreq->work); /* Calls nfs_direct_write_sche=
dule_work */
 }
=20
 static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltqKSMACgkQOeye3VZi
gbnfBxAAsQmDECwLH6JuKN6lmOPVFoQR1odn1cLtQznviSUf8ekpz4eiKrSFKGaK
B+KdRxT9o/YGP5klcfzo6HqFT75tAo5Jo5ZE07zdc4txchm3OmbM8818fMbdcUA4
aJDtGpIsBHOACoUDEakXwUHjskRnSftR+Vbic7o3HWpy+NNwrjA8yaKRrBGKpmkK
BbsjlA2BOxt5Daad4zffbMSbrrR4nGE6vQg5FslKCmXp/StuxZyWYWbXac2+5QQJ
7mNdFXl0tKpU5LDLkwRUu4HbyONJjbtXTg4LGJN+k2W7i7HOY60cQMwF/JMcoa0e
a+UwPF7+MWWu4WVWqm8aeWR/YjzIYQePom/eZUloeqeV59049Q4anlLPxVbbS142
FZSlihq78dtaVfB2icZCZI9DmwmmJxZkxlQE0roc3F+/KGFikiYOB2E3r4XLmECR
fcpr4QGurz/gE0NEqCKnC/VG9a7zh9U+nC0estqRp2oZXZL6XBpT9pnMOPsa/V1Y
J/yWjCpbj1DoKTZ5tTA0XUJGv8nZIwg4Oanu+8H0YdmlkmDNHUXL4ntSH/tsxv0s
rugLNayT3Q/hXW/ZIgQt1SWKPBYoAQAiSbUWD+kOnWnV2YqtCZLOZTryo1Djrmzx
woTLNpmhuQdMsAWewxKWP4r+KA9xzUBt5iwS5pPly6ZKAuuYB4o=
=ERjw
-----END PGP SIGNATURE-----
--=-=-=--
