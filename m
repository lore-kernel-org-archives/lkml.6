Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76345C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB6D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Tb1Lbzy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB6D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeLKQ3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:29:45 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:34684 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeLKQ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:29:44 -0500
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="24241512"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2018 09:29:43 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 09:29:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OvGcfVQAPw38OfXECuiYdeqXNNyE+6zk9RNn7c8BFc=;
 b=Tb1Lbzy/10fR6blEuYTGg0hlLsxAYsmrwgCNbYx7672uUyMpm+QsVZ4CqZo7JY+KNZtcUjW9J1KZ4VHmmMr2cdKf/jyyqrciIZXAXkG54YtCQ4azXPLqJW5XFHA1seUjmEnfIfvb6fSnZ0t4X6OK3LPmfnOySI333Rybl9w7Mas=
Received: from BYAPR11MB3447.namprd11.prod.outlook.com (20.177.186.216) by
 BYAPR11MB3078.namprd11.prod.outlook.com (20.177.226.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Tue, 11 Dec 2018 16:29:41 +0000
Received: from BYAPR11MB3447.namprd11.prod.outlook.com
 ([fe80::e0e3:4983:d46d:994f]) by BYAPR11MB3447.namprd11.prod.outlook.com
 ([fe80::e0e3:4983:d46d:994f%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 16:29:41 +0000
From:   <Dave.Carroll@microchip.com>
To:     <arnd@arndb.de>, <aacraid@microsemi.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <RaghavaAditya.Renukunta@microsemi.com>,
        <prasad.munirathnam@microsemi.com>, <david.carroll@microsemi.com>,
        <dan.carpenter@oracle.com>, <jthumshirn@suse.de>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] scsi: aacraid: change event_wait to a completion
Thread-Topic: [PATCH 2/2] scsi: aacraid: change event_wait to a completion
Thread-Index: AQHUkNAPeQWPKH7BNEGPmaEtBR/DuaV5u42Q
Date:   Tue, 11 Dec 2018 16:29:41 +0000
Message-ID: <BYAPR11MB3447E4D0D93323738690993088A60@BYAPR11MB3447.namprd11.prod.outlook.com>
References: <20181210213301.1065510-1-arnd@arndb.de>
 <20181210213301.1065510-2-arnd@arndb.de>
In-Reply-To: <20181210213301.1065510-2-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Carroll@microchip.com; 
x-originating-ip: [204.94.163.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR11MB3078;6:RoRO5PPg3J1a43ATsuzWy2rOL65nRXaQGXmTTjbCSF5zDVwt2+tzrPdttGkFO+doWupIetdHhf2Ecz4BHgrauDfkFeAC38kEGnpJh1LxwK0aHdI1tQQXPkfrxS0D2ryNF1eyxacJr7xQtI3bl50vVZZSKwwctCztXE3Oa0P+fC3adlixAMBFQ1SBlSRSlF2n85VrFUMnPpU4liQxQ6XAfV263pQ1nOsxs9/rg9zdgLybJcPT8qGrfxEZQqOfvlNYUnVpsUrcq9PDt9NxMw+BZJNX4pScSsl9Grq740Gb6WR+nUYEt5o6sOyLZK5GI6ZvCZprLC2D04QdZ8tg/onkwPEroKHPgTIqE1tR8SxorcWiK5IjLSaYWR9VkJmVY35f+RvySQdUxCgEXo0v62nTHlBa8Bg4noqITWvyJYLuKrg1zT6ylDiEYjyyP+14OGtdmQDza5xUk71UGa1BN+KVdg==;5:z08a8VgsUE7/5KRMFmIQWyOjnYGMa0hc3YjvuyfjSBcAFMeEFYhQwmoTeIhPFuLyDq+THbK4PbQAQ2Wu2DPzltBS2bLuCBry6HpTch4ZkSP5Xgdoiibva0ZyD1vZazcYiRSwFGPxvGb2NL2Z2em3HaLf0HrqzGci9q7HtHEfWW0=;7:J4btlsvCnlFu83fUgvCFurSmh33pXfiU/Hw7Br//z70QS3cZdzgNsLaDQT+A47E6WKkDw4IJXUkM1jZ7DHQI+nsDLEqPRKD4uhb1g7hC3vCT4M3HIqO5r3eWcbkrK8vhmp/1xT8LeFuoZlGQb3jV9Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7f54ab5f-cc08-4598-4637-08d65f85da51
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR11MB3078;
x-ms-traffictypediagnostic: BYAPR11MB3078:
x-microsoft-antispam-prvs: <BYAPR11MB3078CAC84332ADBE5DD6DF8A88A60@BYAPR11MB3078.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR11MB3078;BCL:0;PCL:0;RULEID:;SRVR:BYAPR11MB3078;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(13464003)(199004)(189003)(99286004)(7696005)(76176011)(11346002)(74316002)(446003)(9686003)(305945005)(71200400001)(71190400001)(6436002)(2906002)(55016002)(33656002)(6246003)(53936002)(81156014)(8936002)(8676002)(81166006)(97736004)(3846002)(86362001)(6116002)(7736002)(5660300001)(316002)(66066001)(229853002)(110136005)(256004)(4326008)(68736007)(54906003)(106356001)(26005)(53546011)(25786009)(102836004)(478600001)(486006)(14454004)(186003)(7416002)(72206003)(6506007)(476003)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3078;H:BYAPR11MB3447.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /eYNYtutWTSJJkYeSJ1LUULsvhEv1yMEjAFmHcLxgbX5L2t0b8W8c/Jn4zJsEJGJDzbEozaH6amRJpOBYblmfNesSonF4w/vx3dUcQyCYhn5GceSNTNNm5lXBzepKiBrqQOD1l5arSdRdlCSN/nsioMBtgswgnidEpeT88MoIFfGKcWaPS88ebbfS32sTNn8PDVazFSu3w40TDKQnSa+YtfeE6qLSnmj1+TGFKHiQqvxAwQyBuK4Ja3H3ee9cqbAhIa60iCGy9kQuxErZMtJup4ad8l569QcU3OvGsmXT1P7TrWjobYrgDMzPYa1XOtD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f54ab5f-cc08-4598-4637-08d65f85da51
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 16:29:41.5833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3078
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
> Subject: [PATCH 2/2] scsi: aacraid: change event_wait to a completion
>=20
> The event_wait semaphore has completion semantics, so we can change it
> over to the completion interface for clarity without changing the behavio=
r.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
