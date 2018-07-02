Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D3AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F4B2552D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="WYZbaPEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F4B2552D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754585AbeGBKG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:06:26 -0400
Received: from mail-by2nam03on0088.outbound.protection.outlook.com ([104.47.42.88]:29192
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753132AbeGBKGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imsZAKcGjmcZqIXEMTbbfASwZP94OUmXIMyozeZMJkE=;
 b=WYZbaPErN/G1sUKwZs6ZtNNf4RmQkj5awELNBVqq4O/JjKf4/xiX5TD0oJmJLs/Dj27SKjOKUBOLNaz5LfNdpEJ21dCunFHwDugz66VVbJutYQFTpQDdIxSOyPsbgoWe1fDAF2BSw815R3q93Q6CWRcwMQr0N6kwDdJQeTFZX2w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2632.namprd03.prod.outlook.com (2603:10b6:903:75::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Mon, 2 Jul 2018 10:06:17 +0000
Date:   Mon, 2 Jul 2018 18:04:28 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] serial: 8250_dw: add fractional divisor support
Message-ID: <20180702180428.331b36c5@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0140.jpnprd01.prod.outlook.com
 (2603:1096:402:1::16) To CY4PR03MB2632.namprd03.prod.outlook.com
 (2603:10b6:903:75::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2cd8af9-bc4a-432a-18fa-08d5e00374b2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2632;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;3:ydYoJfUGz2ImyOc7NOlt3VKVz14tN9zZpbWQ7UEMupZPyJmFpVW7kEO0mAcY9bQAQFRLEFAPqk40lXLCZ+bzlVcl/NaEN09jboSAaLLUXM4N5Q0JWzI6yj5AuBn/Gzt/WqPuJu11Vvc5H0Pa8hsUIzP6WjuSegOi/lxquyG1AW8iPVDJ74Xhwd7B+u88nMJUDLtvUn3sOl7FYaZXaEALsV0dbidN6hYBZKpZufcMhbdUSIAp8LsK+70tAkaH01cs;25:I40o4I5DOv24xO2g8bh9oWWeY01Q8RrAuW0BKo6rRgl9L8fY7l4McDPBU2pJJQIitM/AyWBAfeO0UTVo0Xdb+b5AXXd+D+k8OblXhohwJnEcSW9eJSsoQJXo8ES5X5w5XMvq5BZ/crCJZVh5zP+dKUYniHZq1dgCIBokRzdEQpC+E2NfhwKPXi+GujAVabEOIODtSBNNpA546/H4iNDKGEQYZMGJA2xET8PA74LD7n8n7apKplLU/ZATkPgG58mX1dJtCfFOZogEvGxdyAGGoNZMqy7WnwyJ1cXp8UFeHv8s1x9yXSfx7XAwxxlHrw8xzDQxNVXXJsLMiWKmHs4bAw==;31:I6XjdnkLWOFfaSlWtAD+98O1WPm3eOJyOkOJzU2zJ0cQ799WR+15cMrhWd3G0YbZby/HGu+pb2Xl+O8k/iNXnrH6tAR82JKFkRFvo2ZL84RBjVu+aNDDh49mCkWulNpQJRZlN4YlRlZt07p83rq+mB3g3/XmBnW6dC9/zk8tYnbaHlwn+SHuSy7GouEi6XmXKrt8iul1LRNMfCNkZw27gGmPhsIn9hptfHueBMqJ2cA=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2632:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;20:mUk18HTu5f2P1r4kcxJ7cQ1GF8TQ0aVDhtPWcTRsqf1E5Gi6ve5XUOFxZQr3+qKj+9MKMyM1RFRSEcDqQKnCQaBSJ/qO8s8djb9EmxDYITadu35UuR60pSt4W2W9sY5tSC2vwFLDbAQmGUl/D1KKKRINvUAcJKVgq0QHxmuO9eiDuNXScSHa4DN1RzOj0hES9jblO43Oxz5uUdk99j6dOETQYbfPsyLjArJnt3fCLz4h7gxPJqAEifHPJAJ3tgy3dsCdnbRYZDoNnHFBhMzkrggB16ySuO9k2ng1z86FksM1NQxYa6ZAZvFiTY2wWCfuJSwq9KHDMRO4mMgs3o73QuuhB9H0tr/771dM9nhbmOO1aiePrTUlqw2uQPFK7TR39lQUW7Cl/fluZJD5IdQDCofzGLxXK5ep3GU8clciI+biWDIylaGCPSiJVJJTade7ElNHkHFwWortcGkuRIBXSa9v6+rPLkKYAF0ohLnzFTwIjEFWeXu4rxaoS23Z8mkV;4:e3PzKflews1V01e8fFRmtYYvykps25DetQ3tL0bGlTWd5cCDU8XvlZMj7v5usUlQS9V7BWkzX50q9N1jbWqW/um6phtuQPBurO2M3IoOVGbcVz5GtXQKe5Hca+srVKk4xgX8FJWazzxv9onx7GYFaJyoMFbe1M2Vvmt1+h96OsXX0opaPDYBHN92NYIlS0xEVR4ZcCUp2RU+wpc3Y+nccFWKRQVxJhlC2w0A40GUN23MOeNwGqZoIQs1OCw5dOXDMFHeC1EwdV2+19sdBGtc5w==
X-Microsoft-Antispam-PRVS: <CY4PR03MB26325B803A376A7DEA8B4342ED430@CY4PR03MB2632.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2632;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2632;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(39850400004)(396003)(189003)(199004)(5660300001)(8676002)(486006)(956004)(81166006)(86362001)(55016002)(81156014)(476003)(7696005)(52116002)(66066001)(7736002)(50226002)(6666003)(305945005)(68736007)(9686003)(8936002)(47776003)(72206003)(53936002)(1076002)(478600001)(23726003)(2906002)(50466002)(106356001)(105586002)(25786009)(3846002)(230700001)(4326008)(6506007)(33896004)(186003)(16526019)(26005)(386003)(110136005)(316002)(97736004)(6116002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2632;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2632;23:UHrloDHwHtwG7uxeIoGtgbe7Scb8ynDEjjFeVfboS?=
 =?us-ascii?Q?Tto6Kv1l0arHvMPEg1Dgs63MtFeAnMUrgZpauOL/RLfnXyBTa8DK95SO80e4?=
 =?us-ascii?Q?dl8mUQabgXQydPRuUSn/W2baryPde5pgJoj903rv2UyeDnDKmRfN8h54Wd5r?=
 =?us-ascii?Q?7FudiRP/xka/oif9/1AavutMsWEzt/OwKz94/DAq+uYx4GmCaFlwgwb34X89?=
 =?us-ascii?Q?rwqfISZcKNAaXqBd+PlHiHDFqUNgkGuDZxaP2AiosZ8oCA0xDK4oLuHfyD+T?=
 =?us-ascii?Q?MSrqlFQTOE4vZ/AO4W68Yd12RZrFT8CofO/DBq1CCm6yZITJME0o30cRHSP4?=
 =?us-ascii?Q?rLwoYvIyrebj/+08wACzB0yS/C5J61aAmsYDLJ7fRp6H25BatFG0rJ7JzqlD?=
 =?us-ascii?Q?ZSfu0g9CD3VJN52NPVACjyxbuPbVtqBeRDpBaEd/VdaKzmj7eb+CVrPdYdLq?=
 =?us-ascii?Q?Revy62OAhEx1GHTmrB//8hnl2+CUDhIAnAJ2oAdXKL6zRcxMxNYQkoScUMPR?=
 =?us-ascii?Q?GDlnbsLO4WDMl4+BS45kmzEPCQxAY78kLP9EginoCgXAG+60VHwU3Mvca4Jk?=
 =?us-ascii?Q?01XOz+PPcQM3s8Z+apflfip3zx/boOSot57bT0gwNzxEYXbReRR+QR+/zFbE?=
 =?us-ascii?Q?G1zOZv2t2WBINb80rpH3PE+akiX9E19h8bLV0R3Rw/sZ4MEedQaAeytZ+bhU?=
 =?us-ascii?Q?ux42Q/BUbRoutwrP//K9lb4j18ks5KFww0fzqf6HmYWGKyEjPjNyNVcRUy/U?=
 =?us-ascii?Q?2e1ILud965CRqHSRuUK0Ysj8+5tsv41vP/KAfpYC/S5WkOEF8pB0IKhhv3SH?=
 =?us-ascii?Q?ooT5n5d9Tdenmv9le1q8EGqlW3T3r4lxr48yy5RXJFRKRKQqXLrskTiSVy2N?=
 =?us-ascii?Q?Bou0Jef/L7GUBBllRX5DmIVLinmBm1SEqgQyfJHdWJQiWckzKv/wsGix8zMS?=
 =?us-ascii?Q?t7Z4Rtg7fMcGl61S6y9DM7EU5/eX5kU+4B5k1nNfwYVwtnRGCZ65ec1SJjrM?=
 =?us-ascii?Q?tzd6ayGMzAze2CrAv9uuZadh5e3vgBbHfcr+M4NCKrAa4/Vrk16Q752/8Uij?=
 =?us-ascii?Q?ZG0IK8MzTv/xRlBugeX0yKyKcKBWq2GAFZ1/uvcvpoiNF+2EVoT2MCP7Efue?=
 =?us-ascii?Q?5Hra6iDrAWoPJHt4HrlUZcK0PP80cKrHzBxNaonH/IhLesz/nR96w=3D=3D?=
X-Microsoft-Antispam-Message-Info: VGmrnSnxRORh9zq4GKhzBqUfj+UGfmEu3CcJPTq9u0z1tO4DsYdzlRbjM6IjTJE2BEw/n34A9U9/sKW3KldIauIUiirqwc60K9GsPWTaaCNGcmK/7l2zJYshVLUk4BxO1aiAcCtsB/Sn/HhY7ZZibCo5zDvKOfOqG8AZD//9wZAMdRWOc/rYU89VEKG+N4v+kHgVEY05TktoO54COpoSMZ1lLTgJfBHoBtOsWWBrTRil0tUeB5Q2HRLZ4lQkbPOE6T7Jw+JaNlm1vvS/GusMqHB2M/DEBv4rLBOa67FKSr3cpj21dRpSEdZRERa9NyyhmkIcpkRhm0PYscKDlW+JIJTjvYoZirS/LfZEBRSVBMQ=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;6:S3iEAJ9xr7zGgUXgP9s0bo4agsb/e7J86p5zssxS2Lkm/NagJCFxKt7BSLnEs7vPTyb+BzqW0FLNnW3xoA7n0zcrcsu4ctjhE2A+NQuoVuWuaAJ/iunRlVzli87FhngGBDRU9i0/CbKS1DcdkIQ5KNPRYFbTf4GmP8h9boAtwinsfMO4PvXDiT9krRNc+M5TlGRmpmrEtw5FIpLs+17iuR69PytYwcJYfs24QZV5YqDZSaiIFe+HhdB2vuQ7z7cL00cAUMi8fbaUjOpr6C6S3zfb0eL+W1MRhdCVkF0wReoU6Ufig6I0w7YHqw597EUr3HXyGMnP9svQVrBRUpRqXn53ll34BUYrHbHVkt/MVFDzG/NlosMywZygj9X8q+eqg6kvqZUucZ7C+uLXtJ/qasjLIK1hpJKdwEB+0XlGClUdXNaecz+QJbQKRto+H4TnQ9F56BErE5xeujeRwum3IA==;5:tnRqj5/87Un8EYbJ8wImT7PUY1a4JaYuAV1dHmeCSp5iNNMU7B2bWrHa/3FzcM6rFFwavSfEEXKT47c7pOn2DDOu7Nahf7+aPr7k2rzvAHdXnHqXQ8EMQvCgZTO0gWNKeztNbYiaSPFKWGh7Z2aQVzZ/jfv8dUyE4Ua9/E43/kk=;24:k3UZsFN1+TaPdNxY4edJaEM7U+VmDkwRqbVNUM9wmd5+p30zO13WJViZTqhYWAsgf0eZ1oYwwZrsB/by5+3HzqQl6m6XFmivunxWsZszZZY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;7:8dkKwevaJ5Mmg9LEKnvauJ9l2t8MURSAfRWrOvh+S++y+eVqRYhrYxUXCt4kd22ogD/3bD4mhICsmyh8j5VMRarybkseKe1i3f7DD+w2s108613XGXX38bNgDAw/HFR9py8TMkyX6mY0zaCL7YltXrHvTN3A4+a8ikXD+wub7rNmOr3iAUFrGOsSRprzDvmx2uWFSVsZwgViTc09BX6Vf2W6bD1uQzE8b4Qd/24Cdefh5FwqeCHhNFOovdYC73W1
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 10:06:17.3881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cd8af9-bc4a-432a-18fa-08d5e00374b2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits.

patch1 introduces necessary hooks to 8250 core.
patch2 implement the fractional divisor support for Synopsys DW 8250.

Jisheng Zhang (2):
  serial: 8250: introduce get_divisor() and set_divisor() hook
  serial: 8250_dw: add fractional divisor support

 drivers/tty/serial/8250/8250_core.c |  4 +++
 drivers/tty/serial/8250/8250_dw.c   | 54 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c |  8 +++++
 include/linux/serial_8250.h         |  7 ++++
 4 files changed, 73 insertions(+)

-- 
2.18.0

