Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40050ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151BD2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151BD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeKDRAr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 12:00:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:51675 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeKDRAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 12:00:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 00:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,463,1534834800"; 
   d="scan'208";a="278165290"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga006.fm.intel.com with ESMTP; 04 Nov 2018 00:46:46 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 4 Nov 2018 00:46:45 -0700
Received: from hasmsx111.ger.corp.intel.com (10.184.198.39) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 4 Nov 2018 00:46:45 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.165]) by
 HASMSX111.ger.corp.intel.com ([169.254.5.130]) with mapi id 14.03.0415.000;
 Sun, 4 Nov 2018 09:46:43 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/8] Detach TPM space code out of the tpm_transmit() flow
Thread-Topic: [PATCH 0/8] Detach TPM space code out of the tpm_transmit()
 flow
Thread-Index: AQHUc5fWe3GmSbkLs0SOuvxQu50Zd6U/PYpA
Date:   Sun, 4 Nov 2018 07:46:43 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA10A2D@hasmsx108.ger.corp.intel.com>
References: <20181103170806.12177-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20181103170806.12177-1-jarkko.sakkinen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGFhNTg2NGYtNDQ5My00NjFmLTg2YmUtNDliY2UyN2VjMjA0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieUJyTmhhK1ZTWWZOWHlYa0tUUWhxRnhOTXhwUGU0aEVwWFwvaUdDRlZvUmVrWEswUXI5OTFVamJtXC9IelZqWDY4In0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 0/8] Detach TPM space code out of the tpm_transmit() flow

You forgot to version your posts this should be V2 in the subject, right?
Thanks
Tomas

 
> Make the changes that are needed to detach TPM space code from
> tpm_transmit() flow so that we do no longer need nested tpm_transmit()
> calls.
> 
> v2:
> * Print tpm2_commit_space() error inside tpm2_commit_space()
> * Error code was not printed when recv() callback failed. It is
>   fixed in this version.
> * Added a patch that removes @space from tpm_transmit().
> * Fixed a regression in earlier series. Forgot to amend the change
>   from the staging area that renames NESTED to UNLOCKED in tpm2-space.c.
> 
> Jarkko Sakkinen (8):
>   tpm: use tpm_buf in tpm_transmit_cmd() as the IO parameter
>   tpm: print tpm2_commit_space() error inside tpm2_commit_space()
>   tpm: clean up tpm_try_transmit() error handling flow
>   tpm: access command header through struct in  tpm_try_transmit()
>   tpm: move tpm_validate_commmand() to tpm2-space.c
>   tpm: encapsulate tpm_dev_transmit()
>   tpm: move TPM space code out of tpm_transmit()
>   tpm: remove @space from tpm_transmit()
> 
>  drivers/char/tpm/tpm-dev-common.c |  50 ++++++-  drivers/char/tpm/tpm-
> interface.c  | 240 +++++++++++-------------------
>  drivers/char/tpm/tpm-sysfs.c      |   5 +-
>  drivers/char/tpm/tpm.h            |  16 +-
>  drivers/char/tpm/tpm1-cmd.c       |  28 +---
>  drivers/char/tpm/tpm2-cmd.c       |  39 ++---
>  drivers/char/tpm/tpm2-space.c     |  77 +++++++---
>  drivers/char/tpm/tpm_vtpm_proxy.c |   3 +-
>  8 files changed, 220 insertions(+), 238 deletions(-)
> 
> --
> 2.19.1

