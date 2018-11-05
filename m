Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093B5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE89204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QkQrXJ2o";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="iaGeTgQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE89204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeKEPgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:36:11 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:50868 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728838AbeKEPgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:36:10 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA56GL6Q012744;
        Sun, 4 Nov 2018 22:17:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=5yxv0Mbp62MNUdmh8HU8y1OVQbSRRt0Hh3ahzssinoA=;
 b=QkQrXJ2o2SXwj91wCrR4VsOqpIeABcD+CjvPkvwCMe5DdornvwN5WUyTp5cSNlmn3fkG
 NJK8gkG8k8Vx3rss3as0w24sLLXtrMIeuUWyZm17NZqR/gSi+j58+oP825+nfXxjNIzh
 Y3Nw1rysv5BPQbhXUVgMzrhUxbtG0/L0DTNqeTFYXLBqyv3S91D/MbvKeesibdhhkKpz
 Fn+c9vSLTM5xJsearsGdbUTmrxeKH63WdszWlLiAmXqpjCL95UYW6BZdMmNlOGgFwXZs
 S+QZ3unVxNrd7MXM+0LU1sldoNtoTgHHocGVCKqeMnGdQu1NBo88J2ELeHkJfgaRghzb uQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp0047.outbound.protection.outlook.com [216.32.181.47])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nh87rqbsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 04 Nov 2018 22:17:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yxv0Mbp62MNUdmh8HU8y1OVQbSRRt0Hh3ahzssinoA=;
 b=iaGeTgQe3yZKZZ7msg/3xa9SitBceFK1MPMYJVlqiAgX+0WWMQubrxRWdhcjp+BIAYplvfRI/3kKXJcKLPBtSDxl733HavWlRRVMPk30jE4Yq6gpfEjlNR2l5kMwM8nOTPZnW3/B2tmckCjE1wSlt3aGbn/AsVzYWPxXn2+A5nc=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5512.namprd07.prod.outlook.com (20.177.231.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Mon, 5 Nov 2018 06:17:53 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8000:536f:b287:710f]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8000:536f:b287:710f%4]) with mapi id 15.20.1294.028; Mon, 5 Nov 2018
 06:17:52 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Joe Perches <joe@perches.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [RFC PATCH v1 13/14] usb:cdns3: Adds debugging function.
Thread-Topic: [RFC PATCH v1 13/14] usb:cdns3: Adds debugging function.
Thread-Index: AQHUc539qGP+3mxG50STZ9AW8y3lVqU+a7CAgAJE2zA=
Date:   Mon, 5 Nov 2018 06:17:51 +0000
Message-ID: <BYAPR07MB47098D7A1CF7941A6043F37CDDCA0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
         <1541267487-3664-14-git-send-email-pawell@cadence.com>
 <63f0e18c8335b6431f0f7dcf0895c73d85b11fa4.camel@perches.com>
In-Reply-To: <63f0e18c8335b6431f0f7dcf0895c73d85b11fa4.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctODdhNjE1NWQtZTBjMi0xMWU4LTg3MjUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDg3YTYxNTVlLWUwYzItMTFlOC04NzI1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjk4MyIgdD0iMTMxODU4NzIyNzUwODg5Nzc3IiBoPSJmZURTNlpxbW93ZTVNYUVZMXVtM09TSGo5TG89IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5512;20:UFupm0tvqXNhi4y2OHyycUsT4fz8zDhUP9mbyhktQPJH8odGOJgsgWoTByafdf7FN/QqYIDOobRr/RX1czv5jE/sL6+R8lr9WjFjLWBHm7u3yXL1zpxS/fNVkTfqclgSF9bLM9XoeaL+f6S0diVoe8i9DcOeTbcLGjPkGR4uB97YaKF5yDSRY4FaZOibt4wD7JM6lHQlpljsON63rREIq0xwmuiFJP95Z5bHVxEHcKoFArqXIoZeywoN60UbI9bE
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(136003)(396003)(36092001)(199004)(189003)(81156014)(99286004)(76176011)(7696005)(316002)(305945005)(3846002)(8936002)(68736007)(575784001)(7736002)(33656002)(2906002)(81166006)(6116002)(229853002)(446003)(97736004)(71190400001)(8676002)(6436002)(2501003)(107886003)(476003)(110136005)(74316002)(217873002)(66066001)(71200400001)(345774005)(54906003)(105586002)(106356001)(11346002)(4326008)(5660300001)(486006)(6246003)(55016002)(102836004)(186003)(86362001)(26005)(2900100001)(25786009)(478600001)(256004)(53936002)(14454004)(6506007)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5512;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: c3985387-f254-47f0-f358-08d642e66ace
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5512;
x-ms-traffictypediagnostic: BYAPR07MB5512:
x-microsoft-antispam-prvs: <BYAPR07MB5512D3B82FB3C7812B1EDCD6DDCA0@BYAPR07MB5512.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5512;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5512;
x-forefront-prvs: 08476BC6EF
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y0L42/4tVnlxTkXluh2Mftp75BGr1DcJTlp4yn9rccdTytU7uWPMguvYVsj5thy30Y/As73HuAjnR+jxQHB4dmf8MKnZigecJ1M5yd7uPooLsdJ5Rx85UEKuFoxn0wU1W/9jr9lG8T/ZztG0ibkVNd2eA8aMzA2RnoUKtyhp7e3WBrUzQAzV94yjulyuMUnklokzM7IiJZ6MoOOH6CgAy5WpIIcpKgjO2OFlv2R2iy6lnH0WPlWO4+LfNRcUYM95wEiahbwYHiPCanT1Oe1cbDeg5Y8kq04qb/hVS2mvG+RdHS+SxcxaxaFu5N4hD7xxzk0PJw0D9hJ68Lw0GkGMDstf6bHTJu1vXKlYd72lAuM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3985387-f254-47f0-f358-08d642e66ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 06:17:51.9831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5512
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=395 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Patch implements some function used for debugging driver.
>[]
>> +static inline char *cdns3_decode_ep_irq(u32 ep_sts, const char *ep_name=
)
>> +{
>> +	static char str[256];
>> +	int ret;
>> +
>> +	ret =3D sprintf(str, "IRQ for %s: %08x ", ep_name, ep_sts);
>> +
>> +	if (ep_sts & EP_STS_SETUP)
>> +		ret +=3D sprintf(str + ret, "SETUP ");
>> +	if (ep_sts & EP_STS_IOC)
>> +		ret +=3D sprintf(str + ret, "IOC ");
>> +	if (ep_sts & EP_STS_ISP)
>> +		ret +=3D sprintf(str + ret, "ISP ");
>> +	if (ep_sts & EP_STS_DESCMIS)
>> +		ret +=3D sprintf(str + ret, "DESCMIS ");
>> +	if (ep_sts & EP_STS_STREAMR)
>> +		ret +=3D sprintf(str + ret, "STREAMR ");
>> +	if (ep_sts & EP_STS_MD_EXIT)
>> +		ret +=3D sprintf(str + ret, "MD_EXIT ");
>> +	if (ep_sts & EP_STS_TRBERR)
>> +		ret +=3D sprintf(str + ret, "TRBERR ");
>> +	if (ep_sts & EP_STS_NRDY)
>> +		ret +=3D sprintf(str + ret, "NRDY ");
>> +	if (ep_sts & EP_STS_PRIME)
>> +		ret +=3D sprintf(str + ret, "PRIME ");
>> +	if (ep_sts & EP_STS_SIDERR)
>> +		ret +=3D sprintf(str + ret, "SIDERRT ");
>> +	if (ep_sts & EP_STS_OUTSMM)
>> +		ret +=3D sprintf(str + ret, "OUTSMM ");
>> +	if (ep_sts & EP_STS_ISOERR)
>> +		ret +=3D sprintf(str + ret, "ISOERR ");
>> +	if (ep_sts & EP_STS_IOT)
>> +		ret +=3D sprintf(str + ret, "IOT ");
>> +
>> +	return str;
>> +}
>
>This bit is pretty unsightly.
>Especially the static in each inline

Hi Joe.

I understood that you mean line=20
static char str[256];
This array will be defined several times.=20

I will remove inline form function definition.=20
It's not necessary.=20

>> +
>> +char *cdns3_decode_epx_irq(struct cdns3_endpoint *priv_ep)
>> +{
>> +	struct cdns3_device *priv_dev =3D priv_ep->cdns3_dev;
>> +
>> +	return cdns3_decode_ep_irq(readl(&priv_dev->regs->ep_sts),
>> +				   priv_ep->name);
>> +}
>> +
>> +char *cdns3_decode_ep0_irq(struct cdns3_device *priv_dev, int dir)
>> +{
>> +	if (dir)
>> +		return cdns3_decode_ep_irq(readl(&priv_dev->regs->ep_sts),
>> +					   "ep0IN");
>> +	else
>> +		return cdns3_decode_ep_irq(readl(&priv_dev->regs->ep_sts),
>> +					   "ep0OUT");
>> +}
>> +
>[]
>> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
>[]
>> @@ -604,12 +604,15 @@ void cdns3_check_ep0_interrupt_proceed(struct cdns=
3_device *priv_dev, int dir)
>>  	cdns3_select_ep(priv_dev, 0 | (dir ? USB_DIR_IN : USB_DIR_OUT));
>>  	ep_sts_reg =3D readl(&regs->ep_sts);
>>
>> +	dev_dbg(&priv_dev->dev, "%s\n", cdns3_decode_ep0_irq(priv_dev, dir));
>[]
>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>[]
>> @@ -537,6 +547,8 @@ static int cdns3_check_ep_interrupt_proceed(struct c=
dns3_endpoint *priv_ep)
>>  	cdns3_select_ep(priv_dev, priv_ep->endpoint.address);
>>  	ep_sts_reg =3D readl(&regs->ep_sts);
>>
>> +	dev_dbg(&priv_dev->dev, "%s\n", cdns3_decode_epx_irq(priv_ep));
>>

Thank you for comment.
Cheers Pawel
