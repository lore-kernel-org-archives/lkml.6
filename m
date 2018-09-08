Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E84C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 03:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B5E20855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 03:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PaDctZFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B5E20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeIHId2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 04:33:28 -0400
Received: from mail-sn1nam02on0085.outbound.protection.outlook.com ([104.47.36.85]:3480
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbeIHId2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 04:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnN3pnpAP8C6X3Wod657Clt8AABihqp1KJYSbm9XlR4=;
 b=PaDctZFBoDisY7pKw8Rr09/eZWd6muzWYTyDU+miiLWokiR5mo0pYGWC4gaxByGJw+kAnlneZx83k69J5XbprR0vYKBWH6nkwlLGSeWGOsX+x2Kv6nvP7yHwm8dqR97S1ppExnMGuTEqtFECkUF7pokNW++zOAHNpc6rjPHouyI=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB0867.namprd02.prod.outlook.com (10.160.154.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Sat, 8 Sep 2018 03:48:58 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e%7]) with mapi id 15.20.1101.016; Sat, 8 Sep 2018
 03:48:58 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: RE: [PATCH v3 4/8] usb: dwc3: implement stream transfer timeout
Thread-Topic: [PATCH v3 4/8] usb: dwc3: implement stream transfer timeout
Thread-Index: AQHURqy2XdgImSxcKE+4+6HL+fInlqTlvogg
Date:   Sat, 8 Sep 2018 03:48:58 +0000
Message-ID: <BN3PR0201MB099333AF66E6D205AD1520EEA7070@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536326029-16327-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F544AD89B@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F544AD89B@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [182.18.177.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB0867;6:RzkXyfgBQ5sbDYb0S97A4D8YjZ7mQqH/4t/q1Z4HLpsqZeCVg8w7deQMOHVV6FWSSdvHk0NDxfIKTHxqWS9TkvawXGMHmpRv/a8hHIooyBRO11P7Wco92ePS5C4K+P4KCL4iR+63YdDTdzVTxWHFE/dkkd2DB8TCVrSmTCnOMvD/tnOcL1wuIrX5uu81271qc3JlDub8xp97CNjHpIpRHIEwXmEwOrCySFW0Gxs40hEoBq7QyruxB97fYZxItU/uJy9uvkyvvMBb9DCsc+bwCDDgsTeqA6qhNdSbCJlR64Pfn0K0I6GZZis7UOiFi6+jq35FgZUCSDiLflyqTXLJwKfEqjlPQYiZTE801USbLHlEC1a290iwZpaSDAPiuB0gtWaCXLYgVedyzR/D3jZLEEGRKN6CWnGTtMhSg/EJ7tW2Lnq16xgawKdmVyrSWpzRnZcz1nSy7wJIkwjtpk9IXA==;5:/vN1AI8MpWo7wMrGOlHbZTpgbkvOTkUrKnEnXo4QTz8UGB4C0WJ8PBzvuUwODBr+rinLBlwsSALKaoRW4xAIWapko15ZIYy0ZeGlIxrTADmyGByiQP8OZ8j6U/4r85DJCAjQA35P9zpNZ8bZznVDHyv1526xqMNgADIz/k1rJc0=;7:14R830eg/6X0CTBP43tgjioxM31QWEv2pO4BVOs/H6hGFoaAW3uiiin5D6rdkaE93BkhsV7U2wGsSK5R7fFq5J7nl0EtnqIWBHyjjnIoTQqY/F0jZoFpEkg5X1T+oQYmPyfjg52cj3g+Xgv2Z5MD4jHit29F2WBs4pc2oLAQ081lXPA68SuG/OqNLTZUQTAv5lQUgxpgZHgERWhX+8oJSzmNzjiYZZRzLphsp0VnF3dDQBiabwmUtePoK/tasP2w
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ff052d4e-18b7-44a4-86de-08d6153e022c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB0867;
x-ms-traffictypediagnostic: BN3PR0201MB0867:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB0867B86A0EDF7A897B4D57D0A7070@BN3PR0201MB0867.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BN3PR0201MB0867;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB0867;
x-forefront-prvs: 07891BF289
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(54906003)(2900100001)(106356001)(3846002)(6246003)(105586002)(68736007)(8676002)(256004)(33656002)(110136005)(6116002)(39060400002)(76176011)(7696005)(81156014)(2201001)(8936002)(14454004)(81166006)(86362001)(2906002)(99286004)(66066001)(2501003)(7736002)(305945005)(5660300001)(5250100002)(26005)(9686003)(186003)(53936002)(55016002)(316002)(476003)(446003)(11346002)(486006)(25786009)(97736004)(74316002)(478600001)(229853002)(4326008)(6506007)(102836004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB0867;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: leV9owunBRUbR1su2PeP7pNdLwB43oaWIM9Mmfugm2tTBqY9BsdZ3KlMNJICn3iPgBQ5dapJOJuox45NbZnJdDsw4wjoEkwm+wmLMBf5nExL25d/ixcedZ4t46Xi3s2eAbiuwmcc27nEdJCxNUWMG+R7yCQf7qVZEXESnxY+/3zVGack5NvcZnW1kHNHpIMexyG349gDzoRvlv5Wh6cRcBH43byH/JlXIZb2XsIAScFHU0/kEAQ6pix7dIQh49lKUG8j5OSNBa0Ti2XTaI8rUcoeU7sH0b2VU+h+j4yy2PC7HqbJF7rVYZ7hsGb/jC8TaoeryjFi2O+hxBBEyec0Z6AtOrO31uGUcS4I2bM22zA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff052d4e-18b7-44a4-86de-08d6153e022c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2018 03:48:58.2257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB0867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


HI Thinh,

>> ---
>>  drivers/usb/dwc3/core.h   |  7 +++++++
>>  drivers/usb/dwc3/gadget.c | 36 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h index
>> 5bfb625..0b255e97 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -633,6 +633,11 @@ struct dwc3_event_buffer {
>>
>>  #define DWC3_TRB_NUM		256
>>
>> +/*
>> + * Timeout value in msecs used by stream_timeout_timer when streams
>> +are enabled  */
>> +#define STREAM_TIMEOUT_MS	50
>> +
>>  /**
>>   * struct dwc3_ep - device side endpoint representation
>>   * @endpoint: usb endpoint
>> @@ -656,6 +661,7 @@ struct dwc3_event_buffer {
>>   * @name: a human readable name e.g. ep1out-bulk
>>   * @direction: true for TX, false for RX
>>   * @stream_capable: true when streams are enabled
>> + * @stream_timeout_timer: timer used to aviod deadlock when streams
>> + are used
>
>Change aviod -> avoid. Also, the timer is being used when there's a deadlo=
ck rather
>than to avoid it. You probably need to explain what deadlock it is if you =
mentioned it
>here, but I think it's ok to simply say timeout timer for streams (unless =
Felipe has any
>objection).

Thanks for correcting again , will fix it in the next version of patch,

Thanks,
Anurag Kumar Vulisha
