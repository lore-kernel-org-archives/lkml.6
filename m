Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EA5C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A693C20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Vu4AhnKL";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Jl9FuhcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A693C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeKHV1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:27:08 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:47224 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726304AbeKHV1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:27:08 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA8BmpEt019100;
        Thu, 8 Nov 2018 03:51:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=27FmM67a9BwCv2pYgWgC38S3Nxv42eqMRkQdrNw1Uyw=;
 b=Vu4AhnKLOR2iJ5ET9NkhXbWuEWXg3DINK+vG9reJD3yRZd7YdzIXR8DzXeejQvMZfDT0
 7dY5Vr4QHOYbKDyhiptoQPJSe2G4i4Tc+dnK2Z+lporwnrmi23vfaOjxCBFBjgyNoKAk
 FYgBgjE1UsbHe8oG5V3o/z828vPKS5l7ZiEgvijIZYuSM0dGryEfLHOF2ZMQ+T/nA7vt
 rTavobFC4YWUv8rjBJwXQaVvHswppEGIcUhqiGQef/3KO6Q1M+2+8MQn0+3/ogweIDzy
 leg/MF1qMZQGir94I6EngrUN5A0dS+1rUBk9utuKTqfONpV+lpFWrzd1EyA9mwbg/AAG Pg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp0018.outbound.protection.outlook.com [216.32.181.18])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nm92j34y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Nov 2018 03:51:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27FmM67a9BwCv2pYgWgC38S3Nxv42eqMRkQdrNw1Uyw=;
 b=Jl9FuhcMLOZTr294G8lBb9QP+0rErwMVkmbBsfHCrVMrXwLdjEQt/5OJ1d5sxyvQTfPRGzuH13aKC4Dc7Kv46Ia6gAmVM5LqU06FMbHWK1pdxDNr78xOlpeAsQTZQBiQgDsV6Dk3O5/euQNo/pEKaunaL2Fx2jzwb2a0LTDyydU=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4470.namprd07.prod.outlook.com (52.135.225.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Thu, 8 Nov 2018 11:51:51 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8000:536f:b287:710f]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8000:536f:b287:710f%4]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:51:50 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [RFC PATCH v1 14/14] usb:cdns3: Feature for changing role
Thread-Topic: [RFC PATCH v1 14/14] usb:cdns3: Feature for changing role
Thread-Index: AQHUc539QMLIw1cHJke6/oBjfLbmy6VC2T2AgALu+YA=
Date:   Thu, 8 Nov 2018 11:51:50 +0000
Message-ID: <BYAPR07MB4709524FC194D27BE6128ABADDC50@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
 <1541267487-3664-15-git-send-email-pawell@cadence.com>
 <5BE1AA81.3030107@ti.com>
In-Reply-To: <5BE1AA81.3030107@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYWNlYWFmZDMtZTM0Yy0xMWU4LTg3MjUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGFjZWFhZmQ0LWUzNGMtMTFlOC04NzI1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNTY5MyIgdD0iMTMxODYxNTE1MTIzMzEzMzcxIiBoPSJhM2s1RGp0MU96YUFqYXBMUzhNeFA4RFNJbG89IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4470;20:MZQdTsWk+V1g4ILDl4h0befafPv2zyXziSL6a3XPUwHBbR8Gvs5+BsO8tnXPNJ3tx2S2iULrIkjCo2Oxu/W2s2gIHVmmT5ES+4kpzMEqJ1g5dQ3bdHYB/CNJUngn+zucOtjG6eunA+x2hDO3gS5CUo/uo2ZJLIhFT7T92/6CyO13Mg4LZHWjP/VYzyIN8jGm7t6USn6rmFZ2QAGPRydWIv24RqF+h5VtrGn5/PREwOJz0ft2gTAVkw1TxkZ9QuAV
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(136003)(396003)(36092001)(199004)(189003)(229853002)(102836004)(14454004)(14444005)(316002)(55016002)(6436002)(217873002)(256004)(6246003)(2900100001)(486006)(476003)(9686003)(81156014)(81166006)(446003)(86362001)(8676002)(6506007)(106356001)(478600001)(107886003)(53936002)(11346002)(105586002)(76176011)(305945005)(71190400001)(7736002)(186003)(71200400001)(110136005)(33656002)(26005)(74316002)(8936002)(4326008)(54906003)(68736007)(7696005)(2906002)(3846002)(6116002)(97736004)(5660300001)(66066001)(99286004)(2501003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4470;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: ed3c4542-4b19-4991-8cee-08d6457091b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4470;
x-ms-traffictypediagnostic: BYAPR07MB4470:
x-microsoft-antispam-prvs: <BYAPR07MB447069E5DC516A0CA94AA323DDC50@BYAPR07MB4470.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4470;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4470;
x-forefront-prvs: 0850800A29
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Pas9M3CZ5zbtijsZHFb4h4eL3N6IPfgl/JNtUhJ2e6xwWhgpwOxWnhUk0jMxSXkd5IEWCWqZOvpQK61a+vALvdlgQbmDPEXINJe53k2tl89iOEszEesC2WfLu6O97QLFEE7eL+F9Jko4iXCyfuibk+wkGLEU7jRMl2szKhKeKDp6WdMI+sow2pNO9LDmI4f3OmyAmDoxILkukQDhcZ1ueoycXq1T5ZzqFy0ckuCh5Wz45JyWLXd81g7ht4WjM2c+cKW84QN7aePYCvWPFbPajxg2ThhY0OZd9XHUbY+qT6fwWhWr12Zx6h9aY+wyinSv4K0Vime4z/e3SXVXAmPVtWVmxM2bSR1zCru4+EmeREw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3c4542-4b19-4991-8cee-08d6457091b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:51:50.1602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4470
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 03/11/18 19:51, Pawel Laszczak wrote:
>> Patch adds feature that allow to change role from user space.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/Makefile  |  2 +-
>>  drivers/usb/cdns3/core.c    |  2 +
>>  drivers/usb/cdns3/debugfs.c | 94 +++++++++++++++++++++++++++++++++++++
>>  drivers/usb/cdns3/drd.h     |  3 ++
>>  4 files changed, 100 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/usb/cdns3/debugfs.c
>>
>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>> index 34e60d03c4ec..08e6cdbebd46 100644
>> --- a/drivers/usb/cdns3/Makefile
>> +++ b/drivers/usb/cdns3/Makefile
>> @@ -1,7 +1,7 @@
>>  obj-$(CONFIG_USB_CDNS3)			+=3D cdns3.o
>>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+=3D cdns3-pci.o
>>
>> -cdns3-y					:=3D core.o drd.o
>> +cdns3-y					:=3D core.o drd.o debugfs.o
>>  cdns3-$(CONFIG_USB_CDNS3_GADGET)	+=3D gadget.o ep0.o debug.o
>>  cdns3-$(CONFIG_USB_CDNS3_HOST)		+=3D host.o
>>  cdns3-pci-y		 		:=3D cdns3-pci-wrap.o
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index 20ae9e76940e..4012f1007da9 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -309,6 +309,7 @@ static int cdns3_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto err4;
>>
>> +	cdns3_debugfs_init(cdns);
>>  	device_set_wakeup_capable(dev, true);
>>  	pm_runtime_set_active(dev);
>>  	pm_runtime_enable(dev);
>> @@ -346,6 +347,7 @@ static int cdns3_remove(struct platform_device *pdev=
)
>>  	pm_runtime_get_sync(&pdev->dev);
>>  	pm_runtime_disable(&pdev->dev);
>>  	pm_runtime_put_noidle(&pdev->dev);
>> +	cdns3_debugfs_exit(cdns);
>>  	cdns3_remove_roles(cdns);
>>  	usb_phy_shutdown(cdns->usbphy);
>>
>> diff --git a/drivers/usb/cdns3/debugfs.c b/drivers/usb/cdns3/debugfs.c
>> new file mode 100644
>> index 000000000000..d4871bc1a69d
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/debugfs.c
>> @@ -0,0 +1,94 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Cadence USBSS DRD Controller DebugFS filer.
>> + *
>> + * Copyright (C) 2018 Cadence.
>> + *
>> + * Author: Pawel Laszczak <pawell@cadence.com>
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/uaccess.h>
>> +
>> +#include "core.h"
>> +#include "gadget.h"
>> +
>> +static int cdns3_mode_show(struct seq_file *s, void *unused)
>> +{
>> +	struct cdns3		*cdns =3D s->private;
>> +
>> +	switch (cdns->role) {
>> +	case CDNS3_ROLE_HOST:
>> +		seq_puts(s, "host\n");
>> +		break;
>> +	case CDNS3_ROLE_GADGET:
>> +		seq_puts(s, "device\n");
>> +		break;
>> +	case CDNS3_ROLE_OTG:
>> +	case CDNS3_ROLE_END:
>> +		seq_puts(s, "otg\n");
>> +		break;
>> +	default:
>> +		seq_puts(s, "UNKNOWN mode\n");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int cdns3_mode_open(struct inode *inode, struct file *file)
>> +{
>> +	return single_open(file, cdns3_mode_show, inode->i_private);
>> +}
>> +
>> +static ssize_t cdns3_mode_write(struct file *file,
>> +				const char __user *ubuf,
>> +				size_t count, loff_t *ppos)
>> +{
>> +	struct seq_file		*s =3D file->private_data;
>> +	struct cdns3		*cdns =3D s->private;
>> +	u32			mode =3D 0;
>> +	char			buf[32];
>> +
>> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
>> +		return -EFAULT;
>> +
>> +	if (!strncmp(buf, "host", 4))
>> +		mode =3D USB_DR_MODE_HOST;
>> +
>> +	if (!strncmp(buf, "device", 6))
>> +		mode =3D USB_DR_MODE_PERIPHERAL;
>> +
>> +	if (!strncmp(buf, "otg", 3))
>> +		mode =3D USB_DR_MODE_OTG;
>> +
>> +	cdns->desired_role =3D mode;
>> +	queue_work(system_freezable_wq, &cdns->role_switch_wq);
>
>If we start with OTG mode and user says change mode to device will we stil=
l
>switch to host based on ID pin change?
>
>If it does then this isn't working correctly.
>We need to stop processing ID interrupts and keep the role static till
>the user switches it back to otg.

Switching role form user space will limited driver only to selected mode.=20
Only for USB_DR_MODE_OTG driver should base on ID pin.=20
That's my intension.

>> +	return count;
>> +}
>> +
>> +static const struct file_operations cdns3_mode_fops =3D {
>> +	.open			=3D cdns3_mode_open,
>> +	.write			=3D cdns3_mode_write,
>> +	.read			=3D seq_read,
>> +	.llseek			=3D seq_lseek,
>> +	.release		=3D single_release,
>> +};
>> +
>> +void cdns3_debugfs_init(struct cdns3 *cdns)
>> +{
>> +	struct dentry *root;
>> +
>> +	root =3D debugfs_create_dir(dev_name(cdns->dev), NULL);
>> +	cdns->root =3D root;
>> +	if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET) &&
>> +	    IS_ENABLED(CONFIG_USB_CDNS3_HOST))
>> +		debugfs_create_file("mode", 0644, root, cdns,
>> +				    &cdns3_mode_fops);
>> +}
>> +
>> +void cdns3_debugfs_exit(struct cdns3 *cdns)
>> +{
>> +	debugfs_remove_recursive(cdns->root);
>> +}
>> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
>> index 85731f3b693c..5344290c76f2 100644
>> --- a/drivers/usb/cdns3/drd.h
>> +++ b/drivers/usb/cdns3/drd.h
>> @@ -119,4 +119,7 @@ int cdns3_drd_probe(struct cdns3 *cdns);
>>  void cdns3_set_hw_mode(struct cdns3 *cdns, u32 mode);
>>  irqreturn_t cdns3_drd_irq(struct cdns3 *cdns);
>>
>> +void cdns3_debugfs_init(struct cdns3 *cdns);
>> +void cdns3_debugfs_exit(struct cdns3 *cdns);
>> +
>>  #endif /* __LINUX_CDNS3_DRD */
>>
>
>cheers,
>-roger
>--
>Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


Thanks,
Cheers,
Pawel
