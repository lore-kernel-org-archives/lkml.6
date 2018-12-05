Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5FEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C93120645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="S+KBbCVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C93120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeLETFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:05:51 -0500
Received: from mail-eopbgr720056.outbound.protection.outlook.com ([40.107.72.56]:33569
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728238AbeLETFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrdsTYcK1ASjCaGDNlDZPRvbBKr1wA0Q2MArxiYlIQg=;
 b=S+KBbCVLoCNbKDkmaGBtyXE0PegU965+k0JtsQTFHY67g8HemZzQas8PagMQputoB1xoQq3eU7LiF++WkGFaKp8/0UOmQ/yaZJ2yxtE0sImMEIC6strAb8tM1fPc09Al9DC9ndrA8R/bhJlGpIrlvfZVO9aXFMWlofJKyWwWTAA=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB4548.namprd02.prod.outlook.com (10.167.180.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 19:05:02 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d%2]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 19:05:02 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH v7 05/10] usb: dwc3: make controller clear transfer
 resources after complete
Thread-Topic: [PATCH v7 05/10] usb: dwc3: make controller clear transfer
 resources after complete
Thread-Index: AQHUiWbtSjqus2M3jkO9VscWv2prA6Vv33OAgACnyJA=
Date:   Wed, 5 Dec 2018 19:05:01 +0000
Message-ID: <BL0PR02MB56339BB8AD013857534BF09EA7A80@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1543662811-5194-6-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <878t142vpq.fsf@linux.intel.com>
In-Reply-To: <878t142vpq.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [182.18.177.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4548;6:u+8moCXYKv0Dpzem0htgVctA3wsLFf4JR3ZzyCNV1vLJr0Msneljm8ZAnmhOGdK92WL01zekxlCJRUlcGI97VS862i32056gXbScB5YuKqwIlovGJrdNGYR78VBdL0RBwwVOodgmvrs/JyJMtErLYaoGOY5l1C7Zxu0Sa/sT/cc9fJVroY0cMnuVlwRpXRo0kt+xe0Ok0J177H3km5haKRCoR4BMaS0mPcrbiKB88/bx6vTNpwSkFa8GwPDCIpwSo7TqVsm5dP2m5sTRwLX0r9KCoyNsFTNkoWFB0T+9S0ZNmx1RcUlWNNXtR71Fk9vnBrwKCb+/hSRn8WVzXDdof8K/Rz8+klZ7HWZ6e8gIVt52MhSWnb65hjCPkr4TaZwcFYKOSqGrfbbIxLY8bVQB6GaCf8V0WAC5GbkTfZ3+l0yw5i3xZVaGUPndSZsUaFlSauPnTekiKWK4+7Z7Fe1cGQ==;5:iOuqKgsXrHqt579BzoKLg/22iiVMosNKMrw9CYBOtdjBslWUKJKH8jLIocRBmpabymYWJwYkzkdhV4Mtzy12QFtGse43wfcUU4N9bSrwua5HpNZ0EiXDO3fVLuVPGySTvlggS5G1BmhjmeR2iyaBjML1XJnFk6OM9xsV/Rgay6Q=;7:A7I1HMHJvmKKBe2Q9N5X6VQbFW8S0YoTEjHI63nW7N3XtWPfAhH1Fd5veL/1aCX/wJoEmUeDnqnSM4YOXJyT2AMoQvSG5zJmV7PMw4rA7FRDnvztj5J1Hh8nyYoeAJW5izmr6JN3VwKFA1KnB46kXA==
x-ms-office365-filtering-correlation-id: 0dc6442c-8c28-44ad-5282-08d65ae48f4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4548;
x-ms-traffictypediagnostic: BL0PR02MB4548:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB454859F88C722D65272FF02DA7A80@BL0PR02MB4548.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4548;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4548;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(39860400002)(366004)(346002)(396003)(376002)(13464003)(189003)(199004)(476003)(6116002)(33656002)(11346002)(53936002)(446003)(3846002)(2501003)(6246003)(39060400002)(105586002)(107886003)(106356001)(2171002)(7416002)(8936002)(81166006)(81156014)(229853002)(8676002)(186003)(74316002)(7736002)(305945005)(66066001)(6436002)(25786009)(76176011)(2906002)(7696005)(97736004)(26005)(99286004)(5660300001)(9686003)(68736007)(6506007)(102836004)(55016002)(316002)(86362001)(14454004)(54906003)(110136005)(486006)(71200400001)(256004)(71190400001)(4326008)(478600001)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4548;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bS8TIdps8UM1CKjpYsiWTThAf4zguxDJSL8i42Y3lSjOwqC6Bg+Ni35MksU/bW4wVS27mTZXShQQE9v1RSO4DNMJXS30ierb3eSFZNUw0Lehyy7XBIIb3ltDgaInf/tLWmJ8R9J8ZabfAfsjqW68P6IboQBWZbplPupYysgboGCppDDTmewyDusMhWyKAJJhtyoWTS1DNOp7Bwp+LyxgZHKK7heutGxoh9LpY2cvTeQc/q+pEt2PRBPJ4kQaHuAH5H+AulOSD+BaI2Q09GWn3gcrNEb9/Oi8catFJoFVPY3OEkxdMv0guku2Wp8sYB1pivAmCC5qrAj1V59ArixJ1SM09mK61RnFS+/bHc0QGNU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc6442c-8c28-44ad-5282-08d65ae48f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 19:05:02.0058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4548
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


HI Felipe,
>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@kernel.org]
>Sent: Wednesday, December 05, 2018 2:32 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Shuah Khan <shuah@kernel.org>; Alan Stern
><stern@rowland.harvard.edu>; Johan Hovold <johan@kernel.org>; Jaejoong Kim
><climbbb.kim@gmail.com>; Benjamin Herrenschmidt <benh@kernel.crashing.org>=
;
>Roger Quadros <rogerq@ti.com>; Manu Gautam <mgautam@codeaurora.org>;
>martin.petersen@oracle.com; Bart Van Assche <bvanassche@acm.org>; Mike
>Christie <mchristi@redhat.com>; Matthew Wilcox <willy@infradead.org>; Coli=
n Ian
>King <colin.king@canonical.com>
>Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
>v.anuragkumar@gmail.com; Thinh Nguyen <thinhn@synopsys.com>; Tejas Jogleka=
r
><tejas.joglekar@synopsys.com>; Ajay Yugalkishore Pandey <APANDEY@xilinx.co=
m>;
>Anurag Kumar Vulisha <anuragku@xilinx.com>
>Subject: Re: [PATCH v7 05/10] usb: dwc3: make controller clear transfer re=
sources
>after complete
>
>
>Hi,
>
>Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
>> @@ -2487,6 +2497,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *=
dwc,
>>  	}
>>
>>  	switch (event->endpoint_event) {
>> +	case DWC3_DEPEVT_XFERCOMPLETE:
>> +		if (!dep->stream_capable)
>> +			break;
>> +		dep->flags &=3D ~DWC3_EP_TRANSFER_STARTED;
>> +		/* Fall Through */
>
>instead, let's add a proper handler for this:
>
>dwc3_gadget_endpoint_transfer_complete(dep, event);
>
>That handler should be "self-sufficient". IOW, we shouldn't have this
>fall through here. This means that the other patch where you modify
>dwc3_gadget_transfer_in_progress() shouldn't be necessary, since that
>event shouldn't run for stream capable endpoints.
>

Thanks for  your suggestion, will implement the changes as said and send
the patches

>While rewriting the patches, please rebase on my testing/next as I have
>applied a few of the patches in this series.=20

Okay , will rebase on top of testing/next and send the patches

Best Regards,
Anurag Kumar Vulisha
