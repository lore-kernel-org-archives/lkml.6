Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D179C65BAE
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87F32146D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XNkMbjdS";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="YuegW3Op"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87F32146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeLBAni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 19:43:38 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54854 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726570AbeLBAni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 19:43:38 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB1DT0Ic028894;
        Sat, 1 Dec 2018 05:30:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=nOG2u+IO0B8aQL9C88OQ2PnqPV9j6ameCAMsR/bTt6E=;
 b=XNkMbjdSfDnEYcr1/hEXUbshT2yFCCy2Qh0GJq+EJ7FlwXIm+ZhdF6w1ZnARh2dEKViB
 dL6AAoDKbMo1tSsK6uJszrmHR4XwMv30+ZFvz4JAh31YnwQvAuaGe5Osr5H47GpCB4xx
 Mh2XC/Sx0XAt8dCSf8fCd/lszXa/C5TiQqtYEOY70k1AM2b77tnmbwTDGfc98VTuo9Bd
 Znmm1jofCRsrG2YZOMjnIE1ftRvcUrlEkBZFUB24vbZvuHVGszsMPYDut0CFYlspyVTk
 9CVuxMD1EJ9Lh3H1cG0+X0WrI53Sb4HLm7LPMN91UZsAc4Culxfq/YlYH0h0AXK0Uw8g tA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2052.outbound.protection.outlook.com [104.47.34.52])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2p3ps29dvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Dec 2018 05:30:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOG2u+IO0B8aQL9C88OQ2PnqPV9j6ameCAMsR/bTt6E=;
 b=YuegW3OpXcNlSpDEy+kNhOwLsTCJEUgnXdnyp2EdlkbR4V9/6TSYmcaKZ3F16f4wqxWEuuegjeSZJJLlGYVXlylynAOr7l7JcBxyEX9XLwyI4saAQtRONLBFcjfuQM4Faq4Uzxd3Cp6AViRK9/phyZiXFkrdoKCqpWaXM0GTRHg=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB6069.namprd07.prod.outlook.com (20.179.93.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Sat, 1 Dec 2018 13:30:40 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1382.020; Sat, 1 Dec 2018
 13:30:37 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [RFC PATCH v2 09/15] usb:cdns3: EpX operations part of the API
Thread-Topic: [RFC PATCH v2 09/15] usb:cdns3: EpX operations part of the API
Thread-Index: AQHUfycai/XD7MXoJEaF0BC38sYv3KVlMl4AgAScmBA=
Date:   Sat, 1 Dec 2018 13:30:37 +0000
Message-ID: <BYAPR07MB47099386E89C4551D808EFA9DDAC0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-10-git-send-email-pawell@cadence.com>
 <5BFE8E12.9080307@ti.com>
In-Reply-To: <5BFE8E12.9080307@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNDgzYzQwOGItZjU2ZC0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDQ4M2M0MDhjLWY1NmQtMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTkyODgiIHQ9IjEzMTg4MTQ0NjM3NzUyMjUxMyIgaD0iTnQ0cWFua1N2YnZ5a0VtMEVMbXNHSlpMZjZvPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB6069;20:fYy6RnrZxifOjmzvUaqDTkf+xbpFFUMZTEcgSsS62DWcOX5sM3xw41QrzmoqdjMhDyA/gMWChA/Q8h3B+ndm60/8fUCMvTkLutIHSmSRxoRkUPR2jG6BoluobX8Vnu0WKp1eDTT5SEe6edXxilFai+mwiJs3zYooCeWtWfxK7mRzBtt+O+nyESaErjmlC2oJSxcFeFxB01vmihfhWRcyNvsDcM0slQLiBgOPSkLmggvy9xaM61aD9iyj81P87m65
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(39860400002)(396003)(36092001)(199004)(189003)(14444005)(256004)(105586002)(575784001)(11346002)(486006)(476003)(106356001)(86362001)(446003)(53946003)(9686003)(55016002)(14454004)(33656002)(107886003)(102836004)(76176011)(53936002)(305945005)(6246003)(81156014)(81166006)(478600001)(8676002)(68736007)(6436002)(99286004)(25786009)(7736002)(7696005)(71200400001)(110136005)(54906003)(71190400001)(316002)(4744004)(6506007)(3846002)(74316002)(6116002)(229853002)(8936002)(2906002)(217873002)(4326008)(5660300001)(186003)(7416002)(26005)(66066001)(97736004)(2501003)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6069;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: a678486b-2ca7-46bc-04a0-08d657912e5c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB6069;
x-ms-traffictypediagnostic: BYAPR07MB6069:
x-microsoft-antispam-prvs: <BYAPR07MB6069C91EAAF4805589F794F1DDAC0@BYAPR07MB6069.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231454)(999002)(944501477)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB6069;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB6069;
x-forefront-prvs: 087396016C
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kSAIA8G1zeTXVcPHfMfNmE1/dDctGguuRIxcgZf5WRFx9ZA1whpwBk+4bU5+Y2am/eGduTSPEMhMt+6GsMITZs/0tO6l32cB0IiuVjyhQk/cA0Bp5gRdQ+EHyKdI3OKAmehudOIpMu0/JKK57VeIi0agVYf0dXzHGo3pSb9ddlYmOcT7Kbkb1aGktvHaHjjEnqV/a9MMaUtViQSOnCJq6R5Rb7V//v1S8KldJX3mttG79++Xe8VHcs1Mw41thmhPU9KvCCRYB5V1zxEJFzVKkraKJGU7XmLh2s3e8Q/k/M4/nnAEEGeHi3YsCwptOhvhWZsxIwAFph+IO2k/59YttcoJl9FmVsjSOFxMEiKXseY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a678486b-2ca7-46bc-04a0-08d657912e5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2018 13:30:37.5768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6069
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
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812010127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
>> Patch implements callback functions for non-default endpoints
>> defined in usb_ep_ops object.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/ep0.c    |  18 ++
>>  drivers/usb/cdns3/gadget.c | 442 ++++++++++++++++++++++++++++++++++++-
>>  drivers/usb/cdns3/gadget.h |   3 +
>>  3 files changed, 461 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
>> index c08d02665f9d..ca1795467155 100644
>> --- a/drivers/usb/cdns3/ep0.c
>> +++ b/drivers/usb/cdns3/ep0.c
>> @@ -23,6 +23,24 @@ static void cdns3_prepare_setup_packet(struct cdns3_d=
evice *priv_dev)
>>  	//TODO: Implements this function
>>  }
>>
>> +/**
>> + * cdns3_gadget_ep_set_wedge Set wedge on selected endpoint
>> + * @ep: endpoint object
>> + *
>> + * Returns 0
>> + */
>> +int cdns3_gadget_ep_set_wedge(struct usb_ep *ep)
>> +{
>> +	struct cdns3_endpoint *priv_ep =3D ep_to_cdns3_ep(ep);
>> +	struct cdns3_device *priv_dev =3D priv_ep->cdns3_dev;
>> +
>> +	dev_dbg(&priv_dev->dev, "Wedge for %s\n", ep->name);
>> +	cdns3_gadget_ep_set_halt(ep, 1);
>> +	priv_ep->flags |=3D EP_WEDGE;
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * cdns3_ep0_config - Configures default endpoint
>>   * @priv_dev: extended gadget object
>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>> index 702a05faa664..1f2a434486dc 100644
>> --- a/drivers/usb/cdns3/gadget.c
>> +++ b/drivers/usb/cdns3/gadget.c
>> @@ -58,6 +58,19 @@ void cdns3_set_register_bit(void __iomem *ptr, u32 ma=
sk)
>>  	writel(mask, ptr);
>>  }
>>
>> +/**
>> + * cdns3_next_request - returns next request from list
>> + * @list: list containing requests
>> + *
>> + * Returns request or NULL if no requests in list
>> + */
>> +struct usb_request *cdns3_next_request(struct list_head *list)
>> +{
>> +	if (list_empty(list))
>> +		return NULL;
>> +	return list_first_entry(list, struct usb_request, list);
>> +}
>> +
>>  /**
>>   * select_ep - selects endpoint
>>   * @priv_dev:  extended gadget object
>> @@ -73,6 +86,53 @@ void cdns3_select_ep(struct cdns3_device *priv_dev, u=
32 ep)
>>  	writel(ep, &priv_dev->regs->ep_sel);
>>  }
>>
>> +/**
>> + * cdns3_allocate_trb_pool - Allocates TRB's pool for selected endpoint
>> + * @priv_ep:  endpoint object
>> + *
>> + * Function will return 0 on success or -ENOMEM on allocation error
>> + */
>> +static int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep)
>> +{
>> +	struct cdns3_device *priv_dev =3D priv_ep->cdns3_dev;
>> +	struct cdns3_trb *link_trb;
>> +
>> +	if (!priv_ep->trb_pool) {
>> +		priv_ep->trb_pool =3D dma_zalloc_coherent(priv_dev->sysdev,
>> +							TRB_RIGN_SIZE,
>
>TRB_RING_SIZE
>
>> +							&priv_ep->trb_pool_dma,
>> +							GFP_DMA);
>> +		if (!priv_ep->trb_pool)
>> +			return -ENOMEM;
>> +	} else {
>> +		memset(priv_ep->trb_pool, 0, TRB_RIGN_SIZE);
>
>here too.
>
>> +	}
>> +
>> +	if (!priv_ep->aligned_buff) {
>> +		priv_ep->aligned_buff =3D dma_alloc_coherent(priv_dev->sysdev,
>> +							   CDNS3_UNALIGNED_BUF_SIZE,
>
>CDNS3_ALIGNED_BUF_SIZE
>
>> +							   &priv_ep->aligned_dma_addr,
>> +							   GFP_DMA);
>> +		if (!priv_ep->aligned_buff) {
>> +			dma_free_coherent(priv_dev->sysdev,
>> +					  TRB_RIGN_SIZE,
>> +					  priv_ep->trb_pool,
>> +					  priv_ep->trb_pool_dma);
>> +			priv_ep->trb_pool =3D NULL;
>> +
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>> +	/* Initialize the last TRB as Link TRB */
>> +	link_trb =3D (priv_ep->trb_pool + TRBS_PER_SEGMENT - 1);
>> +	link_trb->buffer =3D TRB_BUFFER(priv_ep->trb_pool_dma);
>> +	link_trb->control =3D TRB_CYCLE | TRB_TYPE(TRB_LINK) |
>> +			    TRB_CHAIN | TRB_TOGGLE;
>> +
>> +	return 0;
>> +}
>> +
>>  static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
>>  {
>>  	struct cdns3_device *priv_dev =3D priv_ep->cdns3_dev;
>> @@ -92,6 +152,73 @@ static void cdns3_free_trb_pool(struct cdns3_endpoin=
t *priv_ep)
>>  	}
>>  }
>>
>> +/**
>> + * cdns3_data_flush - flush data at onchip buffer
>> + * @priv_ep: endpoint object
>> + *
>> + * Endpoint must be selected before call to this function
>> + *
>> + * Returns zero on success or negative value on failure
>> + */
>> +static int cdns3_data_flush(struct cdns3_endpoint *priv_ep)
>> +{
>> +	struct cdns3_device *priv_dev =3D priv_ep->cdns3_dev;
>> +
>> +	writel(EP_CMD_DFLUSH, &priv_dev->regs->ep_cmd);
>> +
>> +	/* wait for DFLUSH cleared */
>> +	return cdns3_handshake(&priv_dev->regs->ep_cmd, EP_CMD_DFLUSH, 0, 100)=
;
>> +}
>> +
>> +/**
>> + * cdns3_ep_stall_flush - Stalls and flushes selected endpoint
>> + * @priv_ep: endpoint object
>> + *
>> + * Endpoint must be selected before call to this function
>> + */
>> +static void cdns3_ep_stall_flush(struct cdns3_endpoint *priv_ep)
>> +{
>> +	struct cdns3_device *priv_dev =3D priv_ep->cdns3_dev;
>> +
>> +	writel(EP_CMD_DFLUSH | EP_CMD_ERDY | EP_CMD_SSTALL,
>> +	       &priv_dev->regs->ep_cmd);
>> +
>> +	/* wait for DFLUSH cleared */
>> +	cdns3_handshake(&priv_dev->regs->ep_cmd, EP_CMD_DFLUSH, 0, 100);
>> +	priv_ep->flags |=3D EP_STALL;
>> +}
>> +
>> +/**
>> + * cdns3_gadget_giveback - call struct usb_request's ->complete callbac=
k
>> + * @priv_ep: The endpoint to whom the request belongs to
>> + * @priv_req: The request we're giving back
>> + * @status: completion code for the request
>> + *
>> + * Must be called with controller's lock held and interrupts disabled. =
This
>> + * function will unmap @req and call its ->complete() callback to notif=
y upper
>> + * layers that it has completed.
>> + */
>> +void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
>> +			   struct cdns3_request *priv_req,
>> +			   int status)
>> +{
>> +	//TODO: Implements this function.
>> +}
>> +
>> +/**
>> + * cdns3_ep_run_transfer - start transfer on no-default endpoint hardwa=
re
>> + * @priv_ep: endpoint object
>> + *
>> + * Returns zero on success or negative value on failure
>> + */
>> +int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
>> +			  struct usb_request *request)
>> +{
>> +	//TODO: Implements this function.
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * cdns3_irq_handler - irq line interrupt handler
>>   * @cdns: cdns3 instance
>> @@ -170,6 +297,318 @@ static struct usb_ep *cdns3_gadget_match_ep(struct=
 usb_gadget *gadget,
>>  	return &priv_ep->endpoint;
>>  }
>>
>> +/**
>> + * cdns3_gadget_ep_enable Enable endpoint
>> + * @ep: endpoint object
>> + * @desc: endpoint descriptor
>> + *
>> + * Returns 0 on success, error code elsewhere
>> + */
>> +static int cdns3_gadget_ep_enable(struct usb_ep *ep,
>> +				  const struct usb_endpoint_descriptor *desc)
>> +{
>> +	struct cdns3_endpoint *priv_ep;
>> +	struct cdns3_device *priv_dev;
>> +	unsigned long flags;
>> +	int ret;
>> +	u32 reg;
>> +
>> +	priv_ep =3D ep_to_cdns3_ep(ep);
>> +	priv_dev =3D priv_ep->cdns3_dev;
>> +
>> +	if (!ep || !desc || desc->bDescriptorType !=3D USB_DT_ENDPOINT) {
>> +		dev_err(&priv_dev->dev, "usbss: invalid parameters\n");
>
>dev_dbg()?
>
>Gadget driver will be more verbose.
>
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!desc->wMaxPacketSize) {
>> +		dev_err(&priv_dev->dev, "usbss: missing wMaxPacketSize\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (dev_WARN_ONCE(&priv_dev->dev, priv_ep->flags & EP_ENABLED,
>> +			  "%s is already enabled\n", priv_ep->name))
>> +		return 0;
>> +
>> +	ret =3D cdns3_allocate_trb_pool(priv_ep);
>> +	if (ret)
>> +		return ret;
>
>Why not allocate the TRB pool once for all endpoints at gadget init?
>
>you don't seem to be calling cdns3_allocate_trb_pool() in cdns3_gadget_ep_=
disable().

I allocate memory when endpoint is enabled and free in cdns3_gadget_udc_sto=
p.
Memory is allocated only once and only for endpoint that are used  by funct=
ion.=20
This solution  allows to saves some memory.=20

>> +
>> +	dev_dbg(&priv_dev->dev, "Enabling endpoint: %s\n", ep->name);
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>> +	cdns3_select_ep(priv_dev, desc->bEndpointAddress);
>> +	writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
>> +
>> +	ret =3D cdns3_handshake(&priv_dev->regs->ep_cmd,
>> +			      EP_CMD_CSTALL | EP_CMD_EPRST, 0, 100);
>> +
>> +	cdns3_set_register_bit(&priv_dev->regs->ep_cfg, EP_CFG_ENABLE);
>> +
>> +	ep->desc =3D desc;
>> +	priv_ep->flags &=3D ~(EP_PENDING_REQUEST | EP_STALL);
>> +	priv_ep->flags |=3D EP_ENABLED | EP_UPDATE_EP_TRBADDR;
>> +	priv_ep->enqueue =3D 0;
>> +	priv_ep->dequeue =3D 0;
>> +	reg =3D readl(&priv_dev->regs->ep_sts);
>> +	priv_ep->pcs =3D !!EP_STS_CCS(reg);
>> +	priv_ep->ccs =3D !!EP_STS_CCS(reg);
>> +	/* one TRB is reserved for link TRB used in DMULT mode*/
>> +	priv_ep->free_trbs =3D TRBS_PER_SEGMENT - 1;
>> +
>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cdns3_gadget_ep_disable Disable endpoint
>> + * @ep: endpoint object
>> + *
>> + * Returns 0 on success, error code elsewhere
>> + */
>> +static int cdns3_gadget_ep_disable(struct usb_ep *ep)
>> +{
>> +	struct cdns3_endpoint *priv_ep;
>> +	struct cdns3_device *priv_dev;
>> +	unsigned long flags;
>> +	int ret =3D 0;
>> +	struct usb_request *request;
>> +	u32 ep_cfg;
>> +
>> +	if (!ep) {
>> +		pr_debug("usbss: invalid parameters\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	priv_ep =3D ep_to_cdns3_ep(ep);
>> +	priv_dev =3D priv_ep->cdns3_dev;
>> +
>> +	if (dev_WARN_ONCE(&priv_dev->dev, !(priv_ep->flags & EP_ENABLED),
>> +			  "%s is already disabled\n", priv_ep->name))
>> +		return 0;
>> +
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>> +	if (!priv_dev->start_gadget) {
>> +		dev_dbg(&priv_dev->dev,
>> +			"Disabling endpoint at disconnection: %s\n", ep->name);
>
>This flag is looking very tricky.
>What do you mean by "disabling at disconnection"?

start_gadget fag and this  fragment has been removed.

>
>> +		spin_unlock_irqrestore(&priv_dev->lock, flags);
>> +		return 0;
>
>EP is not yet disabled and we're returning 0. This will cause an unbalance=
.
>I'd avoid that flag altogether.
>
>> +	}
>> +
>> +	dev_dbg(&priv_dev->dev, "Disabling endpoint: %s\n", ep->name);
>> +
>> +	cdns3_select_ep(priv_dev, ep->desc->bEndpointAddress);
>> +	ret =3D cdns3_data_flush(priv_ep);
>> +	while (!list_empty(&priv_ep->request_list)) {
>> +		request =3D cdns3_next_request(&priv_ep->request_list);
>> +
>> +		cdns3_gadget_giveback(priv_ep, to_cdns3_request(request),
>> +				      -ESHUTDOWN);
>> +	}
>> +
>> +	ep_cfg =3D readl(&priv_dev->regs->ep_cfg);
>> +	ep_cfg &=3D ~EP_CFG_ENABLE;
>> +	writel(ep_cfg, &priv_dev->regs->ep_cfg);
>> +	ep->desc =3D NULL;
>> +	priv_ep->flags &=3D ~EP_ENABLED;
>> +
>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * cdns3_gadget_ep_alloc_request Allocates request
>> + * @ep: endpoint object associated with request
>> + * @gfp_flags: gfp flags
>> + *
>> + * Returns allocated request address, NULL on allocation error
>> + */
>> +struct usb_request *cdns3_gadget_ep_alloc_request(struct usb_ep *ep,
>> +						  gfp_t gfp_flags)
>> +{
>> +	struct cdns3_endpoint *priv_ep =3D ep_to_cdns3_ep(ep);
>> +	struct cdns3_request *priv_req;
>> +
>> +	priv_req =3D kzalloc(sizeof(*priv_req), gfp_flags);
>> +	if (!priv_req)
>> +		return NULL;
>> +
>> +	priv_req->priv_ep =3D priv_ep;
>> +
>> +	return &priv_req->request;
>> +}
>> +
>> +/**
>> + * cdns3_gadget_ep_free_request Free memory occupied by request
>> + * @ep: endpoint object associated with request
>> + * @request: request to free memory
>> + */
>> +void cdns3_gadget_ep_free_request(struct usb_ep *ep,
>> +				  struct usb_request *request)
>> +{
>> +	struct cdns3_request *priv_req =3D to_cdns3_request(request);
>> +
>> +	kfree(priv_req);
>> +}
>> +
>> +/**
>> + * cdns3_gadget_ep_queue Transfer data on endpoint
>> + * @ep: endpoint object
>> + * @request: request object
>> + * @gfp_flags: gfp flags
>> + *
>> + * Returns 0 on success, error code elsewhere
>> + */
>> +static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
>> +				   struct usb_request *request,
>> +				   gfp_t gfp_flags)
>> +{
>> +	struct cdns3_endpoint *priv_ep =3D ep_to_cdns3_ep(ep);
>> +	struct cdns3_device *priv_dev =3D priv_ep->cdns3_dev;
>> +	int ret =3D 0;
>> +
>> +	request->actual =3D 0;
>> +	request->status =3D -EINPROGRESS;
>> +
>> +	dev_dbg(&priv_dev->dev, "Queuing to endpoint: %s\n", priv_ep->name);
>> +
>> +	ret =3D usb_gadget_map_request_by_dev(priv_dev->sysdev, request,
>> +					    usb_endpoint_dir_in(ep->desc));
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!cdns3_ep_run_transfer(priv_ep, request))
>> +		list_add_tail(&request->list, &priv_ep->request_list);
>
>how about catching the return value if cdns3_ep_run_transfer() fails?

Function has two incorrect situations that can occur. The first one is for =
request equal NULL
and the second is when endpoint hasn't sufficient free TRBs for transfer.
The first condition I will move to cdns3_gadget_ep_queue function.=20

For second case, the good solution is to keep such request in software queu=
e.=20
Driver can send these latter when sufficient number of TRBs will be free in=
 transfer ring.=20
>>=20
>> +	return ret;
>> +}
>> +
>> +static int cdns3_gadget_ep_queue(struct usb_ep *ep, struct usb_request =
*request,
>> +				 gfp_t gfp_flags)
>> +{
>> +	struct cdns3_endpoint *priv_ep =3D ep_to_cdns3_ep(ep);
>> +	struct cdns3_device *priv_dev =3D priv_ep->cdns3_dev;
>> +	struct usb_request *zlp_request;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>> +	ret =3D __cdns3_gadget_ep_queue(ep, request, gfp_flags);
>> +
>> +	if (ret =3D=3D 0 && request->zero && request->length &&
>> +	    (request->length % ep->maxpacket =3D=3D 0)) {
>> +		zlp_request =3D cdns3_gadget_ep_alloc_request(ep, GFP_ATOMIC);
>> +		zlp_request->buf =3D priv_dev->zlp_buf;
>> +		zlp_request->length =3D 0;
>> +
>> +		dev_dbg(&priv_dev->dev, "Queuing ZLP for endpoint: %s\n",
>> +			priv_ep->name);
>> +		ret =3D __cdns3_gadget_ep_queue(ep, zlp_request, gfp_flags);
>
>Who is going to free this zlp_request?

It's freeing in cdns3_gadget_giveback and it looks like:

	if (request->buf =3D=3D priv_dev->zlp_buf)
		cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);
=20
>
>> +	}
>> +
>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * cdns3_gadget_ep_dequeue Remove request from transfer queue
>> + * @ep: endpoint object associated with request
>> + * @request: request object
>> + *
>> + * Returns 0 on success, error code elsewhere
>> + */
>> +int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
>> +			    struct usb_request *request)
>> +{
>> +	struct cdns3_endpoint *priv_ep =3D ep_to_cdns3_ep(ep);
>> +	struct cdns3_device *priv_dev =3D priv_ep->cdns3_dev;
>> +	struct usb_request *req, *req_temp;
>> +	unsigned long flags;
>> +	int ret =3D 0;
>> +
>> +	if (!ep || !request || !ep->desc)
>> +		return -EINVAL;
>> +
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>> +	dev_dbg(&priv_dev->dev, "Dequeue from %s\n", ep->name);
>> +
>> +	cdns3_select_ep(priv_dev, ep->desc->bEndpointAddress);
>> +	if (priv_dev->start_gadget)
>> +		ret =3D cdns3_data_flush(priv_ep);
>> +
>> +	list_for_each_entry_safe(req, req_temp, &priv_ep->request_list, list) =
{
>> +		if (request =3D=3D req) {
>> +			cdns3_gadget_giveback(priv_ep,
>> +					      to_cdns3_request(request),
>> +					      -ECONNRESET);
>> +			break;
>> +		}
>> +	}
>> +
>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * cdns3_gadget_ep_set_halt Sets/clears stall on selected endpoint
>> + * @ep: endpoint object to set/clear stall on
>> + * @value: 1 for set stall, 0 for clear stall
>> + *
>> + * Returns 0 on success, error code elsewhere
>> + */
>> +int cdns3_gadget_ep_set_halt(struct usb_ep *ep, int value)
>> +{
>> +	struct cdns3_endpoint *priv_ep =3D ep_to_cdns3_ep(ep);
>> +	struct cdns3_device *priv_dev =3D priv_ep->cdns3_dev;
>> +	unsigned long flags;
>> +	int ret =3D 0;
>> +
>> +	if (!(priv_ep->flags & EP_ENABLED))
>> +		return -EPERM;
>> +
>> +	/* if actual transfer is pending defer setting stall on this endpoint =
*/
>> +	if ((priv_ep->flags & EP_PENDING_REQUEST) && value) {
>> +		priv_ep->flags |=3D EP_STALL;
>> +		return 0;
>> +	}
>> +
>> +	dev_dbg(&priv_dev->dev, "Halt endpoint %s\n", priv_ep->name);
>> +
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>
>How about grabbing the lock before checking for priv->ep->flags?
Ok, I will do it.
>
>> +
>> +	cdns3_select_ep(priv_dev, ep->desc->bEndpointAddress);
>> +	if (value) {
>> +		cdns3_ep_stall_flush(priv_ep);
>> +	} else {
>> +		priv_ep->flags &=3D ~EP_WEDGE;
>> +		writel(EP_CMD_CSTALL | EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
>> +
>> +		/* wait for EPRST cleared */
>> +		ret =3D cdns3_handshake(&priv_dev->regs->ep_cmd,
>> +				      EP_CMD_EPRST, 0, 100);
>
>if there was an error we shouldn't be clearing the EP_STALL right
>and leave the pending flag?
Yes, I will add such condition, but generally I do not expect such behavior=
.=20
Additionally I will add dev_err().=20
>
>> +		priv_ep->flags &=3D ~EP_STALL;
>> +	}
>> +
>> +	priv_ep->flags &=3D ~EP_PENDING_REQUEST;
>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>> +
>> +	return ret;
>> +}
>> +
>> +extern const struct usb_ep_ops cdns3_gadget_ep0_ops;
>> +
>> +static const struct usb_ep_ops cdns3_gadget_ep_ops =3D {
>> +	.enable =3D cdns3_gadget_ep_enable,
>> +	.disable =3D cdns3_gadget_ep_disable,
>> +	.alloc_request =3D cdns3_gadget_ep_alloc_request,
>> +	.free_request =3D cdns3_gadget_ep_free_request,
>> +	.queue =3D cdns3_gadget_ep_queue,
>> +	.dequeue =3D cdns3_gadget_ep_dequeue,
>> +	.set_halt =3D cdns3_gadget_ep_set_halt,
>> +	.set_wedge =3D cdns3_gadget_ep_set_wedge,
>> +};
>> +
>>  /**
>>   * cdns3_gadget_get_frame Returns number of actual ITP frame
>>   * @gadget: gadget object
>> @@ -365,8 +804,7 @@ static int cdns3_init_ep(struct cdns3_device *priv_d=
ev)
>>  		usb_ep_set_maxpacket_limit(&priv_ep->endpoint,
>>  					   ENDPOINT_MAX_PACKET_LIMIT);
>>  		priv_ep->endpoint.max_streams =3D ENDPOINT_MAX_STREAMS;
>> -		//TODO: Add implementation of cdns3_gadget_ep_ops
>> -		//priv_ep->endpoint.ops =3D &cdns3_gadget_ep_ops;
>> +		priv_ep->endpoint.ops =3D &cdns3_gadget_ep_ops;
>>  		if (ep_dir)
>>  			priv_ep->endpoint.caps.dir_in =3D 1;
>>  		else
>> diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
>> index 3b0d4d2e4831..a4be288b34cb 100644
>> --- a/drivers/usb/cdns3/gadget.h
>> +++ b/drivers/usb/cdns3/gadget.h
>> @@ -1072,4 +1072,7 @@ void cdns3_set_register_bit(void __iomem *ptr, u32=
 mask);
>>  int cdns3_init_ep0(struct cdns3_device *priv_dev);
>>  void cdns3_ep0_config(struct cdns3_device *priv_dev);
>>  void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep);
>> +int cdns3_gadget_ep_set_wedge(struct usb_ep *ep);
>> +int cdns3_gadget_ep_set_halt(struct usb_ep *ep, int value);
>> +
>>  #endif /* __LINUX_CDNS3_GADGET */
>>
Cheers=20
Pawel
