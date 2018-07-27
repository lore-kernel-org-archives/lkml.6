Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C65C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA29920673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mnes8c2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA29920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbeG0IzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:55:03 -0400
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:29152
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729420AbeG0IzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seqn2oyXCM8Qg3e9EPkRQ4VgQSgyrOGhFom6beKomQk=;
 b=mnes8c2dXyswK75TQdXv6V7vY0sKM7JQKZbMixTW5ghTtMIuHnt1D/rul04xhNynv/B4wO/28aAjo3FoXcV9ZP/njYLvTajL7fgC3EL52mYLTyMLdQZPfB2oSIJllnDOLXXO263BEYvVeEmoMMu2QHSECch5Y44CrED0JZW5KYk=
Received: from MWHPR02MB2816.namprd02.prod.outlook.com (10.175.50.14) by
 MWHPR02MB2558.namprd02.prod.outlook.com (10.168.205.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Fri, 27 Jul 2018 07:34:23 +0000
Received: from MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726]) by MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726%3]) with mapi id 15.20.0995.019; Fri, 27 Jul 2018
 07:34:23 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] usb: dwc3: core: Add quirk for enabling AutoRetry
 feature in the controller
Thread-Topic: [PATCH v3] usb: dwc3: core: Add quirk for enabling AutoRetry
 feature in the controller
Thread-Index: AQHUJOHTzwXtrtjD0kyGI3yBBhb0wKSiqfUAgAAEOLA=
Date:   Fri, 27 Jul 2018 07:34:23 +0000
Message-ID: <MWHPR02MB2816BCF2F19A0D7DA70A6E53A72A0@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1532610528-7290-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <87k1phywot.fsf@linux.intel.com>
In-Reply-To: <87k1phywot.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2558;6:3aa7cdXkkNweZKos0/y82g2wjycfwyspfS/MF/0HNvKaU2+spPWMq4FDcg4dvY4EA7i2WBNpkNFD8+5GZXfWMBOddKytx7gXXOz9jLQekPBhqR0LiyRNWDf/w7bzREhaIE8memlJUFo3WCjwAMac2+aHHyTfN0cjkdvapCYIySbcDl3Cuz+LObQ4cNSAAKG0BO3dLyEXcDgcbQnXnpiZngeU6XQFMaNO4hLJqoY6hBCtctZCKdYUq7A8XfNsofrKIrEB/KbRqOJ68EEc0AMRS0JL4hw5KWmagdLQmM7lpbGlaI1n4Yo+3c2kWK+F+0uTOH6xskhQ35Bvwuy1pjCi2/ofM7E5omJ9H1608FNGtfAOOFdnysB90ZYr44hCHQPX2pjA78/VQKCEbd6zS4F1jgVthueulxWUTjG4y1r6xEZXu+eC3W/0bNWohAjlGRihOcV0rgk7RJ19u0a8pgyEjA==;5:+IfpIoYJZA4+4j/bd8N7PafOo3CFSri4AWvSuxTcrPa1zszwVhgzRIzlqVeoV2h96G2s5OixUaJT9z0dRB+HOsVG3f/VgkveYX+6EBYZsDWw5otKteYLT6xH3r7iTIVX3esrBAiCOxOskPgSFXyPjbgJ0qpsXcuV40sbwiSF/7w=;7:bPwAMr6AgbITy97TLXP+7BnTDQYTkHeMyx7uDHPdvp41dRNapZaRc+4IFW7KaxIJe60YdMlCBjkRHF/3MPUq9RpZHpjMrYW+WlLLOf9TH3oocPd17PkLup8nLr/x1J31M7gg1yG1ak51x+i922wbwxmC59E9xEEuWXmaEskrsqJ8oBfXLMJ0dvsraghvPQ6pX8dPyoghBkhYCFyxHXXhU/0fu4ugjHLieSeZZ7q6/8j/h6DRvNjTd09AdRA4fNUo
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ed0bb9ab-f905-45a2-5675-08d5f3935fbb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2558;
x-ms-traffictypediagnostic: MWHPR02MB2558:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB2558B78971DB6DC76EB8813AA72A0@MWHPR02MB2558.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2558;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2558;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(189003)(199004)(5250100002)(110136005)(26005)(102836004)(2900100001)(316002)(86362001)(9686003)(446003)(55016002)(105586002)(305945005)(106356001)(74316002)(25786009)(54906003)(256004)(5660300001)(6436002)(476003)(486006)(2501003)(7696005)(6506007)(229853002)(76176011)(186003)(11346002)(33656002)(6246003)(39060400002)(97736004)(8936002)(53936002)(6116002)(4326008)(3846002)(478600001)(2906002)(551934003)(99286004)(81166006)(68736007)(8676002)(81156014)(7736002)(14454004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2558;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rV7WnAT2sLxh2eo/lsCsMa5F2DFJLxER0M/6vpxcMsIjjJIbShR4UCFmDRc9/WQCjYqVN0iHiK8XURGVb1cZQVjoZkN6N3VLGWcuC/uNL8ipw+ZlLwEfU4wxKB22U12IxE4fwStiJh93l2eexKW0aZ63z2R2L050XsxIdhHevAX4N6aGfKzaVySkp2f6AKDZ6IhuP1fPahOAHlQc7juBCivH0kLO4JEXtxLx3C/kODM7A72MpzJQER0LZqWfwWO38xJJsDG61CAt1x17uC8TK5ozesb97AiJlyHGXJ6u4ScNTbE+Xqw1Y68bFBaP+18roJZaRdB5ujEokSlCnTV4esc+zJb8m+RPVSwUxCITl/E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0bb9ab-f905-45a2-5675-08d5f3935fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 07:34:23.2926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2558
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

>Hi,
>
>Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
>> By default when core sees any transaction error(CRC or overflow) it
>> replies with terminating retry ACK (Retry=3D1 and Nump =3D=3D 0).
>> Enabling this Auto Retry feature in controller, on seeing any
>> transaction errors makes the core to send a non-terminating ACK
>> transaction packet (that is, ACK TP with Retry=3D1 and Nump !=3D 0).
>> Doing so will give controller a chance to recover from the error
>> condition.
>>
>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>> ---
>
>subject line is misleading, at best. You're not adding any quirks.
>
Oops !  Will fix this and send another version

Thanks,
Anurag Kumar Vulisha
>--
>balbi
