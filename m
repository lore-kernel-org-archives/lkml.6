Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC2EECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135C520853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IPV1qJLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135C520853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeIODsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 23:48:54 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:52864
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbeIODsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 23:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTLjts0Ve/bbTwB3qArx5+umOWuvCZh5Zgfbq3lJFSo=;
 b=IPV1qJLBz446fHau2NXv3xwiLb5QJh+VFIYtb9QiPOt3xDxdFaOGHbB1xu8U380Ly3ikTOi/QZ88a5ETc5z21HzsbGRivePXLhDVzX1Ltae9M6J/qD5pSLoV2AFGWYWxcMC1/DjTRhx4BWjFswwQyhpTRpgWohxYzs9I1sLj44Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
Received: from gi-joe.amd.com (165.204.77.1) by
 BYAPR12MB2725.namprd12.prod.outlook.com (2603:10b6:a03:61::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Fri, 14 Sep 2018 22:32:22 +0000
From:   Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 0/2] Miscellaneous SEV fixes
Date:   Fri, 14 Sep 2018 17:32:02 -0500
Message-Id: <cover.1536959537.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR0101CA0021.prod.exchangelabs.com
 (2603:10b6:910:3c::34) To BYAPR12MB2725.namprd12.prod.outlook.com
 (2603:10b6:a03:61::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d958fee3-29cc-435e-42c7-08d61a91f0b9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2725;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2725;3:GhKMgdTqoQIz94h7uzvxggVnAaDT8vbtB3D1GpnCx9dQQEGxlDAdwjHxar+vCdMJeaNsKleWyIL7k0x7q2icWOgoS15KWOm/EkKxEYFYcPDKNBh+xYJCdMZtYbX1tF1auaYM2Jk817hdRvrNc2nwajYMCHl8ZQVHLXDUQAdHgu7eED9CRbzYYQHEVVKpViviEb3FFKTVUWn4HQjv5Fxgowahqzc+T9JnVFMKDm3s7GO4AoX8YeM5ZzM6WUChc7iH;25:54mD3qtc5qnBEA4JdQ2edyAzBGQ0WEtmLcnEibOM8CucVdHCDQf31es5TsbrvkJaT6t08rgL810Zbwovf8Tx4UrkLlUxetyAnoLl/iAhsmAEHChJ0V8kV0b64eyDSCSqR+aZhdUidy2ezPzUaKTjNhdWib6NuNp49NXjdK0ExEyJfkTHTBiHxjOxEK3FF/iYFUySdOpRl4eG5H3gZ6dfkLQYOOZlmr5913V1WfRx6CTtA+etJSzLboWTWviCTgScqO6krHv5j1jdSGfVxbEVckr7ju8W43RH9pFE1ShwWUPxr3/AxJBbmHDK4ZM1SZYvxEF+4236KiAX9UZIuEBPDQ==;31:5D6C40NxOYs/WUCdSArjyHYG5pgtSAkGoDS3RvG1K4Q785RLWpUTRVcLhWaf8Dc6Xsm2tikUWSliCkccYO7iKdG6B8qaZaE5YavjqIybpZNUwpNPnlfUDacUn+0ABwoDe3D52zejgg+GYP5eDTfzJR9nPBYKpgj7AXt6V5Zvulm5Lfw2V1rueFFPUECGWlZc9kQFoG00qfG3+CDqItGobsb648OVqTjFw3UrpdvMlxE=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2725:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2725;20:18n0c/xaH70+t0G2KhepVL3+GGbe4BDs3vL7C1sa818DGmRpsQJZzITweERIV7rdvxLuX+EVAI68uqsE4NOgsGrhF69xjDQ2V1+1TtF33F8kON6U6LxnT987PtoQwXQ0HgEljPFGaPVhwCvb1qy2tNFwAm1uFT5pd5qPqppEKJNHpIt2KKUsp1wQhmufTsjfqKai01tQxphM1RiMNOkjwuH1kWDCMhANhBziGr4KnFae7CHTOj2Xa0pqBbCNnN53WYlzBHspmrhrL9S2Z8yARs2vn4sQjzReEzzlo+gbsFP3R569IyMoTrnBKRZhZ8m/Y+T6Edu017HOaiX3q7ZMUP1+N5atynS/CrW79SJgQ9BZPiqoQQoSLpqjaXYRDZ2aoE7eDwcVsylzAJ+x9h60muZt9wKlJGiEWeu+StgF76FdIM6ipEjhCoocL3Pgyq9XQjpVbrwUqnTBgO+EA7chAdQc4gZAlD+cof2oVqvnaHEtZgaOmvzkbHibNffwFVwg;4:xMNgqWt/JAAcJXqY0pxzq0gb5vEEwh+hFbL2q5PoLggzkb7mlxp/RJfTMFV61tI6YQtSGRVnzwKtVF424QhbJ1pTDIHBWkpNlK9Zw5BnFwU1H+MR6lUAGMlqdXyzL8m7GkG2RPjqFhGkjNtcyUyxiFPY8fKKg0uALXIBghhMobAn49iUbQH2T118ZR1PS//Y812+Hfv/r9gYdfhmre5ZVHPgNtVC79WCfgjtekVeNmuH9wS5TV6j2xPxBwx6ostIryyuJ8OMmRiket5mQB5tYA==
X-Microsoft-Antispam-PRVS: <BYAPR12MB2725927C03F16A5902112588E7190@BYAPR12MB2725.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231348)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BYAPR12MB2725;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2725;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(6116002)(6666003)(3846002)(305945005)(14444005)(72206003)(52116002)(26005)(7696005)(316002)(16586007)(7736002)(54906003)(5660300001)(105586002)(486006)(53416004)(106356001)(476003)(2616005)(956004)(6486002)(4326008)(50466002)(48376002)(47776003)(66066001)(81156014)(81166006)(386003)(97736004)(186003)(2906002)(86362001)(16526019)(25786009)(53936002)(51416003)(68736007)(8936002)(50226002)(478600001)(8676002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2725;H:gi-joe.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR12MB2725;23:P/4ECx8I6vXCLsol2G4EtulY1auERAvhOiKDS0lhe?=
 =?us-ascii?Q?o5Qj8APz88kOIHt8Rsmmvneu+QMNowj4eLYpobE0hXxyDQUrRGkx6Sy8pD4o?=
 =?us-ascii?Q?EPwQbRY2TsjeKLtIc+BLFXB3hQT4fnt2PQudFF89aEUVADJqrfA09tkapUas?=
 =?us-ascii?Q?w98mHoOQKjS4JBSvMkh065nlY6q8Oq3+xSh3Fv1HY978ntIxCDl0CBc+mW7o?=
 =?us-ascii?Q?KJrXgSc+iPJVn7uChoNBcPFWnt2kUWuPItMC7oKx0ekRgvC079Dalo6FHE4I?=
 =?us-ascii?Q?rVxN34CJNTUc6cHXvdDwriR5sKfjxIQo4y6QJXFLzxNIdZMuwQ3fC39zi6KV?=
 =?us-ascii?Q?8Ce2cfyRgN8iPU8xbs29t2XBjrUsP08a2FlUrFcbi9QGNS41ItiqQZ7ONz1L?=
 =?us-ascii?Q?UHmXhyoK0iVQOKK46muW8+FwOeE/cN0dvE3gqw4rljrIsvlkucpnMcNLR11G?=
 =?us-ascii?Q?DttKMIBKcyqZuSWkXhWZCUMFQt1ALcoW1cEY22GsGAMY/vhEHlVnoQs1gY6Q?=
 =?us-ascii?Q?tuktoCouOrFUgLAhGqShh5Z9K4D7SutFgy4PG+JHWs0wjhGmf/kyJ0CzG4Io?=
 =?us-ascii?Q?eQnVYqerZF6V2Zc5OMKBvrLggZY9oJt9QlZnofe3yfDdb20qCWIJcgFrbpYL?=
 =?us-ascii?Q?AtUG3bRCE2keGGXHnw5Kc6lZuQFs4MsUnouQ0tlu7R3Eh3jwnRRyarYeG6qk?=
 =?us-ascii?Q?H0dvb7BG08Q7kHsEwp2vmmqIkumiSqeO156s+95SB3ccWJImX1QOdGm5+qYt?=
 =?us-ascii?Q?Jp0ghpLVZVCVUQpGLehtSU4HstFxg+CxflcEtP5NiLlFQdHVZnrqthc3Wv2x?=
 =?us-ascii?Q?vYIxBXC+Pofc0dHngnfjNHnToeJXp13BQL1YqEvpQJ0P1LRXHUa2CoFxvGYr?=
 =?us-ascii?Q?dgs1JPsbkRddjxuwKXK6NJXOhkfk1BDzTLcmYmnAVHZthELQhjvcTlHZffku?=
 =?us-ascii?Q?qP8Nh4fzlsiuoQ8YulhlgijbnjVt/7E6T3bI7nd4wzQ8WkNSdTjCIYTM37WL?=
 =?us-ascii?Q?AthuR1xkFHZvzmDuPjGuFVyHmmewn8dczEvEqT2O4hLEn7BbUnfbcFXRXURD?=
 =?us-ascii?Q?ZIuIbs5JfcP8uR6QfuxGz4+rU8znGR5CLYVIW3RET61lnTXr+pUdaUBws1sA?=
 =?us-ascii?Q?NiItcHUToaPXtSoIqQ7AOO/FXty4eYINIKv0I7OortmX4asHl7SLw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5rqtFw/mCE6+puSer5CNb/C18QoxuI1Svo560tbg6rqgDPxqgJ97yp2v+Zs1r/D0xgNljWXuFrzlOqmhJ3xRObselgzEFj4tuYD5etXdnxS3HUD4RbgfoIA9tE5Y9HGg8kVnW9ke6HO+N1bgRh8T7bIrEQgSdqGORFElWwxzu/CiWn+vJX9wp1GL8sVrEdqp+onMyW5jcBQYTs2uwwEipdLY8pJlA//ObSK4a5q9twGXL9HWaOAR1jpgTQkv0s8WpYT8gv7Ejce/cLsLtT9WkT/BcvzToi0rhTnj1rHexLI+xAlXvMY+rqv7+zY1s+xDGV8fWi7pBd0hv5YRzkJIAsH8ilCqP+Yp8O0dyUD8DUo=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2725;6:Ve9VF3u5kklxyFyHw7R+FcKL6+VrvbrktQiZL/Kh0impmvIN2qbgRa4kp1w3YZpKctbtcULlDXY3q0aAVHhTArHIb+pUFM+tv7elZ/gxs5sJ4hoXEQoCORprrS85NQCIYRFbUOhgix6LilN63fckbqDRmT71aNoS47MQRcwqGv6U8TJy1MY64ssK6wmOii+mW4CgDl2BhT9pcZt0JCeRgqWDXy8kEarb9mE5Z5RGJTysIFuumydN5wEh8VDwsWppRXWyDNBI2ae5JUCR9Zn4642lffHnOd9Ybva7NiyN6zrekByD1LH/KaR/rMdX34PpbrEztNMLzX4e68+CHUeO9hDXbk+m5/dSJkGQnEuCetWP7IBjr/suc4qqvnYUNkDJsU8wYWu2WWVYb1/qSvUA9tLMxmA95RJ6e6YTQFJnf7VjJ5FtdCL2qGkbtVmf2TnhZDzbeE7E/YIN7y4xpa/6XQ==;5:y+5Bykhhb3Lbt1zQpmqtV5zR20A6ivZFS8/stGZPMMFSTuuWaSRZFGqJ4todJTXk4RLrAXSU+bUnMDYQfrnxWJ9MBKuAThGBHN/VtNudUaQTuMGXvUt+tpDhCCbdp3G3nDZsu1pIrlaSz1QewVO0g/f8oPWZOFYvYLdOHYaQuZQ=;7:QLa46SpzxqQmWg/E0J26OhI9U4IrBw8XlKgWfxgGyIi52EaNqUUFmqrYz+Sdk7m5FHUpaG85Oe00Sm6WeFlp8AAUIqY+pqPTEu5iyEh2ngiKqsAMkZS3jNtZxNDQbsLvAqBs7IpfcNBGWNeQeYAeJls5nOAQ0QOmkZ3ydIRHJNu52E8V5Mr7EH32C4NgsAnlhIqxSl9djJ3+XkdFHq1+6nVuOfV56I5lNSJiLrv52Y1MffrtCkUqr+YYUtch/o4Y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2725;20:6r3kOjD7KUtcqN0U6avixCp6R0eiMs7d47S4IIMIbRDFWzn//PViHg1w+j4L3fzQTCbkCNW7oP8fyMnFsoISho5oYNTwe+BJVZTiPUG4p0s+Ts9WAap+NYaP6pbRwAqDuFRPNWEQaxwZ8GfIHK3w0F5i/HLXvpYFWduR6Ios8m605xP+297PtEcqW5EZZLXDVCrEczVpJB9fwkqV9kH5GpfFEQtk16Iw3a1Nn0y8+Df8wm0cD4tdckq8AY+3cQCK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 22:32:22.3582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d958fee3-29cc-435e-42c7-08d61a91f0b9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch provides a fix for a static checker warning.

The second patch allows for the SEV firmware blob, which will
be searched for when updating SEV during PSP initialization,
to be named based on the family and model of the processor.

Janakarajan Natarajan (2):
  Fix static checker warning
  Allow SEV firmware to be chosen based on Family and Model

 drivers/crypto/ccp/psp-dev.c | 46 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

-- 
2.7.4

