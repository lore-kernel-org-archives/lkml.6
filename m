Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F4CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5686F20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="B3/lqVgl";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="RNb2FjcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfAQNx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:53:56 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34794 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbfAQNxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:53:54 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HDppmq011701;
        Thu, 17 Jan 2019 05:53:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=jWRoogrVeqcHVcRecRY2PZst9ZImHozDsAhsTT/pNTI=;
 b=B3/lqVgl0pALJHuYr5TA94WTjXB0OlpFkTmm74L37UCjNa86GtncfFvbiJe8CwAEzI5U
 J63nioBNLA3K1o7O3mf1pG7l2jSLTtOn8ZHxrjA9Q1C1NXFfn3zS/UyAjMwnBTIMYmje
 zY8Cn7s18F8bd+3lb97i7y89XSsMht7jnbZkj4zZ57hwh8XoD4o8BYIB2bX21vo9uhP1
 VcKiu11s94QLFOYQShaofzfqXHKmQ5EKNeuJeaxD+z2nhQdJ9oZD8fC+1mMwq5Sk7GAf
 5hozNgffE5s+Sn2nhGFBoSBmDdlHJmN7TJPReIW2fkiHK4mckn01mLj2K9d4tUzOHL7D zA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2q29mt5jmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Jan 2019 05:53:47 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 17 Jan
 2019 05:53:45 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.50) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 17 Jan 2019 05:53:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWRoogrVeqcHVcRecRY2PZst9ZImHozDsAhsTT/pNTI=;
 b=RNb2FjcJIiXzWPvj/4px25MK22i1Q5L+CAv8tblG6ISPg9l+zPLCPih28diW9bqjm9KuGdBql45hWvpL63dQwAE/h3RdnxfcrfmETZNYLWq+HktPyLVnx4n2HjbcecbTBKFMMhrOKY+LniXPU5zzkIDZnBqlkL8Xwe4yjhwYIW0=
Received: from BN8PR18MB2355.namprd18.prod.outlook.com (20.179.65.10) by
 BN8PR18MB2467.namprd18.prod.outlook.com (20.179.64.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Thu, 17 Jan 2019 13:53:43 +0000
Received: from BN8PR18MB2355.namprd18.prod.outlook.com
 ([fe80::5cfc:ec33:325b:b067]) by BN8PR18MB2355.namprd18.prod.outlook.com
 ([fe80::5cfc:ec33:325b:b067%3]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 13:53:43 +0000
From:   Denis Bolotin <dbolotin@marvell.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "Ariel.Elior@cavium.com" <Ariel.Elior@cavium.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "everest-linux-l2@cavium.com" <everest-linux-l2@cavium.com>
Subject: RE: [PATCH net-next] qed: remove duplicated include from qed_if.h
Thread-Topic: [PATCH net-next] qed: remove duplicated include from qed_if.h
Thread-Index: AQHUrjV8CpCemlbv6EONhu+nx76LM6Wzeuvw
Date:   Thu, 17 Jan 2019 13:53:43 +0000
Message-ID: <BN8PR18MB2355E8862A32E65DBEB0C609C1830@BN8PR18MB2355.namprd18.prod.outlook.com>
References: <20190117072220.14900-1-yuehaibing@huawei.com>
In-Reply-To: <20190117072220.14900-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [31.168.140.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN8PR18MB2467;20:OJ8RRYGPOM6tMXjO+AN76UZLW31DH0f0RTmdNW2rHQuIm6OPVgzjhiF9Dcj1gd87qnaTzwSI3VwAzofhbg9weZLTja42wkvN043bb5ySENs8s0h4IeqxZcDY24+hfzoXapRcHEiuFDsareUL5UPZKfGg0L2KtqKjW7hZm1ezLUQ=
x-ms-office365-filtering-correlation-id: be8aa768-dab9-487c-8960-08d67c833188
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN8PR18MB2467;
x-ms-traffictypediagnostic: BN8PR18MB2467:
x-microsoft-antispam-prvs: <BN8PR18MB246737BEBB09762A78324774C1830@BN8PR18MB2467.namprd18.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(396003)(39860400002)(189003)(199004)(25786009)(55016002)(106356001)(478600001)(26005)(14454004)(14444005)(256004)(102836004)(8936002)(2501003)(186003)(33656002)(76176011)(7696005)(6506007)(71200400001)(71190400001)(3846002)(4744005)(305945005)(81156014)(110136005)(66066001)(446003)(81166006)(105586002)(53936002)(6246003)(6116002)(7736002)(54906003)(11346002)(2906002)(86362001)(2201001)(8676002)(68736007)(476003)(316002)(74316002)(6436002)(4326008)(5660300001)(486006)(9686003)(99286004)(97736004)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR18MB2467;H:BN8PR18MB2355.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fBu5HT3f32fS7ZOgx2d2wV3rG7FEYsq/B5ydvKYjCs5Tbp0hIQ/qgvfpLGLMRq9zY8FVWN/XZBgIw2vezcIbUOxj6JFgSSvTn+Qh6KrgClPEs4MjmD+lFYC447i7M2N312aQFxqRDyWzl92opOuDSh3lKJK8eUc5slK/mvoMwWRai9ZgcWpY+18FewzWrBpR8RWW46xUGb0GMI/bHcfrbNR+xp9nyiOzmeSuhgT706rhQ6J/bcGsRx1O9bz8xKEoESXdO9ktyAfO+kL+CPZ0bmr0hfHAxv+n11vKG57PmhLPPnjxdnPw9F3HiMye1Yf/3Aw4SY4T/kPIXA0Or6lAfbRzYMtQqfHKGg7S2HMquDSmTXwF2Y63lSgxkDihf/q1/9F9b98v2tkXPt9HMeHoXaeBpsobvpeNuE4e/AbVtmU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: be8aa768-dab9-487c-8960-08d67c833188
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 13:53:43.2626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2467
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_04:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=935 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Remove duplicated include.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/qed/qed_if.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/linux/qed/qed_if.h b/include/linux/qed/qed_if.h inde=
x
> 91c536a..5f818fd 100644
> --- a/include/linux/qed/qed_if.h
> +++ b/include/linux/qed/qed_if.h
> @@ -38,7 +38,6 @@
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
>  #include <linux/skbuff.h>
> -#include <linux/types.h>
>  #include <asm/byteorder.h>
>  #include <linux/io.h>
>  #include <linux/compiler.h>
> --
> 2.7.0
>=20

Thanks
Acked-by: Denis Bolotin <dbolotin@marvell.com>
