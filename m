Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48384C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078C320851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078C320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeLMUbZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:31:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:45390 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbeLMUbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:31:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2018 12:31:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; 
   d="scan'208";a="129746197"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2018 12:31:24 -0800
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 13 Dec 2018 12:31:23 -0800
Received: from hasmsx112.ger.corp.intel.com (10.184.198.40) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 13 Dec 2018 12:31:23 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.61]) by
 HASMSX112.ger.corp.intel.com ([169.254.11.88]) with mapi id 14.03.0415.000;
 Thu, 13 Dec 2018 22:31:20 +0200
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: revamp string descriptor reading
Thread-Topic: [PATCH] scsi: ufs: revamp string descriptor reading
Thread-Index: AQHUkToXZ68GRbLa4ESXHC/L0gTpRaV5llCAgAOL1XA=
Date:   Thu, 13 Dec 2018 20:31:19 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA525B5@hasmsx108.ger.corp.intel.com>
References: <20181211110705.11646-1-tomas.winkler@intel.com>
 <DM6PR04MB4923D16D47784A1750811A19FCA60@DM6PR04MB4923.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB4923D16D47784A1750811A19FCA60@DM6PR04MB4923.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzBlNTBjOTctYWU1Yy00OWE3LWFjOGEtZjUxMjBjNDRhMWQwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQmlGZzZzMzRnV1MzSzhtYm1OUmliR0xlc0ZoVWpVUmdocEdEcXVlQ3hWQ250dE1zZVVxTTJvVTBsTWd4XC9qaUsifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.249.91.43]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Avri Altman [mailto:Avri.Altman@wdc.com]
> Sent: Tuesday, December 11, 2018 18:18
> To: Winkler, Tomas <tomas.winkler@intel.com>; James E . J . Bottomley
> <jejb@linux.vnet.ibm.com>; Martin K . Petersen
> <martin.petersen@oracle.com>; Vinayak Holikatti <vinholikatti@gmail.com>;
> Hunter, Adrian <adrian.hunter@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>; Vivek Gautam
> <vivek.gautam@codeaurora.org>; Subhash Jadavani
> <subhashj@codeaurora.org>; Alex Lemberg <Alex.Lemberg@wdc.com>; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] scsi: ufs: revamp string descriptor reading
> 
> Hello Tomas,
> 
> >
> > Define new a type: uc_string_id for easier string handling and less
> > casting. Reduce number or string copies in price of a dynamic
> > allocation.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Tested-by: Avri Altman <avri.altman@wdc.com>
> 
> Just one nit - doesn't really matters.
> 
> Cheers,
> Avri
> 
> > ---
> >  drivers/scsi/ufs/ufs-sysfs.c |  20 ++---
> >  drivers/scsi/ufs/ufs.h       |   2 +-
> >  drivers/scsi/ufs/ufshcd.c    | 164 +++++++++++++++++++++--------------
> >  drivers/scsi/ufs/ufshcd.h    |   9 +-
> >  4 files changed, 115 insertions(+), 80 deletions(-)
> 
> 
> >
> >  	ufs_fixup_device_setup(hba, &card);
> > +	ufs_put_device_desc(&card);
> ufs_get_device_desc() and ufs_put_device_desc() actually serves the quirks
> setup.
> Make sense to call it from within so the logic is clear and in one place.
> Might also save ufs_put_device_desc().

You are right from the current perspective , just I'd need it also for the RPMB  patches that should follow,  
then it will have bit larger span than the quirks.

Thanks
Tomas
 
 
