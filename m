Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BB5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CFE20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="oQqVWWiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CFE20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391130AbeGLCE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:04:26 -0400
Received: from mail-eopbgr730087.outbound.protection.outlook.com ([40.107.73.87]:10129
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbeGLCEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mmfj1XqGgc3IHKaZrHgv5QQ8kUMOdf7cHrYWlV9+ZiA=;
 b=oQqVWWiCGY5j2YjYO23CQ7fBTiqPY4ERhK/7xSnAmFfAVb8Xsy6NPX1hizRX1gGL+gcLKUuOCGJYrYw+dsnMrxGTmiPYI9WTE/WugvKMGuOvFl+rHu7zxClphx3u7CSrwJofjFPOmqf8iBtLl+T3YwtlyXq7pMVOGzdAo0Wcjcg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 MWHPR03MB2639.namprd03.prod.outlook.com (2603:10b6:300:46::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Thu, 12 Jul 2018 01:57:11 +0000
Date:   Thu, 12 Jul 2018 09:55:04 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180712095504.4d9583ce@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: MRXP264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::13) To MWHPR03MB2639.namprd03.prod.outlook.com
 (2603:10b6:300:46::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ded1bfd4-1327-4676-64e7-08d5e79aca2b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2639;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;3:tEEN2HXEHqB1uE5+R6KJgz8dElzPRP7dgWFTiJ25vyFCVNW0Je4KzRHBX4OKt2L2WyBNJIvAfkJTRFhsshjw1tJWMDrv+hDxL4P2ozNrQQxwCDUsm0h2naR0e5b0ytxb4oUBZi1smHsqCKbsaFFKUyiQuns1Qcv4HjNC0PC2IpU/XfvtBEW9cFc6qZpGIBDbclXFCXod1F22jORhjNv3qpjkDJDe4FZKO7Etkp6CWYaFBMmtxYr0JimMrF/S08k6;25:FDSMXzRpNtZM1CpZmrSP/AvSP+vProYU5dqoIWrz/EMUS6vcqHqmAcj9PRBVwrze9AdCFhUNLjeSuGrtjc8zM9J8TWMJGYbup+wTBdfMY1nawrmyRKDtLG+D8LXH9VXdF/uMWMLwhvjIMbNjVOAKTY3u2Fu950KtIuZNw3jDKtIbpWBEtGKjqtTSD22BUJeTpWQal6c8+afjy1EGZxFTt5res9P2Sdv+HpSAOV8vJiTy0s2Rgk8NIqXvIW3msn18gsfSrNNUFqzA4Lw8PBnzkKyORrd3NONdxTQM2U4lJhsHpNsR1T0Xo7W9Om7qvT1ZRAW3vcFR0tum0W4mYaICJw==;31:4a0jyHFWO93CkM4KnmyvlNBWaHQwv3iCGpFsoj1wX40z2QfqLjP7z3LDWAPjVQF9+7dLKyw2FxQgkm2JxE33hqRTrqa5GFh+673Gc7K8mF3JG35fZeJO76oJsRrWlNalkJ0x6sYtjvAqHPW95ta5Cu02yo/uJoIZzyuIH2O6rUTJOS5LZKzou8zedNqRBjQ2+eirgLReU/b1EwQGZK0vbzLlakPps5HRjRP8m9cULtw=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2639:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;20:tsHFUIit9+EskmyoK0cwtXIrYx1su+TsdwFClKeHBIHGWDVadbY0upv+6nXnxliVxr/eZgSxNiVfu0yX9p4X+iXJOLC04TGlxEEeaWDNVd5LcXi7cSLKN/pq6aEnQZA2mrTj7QP8iKFZZFRdIhK6wEy6aeHVUsW5KQRi0SokkTikuL241C9t9hs4ta8r8VWGNQ1LI+u9crFCvI9seZA0RGJqoZuMuoAJdoMqw7UGcxAm1miHNpDj+g/hZ6orZ40r2urIzvm71D/RyrVZYj3LrCUiiWEeJsb5BE3ndaAuBK+jnq5oSsNYkvjbnN6ZVN3cdOjLlLizkMRX+Ot93bgHaYVIY+8TFNp1anCouZQyKmD/3pBkdXWBJmVcgr3GOBz2iUDkxV2CgK1faTYmCu0RMbVhGSiKKFm7llc5JsKStTtiz9WI68VVspAfJM00wEwRMpS/LAMUT29lrZecdmI6AvwGwhjDSfxCnD4BrSAp/EJ5UgACQSf6Mo9G4qrgDQZI;4:NPVePEUW6QCP59brOo0N4NTu+Gc73uhijMLoAsFI5ydhsTiZfIn+3jrKw5N+xJhzrWTL8oKkbxaWWSGqXRmzYNRwAQKj10ySqdoxhlx9hBLeowK1uK+J4DKMoQ9qp9jHVp3FUUmzJ/iJ3Zmaqbf2Tw9RnMq04vF4PpbKG8jSbHLOKGx3B/c1VQDh+bLIh3W/Zl4VVGzVinjhDKCxJsyNLWXCnj/gwvtNkJAlD6rPL+8wUU1VlLjQg6mFejBKRYqYV7g5j/2Ae6HeJocTPIn5fA==
X-Microsoft-Antispam-PRVS: <MWHPR03MB2639FA01FEA06A38E752208DED590@MWHPR03MB2639.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB2639;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2639;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(366004)(346002)(396003)(189003)(199004)(55016002)(9686003)(4326008)(6666003)(386003)(6506007)(105586002)(186003)(66066001)(26005)(16526019)(53936002)(106356001)(230700001)(2906002)(52116002)(50226002)(5660300001)(7696005)(33896004)(86362001)(68736007)(486006)(956004)(476003)(110136005)(7736002)(316002)(305945005)(23726003)(8936002)(6116002)(1076002)(72206003)(81156014)(97736004)(3846002)(81166006)(50466002)(478600001)(47776003)(25786009)(8676002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2639;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2639;23:JxXFuWGfdU5vzRQZKEz6NpcPvVnhrg34NZapsR3H2?=
 =?us-ascii?Q?vE7bbmIEHqlDhlgjzpSrtRUb5y4XUEv6bIo7n2ApnKL/LDerxUwWSoCWKHdS?=
 =?us-ascii?Q?ZupX1cKxJq4hnEBAuQgOZXZZsm/asrmW19N2bOV5VT9gfgnCMYhKg8BUnNow?=
 =?us-ascii?Q?N/sq3gPZZHgZ0jWKKb6v54VPk5ovKDWqFgLU2NAQojvkr5saWd+tW6lwv8rH?=
 =?us-ascii?Q?ekPMgi+el7YX0VDDKBpTmzPqEjP1WShBhsTEyjy23632j670P2mTHYWzgaqI?=
 =?us-ascii?Q?FzEXV2YCOgyiXQ0yB3zs7vOVU8ytll2FHD0jlOXDptIzxtZC3di0BIGzOACK?=
 =?us-ascii?Q?+JVUh2kaQQ9mFEbfC4WvLQW/oyvZ81mngLWBd3F2AWkDBAH+avPA6gT7PD8g?=
 =?us-ascii?Q?EA4/ee+XdZc/UJL23OcbuDuWaWd9NqX5nhdcBvnVNCghCillj4WYyhbskxtd?=
 =?us-ascii?Q?N9zlJma3kluGBNgMy/zewLqoJoPagQVH7fvP81MkT+xcTms8yxJCYpeDu44m?=
 =?us-ascii?Q?mBRDBUz8px1s3OVgd8cKd/kom97NwYl2fPs4aa0RfJan+E7oU7HyClaweAQr?=
 =?us-ascii?Q?WYRZqXMAsurBJvWzb2bkPPzZ8uWXjO0cYjlhd0F4/bUzdFZdFq0c4kC2gpwH?=
 =?us-ascii?Q?aLTAyH2phvm1/7aCDRhqM7fFM0IgTQ6MawiWM2EwiI8kTlIS+OcHcu9N28go?=
 =?us-ascii?Q?0U/PX770uBcH7ndl8opwM1L8N8W7Tsfil5JQsVWwRu5m+XIIwQqJeT57FXdz?=
 =?us-ascii?Q?33460Rzo3FXYjV3x7YvFbq2BaCoC0oD5Aq/gKUy1qNjiF8VYiuvZKsMWRSWV?=
 =?us-ascii?Q?G06kicwydfb477UseJCpB4+RE2dH56zwhguRZST8MddXgDjsDVPGCYvX9HKP?=
 =?us-ascii?Q?CsgcghBLVA3cA3Euu4zAYaYYg0tkktlec7PKlzME8oubTUdnsbBO/rVeB3w1?=
 =?us-ascii?Q?OnyZB9HQCBF+9qDIqFlyGv8I0rpn30awePi8/ls+gYkBtpP7iUN6IZPskWfE?=
 =?us-ascii?Q?LSBIEvrZVD8g5C6NgLXR0+0mnHPXCZnKIbvapqPg6d5k42+vZhdvmJMmREPl?=
 =?us-ascii?Q?BriQkFTWhLKcytJ97aVbsBWme4SYgVMIgrJFqlWXS+ONq7kVhdMcsERO7SjL?=
 =?us-ascii?Q?kM3yZLMlw6GFQ+98sowHpUKlx4tcKSxLURxYkJ9nwb1qfUGngiy3A=3D=3D?=
X-Microsoft-Antispam-Message-Info: Ks+Vl3SlDHSCpCWRwXepiXMUpHFzp2PzS53/TdDXCZfFG8dK2KyrZtWvURBq5x0RQE9ejmxAteCrVh56uwsLCZgNvRDCUfjnBpxwwItz0kNeyKq7fctfogyIaRh5oAQZO1yxRCnZluZMwYQeDA3BWyMaxhUu/Wt4DovAzt2Ra2G4QvyIbPPpXjJ5jo5+kPMS6CUCfWqJ3COZ7aRJqdCGMFepXc4kqY5ZI/mv/pEyYnlTAxrqvyyvNZzDUaVou1clgpWJ/i9zZbvE0y7e51M9Jq0GvFCShjonGTmR/wQbxxE868UQ65CxZKDFlTdk7sV8bPPMKswPWkCAm2TIH3tzaYeEidaDYuc+JJRWWBdbAVs=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;6:ojO2yuAcB1VP8kW5reKHFSkAmjsh+7VdJsWZTsBu1JIgCPz8acg8b7895/J+FKSEJVb9qIgSvssaEKUN2DXeXBNd9/zwZCBho+a78jrnv+dxHdkW4UXV112H8aGexGDZm2qlW6OSYO4QP198zbu6Qx0PLYk5XNvq50gIjVq8xiJ1aJSCzq62+t5AdJ2BQokt9koGaVPLyOkbLWleeW8406y7N0WQ6GXsPXXmlpeKuwEjbJ1ByR2KumPPrdgqMu+0tmJwTmuvFFxhSOmXqGGkF4S3+7FtLLMDoizTnXZsAXUZeeYioHFzZHIw6m/4VxZftnGzQpXvdjnr7CrfNBaU1+yg1HyRG7tsz+h1Zzy6YU6iLqlXwvYOXpvszhf3P26sPn8ia7GTi/khB6w0LJT6y4SyujOXscsXva3tgfjnVh6wEhFzXjinHaWEIceoOa3CAKK/dsVuvznB3Olu3btM1g==;5:F/98KlEz86qvt/yzthRd+X6APu++vfkHARy6+FxSBNglgfAcGMHdDsZXYg/Gj3XZ02T27OhG0atdG6affcpzbzBBIdDNnEDdp855l9aJAhaokjITJjPrhtgINUSihHQZxoQZcSUAwdmLYcSBWkPLUUphR8OaxKX4k60bNhqeqlI=;24:qZjwWPd2rQYJ6FD1y9sJtO4qYPB+k4cEC2i9eRomin3cXXmNGGmztYXjvD9STo27kzML5Bx6//jS0SlQNP9Pzczyn0EOqZ3V72yfFBXENig=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;7:MFPps4gf4fU+107MXVyy1m9VuUrui2FjWcEE5t06ZNu106USXOeox5XnMcQRFjD23zVRJITJQHpF51UPUOyhSLRvJurTR8ufhBdRvReWbA+g8mUn5gaedZ+JEnI47NIj14mtxjh+uSw7t4KmiffriDx3X0wAJLI/NbQbViLyDIHrZHlmrRPW+XYTNX/5Y6Diqi9rrc9Ocv8PbI71zcPGtc3uRetdDH3mL8rIWCbTUHbXXtMVl7u5MH7t8tKXwZUp
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 01:57:11.4364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ded1bfd4-1327-4676-64e7-08d5e79aca2b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2639
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits.

patch1 introduces necessary hooks to 8250 core.
patch2 exports serial8250_do_set_divisor()
patch3 implements the fractional divisor support for Synopsys DW 8250.

Since v5:
 - Add Andy's Reviewed-by tag to all patches.

Since v4:
 - use tmp to save baud * 16 rather than calculate every time in
   dw8250_get_divisor()

Since v3:
 - simplify the dw8250_get_divisor() implementation again.

Since v2:
 - rebase to tty-next branch, since I need one patch from Andy which
   is in tty-next
 - drop the patch "serial: 8250: let serial8250_get_divisor() get
   uart_port * as param" since it's in tty-next now.
 - add a new patch to export serial8250_do_set_divisor(), and reuse it
   to complete dw8250_set_divisor().
 - remove DW 8250 version check, since the DLF register always exists
   and if fractional divisor isn't supported, the register read as 0
 - add comments to explain how dw8250_get_divisor() get quot and frac.
 - the frac calcuation is simplified with well implemented GENMASK
 - Add Andy's Reviewed-by tag to patch1.

Since v1:
 - add an extra patch to let serial8250_get_divisor() get uart_port *
   as param
 - take Andy's suggestions to "integrates hooks in the same way like
   it's done for the rest of 8250 ones". Many thanks to Andy.

Jisheng Zhang (3):
  serial: 8250: introduce get_divisor() and set_divisor() hook
  serial: 8250: export serial8250_do_set_divisor()
  serial: 8250_dw: add fractional divisor support

 drivers/tty/serial/8250/8250_core.c |  4 +++
 drivers/tty/serial/8250/8250_dw.c   | 45 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c | 30 +++++++++++++++----
 include/linux/serial_8250.h         |  3 ++
 include/linux/serial_core.h         |  7 +++++
 5 files changed, 84 insertions(+), 5 deletions(-)

-- 
2.18.0

