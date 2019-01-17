Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EA6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F0820855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfAQHvc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:51:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:8737 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfAQHvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:51:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 23:51:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,488,1539673200"; 
   d="scan'208";a="119182678"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga003.jf.intel.com with ESMTP; 16 Jan 2019 23:51:31 -0800
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 16 Jan 2019 23:51:08 -0800
Received: from lcsmsx155.ger.corp.intel.com (10.186.165.233) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 16 Jan 2019 23:51:07 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.155]) by
 LCSMSX155.ger.corp.intel.com ([169.254.12.76]) with mapi id 14.03.0415.000;
 Thu, 17 Jan 2019 09:51:05 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
Subject: RE: [PATCH] scsi: ufs: revamp string descriptor reading
Thread-Topic: [PATCH] scsi: ufs: revamp string descriptor reading
Thread-Index: AQHUkToXZ68GRbLa4ESXHC/L0gTpRaV5llCAgAOL1XCAI5V+oA==
Date:   Thu, 17 Jan 2019 07:51:04 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA7C91D@hasmsx108.ger.corp.intel.com>
References: <20181211110705.11646-1-tomas.winkler@intel.com>
 <DM6PR04MB4923D16D47784A1750811A19FCA60@DM6PR04MB4923.namprd04.prod.outlook.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA525B5@hasmsx108.ger.corp.intel.com>
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA525B5@hasmsx108.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzBlNTBjOTctYWU1Yy00OWE3LWFjOGEtZjUxMjBjNDRhMWQwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQmlGZzZzMzRnV1MzSzhtYm1OUmliR0xlc0ZoVWpVUmdocEdEcXVlQ3hWQ250dE1zZVVxTTJvVTBsTWd4XC9qaUsifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.126.93]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hello Tomas,
> >
> > >
> > > Define new a type: uc_string_id for easier string handling and less
> > > casting. Reduce number or string copies in price of a dynamic
> > > allocation.
> > >
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Tested-by: Avri Altman <avri.altman@wdc.com>
> >
> > Just one nit - doesn't really matters.
> >
> > Cheers,
> > Avri
> >
> > > ---
> > >  drivers/scsi/ufs/ufs-sysfs.c |  20 ++---
> > >  drivers/scsi/ufs/ufs.h       |   2 +-
> > >  drivers/scsi/ufs/ufshcd.c    | 164 +++++++++++++++++++++--------------
> > >  drivers/scsi/ufs/ufshcd.h    |   9 +-
> > >  4 files changed, 115 insertions(+), 80 deletions(-)
> >
> >
> > >
> > >  	ufs_fixup_device_setup(hba, &card);
> > > +	ufs_put_device_desc(&card);
> > ufs_get_device_desc() and ufs_put_device_desc() actually serves the
> > quirks setup.
> > Make sense to call it from within so the logic is clear and in one place.
> > Might also save ufs_put_device_desc().
> 
> You are right from the current perspective , just I'd need it also for the RPMB
> patches that should follow, then it will have bit larger span than the quirks.
> 

Is this okay, can we merge?
Thanks
Tomas

