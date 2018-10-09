Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B99C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDB5213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YlQk4vkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDB5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJINx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:53:56 -0400
Received: from mail-bl2nam02on0042.outbound.protection.outlook.com ([104.47.38.42]:35386
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbeJINx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X6RjF0q78fch5XDZpi5eZuCw6BQotMIx7Nrta43F/Q=;
 b=YlQk4vkCz6kmv6JkPlo4rZF1jM48/QmrpnRBH2PDj+MePbq6rZ2qdx6gSwpRcFVlo7qpD73iQlsgRbqwd52MvIIkL8de9a4ULeyaOU9x65tbri9lL42Loesh2jsA/qBazBMMxrgJ8/GX8DZs4ynbt8Y/dZ4xEUYCh9nDC52vhBA=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB5603.namprd02.prod.outlook.com (20.177.241.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.28; Tue, 9 Oct 2018 06:38:26 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::8cbf:c901:e10:b871]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::8cbf:c901:e10:b871%4]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 06:38:21 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to dwc3
 gadget driver
Thread-Topic: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to dwc3
 gadget driver
Thread-Index: AQHUTQCoBCMdjS6uDUqQ64x43Vb2OaUVlfeggAD0K4CAAAogwA==
Date:   Tue, 9 Oct 2018 06:38:21 +0000
Message-ID: <BL0PR02MB5633850DAB27466B4D5D6F44A7E70@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <BL0PR02MB563373F068BC275BCB14DBE3A7E60@BL0PR02MB5633.namprd02.prod.outlook.com>
 <871s8zptow.fsf@linux.intel.com>
In-Reply-To: <871s8zptow.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB5603;6:dQ3E4vKFmxQWfMLWvgzoztL8agBN7psxCrc5Ga2MJ25wtYcOY5m28Va+pF+wbXwePsUunUBJodksW5Rlyob7MnOu1AfSQMkk8vj2KjvZOE8YwPUxNAZmWW0gPirtt+5DW5yyHdFs+OB5GvqR42XkTe58dUaDgyCKBN6k4BtMWI6/Xhw/gk+PB0tlToYBSi7cTw/8qarBRkqGHokNHa3JGRzA2WRqA6UkTflhOp+zNmD//4o2enAsb7K21LUUmDBa3rI8rYPmN0xRNP8Zr45I+oM5Qshondu/tTV+ZVscO8ld0n3lWqO9ayxKrAj3sm71LUfSeQENN3sNAfKyZXt9YZD11mt9ju5pnEcbHbpv2142MDfdegN5XbHvrSDVJHqvSVIneE2ON5YldihDDiy8mDU1hvMCM1ZF9bLa5/41ubt2qsjskf0cWr9YZ/CXwDAHlHxx2SgiTalsJrKDF8yhPA==;5:1VrHQyvM7MdeahzEcuKUjf6TV5GJcJqZW6qFHpTmstB1itm693ylBlz4/u/+MY3+6DUctCrzzEvq9r1MFt+3E1/N9C17onte2+gvSEfjsfP5gEMfvMz35YPnzfEtU5go7zRHGadaG1IRTw+SMAP/gb0cZ9r7z+4KTlK43jv8s/E=;7:vM8KofjbICMVJdczH8XV29DRSsNa5pGsBVg2JwP/u8tgnsc7lRsaZiXzOD4BRyiXfjmvbV4BgIQgTaUgQOOpk3xOjL1UvOjrGYoz+1FUMOhOevAkL2UlHqUTrgiZuBz+jwkLPzTiEwqwMH4E0sFSwHi6CfJwL+HdrqGDEdgHhXPRqaFL+H0mVuYRcn4B8CXR+jlmA6j4LZ52HGPdvE91gnrrqp+m/0hiv2cxaNM4yrgCK+R/dydh7w/pv2Pr+ogr
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 9c6a27d8-74d3-46b6-9b0e-08d62db1ce77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB5603;
x-ms-traffictypediagnostic: BL0PR02MB5603:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-microsoft-antispam-prvs: <BL0PR02MB5603BFA48F088814BD2F66C7A7E70@BL0PR02MB5603.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991055);SRVR:BL0PR02MB5603;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB5603;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(13464003)(53474002)(6246003)(478600001)(97736004)(476003)(486006)(107886003)(186003)(74316002)(7696005)(53936002)(11346002)(39060400002)(446003)(2900100001)(102836004)(4326008)(2501003)(55016002)(25786009)(9686003)(14454004)(551934003)(66066001)(99286004)(5250100002)(26005)(8936002)(6116002)(316002)(229853002)(71190400001)(71200400001)(305945005)(33656002)(7736002)(86362001)(6506007)(8676002)(81156014)(81166006)(3846002)(68736007)(110136005)(5660300001)(76176011)(106356001)(54906003)(105586002)(2906002)(6436002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB5603;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4pzfnUJpIxyjO7sinaW1C8aOdGWFdfdbXTOGnVxPkao49d/IxmGrtt6nr06Ll/pgnB+tiWZ2qPrsbdB+BNRL338xjzVcDY2D0roKE4vLcJtodJUxxuaE+Vpqq0QYqhQi4llS7Y1puXF0NSMXKRc28/RwPVd3TJsggGyjTxGOhejaSdGUrdinHaDqCXATdKVYTYVt/y8DHgQ9Iku+qtG3a4cSG7merI9QhNeNtdKiKj8PgVsJrY7+ZBUkdivq3umJwb21PDsZ4mI7LFJYqYBzFjb1SEPrYtvnG4M8z/CabXPBNq7HH8Ynn6BcIV7N43F2O7yBMQN9RyyZbSi7UzjheJCV0fGptgkEOWXfs1RyvYk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6a27d8-74d3-46b6-9b0e-08d62db1ce77
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 06:38:21.4347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5603
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@kernel.org]
>Sent: Tuesday, October 09, 2018 11:07 AM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Anurag Kumar Vulisha
><anuragku@xilinx.com>; gregkh@linuxfoundation.org
>Cc: v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; Thinh.Nguyen@synopsys.com; Ajay Yugalkishore Pande=
y
><APANDEY@xilinx.com>
>Subject: RE: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to d=
wc3
>gadget driver
>
>
>(no top-posting, please)
>

Will ensure this won't happen again

>Hi,
>
>
>Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>
>> Hi Felipe,
>>
>> Please let us know if you have any suggestions / comments on this patch =
series.
>> If you feel this patch series are okay, can we proceed with them?
>
>I really don't like this dwc3-specific timer. The best way here would be
>to add a timer on udc/core.c which can be reused by any udc. This would
>mean, of course, teaching udc/core about streams and lettting it do part
>of the handling.
>

Thanks for spending your time in reviewing this patch. The reason for addin=
g the
timer is when streams are enabled there could be chances for the host and g=
adget
controller to become out of sync, the gadget may wait for the host to issue=
 prime
transaction and the host may wait for the gadget to issue ERDY. To avoid su=
ch a
potential deadlock conditions, timeout needs to be implemented in dwc3 driv=
er.
After timeout occurs, gadget will first stop transfer and restart the trans=
fer again.
This issue is mentioned in databook 2.90A section 9.5.2. I am not aware of =
how
other controllers are handling the streams, but since this issue looks more=
 like a
dwc3 specific issue, I think it would be more convincing to add the timer i=
n dwc3
gadget driver rather than adding in udc framework. Also we are stopping the=
 timer
when a valid StreamEvnt is found, which would be difficult to handle if the=
 timer is
moved into udc. Please help me by correcting , if I am missing something or=
 my
understanding is wrong.

Thanks,
Anurag Kumar Vulisha

>Best
>
>--
>balbi
