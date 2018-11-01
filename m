Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D102C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAE0205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Xe3/yOUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAE0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeKBEnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 00:43:42 -0400
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:21280
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbeKBEnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 00:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6eFhHiTDtN/iGYVP3R8yzsE/vObIxxsPWawoXqx1og=;
 b=Xe3/yOUtAnBPC1pdd+ayjx3DvrS6iXMq+oZz5UBW/t6pXCMxjPPUrCmRW/a6YEZ8t95enYhokADOcdr2Vsn+dJBDpQ4y7OFJ5rVFBJ1L2e3mh76omoL8RmLrkAMgNjV/ZE1L1EOU9Ltes9wKWwsZIzX5ucfaq6BOF7A4GW8vGoI=
Received: from DM5PR2101MB1013.namprd21.prod.outlook.com (52.132.133.35) by
 DM5PR2101MB1061.namprd21.prod.outlook.com (52.132.128.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.9; Thu, 1 Nov 2018 19:38:38 +0000
Received: from DM5PR2101MB1013.namprd21.prod.outlook.com
 ([fe80::8415:b182:814c:9124]) by DM5PR2101MB1013.namprd21.prod.outlook.com
 ([fe80::8415:b182:814c:9124%3]) with mapi id 15.20.1294.014; Thu, 1 Nov 2018
 19:38:38 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
CC:     Dexuan Cui <decui@microsoft.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: RE: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression caused
 by incorrect clean-up
Thread-Topic: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression
 caused by incorrect clean-up
Thread-Index: AQHUZqDq7yTdoqSYYEe75q03Sy7/g6U7Z7Xw
Date:   Thu, 1 Nov 2018 19:38:38 +0000
Message-ID: <DM5PR2101MB1013C4320E2A775DDD7F25FBCACE0@DM5PR2101MB1013.namprd21.prod.outlook.com>
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
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-01T19:38:37.3699499Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1061;6:F42d3UA56MLJNK1AfkI1bCWZXvSi6mLH1Kpnhfnzss+U1xQzYw9ZskhT67vL4mByZaSIkmAfheCWY9OFajkKk9PKYTIQJfJMXddwZw3jUCK85I621/BftrpnKTnXQ1j8ZUXZ+BNe2tCklDXet+y/MwtlVhwfH06KUR0nORaL2EmLYYbQVOTFNeDJ1iIR5/relDJduyas4Y8PRy94K4/cpf4obmcVYwf+gboLjLAFDUVmRIkR4w1B0cyxTpWqAt8wbFOPMpHr4jEQYhgoQ0p0I1sRJunHF0/yimqhRH8Q83QgoJB2hys66JT8o8xgmhV3+pZee5IO+mKP9uDvEa5V40H5H3viaTutJJgMr6J2o4nLqQOyy7yBM2DRf6fv9Lo3WwloE/GGzhVqtoM6QAyxEu/hBwIR85z6LY/IXGyFoLZoouy3YALjYILp6yIahiWCNQb/fn5fYZOQa+uWleHUDQ==;5:0rvijYJRYl9WUPaBU6/igbNx7rtR4PDJZA9hJAOMn4nHbBxgRBHBffOoxQ5fNLlI9wMdCMIPLTjYFSgVFElEe6BYuGM0ZFW+YLBFDFIdhf9qChJjbs6uq7Xen7CLmzFWwF2sOGcewOAcQu2yuDIfcQHFSt9yV1QQTL+FOtleeh4=;7:xU8wgeXRx2cUN5D1yzS5Yv8J3BtltzpCtw8VmBiRpBZfAAgISModPBwlyIUaT481MGfcdQLSqwjNprh6GUcA98j3SpNZaRgmHl2NXYv3xxzJ3ABnxmAfxPXuaG9Q+UXalfMChg9fpxJNYSklXyBVhw==
x-ms-office365-filtering-correlation-id: 43b7aca5-90ff-49fc-2544-08d640319f45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1061;
x-ms-traffictypediagnostic: DM5PR2101MB1061:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB1061777B578573A735064DEBCACE0@DM5PR2101MB1061.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(198206253151910)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR2101MB1061;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1061;
x-forefront-prvs: 0843C17679
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(136003)(199004)(189003)(13464003)(6436002)(4326008)(25786009)(486006)(8990500004)(14454004)(102836004)(5250100002)(316002)(26005)(22452003)(2906002)(2900100001)(229853002)(110136005)(2501003)(3846002)(6116002)(6506007)(54906003)(97736004)(53546011)(10090500001)(81156014)(68736007)(5660300001)(81166006)(8936002)(7736002)(256004)(478600001)(99286004)(10290500003)(305945005)(71190400001)(8676002)(1511001)(76176011)(7696005)(9686003)(86362001)(53936002)(2201001)(186003)(476003)(446003)(74316002)(33656002)(86612001)(11346002)(55016002)(106356001)(6246003)(71200400001)(66066001)(105586002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1061;H:DM5PR2101MB1013.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KwxcoMMwsLQb8GFoqF9dyRQ8DI4hJHcebPjrvHu8xtGoU/BZME1HoE0eVTrPuBb4qT1vnnTfE/BxfBhijUmZKpCUPoJ5A+i9rn83vMgfXGWzY4aoGuN3fBKNd06RXbWy5CDOXqgNuXYCGdK9LYMtapUDD2foPHx7u0PN51PfyNEXVMWEwsIUVmrtExx95exbWizdrV2gil6yBiAWPhOujC84RR21fsInmJkLp8un5AjUeS0vdwexPVx2anoItpvy5sdgZ7CUdNMmDm/dfYG4Lx80V4FCYQaqMdeCaAfNAwOzbDp8oA9YF8n22PI61CCoJ8jjnd/u1NnvVR6FNTcHGJ18/L9VedO6CnWcAwYpynE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b7aca5-90ff-49fc-2544-08d640319f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2018 19:38:38.6946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>
> Sent: Thursday, October 18, 2018 1:10 AM
> To: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> jasowang@redhat.com; Stephen Hemminger <sthemmin@microsoft.com>;
> Michael Kelley <mikelley@microsoft.com>; vkuznets <vkuznets@redhat.com>
> Cc: Dexuan Cui <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Stable@vger.kernel.org
> Subject: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression cause=
d by
> incorrect clean-up
>=20
> From: Dexuan Cui <decui@microsoft.com>
>=20
> In kvp_send_key(), we do need call process_ib_ipinfo() if
> message->kvp_hdr.operation is KVP_OP_GET_IP_INFO, because it turns out
> the userland hv_kvp_daemon needs the info of operation, adapter_id and
> addr_family. With the incorrect fc62c3b1977d, the host can't get the VM's=
 IP
> via KVP.
>=20
> And, fc62c3b1977d added a "break;", but actually forgot to initialize the
> key_size/value in the case of KVP_OP_SET, so the default key_size of
> 0 is passed to the kvp daemon, and the pool files
> /var/lib/hyperv/.kvp_pool_* can't be updated.
>=20
> This patch effectively rolls back the previous fc62c3b1977d, and correctl=
y fixes
> the "this statement may fall through" warnings.
>=20
> This patch is tested on WS 2012 R2 and 2016.
>=20
> Fixes: fc62c3b1977d ("Drivers: hv: kvp: Fix two "this statement may fall
> through" warnings")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Thanks!

