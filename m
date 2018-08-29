Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53475C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95BA206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="r1JwVCdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95BA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeH2M21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:28:27 -0400
Received: from mail-bl2nam02on0065.outbound.protection.outlook.com ([104.47.38.65]:61516
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727322AbeH2M20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ft7aLMdRhYL5fuIisx95uV5SmA1LSvSM7BuaglmHdcY=;
 b=r1JwVCdwKVBCleXcVql2CX395t29UNWGsH+b4UPg5WDflZuoznwIrW6Rc54T2jzTwWkOdRIyQ5wmZI0q6Sd8qrI1y2ZdYGLjuqXFVS6KDG2tvY/mLlBpgidxBJ4frkHCt2zlAAGjrP07uIAy25ex926YqJao26Dlorh0g+HhZLU=
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1582.namprd03.prod.outlook.com (2a01:111:e400:5232::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.13; Wed, 29 Aug
 2018 08:32:34 +0000
Date:   Wed, 29 Aug 2018 16:29:32 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] net: mvneta: enable NETIF_F_RXCSUM by default
Message-ID: <20180829162932.6015e89d@xhacker.debian>
In-Reply-To: <20180829162456.2bd69796@xhacker.debian>
References: <20180829162456.2bd69796@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:404:15::25) To SN1PR0301MB1582.namprd03.prod.outlook.com
 (2a01:111:e400:5232::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f53564b5-e479-4862-1cbf-08d60d89f90b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1582;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;3:yBoxctC164cMeRfLKeSWVdo94sNc4BVyZgHxeRTlqalDhzbMJ0Gr3FHVszPuEwJywQ6gw/+N3ycARpqR2dkFeqqmdz8+raOKq5J7SjJAARkDPepc53TGo4iXQQll+wWD+THRu6lzI1kN+85HiTyVNk4Y9yOxVGfUiei/ARA2Ce8LP+k5wilwJt2po+JnpZsB1rv/KUCU+96el0yVkKmEsOvhYX2Lvx2V3K1vdZd8y9MovqVMGliS+n25eaAFOLrL;25:d70ig/i2qx6NqvuDvmsjzVc16pU2KlbjtIEVJ3K/w+h8c8DB1uOKrJR+L+1WfNT9sZW98tVjth7JJ55jJGU0SP030ducujL2mmA0cjrLkqlYP1x1F3emYrXYXJG7axlV6ney6+04fsnpfQlsgVB7N3w2jesgbojFPreXFcKAascWIpbSWZ5gKBS8Kl+6tMI+pWVUinJd5fFD63DXO8MSNVpJ1QQ0NaMAFbk/s2rwXhWcpn4Q/CEcbxxJaEtviH2knDZIoSLsAxVAYZcFurlRUDCa867zOdB1ezVLL8/iw0HEe04e92klm9IjBMN0YqtXvTxdoZ4+ds9GJY97QoegAg==;31:546s1rVXGxwElJkqi7vHKsf8ONYlRD3rG+kQRPeKd3ISh1V6M3YbZ8UPTdARTeaKEUJWzPy4DmIET3hQlf839i0VxnV7ByKrJl6MTsvq1uPW0Wk61CKPwkpfynoRRMEmczQKlvQO7UgQ1dbQgTTudfpBwPBXm5vLiPz2b0OP9LoSkKgXsicxfPMImzR0cAMyGTriD/kGlNMWB8AekeMKl7lH5A2BpcxV9dwQpz9DYKE=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1582:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;20:+sMBPJdgl5V2wMiQrFCsOapJmuGIcLnfoDOVdTmdecScQZH+tSY2j1u51ARhHEOH9Fu8M4ryxFAvmlMj6HiVKCPlhPLwGylR4HnSNOWYSHi/2h7pXYOlzEUN92gSV78vEtyiOAoF4lNLQWbwwcWo8c0Xa+/1NGTAGBzqilnEHjYwHmgFwMgBZ63Qgb5wEK3CDtG+9xtjDwCvhotXxyT5aXsYkhh/GXzdiPF4K7yMfM4ukwBtp6C2sizIAckeTMvWPg3OLa3PL+qE1EjmGbCmhvWP3BFJ/zgKkwbIQZLFC24JRvzCYO1lfMCVb2hUs4BkDipFEU1l1gyRkgvQbS5ksshoi3GElAaRK7y6/bYuCse+YerYcOv9W1i1/S1HjngQWOaDH7eUZzuZMI0JhpmSCNAuNjfA2hw2ZyduAwx6HRg6sDWL4lm6tGT1z858SCyJom46FzbpK1KdfslmrwXz6ww3reIb8M9haEkzsG5nAw/pCosKNcBpeInqTO5P4XDk;4:PT+D8hThSpCu+yNSY5+1cQZ+ajS4CSbYGRQCQIrTV7oeKUK0vRixnZW4OAJgjNLOVsBa0BmWwrfrihU19R+hThQI/XIyVUKw4rSkES6VTPK6aRB9NUTMhX8Tuu7XW8/sctM5eNry4zkaEpdTi3L6Fqjkxbc3hrTCjv3uOMFjUuN6z6P966ohWTGIgZ/43N8C41WFo66oAr4vkqfp6NpgiYpbfZiacZQ3WslGGR1VjHgj8Y0TU7et34X4rOxNfdb2F6lpP7I+rYbrjdRqIJ/+FA==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB15824984A1B5554681EE966EED090@SN1PR0301MB1582.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:SN1PR0301MB1582;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1582;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(7696005)(76176011)(230700001)(72206003)(68736007)(956004)(446003)(478600001)(2906002)(5660300001)(11346002)(110136005)(23726003)(54906003)(316002)(1076002)(50466002)(476003)(9686003)(3846002)(55016002)(6116002)(33896004)(25786009)(386003)(16526019)(50226002)(14444005)(106356001)(186003)(7736002)(486006)(52116002)(97736004)(26005)(4326008)(105586002)(8936002)(53936002)(66066001)(6506007)(81166006)(47776003)(86362001)(81156014)(305945005)(8676002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1582;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1582;23:wVxlmBmK6fz73ftE5MJDonNSslaAGLSH3w21ntq?=
 =?us-ascii?Q?wRe5rYfQ9hP/aZp4Y1U89vtNU9pQYH67wvujel61+En8OSUiE8cF/xKtnJeP?=
 =?us-ascii?Q?3P5VCYoQb0Yi3VjtRLkBVAKzzHcfUxonViMk7eGZfvNC/33xekW0Dm7X8+Ks?=
 =?us-ascii?Q?N/GKbPsRWHPC6WOQmyRdKoKDsgfh5TlzU9lZ7cHRtHqP5uF1lMSOzPoFIXFA?=
 =?us-ascii?Q?/a4hcZb1HWIt1+/teh+Q6a+WrXTib1Y2puI36QvLAKkXkT0y2GxtbH9JYhrx?=
 =?us-ascii?Q?KAhkM9QfBz7fMledLv0nzxrX0VoTIdZMaJ8zEk9a/t2j3NVDk5/2c026OMTr?=
 =?us-ascii?Q?XSWF6SvBul6LHj5/CZl9zqnGG7pq0Vthrf+tRwKK6sOGdUOMhdrKlPqIhGjo?=
 =?us-ascii?Q?kFNXqc2mUSpFUIUyxAKflm1Fd6IVxIt1BOO63Dt/XOmdVvB0iqEqI4Ixx7nc?=
 =?us-ascii?Q?N/OOe1B9WC4hRdRglgEXYnMpED2PK+hvmPZcpSXsp17bh9QOccAymeMPFiwS?=
 =?us-ascii?Q?rwl5IdCfQviYT4xC7ZgdBkge6BY6MnllnHiQXrMh7UIZ6johHw3+65R9pf1C?=
 =?us-ascii?Q?XXCEB9mdNejeCtPtnpsWhxA5UiCVa3nHYhmzeYQlprELCzXehefCFydm42Ej?=
 =?us-ascii?Q?h78yA/05QDIKUxCV9Cc28EwCGy/AT4Az0Zm88sWluiytY9TmITw0mtdJ4YgO?=
 =?us-ascii?Q?fZsd8Xol0ki46E8F1G4BbIi8V44hoBDvHf5pSH1KWnUzkqcGzZupTeQZxp/b?=
 =?us-ascii?Q?hyw9VTl7VzVtbCzMWfSfV74L5fXQnUpR4m285sOwVBV/og2ZzdKaN/ik1d/i?=
 =?us-ascii?Q?hFnt47XtaVD+kxEZAmwiG9bbpDmYikJPS1Pb+7kfspQADxZfn7pEhOiOnrLO?=
 =?us-ascii?Q?zkkH7feOUU8rHs4AAOx5oLDVoqJ7B1eBkxwo6RgWC4VU9g9HsYdFZxD3J3p8?=
 =?us-ascii?Q?Z8DilaGg/g7gpu0ttsf0DqOwG0zs5H/tSjRRSLGngTIor9BT60Uom5bdpCGh?=
 =?us-ascii?Q?y4wbWR0tqzLRymkNuxqpV2OF6XHzIclTOc6Kc2FzGsQ5TfhlRBTvoFixAPwi?=
 =?us-ascii?Q?ipcf4vqwZSRQvJ5wPUXMt36F5Oj+Ujj6UM8TXVCtgk+560rE6WBCvytOyK5C?=
 =?us-ascii?Q?sghFlHyHOBEgpSbuvDhtMqvFSRQM5po8BRwvuGRpzaPFdAM7rXpuSQvQrJei?=
 =?us-ascii?Q?VNOehKTfr7vuVJ3wrXeN9XSeG7GpYIBodGXxjc48y6V7bjyUoWnqe3g0D4oN?=
 =?us-ascii?Q?OfmBUy8yoMXzluwiTdZY=3D?=
X-Microsoft-Antispam-Message-Info: yThMBBXDBqNnyhxfaRpO7sVAPvLxEJV9vb47vaYWxhZfwhYi2cOigzfX0W/iC+W/bhsk9PH2/ulS09+OKDa/qmwX203ThTdV+1vLduGEOohUo9+fByy+R4Wpk4QNrfqiV7T6pYIldPmhUmsMXpBVYZUO5KsbQdsw5EqGvoJfXYWlx5V5ZAB53e/Kb47wxGrnu0YtTNA9drN+l0I75pZzQ6T33w+ymdtsrVEn/sSzsyEtnAIFCxHVHd4F0v7o97ZZF/nHLZ03OpR+3r3iyE2XgK+OveWWL4h1rO1AOZCwl/ta0kcdoMyzHKzZkktdnEn1j4RoLShAA6KNSGgj0dQGM5pfwUo1yHoyHHxEBB7zkxc=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;6:ElNpdPfLlmF+w16xtkDmr3qk++zuXfz8fqF5WuZMlVW0bV8sCoQfM7TN9xHxzTT9mC3RUkCCMBYzkaLhRsGuzEsN8gSAO6gV1ZTllgMfUxkpc6blBuV35kWV23ckZfpuHYvjyB0kHK1TyaRyfC8Hkc4OznPDUyRcfEHZgaNpJGL/Oz4aRQtr4KJTQF57p7SWnvtgU3kRFjc9+mNvdAIQT4g9/7PfMS0H4o7sbFfKMrqP63bv9pTKxSbHv7a1rsZgx/d9DWA+5HpLLku2JZlGh/VDm5capmayyaKBpeYouh8jyRf6hxFZNWJc7G9nvJc4e+7ADFSXrQYCcm1/NQYIoYKgofNgZrUEps568eNiVD8OaYufe/8ra9kkuZ+bQv20Q1F8pR6eVZ/AIJC7VotLkqSy2bA9xrYqZxBCY7AkK4EWLzGGam07SS3smNhOyANbRHdFKnFzFshW8TeDkxwGQg==;5:lCXXCpRN7Fs6dkXyYyyCjXXDNMcehQeyB53jGGyrA/pRbtjVYHIAqC3IKNeDplsHtEccY6U7sHuky1gRbaHtFBw72UU6hvc4Oan+qC3ho15QAKmZentPx/R4t18qHiQZeTqzjdGreY4QZKUEwivxOt5bjVx9+elYlxxw20+mjDU=;7:NBwZHa43iNQdi83WHE02ppRRlPw3GPoKPbSNJ4YIeZ7fuSmJHbYZ2NC41TG2EIuQdfjabsV0/N8TTgQdaU2/o8WeJSLh+CGMkTd7La3IE1UJOKXwT/uLrDCIO1ltw5w+pMjopxIsT3vLJzqkUE4VJ6IC4qvZlFT4HOliOQus+izy5WrezPCJag9mbwRyBsM6+CPgdMaZUf+QPC/CuRIRoWe+teZEfCTfM0gYBPjlb7mRtn1oP64ednRcs0+cBBdv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 08:32:34.1164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f53564b5-e479-4862-1cbf-08d60d89f90b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code and HW supports NETIF_F_RXCSUM, so let's enable it by default.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 06634d4f9b94..7d98f7828a30 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4591,7 +4591,8 @@ static int mvneta_probe(struct platform_device *pdev)
 		}
 	}
 
-	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_TSO;
+	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
+			NETIF_F_TSO | NETIF_F_RXCSUM;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-- 
2.18.0

