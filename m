Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E348EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC3420861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZMDjYVSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC3420861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409361AbeKWVTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:19:11 -0500
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:58202
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390495AbeKWVTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI9bMLlobphgUderf4GN2qEMzO9n+1PU0alclXA+EQ0=;
 b=ZMDjYVSPaUTS/yMrPjJkfiKLZtVMZ+jXzJPHEeqCPiFURgFU+NdNFn+qVGSrCF78pDCW8H0LjV3kfIDTESclWBrOHSEgqmwgLWhTJC+4sBdGB9GI4vIdl1bQZx0q9KOTVn5mRezJpvDIMITIUMNUiEXY+orrWi8Jpy+koCevtFE=
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com (20.177.49.153) by
 VI1PR04MB5598.eurprd04.prod.outlook.com (20.178.125.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Fri, 23 Nov 2018 10:35:20 +0000
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::3cf6:b5ab:ac8a:fd94]) by VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::3cf6:b5ab:ac8a:fd94%4]) with mapi id 15.20.1361.015; Fri, 23 Nov 2018
 10:35:19 +0000
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     David Miller <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Catalin Horghidan <catalin.horghidan@nxp.com>
Subject: RE: [PATCH net-next v2 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
Thread-Topic: [PATCH net-next v2 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
Thread-Index: AQHUgP0VcQXM/br9+0etCnjg7gktoKVa8JgAgADTuGCAAFW+gIABEv2A
Date:   Fri, 23 Nov 2018 10:35:19 +0000
Message-ID: <VI1PR04MB48801D1DF330B957C5BE652296D40@VI1PR04MB4880.eurprd04.prod.outlook.com>
References: <1542737734-21756-1-git-send-email-claudiu.manoil@nxp.com>
 <1542737734-21756-2-git-send-email-claudiu.manoil@nxp.com>
 <20181121.162118.2250773796794960530.davem@davemloft.net>
 <VI1PR04MB48803D4A3D8D331046CFC63196DB0@VI1PR04MB4880.eurprd04.prod.outlook.com>
 <20181122180557.GC10697@lunn.ch>
In-Reply-To: <20181122180557.GC10697@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=claudiu.manoil@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5598;6:jAjY5NP98JwCaGUrdTD7c1q7xk8yKdztpsQAfYhsz1Op6+2M7lF9y/4kHPUCdOiJHn+cYjsJ90DZ25ksJsqO2DE3wwsi6UcjhppCoJ2R0NFk8vDrzTEyRP4Q2RLut/Lh3eOKJE3FMnUX3sfHmUET8eARj24JnbPN9PCejMAxfGuKWMZTxRj2vF2EcpV4MqIUu2PQzvhTQ6uKpkdqX+zdFeVbXGEQT12NTLVGjPAoew9Acqwrynd5o0nK+KIpfnzi1CuMCpZkCuILih2eXSZJcN2QeNv3WN7XsBxi848kpKvmyOyGej6FqDe+1xKn2RflR4IjF4vi37faOcm70CfJaK0qmu2/zgxJVFN7erQUN2w8DP/PxuI2L3PXElSQdo5iTas+v1uCovAwb0QSjYJyQBy6Puhyy4mUHvLWt58kWX/cX4Dle+Ohd45WwVcImbBOuhYpCQZY4e8u8CwBSR8d8w==;5:VF3nS4Ame+2sLhcDLNeTY/CbCP0FqR77IRT2RUBIns2BWnupNQL5xcJ1ZF2rVRp1+sLJ1Hri0rxf3d+jTVIkK9WVVI6pvi3xkiDdPriZGnV+VHsGFcPiCFQQOS/8FvYYuPCFv8sTx+CpyNQUKEgk1ZbuUb9oAnZpEwS6o3qj0JA=;7:84JE3u3uZzwjGstH8A7yH61gePR3AL8abo5YvlxpcZE+ha1TYl1q4Fgq/oogg6qzBHnTBd5XVfQKX7YjClc+ROR4rxZXTHh3pydrR6pA1jX6ywgzNM5sKaATpL1vOcGWiMyMXHbWFF/HKpjtsxMQlw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fc2d0f31-1a48-4aa2-2994-08d6512f5de1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5598;
x-ms-traffictypediagnostic: VI1PR04MB5598:
x-microsoft-antispam-prvs: <VI1PR04MB5598CDB4827F942E7E142C1296D40@VI1PR04MB5598.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231442)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5598;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5598;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(366004)(199004)(189003)(13464003)(6436002)(25786009)(6916009)(256004)(446003)(74316002)(305945005)(7736002)(478600001)(26005)(14454004)(186003)(7696005)(6506007)(102836004)(81166006)(68736007)(5660300001)(76176011)(81156014)(8676002)(8936002)(229853002)(99286004)(105586002)(106356001)(316002)(4326008)(6246003)(97736004)(2906002)(54906003)(3846002)(93886005)(486006)(71200400001)(66066001)(44832011)(55016002)(9686003)(71190400001)(476003)(33656002)(11346002)(53936002)(86362001)(2900100001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5598;H:VI1PR04MB4880.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LVNxdeZg+cIZqNBrI2I9uqHC4BsUERJAApI0afkKDnvRGXtk/RJgnjL8PEZA256dqCbdtNW2idUFI9dH4pL6/k/FUyVLwo8Le25eLM/WXHV4iHFN5ptK3sPp3dE6qybQSr8p207coGZu3xaxUHw/4g6zpq303c6vULDdHpzzLTkDajSZCI82xuICz38Bk8F2iP4XfrcMibBQjNMju/DyWwBK2Cj5iVtYJN/N4RDDRdFiVEV1UvFckPUiJGcXk/GaWlUQ0jsdCHm43ucN7YDW75vXIyGS0g5UoXy6Uvc5HCNC61NQ0NQhLS+nCawpghXPMn/TLLzORPH2ueMqVLhX0BhDgIyS6BeqGxYmdpj0D7A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2d0f31-1a48-4aa2-2994-08d6512f5de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 10:35:19.8760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5598
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Andrew Lunn <andrew@lunn.ch>
>Sent: Thursday, November 22, 2018 8:06 PM
>To: Claudiu Manoil <claudiu.manoil@nxp.com>
>Cc: David Miller <davem@davemloft.net>; netdev@vger.kernel.org; linux-
>kernel@vger.kernel.org; Alexandru Marginean
><alexandru.marginean@nxp.com>; Catalin Horghidan
><catalin.horghidan@nxp.com>
>Subject: Re: [PATCH net-next v2 1/4] enetc: Introduce basic PF and VF ENET=
C
>ethernet drivers
>
>On Thu, Nov 22, 2018 at 01:06:01PM +0000, Claudiu Manoil wrote:
>> >-----Original Message-----
>> >From: David Miller <davem@davemloft.net>
>> >Sent: Thursday, November 22, 2018 2:21 AM
>> >To: Claudiu Manoil <claudiu.manoil@nxp.com>
>> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Alexandru
>> >Marginean <alexandru.marginean@nxp.com>; Catalin Horghidan
>> ><catalin.horghidan@nxp.com>
>> >Subject: Re: [PATCH net-next v2 1/4] enetc: Introduce basic PF and VF E=
NETC
>> >ethernet drivers
>> >
>> >From: Claudiu Manoil <claudiu.manoil@nxp.com>
>> >Date: Tue, 20 Nov 2018 20:15:31 +0200
>> >
>> >> diff --git a/drivers/net/ethernet/freescale/Makefile
>> >b/drivers/net/ethernet/freescale/Makefile
>> >> index 3b4ff08..20e5c2f9 100644
>> >> --- a/drivers/net/ethernet/freescale/Makefile
>> >> +++ b/drivers/net/ethernet/freescale/Makefile
>> >> @@ -23,3 +23,4 @@ obj-$(CONFIG_FSL_FMAN) +=3D fman/
>> >>  obj-$(CONFIG_FSL_DPAA_ETH) +=3D dpaa/
>> >>
>> >>  obj-$(CONFIG_FSL_DPAA2_ETH) +=3D dpaa2/
>> >> +obj-$(CONFIG_NET_VENDOR_FREESCALE) +=3D enetc/
>> >
>> >The driver enable Kconfig option should guard traversing into the
>> >driver subdirectory, not the vendor enable Kconfig knob.
>>
>> The enetc/ dir contains 2 drivers, that share a lot of common code.
>> Would you agree if I change the vendor enable with the two configs
>> (one for each driver) as below?
>>
>> -obj-$(CONFIG_NET_VENDOR_FREESCALE) +=3D enetc/
>> +obj-$(CONFIG_FSL_ENETC) +=3D enetc/
>> +obj-$(CONFIG_FSL_ENETC_VF) +=3D enetc/
>
>CONFIG_NET_VENDOR_FREESCALE should hide/show all Freescale drivers.
>
>Once you show all Freescale drivers, there should be an option to
>enable each individual driver.
>
>Does the ENETC_VF driver depend on the ENETC driver? If so, when
>CONFIG_FSL_ENETC is enabled, the CONFIG_FSL_ENETC_VF should be
>unhidden.
>

The two drivers are independent as can be seen from enetc/Makefile.
E.g., in a virtualized env you can have a linux instance (guest) containing
only the VF driver.
Sending v3 with the above mentioned change.
