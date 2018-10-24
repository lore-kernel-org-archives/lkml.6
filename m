Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D9EC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7C62075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bMeieu4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7C62075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeJXXcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:32:39 -0400
Received: from mail-eopbgr680110.outbound.protection.outlook.com ([40.107.68.110]:35003
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbeJXXcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKQMGyiLCVuGsDs0rYlNHFF8xj/GzfIrObJ5xe7snj4=;
 b=bMeieu4w7exoNoZ76mg5iGfIZyKZsLbuTtwdxj00KN7iMbB/o+KQqTNT4MOzMmqXY7X3ptsSYOQaFy8wMSX4Q8Tml7vmFziGHXNG20iaQseOMnRzfelQlHCm7+c3sSnv2jlzU3b3LooUf7SiWqp4fQfJFU3Wq+UpxlFkIAzzw6o=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0760.namprd21.prod.outlook.com (10.173.195.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1294.8; Wed, 24 Oct 2018 15:04:08 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb%8]) with mapi id 15.20.1294.001; Wed, 24 Oct 2018
 15:04:08 +0000
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
Subject: RE: [PATCH V2 1/5] Drivers: hv: vmbus: Get rid of unnecessary state
 in hv_context
Thread-Topic: [PATCH V2 1/5] Drivers: hv: vmbus: Get rid of unnecessary state
 in hv_context
Thread-Index: AQHUZqDovv3pKWswLUesnH4Ml/pRnKUuh/tQ
Date:   Wed, 24 Oct 2018 15:04:08 +0000
Message-ID: <CY4PR21MB07737F5CBF6C9F594A72B6A4D7F60@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181018050835.27828-1-kys@linuxonhyperv.com>
 <20181018050932.27932-1-kys@linuxonhyperv.com>
In-Reply-To: <20181018050932.27932-1-kys@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-24T15:04:02.6040268Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [12.130.117.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0760;6:8Bxu9N4LnRSdOLI3Zkl3cKhevzvC4aLebTmkzejXyMDp3z6lHdg4kA/c5027TsGk+Ba6Sy1RBjXP+CloQ6sltJRPFEuvGh3E9JoHxXCTJlwyVc0gznKKSHMj30w+lRKIBj3bUZIVBLfQF7JlGnDcO/UkXBtoDlBXx3JRNLXuEdPwhHPEEoRLxIMfCz15wcMBbWmnO6ywFJxguVOqk2rf0KeI/oMn+5e0lNtKN+00WfV6YO1J7dI3aQM3vnWaFvJ3bSyrN7oJFX7bX9JVu1hOZdcM5dLnrz5gQ16tOgVXoCIb4FdyS5fKOwh067/lvOsJuu2HrDnGU6/FfeMxil6OmEVcRvY71ggHVMM9NiIjjfADh0KTFjpWkE+bRBQ3WLPvw83qe/YMGKa110nIFDsSGdQkjNaHzVHlOEJSd38X/KVB2jIhMFd5Lc2gTTHOADxZNo2ZIDE2fmdZ/ma8PM48tg==;5:uUhEXkvwtv4wQyibWW9KZvSrvaztW2Hmg/NEV02aywBM03IXSrZWIRt+UZNNa3HBOij5vQ/Qn2ZId176vqk39nFUJinh1gu6aa1B3+/liZjx6oYrY60Leph+T2htB+VEz5H/hsnisLKqhZ3FB3Zc3PBYkoMY+pZnkLDFRct2AMo=;7:4pn75MN1lidkSGhOT6W9y5PEbhBUaKTws4+dgEHNSs4RAgkRaiFHPBsNmDEqVsn2ha7ca9EcutDWwagIG232778A/EZI5EpfOIK/24Sue8XmsxH0ZmV4WfOw79TwuQu7j748YB5c+OXWd4CnHNryvw==
x-ms-office365-filtering-correlation-id: a75cc786-ed21-4aae-d2b8-08d639c1f2c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0760;
x-ms-traffictypediagnostic: CY4PR21MB0760:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0760CA7A240A0FD489225263D7F60@CY4PR21MB0760.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220027)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0760;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0760;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(478600001)(22452003)(10290500003)(110136005)(316002)(8990500004)(186003)(3846002)(6116002)(229853002)(14454004)(99286004)(5660300001)(2906002)(486006)(33656002)(6506007)(2201001)(86612001)(86362001)(446003)(11346002)(256004)(97736004)(76176011)(2501003)(6436002)(7696005)(476003)(5250100002)(10090500001)(305945005)(66066001)(53936002)(1511001)(74316002)(2900100001)(102836004)(105586002)(7736002)(106356001)(81156014)(68736007)(6346003)(9686003)(26005)(25786009)(55016002)(71190400001)(8936002)(6246003)(81166006)(8676002)(71200400001)(26583001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0760;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-message-info: PVVKdFMXM7VXRfpbNaLhqgCz+CGhb9HE3QPLFuewC5Z4/RPR8P7owohy+kAclI8k8MuTcdMT30o7TV71lstcJRALg3D+S7WHkkCxxmJ1yCIkAq0NN5erhcrr1E4zx8yTPbxYRn54+TulXEXEKx0cOJv/YybII2FWsulVFDOcIuk1CtOs72DrbC2MfxC/g1Z9zkdF+Y2fnkq4w/1q9uGSyGa+ynyFzoSXBOLSBHHNskhLKtb08h5zOvYYlFEBV3zb+9nfw/nwTewPxnUJV2F8Hb4Go27Uc3ToBnSP/VOH/1E3sHgASVd/hVsJMwKeWnXkjeoMWlkc7QvZ3KfIlo2uuW+qhp50r0qDTRYiCqtcRgs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75cc786-ed21-4aae-d2b8-08d639c1f2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 15:04:08.2402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>  Sent: Wednesday, Octob=
er 17, 2018 10:09 PM
>=20
> Currently we are replicating state in struct hv_context that is unnecessa=
ry -
> this state can be retrieved from the hypervisor. Furthermore, this is a p=
er-cpu
> state that is being maintained as a global state in struct hv_context.
> Get rid of this state in struct hv_context.
>=20
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/hv/hv.c           | 10 +++-------
>  drivers/hv/hyperv_vmbus.h |  2 --
>  2 files changed, 3 insertions(+), 9 deletions(-)
>=20
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
