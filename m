Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E031C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB485206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="C/W+vDDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB485206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeIENtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:49:21 -0400
Received: from mail-dm3nam03on0059.outbound.protection.outlook.com ([104.47.41.59]:18426
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbeIENtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zjWTCcCRjipeZv4cnfiL1ytJmywkF8AC3O4XFfnLb0=;
 b=C/W+vDDpIEQCPIuITUJV7c5LwGPKy8CaoRJ0FQZL7ruC8SL4qqeb8LaeUUYHZGoAdhnxudIC1tGr5/mI0Bg1IB20Ttx9lIX64TfWkmq7Y3MPEwSrEzdix6wth3hxTU0+o9JPhXr5fwKHVfVOOJXMmwIngU99UbvM+HO32qXKqmM=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB0932.namprd02.prod.outlook.com (10.160.155.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Wed, 5 Sep 2018 09:19:40 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e%7]) with mapi id 15.20.1101.016; Wed, 5 Sep 2018
 09:19:40 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/8] usb: dwc3: Correct the logic for checking TRB full
 in __dwc3_prepare_one_trb()
Thread-Topic: [PATCH v2 1/8] usb: dwc3: Correct the logic for checking TRB
 full in __dwc3_prepare_one_trb()
Thread-Index: AQHUNiVThZEOCvrQMkaSQCCLSEec7aThZIpg
Date:   Wed, 5 Sep 2018 09:19:40 +0000
Message-ID: <BN3PR0201MB0993325C7125DB1A084BF9BBA7020@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1534508695-12642-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F544AB897@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F544AB897@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB0932;6:VE/aRFNuzHljmOEW3sWGguBGzUxJDGzHJ0wVZXs2CKeGq96MFn5+4QG1KgV57fnHsEflP3rHLUvTqAXvl6ia6CbxVJWmhdyuGP+SkzVjOG2npFbXgvX3jwAU8fxJ7gsYEIeJyfoAc8a+Nl8onK5xEJ+2ohxFLzLLE7LBNOF5LjfSzcUhHG5dpXVZszFVNUvS5X7+5YGlrr1hxj0a0/ZseEjOzwubAIAmdwrF795JOJE3pwABw+rIgYtVp/8GOjO/DMquFla63w7D/vQKEj4f0JvYgnQdWHwdSTIOl/oQF2tT5scBsKp1sLmoTBU6IVpAFJQrQ9YMXPjxnq8s90gSdSlUVj2Xo8VoqfwBKKl+Y0pFV6uhZywjGwlXSgE1F4WMEp4SPaU26D1364fmg4vhjeWsU9n18Zp1r/TEsAfjfkp5v6n6+UiqipxHRI39J5dpaY5E4is45f4HQmjaa9HbwA==;5:Q8X6AoqxPu4iaVJy7Re1d7LOzlLTu+LhvwkWQ/X9WIed2irQ76jPL3glZZooen9dnoiHY+0+0FOqJd6t4yq+/kQQiUTszr4x8NXViPnCudptWOC6UXJ7h4aezVFBj2nGmvF2yCdoutAX2/eMNBEqRwqUZwtnBzWGbtgVKs8EYSA=;7:u8VQX9Sc+e0lf1GLgo3NehXkzUWOyNv4pJW4olkwp/zhZoWjC2GXlHFGL7T7oxMk5UnWMFAtT2V8iOLRlhOuxkFf6Zl7hQBZlH7PrVV4BvYO8Mnm9EYiJMMLicIMcztPtAMCh643tTMrtZImJPkTq57TnJu30vkXkkXIB8L+N6FRAx0Dj2maULIqd6mYZTtzI+uLXWphXTtDciePgyF0C3QOj1APj8ql+HWI4lqvnw2TZtAdTSptAOjiSbKLoN1W
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6ce9e2e9-1601-4560-fe7e-08d61310b579
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB0932;
x-ms-traffictypediagnostic: BN3PR0201MB0932:
x-microsoft-antispam-prvs: <BN3PR0201MB0932A0C2ED0A8B5EDB818D68A7020@BN3PR0201MB0932.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3231344)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BN3PR0201MB0932;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB0932;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(13464003)(189003)(199004)(7696005)(7736002)(25786009)(26005)(316002)(102836004)(6346003)(86362001)(99286004)(4326008)(39060400002)(9686003)(2201001)(186003)(68736007)(76176011)(14454004)(6506007)(54906003)(97736004)(11346002)(229853002)(6246003)(110136005)(446003)(6436002)(2900100001)(476003)(2501003)(486006)(256004)(53936002)(478600001)(81156014)(305945005)(74316002)(33656002)(3846002)(81166006)(66066001)(8936002)(15760500003)(55016002)(6116002)(106356001)(8676002)(2906002)(105586002)(5660300001)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB0932;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-microsoft-antispam-message-info: x2gwf9ME8G7EjinfZPEvhLsyuOug0ATHYHEwaKkRO7NLiSAhvesHW3/s+l5mSg2yzpXGx/QJiZ3uRimkWGuspCuOM/d1AWz7wTiNt3UGB1+OwkMn69VtgOlqx+IidMLr+3Khf1WIk4cxJPnRAszPNC5gqC1ei/x/0SiF6sIYKKAsRbl0xOMGg46tJy2bvGm2+v/8OFhN4mGjQenPP7LhRinG1d3Rxv/G6J6HkG1eYLYyuHagB5tBcfgVDraQk/0f0ljnmo6q2E41oX85aUi4w5jd06M6QkdMZv53C/y5RqMb+3Yurfa2x9srzVWMp/rAxh95q6JupOVEyGibBF1w43NKxg8vT5I1iHk0+HCTd0I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce9e2e9-1601-4560-fe7e-08d61310b579
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 09:19:40.2517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB0932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

Thanks for spending your time in reviewing this code, please find my commen=
ts inline

>-----Original Message-----
>From: Thinh Nguyen [mailto:Thinh.Nguyen@synopsys.com]
>Sent: Wednesday, September 05, 2018 11:04 AM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; balbi@kernel.org;
>gregkh@linuxfoundation.org
>Cc: v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH v2 1/8] usb: dwc3: Correct the logic for checking TRB =
full in
>__dwc3_prepare_one_trb()
>
>Hi Anurag,
>
>On 8/17/2018 5:25 AM, Anurag Kumar Vulisha wrote:
>> Availability of TRB's are calculated using dwc3_calc_trbs_left(), which
>> determines available TRB's based on the HWO bit set in a TRB.
>>
>> __dwc3_prepare_one_trb() is called with a TRB which needs to be prepared
>> for transfer. This __dwc3_prepare_one_trb() calls dwc3_calc_trbs_left()
>> to determine total available TRBs and set IOC bit if the total available
>> TRBs are zero. Since the present working TRB(which is passed as an
>> argument to __dwc3_prepare_one_trb() )  doesn't have HWO bit already set=
,
>> there are chances where dwc3_calc_trbs_left() wrongly calculates this
>> present working TRB as free(since the HWO bit is not yet set). This coul=
d
>> be a problem. This patch correct this issue by setting HWO bit before
>> calling dwc3_calc_trbs_left()
>>
>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>> ---
>>  Changes in v2:
>> 	1. Changed the commit message
>> ---
>>  drivers/usb/dwc3/gadget.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 69bf137..f73d219 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -990,6 +990,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *d=
ep,
>struct dwc3_trb *trb,
>>  			trb->ctrl |=3D DWC3_TRB_CTRL_ISP_IMI;
>>  	}
>>
>> +	trb->ctrl |=3D DWC3_TRB_CTRL_HWO;
>> +
>>  	if ((!no_interrupt && !chain) ||
>>  			(dwc3_calc_trbs_left(dep) =3D=3D 0))
>>  		trb->ctrl |=3D DWC3_TRB_CTRL_IOC;
>> @@ -1000,8 +1002,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep
>*dep, struct dwc3_trb *trb,
>>  	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
>>  		trb->ctrl |=3D DWC3_TRB_CTRL_SID_SOFN(stream_id);
>>
>> -	trb->ctrl |=3D DWC3_TRB_CTRL_HWO;
>> -
>>  	trace_dwc3_prepare_trb(dep, trb);
>>  }
>>
>How do you reproduce this issue? We should not set HWO before setting
>other trb->ctrl bits. Can you provide a driver tracepoint? If there's an
>issue with the check if ((!no_interrupt && !chain) ||
>dwc3_calc_trbs_left =3D=3D 0), then we may need to fix the check there.
>

This issue gets triggered very rarely on long runs when dep->trb_enqueue =
=3D=3D dep->trb_dequeue.
In __dwc3_prepare_one_trb() , IOC bit is set when no TRBs are available, so=
 that a complete
event can be generated and TRBs can be cleaned  after complete . Dwc3_calc_=
trbs_left() is called=20
to determine the available TRBs, which depends on the previous TRB's HWO bi=
t set when=20
dep->trb_enqueue =3D=3D dep->trb_dequeue. There are chances where the dwc3_=
calc_trbs_left() wrongly
returns DWC3_TRB_NUM -1 instead of 0 , even though there are no available T=
RBs. Please
consider the below example

1.  Consider a TRB passed to __dwc3_prepare_one_trb() is the last available=
 TRB in the pool.=20
2.  __dwc3_prepare_one_trb() calls dwc3_ep_inc_enq() which increments the d=
ep->trb_enqueue
   before preparing the TRB and since the current TRB is the last available=
, incrementing
  dep->enqueue will make dep->enqueue =3D=3D dep->dequeue=20
3. IOC bit is set by __dwc3_prepare_one_trb()  only when dwc3_calc_trbs_lef=
t()  returns 0 (empty TRBs)
4. Since dep->enqueue =3D=3D dep->dequeue and the previous TRB(the one whic=
h we are working)
    doesn't yet has the HWO bit set, dwc3_calc_trbs_left() returns DWC3_TRB=
_NUM -1 instead of
    zero (Though there are no available TRBs)
5. Since  Dwc3_calc_trbs_left() returns non-zero value, IOC bit is not set =
in __dwc3_prepare_one_trb()
   for the last TRB and no complete event is generated. Because of this no =
further TRBs are queued.

To avoid the above mentioned issue, I moved the code logic for setting HWO =
bit before setting IOC bit.
I agree that HWO bit should always be set at the last, but I didn't find an=
y better logic for fixing this.
Please suggest if any better way to handle this situation.  =20

Thanks,
Anurag Kumar Vulisha
