Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D6BC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A9B2689F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A9B2689F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeF0Gct convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:32:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:19906 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751043AbeF0Gcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:32:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 23:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,278,1526367600"; 
   d="scan'208";a="61728299"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jun 2018 23:32:47 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 26 Jun 2018 23:32:46 -0700
Received: from orsmsx111.amr.corp.intel.com ([169.254.12.50]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.88]) with mapi id 14.03.0319.002;
 Tue, 26 Jun 2018 23:32:46 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     "Ye, Xiaolong" <xiaolong.ye@intel.com>
CC:     lkp <lkp@intel.com>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Laszlo Ersek <lersek@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, "Borislav Petkov" <bp@alien8.de>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        Dave Young <dyoung@redhat.com>
Subject: RE: [kbuild-all] [PATCH] efi: Free existing memory map before
 installing new memory map
Thread-Topic: [kbuild-all] [PATCH] efi: Free existing memory map before
 installing new memory map
Thread-Index: AQHUDPc2R4ZR/m4foUijQgjP6VqzEKRyU0IA///NwQCAAfNkgP//kdJg
Date:   Wed, 27 Jun 2018 06:32:46 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4605BA4E@ORSMSX111.amr.corp.intel.com>
References: <1529980892-11833-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <201806261053.B3CmI5Dm%fengguang.wu@intel.com>
 <FFF73D592F13FD46B8700F0A279B802F45FD1614@ORSMSX111.amr.corp.intel.com>
 <20180627060257.GD18756@yexl-desktop>
In-Reply-To: <20180627060257.GD18756@yexl-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTBmN2JkN2QtNTRiZi00ZjhiLWIwNWYtMzdiZWMxMjI1ZTcxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaUlpcFF6bDRwZkhmcEZZUWJNRkRHaHBGeTVObEg4b2NpaW5FYm5BdTc2UzQ5MXJWdzh0REhVNWU3bDdzS01PQSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >Since efi_memmap_free() is a recently introduced API [1], please note
> >that the patch is based on efi tree
> >@https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
> 
> I noticed the official efi tree recored in MAINTAINERS is
> git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/efi.git,
> are they identical?
> 
> EXTENSIBLE FIRMWARE INTERFACE (EFI)
> M:      Matt Fleming <matt@codeblueprint.co.uk>
> L:      linux-efi@vger.kernel.org
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/efi.git
> S:      Maintained
> F:      Documentation/efi-stub.txt
> F:      arch/ia64/kernel/efi.c
> F:      arch/x86/boot/compressed/eboot.[ch]
> F:      arch/x86/include/asm/efi.h
> F:      arch/x86/platform/efi/*
> F:      drivers/firmware/efi/*
> F:      include/linux/efi*.h

Hi Xiaolong,

Ard replaced Matt as EFI maintainer. Please see updated MAINTAINERS file for more details.
https://elixir.bootlin.com/linux/v4.18-rc2/source/MAINTAINERS

EXTENSIBLE FIRMWARE INTERFACE (EFI)
M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
L:	linux-efi@vger.kernel.org
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
S:	Maintained
F:	Documentation/efi-stub.txt
F:	arch/*/kernel/efi.c
F:	arch/x86/boot/compressed/eboot.[ch]
F:	arch/*/include/asm/efi.h
F:	arch/x86/platform/efi/
F:	drivers/firmware/efi/
F:	include/linux/efi*.h
F:	arch/arm/boot/compressed/efi-header.S
F:	arch/arm64/kernel/efi-entry.S

Regards,
Sai
