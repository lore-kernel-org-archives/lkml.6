Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10A1C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B88219DA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="xRKoAVKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B88219DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeGFHVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:21:32 -0400
Received: from mail-eopbgr710085.outbound.protection.outlook.com ([40.107.71.85]:35808
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753216AbeGFHVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmprZku8IAxuzfQCR2y+4VCJFCOq3VFsVxFd+MVe2NQ=;
 b=xRKoAVKAW+05kp+EcNm961qyIY8DvGHh5eyGkFf0kMgPnhlfXcrt4jb20vFWVknI9aPyoZ3NLpJjd9MEgqzXFpEZrCXtfNMnRm+wPK77oYDusNaA+9SPwL302xn5lgd0J8IDlPP1J9ee6AdMPhvP87zw1L4YyTZGRDhZ37vLQRk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2632.namprd03.prod.outlook.com (2603:10b6:903:75::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Fri, 6 Jul 2018 07:21:25 +0000
Date:   Fri, 6 Jul 2018 15:19:30 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Manjunath M B <Manjunath.MB@synopsys.com>
Subject: [PATCH v2 0/2] mmc: add SDHCI OF Synopsys DWC MSHC dirver
Message-ID: <20180706151930.78b3024b@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:404:42::22) To CY4PR03MB2632.namprd03.prod.outlook.com
 (2603:10b6:903:75::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a0a2cd8-1a42-45f0-71c0-08d5e31116a5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2632;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;3:nvKmYCA5mSFIBlM39trjdwTN61Grw7LvW+jzUoTLhLxGlgbI/UoX3rNKpjY6d1OjAsKhrmumtYQVWvOaWLDteN3xgO4iq8M9HAVm5md9f1pXDGp4JpQQWorM+JIK5oP0JZIfKslxo+G6vq11H8mwwfVrng+PWbG9c3KU8XKVfTDJJhOnXtLS8or8oeltc08lWhVWZ+qrO1XnEzUPFWz4Fb2qf55/EV+J/6bn3J73zwJ6vylOInGKKghazNDii7/L;25:jJolRsBU1Cu3DHKELtBsY/gCSipaZzjF0xarbxxuvqgCc8AfkyVAfXTz2aG7lVVOcv++setHWbkCufW+O01OSKhv0AZbVd+fQL6ZhPZow/m9JagGYBhTJNjIEpL20gONgl4GK4j0oYStd4s8Ry0bxS1Wa1ZIID46HT8eciIzm4oBG3og6NJXMtDFnwyLwc+bDgdSeFWTP0UHthvF7I8lDjGRph90aCGqfg+FLKG5ZMa5u41u/Wy09kEb2Q8fQF+aUQWQ+5Hu3aOvoObYsWo+YhperDV2b+E7eNsWFUztMp7dZOm2Xx8w+6Mk8u1VREFIAlWxqdnEPkVrtQbqjUIfFQ==;31:wOZql8EGNTOe81ZVoHJcTIMwiKCRFgY+xPwvaDWLzv6YsnU7IDZUqr+mRrtN2/NUDK97zoo5Wf+tqUZuH5xzvAdNlOpkJE+b6K1qMlw3AfibiZ8hMB+wLnpunwxCCQ0rubzPNcbaZmXs78/Cp1JZZBYz2PwYuaRwq8irYznGJJRda6S5ziij8wr0S4eQpXpgDW5WQyvrAtBocq7CUmfeFY3whlrlGx5PkXQL42irkSo=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2632:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;20:htUzAhg350WECfctOocSaRkfvl8ViKoBkdGdfpaKImyzYqvKl8loHmT9FIVEnb6b9Etj19e2kjzXQLhrt2/v2ARVzaOP2sLCzeoiEs8ZDg9muSN/nOiG2z3RCscnoIJ/cBVaMTbvJHqwLbAUj0GWXlPh+fDZ9e6yZN90N1j6uBsH+nPSzHzOXOKtn373U3j9bCYoofxhdNHWc+D7hXESax5sBLuQphYk5T0V/589XoasneXcop6plKXWP+4tyt5upY4P+G0h/IZaS8XBV9fS0CNhDESw+smxCHMef/ytuV3O6xVUKyNDy2ezIj4PNFY+RJ+zuzozFTuZq6O2pouGOAR1OmGXTG9D/6j60ndZdgIFcAkUZxfxZEhxRroPOwoZ6y5sYW4MvB7I4IEygMHSCYunV+EJiSWYlIufuofQpwNqNAR/jMNkDUz4UWDUeSp/PCy3jenuA8ob5B97oPk6KNEaFgcjoD0LVJkGtEbuU7K1E6CuBP20/kjGAHc+cKDB;4:RfwHiWfvgEqrHKIV3DY3vEUSV4hywvROj8RvSshd4XMcJVQ0ld9qXpxGLa9F04R7dCB1FbyxbXbKCof+qVDg6LmO9BXzAfHTJdw/rUeKXFyLsd1HJ1rh2cjAitRjQJo6Ctbk0Fp06rlRR/xLnnRHNCpja//r0ohGYAQqmbm76pJ9i8zdD7AcdevxQCsLqeBsqbkEQJNOmX46l4ylgWwcp9TZ9rSi2uz9ryyNYfh1VMBSJ8YT2WvGQ/WpaJI8RGa3Homes2TERh69VTbmUWe1WQ==
X-Microsoft-Antispam-PRVS: <CY4PR03MB26320591B3A142121068FC77ED470@CY4PR03MB2632.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2632;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2632;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(16526019)(186003)(6116002)(50466002)(97736004)(3846002)(23726003)(106356001)(230700001)(2906002)(53936002)(1076002)(105586002)(386003)(26005)(316002)(6506007)(52116002)(33896004)(7696005)(54906003)(110136005)(7416002)(72206003)(7736002)(305945005)(478600001)(68736007)(50226002)(86362001)(47776003)(5660300001)(8936002)(81166006)(81156014)(8676002)(55016002)(956004)(486006)(476003)(25786009)(66066001)(9686003)(4326008)(14444005)(6666003)(217873001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2632;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2632;23:381cY3odVcrqwizVRD5NQl7r279NoJ/i3zrVcZ6I/?=
 =?us-ascii?Q?2TatLc7uAo3W5acp68SGmgD08k7vJCjfL6VkPDN1vH1TQd+4xgEIXeU1CJvS?=
 =?us-ascii?Q?9n5Ec3tnDD4lJJWr8UlSLPp1RAWdPkLqCAMUSohVutjVlZoFKznI10uIkaU1?=
 =?us-ascii?Q?68eA98p23oz3L7pp259VSZiEYt4zNufvuF+G5IqjW1wJGx9RB9634ZNLaMeu?=
 =?us-ascii?Q?lLOCt+xQgwpP8CXxs92eFeT7cZTrFw3brrK4dsx26AaNlWznc+CFGUXD8ZOg?=
 =?us-ascii?Q?W2rNVYCFhrGAwnnSjU+JNDE7B1DKaCpmsxkUB2bqIToakCYpfTFn1N/9KCDX?=
 =?us-ascii?Q?tBOIzKREcqQM5eLsfDvxAcFKd6+QC2Q+XPitVTfIvMQR2EIU0siC3wWflxVj?=
 =?us-ascii?Q?dO4fm4VPp4NQOulcxyYsB0fgI9vsCLlSOu4OF5PUaqvShQ6u5ZdyR0Xw9Y6K?=
 =?us-ascii?Q?Edg7MS8Byw70YiZH14zDpPOrqgEKupoEbch18lKLRT2rRBumQJbK0FbcyoRP?=
 =?us-ascii?Q?L8j6Ozo8aaDjBuCzRsGWcJSKfQNV+Hkb7CQvD7LNhi6hkMy4MqY9lJx9sQUC?=
 =?us-ascii?Q?qzPektSi2drrVaDy/k/OhiDI8HS5V5Jm61sz9FW12HAcVpVC7StPvwj7mybQ?=
 =?us-ascii?Q?/Bew8cj9YcEMl2K3KUfZGzanbWUJVCGfp5TAS1nt4E/ihXhcUW9u3zabPzP4?=
 =?us-ascii?Q?weyKe/JNtREFjptvd/KaVRCOJ/5qRF4B7B92N9D1f4dy3Xf0uOZweP5sPuMh?=
 =?us-ascii?Q?wPPxcetKxX2YYhhXqGG9TzXQ5dWf1hKsq5YZqqepnL6kzEHRHObZuKB4LbrS?=
 =?us-ascii?Q?imEbEaO7WJ6znj/0pc8gco31o6dDWZDOj6mObMCWAH0oJZ6gIqB86+8Xfxvj?=
 =?us-ascii?Q?YiKhFVzV9PyZlZvNvCO7HkH8TikL6fWYZXnmA/2coeYQtXqj/oxNz/CZBfWX?=
 =?us-ascii?Q?pmufOUEMct5/0LkU1pO4Hi71Y8Rnlz+mFOesz09FTf1nx26sgHS8YROY2y7n?=
 =?us-ascii?Q?PaN1qNAQxhV2CN9H8SRdWG4WTWBgFCJuiyyHM4KZXJDx512zhS5G0+wQATjx?=
 =?us-ascii?Q?xgRcLQ5bkDLJLqmuJHVvvbovHEwE6SC0VGOCj+vcdK7zE11OHNtOY6TT1zHX?=
 =?us-ascii?Q?yrAASAIJL5SR76XWmns9d/XVU4XIp6CWfqXDW1jzoooL8MEwVOcawWwwMV+R?=
 =?us-ascii?Q?t5/ZF6aXoUmBYS+pfxZh723NQlNlzR6zccaUKL8Pxl7jOv/mW640PqjX7/oa?=
 =?us-ascii?Q?lPVlBcEYGc6fAY/TjU=3D?=
X-Microsoft-Antispam-Message-Info: qxuQDUshyJBPtghknLK6WCTIpeRhdhE8eeEW+B1fVAar8F9HBxXny0yuQhkcGZ18l9y78uRj1Eo5Ym7wX1nYFGU61Ci1Y74F5j6z+1aqQ7X8Kqh3APvBBjPqYsKKRODr8+XFuTX27UwlRDas3G/DD5XM/TzcyDBwq+pasZCR2/YJsuFE1S/NdAirAKLNP3+iHmi6EfjsT09NYIkaaTtM4b6NqBaMg5ETCX4ajnCY75XDVhZ/4KokfVmG5yAUc4l9RCFEZxcxq8vUQ/lndkrd/Wh0bRLZP8iNsHCDBXl+iB/uzhtQBA3jLcG9QTmWsPJ1ucpoDxT0z4vW73rLRHiYUeUD/GHz/k1aXW+wutQxFx8=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;6:DgoKaJW6Qn7n028E49bdDQ1GFuJYU7ds83OF/N3mxIQgXvXJNUUaRC9BfYw4TEuEhFtNe0SkNoOYn5BiVGUvr1TyAHxwDFFQflTyNYT+5OIlxGfNPC51yMec0VF0L49R9TzUitzdY4V2MHjxd//Txffb16LIaWMtbSw/G2yliE1skWuyC5L9dmyMdJV5A4rav2KL/u/Uqjrh7E7LEGeuQ192SOIGKcsooA80YJbijBs2M5LgTaZAr0ZVD3yAWsHP5cZEEieC6Or4abYL7cm3DBy3E4n1EZoAfRM7uNbiUq+ZJkDS+xt6w25TI6rPAAhic435UcXvKyq8c97tOhixxM9PzCbPwOSnn5lhMKgR05stbjBJz6DYrnrTfN3I5J1i8xXO8If7aEGzK2TRbBV9Mr2caVpLzlfCuCyFuyS84W4RTkW7uioxbYkNcPXmMcNKgXAGb+W3wSd1TKkvKjJAvw==;5:gujXU3nf5L8qXeXZYiuoTRhv/lS6XIM+pfv9xC4o/tTnukabglX7O9OvXKbS1I9OGmG0YeKQqVVSE7URv07WGNyFtbZi+viElHtQTc97tWGM5dKAfaNpu+8XnpmZ6X9jT4iwx/tfNPAXdleNWBeZHISh6/2SGf4R6sAjQTyfP18=;24:qJb4zLCHJVToTSIrxhD0Scwjkh1xehLjTrSPu38dFUHrwteKNwzo6nInvorptKJ4prMgWUo/T5/nEVrxJ4zkprjqco8gWEo18K72sezoXlY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;7:em2ry6n4jNHS3GKqs+QEgeK7dDYicyeBwfWv6zobVj9KZxOQr4uL1UDH+NUApdaqCPK5rpEkRLb3ndMNfd+wUjrjsa5g5V1dW9jnf2Lv4O23Y5QVbvoLcJLFz72F28oOxwPgYTgKmDnKu4agYVGKBYho+KMMyRZGWWDJ9JKB7VUcLsQWjgzl+ReRQhyX49KlFO5z04askNp5Jd4ZMEww7NENueJcQ+F8BDc/B76fk7lFd/ItBf8h0VI+kR7pFdOY
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 07:21:25.1993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0a2cd8-1a42-45f0-71c0-08d5e31116a5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Synopsys SDHCI compatible DesignWare Cores Mobile
Storage Host Controller which can support eMMC/SD/SDIO.

Since v1:
  - move the dt bindings into a separate patch

Jisheng Zhang (2):
  dt: bindings: Add bindings for SDHCI Synopsys DWC MSHC
  mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC dirver

 .../bindings/mmc/sdhci-of-dwcmshc.txt         |  20 +++
 drivers/mmc/host/Kconfig                      |  11 ++
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 116 ++++++++++++++++++
 4 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
 create mode 100644 drivers/mmc/host/sdhci-of-dwcmshc.c

-- 
2.18.0

