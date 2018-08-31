Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A542083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="QDubzUyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A542083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeHaMUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:20:42 -0400
Received: from mail-eopbgr680043.outbound.protection.outlook.com ([40.107.68.43]:27968
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727536AbeHaMUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFn8rgeC1vgsMFnOwppdlgQ10jgxRC9rr9awKFyZhsY=;
 b=QDubzUykpuixDTLy9EnPBdNntAjUGoiRsflkbUFdA8N1FvD6lftZmEuAAoMOYMV4YRRR9sIKC+Ik5ycUkVU9u7VQT5o2xdxHE6FBwLLzgFbaWGhQafXV4QOsA5ebzSMW49eLi0u6gm4l43buRnBHXFqk//8NNmvdsyDIMu5T57o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1578.namprd03.prod.outlook.com (2a01:111:e400:529c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.15; Fri, 31 Aug
 2018 08:14:18 +0000
Date:   Fri, 31 Aug 2018 16:11:09 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] net: mvneta: reduce smp_processor_id()
 calling in mvneta_tx_done_gbe
Message-ID: <20180831161109.23db0901@xhacker.debian>
In-Reply-To: <20180831160810.2539ef4c@xhacker.debian>
References: <20180831160810.2539ef4c@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSAPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:604:c::16) To CY1PR0301MB1578.namprd03.prod.outlook.com
 (2a01:111:e400:529c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84e9e948-e200-42f3-c6dd-08d60f19c0f2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1578;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;3:DlIc0YFZsDBMpbAsB8g6yqNuREw2NFjhpWSAl5bdtA4Etcqj7eDgaPfBwbscFeJ/muoXt6ovSB9jdclISOyVMuzSXjtn1gUOfy6hYgbCmnFTEWL+szWRmYbFoSxzb6a7D37iDDVhK6Xn1sMYJlGTiBoEYr5j2nuYeUeTBEJWPFUyc4IjYxyw/BoWPKgt97J9s55DCA3msGnlVaLrJEQKWQYVLi31sxWunyT7jVHdX+UQ6vHfIwZPn83on85o6Is6;25:6EeIkQbBa6aEkXuBrUGCpcMo4iNtqvGMTxW6eGPIxROLYMmz/qafDpFCEsZ2HxkP6s+Zn69hgd4+1ISBqjMa53S1hipCUJYlxXGJhHezXuxMvV2usI8bBNC1zRKD1MU/ujeVnZtvkVZdRi49AVBe9aWmnpkvVT6CXQHUfk94H0TlQ1zH09Hwl7AMvZRZgahuFOSLaae5wn+sU58g6l1k3kNev37OP2jaFEDzFmLgJT8/du0W8H/YMcmc+65ULnfjkfSnqw+T0E7hRC0DY1CLFncQolwBga0bmJ/MbWOyyg53KeMGdsCIsYWnjNbHt+crmdHKl+tLx/pLZi09jSShqQ==;31:ZkLr6AJ+0qwtwQ5MfnvZC01PArnAUbwHyaej/UXa3GHkywtReztLqDTzGv9dT7h+uma++a2Vdh8I8dzl9CIGIK5uI7wOP3g6ji8lpCmp+nrPOCWIvumn2n90HYOL6CahNzLgZYCO4jn8sIcACa0jOZZBEJ5N134UAp4bnCkldLImCcPVEYef+Dc6aJ8JuXJZ/DwQeVvNG8fQ7WLSA3qYHXKN9gUCiMkEninzVNvJLwA=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1578:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;20:0+NgwjKiolxfnfx5ZYQsfjaIpEUiJhKOvrcE8N+RbUNymrSOv5l6deXe8tcgtxYvFBm5VhYWgPeBRiQfzqojBXAtOwTcmjbL10W/9++Myf6H1H8jc5clLaam/jN3nWyIUtSdggJwl6hUcpfeilk0eJdmMXjtYYH4/oZn/QStxKlDZCSAWmAP891o8VMW74XN77ylKjpNrykvOZQhAk9iouE6FdahnsaKxRb0TxqU2HPQnkXrOThQ6mM5OBzPAATWilVjZgxfo0htYYM+6gWmELKRIJxYEEErY+nZ0iN0ml382juy5/udmAcEQHoc1LdoEBsl4CTaEFR4TMSBYcMbq5OAbRsT/dpCyyC3TFHXOn9AXPJ4GIklO7f4b1+BS29zRPeTfZUvWZx4ZB+sQbrufKgIUOidPTo19aXytL/EgqIMmtt5w++B4kJMZNDMk6qEbfz0dn9hB3G5RnNki6YA2HMVR1pMHtchlcFkLSI9EpSz1J4hMZXcVhBTAR3eWcpX;4:OzAhYZvf0dhQONxrdgtlosHxCsgyimCW8yW8JVIkVT4wahILwr3a5BhiNzHbU3zFjHNNoUqfitaqt8dNcGrlEbBC+xSSQ+nmsvbOl+bDz4LMohkrJ8Rrr+O40fXhgjHRhKNb6ixnM+tQQzxDavhCVg2HvjhCAOTVzPXSmYqPVFoXN4enhYTe5zsH9q/D40L6RvhHDINucUboA9auIxEmr5/UeHX9mYNKTL3bD20Z+ndgvWeR90Mvvc7DPg6FykSM+7KddznZFLRnpTPYLoTb2A==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB15786CF26B3412A000D5751EED0F0@CY1PR0301MB1578.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:CY1PR0301MB1578;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1578;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(376002)(346002)(366004)(189003)(199004)(53936002)(55016002)(956004)(476003)(11346002)(9686003)(486006)(386003)(47776003)(106356001)(105586002)(97736004)(7736002)(6506007)(66066001)(4326008)(33896004)(81166006)(25786009)(5660300001)(2906002)(8936002)(26005)(50226002)(81156014)(8746002)(72206003)(14444005)(16526019)(316002)(1076002)(7696005)(52116002)(50466002)(110136005)(6116002)(6666003)(3846002)(86362001)(23726003)(186003)(68736007)(76176011)(8676002)(305945005)(446003)(478600001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1578;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1578;23:EQLxBRhP3ZSbXnhEYVqJxiKiTJtoSnGhmm2uW61?=
 =?us-ascii?Q?hy+GDuwrkBSmOumMo5i607yNrXHEwsxLcxd/8e6NtUm3LFG/MoJQJLFF3Mi4?=
 =?us-ascii?Q?fOh/eCcv0LqfZnd4kq4sGzFBA7h8ku5pQp/JDxNELx9nqEx7bAcsTPT2p7Sq?=
 =?us-ascii?Q?o5vGKemJmKAdPYaV7ANYoAbV+xRtOOzYRJsBswDa5fY3P4Mku6cUAY2PbCsF?=
 =?us-ascii?Q?y+1/e17D3nbJ5z42yXBydN4A564DFw31h+gqjLRq/dhganFzlhORVpsaNvHm?=
 =?us-ascii?Q?EQ/uBqRNNtilFYXPaKZNilyfq1MhNgqwGU68kTJuIAcW8ytiVkGG3ObW4+cw?=
 =?us-ascii?Q?O9caNA19bh00Oql+yySeWtNZi5kgjT9YeAgtRNI0AawUcw/bVLZUNfMmXuNp?=
 =?us-ascii?Q?X4esRvz/e5nhW4d++rrsMywoS1jby7ZhN5jOpNz2DH8eqejmPdWGivjJKbUk?=
 =?us-ascii?Q?cFM3gld6nwDRxgcaDLW9kzNzZIyt54y43/sbWcvv4DhpDbni7Y6RN83TpyUW?=
 =?us-ascii?Q?Yyzv9FBQPbvKi5nrS6oNwVTgVo6JPp84tYS9txhBlj4ocnfESjfFoZEA5yu1?=
 =?us-ascii?Q?SysvyLZ5UHZepjIGjOryLNjT+s16ekVJzAQDAtEd2bR/3EAQLVuVClKp7cD5?=
 =?us-ascii?Q?6+roX+cFuwRjCsZPkgkrvqNyoEPvFomoeWREWBx+pr+Wab/571skEFb2yy+I?=
 =?us-ascii?Q?uJg6gkBBpMhO5VyRwUMQmP+0UpXO6FRvtghhQ1sjcsJdT7do1X9KnH1eWt1b?=
 =?us-ascii?Q?Z1l2W2VZFZI0sj+v6a9c5gK8avB9Zd+M8v2b2T0pHwNRcPWPzUoSHSpERnNl?=
 =?us-ascii?Q?Xds1TX7obvv04b3XU5i5edq0J6O+nAB+CEUdPTXd+kNTTjD/650t7VVkduGp?=
 =?us-ascii?Q?/CbQDzD+nxUGjtXil83KEsd+Pj0sdjcVE4c4FKj359VjXzvZ5M2VXhikuxTS?=
 =?us-ascii?Q?VJEke5dzKy51mSHhDdzY2n/DDjp6WzagzGlLWz+H7DG05EFt2c1bA2Lbwwjo?=
 =?us-ascii?Q?eImZ+IETernmg4ttFpHA3O+7VmmLVyW80HL/yHd6u10YSHhpRz6Ee418WqUu?=
 =?us-ascii?Q?styiwIduykp0Ru0g2EtAKaxpQEpSN5c6Nkhp1ufMnyputR+geE7yQFz8ITu5?=
 =?us-ascii?Q?e9pt0it83T4yUovQ+lPb+fNneYNGtTy1r4erePzDjPuYrEtczgoDRFYnB6ok?=
 =?us-ascii?Q?RgnWwUXkq+nlpQTVFU1fYTyDtjrz/Uc5OXG27rq3raB9hB7xoN9wnfOK4gw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: YmczNd/kPny1tyzI7ZPOzgdnKa0XZNP+CIYe+3TNVyde3t54KNUzO7gk9wBkkOjx7wTMkT5B4HQea/HzzaiL14xxmVVA82OJIpXziiuKjIIFxQMgg5z4RjrZmbtbFApMTnWnRClHWb08MzFuMT79hW+trRtEDPMqltrtha5z9OohDH8UKLaktOagYO9snPO7hculXTgo26PcBye9o8Ju8EXYI0+/DXJczj/Cn7buoyEf8ViAIDlgHjLUoO1UBwLCctqVGPxhXy6Q+8N+XX6+op6CN8eEHguP8eHyIZ9rw+oJME2YSTMFcwQmE803U/R8beoIStCEF+Lc0X0+Xyq27ao3IjrtgJTvQGXMIAmWbmY=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;6:1TWmNJl9r+pd4wq1xhgsk+CPMhEu14DquXEWazO5BJu/QLbTTWnp8E3rMDTVNICyyCP6Cok1rPvzIA4sUihggMUY1XgBw50E92pM34XrcKk85wLmmKGLp04MZsEpnfB1inE/BKGTnC/uDHQAMNGi6bHNQ5fI4TijzzCjYDz3aSvUEUexjqq/b7Y8jqj8bF0ogaBxtA7Ch5NikB3POELHTCzveRgBnZBqdiaI299kYkNipEmCxMGShYcL63v7cNDnC2Mw6vpWwe/Ff4lXG/Y8votEcHb+AzNtP3+yXt24+nEWxhO7zjxq7cn1q+PxHnX9crKQldmlM4rt5Lm8ev/asysI6E/9KHq5TS4pDscYd11bC9j1i87y/GzXeN2jiFg6vXLA3fmRZJ6M7pfA++Ey9ll54ZWbS1ACuZMRwFO01+vY24lBQDk19RY1Y/ha0qlUYh37ZCWplpKv6FU25CGtnQ==;5:Cz5Y4dXF/dYszrqLNWHPL9KJzX0oOIYhMgexryvALdI66obvRqwX8bseHmnosLtSr5qTpwcJPNnZvZf1XdnW3tYXPm9SyYK3ghTlyz7192eg+/N25BRz/s+QbrblZqLXxXVpJpT/dnsXLMmDNuLpZ79Jy33ysveUeiZWCOTSa28=;7:AsyznVvcqC34oIP3abXiuLAuU2+Url+EGL1mJ6eDK1vqiOgt1tNt7IY4t5BdDhIWgqfNa6CviYOzO6Qp5IRhKOpQh3f18sEyqozGdIytnyDgOH1bgaZ62NOgKtaHo61iwqDLPbFQzDmknKlgS/J/XQi8Ucosw3dHQwZ6SBMT22gsZjfd0IQ0dyAA17iXkiBxZf+woDr7R8vS6XkhiFtlm02vxD0BOMpMZ338BvUnrW4vZWyEd+sOgppYm2zQH3hj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 08:14:18.5692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e9e948-e200-42f3-c6dd-08d60f19c0f2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the loop of mvneta_tx_done_gbe(), we call the smp_processor_id()
each time, move the call out of the loop to optimize the code a bit.

Before the patch, the loop looks like(under arm64):

        ldr     x1, [x29,#120]
        ...
        ldr     w24, [x1,#36]
        ...
        bl      0 <_raw_spin_lock>
        str     w24, [x27,#132]
        ...

After the patch, the loop looks like(under arm64):

        ...
        bl      0 <_raw_spin_lock>
        str     w23, [x28,#132]
        ...
where w23 is loaded so be ready before the loop.

=46rom another side, mvneta_tx_done_gbe() is called from mvneta_poll()
which is in non-preemptible context, so it's safe to call the
smp_processor_id() function once.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/m=
arvell/mvneta.c
index bcd20ebb2ebd..fe3edb3c2bf4 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2507,12 +2507,13 @@ static void mvneta_tx_done_gbe(struct mvneta_port *=
pp, u32 cause_tx_done)
 {
 	struct mvneta_tx_queue *txq;
 	struct netdev_queue *nq;
+	int cpu =3D smp_processor_id();
=20
 	while (cause_tx_done) {
 		txq =3D mvneta_tx_done_policy(pp, cause_tx_done);
=20
 		nq =3D netdev_get_tx_queue(pp->dev, txq->id);
-		__netif_tx_lock(nq, smp_processor_id());
+		__netif_tx_lock(nq, cpu);
=20
 		if (txq->count)
 			mvneta_txq_done(pp, txq);
--=20
2.18.0

