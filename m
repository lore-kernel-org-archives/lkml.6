Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA4CC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476F721471
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3sj5uF0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476F721471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeIMApY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:45:24 -0400
Received: from mail-sn1nam02on0060.outbound.protection.outlook.com ([104.47.36.60]:30976
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728071AbeIMApX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1v2xIennYv0MKNZqVnA15HYc6fpx+KcsVLFplx5O1U=;
 b=3sj5uF0mlwNxxTTI7c9bm5YY6h6gzmkpDtKVA08jMOXVnHMkbLxRtvbwl0elUQw21Y5udHDbpKyv4BEgyuxQldoAoHRUobPoQ6YJkgdhsxlYsWvjxAR8hm2p9F55guQsN28ivWVnYBWsenBmOjIXi3Hu7Tvqm/n7bgYeaTBivuo=
Received: from SN4PR0201CA0013.namprd02.prod.outlook.com
 (2603:10b6:803:2b::23) by BN7PR02MB5107.namprd02.prod.outlook.com
 (2603:10b6:408:22::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.17; Wed, 12 Sep
 2018 19:39:15 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by SN4PR0201CA0013.outlook.office365.com
 (2603:10b6:803:2b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.16 via Frontend
 Transport; Wed, 12 Sep 2018 19:39:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Wed, 12 Sep 2018 19:39:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:36130 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayo-0007VL-Co; Wed, 12 Sep 2018 12:39:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayj-0001JA-9R; Wed, 12 Sep 2018 12:39:09 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8CJcwIF003379;
        Wed, 12 Sep 2018 12:38:58 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g0AyY-0001Go-Gb; Wed, 12 Sep 2018 12:38:58 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <michal.simek@xilinx.com>, <arm@kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v12 0/6] drivers: Introduce firmware driver for ZynqMP core
Date:   Wed, 12 Sep 2018 12:38:34 -0700
Message-ID: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(106002)(316002)(16586007)(54906003)(110136005)(72206003)(966005)(478600001)(7696005)(51416003)(63266004)(50226002)(106466001)(36756003)(8936002)(9786002)(476003)(36386004)(44832011)(81156014)(305945005)(2906002)(2201001)(81166006)(2616005)(50466002)(126002)(426003)(336012)(6666003)(5660300001)(486006)(48376002)(186003)(4326008)(107886003)(26005)(356003)(77096007)(8676002)(6306002)(47776003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5107;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT025;1:nAKrmXlQQnvf7P+IBDvRXwy/UtczoZ4Gpx7//9CNzEY/ptAEsgqFo9hZ1Pikj4z66sf4x45pAGxUKM0I6bdDJd+LloUMo7CYNu7tByCl/ZFNh0dg5DY69l3YPTpUZz7q
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79a9935d-e188-4039-8420-08d618e76c4d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5107;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;3:iPkLmWR48XBm1lT1QkkzFlJUhfln6uiPgeEl/izoU82CILGm/+0if6ZuUWKLurcsTVOgStXV4o49xT38PdO6/vPg4uix97FrhmuDUTB2A+KRY6S7l5hvTt+SkY2Xqjrjg46UTJFuhK1mVRYzLQp7BAgM+6rGm6NL4Gi187WqJd9Rd6viNWa4dR6dXTTaGPlfheIljFagXpthGdA3OHOxV/JX3/ijsHG/atIEobyaguJ0Yf+vU+LTPx1mHOovYkGz/lmxWHyNgEbhCY/7amOlk1Xt0C3DgeibjSP0gvot0kcz6C+L/5kJ4uhtdo4oJ3bi/Uh5ZPzNcI/XN0ynJ+V6Eecb/a8y/CR6vzd5FyEmNcI=;25:WRXbTTxrv1y1LVao/FN7Ow2/vnOt6ZOO2axA4Szc3AD94wFGyL8fO7JHBU+nlZLB9/SUNxRdahI9LZORuEoeRhz+x9SE7OU5ogisJP7VvXjY1ivTG3gkarf7KUhfxeVppCzXST4khIAtYIfc6GyyK9oxeKRaLLlvI8LifENPi9hwugcV7S9s+oJrtVP1geVvEFB0ewFwYgENav4qiUMsAt/OZEKEk/z0Dm0MEr2sIwpZcUF5Mc3FnSNtN64Zx+XcTv+1U47gBoVbCV9hIFQcFIhwSmUEKD1ANeIhSYlshNfntSXnWI0Oc5VOS01I03ohn8a1fSmD6y1NmJJYc9xpmQ==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5107:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;31:MLKPoH9Q5GHIezfkwYDVuykbQEHdgKy5H5mGRJykoEs2/fjDPlgFhIdeXMMlucPIOB1uFujgKZiWgUKbKxvyDGZEjPCO1hKvbrimMboEb6nnq6kfxY4fCdJfU447rvo3hxgYC3J+xu1hCa9QSIqgRojIPKaki9aGgpwOV+xBORZzdnKcvo4qzAKqQYuTXiU9UyOy3yOFZW7rE6gNUN5gDnjEOUNGWjaMqxceEDKfBRo=;20:YZ060BMJNuOKWxyPgu5GPbLOhJqT/nvimolBQy4PxqKD1HFDAgGczKvNwlYdZ/xayX44/DubsIFQ/SnXrK6c4LUAWGYp7gys/aaTdjTKM0HWZU6wFSgdwe5VRK2MBCOpXF2oncNMS76U318BjTtd4iyGUWlaBEXTS/aGB/JyRYg3ilMlV3qZiCsJNF3tZ/Y+YbyF4NqobdmB1EeE4FEdHYIla3GbEZoTILP5rUh7O9mguJAKOTJ1GKW6MIyIlIsngx5OlRMnah62OGU0VbXwuyKCtS+nqhTrSfydj69FxI8wPoC6GT+2WzciwmxxJx2MBONp/AbamrdRsm4LbPiftE9Yf18a2Uxh3Gvp8S/BDbMXOGp3H+HuzLLbfAp4T4pQWvQ1ueV8lEhUKg+Q+k9jV4V9b3LZa8hP9GAOh3rxCD2gOa6ytbhadi/3911MU74bz0cb55JlJSzzJZxhCw+IOhjouhrgO++fEyzCsQ/wWm+DjOkJ/w/FT/QlBn/ojOv0
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB51078D0D66B9A6597F8D2645B81B0@BN7PR02MB5107.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699050);SRVR:BN7PR02MB5107;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5107;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;4:kojjIytqd7TlrlA3r7bYa9mqvVjbQNf2rwTxaI1cQNx7d3RqE4sxkKVBQDfyZ1q1mvFq+DdzzCLQrjjyUKk8XVS4ijP6iJeEuYSOl+AXOXc43vKAtWkfoRKwsrupqEZKiOvk4rXYW2H7pJYeGi5PZpP8uRB7reYY28tqoMQ0WbcCZtMRsqacm7ZgcD4r+JHX3nbI6xS2wPjoo/ni+I6kjcrbiTOZ+BFLgyn3Z0KU8MlNl835Q7kQaRdP/JnFYgFFXLJv0ESbzHMudaTEZQ0gfg==
X-Forefront-PRVS: 07935ACF08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5107;23:kiuodrEaIKODKyTkuO1B3DIQEKdPufM4w/RaRJ6Ei?=
 =?us-ascii?Q?TCuTGLx68NhHd9tTuJSHCoCGSDwTk2XHXSd3XDf2YS6XyFwnCNLoc0UZMnmo?=
 =?us-ascii?Q?A/k8PYQU6NIaSSKQP8V4kf86el4NmCmCBoVZ+16ekx9QwgQ85QV+ErkgYsce?=
 =?us-ascii?Q?nj2rBgvaIcXYLkwBgz4jBpnvb6oY7F8fIVVMnPAF+FWm4zgUCSY4Qn3eyiN4?=
 =?us-ascii?Q?ei/7jrzS4zhCAYAXnsnrwdy9ckg/+MUldhhjJQI+hkWOiM7SY4a/AvS/aDpA?=
 =?us-ascii?Q?hkX+hRncCcRgR4M6f2KVh8+EVokrf+2Jx1zUrXAzCO7p12WSqRED7tnNwnJ0?=
 =?us-ascii?Q?JuEzRv+8VXxQizni0lxtiVJGdS0iHyzpy2zJvyk+jsxVHLa3bwyUt5+LByCZ?=
 =?us-ascii?Q?1RfCKEcQvQfe+7PyxL+pLc29zKPigUIA6DOeEeqAZl/E8NGZAlIds0zjVn2E?=
 =?us-ascii?Q?WTAPyEYiH+z39RQdZcAQamd3VZVIg+PqOJy0ycS+A9IqYG3vfC08GXcAoAFr?=
 =?us-ascii?Q?guyV9rovYvneN8lNYTkE5hWvyfWqeHpDrTFlVn/Qbr2+qEAqKS+N4IphUgFT?=
 =?us-ascii?Q?pioUqfU8esqLIutlXhU/TfNWCf8VRXP6SZjmZXl0yiCh+Gh6HxfSKue/2AwM?=
 =?us-ascii?Q?oKnzGZmUk79fZgv+QAKSIoGynDum1l564fgFtJBExiqkTcZfDyZqLTujNJYy?=
 =?us-ascii?Q?2cKw2IiR4Ec0+1ClUTUBsb7plnk/nfQWj54+vIXjgoe8ZoPmk6KBDoU/Ydt2?=
 =?us-ascii?Q?hoyy5HUVaDSizpmYSYwGyagilVELs4GfRD2VwX2O5Ovp6VT1k0SdjlYIa1wr?=
 =?us-ascii?Q?KbKbUhFabp9e1HMJjAsuJHEKMiYGCjcv9rRgyNJcR71Uci1SMHWexFh/qryW?=
 =?us-ascii?Q?5akrQjVsl7GlciGV9jn43yzuAyPTNVG9/iDgggXm7y1UXdqFOIuq0fQMq3LF?=
 =?us-ascii?Q?jsazDnrO5ZGGGzLZUgISTI39cd+b9sIK2KpPieBvPSbgdEyd9L+0nx+9Ci3r?=
 =?us-ascii?Q?WnotEyCFFt6mxXNEKb7vohOucad+9hgR0KLBy2EL+6lJbjawP52qZrysEZa6?=
 =?us-ascii?Q?bufYmKQM4PMA/9lt8lzVze1AyJEdvxuqp4soYqGoXV/BFPOOb2/qvo7nfOq3?=
 =?us-ascii?Q?9ZMy+PwO7voYwR0d205hCNEImW5D4ns0IAm8oGR7ZxCOGbzRvTJBL2bo5lFH?=
 =?us-ascii?Q?UAoA41w/ENW4WM=3D?=
X-Microsoft-Antispam-Message-Info: 8ySA0pk5qcxinJJ3+ILD7QEu50aRQBfmPk+z78SI/pw9OTuCKy5YQz19iEkEfbDWO3Hpl+IT19WjITCk8beEHM7mzsbClaZWdVUUA9eBE6oL/2hSeuBLMqStGDyPMKOW1Sr/C7X3yzUqOr+nDYm8ZUPwu2ts/4kFzKy9poUV0zXGDizrIjCl5QXUK+SWUh1gFIsjUC4p7BKLt2lM57Y3lNvWm1H9cblDf1SUAGmI99laJdN8vWuipHp2oW7AtRzP8c8Dd0VKCSaVzIU6j6f5T/mKKSfhrLPGIryORMsXhG7puJUEqJaPQxYY9paJgGpDVUw9wj9rTP7Qn6eugjcPDaGV5sFRRqzQTHw4h44OIfE=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;6:+wsjStFbXTP/stqt7C7Ke02eDsCRnHq/V4XrSWFFvVyYzluofhu9ajHKDlz2DRgh9cXdnppfL/UqdtnvfErsDf6yo3qURv9TmYQmK5PiuP1SnyHCu7uSCDZqnhOf+7fx8kCrwf/VTBEFBWceN/iOGR0I242zwZARunmHlCxR6whrU7dRATTc8TDEdcZy8u2ltLySFfepZokvZoVzBpP2D2kSY30DuFyPu9ruJJsp1wxNEWLbfs0iwPCPKzy558sf/LvvsiXiK3Ti0XEczxDul1Hjf4gzat/onRUaWMai1aa6Uuon5OzrW2Jwyldhf3KlvKfQi/0gwsbShtlCavd4u4CA7LknMYGRYCK7qTHZSbv2unfMIOKvv6pxZK2e3ylIeHzTBtZm+dCUiHVw0OWLrvGEU4ufwGrsSWDZaqkMH/7QTPZ+k/3ahh5E5eoDsLg0D7ny9xIOxbrSy3QUl7iOqg==;5:39RSxpz0gPwsSg1x3t4fovjRAMqLIeWpx1gt1GuLGNj+fkcVokG3UCsbmRza1ijfQiGcu+bD7K5gdx4PvrIjHLdLoBt6EJZUiSISlaBHXnXBlJxS8VYbP/WCE+Fkm5KWUKnSOwuHRk8NrNjsMM2wXFHDLwvEjYRkCoexNvWJ+r0=;7:z+DsNKV4v9ea6sSt+vQHyoRW8huCTKQCBEz7+graQbEnCkyVVINGDHd10Wc2FdtO81Nvp6/PC0Bw/J4oAwJ8bCT6QmfDyq6bGnH3UcASNU8kbU9lBfHccDTlha27rHP30A70svr8DRzYwpXybUUlMbBwvMxnrJmEDKWnEYJtVDKWqsZcwpUJDCXIFsfdrQRjn5AnEeQ+vnl2w2G+b8qKgv5D/I7y8fhJrqcO6D9Qo7zFnzFCVjBE6fSpFXW8g52+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 19:39:15.0378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a9935d-e188-4039-8420-08d618e76c4d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware driver enables APU to communicate to PMUFW(Platform Management Unit) via ATF by 
using SMC instructions. This patchset is adding support for base firmware driver with query 
and clock control APIs. More API support will be added with incremental patchsets along with 
their user driver.

v12:
 - Removed clock driver patches from set
 - Removed ioctl api support
 - Incorporated minor review comments from v11 patch series

v11:
 - Removed "Reveiwed-by:Stephen Boyd" tag from firmware binding
 - Updated clock and firmware driver to use probe method instead of init
 - Marked PMU payload arguments with __le32 for proper endienness code
 
v10:
 - Incorporated code review comments from v9 patch series. Discussed below:
	https://patchwork.kernel.org/patch/10478575/
	https://patchwork.kernel.org/patch/10478457/
	https://patchwork.kernel.org/patch/10478461/
	https://patchwork.kernel.org/patch/10478463/
	
v9:
 - Fixed minor typo comments

v8:
 - Corrected typo in clk Kconfig
 
v7:
 - Removed xilinx specific clock debugfs API support
 - Added reviewed-by tags for FW and clock bindings
 - Updated clock node name to clock-controller

v6:
 - Broke patch series to have base FW driver and Clock driver user
 - Incorporated code review comments from last FW and Clock driver patch series. Discussed below:
	https://patchwork.kernel.org/patch/10230759/
	https://patchwork.kernel.org/patch/10250047/

v5:
 - Added ATF version check support
 - Updated some functions to be static 
 - Minor function name corrections

v4:
 - Changed clock setrate/getrate API prototype to support 64 bit rate
 - Defined macros for get_node_status return values
 - Moved DT node as a child of firmware
 - Changed debugfs APIs to return data to debugfs buffer instead of dumping to kernel log
 - Minor changes to incorporate other review comments from v3 patch series

v3:
 - added some fixes to firmware-ggs.c
 - updated pinmux get/set function argument names to specify function id instead of node id
 - added new pinctrl query macros
 - incorporated review comments from v2 patch series

v2:
 - change SPDX-License-Identifier license text style
 - split patch into multiple patches
 - Updated copyrights
 - Added ABI documentation
 - incorporated logical review comments from previuos patch. Discussed below:
	https://patchwork.kernel.org/patch/10150665/

Rajan Vaja (6):
  dt-bindings: firmware: Add bindings for ZynqMP firmware
  firmware: xilinx: Add Zynqmp firmware driver
  firmware: xilinx: Add query data API
  firmware: xilinx: Add clock APIs
  firmware: xilinx: Add debugfs interface
  firmware: xilinx: Add debugfs for query data API

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  29 ++
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/xilinx/Kconfig                    |  23 +
 drivers/firmware/xilinx/Makefile                   |   5 +
 drivers/firmware/xilinx/zynqmp-debug.c             | 250 ++++++++++
 drivers/firmware/xilinx/zynqmp-debug.h             |  24 +
 drivers/firmware/xilinx/zynqmp.c                   | 523 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               | 113 +++++
 10 files changed, 970 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

-- 
2.7.4

