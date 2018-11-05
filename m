Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E468C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5BC2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="I9oh/osA";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="AX+CYth1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5BC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeKETxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:53:37 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36494 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726319AbeKETxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:53:37 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA5AQvu1020649;
        Mon, 5 Nov 2018 02:33:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=poJlbK0YbBA6u2M36rgSQBwRJb20+RsrIA15MP3PFKo=;
 b=I9oh/osACNUXfgo6M2O96FLdI6pmGeJcUPOfqFDqc38Qw02uVHFIp6/Car7t4ZEdaWzr
 XmwJR4AR7MmXDUq4MwUk5QzL5IgRm1qYNGWRHlotUWo1pOwjeGkm6ce8tK3DvZ7AX8+Z
 61h2BeYVcAoDIcm3IlTpwhLnct4pKhfdYbVzbnXAsd+1LQSTbT2oeat2phk86xpP/zpd
 uUjFwdWagdIarZOwWE8vhA5jqORllv/2R3hvcBoK2NAjfwovv3Bhblp+drZTXj0giC7O
 RNevEMVBNSFZLfRjJ9B0e1oB75crBE5KjVEnQWITXc6d53ngcNx24sQaR8OmP9bx+CMm fA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp0017.outbound.protection.outlook.com [207.46.163.17])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nh87rrac7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 05 Nov 2018 02:33:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poJlbK0YbBA6u2M36rgSQBwRJb20+RsrIA15MP3PFKo=;
 b=AX+CYth1GvGMTF7GJKZG/UxOo9mkRknqW71XCm5HHMYP/OVsrU80JkVSGDp0FXOepsyyxxrkq6QURDcjX8WKiAln95f9X69tqKlXx1ByFpwxACorp0Phwd8Ix3C1w2mSVVXfTekcvhZ6qgkXLJWWggo4rSXCCUDyCUOOapjkcAw=
Received: from CY1PR0701MB1664.namprd07.prod.outlook.com (10.163.20.22) by
 CY1PR0701MB1355.namprd07.prod.outlook.com (10.160.150.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Mon, 5 Nov 2018 10:33:29 +0000
Received: from CY1PR0701MB1664.namprd07.prod.outlook.com
 ([fe80::59a0:1638:ccd6:ad87]) by CY1PR0701MB1664.namprd07.prod.outlook.com
 ([fe80::59a0:1638:ccd6:ad87%2]) with mapi id 15.20.1294.028; Mon, 5 Nov 2018
 10:33:29 +0000
From:   Damian Kos <dkos@cadence.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?iso-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Piotr Sroka <piotrs@cadence.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Rafal Ciepiela <rafalc@cadence.com>,
        "quentin.schulz@bootlin.com" <quentin.schulz@bootlin.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>
Subject: RE: [PATCH v6 0/6] drm: add support for Cadence MHDP DPI/DP bridge.
Thread-Topic: [PATCH v6 0/6] drm: add support for Cadence MHDP DPI/DP bridge.
Thread-Index: AQHUX0/e2PllWSvZiEqVG0HuQ+ejRqVBF/BwgAAOeICAAACgAA==
Date:   Mon, 5 Nov 2018 10:33:29 +0000
Message-ID: <CY1PR0701MB16644A2C7EF670F5AC732BF8CDCA0@CY1PR0701MB1664.namprd07.prod.outlook.com>
References: <1539034953-11274-1-git-send-email-dkos@cadence.com>
 <CY1PR0701MB166434BBB71DB76593E0F513CDCA0@CY1PR0701MB1664.namprd07.prod.outlook.com>
 <3056496.a8qoricJmv@avalon>
In-Reply-To: <3056496.a8qoricJmv@avalon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGtvc1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTNkNDA2YWMyLWUwZTYtMTFlOC04NzJkLWE0NGNjOGNjMTI3Y1xhbWUtdGVzdFwzZDQwNmFjNC1lMGU2LTExZTgtODcyZC1hNDRjYzhjYzEyN2Nib2R5LnR4dCIgc3o9IjE2NjUiIHQ9IjEzMTg1ODg3NjExOTY3NDIyNyIgaD0iSjN4ZExjTUNiUjNEWnllazh0TUU1QjROa3ZVPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0701MB1355;20:zRg9tcZfTTws44jGBgcRYLSP9YygvibDWheIUHrYcDHoVN52KXSODKwEbwgBIrODVdrT4YTDV8gkL5LUWDqwjAxlGjteSH7w18fJQF7JQ9vViIWB5rMMylDFjGQCS0pxps2+CEOPT85s5iAEHjUmj4+/t7ZHD5QpLRtpBOlPMdarh0W04bhR1ZgGP69WX4jypP7HBERs/oasC+0eblVLC/+SFQ7YrjLSyzcz8ihWZJKNh30V23Wc2uwJwnPHOQgi
x-ms-office365-filtering-correlation-id: 46d0baa7-1a64-4062-ad14-08d6430a2084
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY1PR0701MB1355;
x-ms-traffictypediagnostic: CY1PR0701MB1355:
x-microsoft-antispam-prvs: <CY1PR0701MB1355E9547C05CF1070F1489FCDCA0@CY1PR0701MB1355.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(217544274631240)(9452136761055)(258649278758335)(31051911155226)(72806322054110)(180628864354917)(7411616537696)(228905959029699)(58145275503218);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY1PR0701MB1355;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1355;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(36092001)(13464003)(25786009)(71190400001)(71200400001)(3846002)(6116002)(6916009)(7696005)(76176011)(33656002)(2906002)(53546011)(6506007)(102836004)(14454004)(486006)(74316002)(476003)(68736007)(66066001)(97736004)(2900100001)(99286004)(446003)(55016002)(11346002)(86362001)(9686003)(6436002)(5660300001)(106356001)(4326008)(6246003)(316002)(256004)(305945005)(54906003)(105586002)(7736002)(478600001)(8676002)(8936002)(26005)(229853002)(53936002)(81166006)(81156014)(186003)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1355;H:CY1PR0701MB1664.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SUFNkBMm5t26D1pyQWf4SWf9+FIbeY1UvL/qUopT6lFC6iRd1auBAxvYoD4wn9jtJ8NGkgUOsS/SllW2QQpdVeo8OZtKQFhXENyKI4UTNui2DeYGtjSCrxm91sWD2/RwuvyqpgTXfOPkmiVGI6DqRwrqt67Cu0VqW4101hh1+2dYYk70pOzOsanfXI7aTn5EHsVERP176EZM8nGdHx0mz/P4/MK/POjEXqgGU9gDVrebxtnBqSwNavntHq8i4SUyO6Ll4wLYTeQiK3X2QYdu9k/Us6I2aSjersi/a1xlmB7WkiWVGFkQNH5RtjFbz6ntAXePPU6Php/SE6MsUQdBxfOvKnOld4ZGhRzR393h8G0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d0baa7-1a64-4062-ad14-08d6430a2084
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 10:33:29.1682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1355
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Understood. Thanks.

Damian

-----Original Message-----
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>=20
Sent: Monday, November 5, 2018 11:30
To: Damian Kos <dkos@cadence.com>
Cc: David Airlie <airlied@linux.ie>; Rob Herring <robh+dt@kernel.org>; Mark=
 Rutland <mark.rutland@arm.com>; Archit Taneja <architt@codeaurora.org>; An=
drzej Hajda <a.hajda@samsung.com>; Gustavo Padovan <gustavo@padovan.org>; M=
aarten Lankhorst <maarten.lankhorst@linux.intel.com>; Sean Paul <sean@poorl=
y.run>; Sandy Huang <hjc@rock-chips.com>; Heiko St=FCbner <heiko@sntech.de>=
; Quentin Schulz <quentin.schulz@free-electrons.com>; Piotr Sroka <piotrs@c=
adence.com>; dri-devel@lists.freedesktop.org; devicetree@vger.kernel.org; l=
inux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-ro=
ckchip@lists.infradead.org; Rafal Ciepiela <rafalc@cadence.com>; quentin.sc=
hulz@bootlin.com; jbergsagel@ti.com
Subject: Re: [PATCH v6 0/6] drm: add support for Cadence MHDP DPI/DP bridge=
.

EXTERNAL MAIL


Hi Damian,

On Monday, 5 November 2018 11:44:53 EET Damian Kos wrote:
> Hi Guys,
>=20
> I'm wondering if this time patch is so good that there're no change=20
> requests, or is it so bad that it was rejected without a comment : )=20
> Please let me know if this patch is being in review or was rejected=20
> and, if so, what needs to be changed.

I unfortunately don't have time to review your series for the time being.=20
Hopefully someone else will have a better review bandwidth :-) Sorry about =
that.

--
Regards,

Laurent Pinchart



