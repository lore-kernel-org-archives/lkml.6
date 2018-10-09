Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B17C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8318214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RGbGwsFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8318214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeJIURn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:17:43 -0400
Received: from mail-eopbgr700041.outbound.protection.outlook.com ([40.107.70.41]:15286
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbeJIURm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCSMezfUKOkpRE2ykC6CPAnT1r3xeYV7AGzjATPYKBg=;
 b=RGbGwsFa3nFvMdi+0F/z4DK+L01XDSgwWYKReQYEh6BiTEksgA/zIm0CBxnYVZ2N1sTcXJFA1Y3/2cMWEWuIw07yEA5HfPjYizHkRjRtp1xkJB3UhlJC4Eumv7rXwTfH07veRcrXb6J0r84H/Hb6fjwgzjaAAn7YKGv/mXSJpKA=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB3636.namprd02.prod.outlook.com (52.132.8.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Tue, 9 Oct 2018 13:00:47 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::8cbf:c901:e10:b871]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::8cbf:c901:e10:b871%4]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 13:00:47 +0000
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
Thread-Index: AQHUTQCoBCMdjS6uDUqQ64x43Vb2OaUVlfeggAD0K4CAAAogwIAAEvUAgABckVA=
Date:   Tue, 9 Oct 2018 13:00:47 +0000
Message-ID: <BL0PR02MB56334E88A0D23DC1FA9905B0A7E70@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <BL0PR02MB563373F068BC275BCB14DBE3A7E60@BL0PR02MB5633.namprd02.prod.outlook.com>
 <871s8zptow.fsf@linux.intel.com>
 <BL0PR02MB5633850DAB27466B4D5D6F44A7E70@BL0PR02MB5633.namprd02.prod.outlook.com>
 <87tvlvoaaz.fsf@linux.intel.com>
In-Reply-To: <87tvlvoaaz.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB3636;6:2qVJE4MGJ7K0zJhn+LTrBt9MHT4XBOxz+TPSDCaYBx5lBEQlcUApe9ITywS7LqJHd6E5MlhvChnHPBn9B2thIGny4X8ff/kZMSKyK+7cxTIhAeGB8rP1wXbJPhVIrxZ4RuU6zeGRPLDIX2fPfceplIupIALiXftgT44x7Ube0JR2NCRUZxhXfWwRCAglqUdqSDVyvc5JJUa6n43OTRrxCw23w/x9uMHgkopWZKizw1glPMvfpBdIuIN8/SLJ8DJRpQEXkbxjFoAfNfJ2fj9RuSz3669rB3WIFzG2RmMLd94jC40TH+yTn4nuHvqgRBbgrhPUUh5TMmGdd+X9xuZI4SVW7SRd9QsDCCcPJ8/WBQzTCVaayAocnU6tHJhlCPRE3i5vzxo1sQLBL4XjRH+9OQUEMSkklhYhNA7Nv/FCUSmB0ibMClp5cwqK7jar8Qh9TowT/YLFDHAzr1qmW0UPdg==;5:vnpwuuo2AlPmX0e8JI4YJzrecaYUOQducLBRMQOMEumI8RG/h7Stksi0jp6SIFp3OwQ3aoe9bq7pK+UyONkxFFFzVuRiTmZnrHuCpA/6JbjYCVlSb4d1IK4HQy9KZARyVOxT52eXFDahHhr/0LO8+CuqvGTt7YyPU4+pgFLdT44=;7:a2g+V9A/GSj8bDn9OlWvuaBBW0fRrKtbQm1zOt9f8MQgii//R+AePR+CE1D3Bdl2Z+CGm4GUN1qfjEa7gmEnpLaH5btoBz9fandldtOAhug6x+kduNWCv9c0QsOxclQNBKyOu72RgxjxXXrG0v9DqUSV3Mq8SarZgGLEJwNwP17EDw/k1n5wCSaUTYauB9jblYbFLOckPFMMBcjTqiMCqh2HmRAODT1s6FOGOLwySL26Gy1toX5xFgy3ylAyhacW
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: bb5cbc17-26a3-4898-0d00-08d62de73b3e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB3636;
x-ms-traffictypediagnostic: BL0PR02MB3636:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB36367395E136A90A9B21ADCAA7E70@BL0PR02MB3636.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(9452136761055)(17755550239193)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051);SRVR:BL0PR02MB3636;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB3636;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(366004)(376002)(13464003)(199004)(189003)(14454004)(305945005)(66066001)(74316002)(229853002)(14444005)(7736002)(256004)(7696005)(76176011)(55016002)(99286004)(478600001)(6436002)(5660300001)(2906002)(9686003)(6506007)(110136005)(54906003)(25786009)(53936002)(33656002)(4326008)(551934003)(2501003)(5250100002)(93886005)(3846002)(68736007)(316002)(97736004)(6116002)(71200400001)(486006)(71190400001)(11346002)(26005)(446003)(8936002)(476003)(81156014)(2900100001)(81166006)(102836004)(105586002)(8676002)(106356001)(186003)(6246003)(107886003)(39060400002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3636;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jIahS8TiUuj90wzcUAUe2R9ELxpmfPqPDNFIGeQohZd1KtHRiEWWBJ+cqhZquK529j9bdi317pTeuOxc4m9BLK65winTbe2v18JEdMUeIH2QsQeNurbxsRWwwqd4ySeu6vBhSUHVYiwTM1hF3Vvw2lF1YpAVDzSmcxg0tXSON0mY79V1fomcF0jh5my5X6ba4VaYGNPszsBYTYPrSOKf3iA2TtHUdXjQAYlvbU1vrurkf6Ewfv35SXpanikRIPnatzQ5qyowKItJ/nQd0SmqwGwNlUgE172mbF4VAH40Jt2DL8u4ZMo/k6bnl+fqOMd3cxRB11MQlKfWxR2Zx8VzYgOaph2oLYT4azlFxXd8YVc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5cbc17-26a3-4898-0d00-08d62de73b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 13:00:47.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Felipe,

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@kernel.org]
>Sent: Tuesday, October 09, 2018 12:51 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; gregkh@linuxfoundation.org
>Cc: v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; Thinh.Nguyen@synopsys.com; Ajay Yugalkishore Pande=
y
><APANDEY@xilinx.com>
>Subject: RE: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to d=
wc3
>gadget driver
>
>
>Hi,
>
>Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>>>> Please let us know if you have any suggestions / comments on this patc=
h series.
>>>> If you feel this patch series are okay, can we proceed with them?
>>>
>>>I really don't like this dwc3-specific timer. The best way here would be
>>>to add a timer on udc/core.c which can be reused by any udc. This would
>>>mean, of course, teaching udc/core about streams and lettting it do part
>>>of the handling.
>>>
>>
>> Thanks for spending your time in reviewing this patch. The reason for ad=
ding the
>> timer is when streams are enabled there could be chances for the host an=
d gadget
>> controller to become out of sync, the gadget may wait for the host to is=
sue prime
>> transaction and the host may wait for the gadget to issue ERDY. To avoid=
 such a
>> potential deadlock conditions, timeout needs to be implemented in dwc3 d=
river.
>
>"in dwc3 driver" is an implementation choice. The situation you describe
>could happen with any UDC, right?
>

Yes this could happen to other UDC drivers also, unless controller is capab=
le of handling

>> After timeout occurs, gadget will first stop transfer and restart the tr=
ansfer again.
>> This issue is mentioned in databook 2.90A section 9.5.2. I am not aware =
of how
>> other controllers are handling the streams, but since this issue looks m=
ore like a
>
>We should get in touch with other UDC authors. We have at least Renesas,
>net2280, bcd_udc and mtu3 supporting superspeed.
>

Thanks for pointing other drivers. Will refer these drivers to see how they=
 are handling streams
=20
>> dwc3 specific issue, I think it would be more convincing to add the time=
r in dwc3
>> gadget driver rather than adding in udc framework. Also we are stopping =
the timer
>
>why? When the situation you describe is something that can happen with
>any udc, why should we reimplement the solution on all UDCs supporting
>streams when we can give generic support for handling certain
>situations?
>

I agree with you. As you suggested will work on implementing changes in UDC

>> when a valid StreamEvnt is found, which would be difficult to handle if =
the timer is
>
>Why difficult? udc-core would call:
>
>mod_timer(gadget->stream_timeout_timer, msecs_to_jiffies(50));
>
>Once you receive stream event, dwc3 would call:
>
>if (timer_pending(dwc->gadget.stream_timeout_timer))
>	del_timer(dwc->gadget.stream_timeout_timer);
>
>Why is that difficult? You could even avoid anything to be written in
>dwc3 and put the del_timer() inside usb_gadget_giveback_request()
>itself. That why, dwc3 doesn't even have to know that there's a timer
>running. Also, you're timer function, instead of calling dwc3's private
>functions, should be relying on the gadget API.
>
>Your timer, apparently, should be fired per-request, then your timer
>function would call:
>
>usb_ep_dequeue(request);
>usb_ep_queue(request);
>
>If the timer expires. This would work for any UDC, not only dwc3. Then,
>this is something we document for all UDCs and they'd have to adhere to
>the API.
>
>In summary, not that many changes needed to dwc3. Nothing related to
>timers inside dwc3. Almost everythin can, and should, be done
>generically.

Thanks a lot for giving a detailed explanation. Will implement the timeout
changes into UDC core.

Best Regards,
Anurag Kumar Vulisha

