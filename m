Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1362C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DF920844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="iUsiUEgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DF920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbeIFTUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:20:53 -0400
Received: from mail-by2nam03on0059.outbound.protection.outlook.com ([104.47.42.59]:48048
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729840AbeIFTUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dsJ81mqGECUjvB9GK2CZ8qqrEm2VIGDNJ5n8YjsQIM=;
 b=iUsiUEgUbD00yuVv1tSi8mZgB5LsKy2VlV0MqNYZCIZFSd0UawSsYm9A+A4IwbbQZ4bVojA/tQ7rmX0pJhSxB4xYMIf5wlkRVljeKLUjquO4ESuzqSL/67Mb4SYpJprSfmwPsa4IoexaJsrjp4QJD2bekWu/RQazt+zsLVQL9TE=
Received: from DM5PR07CA0037.namprd07.prod.outlook.com (10.168.109.23) by
 SN1PR07MB2175.namprd07.prod.outlook.com (10.164.47.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 14:42:58 +0000
Received: from CO1NAM05FT045.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by DM5PR07CA0037.outlook.office365.com
 (2603:10b6:3:16::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.17 via Frontend
 Transport; Thu, 6 Sep 2018 14:42:58 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT045.mail.protection.outlook.com (10.152.96.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1 via Frontend Transport; Thu, 6 Sep 2018 14:42:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w86Egrxb013012
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 6 Sep 2018 07:42:54 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Sep 2018 16:42:40 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 6 Sep 2018 16:42:40 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w86EgV3k025969;
        Thu, 6 Sep 2018 15:42:31 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w86EgVcH025964;
        Thu, 6 Sep 2018 15:42:31 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Alan Douglas <adouglas@cadence.com>
Subject: [RFC PATCH v2 1/2] dt-bindings: phy: Document cadence Sierra PHY bindings
Date:   Thu, 6 Sep 2018 15:42:29 +0100
Message-ID: <1536244949-25892-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(2980300002)(189003)(199004)(36092001)(50466002)(2906002)(217873002)(36756003)(7636002)(305945005)(246002)(356003)(8676002)(51416003)(110136005)(42186006)(16586007)(316002)(48376002)(336012)(426003)(186003)(26826003)(26005)(478600001)(486006)(87636003)(8936002)(106466001)(50226002)(5660300001)(126002)(4326008)(2616005)(476003)(105596002)(107886003)(47776003)(2201001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2175;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT045;1:Y5KFb8TJ0Hk8bWa/m0vYQ4Ir/aXxo5nXkQ16uqZjvtJ34YFQN5gBYSlaCHNAgt/IEkfK/Qay5OdmruPKlN1Nqmh1o5bqWYoVu6c2Hxo02CZfUzWQLzf4Zkph1p+05Fie
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e592477-4376-4dad-b96c-08d6140709e3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR07MB2175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;3:6n/kx1jaO1GLmaT/O+YdhglyVr7+E5T7iqaNIiVuYMFo8qp5j/sfm/8d7z9VCX+MW16EWArl8ve2bEXF2WipPjKCYCDzCFwriFBiBVtp5kph4OwgrGg8YSde/csDtMJPbLL5uGEKCYchU8xHNo1pXiARiIBoSQGX2asICVoJT+W75h+EjHZt/ead7XQ+UDPl1miMfvKLpyuvCU3mzdg8aMjGtvGqTnsk+IgTxMJ91yz0auArKz7Yr4yF6kP6V5itUDoCWYuG7Thvik9JxmRAKld6ys2+It3kyR0FyQKSnY3OsVAZkUeCXGGLmZb6Otz0NMv8sd5XvRO/z1I0/TavUppEQrLdVon3eZtXomYMmFY=;25:Nxm9J4BtC1q43ZtZyZMWdHobDzjx6tOBMSDKpZZXf7iyRvA9bAxyD37WLCFFCiXnlauXgJPUeNdExniDZmCEClLzm2UretFXhdZHsUFYPV1BxETktu4JhPi8d8vuYyxYyq3eICtDPfWsB8zgu65RzNW6CmSL80d0EVkCrorRr6LOzKH2JoYJGF16HAB+p8OAxcnckTrxUGd62Qp+xKK4VpZ+id8oFxfegtTe0/iReC2p/XFc22SxIapTgQbD+eyvTPzYLIrc+53/5hFyizRsu5GE5fMcs3tFsaxbv1x7/QwJP2Am1vGz4pV20BPK9iZJdrmSFfMWlOH6AtwWKWMmEQ==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;31:5f/3H0t7Z7XviPwXa1YpyOMs1+7x8Of502xkMgIBC0OoRVE+l6ck2bzEEcYEe2AqYop2V1KMjMRzw8piEI3+abYkrncfYuNjDb3kGQONBxqldv4vDYt0AV05tOPjYK6IcbNHRm7y8TLYynfAOvltemuTOh0ZyiKx7SgcjSMtL65MqOAvBwiqz0NTSa4izoBap7EkKhyl/Bw/suCYpQntBDzqoXDT2YzmON8TClc5d+A=;20:BrCE4HMm6QwNi/iZNzqjK0xRftf5JszHDCYr8AX9MY/HzJFtdNOw+exel9DbrtcvdGXBVJpeawRLjGbBgUCTyvIFCTWIVvkhJRZRDcz8RtAhl17ZvZbXlfaXCdSB4h/ygm8/irpMyN5r2RT7cyM7Vn5AB4/ImGc/lYCF2GIwdKI0bCVwkZOpTyIgMYNG8IHNuBVkPvoqekElxt+Dt6MT/dT9KXxsSXwyvkHlvv7/6VxX7nC2lRneHX9Kh72yuMl6vuEs0Yja0TE5Kvh2MFluk5pQVQ5t3pNxpTMIb1Nk1ixj2KBglaUJISGKIJlb8JpDGLk/E85fQpZbHuRZN8lOujmCXHZG5lqSxgEKDY1Esy+9Lw+7jyZZA258V9OBm+m8+gTsero7HRahR0ETSurxPGuTUAORM2q2TKO9jijcPlW4WgPkAocxGVmuBPveshWu1xMRWd+yS6RrN4Q0gqIZfARmzSEsXAV0ref2UBwJNYOSqRJQZl0pAF9x9xHUZdDE
X-Microsoft-Antispam-PRVS: <SN1PR07MB2175504D53F0F7EA28DC7D3AD8010@SN1PR07MB2175.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93003095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN1PR07MB2175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;4:wVk3hS5ZaeiPfgExkAZET1E4ls82xMAK+BgiJeGTuhFX7ViOgeYfCDOdnal7znrrJGiB+BAEzhbjPxvCj9qIhvH9uwVqCYZAQL/UXFPq7NSSdELHrZXkTY9Fk7DF845WKVld5/nopokMOa5mWh0uY9gsnXF2T6SjRJFzwsFHfmoy1h2FMsodrtnP+Ohmfn4iYUJkbntZjR8+7ulJOar5UuZshtRKXDPI4AphPfujbQUPzROX9b9+OBN994LnLnI7gN5Oh02RGCjU0JJ9vMlH5Wh6XnhIc+vWFE1mrY/gAxXKh6dRG6VbAydkYw8ROAV4
X-Forefront-PRVS: 0787459938
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2175;23:kB5KtJL3JOIeM3lh+VBmw/DMj4DsUkI1Ou4ZNqKjF?=
 =?us-ascii?Q?8NMT8fqqiOMX6dIRRetuBJqTH26oGaGO1xmFgycDSqjnCb9XErTbqn/oxfWW?=
 =?us-ascii?Q?PaM83HXLtfrvZEhMXQdP5W+US7gS6RPHbr7s9oXFERF84aYE5kEyoKCGAudn?=
 =?us-ascii?Q?N8fyJ2af0YabW0jYj8jVUBRkE4eI5h7kFIg4/QLqPe9g4JAzv9u47TK9Lewd?=
 =?us-ascii?Q?UzafyQhlJQUavz9tsu3l3d+GhHh0d+RugYA2bYyNKhZYRYteNksMmzWNVrZh?=
 =?us-ascii?Q?sDVrL2wvubXli4jSLdl9y13SAJKfrPFa+P/qQgqoEpvFRnXDmd14N2CZ6tOm?=
 =?us-ascii?Q?jVaYdsTiOnNOCIFYayOA7LT/xwzosm+U/cBlPjWqAotiiV2uImJxpyIxennz?=
 =?us-ascii?Q?QrfQPsA/q+NAb/J7ADr3l89CfYPoNlcUEQcwSv1djdQ3my14+yX8CxI70Cqp?=
 =?us-ascii?Q?tiGYs/XHgVjOyrd603TJKMV/8luCumGjd6qYhBE9siJPHtJSQm5edhOP2dQg?=
 =?us-ascii?Q?kKJUasV0zBoEPn5Pz9rt7aaZb9pHDV6P1BK6a9CUEYEF6uM/EEveqksseKOv?=
 =?us-ascii?Q?PFCYBV54pzneusTAVT65DV4IMC2zn0hGkHHqeUZ+9gtVUqfExC4EseMYg03S?=
 =?us-ascii?Q?+OCa6vcNczAJIq+n3fNDRCVGgnmYGEVnbuOIBzdVrPEOWgmseX/ei1ltM/cI?=
 =?us-ascii?Q?HUVg2f4EnjWAhjSdNjWs/bGUPFvgDo8FqpMlAVTuwFkvWcEun6k+rI4tRloS?=
 =?us-ascii?Q?JMgn29XDQezVsY2SLTNVsuM4BboLn1y/YHzGNeYZ0j5kH3RAvE6WMUqpN0F2?=
 =?us-ascii?Q?1oSWx6w3V+zUBaeWx6RErIazyRcxRgBtlmgw56gVHpX6tMKem4T/XdpUHY8a?=
 =?us-ascii?Q?KPHOapDQwBpVqbFZvIZrRZP0ZMP81GP/bPZBZe+V6df7QpYXIG8kxeGwzqD1?=
 =?us-ascii?Q?PBNPcyJavPYTsAlWvZYjVv/LVupmsTzFTi0ZPQfbKb1DUjqDokij+fGlcfyb?=
 =?us-ascii?Q?iunyKfZVKxtnNkl+CedFKpB?=
X-Microsoft-Antispam-Message-Info: Rfpkh/+V2dF0Y/frrlEx/F76IZDTQ/iAuaMBKUERPza+3V1cRp84C428L39t7kRoTU8JOXnairetJ4Ir3VULk+6gEp/wtLhunp12alr3PMUXwj43s5xpF5a/ybSHFAaeAMN8NJBLGVBPx+i0FZKJvqer3Bw5Z3DZmvMhiYj5AlqR3v+iKu7sCzYNIpZKl5o9UoxD+P6MYHUemO/1tIYZflQcORqyiuF3bmEfhYIbECm3Y8SRuftJVQaItltqWRDedm5ibpf9E81xuVYOHK4NPuv9F9a1g9z74d5Fhe34yJUBX5n1m/VsHST63onZLmOlRQjjrdm86rO6m78JdGMCNcfFgXcdhtfgiylmOaNjkx+l5aXOq1/juBhl8iGcY0xStMfV8GdEbj5KEW1/g3SC1A==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;6:jpUo5mLTXYVdudgACh4fMRz9NrWL2umlSgs0QzrSnU7oVsC+yPyBZq78crmHcm9WKrnw+AeFxMZbX1p7w6goB0O4lyUjt1r2/yLh+ojhrWzzoVoYdVzbfjLofzIrZ10Px7Y8Icr4b5sAJmvj15VrJyANjJK3hXoJjO4rSPVeF+JrwqvypBoqjOexNbYKLZYlSHdALqgdKh7XVOEtAdx3G0cXdrtQ9jX+hwLx1xfaxH30owO+e9whXvWQVJHaAuceTqWDvUqazqBQVxRJ3pXmo+iEcM2svl2tcMQCA5Ps9mfAgqyg0IR5Php1w6wsz6VrkcGAvemRfP5q9Svplt5ILL0I/zeaei6Ag2iuUU7Gov3SAYUSS6oWi9JQa1vZIFWzFnSFVHtdPBgo8+a93QXKrtwkYc/vZEQ6bJ+mdly73fENmfTmkkoWhL4+rMpuYiuD/R8baQamz0PebwZ2LIshvg==;5:KuHt457SIbwwF6O3GJBqyWAbhxeUTOd6mzqsGRX/hiZjIEjAdU+qZX96yRaraftxcUuaTazbGVSVhL1LKS7qN4Nd4L1/OpgHrCHDbK+42n/e+JpegniwlAm4/J6C29vDGeBSst2FkkeKKfA2BrMh1qMfEsmkuFmDALsRByS+Mmk=;7:maFN2cqva0Ep0QhkY/Q5Rq2fylzdpOQ0ARbxyjwjNM/4759+ZQYHg8relxMBS92++4nH7GRV/ZkJQj9BZ/m7cTA7PZbHi7CMnCTB+IpULnSdXJEI55sd6Wg74007B77LacfDveVsIO6tmf6hxwJGNrXfcgIjU5oSZ+5RqM8JPm+AbluGbuuDb8r1k8pW0r4kte3z2YumIQZuZ55V0X1ZqUYi2X6zu2hNLhH8pOCE5b6oOaBQNLd7KtFNJTiGauIS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;20:Q4beuwJpzNnsMiyV9HMTvBhXno0hQhSix5F0zBJG0ZTEJv18i4o3C/VNQYGy/rBRH5ddt+n1Tax/Z0mcFArNfSUGiJqZcprDwCJeq2Y13mY0ycp1R1cLcTYb4I9gDwUJ+LeIOifEWsWa5FhOjPRxphCnO1kVWpYvLLoLwSbrTr229teC9r2w53ntL5YYAM66Z5+r9XqorDsWVuMJ5TBS3HGgPXJ7o0PMGlDsBhRs4EhBsWhva/i0VAAa0Md/rltt
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 14:42:58.0249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e592477-4376-4dad-b96c-08d6140709e3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for Sierra PHY.  The PHY supports
a number of different protocols, including PCIe and USB.

The PHY lanes may be configured as single or multi-lane links.
Each link is treated as a separate subnode.  For example, if
there are 4 lanes in total the first 2 may be configured as
a multi-lane PCIe link while the other two are single lane
USB links, and in this case there would be 3 subnodes.

There are two resets for the PHY block, and additional resets,
one for each lane.  For multi-lane links, only the reset for
the master lane is required, the resets on other lanes have no
effect.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 .../devicetree/bindings/phy/cdns-sierra-phy.txt    | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt b/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
new file mode 100644
index 0000000..94a8a7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
@@ -0,0 +1,65 @@
+Cadence Sierra PHY
+-----------------------
+
+Required properties:
+- compatible:	cdns,sierra-phy-t0
+- clocks:	Must contain an entry in clock-names.
+		See ../clocks/clock-bindings.txt for details.
+- clock-names:	Must be "phy_clk"
+- resets:	Must contain an entry for each in reset-names.
+		See ../reset/reset.txt for details.
+- reset-names:	Must include "sierra_reset" and "sierra_apb" and one for each
+		sub-node.
+		"sierra_reset" must control the reset line to the PHY.
+		"sierra_apb" must control the reset line to the APB PHY
+		interface.
+		Resets for each subnode must control the master lane for the
+		subnode lane group.
+- reg:		register range for the PHY.
+- reg-names:	Must be "reg".
+- #address-cells: Should be 1
+- #size-cells:	Should be 0
+
+Optional properties:
+- cdns,autoconf:	If present, indicates that the PHY registers will
+			be configured by hardware.  If not present, all
+			sub-node optional properties must be provided.
+
+Sub-nodes:
+  Each group of PHY lanes with a single master lane should be represented as
+  a sub-node. Note that the actual configuration of each lane is determined by
+  hardware strapping, and must match the configuration specified here.
+
+Sub-node required properties:
+- #phy-cells:	Generic PHY binding; must be 0.
+
+Sub-node optional properties:
+- reg:			The master lane number.
+- cdns,num-lanes:	Number of lanes in this group.  From 1 to 4.
+- cdns,phy-type:	Can be PHY_TYPE_PCIE or PHY_TYPE_USB3, depending on
+			configuration of lanes.
+
+Example:
+	pcie_phy4: pcie-phy4@fd240000 {
+		compatible = "cdns,sierra-phy-t0";
+		reg = <0x0 0xfd240000 0x0 0x40000>;
+		reg-names = "reg";
+		resets = <&phyrst 0>, <&phyrst 1>,<&phyrst 2>,<&phyrst 4>;
+		reset-names = "sierra_reset","sierra_apb","pcie_phy0",pcie_phy1;
+		clocks = <&phyclock>;
+		clock-names = "phy_clk";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pcie0_phy0: pcie-phy0@0 {
+				reg = <0>;
+				cdns,num-lanes = <2>;
+				#phy-cells = <0>;
+				cdns,phy-type = <PHY_TYPE_PCIE>;
+		};
+		pcie0_phy1: pcie-phy1@0 {
+				reg = <2>;
+				cdns,num-lanes = <1>;
+				#phy-cells = <0>;
+				cdns,phy-type = <PHY_TYPE_PCIE>;
+		};
+
-- 
1.9.0

