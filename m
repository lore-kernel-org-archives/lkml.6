Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB879C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3979218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfBGQlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:41:19 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:54605 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGQlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:41:19 -0500
Received: from orion.localdomain ([77.2.6.87]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MuUza-1hA04p1hfm-00rULW; Thu, 07 Feb 2019 17:41:13 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, kernel-janitors@vger.kernel.org,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net
Subject: RFC: refactoring the deb build
Date:   Thu,  7 Feb 2019 17:40:55 +0100
Message-Id: <1549557659-19137-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:BO8Oml1s/BStYvQB3cgiVFSgPr9LkQ6nH8tulm8K5QWHWk2O0My
 n/AyqhLIMMkAwYilYX+zoC/kedbpGiVs37xmO/DyFskvfdJhSplhpYdmhtP5HtXopkxvR6D
 nfewISEqhOGWjko7x/hL5uM+Nx7HBkJ5Mbk7uM6pJEXAYfblqHEyJaHeeusmw/M3ORnljfw
 JeY3stKPRIbnpV4GodVog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XUJ4ERUZ5BM=:FStTOPzVj8R/7J+1MQbcDY
 87uPfSXadzdsCOAheHZ6NM/QGaWU6A3wtQE1wX4fkoW+UCv9UpHi7QbxYKliVHpRCc5ekwvnp
 bFK/DOEaPEDhPZpGA1qZL4pJIvN8gihdBoohn13Q7GhYyylRAkpMRScU+JHkMnAPbT1BCcUvr
 EhdsZAx1E1g8fhJ7V2ICApPh/Dmo/6r570qSkME2lkOVGdIgI2QvZtVNPwAEKc4L6DuAKkCC6
 n13fKZDxh23+GNSXE2ag3PU2PgSu0DPotPIa2OhOfgUSZCTSRRByTTNLzklOMZno31sLn1Rwk
 YMi/1GaMBTIAVrmUPVZeXTHnEok54hkE+vS3pIczNw3/WM0gQBX/xLQFMwxBL2LBLKY0jGsOv
 mT1teauUJRpXTVqOnRKwsaI6At6tclR6k8Tl3sXDEUoAgbfokTAjGN/Bnz49mi+ojeMomrLZF
 hFkpLkEP3vX37Wv+S7sKJnEOjowPcw2UOT5lXFa4UYIU0euvR+2IcoRr0X/pxWiS1phqr67Aw
 MxQ7NY9rvYDI/674KmpxJpdqQJK6pz4P+AwimnW42i5jWPMpqfzhTjMqjGl2TsPTyXs8Jje2Y
 4iNyPXel8APMFOrVmtxcxB0YUQ0W1BI4EatkP4hZdonNii2kmpZPBS/Ar0K2gizYDd2LFs+8W
 kGQrEz340Y4VuJFvyOTL3+bfEf3ifkqw+Xx42knPmEolt5tEeZBC/mf52Rtw3fEXYiCjn8WGz
 IZe99/ggQ8o267O9HVWi+b6mH4jKWzIdHteIxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,


here are some patches for build process that allow building debian packages
right the usual canonical way (eg. via dpkg-buildpackage or dck-buildpackage),
instead 'manually' setting up the build environment and calling make.
So, from a debian native perspective, turning it from head onto feet ;-)

dpkg-buildpackage + friends expect the debian/rules file being present in
the unpacked source tree and driving the actual build (the 'deb-pkg' make
target does that quite the opposite way). Obviously, 'make deb-pkg' can't
be used directly, as it would destroy our debian/rules file ...

To archieve this, I've done several things:

* place .config file to the source tree (not in this patch queue)
* add some helper targets to the toplevel makefile, so we can just ask
  for certain things, eg. version, arch, etc, that we need later
* fix some missing dependencies in the generated debian/control file
* change scripts/package/mkdebian so that the name of the generated rules
  file name can be changed via environment
* a generic debian/rules file for driving the build

The last patch isn't really meant to be merged yet (need to change the
deb-pkg rule to not overwrite debian/rules anymore) - just including it
for illustration.

What do you think about this ?


--mtx

