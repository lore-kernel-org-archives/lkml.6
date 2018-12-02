Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB90C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCC520881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="bPVpGJCO";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="A9cygit5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCC520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbeLBT2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 14:28:04 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34484 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbeLBT2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 14:28:04 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB2JRIrL018046;
        Sun, 2 Dec 2018 11:27:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Gtaaj6U6NxVVCM/+zFGGi4yR9xdR5QSKztdjjixs2BM=;
 b=bPVpGJCO6BxVYBuKQhbgDY9vpMIU5wVBZ038Ffb2lwOc0nbovUERtyqyqMgChlK2GnHb
 ojYrOcmpPnxrXdwUIKZ2GZGetncqJClQxurps+DJVrj9nMXRQlezFsrpfP2UvHNuNXW6
 953xHoNhmu1KpGwEfRCEtYRA1Av545QcLAMdbqvT9/0IGwPplLT//4T6DqplkVcnq3Bt
 1a2Y+CecpEA00CVT8Fh9zYMVybrWtp8922tsJ4uTDlH+jlKQKFLCD3RVBVAf7mmnhS5W
 nIa7RFF0N8nrHDT8cw8jIfzs6tAuVLY13XV0YNJCyZ/FZqmejQAKrxbdkGMMCMAMqlzB Mg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2055.outbound.protection.outlook.com [104.47.36.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2p3qr16he3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 02 Dec 2018 11:27:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gtaaj6U6NxVVCM/+zFGGi4yR9xdR5QSKztdjjixs2BM=;
 b=A9cygit5Lek+Xu6JVneFe+eJvegXWhXMYdnrCltfZW0LqEI2T3GDGcbDJoIkdawthYUVrInjg7K7mSHrD126JQ7Od7udOePZWwtVJWhzjpYT/fN8CMjvACPVrzwHXgM8/6NceXnFGz61GI7kvH11pp9jaxnWfHrRb2ZkE3B8z/c=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5415.namprd07.prod.outlook.com (52.135.241.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Sun, 2 Dec 2018 19:27:30 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1382.020; Sun, 2 Dec 2018
 19:27:28 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     PETER CHEN <peter.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [RFC PATCH v2 02/15] usb:cdns3: Device side header file.
Thread-Topic: [RFC PATCH v2 02/15] usb:cdns3: Device side header file.
Thread-Index: AQHUfycJzsVSHKUPpEauszYsGMPBFaVn8v8AgAPP8mA=
Date:   Sun, 2 Dec 2018 19:27:28 +0000
Message-ID: <BYAPR07MB4709E47639F2DA3339D99147DDAD0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-3-git-send-email-pawell@cadence.com>
 <VI1PR04MB5327F686BE6E9F5D85380BA98BD30@VI1PR04MB5327.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5327F686BE6E9F5D85380BA98BD30@VI1PR04MB5327.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMjJkZWM0YmEtZjY2OC0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDIyZGVjNGJiLWY2NjgtMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzA3MiIgdD0iMTMxODgyNTIzNzY4MzcwNTUwIiBoPSJjN2N2MmJ2R0xkamxLekI3a2p5bGFnWS8velk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5415;20:1b7ZJY18xT4LrG1tRnRgrtCT3nYYtX2fezJb8t+ECMNqrDu9mpeI8KvFne6mYsRnqc8RCDBOG29cFGBDPUdoOTIMHf/KXTMIwfopDiudmSBduZEv6Kg+YoFv4hn5eURxLIJdyYjpFimfsH/0nkOymL+jdn3geImJjvMWCWkd1VUMhFFvGXvhiRDE/lPcifHb6W+m/SQpF3GYBT+7m3UFUyj1MqGSxjGhZOwSdkWJ9N0CIWyAdUAW1Nu8FfKlKHPl
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(39850400004)(376002)(36092001)(199004)(189003)(68736007)(74316002)(106356001)(26005)(53936002)(105586002)(66066001)(305945005)(6436002)(7736002)(186003)(3846002)(33656002)(102836004)(217873002)(4326008)(6506007)(6116002)(55016002)(107886003)(6246003)(71190400001)(2906002)(71200400001)(256004)(14444005)(9686003)(229853002)(486006)(2501003)(8936002)(8676002)(110136005)(76176011)(316002)(11346002)(81156014)(81166006)(476003)(99286004)(97736004)(54906003)(25786009)(14454004)(86362001)(5660300001)(478600001)(7696005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5415;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 3f2d09a9-df31-4fde-e416-08d6588c3250
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5415;
x-ms-traffictypediagnostic: BYAPR07MB5415:
x-microsoft-antispam-prvs: <BYAPR07MB54154862E3C7BC30F28EC55BDDAD0@BYAPR07MB5415.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231455)(999002)(944501491)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5415;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5415;
x-forefront-prvs: 087474FBFA
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +liX+SGJKUI8ULs1wujC7Nj4yNgBT4ATiIJqjiJL9U+/3z71GG/l577NFu+GZOjh2n15hwuX+w1nQ4eHsikMRjpP9RIqm7u9SQ5tx903BknkMkDbuaYY7QBzIAVMzzPWUquUH9jGDrp+E/40GTcDKlxrjkR0mLXZeXTe6OPVT3N/wmGNZcw9eb1aGyOftCYeh5rq4gYgwL6TZUY699El+Luadl6y4YH8nimE2eHdSqqiMW0HmXhuflOMrqIiiTXbvwvnzuG86yqazNjP5KZRUiuPTndJLQe3x8owXB7X0us3RvQ8t1O3AkExhGfoh+yIJYKrcOV0YG7Lt1oPEKPH4U80blxC3j0LivL51+4kHOU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2d09a9-df31-4fde-e416-08d6588c3250
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2018 19:27:28.1090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5415
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-02_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812020187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter
>> +
>> +/*
>> + * USBSS-DEV register interface.
>> + * This corresponds to the USBSS Device Controller Interface  */
>> +/**
>> + * struct xhci_cap_regs - xHCI Host Controller Capability Registers.
>
>struct cdns3_usb_regs - device controller registers

thanks, =20
I had this from beginning. I don't know why. =20
I=20
>
>> +struct cdns3_device;
>> +
>> +struct cdns3_endpoint {
>> +	struct usb_ep		endpoint;
>> +	struct list_head	request_list;
>> +	struct list_head	ep_match_pending_list;
>> +
>> +	struct cdns3_trb	*trb_pool;
>> +	dma_addr_t		trb_pool_dma;
>> +
>> +	struct cdns3_device	*cdns3_dev;
>> +	char			name[20];
>> +
>> +#define EP_ENABLED		BIT(0)
>> +#define EP_STALL		BIT(1)
>> +#define EP_WEDGE		BIT(2)
>> +#define EP_TRANSFER_STARTED	BIT(3)
>> +#define EP_UPDATE_EP_TRBADDR	BIT(4)
>> +#define EP_PENDING_REQUEST	BIT(5)
>> +#define EP_USED			BIT(5)
>> +	u32			flags;
>> +
>> +	void			*aligned_buff;
>> +	dma_addr_t		aligned_dma_addr;
>> +	u8			dir;
>> +	u8			num;
>> +	u8			type;
>> +
>> +	int			free_trbs;
>> +	u8			pcs;
>> +	u8			ccs;
>> +	int			enqueue;
>> +	int			dequeue;
>> +};
>> +
>
>Would you please add kernel doc for above structure?

Done.
>
>> +struct cdns3_request {
>> +	struct usb_request request;
>> +	struct cdns3_endpoint *priv_ep;
>> +	struct cdns3_trb *trb;
>> +	int start_trb;
>> +	int end_trb;
>> +	int on_ring:1;
>> +};
>> +
>> +#define to_cdns3_request(r) (container_of(r, struct cdns3_request,
>> +request))
>> +
>> +struct cdns3_device {
>> +	struct device			dev;
>> +	struct cdns3_usb_regs		__iomem *regs;
>> +
>> +	struct usb_gadget		gadget;
>> +	struct usb_gadget_driver	*gadget_driver;
>> +
>> +	struct usb_ctrlrequest		*setup;
>> +	dma_addr_t			setup_dma;
>> +	dma_addr_t			trb_ep0_dma;
>> +	struct cdns3_trb		*trb_ep0;
>> +	void				*zlp_buf;
>> +
>> +	struct cdns3_endpoint		*eps[USB_SS_ENDPOINTS_MAX_COUNT];
>> +	int				ep_nums;
>> +	/*
>> +	 * field used for improving performance. It holds the last
>> +	 * selected endpoint number
>> +	 */
>> +	u32				selected_ep;
>> +	struct usb_request		*ep0_request;
>> +	int				ep0_data_dir;
>> +	int				hw_configured_flag;
>> +	int				wake_up_flag;
>> +	u16				isoch_delay;
>> +	/* generic spin-lock for drivers */
>> +	spinlock_t			lock;
>> +
>> +	unsigned			is_connected:1;
>> +	unsigned			in_standby_mode:1;
>> +	unsigned			status_completion_no_call:1;
>> +	unsigned			u1_allowed:1;
>> +	unsigned			u2_allowed:1;
>> +
>> +	u32				usb_ien;
>> +	u32				ep_ien;
>> +	int				setup_pending;
>> +	struct device			*sysdev;
>> +	/* The device mode is enabled */
>> +	int				start_gadget;
>> +	struct list_head		ep_match_list;
>> +	/* KB */
>> +	int				onchip_mem_allocated_size;
>> +	/* Memory is allocated for OUT */
>> +	int				out_mem_is_allocated:1;
>> +	struct work_struct		pending_status_wq;
>> +	struct usb_request		*pending_status_request;
>> +};
>> +

Cheers
Pawel
