Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3202DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A912083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="f61zT7FS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A912083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeHaMSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:18:37 -0400
Received: from mail-eopbgr700083.outbound.protection.outlook.com ([40.107.70.83]:11440
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727459AbeHaMSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NzGt4NielWXWd5bk/EEev7uGYmuohMoKTtjY10MSxQ=;
 b=f61zT7FSuO6hGeUISd0tYZDm8ythcYaplw+Ok4wSIefZDUHQ6dGGxirYt1OTuH76ipalMcKpKUSdJbIEqROR9KfViHWvWJxmwPi7xEPpTWuRzjbv/tPd2T38Vmk81gMy1X8Cuv0XhASL2y7XROcTxomAvw1k9jRzjdoxsQqsPK8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1580.namprd03.prod.outlook.com (2a01:111:e400:529c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 31 Aug
 2018 08:12:17 +0000
Date:   Fri, 31 Aug 2018 16:09:13 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: mvneta: Don't check NETIF_F_GRO
 ourself
Message-ID: <20180831160913.325ee36b@xhacker.debian>
In-Reply-To: <20180831160810.2539ef4c@xhacker.debian>
References: <20180831160810.2539ef4c@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:404:42::23) To CY1PR0301MB1580.namprd03.prod.outlook.com
 (2a01:111:e400:529c::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53a29e48-eedb-4f14-79aa-08d60f197886
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1580;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1580;3:d0FiqA338xdkAvV70jqweho0pHy799siWYIffShpQPHb9qVA7ESmgJNFS0YDGpjrRVSetbWot3qtRVo0ejvwHmG7gBAxxpN5JEG4T5wTi6DwHu8tflPnoE1XeGoLrBXjflIognlTgQMRFMTX2F1Ffa/ewWO8jRnrYSCSoslypO0rMo74EtuGldG/jILENqEOIV4e5Sl/onsm46b6vgOEkO/femX9BkMdUfWq/ZFT3DgvEjeyCFdRr7Rc1X51WoTY;25:35QzpxJa2FlbHOPoNq0EYOmYkVjt9iGe4+LsCrRexPDkwr71NvTOx8fjroZonliqadZZdZwFeXzMcOkadx5I91EUdTQftVe4y1UZ7/UXSLfoRHlvRc/enXP3tMHn5IJarr7/d5RIKVA2Ql2yg9UDtQg7hTBKbbcWirW8KdIht2DyvKYifyxg6oxv7fCmTl1q8R8eitLtX9wJB84qeXo7KMVi0XnQ9mKNg/NDzrjllbNJj0ouc0UoIDKky9VoRIfRQZsVcOkoEWTuX34xdqYxnC4WCpCheln2Be8fgoWHsK+YE0uHr/R7qAIs/2xCmAqPIMvU4Dti9vaCx6CkgoIh3A==;31:ioIHgXjfOUYGZyA7WQqLLDXs3N7Px6O9KRTq4UUHakWBEz4xSf7kTMjJTghz2V/lIw/LbThGSP70aVBDdyChtmtdykPnv2qBv5qZCiXxOofHAXP8tZ68jr0dtR9WJOXy7fFP/yDTH8x5CLrmUXN9KtTydL2v/LDlawUrJbEkuKr15aX53a+x1vRKhutY0QVLvy4CVfu8oU1pgJKusJ7jc513B4TptTfEWwIEEC3VRxI=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1580:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1580;20:APzJ6VRztocUe9LLP6aJ3sekrfcZLU/0kO4C47lAGCYOD9HvZ0c03e81a8PAqsHe0R+HHaiH9LHJOPsaGch2lrPzEUMbsR5FoRoB2gIWdXXK4Wz4Oq38xCrRwk7ZNno0r8pYudcVr5UpUKy+wa+ylKIr796KF8JKC4XyASV1CSljEf0L0kuqBtR1eRX1C8IA9fFn2TqX7hOr4tfZGv8W1bO4m4uZS9Ri8p8JLLIGzxAAkGzaDuC5KL4sbDtBWSNVYN8P7auxzfcXmW+bjRz1Uf/6D66s93jlBma6vZdirxfnMT76yfEqxA6H9uKsRRirUvIjQ64/hZSOFCB2PS4gzpWdYG6a8dY6+XmwHZd7fdm6XOBUqiVbh7wuqVVkqZbYmOmg36a5gkdL9RON7yLocv+gUMlLDhjI01VC4faTr5IQ7R62AXkeujctgZDldPXsKO4XtE9cOME6gQguCzLMLrE9jFZ5ZkghBuwmGlqRclCURNbWTG0XG6DNjnwe1+o9;4:CsofGURmWiRFaDyYFzsY5QNyn14XDhsnHQZ+nRmsEOAYNGlh+c/qsnd8k8igrG/vl0o9WZlWEvxWBGNtqKl5BQQWCfL3okg4m2V0lar7WQ3NHO/ms0biLz9nrV2IHSbIu650eoDCEj+b0w2oO4T/Sg0MsYKcgsFkwgVVzgaTpRLHAiSao89FvbZwuHw3iZjVtTAH2Q/S/ZqO8T7zCBFSE+noi2z2n1Yh9uaUjGBOTrKvqSLIFk5A7MOFFdwulDTrN75IlTw1+nXZIha/WUn2YQ==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB15805FFC18B317905305040CED0F0@CY1PR0301MB1580.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:CY1PR0301MB1580;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1580;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(11346002)(8676002)(106356001)(105586002)(956004)(446003)(476003)(25786009)(2906002)(26005)(4326008)(305945005)(97736004)(186003)(68736007)(6506007)(50226002)(16526019)(386003)(8936002)(7736002)(7696005)(52116002)(76176011)(66066001)(33896004)(110136005)(1076002)(316002)(47776003)(72206003)(50466002)(478600001)(230700001)(5660300001)(6666003)(486006)(81166006)(81156014)(9686003)(23726003)(55016002)(86362001)(3846002)(6116002)(53936002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1580;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1580;23:DQm/37xw6ecjk5BlH9G77IA6ZNeBtTnuNe8fxZJ?=
 =?us-ascii?Q?Y6YaJbuZ8xS5ZqZdehJIO3oDa3qmycpMz5yC4bc+OiHiO6Y74E1FWBVEgvUg?=
 =?us-ascii?Q?q7c1M20rG3W/S6W85TWWCq0xENrQ0bTCx/vUfjr2uPCrviGCtKeExzZ9QMq/?=
 =?us-ascii?Q?cF3DQ9fHqm4HM/W9j2O53rsEoG1VdN1zDjumWK1xTZ6Snk13xc7At/2A3QBb?=
 =?us-ascii?Q?KXm3Qh7sOgPUUBFz1kOz70cvYtwMb3KVGu7SRpO5NfdIiUfwGf/4EoCj+1xQ?=
 =?us-ascii?Q?YlUjdTeAfuZ9C4fg5A7AXVIaZbjErMNQpK9YrqKkNXSsiV6xYolLxXT5FT29?=
 =?us-ascii?Q?bGcY34vKbZMGSfPcPI1h5/vb0ULnMsVUrhMv21Bzjg9ZIgI3t3xBSUe7jpMh?=
 =?us-ascii?Q?vzu0bMN4xNFWToP5DyuF0B6EfAcIpCZCPrmwPIse4ENOJiKkXJlBX/VwFI6C?=
 =?us-ascii?Q?OXG2ntfT8AG3TcvfYVLx1gXHVnwgvrJUz+kV1nGIXlWWI6FoWBfbdkCyLGZr?=
 =?us-ascii?Q?3a+tlS1WkgzCOPWQNe10vs0wfpjWgPSRMX8Qqe+IuliDtKGds1lnLXI6PFrk?=
 =?us-ascii?Q?aFiCMcwnX6YzScJ1GLzP3hCkZC0mDq7Cdc/JJrqvu26wLrQqghqMgJDHxZqg?=
 =?us-ascii?Q?m8OmSQfh6nkKf+fsSSlDUMW3PC20tJqKHgzxX7jdzQm1vQPuCkiKvc+ihDbh?=
 =?us-ascii?Q?dM+bBUUMozSLLkdMkDlZeA018BEMUAlDExXtcTHOV2/9BH65faAkI+26T9Mt?=
 =?us-ascii?Q?deqGwdQXoT+WpaZaMDc+2B5wox/kz1bHl9pC/Biy8pwlqqlJTiRZBrccB6DR?=
 =?us-ascii?Q?aCfK0o1D7aqfcCVw5CejGomzetWnWzFrYSoGPENmkB8ym2X4xGnpONdPa6Q+?=
 =?us-ascii?Q?x//20G6zqA75SXs7k9oaTxVZR0kNlol8HmmnX8bfM7wqIkj6Lhwz8sarLhOm?=
 =?us-ascii?Q?cZ6tHW5QK1mvWlhDFnZbkiFb5x3iqX9Sx7kEPN/r4bRHBNQeQzkVLO6fhHKL?=
 =?us-ascii?Q?w1uO3l2FNfgWFxuOwk66n6BtPKvariIVsmRgh/O2mIh1ZgDifRWhBl/6r439?=
 =?us-ascii?Q?65j/deLmk1uGBT18ysxxk3XFot0Wv8WLCLAmB75I0NQD+n9bMIGPSQJ4cxCU?=
 =?us-ascii?Q?05kOwOGpInXlulTwdpwRiVX/YhkpcsVXETJ62KmWovBV0NCSglFWcSyYdyo2?=
 =?us-ascii?Q?yksTKXuTqVnaZSwcp1FCKYNcoHPsPFmfRkGEE4SJcnpzOl+FEyPzPz1KkEA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: Zr2/vKvDM4rdxLSJMHxChjj2m1UAcpPvNRvcYnnq0p6AwyG8MOwYbavZKDwqEP/rLxg5S7RDt30GZeJ3rXHQRp8fFbUlBTS+8V4zG/NKx3afpZBZ0rVVr7AprVGbpXkjNSwfKFuLfYEjuX3jAUnsHuKWQo6arKJJCw3kODwFNnt3+028ZRmPyHtpqq5ej+kEDeNdy7t+nKwSlne9qC1Xcg4dzn461fdN8Jljn/OM/iELS4NGiLzzX0cd9nxhNbvwyoFJFj2xf2Oh6cR+tLwjmeu5xLkfhDinuHrw9rVNz1EQhnbw3uWSvLlSz3jnN+Ev7gV4mrl6egLZTfqFeNM8rto4POHHj4LRsEkJ76ridGw=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1580;6:D2oFU/1W+7WtEwCb6DZthwRpYGK289J8Ieg0OC15Kbz7WBY1nLGC5SZx685vM1oRa6QBgJjXPkqSCAk1h4lidqMuaZRvBnSnx+l2kq7Ws7tufQZCuTjuagtheqzoBHmYY66bHcHLN1QwPGPCsCM4Ahw5k8Jxu1DpgEiIcY+yKRfeRL3J8ox2sOn/xFj+3M2i7fnFhC17oE2oTAYTUSL8A4/lx6aFdAaAl0D+L5BplU2L3Pl9ff9CzfqeSoz7T491IZTKqCTTbSopPYCf3abu0pKsP0WBIgWtzMfxoo32oK9UBMhVedX8B3smcL6xJkC7ReHzj2j2abW2xkPoX+i8dn+z3MiMBdusOlh3v3ERm3iNP0iqDfLh+JChCpBrdf9vegUmc0F8sg/7QEVRpZ/lnlqKaLpiBUQ4mDohBe04gf+Kck+ef6GqEJhL/sPV4Rq80q4Fn40MzZ6v1ZoO7+bYuQ==;5:QMn+onaAS0ugz2M35Dh9imm1SNd5iw34jN7lwR5pJP30lPJsoibdEAgDht+FFZBhszT0Of6tXUI+cvui7FaR9/8vH8xh/9rrHatBeMHlBAt9WjBdrW3iFpG2pdJN7lS9KDfPwKR9EEjak8DQQsaE1ZOqlORiyw5DFw4hmHQ+q7k=;7:w4R40LhYfo4kUbRVLJBVzoAAdJVPHUNLd8zc27GeoAOijH6IwVscv7dY6DCMFHeHFmKEw3L7uoZjY2YRuFnYVyE0c8KzgucB1n3MxLGv/0LeMojm7Nh0RKiNMOsJWKgZBAoivAAPjmuJNdsE5fTcJQ9u3/37a7fKHG5UYumSCaXfHqqGgysGRNGCGkOjGGnpqBGWUsGrXK4sDXHbgsD3b8hYJpZ09KlUsUmA0XlsVZthDFCoUjOMPMnuLBAOn5f/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 08:12:17.1236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a29e48-eedb-4f14-79aa-08d60f197886
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

napi_gro_receive() checks NETIF_F_GRO bit as well, if the bit is not
set, we will go through GRO_NORMAL in napi_skb_finish(), so fall back
to netif_receive_skb_internal(), so we don't need to check NETIF_F_GRO
ourself.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index bc80a678abc3..814aee92a1d3 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2065,10 +2065,7 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 		/* Linux processing */
 		rxq->skb->protocol = eth_type_trans(rxq->skb, dev);
 
-		if (dev->features & NETIF_F_GRO)
-			napi_gro_receive(napi, rxq->skb);
-		else
-			netif_receive_skb(rxq->skb);
+		napi_gro_receive(napi, rxq->skb);
 
 		/* clean uncomplete skb pointer in queue */
 		rxq->skb = NULL;
-- 
2.18.0

