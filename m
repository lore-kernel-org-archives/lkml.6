Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05B3C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3272082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="pnWMYU1L";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="gi57eOQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3272082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeLAWXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:23:42 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:37994 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbeLAWXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:23:41 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB1B1kI3032750;
        Sat, 1 Dec 2018 03:11:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=xVLH7OdR1GNnZyJTxjixLGF8Fab681parmxXlkgl5v4=;
 b=pnWMYU1LVG0kkuWqEFYCphwNBmrmympkbig4a7PHO6FUhvhKcHo7pyn7o5z24fJPFPOi
 3WVTKsW7QJuoaof36x/HAUvtkKznj1rdyqeDP5efu4W9JweW2PQTI7xSFvhKXwDxfU4P
 o6rKkjMOpi7HmodNZ2NrhDoe32QVs1I2WkfCj/S2oKWyCUHdu5VSVkGulh9ruuYZZ6XP
 6OJcEXVPhJjgWAafgaVbryxHOJ8hhYEV+0rRoULEn3cqr7A84dPV8OKO2UEZy9JsqGr2
 ca2URIAcoVQjlEvojoK0K8ZguN3EiSQmuOiSNDpt6slO/T4bHcgszyBpRmIFCB7Z5q7b cw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2054.outbound.protection.outlook.com [104.47.38.54])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2p3qr10cy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Dec 2018 03:11:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVLH7OdR1GNnZyJTxjixLGF8Fab681parmxXlkgl5v4=;
 b=gi57eOQ1WwY7WYcSnlgxgcgZHCXGYFpPbYB0n8+29K8RoFFxDpHL9R05UGTvuYzBit9BhIKnXjGIGNfbIlPGsKyzNOJkiS5pPX2fSbx/GGD4GiFVRJuLtCR8EX89MBbRZZbzNE1X7Fx8l7S01ruGsnblXqOWTAqRkCY7Ctas5GY=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4263.namprd07.prod.outlook.com (52.135.223.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Sat, 1 Dec 2018 11:11:04 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1382.020; Sat, 1 Dec 2018
 11:11:02 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: RE: [RFC PATCH v2 08/15] usb:cdns3: Implements device operations part
 of the API
Thread-Topic: [RFC PATCH v2 08/15] usb:cdns3: Implements device operations
 part of the API
Thread-Index: AQHUfycXLoLM1JyA10aQRtXGNL+S26VlK76AgAQ822A=
Date:   Sat, 1 Dec 2018 11:11:01 +0000
Message-ID: <BYAPR07MB4709BBB7E78C7A7244270215DDAC0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-9-git-send-email-pawell@cadence.com>
 <5BFE8883.7090802@ti.com>
In-Reply-To: <5BFE8883.7090802@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYzY4OWE5MzktZjU1OS0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGM2ODlhOTNhLWY1NTktMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTE2NTUiIHQ9IjEzMTg4MTM2MjYxNDQ1NDI2MyIgaD0iQVZWU2k5bzdlSUE5VXRtU00yU1dBQnZaNVVzPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4263;20:KoFBsHX7MQjBLW399ycHu675T5Z3KvHLn2KmqUCxcxrDZaxyPsjPrcjhotXgV6G5++2IuTkW1ItwFaArVBhdfkXPnNifIk2M+5olsxw/UjzqBQigj/UgJwVZcYFq+FT1vPQh252gsiVt85M5FN7LIVbHPUN8+eQJ+4rP+YFzGbaxaVnirlf/Z4qF/7RxAoxNpPaC0HqM5HtK+b9sAFS+vwHe8m+m5COxjlG5WsxLIYbQd2EEUhaH9ucXljgjWbXp
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(366004)(346002)(376002)(396003)(36092001)(199004)(189003)(76176011)(105586002)(2906002)(7736002)(97736004)(99286004)(478600001)(6246003)(6116002)(74316002)(33656002)(2501003)(7416002)(4326008)(305945005)(476003)(55016002)(486006)(5660300001)(14454004)(11346002)(446003)(53936002)(9686003)(6436002)(110136005)(54906003)(186003)(102836004)(26005)(6506007)(71200400001)(71190400001)(66066001)(217873002)(256004)(14444005)(81166006)(81156014)(8676002)(86362001)(8936002)(229853002)(68736007)(316002)(7696005)(4744004)(25786009)(106356001)(3846002)(309714004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4263;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 409a408d-ced4-4366-d457-08d6577dadf7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4263;
x-ms-traffictypediagnostic: BYAPR07MB4263:
x-microsoft-antispam-prvs: <BYAPR07MB426367CFF0A7B8C58973BB92DDAC0@BYAPR07MB4263.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231454)(999002)(944501475)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4263;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4263;
x-forefront-prvs: 087396016C
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vZerv8/Art/IUS15ut8KGK1FUv6Nd3oFDrEyasrzV9JaC+pUItbpu+moZg+6wXeiGGvo2jL7RZh3XsoLCy51r5dkUHsoWl7vO6saRc3orTd7Ja2mLDbhLMZuVm2+FvAlfvR4BCMBsQ6ZU2pykUo3mqpHt1nrpQA7MwJ4MLrebJMsZ9KNgPiH5VMIhraZLisHR4X4I/4dlO8XR6d1NPJxW9noGoKXUz9Q6ENsxDib7TmJQ1rblRrzlqlg+dcq0kX9Def0DjKTaLdeiFkkDHMPGCNUKWwK5OduCndKFLCX+iPJ6WTik1GN0URi2Jyd0zyoW2EyPGKGXXmVCpCGySVEUK5sjYtahWcFMPZs916YGEQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409a408d-ced4-4366-d457-08d6577dadf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2018 11:11:01.9661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4263
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-01_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812010106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> Patch adds implementation callback function defined in
>> usb_gadget_ops object.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/gadget.c | 249 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 247 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>> index 376b68b13d1b..702a05faa664 100644
>> --- a/drivers/usb/cdns3/gadget.c
>> +++ b/drivers/usb/cdns3/gadget.c
>> @@ -17,6 +17,36 @@
>>  #include "gadget-export.h"
>>  #include "gadget.h"
>>
>> +/**
>> + * cdns3_handshake - spin reading  until handshake completes or fails
>> + * @ptr: address of device controller register to be read
>> + * @mask: bits to look at in result of read
>> + * @done: value of those bits when handshake succeeds
>> + * @usec: timeout in microseconds
>> + *
>> + * Returns negative errno, or zero on success
>> + *
>> + * Success happens when the "mask" bits have the specified value (hardw=
are
>> + * handshake done). There are two failure modes: "usec" have passed (ma=
jor
>> + * hardware flakeout), or the register reads as all-ones (hardware remo=
ved).
>> + */
>> +int cdns3_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
>> +{
>> +	u32	result;
>> +
>> +	do {
>> +		result =3D readl(ptr);
>> +		if (result =3D=3D ~(u32)0)	/* card removed */
>> +			return -ENODEV;
>
>Is this applicable to all registers?
>What is meant by card removed? We're not connected to host?
>
>how does EP reset behave when there is no USB connection?
>

Function was adopted from XHCI driver (xhci_handshake).=20
I think it's about PCI card.  If this happens driver should read 0xffffffff=
 from any register.=20
I need to confirm it with hardware team or test it.=20
I remember that I had such situation some time ago.=20
My testing platform consist of separate FPGA  board and PC. Both has  PCI a=
dapter=20
and are connected by means of special PCI cable.

>> +		result &=3D mask;
>> +		if (result =3D=3D done)
>> +			return 0;
>> +		udelay(1);
>> +		usec--;
>> +	} while (usec > 0);
>> +	return -ETIMEDOUT;
>> +}
>> +
>>  /**
>>   * cdns3_set_register_bit - set bit in given register.
>>   * @ptr: address of device controller register to be read and changed
>> @@ -43,6 +73,25 @@ void cdns3_select_ep(struct cdns3_device *priv_dev, u=
32 ep)
>>  	writel(ep, &priv_dev->regs->ep_sel);
>>  }
>>
>> +static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
>> +{
>> +	struct cdns3_device *priv_dev =3D priv_ep->cdns3_dev;
>> +
>> +	if (priv_ep->trb_pool) {
>> +		dma_free_coherent(priv_dev->sysdev,
>> +				  TRB_RIGN_SIZE,
>> +				  priv_ep->trb_pool, priv_ep->trb_pool_dma);
>> +		priv_ep->trb_pool =3D NULL;
>> +	}
>> +
>> +	if (priv_ep->aligned_buff) {
>> +		dma_free_coherent(priv_dev->sysdev, CDNS3_UNALIGNED_BUF_SIZE,
>> +				  priv_ep->aligned_buff,
>> +				  priv_ep->aligned_dma_addr);
>> +		priv_ep->aligned_buff =3D NULL;
>> +	}
>> +}
>> +
>>  /**
>>   * cdns3_irq_handler - irq line interrupt handler
>>   * @cdns: cdns3 instance
>> @@ -58,6 +107,114 @@ static irqreturn_t cdns3_irq_handler_thread(struct =
cdns3 *cdns)
>>  	return ret;
>>  }
>>
>> +/* Find correct direction for HW endpoint according to description */
>> +static int cdns3_ep_dir_is_correct(struct usb_endpoint_descriptor *desc=
,
>> +				   struct cdns3_endpoint *priv_ep)
>> +{
>> +	return (priv_ep->endpoint.caps.dir_in && usb_endpoint_dir_in(desc)) ||
>> +	       (priv_ep->endpoint.caps.dir_out && usb_endpoint_dir_out(desc));
>> +}
>> +
>> +static struct cdns3_endpoint *cdns3_find_available_ss_ep(struct cdns3_d=
evice *priv_dev,
>> +							 struct usb_endpoint_descriptor *desc)
>
>why is this function called ss_ep? This doesn't seem like only for supersp=
eed endpoints.

I will remove _ss_.=20
>
>> +{
>> +	struct usb_ep *ep;
>> +	struct cdns3_endpoint *priv_ep;
>> +
>> +	list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
>> +		unsigned long num;
>> +		int ret;
>> +		/* ep name pattern likes epXin or epXout */
>> +		char c[2] =3D {ep->name[2], '\0'};
>> +
>> +		ret =3D kstrtoul(c, 10, &num);
>> +		if (ret)
>> +			return ERR_PTR(ret);
>> +
>> +		priv_ep =3D ep_to_cdns3_ep(ep);
>> +		if (cdns3_ep_dir_is_correct(desc, priv_ep)) {
>> +			if (!(priv_ep->flags & EP_USED)) {
>> +				priv_ep->num  =3D num;
>> +				priv_ep->flags |=3D EP_USED;
>> +				return priv_ep;
>> +			}
>> +		}
>> +	}
>> +	return ERR_PTR(-ENOENT);
>> +}
>> +
>> +static struct usb_ep *cdns3_gadget_match_ep(struct usb_gadget *gadget,
>> +					    struct usb_endpoint_descriptor *desc,
>> +					    struct usb_ss_ep_comp_descriptor *comp_desc)
>> +{
>> +	struct cdns3_device *priv_dev =3D gadget_to_cdns3_device(gadget);
>> +	struct cdns3_endpoint *priv_ep;
>> +	unsigned long flags;
>> +
>> +	priv_ep =3D cdns3_find_available_ss_ep(priv_dev, desc);
>> +	if (IS_ERR(priv_ep)) {
>> +		dev_err(&priv_dev->dev, "no available ep\n");
>> +		return NULL;
>> +	}
>> +
>> +	dev_dbg(&priv_dev->dev, "match endpoint: %s\n", priv_ep->name);
>> +
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>> +	priv_ep->endpoint.desc =3D desc;
>> +	priv_ep->dir  =3D usb_endpoint_dir_in(desc) ? USB_DIR_IN : USB_DIR_OUT=
;
>> +	priv_ep->type =3D usb_endpoint_type(desc);
>> +
>> +	list_add_tail(&priv_ep->ep_match_pending_list,
>> +		      &priv_dev->ep_match_list);
>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>> +	return &priv_ep->endpoint;
>> +}
>
>Why do you need a custom match_ep?
>doesn't usb_ep_autoconfig suffice?

I need to test it but at first glance it  looks like usb_ep_autoconfig suff=
ice.

>
>You can check if EP is claimed or not by checking the ep->claimed flag.
>
>> +
>> +/**
>> + * cdns3_gadget_get_frame Returns number of actual ITP frame
>> + * @gadget: gadget object
>> + *
>> + * Returns number of actual ITP frame
>> + */
>> +static int cdns3_gadget_get_frame(struct usb_gadget *gadget)
>> +{
>> +	struct cdns3_device *priv_dev =3D gadget_to_cdns3_device(gadget);
>> +
>> +	return readl(&priv_dev->regs->usb_iptn);
>> +}
>> +
>> +static int cdns3_gadget_wakeup(struct usb_gadget *gadget)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int cdns3_gadget_set_selfpowered(struct usb_gadget *gadget,
>> +					int is_selfpowered)
>> +{
>> +	struct cdns3_device *priv_dev =3D gadget_to_cdns3_device(gadget);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>> +	gadget->is_selfpowered =3D !!is_selfpowered;
>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>> +	return 0;
>> +}
>> +
>> +static int cdns3_gadget_pullup(struct usb_gadget *gadget, int is_on)
>> +{
>> +	struct cdns3_device *priv_dev =3D gadget_to_cdns3_device(gadget);
>> +
>> +	if (!priv_dev->start_gadget)
>> +		return 0;
>> +
>> +	if (is_on)
>> +		writel(USB_CONF_DEVEN, &priv_dev->regs->usb_conf);
>> +	else
>> +		writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
>> +
>> +	return 0;
>> +}
>> +
>>  static void cdns3_gadget_config(struct cdns3_device *priv_dev)
>>  {
>>  	struct cdns3_usb_regs __iomem *regs =3D priv_dev->regs;
>> @@ -74,6 +231,95 @@ static void cdns3_gadget_config(struct cdns3_device =
*priv_dev)
>>  	writel(USB_CONF_DEVEN, &regs->usb_conf);
>>  }
>>
>> +/**
>> + * cdns3_gadget_udc_start Gadget start
>> + * @gadget: gadget object
>> + * @driver: driver which operates on this gadget
>> + *
>> + * Returns 0 on success, error code elsewhere
>> + */
>> +static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
>> +				  struct usb_gadget_driver *driver)
>> +{
>> +	struct cdns3_device *priv_dev =3D gadget_to_cdns3_device(gadget);
>> +	unsigned long flags;
>> +
>> +	if (priv_dev->gadget_driver) {
>> +		dev_err(&priv_dev->dev, "%s is already bound to %s\n",
>> +			priv_dev->gadget.name,
>> +			priv_dev->gadget_driver->driver.name);
>> +		return -EBUSY;
>> +	}
>
>Not sure if this check is required. UDC core should be doing that.
>
>> +
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>> +	priv_dev->gadget_driver =3D driver;
>> +	if (!priv_dev->start_gadget)
>> +		goto unlock;
>> +
>> +	cdns3_gadget_config(priv_dev);
>> +unlock:
>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cdns3_gadget_udc_stop Stops gadget
>> + * @gadget: gadget object
>> + *
>> + * Returns 0
>> + */
>> +static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
>> +{
>> +	struct cdns3_device *priv_dev =3D gadget_to_cdns3_device(gadget);
>> +	struct cdns3_endpoint *priv_ep, *temp_ep;
>> +	u32 bEndpointAddress;
>> +	struct usb_ep *ep;
>> +	int ret =3D 0;
>> +	int i;
>> +
>> +	priv_dev->gadget_driver =3D NULL;
>> +	list_for_each_entry_safe(priv_ep, temp_ep, &priv_dev->ep_match_list,
>> +				 ep_match_pending_list) {
>> +		list_del(&priv_ep->ep_match_pending_list);
>> +		priv_ep->flags &=3D ~EP_USED;
>> +	}
>> +
>> +	priv_dev->onchip_mem_allocated_size =3D 0;
>> +	priv_dev->out_mem_is_allocated =3D 0;
>> +	priv_dev->gadget.speed =3D USB_SPEED_UNKNOWN;
>> +
>> +	for (i =3D 0; i < priv_dev->ep_nums ; i++)
>> +		cdns3_free_trb_pool(priv_dev->eps[i]);
>> +
>> +	if (!priv_dev->start_gadget)
>> +		return 0;
>
>This looks tricky. Why do we need this flag?

It will be removed in next version. It's no longer needed.=20
>
>> +
>> +	list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
>> +		priv_ep =3D ep_to_cdns3_ep(ep);
>> +		bEndpointAddress =3D priv_ep->num | priv_ep->dir;
>> +		cdns3_select_ep(priv_dev, bEndpointAddress);
>> +		writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
>> +		ret =3D cdns3_handshake(&priv_dev->regs->ep_cmd,
>> +				      EP_CMD_EPRST, 0, 100);
>> +	}
>> +
>> +	/* disable interrupt for device */
>> +	writel(0, &priv_dev->regs->usb_ien);
>> +	writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
>
>where are you requesting the interrupt? Looks like it should be done in
>udc_start() no?

Currently it is in initialization when the role is switched on. Interrupt i=
s freeing=20
during switching off role. So now the concept is the same as for host role.=
=20
Whole device part is loaded and unloaded during changing role..=20
>
>> +
>> +	return ret;
>> +}
>
>Can we combine cdns3_gadget_udc_start() and cdns3_gadget_udc_start()
>with cdns3_gadget_start() and cdns3_gadget_stop() respectively so that
>cdns3_gadget_config() and cleanup() is done at one place.
>

Ok, probably it can be invoked only in cdns3_gadget_udc_start() and=20
cdns3_gadget_udc_start(), but I have to test it.=20
>> +
>> +static const struct usb_gadget_ops cdns3_gadget_ops =3D {
>> +	.get_frame =3D cdns3_gadget_get_frame,
>> +	.wakeup =3D cdns3_gadget_wakeup,
>> +	.set_selfpowered =3D cdns3_gadget_set_selfpowered,
>> +	.pullup =3D cdns3_gadget_pullup,
>> +	.udc_start =3D cdns3_gadget_udc_start,
>> +	.udc_stop =3D cdns3_gadget_udc_stop,
>> +	.match_ep =3D cdns3_gadget_match_ep,
>> +};
>> +
>>  /**
>>   * cdns3_init_ep Initializes software endpoints of gadget
>>   * @cdns3: extended gadget object
>> @@ -184,8 +430,7 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
>>  	/* fill gadget fields */
>>  	priv_dev->gadget.max_speed =3D USB_SPEED_SUPER;
>>  	priv_dev->gadget.speed =3D USB_SPEED_UNKNOWN;
>> -	//TODO: Add implementation of cdns3_gadget_ops
>> -	//priv_dev->gadget.ops =3D &cdns3_gadget_ops;
>> +	priv_dev->gadget.ops =3D &cdns3_gadget_ops;
>>  	priv_dev->gadget.name =3D "usb-ss-gadget";
>>  	priv_dev->gadget.sg_supported =3D 1;
>>  	priv_dev->is_connected =3D 0;
>>
>
Cheers
Pawel
