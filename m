Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47388C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E2E2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lhHiMULw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E2E2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJYAG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:06:27 -0400
Received: from mail-by2nam01on0138.outbound.protection.outlook.com ([104.47.34.138]:61216
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbeJYAG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHeShF7mJvxdIJ8GpE27QRvPi7AApvB1ZdPv8ZeqvqI=;
 b=lhHiMULw1Dzg2AphNcwhGwsX1t01qfAdNAjPBpJ/+kasZPxlqcmzPRIsG3njrxaxTx/zs4q5SSvZtv82Pk5ArpW4do8uMlruz4Y4EIyjbTXJQvFqQ0p7gbNKOGeSzfobo8SmaDHoTO2kFk8twSjwzNz+IdjNUcWQVQ89L2pv8aE=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.3; Wed, 24 Oct 2018 15:37:50 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb%8]) with mapi id 15.20.1294.001; Wed, 24 Oct 2018
 15:37:50 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
CC:     Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: RE: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression caused
 by incorrect clean-up
Thread-Topic: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression
 caused by incorrect clean-up
Thread-Index: AQHUZqDqbasvay7PwkmlHkiKerM2nqUukUpw
Date:   Wed, 24 Oct 2018 15:37:49 +0000
Message-ID: <CY4PR21MB077329FE239A11054FFDD661D7F60@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181018050835.27828-1-kys@linuxonhyperv.com>
 <20181018050932.27932-1-kys@linuxonhyperv.com>
 <20181018050932.27932-3-kys@linuxonhyperv.com>
In-Reply-To: <20181018050932.27932-3-kys@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-24T15:37:42.0398357Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [12.130.117.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:1at7VWaxrp7W0d8aZVdEAHFNbUBT0NYWmFTRiyfZ7SZ2mliazCAoq+lMM++g+dlvXcUbFHEbbCHM70Seg1LfmMUV+6dT0uuAVuAdmRa6hIMv4ztWRj3PDKAENaszVM3s7o0Bn2iq2qCDBEfltmMuXUZs1GZw4V28W6QSoWsWKCB9Bni/PukRnNCil2snMEi1soN530TDSzSKd1isF8y/rSgvVbRVkhOu6EN/EwHPHV4DZ87CTg2eIZz/nnDEYwPq68Ytan62BVnEJ4iHRvXLkknQzEQrpA9f6daiPooWntkzWOKsjGP1pSMa4cnxuN2d+q2m+r2Vv98MDzqmJPY5Xn8I6PUNa2BTy1Ti+QarsnnFQ8RguJ5nrGhQzWC15Gj49ae4nqkcYwWuS2g2FhCyBmT+98jOfvL7oJJQ4A/oU8dSjys0Dw3wKagaBoI5Fp1lcVNExwvlty8zqb0GjYf2uw==;5:kAD0WUsRfCor/E8/sD1442SCFkwzOyWupcgRvGYH1yr8z0CzuU/XdoDjm02/Iylo83pizuqoE1gw1Jh8Nr/kQe89baE+9Crg9uFnkzwMH+o3K+hjLCJKLbXRVuGlInpwMPm0WhOAl6wf45tvpY7mkQaK4Zifnw5j+OlLK2VAiBQ=;7:yaOyeicFacIUzOGqMdOv8Gb2qGE6/CPypGWB788iX8/5W6AUCFGpowKOgAvjU9LKy9P3Ukxt/pfkdm1x19Yp0SfzPSM0sZOSRc71l1BaEtTW3rizOjCyU5gnPVsCLmvpyKTiU0Wen3WfVG+LVGJIgw==
x-ms-office365-filtering-correlation-id: 9e0c50cd-398d-4cbc-3aeb-08d639c6a7c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB08371CCFBB98A5957D3D7153D7F60@CY4PR21MB0837.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220027)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0837;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0837;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(105586002)(106356001)(102836004)(8936002)(446003)(11346002)(68736007)(97736004)(476003)(110136005)(55016002)(9686003)(486006)(2201001)(6346003)(8676002)(81156014)(81166006)(26005)(22452003)(316002)(86362001)(186003)(71190400001)(71200400001)(5250100002)(2501003)(86612001)(5660300001)(256004)(305945005)(74316002)(7736002)(10090500001)(2900100001)(1511001)(7696005)(8990500004)(229853002)(6506007)(33656002)(4326008)(6436002)(53936002)(76176011)(54906003)(25786009)(66066001)(3846002)(6246003)(6116002)(2906002)(478600001)(99286004)(14454004)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-message-info: MXHyZQHrguRTwVgnFvcpXakgppcmR2GwpEozQOppYMkGXvSbFppMLiWJz360LxkIP93UgZhGz/gtRv/JaF8F1KkrW4uh2V8g3ldXaoNdvyDJmCJg3BOdLDfvSbgQk2lOf0MRU8LGbwKo41swAN1uBR3VHfLcQBagGzBQzM/B3oNIRtoy2AzXAdx53Ym6v2nUs83SX02FuGUSxXyjvHV5bZFbw0/7L6W50tLIkEUy9e6Zcc8paew5hfIrqrLlKmXWYJ9ZVoolwLNCHdTCXoAHcUaxIdQeNftpPvipx9YPXbm6hb/ASBX9rrKt1rJotfgJQtqegvChz8Gz0oxPjGIFQJiFDZNVdmEiZ9V7MowwxCs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0c50cd-398d-4cbc-3aeb-08d639c6a7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 15:37:49.9147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>  Sent: Wednesday, Octob=
er 17, 2018 10:10 PM
> From: Dexuan Cui <decui@microsoft.com>
>=20
> In kvp_send_key(), we do need call process_ib_ipinfo() if
> message->kvp_hdr.operation is KVP_OP_GET_IP_INFO, because it turns out
> the userland hv_kvp_daemon needs the info of operation, adapter_id and
> addr_family. With the incorrect fc62c3b1977d, the host can't get the
> VM's IP via KVP.
>=20
> And, fc62c3b1977d added a "break;", but actually forgot to initialize
> the key_size/value in the case of KVP_OP_SET, so the default key_size of
> 0 is passed to the kvp daemon, and the pool files
> /var/lib/hyperv/.kvp_pool_* can't be updated.
>=20
> This patch effectively rolls back the previous fc62c3b1977d, and
> correctly fixes the "this statement may fall through" warnings.
>=20
> This patch is tested on WS 2012 R2 and 2016.
>=20
> Fixes: fc62c3b1977d ("Drivers: hv: kvp: Fix two "this statement may fall =
through" warnings")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/hv/hv_kvp.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>=20
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
