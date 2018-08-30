Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5800CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC6620658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Xi+X2Nmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC6620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeH3UbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:31:22 -0400
Received: from mail-eopbgr720113.outbound.protection.outlook.com ([40.107.72.113]:62784
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727450AbeH3UbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2a/HWzY99C7PTDHxr7lI7DTZfaWKg2wmjcCRmJFs4k=;
 b=Xi+X2Nmh/gDrwWtsPW/GGgbYYubtcImAWy6pzGjKmmdPaucgJRTQbvXnirl/K6dmxwNxw7BSAHWrIipVA1Wjy0HSan5gyUICN/WXr9JwXHO2Gy9+SecleFQ3qqyDY6reb+cv1z22vpTwqgUDzwAJuExgKRykZxF+AnvMPvjJLaM=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB1116.namprd21.prod.outlook.com (52.132.149.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 16:28:22 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::9005:3b61:42d7:1fe1]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::9005:3b61:42d7:1fe1%4]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 16:28:22 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'" 
        <driverdev-devel@linuxdriverproject.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Use raw_smp_processor_id() in
 vmbus_connect()
Thread-Topic: [PATCH] Drivers: hv: vmbus: Use raw_smp_processor_id() in
 vmbus_connect()
Thread-Index: AdQ7H/34qAH7zeGBQLegJ1KnxB9zFAFWLlUA
Date:   Thu, 30 Aug 2018 16:28:22 +0000
Message-ID: <MW2PR2101MB11138A251E48BC8C6B859BF1A0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <PU1P153MB01694E53D6A6192A46EA3214BF370@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01694E53D6A6192A46EA3214BF370@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.136.232.39]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1116;6:Y/yaE7wfkzk4FOrnOxLLwI1HdGDwXfthhFh3ZjQKJJiHxWNGiq+1Yz/2AtKGY8cRMa2LFhrq7RkW97fymA9Yr5jyf21uYuQCeQshTUTs+YrdjOu34noSOEGW1PkaVFAAoGN/KDlA87jQFkW0aGfLGKuhFbTU0sgr12Okv9NbyhOKX19OVSs+3dk/z45IflVybSwq2mQaN3ax7GuNRFuIsgD9ias8tTdPp6lFIeiPn+EwinXheuHlovvts5vGOTDfibnTIWf3eLmLRQpGpiPxCyxfHZ0NowUY5A/r7z7Snuo/3BSeunjbtHkmslKcV2iMx044CjAzItKV9xbcIFdge50DHIP/pTQrH3a61ZYLXLLLc8HWLd2HbV9KkNnNFGwk9qVSh4LYWMChGyr7w/H/pCHcCrYjxVmESzmx01GCpSUuPTxFrJChg91CTD8T7zmPwl3IIz6wipjDfKLt+bZ92g==;5:vo8Co54/AL1vg+GciZrQBBoJ8IBRNXX1h1F9MDvifPEVH6y1DofjNIm+sbP4It4CUUTCjTNR9h3HO4o7V3UuF3ZAiYH9MUdPq+DIDuhb/USHxAdaJAVC31+kceUQZtDqCIhokHARWpbdFc+QtOWRxin6tdGGbdCyXEoQUYcbvlo=;7:foMiLLtYy1Ezbk8xtLUS2SPGFE6ZTMVvbm1tHrI7uXmAFYwIhBDTXV5d7VufweoDodl6PCzftmNbxjMUpLP9InJnNDWqB7PRemf6puuI9YLjM01DKtwqJVsjAhA6yiIuk1CjGRoQ34ocwlQeah1aR++g1yx8Hx5dJ77TqjQMPx3FFH9tv4vwnX8l8FWG370kwQJz5c3yklR4mBcX40SxkJ1WMmv+xRs2ZhRP7ZTKkIRuXq1AXBPVr+iQsXcnNyrR
x-ms-office365-filtering-correlation-id: ff38a5ba-804b-493b-eebd-08d60e959a66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1116;
x-ms-traffictypediagnostic: MW2PR2101MB1116:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1116041DA646112DA3CDAFE6A0080@MW2PR2101MB1116.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(21532816269658)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:MW2PR2101MB1116;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1116;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(396003)(39860400002)(13464003)(189003)(199004)(229853002)(3846002)(68736007)(6116002)(476003)(486006)(446003)(11346002)(9686003)(66066001)(14454004)(2900100001)(10090500001)(86612001)(1511001)(256004)(102836004)(8936002)(53546011)(26005)(14444005)(6506007)(86362001)(55016002)(53936002)(2906002)(6436002)(97736004)(6636002)(74316002)(305945005)(76176011)(7696005)(99286004)(81156014)(316002)(22452003)(54906003)(110136005)(5660300001)(8676002)(105586002)(33656002)(5250100002)(8990500004)(106356001)(4326008)(6246003)(10290500003)(478600001)(7736002)(25786009)(81166006)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1116;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DeUTXkuiWMD478BpOOiJSTlCpW8COcYoh+nicl4mqJHvi9wMVx2+Oi/lSGEGqYKLYJNWcSK977qUlgM9nUfQczXrQkWoQgkJiFnJMjVhu7HScq4c8oFYDWupYy+ngmZ0OwD+FOzOwRQttuZ+py2LXr+Yms3zlj13MHNomEMOZNm82N0l/OiwHUeAdtFU1xSn9GIyxqLqUvkIxtoKsFrOCdEgyYTRJFVg1CSuyeNhJoQxGX72HH2swLqnNvChE1Vssk+tAAe1CCAsy2e4VSTMKV5CFY/DoC2/q62+ZamyxQKtmeyHoP2QY57dKa3tDziJZ6TvpqGfiNxWj+x7Qun76I1lF2k/TfxGjIijKGJZR3U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff38a5ba-804b-493b-eebd-08d60e959a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 16:28:22.1656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Dexuan Cui
> Sent: Thursday, August 23, 2018 3:31 PM
> To: 'gregkh@linuxfoundation.org' <gregkh@linuxfoundation.org>; KY
> Srinivasan <kys@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>
> Cc: 'linux-kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>;
> 'driverdev-devel@linuxdriverproject.org' <driverdev-
> devel@linuxdriverproject.org>; 'olaf@aepfle.de' <olaf@aepfle.de>;
> 'apw@canonical.com' <apw@canonical.com>; 'jasowang@redhat.com'
> <jasowang@redhat.com>; vkuznets <vkuznets@redhat.com>;
> 'marcelo.cerri@canonical.com' <marcelo.cerri@canonical.com>
> Subject: [PATCH] Drivers: hv: vmbus: Use raw_smp_processor_id() in
> vmbus_connect()
>=20
>=20
> With CONFIG_DEBUG_PREEMPT=3Dy, I always see this warning:
> BUG: using smp_processor_id() in preemptible [00000000]
>=20
> Fix the false warning by using raw_smp_processor_id().
>=20
> Here vmbus_connect() sends a message to the host and waits for the
> host's response. The host will deliver the response message and an
> interrupt on CPU msg->target_vcpu, and later the interrupt handler
> will wake up vmbus_connect(). vmbus_connect() doesn't really have
> to run on the same cpu as CPU msg->target_vcpu, so it's safe to
> use raw_smp_processor_id() here.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> ---
>  drivers/hv/connection.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index ced0418..c3b7040 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -119,8 +119,8 @@ static int vmbus_negotiate_version(struct
> vmbus_channel_msginfo *msginfo,
>  	 */
>  	if (version >=3D VERSION_WIN8_1) {
>  		msg->target_vcpu =3D
> -
> 	hv_cpu_number_to_vp_number(smp_processor_id());
> -		vmbus_connection.connect_cpu =3D smp_processor_id();
> +
> 	hv_cpu_number_to_vp_number(raw_smp_processor_id());
> +		vmbus_connection.connect_cpu =3D raw_smp_processor_id();
Dexuan,

We want a consistent view of the CPU we are currently running on. How about=
 doing something
like this:

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index ced041899456..4cc0877ba38a 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -119,8 +119,9 @@ static int vmbus_negotiate_version(struct vmbus_channel=
_msginfo *msginfo,
         */
        if (version >=3D VERSION_WIN8_1) {
                msg->target_vcpu =3D
-                       hv_cpu_number_to_vp_number(smp_processor_id());
-               vmbus_connection.connect_cpu =3D smp_processor_id();
+                       hv_cpu_number_to_vp_number(get_cpu());
+               vmbus_connection.connect_cpu =3D msg->target_vcpu;
+               put_cpu();
        } else {
                msg->target_vcpu =3D 0;
                vmbus_connection.connect_cpu =3D 0;

>  	} else {
>  		msg->target_vcpu =3D 0;
>  		vmbus_connection.connect_cpu =3D 0;
> --
> 2.7.4

