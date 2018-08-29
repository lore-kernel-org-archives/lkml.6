Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B1CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC342086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="nuSZWYmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC342086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeH2M3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:29:19 -0400
Received: from mail-eopbgr720041.outbound.protection.outlook.com ([40.107.72.41]:13100
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727133AbeH2M3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssSYEkoUjeRD2907CRxsnGJWrPIgq8vvZI3n7lRvDkk=;
 b=nuSZWYmU7xerEJTMJbjWqIapm4Zc5NDd+Pg5AeY84pcMrV/izrnxOAyOOMcPai4tO39CCW7GKNiPOxMhRWTDg3LGVAIdW9vI9/2Jy3yE7wDd8Su5Ahf9mXCmnTsq0DXXXA+v951sv6/IZLQK+IIp1JST1fo5XPtXWwui71y2NhA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1571.namprd03.prod.outlook.com (2a01:111:e400:52a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Wed, 29 Aug
 2018 08:33:26 +0000
Date:   Wed, 29 Aug 2018 16:30:21 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] net: mvneta: reduce smp_processor_id() calling in
 mvneta_tx_done_gbe
Message-ID: <20180829163021.70ce99ab@xhacker.debian>
In-Reply-To: <20180829162456.2bd69796@xhacker.debian>
References: <20180829162456.2bd69796@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:404:15::16) To BLUPR0301MB1571.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c07545e-34ab-4c17-3c45-08d60d8a18db
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1571;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;3:JALAq0nJFJmsx+XnA+bRySjdqSm9wFBJowbf7koxHe+R5XQbhxPR+cHNGcOtpZe6RyYdkkrvgNHiaOIihOuW3yDWJBzivGc0CwTcgL0aISwc10PuW+ydcKm1sTJMzAgtJFQgWlwTpXpD0/4CFCobvYuY6E2axc22+eqDwzChtrULECF3hx7svD7JGgQze+XunS7hWANoKCnOJZGvpj+TrxDWdne1QwaqnV2cxMSTJvhZ2JdqnVV+GkHWbNMahlcR;25:MKzkG86o01JVckeRJ7Oo94+5t08S3m2JAsg8IuZTvR73ns77uH2luSg7+nkBBV5AlOu6rcyI+XmX/b6U3mKikdnMEPRIq9ziPm1JtRfh5c4IicuZNond+j2W08fo00YikgnyIWuzf6X7iD39FcM+8GtDR9OUHOJ6+ReqmqAL5Ul02WOH42deHbeeuzqeuVQ4l9MuG+ZHZgnURw6X5iaaAsFhhz+da2P0CxZ/MFCJ18RD4CT0bASwn53tEZ89zTqnqJuf9XGylvlrBNebuwwUJ2nJ+PQkgfUSJ/CbuWcYGRxPNpPMy/dEOIrD2juAD7E5FlimciwN2tlLoaSx4eBkfg==;31:M59CLYmHouYEba1AlE9fYyYtvDT5Wyc1ohXdHMIamJpyK8KQtyjMHPHFg5HeqRCc1gelU1xT0+tzPOh6WAL+6odjf/2xCS7+RhUA/+WAtjQnTLY6WydM3Ap/vm98+QuP0ZeQe4wB1MR4UGc5pBBodfy3+rU7XvXjuDgnF5yxJZFI80+0iGC3Q2ndkHKh/PA0vosl5xDnUi8xqouDl+oFtSokWaH/Zl5UWQ+ebQcpdBA=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1571:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;20:bwAIowpOcWiNUVZVJV8FAbbvgBBDgS4tzrp1StIl0KIkSfBLxwAUZCYGtvfSBOOjjBW9JzQ9857o7xJwlLoUhl2Jq4ZwPa+5IASnGluJxTMowVpia2j5KXrwx+nAMiVxzOIebYLXSJljT+7BfGNGET17eSCf3qVtpdySdzdyqWLLVSHQ2AqlHcz5JPZ/rd/N/HhKwopZZhwkD4jIb+mrqCyH19bp7Rsw3VDOeaxgM/9qx9s/T/+rQa7ldogGk3/AuX3XM+s0bkFYfSWvXDIpmJ0TrdVF7DDgYwZq02j15EvSszGdIfLOMkEdJYJDWmK+nuZ6p9dcab3flaKZT3ZZQD/zrdrHqhszS8WB9wEkIGlF0+9s0rcCIrmvCTR5M7j8YR4YHI7j3v/exK+Km8sNlIhYr6qo+bFReC30DDJrGQ0Ysh5OemUunHCX7C6v3Qn1L3u/dvI9wnsufHO/y/JMpYCT13tTDh/AYUO2m2URe+yF/vy7de7hp9p+oAEm3J7e;4:TOZFexnI+z2Q2yhNlQtfnAcigjfK8GO0XkWSPKYJsWPi+n3acwN/t8j148s+d2ofmqLTG4+JXYQUwFiY0JptbqFym45OgJ9gVWdM+F2QnA3olGeCtTGWV7qIXtRg2mVn7HD/vviHoLCELijFflYKeTY9qiUWdfrnxqM+FZW+ywCDu6qpsgWfJTmvSydnGtZGsS2IbWJV9jyZ9CZmxJV9vc1zTjVApQIomU1jpiCow9snf5onGw0cK0MzxADLvUmW4iGJ8LzvdPNHDTTIkSBBNQ==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB15716ACE0A8A41CF3029AFDEED090@BLUPR0301MB1571.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:BLUPR0301MB1571;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1571;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(8676002)(55016002)(105586002)(68736007)(106356001)(14444005)(305945005)(7736002)(72206003)(4326008)(25786009)(478600001)(2906002)(9686003)(33896004)(97736004)(52116002)(7696005)(76176011)(1076002)(110136005)(54906003)(53936002)(316002)(23726003)(86362001)(6506007)(386003)(476003)(3846002)(6116002)(8936002)(47776003)(8746002)(66066001)(26005)(486006)(81166006)(81156014)(186003)(446003)(16526019)(956004)(6666003)(50226002)(5660300001)(50466002)(11346002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1571;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1571;23:cQWMSq4no38gIjrAqwu54nRit40reQ2TkPAtbtd?=
 =?us-ascii?Q?kt1gRxWm1lRD6Fn7PV7occudCB/tIvnwmmoc74rTHxr/qpPk5q1STWKD2B8H?=
 =?us-ascii?Q?t7jgvpLvDQBrfdZpan4HqLaHo5W3IzrbjLfdRexCX65UlBPUFj75FbpOUvTn?=
 =?us-ascii?Q?MUF7h9TFWeZJ+fXK0Qj5pCi1UDD2iZ1iPHXvfD6VDCb0UfkJiT//Ge1biLhh?=
 =?us-ascii?Q?gY5ikKZHUvI+OEqq8r+2P+yV8IRnQF0PbXfFa1mIc0tquA1VMQxcVDPiClZq?=
 =?us-ascii?Q?YlGTVMBYLq9tpC4zLPKe+Sfo+J5RqSsh+yWYMwISE2ViMfpEb46nrbT50yyc?=
 =?us-ascii?Q?YxynE/GKZ/fBVCf592cNCDi+tFcON7JwMcqBcdJSO4cKv/IbfMbv6lfzjspV?=
 =?us-ascii?Q?2OeEOQpUVp3iOZbtAibKRR1Q9o1RRwWPSONrw8kKIczoUW7qOml2mWr5nptZ?=
 =?us-ascii?Q?/X9/9ajckjWjYT2BPzAbgfrErwtKu7iD8h2lkjPVTZcQfHKhGaLgcQBZQSFl?=
 =?us-ascii?Q?TCU7e6o6pJq61SVNZSSEDwyGW9YtrdRoD791gliH3DsMJP1ec2rUGXALVkrs?=
 =?us-ascii?Q?72U+7dwgPu2LvktrMl+QXUmX6HCwGa15AkMQexPFokQwiOiTftcSMUKL6axt?=
 =?us-ascii?Q?fUnH5gk7HPNjpEgBiK+6RV9Cafn4UUORXAOhMx1YnTEPsEERk9ZaNPNeRSLK?=
 =?us-ascii?Q?dvrgQPxTm4TvCNR2tJ++z6bKEes8mCkUd6ZYbZojLoXta0sSwDIRfLWbCb90?=
 =?us-ascii?Q?a2LvfyUay6N7WJ8gtw8/W4JXWJxjQLLUqZHSn2iC/5OYcYD7ejLD3z6IQz+a?=
 =?us-ascii?Q?6SXmHwG1JkBYB7jD680pyRHBWRmGJSaUqDZ6vne+f4KcmPabAIvbK+ldrGoe?=
 =?us-ascii?Q?MHyHCuNXeQB/QZodkovRfuUMySICMDSTAI+iNvlseco46Ar5TV5a3HuYyyPj?=
 =?us-ascii?Q?JOSUyctYL2pRfQ1zIjMFAR73kYz/XGPoD0TXyRBzO5Y0oDBesnqHk8UGiNhV?=
 =?us-ascii?Q?ESiDabuLLxMbQaYIipA+zvuhMVAYQhLu7RnA/lBVj01JPpTzqaDFZ6CGeJCO?=
 =?us-ascii?Q?WSxaAmL1M8td+NN+N6BD7J9PPWaCcbqWUgkJi0Gnd5FofRCqoPsEgvZngmLd?=
 =?us-ascii?Q?dCskEVCjIqiwZbZ3l1zK8PO/DlNxyvnVf4M3AXYNEG2QQXovF4gB4MPcFdKz?=
 =?us-ascii?Q?gZAz0RuJdBFGICdSWuswgMJnxRFCSnELl8NiKZsJe4fbzjD0geKhfHJa1Z08?=
 =?us-ascii?Q?LSaFZAvERcUb6KtHIOkM=3D?=
X-Microsoft-Antispam-Message-Info: sYIKzO2x3kzRqtZGTU1EQjwy7hmyxzhSuPpiisrQpuNZLX+2TsbPss9jmA5LqrWp+kxXJwaKiTMmoJhO8BWupDKITdLIX1E6uTS6xXuj+2nr7Ry2m06agmCKmFHwxiMtB9mL1JvbcPWsuW3qw+nPN53GVAsUpcbXDHANaMPAArE0G2Zgy5Ab5jrpIfBXErcX2eXTNkiiWCp7T42BtOSiM0ign2dRE84hK/z4dFMKth3CIYPG1UJwBaOSzRadjBBZBtuV45mD5N9JtaWVA5Z3ukULqfRIPg6UmlaV397dLi8mxkYaG1T9szFKE9/qH3FJaSKiubX48kiRJo2AdKcMbbGyylnu0QDbpjAA0BeiN7o=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;6:vg29SGYJctr0UIf+zINMBMZhqt632KQji234vYhMIBfv17B/6AXU99OFeG8WHXmuMOPhAq+yIj2h15qH/SMgppibMjgKnIYHrE5SH/xt40GA6l0ZyXwqFVltDdqySdOOa9pE4z1nJgA7x5WbFQwVAzDmFEUxH2uX69NtzEXBY75WGPdqpD0rTSoxhaSZY4l7NdfXN1Ej+nOot9kF/ydwgzvrYXUu87+Iu0sFe9xyLeDanp8srJnwN7BrBivEwUFhHvt9Skp/ADxi4N6GqZFTRoijC8OE3dur5d26CiJZNjnPVoBp7QszsH8wWvqUH2fGJYhjTOXTPJ7emNfZ+W684uLG5tLH+WcKk6AHrDHiropRtUIyjZme5i6S4sAX5wQpPnGqVUp0Pso1TewH0OGwXUs6bxd83FttQlcGBcAfAkdPc5oDFLixgO9m1k4rIVTgDuEG4DTcDIJnEBLXC6pdUA==;5:980CC0cHHGJQverQ6kpbqKqT5v66YJI/XXTPcZX+koPDuvbG5PfVeFT/axmZk2HG47hqa3xO3tDIPRFnaZ0Og3myuxuKaXuR28JsCH3TswnaLIbelwwVbD/AhWCO+2EMwmXRTgoLJbEblV4fyYXAYWKzE76ihdJKvMVJxkRVioo=;7:PaWb3tum8ocHyVuE6qTM+sPuL+XtG5KgvGXWNQBgSuX9z3756qa9stHXJdL+K/5UD6NGDMoGViTwexsMbB50f3q694q796o2Hv42WLwWdHPXBQqrDvvZyK9bcu9jApI3GgAyU6bECB1AWHNaV+2vFflx7FDIgy6IL+MOp4I1zTXjoGny9VyoStGi3XWXpDtrjig+rOAg/RAFon04AFoB4XVefEN4TPVYhWKGNeWjRzaQnrXi3PdEDEKWUYSBNs3m
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 08:33:26.4734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c07545e-34ab-4c17-3c45-08d60d8a18db
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1571
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
---
 drivers/net/ethernet/marvell/mvneta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/m=
arvell/mvneta.c
index 7d98f7828a30..62e81e267e13 100644
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

