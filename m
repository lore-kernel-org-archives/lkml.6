Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F6B2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="IZAJMKT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F6B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeLKQbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:31:20 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:40113 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeLKQbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:31:20 -0500
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="25110756"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2018 09:31:18 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 09:31:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGJc1m8ob+qAdMY9v8rb1YLF1yoaKyztwWFQHRp+Hto=;
 b=IZAJMKT9uO6p0GxtTSDLFQF31AxUG53qoT7ykHy+XXu0JHAL8nTnbP8fTOcMcz+1OuDNBqfn1lsNgW5TmBY5HthOKYV1z0doXJfBMdom0uApNoFw6J7FaXUBTSfabyY5W/iIkpLRry2xyUPpHGvOE0xPzFkn75lHG7/tgnu0I5I=
Received: from BYAPR11MB3447.namprd11.prod.outlook.com (20.177.186.216) by
 BYAPR11MB3254.namprd11.prod.outlook.com (20.177.184.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Tue, 11 Dec 2018 16:31:16 +0000
Received: from BYAPR11MB3447.namprd11.prod.outlook.com
 ([fe80::e0e3:4983:d46d:994f]) by BYAPR11MB3447.namprd11.prod.outlook.com
 ([fe80::e0e3:4983:d46d:994f%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 16:31:16 +0000
From:   <Dave.Carroll@microchip.com>
To:     <arnd@arndb.de>, <aacraid@microsemi.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <RaghavaAditya.Renukunta@microsemi.com>,
        <prasad.munirathnam@microsemi.com>, <david.carroll@microsemi.com>,
        <dan.carpenter@oracle.com>, <jthumshirn@suse.de>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] scsi: aacraid: change wait_sem to a completion
Thread-Topic: [PATCH 1/2] scsi: aacraid: change wait_sem to a completion
Thread-Index: AQHUkNARC0C6ZNHW1UaW3ZDhMiOw+qV5vAnA
Date:   Tue, 11 Dec 2018 16:31:16 +0000
Message-ID: <BYAPR11MB34477897C0368503E427528588A60@BYAPR11MB3447.namprd11.prod.outlook.com>
References: <20181210213301.1065510-1-arnd@arndb.de>
In-Reply-To: <20181210213301.1065510-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Carroll@microchip.com; 
x-originating-ip: [204.94.163.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR11MB3254;6:IuL4mjJK8oFS4lKOG8pyP4OxvF/D9ghQ/sqeZfKXEvyUyGsK78RyJgP6OtoXUs5UXzSVf4e0D2tctQCyv9YlmDLHBhTL2eXCKNssDsaNUvFujHbm89srfwxD94PTb9HEEDBDgiSokfgRz/9+4xmnJHbRCdY2nGb5QmnCilQbGXN8kT0GfoVe+JNOEjtG2yLrwCZ1Cj5s1hu+H6iAw7ST91b7Tu9KMJxxW7kE4QF94p1cQbOx4Fm9wS7thP7y51hPxciiThYcZAkeGcI4qeIQWhlV+CmCryC0kTbT7a9widjFUN9XJmBUs0cW4O7k38wpsWlF6afAYw05gR2frkHDLHrOxN9M8BXn2LjLs1zYmSoIOdkWIYI+X/eshQk4be0J90rxJoGkkj8B6ISs1QJU2dBkbzj066glmJzz0r90gSf0F1Q2NkJlwkiOOTr2vnGQ569t9XJ7aeFF7sbu5Mhr4g==;5:neGd3+ZGTIiD1yHtNcDMQp9rZPVH/qZE5AoVCHQfAg5EH5b4nV7GNWGXFVuOAFV2sT1UCRpsX2Mpb/F8n3SXTrVlC3VVG3pQfqgZG/1HcHdXP4PjRdG6eiFTk/BX++NYo+DMZXMPmJYD9igdzFC8+eeO7QIvLnb+PFZOaQL3VUM=;7:ArW69YTuAaYRG5nfJkkGE0z0gCLtGHDsnTNTjPjX6FhVBjY5jeWfOT4gfhIo3IN+GQVD0rvHICPYTihgKwEsnPSz9KvKSrC4axU3DFWlO3MOXWczMG4o0pqkMlCkxnwDAoQoWWPVPWh6tnrafRb2DA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9097aef6-28ad-4549-383e-08d65f8612c9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR11MB3254;
x-ms-traffictypediagnostic: BYAPR11MB3254:
x-microsoft-antispam-prvs: <BYAPR11MB3254AB89F0C6607AFB8D720F88A60@BYAPR11MB3254.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231472)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR11MB3254;BCL:0;PCL:0;RULEID:;SRVR:BYAPR11MB3254;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(13464003)(199004)(189003)(476003)(71190400001)(99286004)(86362001)(71200400001)(305945005)(446003)(486006)(11346002)(110136005)(256004)(25786009)(2906002)(7736002)(54906003)(74316002)(68736007)(9686003)(72206003)(66066001)(316002)(186003)(8676002)(8936002)(229853002)(478600001)(14454004)(53936002)(106356001)(55016002)(6116002)(6246003)(6436002)(97736004)(81156014)(81166006)(105586002)(76176011)(4326008)(33656002)(26005)(6506007)(53546011)(7416002)(102836004)(5660300001)(3846002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3254;H:BYAPR11MB3447.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vWDgDJc4gXi1iBcc2swM2tBIX/ZUwOamB5h5VBj3Twp8ioa29EeKcr+BOEr+ashMDnsxTb4CR1YIUGLLzoLri3FRukBPe2RR25oTh+Z6p4O2dSshpMK6CwbpSVzhCO39A5sbRQxsVdJZxzZJ4MmOszkQurkAkE/fbtfyEdNRWSLwSFG3HWMG80rTnBaOoxWC/LARBbFwvoq/uHh5VoBmFQ0EwxtsL8wGzmafxA2RTf/pgrxZMcWnThBXbpxfalryS8eT6BCAUbnEr5xw9CIrAbe/sNht0T9zR/YL4oB94ZJ/XmAoTdAuuezxhrOhOUfw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9097aef6-28ad-4549-383e-08d65f8612c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 16:31:16.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3254
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-
> owner@vger.kernel.org] On Behalf Of Arnd Bergmann
> Sent: Monday, December 10, 2018 1:33 PM
> To: Adaptec OEM Raid Solutions <aacraid@microsemi.com>; James E.J.
> Bottomley <jejb@linux.ibm.com>; Martin K. Petersen
> <martin.petersen@oracle.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Raghava Aditya Renukunta
> <RaghavaAditya.Renukunta@microsemi.com>; Prasad B Munirathnam
> <prasad.munirathnam@microsemi.com>; Dave Carroll
> <david.carroll@microsemi.com>; Dan Carpenter
> <dan.carpenter@oracle.com>; Johannes Thumshirn <jthumshirn@suse.de>;
> linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 1/2] scsi: aacraid: change wait_sem to a completion
>=20
> The wait_sem member is used like a completion, so we should use the
> respective API. The behavior is unchanged.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
