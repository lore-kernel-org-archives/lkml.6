Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86038C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AE92075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xwXIN3R+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AE92075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeIENxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:53:38 -0400
Received: from mail-dm3nam03on0049.outbound.protection.outlook.com ([104.47.41.49]:46227
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728056AbeIENxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+u6BeStYYAUeGM+p5ZgmrCJQGKurwbQ2Czza6HF2kU=;
 b=xwXIN3R+ZAnZnbhf2alovhmmnutnCqeY90qw0capLCbolr+adYUCoSosIrnjfU9JrhiqnP1/+xiOskdA6bbEz5y+kpKuM+FEPY3uUoYwFfV7ngTj7otEFEgk8GJPs6pVOvA3aBvnHSSp7GC8TcAoYFXVN1Srlxxa49u3Crqx9EE=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB0932.namprd02.prod.outlook.com (10.160.155.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Wed, 5 Sep 2018 09:24:14 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e%7]) with mapi id 15.20.1101.016; Wed, 5 Sep 2018
 09:24:14 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/8] usb: dwc3: implement stream transfer timeout
Thread-Topic: [PATCH v2 4/8] usb: dwc3: implement stream transfer timeout
Thread-Index: AQHUNiVVg4AXlbkIiUaGiqFG6/ZLBqThh6EA
Date:   Wed, 5 Sep 2018 09:24:14 +0000
Message-ID: <BN3PR0201MB099343BF037A62CD036CD4BDA7020@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1534508695-12642-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F544AB8CD@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F544AB8CD@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB0932;6:XnHb5xbr6OL1W3boqAk5t2dVxMDx8BYWwua9x4CZQFtRVUmpeGa13MJgVYecEXTEdnIkMjq4jR0U8ZRATxDZ7xVEZjtrlIwcg37rU9FL97/6ChmhO/kn3nNl8gY0xJJKdLBYRtfLFeyIt9t42F/s8Ps186ScjsVRK62oPLey2jhUYrpxE9Em+3YeJXwcShVdVQE42mZJkjkeA0mBgEdK7G4uujp5UvXv3j6NEy2ERg1gMDdKoN03kvhLENQ2bWyVpGCC3EV65pR8nN16L3qmwro4Mmj5N2R5Td4DW3H3JynfinIv7ysTeH4CORRfaV1GIpSeR1tBCnnlPea+jwK+7iOvikmGGpYCxupA26TfdhpcYIl7bw8mG9z4hMkUgVFK+nj0phRqKDfU2gHi9obGBq4FDnzC2xGbaZLD9qFx8bvLx6sDc0ejupV4n+pon64X6zMka+/B9wpCarTK2kb54w==;5:Klph3kHWr7B2lYEIraZF9CQkLicQHrdnNwSdzrELdSkyr5vcp+zOcFsAt/OW1q0keBZ97dmE51gxKwsQ6GkgX+yunfvQL/vOburjBXea/syH/jx7Tzii2GGUaBQJHRwoK50ntjPASPm7nohj/OMSqeVCyVsTDoEY6ut4+LaW0Eo=;7:tdp5/dvyIGCBK/YIvBmyyectBzP3O1fUpA6BDtVYaynGexWbop6h2ouw9/CDwg+L8/a+Tzhrt3f9voOzJsHwEV3PMCDIyis4dQMCILfa9JMPkXqtMVsuxGHPw9bHOJs+RwA1b8Yf0I0R3pmZq7iXyl6qZMIx9azKgLx27//V2Wc7tLzJLZl4oOltKdCxwMA9Gt5fLAiDHcNXo9Smh7Q4xmSuR2jP0+dmTLtHbrnPU4NJP5hvaZs2xZARWIe+ca6W
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 003166d0-d6a2-4091-7964-08d6131158af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB0932;
x-ms-traffictypediagnostic: BN3PR0201MB0932:
x-microsoft-antispam-prvs: <BN3PR0201MB093233F9B951F0C878872EF2A7020@BN3PR0201MB0932.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3231344)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BN3PR0201MB0932;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB0932;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(7696005)(7736002)(25786009)(26005)(316002)(102836004)(6346003)(86362001)(99286004)(4326008)(39060400002)(9686003)(2201001)(186003)(68736007)(76176011)(14454004)(6506007)(54906003)(97736004)(11346002)(229853002)(6246003)(110136005)(446003)(6436002)(14444005)(2900100001)(476003)(2501003)(486006)(256004)(53936002)(478600001)(81156014)(305945005)(74316002)(33656002)(3846002)(81166006)(66066001)(8936002)(55016002)(6116002)(106356001)(8676002)(2906002)(105586002)(5660300001)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB0932;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-microsoft-antispam-message-info: 1DP/34zCdM1FlqtDDGZWmDCqT5oJBdUnCiH/YmPRg3RcqXx+0X73T/YRmji3MFDgIZf4+b1yaEQNCNMRLA+0IFAm05EUnUka2bTKONz9+A1KRF/dluw1AhSv/AednYakmA8406yHuQCj99bQY80DBt7o03BthAyaskeW8DgASGmF4+SxjHTZv1gR6/Y1MyrAhjIAFCyXaRG1oBN4Z5SvyQ6RBb/LRQImybgplvOFvm7HNVXGoExpn9Q9XRswNtTLbJqoajS2FKAe9brgijn7Af/IbPetZImN+L+Ym0BoqEpuAk15+HfnN71K82bXs3SVJd/rd/a6jeY4j8Z3/b9fm9aNRP3zG5NxzgzrKbi4+DI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003166d0-d6a2-4091-7964-08d6131158af
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 09:24:14.0678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB0932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

>dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
>>  			stop =3D true;
>>  	}
>>
>> +	/*
>> +	 * Delete the timer that was started in __dwc3_gadget_kick_transfer()
>> +	 * for stream capable endpoints.
>> +	 */
>> +	if (dep->stream_capable)
>> +		del_timer(&dep->stream_timeout_timer);
>> +
>>  	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
>>
>>  	if (stop) {
>> @@ -2486,6 +2505,14 @@ static void dwc3_endpoint_interrupt(struct dwc3 *=
dwc,
>>  		}
>>  		break;
>>  	case DWC3_DEPEVT_STREAMEVT:
>> +		switch (event->status) {
>> +		case DEPEVT_STREAMEVT_FOUND:
>> +			del_timer(&dep->stream_timeout_timer);
>> +			break;
>> +		case DEPEVT_STREAMEVT_NOTFOUND:
>> +		default:
>> +			dev_err(dwc->dev, "unable to find suitable stream");
>> +		}
>Add break after this. Also, it's probably easier to read if we use if-else=
 case here.
>

Thanks for correcting the code, will fix it in next series of patch

Thanks,
Anurag Kumar Vulisha

>>  	case DWC3_DEPEVT_RXTXFIFOEVT:
>>  		break;
>>  	}
>> @@ -2587,6 +2614,18 @@ static void dwc3_stop_active_transfer(struct dwc3=
_ep
>*dep, bool force)
>>  	}
>>  }
>>
>> +static void stream_timeout_function(struct timer_list *arg) {
>> +	struct dwc3_ep *dep =3D from_timer(dep, arg, stream_timeout_timer);
>> +	struct dwc3		*dwc =3D dep->dwc;
>> +	unsigned long		flags;
>> +
>> +	spin_lock_irqsave(&dwc->lock, flags);
>> +	dwc3_stop_active_transfer(dep, true);
>> +	__dwc3_gadget_kick_transfer(dep);
>> +	spin_unlock_irqrestore(&dwc->lock, flags); }
>> +
>>  static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)  {
>>  	u32 epnum;
>
>Thinh

