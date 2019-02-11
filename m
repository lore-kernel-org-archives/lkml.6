Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F633C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160FE21A49
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="S9sJVl9r";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="UrZ2KlK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfBKM4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:56:44 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51550 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727106AbfBKM4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:56:44 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BCmkA5029093;
        Mon, 11 Feb 2019 04:56:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=HQqSuRLMC4uqOrxJBv4Aj6S8OPNWRU//P+jz/Zkdu3M=;
 b=S9sJVl9rV97lG65L5z0HL3VpR0J/qGeGOf6LdgCreJVRVjN3zbeCvT2vWYvE0RPF/lbK
 Q1elieieSkQGElZelc8i2Q5hZKL8wY/TBz3QM27VDhAjQvoE2YLgP0LsntbQEuYbsMVX
 cPS23FJGhH2lyRItlfI8ZkHmpFMeqDMXEIZOZEOZd2I+COvLwSwOgYLZD93z1rSS5I/N
 +e4UXjf/7Z+M1FRXNMqsntHxY4kLHswhPH9SvJlh/3dBm6ZwVKBaE7+dYLtDjDo5GAuh
 pMhp//ucmxpC3s0Tr9eKIve+ogolffGFxqti2vQckByfGZI4tdke0D70OatIBuuZybKk qA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2054.outbound.protection.outlook.com [104.47.49.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qhuaxrdbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 04:56:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQqSuRLMC4uqOrxJBv4Aj6S8OPNWRU//P+jz/Zkdu3M=;
 b=UrZ2KlK6QJctIco0AnAqkRsUAQkNUN0i7PhggV0z0a7wd7hPeczYNBYBIyfX1BwC2GY5xII3XsAA8FXtLzB3ikAEnSaSa3SlYSS9Gv4hA68P5+L/gjJNJaYwNKDPVuFsGKjmW7k2Qx1o/7ADAPdPvzRJgPRXcF3F62ubE2OfgxE=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4197.namprd07.prod.outlook.com (52.135.223.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Mon, 11 Feb 2019 12:56:25 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 12:56:25 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v3 2/6] usb:common Separated decoding functions from dwc3
 driver.
Thread-Topic: [PATCH v3 2/6] usb:common Separated decoding functions from dwc3
 driver.
Thread-Index: AQHUuVupTx0ci+BG90KsaLISdJHpa6XPi2kAgAAqdQCACuQvoA==
Date:   Mon, 11 Feb 2019 12:56:25 +0000
Message-ID: <BYAPR07MB4709A40204EF528F8A04E1EDDD640@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-3-git-send-email-pawell@cadence.com>
 <20190204114502.GA28608@kroah.com> <87y36vmyeb.fsf@linux.intel.com>
In-Reply-To: <87y36vmyeb.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjlhMmM2YWMtMmRmYy0xMWU5LTg3MmUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDY5YTJjNmFkLTJkZmMtMTFlOS04NzJlLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNTE0OSIgdD0iMTMxOTQzNjMzODIyNzE5MDIyIiBoPSJVcjgwVWtYMXdFSkdHekZBRUQvbVR5OWRxUTA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4197;20:rKMV0GB2qfXLQ5ex1viAz3/aQ+VX4HqMPuaUKo0nWBR4sT5myVkek50rRkGW4We9Rq8Uvvs3TUY24Xyc9SfJi3p2BLp8IB16nsITjx2ibNNFz3xZNMjY7CD+tFLPAMmW59/uHGfX8GEVaIoRN5QqHBzpgnTDhIegRZpIuc7tcb8wx5cOn9pBCDa93SlymDch0LablcE15em2H8AMCXZi4V/DsXLpPbeR/Qj/2haXWGMRzkK02DfGAIpq1dM57BKC
x-ms-office365-filtering-correlation-id: 866bdb5e-4e97-44df-721b-08d6902054d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4197;
x-ms-traffictypediagnostic: BYAPR07MB4197:
x-microsoft-antispam-prvs: <BYAPR07MB41970B2FD058D4887F3B324EDD640@BYAPR07MB4197.namprd07.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39850400004)(396003)(366004)(346002)(36092001)(199004)(189003)(7696005)(6506007)(102836004)(76176011)(14454004)(7736002)(8676002)(186003)(71190400001)(33656002)(14444005)(478600001)(26005)(71200400001)(53936002)(305945005)(66066001)(8936002)(81156014)(81166006)(93886005)(256004)(3846002)(486006)(6116002)(25786009)(55016002)(446003)(7416002)(97736004)(476003)(9686003)(54906003)(316002)(106356001)(2906002)(105586002)(4326008)(11346002)(107886003)(6246003)(99286004)(86362001)(229853002)(74316002)(68736007)(110136005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4197;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S8oLVw8rfE0BU6GAzpO0qNU1KTmKMiM3QAm9xxIMVSbT1H2lwHSJLDxFXkCFWkJQwkat9kZlVrtCk400bv1+jTVN0gSMlxRx3m5fp8KMJyibbZ2WMxT0/GEqOTy95oqCjYcGp2KVoZIqfp4BHMQQD4CsPmuSjk0SkoiLd0qG6bihuy0E8YmGutSx6hyL+UOzVcOTqaook9zGNfhPO6s/trrzfS16M3O/PsJxc7yZsCK5Y3YwEmg3vt08d/SUqy/lGNwozxHKNN++Vo4QM8xZZ4zPul2X0He7hBE73WGbQ5qI0JJfckERMMpyR46WmA7hfOTNG+iMdIf2vPl+jBFqfM/zVPYsaNMcQDFaf5hNRyoVkdxjCBtgN7n9M3h0pDxewcXvoAzrpEWWV9ND5nVBN6BVo4ATQhsLDGol0HK4CSo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866bdb5e-4e97-44df-721b-08d6902054d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 12:56:25.4611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4197
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>Greg KH <gregkh@linuxfoundation.org> writes:
>> On Thu, Jan 31, 2019 at 11:52:29AM +0000, Pawel Laszczak wrote:
>>> Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
>>> to driver/usb/common/debug.c file. These moved functions include:
>>>     dwc3_decode_get_status
>>>     dwc3_decode_set_clear_feature
>>>     dwc3_decode_set_address
>>>     dwc3_decode_get_set_descriptor
>>>     dwc3_decode_get_configuration
>>>     dwc3_decode_set_configuration
>>>     dwc3_decode_get_intf
>>>     dwc3_decode_set_intf
>>>     dwc3_decode_synch_frame
>>>     dwc3_decode_set_sel
>>>     dwc3_decode_set_isoch_delay
>>>     dwc3_decode_ctrl
>>>
>>> These functions are used also in inroduced cdns3 driver.
>>>
>>> All functions prefixes were changed from dwc3 to usb.
>>
>> Ick, why?
>
>moving dwc3-specific code into generic code.
>
>>> Also, function's parameters has been extended according to the name
>>> of fields in standard SETUP packet.
>>> Additionally, patch adds usb_decode_ctrl function to
>>> include/linux/usb/ch9.h file.
>>
>> Why ch9.h?  It's not something that is specified in the spec, it's a
>> usb-specific thing :)
>
>agree.

Similar as usb_state_string function from include/linux/usb/ch9.h which=20
"Returns human readable name for the state", the usb_decode_ctrl function=20
make the same but for standard USB request.
USB Request is usb-specifing thing.=20

If my idea is not correct, can you suggest where this function declaration =
should be moved.   =20
>
>>> +/**
>>> + * usb_decode_ctrl - Returns human readable representation of control =
request.
>>> + * @str: buffer to return a human-readable representation of control r=
equest.
>>> + *       This buffer should have about 200 bytes.
>>
>> "about 200 bytes" is not very specific.
>>
>> Pass in the length so we know we don't overflow it.
>
>agree.
I also agree and I will add such parameter.=20
>
>>> + * @bRequestType: matches the USB bmRequestType field
>>> + * @bRequest: matches the USB bRequest field
>>> + * @wValue: matches the USB wValue field (CPU byte order)
>>> + * @wIndex: matches the USB wIndex field (CPU byte order)
>>> + * @wLength: matches the USB wLength field (CPU byte order)
>>> + *
>>> + * Function returns decoded, formatted and human-readable description =
of
>>> + * control request packet.
>>> + *
>>> + * Important: wValue, wIndex, wLength parameters before invoking this =
function
>>> + * should be processed by le16_to_cpu macro.
>>> + */
>>> +const char *usb_decode_ctrl(char *str, __u8 bRequestType, __u8 bReques=
t,
>>> +			    __u16 wValue,  __u16 wIndex, __u16 wLength);
>>
>> Why are you returning a value, isn't the data stored in str?  Why not
>> just return an int saying if the call succeeded or not?
>
>There is one detail here. The usage scenario for this is for
>tracepoints. When dealing with tracepoints we want to delay decoding of
>the data into strings until print-time. I guess it's best to illustrate
>with an example:
>
>DECLARE_EVENT_CLASS(dwc3_log_ctrl,
>	TP_PROTO(struct usb_ctrlrequest *ctrl),
>	TP_ARGS(ctrl),
>	TP_STRUCT__entry(
>		__field(__u8, bRequestType)
>		__field(__u8, bRequest)
>		__field(__u16, wValue)
>		__field(__u16, wIndex)
>		__field(__u16, wLength)
>		__dynamic_array(char, str, DWC3_MSG_MAX)
>	),
>	TP_fast_assign(
>		__entry->bRequestType =3D ctrl->bRequestType;
>		__entry->bRequest =3D ctrl->bRequest;
>		__entry->wValue =3D le16_to_cpu(ctrl->wValue);
>		__entry->wIndex =3D le16_to_cpu(ctrl->wIndex);
>		__entry->wLength =3D le16_to_cpu(ctrl->wLength);
>	),
>	TP_printk("%s", dwc3_decode_ctrl(__get_str(str), DWC3_MSG_MAX,
>					__entry->bRequestType,
>					__entry->bRequest, __entry->wValue,
>					__entry->wIndex, __entry->wLength)
>	)
>);
>
>The above is the code is today (well, I've added buffer size as an
>argument). If I make dwc3_decode_ctrl() return an integer, I can't call
>it from TP_printk() time. I'd have to move it to TP_fast_assign() time
>which is supposed to be, simply, a copy of the necessary data. IOW, I
>would have this:
>
>DECLARE_EVENT_CLASS(dwc3_log_ctrl,
>	TP_PROTO(struct usb_ctrlrequest *ctrl),
>	TP_ARGS(ctrl),
>	TP_STRUCT__entry(
>		__dynamic_array(char, str, DWC3_MSG_MAX)
>	),
>	TP_fast_assign(
>		dwc3_decode_ctrl(__get_str(str), DWC3_MSG_MAX,
>				ctrl->bRequestType,
>				ctrl->bRequest,
>                                le16_to_cpu(ctrl->wValue),
>				le16_to_cpu(ctrl->wIndex),
>                                le16_to_cpu(ctrl->wLength));
>	),
>	TP_printk("%s", __get_str(str)
>	)
>);
>
>Essentially, we end up moving decoding of the tracepoint to the time it
>is captured; IOW, we reintroduce regular latency of string formatting.
>
>What we could do, is move all functions called by dwc3_decode_ctrl() to
>return int, but leave dwc3_decode_ctrl() returning a pointer to str just
>so we continue decoding the data at printing time.

I will try to change these functions in this way.=20
>
>--
Thanks=20
Pawel
