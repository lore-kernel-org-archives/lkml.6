Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76E9C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E922145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Iy0hVQgL";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Bq/qT66S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfBEIOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:14:03 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:49494 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbfBEIOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:14:02 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x158CFt7024340;
        Tue, 5 Feb 2019 00:13:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=l/bt7CTQpmjOn3DSR10KhHGiBiEoh5Ka4Srs6cY1GJk=;
 b=Iy0hVQgLLZt9hsePOfCidv/Ob5HAOO0DYP8HIN//umzu9bwKtky7CmmETzR4zbWNpPQw
 iZumFwe9qh6XCS3vtEP9diWrge77cTALHSQwdz8XfO02udAhzSig0t9gPo/oWlItBtar
 6SwDkIsyzehOVj75oqwQmD+Cda7lZKWjRQ7XcbJap6iw2/HhPsIu205Fytwjx7/Npabt
 ZqpqyTLPaK95K3rR/lTnOVrzydUim2/vNleaodI4+KL1r+tnnuJ+B/m1+D4Grlc0XktH
 C4QqvmtRJ3+xPv5YMS+cF9yli88TI78Ya6DXkcRh48ACoFm+wSOvlodsCzgK4NL9uW/h Jw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qd8mwaesa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Feb 2019 00:13:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/bt7CTQpmjOn3DSR10KhHGiBiEoh5Ka4Srs6cY1GJk=;
 b=Bq/qT66S2m3+OLY6icugWxICmMI7qIrsaEauAkaSPX4FqbSC/lHmwNx/AW1+IlMLHrN3rO1aG0IzYWr6gPlXeqeVRjAAT8HlOK/hj8eilHqG3BSyAP73BOF7fiSHNiBudRF8K9mxUZzggUw7XWys0q0C05ubl8CorE542iAAmh8=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4550.namprd07.prod.outlook.com (52.135.225.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Tue, 5 Feb 2019 08:13:32 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a%4]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 08:13:32 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Thread-Index: AQHUuVupTx0ci+BG90KsaLISdJHpa6XPi2kAgAFOoVA=
Date:   Tue, 5 Feb 2019 08:13:32 +0000
Message-ID: <BYAPR07MB4709F763E5F1823520FB2AF1DD6E0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-3-git-send-email-pawell@cadence.com>
 <20190204114502.GA28608@kroah.com>
In-Reply-To: <20190204114502.GA28608@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZWI0MGIzN2QtMjkxZC0xMWU5LTg3MmQtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGViNDBiMzdlLTI5MWQtMTFlOS04NzJkLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzYwNiIgdD0iMTMxOTM4MjgwMTAwMjgxMTI1IiBoPSIwTXRSZFFIRENXSk5hemUzS0toVUVFUEZpZEk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4550;20:IjlKoV2oguKhV6hWwMjIYeYErxYs94C7LWMaks8tCeKydmlfzERk11bAUq+4iTbKWDI38aqEmUGZKa1G3ti6zinEWQEWG/jOnwU5/R3OsZt6/ze/h2PeOWkg/0t+qR+6RHWWXbxYtqtX3dXSNXceqBmgjy8ky2f7wnNFW06P9Ecv8l4HUwWvcPC2etCGWe2lGpbbnP68AaT5PCMxCbxXaLdNBkgkUNAU55AXGR+8AIoyNmPb9TiDUz2St/U20+Hu
x-ms-office365-filtering-correlation-id: 744a5371-a447-4c29-b9e1-08d68b41d15d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4550;
x-ms-traffictypediagnostic: BYAPR07MB4550:
x-microsoft-antispam-prvs: <BYAPR07MB45506CC471E8CBF63574D5A5DD6E0@BYAPR07MB4550.namprd07.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(136003)(376002)(199004)(189003)(36092001)(6436002)(102836004)(2906002)(6916009)(26005)(54906003)(316002)(186003)(7696005)(14454004)(7416002)(99286004)(76176011)(478600001)(486006)(105586002)(6506007)(106356001)(476003)(11346002)(446003)(55016002)(9686003)(68736007)(14444005)(71190400001)(33656002)(66066001)(53936002)(86362001)(256004)(25786009)(4326008)(71200400001)(6246003)(107886003)(8676002)(3846002)(8936002)(229853002)(6116002)(74316002)(81166006)(81156014)(7736002)(305945005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4550;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jVTor7Bctw9OKUmbxIbN5ELJdGbcsrVqo6p7oXheFWKvgvFoqK5PB9/ixA4Lf+bcTykePGLr84qCxmVdY2ZoTH4Tx8rlLbdwrOQsTfg+Cr/KbUhdpwIO7gawQnPTCGgAGPrbGaInGqs1q+znfVst509s5fCUbZCM00yKASl7zNe698m2u4CIMEW6J9OjrdJUytI6kXLA70CW7Ci6YxrO32I3TWaO/s926icBHhBZ+l8DByYAN3Cw2eD30esE7Y7xgR6WSCjW5JhFUiF/ac/hi0+LOeWNoL3SPXmhqYxYzBUyXsF5mj6+y4klgFNys7IRVcpqVEvUi53IoFRf6LZbByJLIgPM676ZPH8b6u4m6sf404t9u6iIlCSZKLnxAYeUX/UMzhpts4Fre5k1yTbz/qGLqNfUSTboos2uf2yXzPk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744a5371-a447-4c29-b9e1-08d68b41d15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 08:13:32.0769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4550
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902050067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H Greg
>
>On Thu, Jan 31, 2019 at 11:52:29AM +0000, Pawel Laszczak wrote:
>> Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
>> to driver/usb/common/debug.c file. These moved functions include:
>>     dwc3_decode_get_status
>>     dwc3_decode_set_clear_feature
>>     dwc3_decode_set_address
>>     dwc3_decode_get_set_descriptor
>>     dwc3_decode_get_configuration
>>     dwc3_decode_set_configuration
>>     dwc3_decode_get_intf
>>     dwc3_decode_set_intf
>>     dwc3_decode_synch_frame
>>     dwc3_decode_set_sel
>>     dwc3_decode_set_isoch_delay
>>     dwc3_decode_ctrl
>>
>> These functions are used also in inroduced cdns3 driver.
>>
>> All functions prefixes were changed from dwc3 to usb.
>
>Ick, why?

Because CDNS3 driver in one of the previous version had implemented very si=
milar function as dwc3 and Felipe suggested that we should=20
make common file with these functions. He also suggested that this function=
 also could be used on host side.=20
It was the reason why I've took function from DWC driver and put it in sepa=
rate file in usb/common directory.
I change only the prefix to make this function more common. =20

>
>> Also, function's parameters has been extended according to the name
>> of fields in standard SETUP packet.
>> Additionally, patch adds usb_decode_ctrl function to
>> include/linux/usb/ch9.h file.
>
>Why ch9.h?  It's not something that is specified in the spec, it's a
>usb-specific thing :)
Why not ?

Similar as usb_state_string function from include/linux/usb/ch9.h which=20
" Returns human readable name for the state", the usb_decode_ctrl function=
=20
make the same but for standard USB request.=20

>
>Also, the api for that function is not ok.  If you are going to make
>this something that the whole kernel can call, you have to fix it up:
>
>> +/**
>> + * usb_decode_ctrl - Returns human readable representation of control r=
equest.
>> + * @str: buffer to return a human-readable representation of control re=
quest.
>> + *       This buffer should have about 200 bytes.
>
>"about 200 bytes" is not very specific.
>
>Pass in the length so we know we don't overflow it.

I didn't want to change to much this code, because it's not my code.=20
I'm not sure if I should ?

>
>> + * @bRequestType: matches the USB bmRequestType field
>> + * @bRequest: matches the USB bRequest field
>> + * @wValue: matches the USB wValue field (CPU byte order)
>> + * @wIndex: matches the USB wIndex field (CPU byte order)
>> + * @wLength: matches the USB wLength field (CPU byte order)
>> + *
>> + * Function returns decoded, formatted and human-readable description o=
f
>> + * control request packet.
>> + *
>> + * Important: wValue, wIndex, wLength parameters before invoking this f=
unction
>> + * should be processed by le16_to_cpu macro.
>> + */
>> +const char *usb_decode_ctrl(char *str, __u8 bRequestType, __u8 bRequest=
,
>> +			    __u16 wValue,  __u16 wIndex, __u16 wLength);
>
>Why are you returning a value, isn't the data stored in str?  Why not
>just return an int saying if the call succeeded or not?

Currently this function is called only from trace point, and probably it wi=
ll be use only
In this way.=20
If function prototype looks like above, we can simply call it in following =
way:
	TP_printk("%s", usb_decode_ctrl(__get_str(str), __entry->bRequestType,
					__entry->bRequest, __entry->wValue,
					__entry->wIndex, __entry->wLength)


Thanks=20
Pawel laszczak
