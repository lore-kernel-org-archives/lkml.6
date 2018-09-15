Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3609ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656062086B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3NOLWjq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656062086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeIOSjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 14:39:24 -0400
Received: from mail-co1nam03on0070.outbound.protection.outlook.com ([104.47.40.70]:18560
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727028AbeIOSjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 14:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1uBbKqS/LZE0U2XzVVFJWG06iQ8e/U6xVL5mEVt/gc=;
 b=3NOLWjq+/wgjhaf0I9Cp/eNa/QPigP0NEjFUZtcB13qhrXp7GYzplo6UE7UX0FMbX7MJMaiJBwXXPIyOiKuTKMvGYbSrq6BOOXUWkF7tyWHGngY86OMLXIpmXfFUHnIuH5fgxMN5963mNBPm1+67rtek78iX57BIIpuAS3LCM7U=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB0929.namprd02.prod.outlook.com (10.160.155.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Sat, 15 Sep 2018 13:20:18 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e%7]) with mapi id 15.20.1143.017; Sat, 15 Sep 2018
 13:20:18 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: RE: [PATCH v4 4/8] usb: dwc3: implement stream transfer timeout
Thread-Topic: [PATCH v4 4/8] usb: dwc3: implement stream transfer timeout
Thread-Index: AQHUR4UWRB/re03360KpnUerBO1A9aTxXf+Q
Date:   Sat, 15 Sep 2018 13:20:18 +0000
Message-ID: <BN3PR0201MB0993B7CC13E3042415127FE0A7180@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536418986-16609-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F544AECB6@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F544AECB6@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB0929;6:C9niIoYApyJHbrkBbbJlbNYLUDXXE2JjIhAqIw++RruOEm2+9MuGVJVGm4r3ZFZY+um6J2j+qsi0+keOBrvbxxcrWqYV0GLzl9JGRjVx8eFpcimoVO0xQQuCFBeryqwa8ru2Oe+vQ8EeejD+CMi9ITBlWA1sY2i/mVKUtv4ijgEq4/XP5LE4rXYHSjVmGLE4ZOw8UmnhHoZW/L7YBRQntpCM1sdEp6VTLVPnl/EeFPt8hGGJagJNxyqnTPBJh3oYlOADeAY5qviRPjR1JDnx5qKiV1caGWlCAPzsKPn0njXJISCplQVkzGlkB9Q6TKSGXKO+WQbjFXAEdWx3mb56s/usHxugFITKWX2rfaLGeYm6ld6qBq+PxE31KFlVdgKSCZngznRWyfREhHcRLirySQKu3p/mCTFDokzuT+SwWkN8sl42pYmieh5updYcUjwyajQyLGw0Up6Q4WxWqK0t6g==;5:KUCJl3x8zDgeey2C5a/sf+Miy10ssfdMmVJxxltpvGedZuE6QNvMFSOgo3IwFFzY6rz9/VnNivAupb4fQPPnOg2vPhWQpoKPbGy6obkmWubChjfAq/RuVCvHQBft+kJnx4NdGEU2RyqHWRVVcU+urKO08uwpePXlcoJNpcmKMGU=;7:/OS07TBe1EzaLBBGmHY9kZdos7LDRijjaI4oU36m3idccJ+rkKLUGSzq+tG+J5e6pkOGlkcXtyYipI9dFXTuB0bo5goF5B1pChFIjw6S0DRYY3VFnXh48QDx6DYKLDH9s9/zH+06PrqJj4CjP9U4wug6XGWMvQuBD8ue5aaHKQE0z/HAllhjP89qtWOv5ED//k9UkmbNVexu3IrRDIECJcHj2O9WODnPRlZvpb1wOr9etV4Gsib5uq8m3saVuI5q
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cafb4348-e138-4d9d-4a52-08d61b0dfb42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB0929;
x-ms-traffictypediagnostic: BN3PR0201MB0929:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB0929396D61A4CF0B74F5214FA7180@BN3PR0201MB0929.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BN3PR0201MB0929;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB0929;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39850400004)(136003)(366004)(199004)(189003)(14454004)(3846002)(68736007)(2900100001)(6116002)(105586002)(33656002)(53936002)(106356001)(2906002)(5660300001)(6246003)(478600001)(25786009)(66066001)(39060400002)(7736002)(81166006)(74316002)(6436002)(4326008)(8936002)(55016002)(102836004)(305945005)(186003)(256004)(76176011)(97736004)(9686003)(81156014)(2201001)(316002)(486006)(86362001)(99286004)(5250100002)(26005)(54906003)(476003)(11346002)(7696005)(6506007)(14444005)(229853002)(110136005)(446003)(8676002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB0929;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e2HiuVinM4yddi2IgZd5zcFmlBwdxBEdXNGklEBLuBVGgXu8FC6sHwBxgCz330L0hI9B+vLSlNYnyc6im+HWKQ7uS6bMltH5y6fDien7QY2Fu/1q6tBjGHkCJPYNosnDvzSTSxZtsLmZZ/uN3Qn3ZU+MR5pmSDJ5y7BaJoPht5SrOr6FnkoxchyzGpxHeUh4c5UuWv+zwtPtKT8K46gU1qqYWvxTStig+tHCN8V8QRVePiS0LFxVgv7r9FBAO0I6mliOcc8xkS61SRfQqqN/G3ZhxswjX0GqRwk8sQSiNSn2v3ZoJDrSvAjYT/2HxWodPNHJQVqX6bnm78hD8CAlXaonLJF8AXWqM83Ac5GXhTQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafb4348-e138-4d9d-4a52-08d61b0dfb42
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 13:20:18.2213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB0929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

>>
>> @@ -2403,6 +2424,13 @@ static void
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
>> @@ -2487,6 +2515,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *=
dwc,
>>  		}
>>  		break;
>>  	case DWC3_DEPEVT_STREAMEVT:
>> +		if (event->status =3D=3D DEPEVT_STREAMEVT_FOUND)
>> +			del_timer(&dep->stream_timeout_timer);
>> +		else
>> +			dev_dbg(dwc->dev, "unable to find suitable stream");
>
>This debug message is already printed in the driver tracepoint. There's no=
 need to
>print it here. Also, I don't think Felipe will accept adding new dev_dbg()=
 after removing
>all of them and converting them to tracepoints.
>

I agree with you, thanks for correcting. Will remove the debug prints and r=
esend the patches

Thanks,
Anurag Kumar Vulisha
