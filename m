Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86C8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BDD208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="l3F2MCEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BDD208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934113AbeGDJBE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:01:04 -0400
Received: from mail-co1nam03on0058.outbound.protection.outlook.com ([104.47.40.58]:42832
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932376AbeGDJBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JunQKGPmgto0BCtEumlYTfpXsjOLr8eNXsq3pDd/mEg=;
 b=l3F2MCELgVYE7wN6CmFqeRZ3NeYBOxToaeu9kuas3+6t3ne0xr0g1BhCHD2J1fETlwkt7D3Q1fsELqF7D0fgpxGVCxJ++CnGxlEIDutF+OYaFUoBiqNmUOpvzQyMZ4Uxp/5XLj/Ol7TCy3nxzZooKm1UtDHh7HYkBYCJHu+GAQ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2629.namprd03.prod.outlook.com (2603:10b6:903:75::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Wed, 4 Jul 2018 09:00:57 +0000
Date:   Wed, 4 Jul 2018 16:59:08 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180704165908.4bb8b090@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::13) To CY4PR03MB2629.namprd03.prod.outlook.com
 (2603:10b6:903:75::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 742d17a8-cefc-4fa4-5eca-08d5e18ca906
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2629;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;3:9ActPzd2ZX7QHJ4RnFdHdtMbMaXJnoDzU+T7soxduuAjCyqKyrfGHPd8Qd4yxQ/IaRONpK4F/OEYdhujPg0ZsrKsdzU3KLLoMb2mVqKrIVD4vTDeYMRog+YD4yeysNnw4YZjH/VtTjsAB+kSsx6C8BHcPKZzlmjiBHWig6QUwx5KqbpdgGnv3ULSVWGh/oUgtVVqOsQFK/Wt4FCns3D1OXKiGAiROzlCHvDL28ZzWZR2p2gZ3OzYXYXXsd+yGvrw;25:qto8uUDwzFyZMjHookeCXSefITwNvpxEBUFmsUTvHkexYflGGOqt9F4udcmIMB5YzK7KUH/sO47nyFKqWFQkQ3+uSmNlV3jCYUrFYlnMmD6rtdXK6e+d1o4x1594MzfloAKbWjb8zl5GYzT/MWmLD2eDoHD+uoDDET+avo1HCOqo9ANvdFMGBFwKCM4RC/wAqSgViLv/cdMBN4nKVfE4w8aZ2aFbiKchNATrf6CUG/LMaG1MfQmb0bn1KD+lOmB2PNwWwMmTyu2TMt1kQKh/dUr2dy9/Ksk7gsTIrUIGGjjWHJeoMXly1iW0ibH3VFr7bxrBMpQeSGghl3YNx1fd5g==;31:LnyojX5SJb+i9294UC2LNhD2JcOcaowEUIW3rq0Y5cJYJUYcaxFjgyTBct37ZtyMYtI/K1rrDJcPfilqFNixae7hbsny/035B8Xy+xCvSZ+Bszekrtr3WHcyCaQQ7Asm9XQ5bs+d9AIF9gLcRN023DN1Yo+zG0TRIwNu6pKLbOuUDMb6ZjEcvhdQ6yOcMisWyMF2TLt/geBcKX+a746Ztr0tGWjNYBYKq+5mWVXlBYw=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2629:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;20:GEUw8tnM1EbBLEW2ii5DIYUYatQnitagII1lKVtkab7XOIFaNhlydy8999XmMEEBoaI08adKpKwlvn28OpiV/bIVhtVY57QJMb8wip1rYmYbNXWVuORsxjJU0NMBYbJEtUXumPWV6HlnreRz3NNAHd+ZsFZmlLgUJrxNxdqVE6YPXrCgz/J+VZhZ+dYc5C1eCxzLW9eysTAgS2w0umL7zVCQAWFJ3UfuCE1xfvcdOXfkPl/bw94uGGrsBOO0nFIt/ohN3QI0pJ5YvizMAbpjXppgp9Tte90yIcd9o/DqZLhanFGFffngQBKuQ9rr5Yy2aQddAyb2fGfYFmBox5z5dSwNKU+OLuzqHwvrtrBwkCGkGB1/Ghpr7LFGmpOtdiLZpjYNqJwtFrt0mJ34dXJyVGvszcNHLV1Yh0c/hvTJAwmCIyg6mZW+lyuk/59v7eyho01ocjKXHYnv/qNwJthWPRF+6r4vpTkAPlCrY+gog08+M+ya8z6U2t97yYRxTY+e;4:aPy03TZofZh3bGxN2Mkb/Gi6ASeh5h/PCqAyHOaZN2o57/mQ7LSAKu4R7WXZg1zhusLOHGCEFm2M6je/pEuwdTBwISnNTxLR0tT5unatQJS0rUyaOtCOZ/mGPKKxJO19LE/RLveYrRQ7PlJvFWERb8AUDmw2EEWIMWYtv+9BqXsj65F3r7kFsm2Cuvuf2Z8JhXO994mYUTKWG0FrebKnIYTGBeNv0XqBMqMUsHUr1ym2XLATzoR144T1MztmAU3Mf/aveiKqKE9qs+X9Zk3/lw==
X-Microsoft-Antispam-PRVS: <CY4PR03MB2629DFB2F910BF168D93AE0DED410@CY4PR03MB2629.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2629;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(136003)(346002)(366004)(199004)(189003)(9686003)(6506007)(386003)(33896004)(97736004)(26005)(68736007)(8676002)(186003)(316002)(55016002)(16526019)(50226002)(956004)(6666003)(305945005)(86362001)(476003)(52116002)(7696005)(106356001)(53936002)(8936002)(105586002)(486006)(7736002)(5660300001)(50466002)(47776003)(4326008)(230700001)(66066001)(25786009)(23726003)(72206003)(3846002)(6116002)(81156014)(81166006)(110136005)(2906002)(1076002)(478600001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2629;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2629;23:g6AdhqQujfEOCbwiCtQRIri49IFJ/FvmSrJjVogCp?=
 =?us-ascii?Q?GlR2z2WUGTsUFsWBH95PxrKSj71Y6wuhdKdvW88JyaI5jZD/8IB9zR64DT4D?=
 =?us-ascii?Q?xGIHUS6RG0dfrvdI2EZirG4wmXB5k1Tf+yKpWlQMNAAikTJyLfC3AmBDTzb+?=
 =?us-ascii?Q?M0Wy5Xfyq4n8Rx6ZeELGum5VoTXPQo4DMCzpYcz2Px5Wff6nkzcWdwzQGWmi?=
 =?us-ascii?Q?SzV1lbmvvBleeWAylHm0X8To2ZBud3OInFq06edvXkRHbcHogAiM3PYNja6B?=
 =?us-ascii?Q?EOmOkaYa3GzBYplVRKBSJR5jh44bFikoAGmgH+15beyrpZlTtAb+ueJN1Z9O?=
 =?us-ascii?Q?zacagbGbCVc7I4SbdovzAo0duMXs7z+rsn9io17EncU3NvkhT382jOQZAszn?=
 =?us-ascii?Q?DBM6t6vVI1pzPBTTj7G/cbVpTg+H3Ppt5/QX0N4CX54YWV71aNfYkXnqf8tO?=
 =?us-ascii?Q?h7QCK4AznY3yEBmOq7ZPqO3tr1IjtvF6I5pIGzUGXQXuN3axbIboPZp3Zsjw?=
 =?us-ascii?Q?7OyBBRSKLYw5RiEyLBV9rV87ALkoEPkiZZHfZBnCltQvA7yZCmc2odfDdkoJ?=
 =?us-ascii?Q?Sbj2Pjw5nHzk76ZHScIuJdUE9aVs+dnToa4UoEjsOtzpuYL3Ai1dbEGnpYYl?=
 =?us-ascii?Q?Er4V5d1u0OQteBS+gPQQn/WILzEc+p8ApXv7bdQ/VQHGu3g+Yo5t8/naS3L8?=
 =?us-ascii?Q?AGhHYrRXOuAy7R3grIZKs+dCz8j3xtSy+R+6ap0rYEUa7AmgIgIkM6YYnnpV?=
 =?us-ascii?Q?rnY6OZR6JYoM5BMbQMQy5wNaILydAauOqWuCJXQkxrbPaY1YLazo6TKn2nQH?=
 =?us-ascii?Q?Y0OyGpfCvGgkhUZmAzWJj6ofNptdW5LMuzi+kRdxpzA9tC5aST9IvxWuU0n6?=
 =?us-ascii?Q?ZT++jBK9Il85hFfY5//aBir/b7sWfvAJ4h9ioVaHgY9chL36IRtImWwmTeKt?=
 =?us-ascii?Q?1Pk5H+2KbIs8If2ZVCq7c0En9A4WVFl4P4+LjscsC//HjO5TiP9u6iwudo0P?=
 =?us-ascii?Q?q3aJG6IQw5vGIb2GiZqvRgNMZO1L79gadqMzeO61Y5n0OMaWLqnn4P80Slbh?=
 =?us-ascii?Q?SOnU4jltL+IAjnPJYZSMmJlEXK9VJuZ2bLXaqWrZ1e55r8YfFD1Myz4d5j44?=
 =?us-ascii?Q?FdXku2iO/kjC4Del4qFIW4wvVOzkTZDJbwJCnfdEsNAMCmOatX7AA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5t46Sw8HIt0tgpJyvjWhp0IGJW5C2Wt32Jy33N5Yht5TTFOckFnBsOoLcno3KGJtooqzLM2LeE0lo/opcjrqEK9XqXG89FPyd0kFjW0dT3qxy++MRbdcPnPBGke7fuSaWDGGt6YM7v+VYEMS4fUUkzZkeUIOfoHfNSZmvDIKkOl6aIsKxK+qCdIRoRSDPwO2bmB41mwaPdPipBlqwH7/pC5X/4/LNi8Eo0EXUe7LJ0Emju30ha2KZ1xYPSdCcZ/U5ohrRL67byZDYslvJbn1FZ3uSm3SbOTayxHn821RB6Y2rZt5ZUOErpW0OQUpNi88nZfKVlmff4IfyHqu9NT7jZpzxmhdcQnIQTt39UMa39w=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;6:5nkeJIyKw21RCXvK9hPogSGdaisFTyahcV8PJ7qUTIA/QyQrh610vUYI+HTbP9N8b37x6P/CIauwEgFBn9iLQtwm03mA3k1zFLEUDO6xLg2uMeer+Gtq8zSEIK64oYwsYnzsYtsatXo+f5BWSuq8xw24XBUbFRW26Z/BsJjGLbtvgpPi3N1bOmkk+jIZRFlGl1Noe6X8sw58fdiiSHdC7Fz3sBmYUdrtG3FJJboUxSwaihQoNZSan8J8iCPqEsCcvdRfpkJYDCTuN6Twosbb60wD17iCJzXsONxXI1cwZF9hX1zrxfbi8LO/9qzpXGo2Iz/v8j6sLHxJ8RRQrTYROpK4DfEiAroEADhWrTKC2MkHs0Av83W6EIAjyOvPmlWTm/yQGHe/UrhPfngdAIa2QZbe762yfD/V/AkckrkWXx/kuR1SaQSzAoCT5EVtNe191jkTaKapmv8+t8Q8JyL4nw==;5:0NV+dAoyK3aEUz8PI6UqEQV2+lHg9lEzapPFWDIXSXWM+oBizplxlLskcjk4U7ZAglOc5jNIKHYufNmb+ln37kc1FU8g9sIj75rOeoJ/DUnfWo23OYcJcPh+4ioorbZ555uShroyOtuTvaYSTqVQyFzakQw7eJF4SjnCmZfWLPo=;24:/scS22yMRRacXkw76CstUAnK/BeERVXTZGAeIUpHQUrr+yiCEUGbPydPfYteNmklBg9YNImgnXaNXWnqWmpYfsA9h2eHxdF+23kY/pWZEXQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;7:p7c9qhHuO+6PSky+cs8rIBeh99NwUyquLouJQHgh91q70uVuBlrzzcjIovp3F7KI9d1roNRnIDd5D+0EhjsyDIELJg1IWwoAtB6Rtngz0w979ztop1A8iCwpW65il1LVvqVEmtQYuU79riFT6LOmU+AzqEKn3uYOqzlVK+SpBZlxVTwAA6eQVxqX8e6HXb4FUu0MmBlxG6dPVKP+BZPjO9iRWggpMoU/N3wGHrbvcqNlNFNdk17qREQ+88hlQFWU
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 09:00:57.3847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 742d17a8-cefc-4fa4-5eca-08d5e18ca906
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits.

patch1 lets serial8250_get_divisor() get uart_port * as param
patch2 introduces necessary hooks to 8250 core.
patch3 implements the fractional divisor support for Synopsys DW 8250.

Since v1:
 - add an extra patch to let serial8250_get_divisor() get uart_port *
   as param
 - take Andy's suggestions to "integrates hooks in the same way like
   it's done for the rest of 8250 ones". Many thanks to Andy.

Jisheng Zhang (3):
  serial: 8250: let serial8250_get_divisor() get uart_port * as param
  serial: 8250: introduce get_divisor() and set_divisor() hook
  serial: 8250_dw: add fractional divisor support

 drivers/tty/serial/8250/8250_core.c |  4 +++
 drivers/tty/serial/8250/8250_dw.c   | 53 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c | 33 ++++++++++++++----
 include/linux/serial_core.h         |  7 ++++
 4 files changed, 90 insertions(+), 7 deletions(-)

-- 
2.18.0

