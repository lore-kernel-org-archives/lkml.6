Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0492AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63BA222EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 18:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="WdtlooXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbfBPSAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 13:00:00 -0500
Received: from mail-eopbgr820111.outbound.protection.outlook.com ([40.107.82.111]:57270
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732151AbfBPSAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 13:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe5/ig3WYacNRnDw4cX8fy96wj1o+W+L22YyrLYuNvA=;
 b=WdtlooXvq8K1hrKdyj6YvZbKssLQvnEDHnJbJTudrEs7g4FpMLSjhS7clZy3+XerU9XeGb+IyCzHdOkJm+X62xxIVZKCznHbzmPHTp9GxEwNRjF8EoqoqyhYERG0udg9LDrFMXNyYluTcplJ+Q8tQCa70pT1FWy5WIiTyjd2EtM=
Received: from SN2PR01CA0053.prod.exchangelabs.com (2603:10b6:800::21) by
 BYAPR01MB5608.prod.exchangelabs.com (2603:10b6:a03:128::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Sat, 16 Feb 2019 17:59:56 +0000
Received: from BY2NAM03FT009.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::208) by SN2PR01CA0053.outlook.office365.com
 (2603:10b6:800::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Sat, 16 Feb 2019 17:59:56 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 BY2NAM03FT009.mail.protection.outlook.com (10.152.84.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sat, 16 Feb 2019 17:59:55 +0000
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x1GHxr8Y031316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Feb 2019 12:59:54 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6A8237A5779; Sat, 16 Feb 2019 12:59:53 -0500 (EST)
Date:   Sat, 16 Feb 2019 12:59:53 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: fix inconsistent spinlock usage
Message-ID: <20190216175953.GD23000@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        linux-kernel@vger.kernel.org
References: <CAFArEyWsuvEMFQ-CpTeawBbDY1egDzXf1HaOyd9z-uKcbSCq=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFArEyWsuvEMFQ-CpTeawBbDY1egDzXf1HaOyd9z-uKcbSCq=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(199004)(189003)(5660300002)(8676002)(4744005)(1076003)(4326008)(50466002)(33656002)(52956003)(8936002)(229853002)(478600001)(356004)(26826003)(75432002)(86362001)(336012)(786003)(6266002)(305945005)(486006)(42186006)(316002)(246002)(90966002)(46406003)(36906005)(58126008)(6246003)(36756003)(16586007)(6916009)(106002)(2906002)(2616005)(76176011)(106466001)(446003)(11346002)(126002)(476003)(88552002)(103686004)(23726003)(14444005)(26005)(97756001)(186003)(47776003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB5608;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5262a98-2f91-480e-34cc-08d694388f12
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BYAPR01MB5608;
X-MS-TrafficTypeDiagnostic: BYAPR01MB5608:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BYAPR01MB5608;20:RM0uCT0gfiWERTMDTl8eC5jxne+g1z0jnAPYVjmzRHuF8xlU7hAx2+Xg0LnYFLjee2hTPr44cZ1M3XTmDbg/rde2nhKYmlPpjka4g14bz8MaNHlFN3CwefZ2pvB4zp7NahZp2GkCQlcMq7EBIrQnZA696oWw24BUUWS44DfDyNW5hAaR9XKzx6Q0MFR95D+UhxuJZiTAZpJ5LGMqo4vtI5pNZKIEX8YJaEmSdcHpokXiTJPa+ppgGLgYU6jRSfuct4xhXhdD8BN+ebKzF/ZMUCKj1+s8sa5K2LLf7JK+sQlXzx/IPCjKt5GqkHSCDrCGkm+eeVMLq+K8s2f/hZx9Mv9jlK9nUCi+90di5q6TERyes84AVVCada2rK/nl+FOCwQh+2vJDKlE2wTv38vnFenY73IKpeOzDVKlJb9JG/r33JxntrpCllNp4MJIx6xVgE51EdbQlJyxaYDMcbqrDiAY2+GZlPevts1reeFTB8EesXUnZnm9GnAIcHWdJ9qmAceljL/e8ntlFiNPIW9h5J4A+/fJSYd7NlhgUUrYOzAWM2FNmirMM2iuXiBr6d/FMmYjGwpl7jiKy5au+zOJ3JVPARh/UPdmYAh/jxwl+yLw=
X-Microsoft-Antispam-PRVS: <BYAPR01MB5608A03A2BB22775DA2E628FB5610@BYAPR01MB5608.prod.exchangelabs.com>
X-Forefront-PRVS: 0950706AC1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR01MB5608;23:y/NetzKQAnrMCKp7qayFjTKYs6bqSXYejxWWDmxGQ?=
 =?us-ascii?Q?lfhjUf4MOg+4j5oh5rnsG7tKHbpGKII8xCs4HbVcbE4YrZEu5p7XwWsGmb5N?=
 =?us-ascii?Q?lZDx8Qdb4dHR6P0RMhC4utqG74EDWYIiLEB3jj+VMeBP68hXy7vanVVI4iyX?=
 =?us-ascii?Q?VIQ6NjTLiPw+i9qz2/qdfsabAkXXraY7ilT5YDec/hI2fw1eXSsOf/F8zsoG?=
 =?us-ascii?Q?8LdhLZESkeJtuIR1C6ST7Mmqr/o15nRd6EbGy/6IC+LYIfjfT2uRlCTglRBr?=
 =?us-ascii?Q?oGrwm55Ui7MRAidy+Q5N2PNAi+6aqJlHXWBNcr4ZrM4CRWNrpf5UQU75k5YT?=
 =?us-ascii?Q?2gOETL1dqn2+jTGbYjxNmOEDi/Uo4SbBXobuWRnrxSsyS+KeakeiU69glYsw?=
 =?us-ascii?Q?ZR75Dlno+T5umSLX+rMj3yf+SmizCgMhFP57M4EbAC1E0320jSW2nObpCrMl?=
 =?us-ascii?Q?8qGfPP6goI/S6Tsh3ReiVBiJc7W9uHziA4vKTtPtqSo+VyxPcE5ngfEMKkFE?=
 =?us-ascii?Q?koVBtbah9bUca4LPo1gYQP3ShIv9DchqzzEdYiHMdzQx6Xoa4h/TYMJWsqZn?=
 =?us-ascii?Q?z59Dv0BKs0G5h+eFhHRo7eKXWIuegKUFIER7ExEwpnzd21GfA37j78Cd33Hh?=
 =?us-ascii?Q?Fn5H6pQXa/f26PGUmL6cwwOtgqhMmo62GeOG50+jb3OSY8Ev5DnPyPIt4zsg?=
 =?us-ascii?Q?RamnTAsDMboJiHmB4WFqKiytrR6yVhcLzgS/6loJ96+B4VBwfYC4KBrVRnuA?=
 =?us-ascii?Q?hDO1zpq14FteTRMoYrALChRan3sxUnOI7rZbznNPdL4mKQVnpnoyY+YPfp5b?=
 =?us-ascii?Q?gb/02PZowHA/17TKoGaYpmsrCcRblxR2XrEpJtV8L83uo09sts1duJIq6AKG?=
 =?us-ascii?Q?Dw0+dmIZvb9slRsnQyVm7gRoK+6wOdhjETuzy46YMvMbx6d9KK9k/xp4mJFH?=
 =?us-ascii?Q?XgaVuVknOnGTObwihX4noymfYPdLOeIfoOQxLx+rm+JnSCsAKKwgJYOVryV4?=
 =?us-ascii?Q?tdgAnwYdnkmPW+BMC4M3LUWBufkHJ6wAJeI572NYjdTpIkV3ZGhxzqFOiRKC?=
 =?us-ascii?Q?7PhfacmOTUltKrTTDF0MV34u5kl4HWTXyK+aFT60IO2Owk5ZVtroMJKmu9AV?=
 =?us-ascii?Q?/e1kQXKs3VQ3Fs6jFxH+1+ZoYgUKXwrbDK4gp5tlYAGq12NR9JlHDWsgleax?=
 =?us-ascii?Q?pHVLmTzSz4SIRIQG+SE1BMW7Vmu2vfhbbnNQQS5Bp+k/kp5F8hXjCNsIwSlP?=
 =?us-ascii?Q?/n7anTmncMv1UFnpTI=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ltg1gKeksvJL436MQ3mCHLZNV/CfW4R3NqD7d/OGa85IWzhrnfR6MNiqCvXsYfCbzGacj8S9U3cPFfxHirEmS93bSZuSOF0RTi9vZ77aV1f/kJlYaPxplUTbxlJ37733EIrgNtGKoSHI1K8aE+hu+5rtBsD78llN1WW7OLfpqYfsdUz9IUdHweQWoiqxkuFXUHHnI4ko26Qam57u8Q1TibnP+oXk8R79frVcRhtB6dmQbYArJ1q1XNXTCp05/7GHhFzijdjR8Tu02FgQyx2PQrrMGdz6/0sP258s4Bd0kTAm0oIkvmAhkCQXxsJ4hvbqxtsSNP5SakRbhCPEQLpiz+J2silYUoLJ5aoEbGNEUIZoDgas4xf6b9AAonPdsFVjwnVqWkyefN9rm6bSv8VCTZxb8DPmkp9DlndE8qFkk/0=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2019 17:59:55.4611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5262a98-2f91-480e-34cc-08d694388f12
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 02:03:06PM -0800, Sultan Alsawaf wrote:
> All users of the struct entropy_store spinlock use the irqsave spinlock variant.
> Spinlock users of the same lock should use be consistent in their use of a
> certain spinlock primitive, which makes add_interrupt_randomness()'s spinlock
> usage incorrect.
> 
> Fix the inconsistency by converting add_interrupt_randomness()'s spinlocks to
> use the irqsave primitive.
> 
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>

This isn't a problem; interrupts are off by definition when
add_interrupt_randomness() is called so there's no point using the
irqsave version.

Also, please note that your patches are whitespace damaged, so they
can't be applied directly.  You may want to look into how you are
sending your patches.

Regards,

					- Ted
