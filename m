Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433A3C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32B42154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fCsd8QCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32B42154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389991AbeIUTMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:12:09 -0400
Received: from mail-by2nam03on0071.outbound.protection.outlook.com ([104.47.42.71]:40208
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727392AbeIUTMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX9R8T1arf5VGyM4jMLNKLOwuRwq2nNpNYzB91AKS3M=;
 b=fCsd8QCxheTpoGv6eba0BIu28Fc3YBtNfhFO5fYj9k5i8NwYt4urNP0UQvsiw+gQXzoWY9FjQ+pH57w7e0s9uojdURCRsoM6+NTWSuaFHoHLh3ywsZYo0YZ3v/p3uSaMuuj2czsotBTGXerdeKW8BZpRu0m2ei8mummNMXc6Hec=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from andbang2.amd.com (202.56.249.162) by
 MWHPR12MB1661.namprd12.prod.outlook.com (2603:10b6:301:11::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Fri, 21 Sep 2018 13:23:09 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com
Cc:     Sandeep Singh <sandeep.singh@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH] xhci: Add check for invalid byte size error when UAS devices are connected.
Date:   Fri, 21 Sep 2018 18:52:29 +0530
Message-Id: <1537536150-11721-1-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: PN1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::19) To MWHPR12MB1661.namprd12.prod.outlook.com
 (2603:10b6:301:11::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36b9de12-37f4-486c-b59a-08d61fc56108
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1661;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1661;3:ofWTVbdx3xio6SeRuekm4Z9VFpV0rzUmwhJZM27EM7cF6/jfMr/W2hNkHGxcrOXcGYdMOPuvJLj04zVsQNreHHNA79pviz5/jVHFYj08m2aVElJoB4P5wqBeFUY2zcjRYWdUK8ou6Rx51a/5THPd4h0kGozuxXUaKSoilEfev23Gsi1tQ3ZKrWAptfJahKj7HqTia5LFbDrfeU1fEdk/YlDHgwUsYObgLmUDxANGn8e3ROowY9BAjIUjaQTaJeht;25:6Inla3/dHl3PSDwOJI8nxdVu5wAisky49HtbImWsYxA8SPFqLVUi6hMlnQgBV3fEx3bnP52FuWfG//PcSRO17IYigwZlDxtIUzayogf6Eai4fd83iPYpOQ5bIwXjNe/IjKw9gMKx0zXpqxpahXWAHB2a/JxBTAKvv7VUCH5OG0NY5ZiwLySWf9qeEao2521+GEcGPan9fue80FjIxDlyYwKiaLuBeukWW9OuCwK4eHLIKCrQtNGRjD/gw5ytfCu4NkbzEBkL4lhJJ9I5NMOiCtyhTvlhEIsKoU1Jjjhje1Dt85xMxKYs8eSb5R4jXkQNA0+LeBCQKJyqA1TW3y9fPQ==;31:Y7v2m7JPrv2FAfqivoXU9ODsqXQffsLPnA/rFiEdnZvvFWR0AqIdU2CB7JvnVcubm9E+FHRWswKbmvmVM82zkF5qCvCjiUKmtH5efWIgbvYbJzglwSLHTDj907uQRDYKg+qT2i/XyBFlHMzQxtK1UzcQlrT09oOpy79ata5aV16pzGhh4G8o5+XX/X5uSg+mt0Y5yu/2Y6sm59v8192tO7MP73X0QceqQrkbK5z1u50=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1661:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1661;20:PAxiHTHWGp6lKkob86tRBW77sSh1hf1pI3/Hpx0fHQV1ui9RVXfCadGg2e64qpw1yFUGoki/NV+Jv1EuItaez3JUTdj4VzULVuudNp2ekoZv/Wx/g8ugsJbZ49jJZabiVFiPbNdFQxZN7FLzsIeXZr4qJS+aeTuteTf3mzm8kCEoVyekDW7fRHDkMf4MJ+5ujlIZWpEhX9QaBDTSnq79bu8mgfj6A8td4eI7JJ4Q4D8t17YHBW2RERFFEYJ+GYvqhDsqkDLKCoAmnNEEIJKq7dpN6ybJopT7tC2AZWVbimdzcRa2s89rMWbFxLoiz4wQlkslgKAIYM+cnauQf/syZDY8vcgHZSFJgXVKTrLp/yo1Gk+BYvWDnH3VJwJxPoaRlnj4UM18D8SFGCnwIyUcdsTbgQNATlCO2/h0cMAu1veTqsy86ZgXEAYY4GfdfOteirpI5XVBLGnNcTCsra7ESuEJFEHjP3NAOjK/lOP4t6altKPJtl09QMDfxpbn0zF6;4:YWLdm+/b5F0WDx0qWqDkDr72FaQDwY2TjSxgR3sM/0xRcP5aCWKvckb32G5GydFE6OFYGYy1DvmI9r3Y7qvArXVkTurUQIOfpbwbeWR/8M+tXFmJpV4Ri5aaELXDY6sqoSed85IwPSTU6jePl4zhMRJKBoMzaYB8C70WS8aAMcX3Fdrxs25LhRGrHLbXGMjiDQAdNOEUSkbmrJr6dVVwC3e2R/Yy65S7KLKU0cYBc1zXsaX7S0y0m0FtZNWG4spFeksVomoatjHH7vIsB0K13bBoMB8nzkPe04M3dbqq46XGXM7zb6EygVxWjmrWHZe1
X-Microsoft-Antispam-PRVS: <MWHPR12MB166147A80E3546BB4E566F2AE0120@MWHPR12MB1661.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051);SRVR:MWHPR12MB1661;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1661;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(199004)(189003)(53936002)(5660300001)(4326008)(68736007)(2906002)(36756003)(47776003)(105586002)(106356001)(3846002)(6116002)(53416004)(25786009)(66066001)(6486002)(16586007)(54906003)(316002)(51416003)(7696005)(52116002)(72206003)(478600001)(956004)(476003)(97736004)(2616005)(305945005)(48376002)(486006)(50466002)(7736002)(50226002)(16526019)(186003)(81166006)(8676002)(26005)(575784001)(86362001)(8936002)(6666003)(1857600001)(81156014)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1661;H:andbang2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1661;23:eUXyCyGLpXI4HpUsgxxQDtK3/AdActqepcV7tTzL0?=
 =?us-ascii?Q?nNsWX+aTM9AB3W99/f8BzAKcK9EkV31meacOaaWBucr3prD4zRwibczVznlz?=
 =?us-ascii?Q?Yf8abPkbBI1XLe3MClf/acdUjEu60kQDJIQzHgIBLIvPnLtRo9qubKnjRaKd?=
 =?us-ascii?Q?pijuDyBrsbFH4mIk+62Boy3PZ721P1z7Hb9SEf3/0rLB8Rwp8MKkRL9NuPsl?=
 =?us-ascii?Q?gLgHDYzzVQ7In4qWPuWIhrfirzODrY/4JE2wleAOC8gtIjOk3s9Ig0Qo/KEr?=
 =?us-ascii?Q?OR5gqmXqtr8KUQZjeoQmMTIn301RldVzvehp29MNurRKuFiqoWC+Hg+EC2Cn?=
 =?us-ascii?Q?buG14O7o5qc9GtzF1TrCHPlWeYdnvmh0Pv3Pq2NBh55IUJtanOYw/HqeRHCf?=
 =?us-ascii?Q?hvnKy2MwXZfuwE9EdnUoI50uevFw7KSX7fdgE7jQ4vaPFuInagXQQRLJ6nlN?=
 =?us-ascii?Q?CIeXQnPaURESH+nP6zJMNJ5zYnQIRGexfzPKVS3ZCVCMShzO3NPj/4neKLgm?=
 =?us-ascii?Q?jklM33ysOC94z392l1RuY4Atr+kdlWXhAs4mBdYDVgtkGn/sw0JCwN8UY4ah?=
 =?us-ascii?Q?nYHfScZkZS9V71+T2SNC6y5hRgD2JqR/GNMu/J0s/xQMzV+dWXmPbh1uxwd+?=
 =?us-ascii?Q?visFuuqCsb9th3TkXkJEAfk1bTHgHFnFwHZRAM9Sv2PZmKKGgg7JPK2zsYdf?=
 =?us-ascii?Q?o7KxMlJjiVYO8Cp9PVz90MjH/qKAt1vgSI8dlV9pW+FPJf5L8NoV1+RCAMfa?=
 =?us-ascii?Q?GlwUuYs/jIGQMBxK7icBgYvcgaVHprvwGRtVqGfGUcEh/oKbjfkvlOlImC2n?=
 =?us-ascii?Q?mGNx8TO86F1uNKgUGEf3CnXi71w+JTWa50nHaM1st91eRMOnZXZnRKnu23Bg?=
 =?us-ascii?Q?r5CTVLVk3p1kiVXakBtFHKvcdZNIMW3JkscaVwZ0dpKK3nFw7gb3WKISgijt?=
 =?us-ascii?Q?B58JeVzdEnyPKBFGrNLHkaYrWFELqCFYeNgU+PkJTDcpuoXsGyqBsT4vsYei?=
 =?us-ascii?Q?1trwQVoN12FIWmTZB8rD0fsq5Aj8K+m+JiOGbYl6cQtVL5AJ/mmww9B+YrW6?=
 =?us-ascii?Q?K6A0qj10Pq7bg5vcs5dXmKfB3hhoUedzccMOH+Roy+XJeiyFVLqa/a/SipEs?=
 =?us-ascii?Q?LkOb1b1LzJjEnSSrR3RFBfwcL4+o9A4koB0TI0ogGKN0ewudLaG9BGxkmRu1?=
 =?us-ascii?Q?TZqLJYIMOX6LBo=3D?=
X-Microsoft-Antispam-Message-Info: 8R4Jo0p/OrGzMx1z+QbNBeS+u1DuKrhEt0xYUj44nTPxiVWGg1LTzS+T2fFpq4XI14u3XXNHbiWWmbioBH7urMtvOlZJ/nXDjeRsHark6URIQJauOsxPLAO/AWlWlzkJqmqMyb8wl14N/xajr4M8TCrhXwOh+EuWMFJpIcz1tXaJ9FEXsll/4su6488dboV2VRfrCR+HqXTDZI7Prg3gWxR6jBQFXZUbHqjtHz4rU5fna7UNnMZkhr9xVxKEH3XnU4lw4TnPyOITPDzyDtslNljcmAK3mcM1ckRIPDAwpoiLnAPHAIllDI37I02hmkM/VoC/C4z59RyUVxJTp5yQnEszaNDSzzeHtZ17srWRq18=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1661;6:6K3oPotlhjVNmJlNlf2+64+eqNuEKkuE9WLp9yuD9mnsXjL0jPNpevffYqZQQZW8yKqT44t0dhpoLYE1VxzdMJG/qOIw1PEMQ1MSYF/RDkPV9+wpN7YOzU6FpW3jI42MhyODIY/jpFR3zFqy1ODW2HWh5fc0f5cC8V95scApRXfgQMM55ncTYHnKVlp2vNXsU0qqh5DmbVwaX8w6Wv3RePU3+1GCfuYI0SLmQAHIhTzqBhgP3furhz2Zh85OVjAeH58Y3o47xIKy6ZGr6lItWZpnVqd0MbjwGqwXus0/md+efStFVSv8OMeaShQSGJ3/F9Z2WH+9qclhz+Je0g/hVOEfg4YmzEgYD4rMQGKoxIojSNVg378QZV1Dw6oJcDIEfe/XQv36vmqvbJ8Ro4tt2YZ3jOsiIf/wypAY5lPdbvnGuarStjo0iwYCQ02gvNsY5d+kPusskFDp69vfc+R0sw==;5:E2HWmMQDPD7JIS2alvy9mcZTKMBR0UgSdKqlYWLgD32K4nlOdpuUDf7wVk5aK1M8tKdhXdQoLSyIVkJz8U9RaaAouo8uKBZLjNcEIt/sB0VM0kbITYwI9dLHIL624eNDv04cjk04ds9ZAfpRF8D6OLXGgtPmMOZYOqzrAJN/IlI=;7:V9DL+XL2ledPkm/R95gl9PwtYdsQUY2tz5cidaJw7M3uyDx15eyK/hdHGiufGGe1NH49MVtf3NWgXq9SwichaHJHXn5maW7oXfeScS68zt9JQGq61v3BgWGXkXuI+PfdYUHjichRTWHMjRIh/byvjZu4jKghOn2viYmXMIsKy5LJW23F70XgPHtLZ7hXZaMlMVEwLPuV+coDPztXoyTejXLjeAKgEhO74urcteEZRaUphi6QQnie1g7r+TJ1UIXo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1661;20:4/BEUs2aLj0hpInmbdq3p7xIDUKIml2g1khxv9vjzd0ycRHSc/par7mSaNvcAtVrw3J8rVr0lGUDnFA8CygINYfrh2ITF+s036T2TRme0Miw3XX7wNn1mrzIHl/SgkvbQXip5in5lS+aJXvY9/DAC1gtp8Dclqyils9XB7B1fE6z2yyrHjx3qHFum0Bs2Ho9zQOI8NH7DY+JB+uSC2I++5gEvjr188bb2NAPoLV+TX0TLcjYaZYpa/oXyzU8RvVv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 13:23:09.0071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b9de12-37f4-486c-b59a-08d61fc56108
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

Observed "TRB completion code (27)" error which corresponds to Stopped -
Length Invalid error(xhci spec section 4.17.4) while connecting USB to
SATA bridge.

Looks like this case was not considered when the following patch[1] was
committed. Hence adding this new check which can prevent
the invalid byte size error.

[1] ade2e3a xhci: handle transfer events without TRB pointer

Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
cc: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/usb/host/xhci-ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index f0a99aa..8ba2cbc 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2246,6 +2246,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 			goto cleanup;
 		case COMP_RING_UNDERRUN:
 		case COMP_RING_OVERRUN:
+		case COMP_STOPPED_LENGTH_INVALID:
 			goto cleanup;
 		default:
 			xhci_err(xhci, "ERROR Transfer event for unknown stream ring slot %u ep %u\n",
-- 
2.7.4

