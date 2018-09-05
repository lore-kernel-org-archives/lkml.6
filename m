Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE5BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9D42075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="04sR8r4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9D42075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeIENvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:51:00 -0400
Received: from mail-dm3nam03on0086.outbound.protection.outlook.com ([104.47.41.86]:59552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbeIENu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfz8SW3zEkqMZlmFjgK075fHllq6Fw1qcjqE1y6ujiM=;
 b=04sR8r4zyVBRzjJ117gPrRCTP/uS1oz9whrywLSZh2Jt9hlH8C0ouQyUXwdi24Mxlhl2xeRyLcNLAxchwtXxw/uzG9ULpsoXBV/e+K/A3STPPT5toROQi/d9mghV4B8t6CEklPhZtR7KDLFJKFfmowChrDwcQq8h8jENkC/IiyI=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB0932.namprd02.prod.outlook.com (10.160.155.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Wed, 5 Sep 2018 09:21:34 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e%7]) with mapi id 15.20.1101.016; Wed, 5 Sep 2018
 09:21:33 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/8] usb: dwc3: make controller clear transfer
 resources after complete
Thread-Topic: [PATCH v2 3/8] usb: dwc3: make controller clear transfer
 resources after complete
Thread-Index: AQHUNiVVrYzEd/MLO0Wv5fDm3NztnKThhvBA
Date:   Wed, 5 Sep 2018 09:21:33 +0000
Message-ID: <BN3PR0201MB0993768965D7E7C08B33E4FFA7020@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1534508695-12642-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F544AB8AB@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F544AB8AB@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB0932;6:NkOYx8vVFTCFXEAfwkvEiXmQUWrW8fn7NfXCUMd/5dqgWpSRH5w7ZDNwakiHxUal1u4GAJxfA1zHxXA/2VP1cT/724UyLKSvq/FNvYEBW116WrOT17c6YyRY/Fy4czv6tCggQzw1kAzVOCaEVlOPXHdA7zWOXt9tlnAwk2qDV4ve6h1+nHaJ0P51QY8G+vAzlIXGWafbZOWVQbngV4mEXVRUNwTOoqnb2ZXC44SMbw9o50vuJWk4Kj+aRmJ8GA80KrRi8NbpH/vew9Ch0aabpqARCRstaV7NyCsStyi8wW9aSTmHCIHuwhWtsZNp+N+1DlF8VISfwfH3DKVeDsxyxxL2wmRyMa6MDtv88FS1Ht10C598nppdw54qVsXay+tLzmUAe1ycvX1yVPc3L3/E0i/0HC3cdla9AOxEIpRaH0sPH4Ri/b5soji0rWbYG4DP5HP8+xeCDiaIbTquZS5LPA==;5:B9fx3A6qrYi8HLK0/mXnjX5xX3F3sxt/yOEXOPdOqPoV75l1SlMqlK1BG/s96W0xXfnw1n3QJWAan7LuKMR7RXBYq6E6pY8g3jDsqpq1I24PEi8oS2Fl7VlsmUtpLzhZ9S6cPSDFRcWPU+5OmiMZ/oeE+9zISlREUpI5Ym/Hovg=;7:ayQ3q+WYQpJCexCv5cfmuJRAFEkSj6eTlN8aAIYU3oP9LUAitq9NZqntYElU2PgsSeoi2M2cIJNLsoyrQ/2agG1Rx1SJr43Rr2r4T+tzG34Ibwr1raZrt9vHBzBMhcF7CsXoJQ4QckNITnrKipzdlBfgxDE7oF7IkboHgQAK9mfJbdIznCra/zXu4LD/+JfVI++dSWrSEI3NM1oW9TJfWymLqN7syi2Swsyx/Ijl3r1Q9rCFuReEfnx9wBGdSmoj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d9bb5b3a-8a88-4e7b-8eaa-08d61310f91b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB0932;
x-ms-traffictypediagnostic: BN3PR0201MB0932:
x-microsoft-antispam-prvs: <BN3PR0201MB09328A16A73861FA75BB5FDDA7020@BN3PR0201MB0932.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3231344)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BN3PR0201MB0932;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB0932;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(7696005)(7736002)(25786009)(26005)(316002)(102836004)(6346003)(86362001)(99286004)(4326008)(39060400002)(9686003)(2201001)(186003)(68736007)(76176011)(14454004)(6506007)(54906003)(97736004)(11346002)(229853002)(6246003)(110136005)(446003)(6436002)(2900100001)(476003)(2501003)(486006)(256004)(53936002)(478600001)(81156014)(305945005)(74316002)(33656002)(3846002)(81166006)(66066001)(8936002)(55016002)(6116002)(106356001)(8676002)(2906002)(105586002)(5660300001)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB0932;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-microsoft-antispam-message-info: Kl2yYYDKh9HlMnDLqczncLh+kGnQJ5u1BdbfBmzQH8QPzW28SLOhsoKasRD1Nr8PCODTC5DDpEGEFKybkwuPe9NCIbx+F6IX57QU7Ndf39GMP7lKopcb5V5hCNG4ck/evOTvgZfM+2ojPSlmwnf6n4BWvSX3gGP/hJS3QferL1s1Nf2dB86+0Qx9dYRzC6nHrfmTS0ZVlHjVE5EuIXdkGeJ1qsnPgns8gjZpvo2riGJoHnpL5Yqso5g3cUvIPo/BfNG7DVXESfYAk6ir22lrjCvZSGojCWhFFwmAt7oTrLb7xzTBwILLESOJTwcuQETGC4tFuuOPobOLg/7m7QZimnt3WsGQwIuU+pcArp+PCJQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bb5b3a-8a88-4e7b-8eaa-08d61310f91b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 09:21:33.7139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB0932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thinh,

>> +	 * To issue start transfer on another stream, controller need to free
>> +	 * previously acquired transfer resource. Setting the LST bit in
>> +	 * last TRB makes the controller clear transfer resource for that
>> +	 * endpoint, allowing to start another stream on that endpoint.
>> +	 */
>> +	else if (dep->stream_capable)
>> +		trb->ctrl |=3D DWC3_TRB_CTRL_LST;
>> +
>>  	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
>>  		trb->ctrl |=3D DWC3_TRB_CTRL_SID_SOFN(stream_id);
>>
>> @@ -2268,7 +2278,7 @@ static int
>dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
>>  	if (event->status & DEPEVT_STATUS_SHORT && !chain)
>>  		return 1;
>>
>> -	if (event->status & DEPEVT_STATUS_IOC)
>> +	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
>>  		return 1;
>>
>>  	return 0;
>> @@ -2457,6 +2467,10 @@ static void dwc3_endpoint_interrupt(struct dwc3 *=
dwc,
>>  	}
>>
>>  	switch (event->endpoint_event) {
>> +	case DWC3_DEPEVT_XFERCOMPLETE:
>> +		if (!dep->stream_capable)
>> +			break;
>> +		dep->flags &=3D ~DWC3_EP_TRANSFER_STARTED;
> Add this:  /* Falls Through */
Thanks for correcting, will fix it in the next version of patch

Thanks,
Anurag Kumar Vulisha

>>  	case DWC3_DEPEVT_XFERINPROGRESS:
>>  		dwc3_gadget_endpoint_transfer_in_progress(dep, event);
>>  		break;
>> @@ -2472,7 +2486,6 @@ static void dwc3_endpoint_interrupt(struct dwc3 *d=
wc,
>>  		}
>>  		break;
>>  	case DWC3_DEPEVT_STREAMEVT:
>> -	case DWC3_DEPEVT_XFERCOMPLETE:
>>  	case DWC3_DEPEVT_RXTXFIFOEVT:
>>  		break;
>>  	}
>
>Thinh

