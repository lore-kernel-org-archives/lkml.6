Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8C5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E9C2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="mp6fg3eD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E9C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeHQPe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:34:57 -0400
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:37343
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726478AbeHQPe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgXXh8BEG2mQ09zzfL4EhFalcNoo/gAhP3vOcGUe9Gs=;
 b=mp6fg3eDFMN8ogGLqYx1x8tNsuJHOEjxKJKeTSzCtzbkFpUeRXOWRep2zQsBGpDqkhgEZKdo2PLCcC/gnc+yjl7ZzUfRivUhkI/xFiwK3SG0sBYskqq+YOxvaAyiTg/qGdEFFl1+YBOu2R8S/B1ZBcnEzOQFmbyAqTGy7RydlHM=
Received: from DM6PR07CA0009.namprd07.prod.outlook.com (2603:10b6:5:94::22) by
 CY1PR07MB2297.namprd07.prod.outlook.com (2a01:111:e400:c5b3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Fri, 17 Aug
 2018 12:31:38 +0000
Received: from CO1NAM05FT056.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::209) by DM6PR07CA0009.outlook.office365.com
 (2603:10b6:5:94::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Fri, 17 Aug 2018 12:31:37 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT056.mail.protection.outlook.com (10.152.96.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1080.6 via Frontend Transport; Fri, 17 Aug 2018 12:31:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w7HCVZDq002417
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 17 Aug 2018 05:31:36 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Aug 2018 14:31:26 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 17 Aug 2018 14:31:26 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w7HCVDMb012680;
        Fri, 17 Aug 2018 13:31:13 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w7HCVCZs012665;
        Fri, 17 Aug 2018 13:31:12 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>
CC:     <stelford@cadence.com>, Alan Douglas <adouglas@cadence.com>
Subject: [RFC PATCH 0/2] phy: cadence: Add driver and dt-bindings for Sierra PHY
Date:   Fri, 17 Aug 2018 13:31:08 +0100
Message-ID: <1534509068-12515-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(376002)(136003)(2980300002)(36092001)(199004)(189003)(51416003)(16586007)(54906003)(110136005)(42186006)(316002)(8676002)(246002)(47776003)(217873002)(5660300001)(6666003)(478600001)(4326008)(26826003)(87636003)(107886003)(2906002)(48376002)(50466002)(50226002)(86362001)(8936002)(105596002)(106466001)(6346003)(36756003)(356003)(7636002)(26005)(336012)(486006)(126002)(186003)(305945005)(426003)(476003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2297;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT056;1:xw9cWlZS6AmwaLdtYd+HwRyV4eRy7HSKKpAS5rm1zyF10EcgQO565Wuzpu8aezCyohhzDfXjM8K8BQ8lStG1btxEOwxATGS8CJ14WK/e1Ykm3aOJ0g20S0tkc2yj6VOt
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2a4a7fb-e877-4581-7bb4-08d6043d6064
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:CY1PR07MB2297;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2297;3:hSjegqRHE1oIxS6zeoV93Izil4ObUDUPwU6kyCWE/gUPY95Kv0uTCEtUsf9DetRsOH1xxYjMeLe4/mDpSFDIpGhpVzLtXYcGLbFky4eWv6z5XTU3s7CEFILvik09nQuagtExdz7yaBsidDFba8fDffnCkl5kA83S4DrVErhRbPc/LRbjpnbTeIO7R2eAWK9CAj94u3FTi9dDpb16TISE2ATqr2XkSMYEMcdcHFhWNpaS5lrbWvCFxN8fc4NeN3dnRGbMhTJqFIjZgN0zicN3nXzHVMiePkGuYz86Q4D9bns7kOAvGccLNxYL+frKjAeBDYdjp4GlyJpoaN+sfrz1NE0Le2JVV33GLA5JdOvkJq8=;25:6tX25wH5jDng/eeD2eJTOgS8mX15yVyJA252Wwh5TjhcZOzPkcEczxH/zOdqd4fA8F+9wS3rAh6nTaOcbQB6OuzTaNHqozhEHkXne5A5FuyFgG7ECPeM0p6arJYIL3G9G488gL5fNDDHscANr/58/w7EQhcu6IVMlxx8KPkBXE49e5JD4vokWPPgFPwr8sjmad13fGYQRqili7+2KxKIM5F0VA6+HWEPMY0KEWL9UT1ZzMrxapB07ym2JJCU5vwv4ZSvMG/HBwrqNIc2Ck+wZN+wYwC1jB4gNAy0RWLzDZ/ZCPymV6y9new9oW/tO/C0I8E1+4JbeqQBV0gst3h3ww==
X-MS-TrafficTypeDiagnostic: CY1PR07MB2297:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2297;31:5ZU2L93dtatbeJ0PFMCemZlrzrvk0izEiiGIr29cA5iaEW5ggVPqHq2V9H9eEpNrZJv5F+nY+U3lEScZRBDf2uipLsDN9g92Ci9iLDPKzMI0vQXDQtb64BY+EE+Jhu+fFS5Q0d/OyVEA9lnJt/Q/GEgxPSixYzlNmpJq5hbW6IXnIyUZ3xuvYHYFDX9adhIrT615l/jrmIUvCVRqDU9UU0J5hz2+nwZQQdz54R4q2Uc=;20:s8oyC+mbZsJA5wMUMCxpc9LNdkKD2zRaKAVv3GW+G61ihgpieK90csvORChbrw8PGWY4qHeJjJgXM4jKqL884XWEksZLZMok+X+dveFRGdtpfxZ363C46EiOqq+r4iIuWPH9LMOjI2Y2xU2mKQ3iV02mfPo/3YyTfaLdEKpuDCWmf1KxPK0RXlBgecJ8nPB0qDtCxzxR2W7mNynz0hd2KU7WmUYquZnXFwVnwPhAZ+sCscAJLRhSLvp4397F7ar/VtLkxxB69/P/sGTdj4OojrJM9x2StlF2FAxBsJqQT2hfYMKC3oTKIYOz+WXj3c6CX3edC62eAYB31EZrpXLAa8K5cOMbwTiU4nZjAXMoSyerJEg4tASuUB+IeFyg5mE19GQeb/XcY/1LrdVsVcvS9emjGBlNo+yZYXqKvP7QYTHvkAKd2hvM4IJrq++PIg2Ac7XBHj8LntGAACcqp/VrI+NOy8MgBWVHDj59VkazAVq8b6r/oO5jEQpFfK4hsjEA
X-Microsoft-Antispam-PRVS: <CY1PR07MB22979BD5852115A33C23CB74D83D0@CY1PR07MB2297.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93003095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:CY1PR07MB2297;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2297;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2297;4:lsUzlMh5F6hfko42wCoqBfeaqi+9X5Zv4fbj5pdfc2BIeIN8ee2pEV1fu+OxJ6UqFY3ySMTLh/4EDjKWwZ6xmLQQNgViFy5YTb/VodCbNYduEKKntdgAZ2nkQcuTHrAdfuSxMtYTDjsF579oq4kQpXZUCu1lhRfQz/0CnaEMVnEo9yiJ3IWaxzYzHxYUahyuy+UFkd4tOrrKn9fUdt73IC0ikAttOP4e7d9pEUr/95aJaHBXGmaROiW5xcUxYa9h1g1T/N5fp+YPx5wi5HQWUA==
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2297;23:3aQHjPNdAS0FG0GutDnhVhxxVB9cndz8+GW0IQWz0?=
 =?us-ascii?Q?aODsRbW2szjyPNH82h9bsxpO/JtF8jbqdPx4VP7qzjp8iekX9E7PU2JJxS2S?=
 =?us-ascii?Q?hkif9/JhhunayHSsAtGo6KUGLaJwG/VD5WNcNygF2fsVtEHaaPpxxHfoloCL?=
 =?us-ascii?Q?ce7WS4bD5IXBjv0utmkUu/61MfeJGABR+n8dTNXPNCdjaIiKWYkdbiB7/f8R?=
 =?us-ascii?Q?a1SbjRbvKD61j0UKN9zCw/8sC07pMzIXXWckKAeUNmMTjQU46sDoY+kkOxLh?=
 =?us-ascii?Q?d9xMEIFn2G23VGRB7+vuNlH6DxVvGqTJTyX9UUkX0NCEUH4u6js+Kkj99EbA?=
 =?us-ascii?Q?b3WP3xAriotoaHrw6J/ZJFKhKSmED1fmADDythUw6vudHiHb8ZX9J0f/vh/m?=
 =?us-ascii?Q?4iwZY+HYKPCXk/iGmUM51yg1G+mSqgU33Dt6keDqEtuozr4963jHAn7vAYzU?=
 =?us-ascii?Q?vqykUJCOZPGXGl3K+fZYVqtUOM67El7xP2sW4FBGiR7M18nZMcRLmGEJrNby?=
 =?us-ascii?Q?YDEHUgkPNmW+dYjiJF8QG27ki7fE/JiKsgoGwRluMqqiTEKeMn7JY1QOWX4s?=
 =?us-ascii?Q?3wg6sn665nKZguLSutQH/MJciWoiEvUtCjoc4juM2AIenjKlOSQ73v19Mtzb?=
 =?us-ascii?Q?7sZzf7J/InQgX4alO274FLdS8QhPeHGLA7Nd5s/cnxsKJU+EZzZ7jvzAo6Kh?=
 =?us-ascii?Q?ugzYLu5IKp1y7iRlZ5hg4lpcqw8n3LVr7/RIyuHIdYYpAnsp43r0UAhhsK8d?=
 =?us-ascii?Q?67kpxmqSXCbgkJmGTc4t3qP59b3vA8lyMaWvKLFo7/gyotPWP9GtaxTwzMsv?=
 =?us-ascii?Q?MWGqiKVFaBpVki69UxrqIpkwxP4vjJ5rfHeGeGY9MT8ozixrR1tJuWRUf6Ah?=
 =?us-ascii?Q?onShKXVHwBEkZUf9HsbewOO8dEZys54GmcqQ/pT2HJOG3cW+9csaKe7nmWLR?=
 =?us-ascii?Q?nd1TYtZ9PXZbGCHyMV3t/60Df6scmB7cs91twgV0Gi4HFNMQkNjpuh5SlN7b?=
 =?us-ascii?Q?lk3DulPyYyhGsiSqEA0QacOt+AbOd9J7RvK4btXhXEZgseFkdoTdUKmu6aq8?=
 =?us-ascii?Q?1661a8=3D?=
X-Microsoft-Antispam-Message-Info: EOFR1R61OfMeZcEXM6XLD6vusgIH2jXaMEPYybEpkTjMq5McwxZib6Zfezyet1KWiuFqT+K2AB4iYF/9q5prRPCe39MWbcYAaUNw5lo+Pfq6gj3N/EFqYTypleDHNdsX7HnSCL1Ahvm6zVpZUg8jnfrt23O66KekmeAaKseuUiCGZaUU1jePfFI9YP9XYEPrVTpfBXQDVdA1d22+fS3bgkvrePwnFeFd5b4aEgUB69ucAVo2j/GXgA6FsoBC+PkSaIh3LmO4J+cbGJhMONxLwgw/yW64lmgM10G46wJBxa2nXDdtTyRj2g8rFeJfHWsRPePwWdZzT9oDgVtq/rnH1n60oeNp8P3krZ//U8NZMwTOveSfhbpJ9feYgyBsPlRvFiE3FBwjyWxhkLfGifhbeg==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2297;6:Fg5zdfJTrYesrNlDVnAiF8CgSz+QFMpWB5O55MEWPEIZHPYKmHVNDmPE9a2hOMI5sA/gDesfkbJYtqgUHhK3ZLezTCjX9YCCx72wI0OMRen1nsd04B6W0UM86Lov8r4nuSVF6+f4Vbr/uDasTGB3Bsn/Kbbrh+N/tlNnULpYqG58xK+gMvP39mqt4UM80zJZOaLEp/dNr4LALi3VSqH4oFytobCXmBlXo3V51iZXJw9ir0wg0DGA7oALUGSv3RFFjM5xFlaTptxVLsc1/OoI9pfUB+l9YHVROUUfzSUvjGIt66xO9ew03aPpY5i3ALzgDgMdTPh5dQM/y2RLjE+wP2iPhN6E6PIEc19c687QsIjLRlZ4V2okU0P+YrtzZeHMiIIObBtITOCPLN8G98pMZtX+w0MhUFaVFeNo/ZhMTuO+33KEv9cuPQhq6JRPj9cfOwfQWz8YzM8rtaASgcLdvA==;5:urIY6dJ2yAnyKCiuD9kQ345V2eA2PlkjBugfavtk+h8D3Ilw44en34e5KEFJYHS5+UQTCqbyiEC/KOS9CPkFXdL53I+yRbCLoXgo7YLafOC8iyPF7V8xO5um6NGUFfrJ8M05D+0d3l3detY3cWZ+dZ7xOGgVXzntRNqUBNLT2Ow=;7:3KPb5rEu6t2UxBMcRb/Z+A73vbo7qzpVQQNwBdx93Lrd/MyWqjPmp0FP97AvlYUkKFDWNHvrNgnb6723Q1Ln7pn8NT9BoXcZsX3G5FTQFcxkvkHuekFCdIXVPjuukjkfvh3Y9fCl1Yz5HuIQkeZxk95g2khXGwm6OCX2nsUHYCIHeDj6TZOtN1lZ7JjKux17fH7GUzeGlKh9Ya510bImR3UF7ld886rs13EPYBqGISytGvOQfQCCrlIs0o++NTeM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2297;20:SEKYr5xE9JDsABZFqN44InKxr46L7uc+iAVi92S/gTH9sr+ZBOKUJ1Vm3fWJY+k5CevPE5D7wxki05EYVqROENTxLaXgQfwH4m9iXLyfm39Iqn91928t36j9yADsL+YqtIz4XSwT0USUASCjVf1blP9iqnlU26ruScwczX2ZbDyGljDN8gLEkrkWVkLKh3z0t6Xweq6MVDZqyUHOQxatyCh5GBm7KHdraYhKHiJvz6PO/UWwwPK7EN8YTLzeXeaM
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 12:31:37.4811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a4a7fb-e877-4581-7bb4-08d6043d6064
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2297
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sierra PHY supports a number of different protocol.  This series adds
a driver with support for USB3 and PCIe modes.

Two phy-cells are required in device tree bindings, one to specify the
protocol to be supported, and the second to specify the number of lanes.

Only one clock frequency is currently supported, so the value of clock
provided in device tree is ignored.

Alan Douglas (2):
  dt-bindings: phy: Document cadence Sierra PHY bindings
  phy: cadence: Add driver for Sierra PHY

 .../devicetree/bindings/phy/cdns-sierra-phy.txt    |  29 ++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/cadence/Kconfig                        |   9 +
 drivers/phy/cadence/Makefile                       |   3 +
 drivers/phy/cadence/cdns-sierra.c                  | 326 +++++++++++++++++++++
 6 files changed, 369 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/cdns-sierra.c

-- 
1.9.0

