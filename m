Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689FFC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0917B20855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZEknaTa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfBBDCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 22:02:50 -0500
Received: from mail-eopbgr740095.outbound.protection.outlook.com ([40.107.74.95]:11424
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726615AbfBBDCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 22:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8djspuCWBiI3ZQevpZzcTknh0oH1Ajr+zEw757JZY8=;
 b=ZEknaTa7ztFM9GF+e3Giq2MAt4tn9Oc8Fu4NYZhmDYenY93uEWEGskf2orm36UZREnhKkSt6+Yo+WTc5MUD0XDJ6VkcmWeVjIpV99hoEiBck6rLmUhgniY/WHHdB7HfEaojj1m639KmSbCdB5YlHLRCfyuQgW3eFrjlyNcMxUNs=
Received: from CY4PR01CA0024.prod.exchangelabs.com (2603:10b6:903:1f::34) by
 BN7PR01MB3745.prod.exchangelabs.com (2603:10b6:406:81::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Sat, 2 Feb 2019 03:02:46 +0000
Received: from CO1NAM03FT038.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by CY4PR01CA0024.outlook.office365.com
 (2603:10b6:903:1f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.22 via Frontend
 Transport; Sat, 2 Feb 2019 03:02:46 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=bestguesspass action=none header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT038.mail.protection.outlook.com (10.152.81.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Sat, 2 Feb 2019 03:02:43 +0000
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x1232exk011623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Feb 2019 22:02:41 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 44E347A4C53; Fri,  1 Feb 2019 22:02:40 -0500 (EST)
Date:   Fri, 1 Feb 2019 22:02:40 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Prarit Bhargava <prarit@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH v2] x86, random: Fix get_random_bytes() warning in x86
 start_kernel
Message-ID: <20190202030240.GA9802@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20190201180831.19839-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190201180831.19839-1-prarit@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(189003)(199004)(76176011)(103686004)(90966002)(26826003)(6916009)(50466002)(14444005)(97756001)(229853002)(26005)(106466001)(478600001)(33656002)(8676002)(186003)(4326008)(8936002)(36756003)(23726003)(54906003)(356004)(126002)(42186006)(446003)(36906005)(6246003)(7416002)(16586007)(11346002)(476003)(486006)(316002)(786003)(2616005)(58126008)(47776003)(4744005)(336012)(75432002)(86362001)(2906002)(246002)(305945005)(52956003)(1076003)(88552002)(46406003)(6266002)(106002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR01MB3745;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT038;1:+GIPTic9yh8e0Aa2Uzn3p+0lJpc0El16w4S9UDcMJwv3Me4f9cwVtpWRWJ8hCiJfYQNJUlxpI+1GNSc2Nk+aRRuhiSee3S2exmCnqNS+DobelF4vEiAmwK6ivzFvfrMfIAFy1iEYfAUGi4BQa+xV2vZm8QGgBpcIDTL7uL1UhVM=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d49b47c8-9f9e-4967-658f-08d688bae80a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN7PR01MB3745;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR01MB3745;3:pGeW98uwcprIs1Y8NizNFyio2lgifGnbvvOmNq4cnnd5ikXSMGwMWBHjW8boUQuSdQoExErQQ6/oxfBbU3LCrK/kdoM28rf64y/a6wYd1Qe2FIjNpBweZRyEccjBZEqkA0aiUy+dXIV/Yy1aTwSkCYkst5AdQIc1hm3Pk1SLDCbPmaGUPRDiOvhO3S0XloR9Bop3Cznso4IHOPoTenOrGOpE9TfNTiDtbiMw0Hre9Tm45hMSKTnhUKwSC1wbywYAW0OZpzZI3svgEyeCQ/HXA1Orvs5MXnFAi0JZJUZpGGwEluT4ovK2RUBcXTi9TCjeC7127gzBoFdal9QOdKMW2kXxS542IZELoGJm6ZpPE47xfsc58XnbTRJc7yd/54QA;25:n7LXms3YOESIRW96un7W2GsCZ8jnsfMtbI6NPEULjS58EO9HtVZvzbg5nvikzl3nrZEES9kYXbISxWs2/b5zsanz0o0GMHo0gMXqo64eV0jMxpAr0ShkN57tphnqjOjzubzbqJgBZg1/0Ro7L2DEinVJHtWhsUfdcc4yPr3+CnuHc9HU41dHNLChhgBhH6mgSQse1ZKXoDP/WUvj/ywWr3KWMEemD4o/hwYz6lnVqu2KaSdRqHtvT4EPrK4qvI/y85KgnUAze4ZBLn6D+OAszc/encl2jJkjZRjpVDP/r31dSVJF4BfwaVD2y5UwjKDhGrABg9IUyaaYtO/UO4JP2A==
X-MS-TrafficTypeDiagnostic: BN7PR01MB3745:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN7PR01MB3745;31:adiUvnnKG200HH3puamrVrHIyncoEeb7zIR9SbGb0Y6Ub5fgIKl4+wdtkgRqor60agblJIy17wxvpK1A6Ssv19C6lNg6IaKsY51pwoDYSim2WA4Y3jScgDLfsMbVqcwfPAdeshdp2pLVmDgYNB6WHauJ5LRSqqdDWdtY1L3/IbHjf305MhhAaPHJl4s+jMz6LJHF5ZFVs8CC8o0+fUQ4j9m7TnNFAvtsqIzktJ+2Fq0=;20:gxsAmZkxqidcqIHsfzXpas4+ugIwanzuFZe2dE4SLdLbxq/k1mTn+SU8E4sG7+7gLSaNxbepzxhm4cHSdTLLrDVF0e5xt4nrjybQj3HlnodcSn+fk9jWF/7JUaweFSrOTsijZROQ3U9GoiFlXOuUwFRYdO2nKCgd/nAgv3b6AXdr05f2q6e5E6kN30+75I111VMNgACO56KoUwdghFxKkAeMxfVqcPzNfLWg2RZ4I9ryacY1qitK2ccRrLbGsKmYrmSEM+pEcpMYwVqih6KAPUdo4oKwO8GIE1BRcFDGEW5yEl9b/har6XE19zVVuHlzEXvjn32BQPNExTM67NOtawZeCTB3Gc1vsDv0595U7DD231nc1ksoouvrs7FnTnp39AKpyMqniyjiKjEPz5LPhrDkneLQKp85nE54RYDrfe7nEAXpbsurkXNpAg3ZneODTwZg7rqkz0nCLUvB4T08XxspljHf0+bTVjkV6A4NJgHIYKtVUyhUd8P6mMzzmGCuU95xuk6WYAstLAyxXryR2la+0a88XEsFwxCIqahBxpNa1WQbbX4r4DBr4Q2Rmx31GUPJvBYG3no5ciwD4AhHRWY3tKO9Iin6n4t2aD63ttc=
X-Microsoft-Antispam-PRVS: <BN7PR01MB37455F368B9EFC0D0B150F77B5930@BN7PR01MB3745.prod.exchangelabs.com>
X-Microsoft-Exchange-Diagnostics: 1;BN7PR01MB3745;4:MBPhGfbwS0iopCLO96C0WNVw7NbiTNxMtyxNZJVZlIhhY2chSmukmcImawym5Q0Nb4MNvryXZtnU4OZB9k2kPVcuwUKsny3d/+QdTxnFEr0qCXqdGzTkBZjDIv5A6kQ15eO4M+5akeZaZnt5IqIZlkUw9Qchz+aPppLd/P8rM41mYKlXCrarw/yZUAt/aTbWqrWUm7ois7Gonysy8k3ooYB0zmVUDRRpbM3owMDFxASm9DE1oEr8bDAh8BWYTJ6gZNcbVKKIms8mBuV/cPZkvVb/YEFSOG9lXhiZ9F3d7Dk=
X-Forefront-PRVS: 09368DB063
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR01MB3745;23:xMrK9GAQmUXtAgCtoWKHAqhQKUcftnDh4C4CVS0MO?=
 =?us-ascii?Q?rlsLFHaQE5nFamAosBegIMB7rSWtZerF+WKijr1vb4mevb445vdTeGzXFH4g?=
 =?us-ascii?Q?mNDSWODqyYj/pAC7r7mUErxfuR9D8If/x4nU7QF0NkkpiD+TTbNWzNPHWjOP?=
 =?us-ascii?Q?mvQR5yixu8czn53M0BgHE5dVPcbDnKQksP/4Wvz9sgyBhEjgFADjQzntz1+o?=
 =?us-ascii?Q?yGNhaUKp+fUtVyiRsqrcxm1DOdbNmHHXVzeu4ZFPALjBpsqZQF/vDgjL+vV5?=
 =?us-ascii?Q?w0egmXFNbdA6/bLZ0cIFkeLoJ4wEoj2j+BeK5UaLu0XA2LPSuQ8u8UZnpzsA?=
 =?us-ascii?Q?X6oBqU0C1OC/mv2HZdbizOlVtZLHXR1gv1Av5W5/eJ6KXwI0LB+WBxPmJyy1?=
 =?us-ascii?Q?1uTmt8z82iOQOsc7/keziQoIfTufVkQsSQilGkObv2T+eBk1C6zH/cwIKuwL?=
 =?us-ascii?Q?aGM8dEBNlbUcBq8xMWhZ7YPrMXPaUeyRlbwUXXrOxIj//jCVkO1JGh7yHnGl?=
 =?us-ascii?Q?eoRJAXuTLHA47r+RoT5yJ+CF2Pxcvhf7aSqqVyWOT44lh/GgK2lYDAdtThRC?=
 =?us-ascii?Q?eK9UAPp3Z9s11KjCIdaWyaWfR1pZ7j8RhdhsRDfbU3DjSX3rhmKtYCJw4E6B?=
 =?us-ascii?Q?VbdfKVuZ+E9krPSZHvkSUeW2ul6LJtpZXHZWr2x1WRsi0xOtugYpMbedAZXd?=
 =?us-ascii?Q?InHgGRQzJ7wgs4mm2zvcjbDm/YJdno78h5IZyfPdQ9i6OXYH+KLB1mgq30FF?=
 =?us-ascii?Q?fzINMKgs54f55+9snLnSNqINl+2qsEgXaPQeK5LS21H5TZ++F/+mSMBdaiX3?=
 =?us-ascii?Q?bSo2RVd465qPPbXhiWlbIZnktxcl40eGBM8hgDRDaFBe5nKRs2A+eNnzUp5O?=
 =?us-ascii?Q?AI+XHMW2PP3k+UDCXln2gnYYEVGhik7zYwEcljzR2UsMNTmiSlNj3tE5/cWk?=
 =?us-ascii?Q?Xv3Svn7+iN7RJiHx3nX01O3q704qxe+UoTf8vSBqD2zURbVQl3Ai+ULpMy4M?=
 =?us-ascii?Q?bManNWTXS/WhsFHPt8E976XWVdfexWLiej2Qj7UzHxnhNx9NLWRZssFTGz/7?=
 =?us-ascii?Q?y5ixmYuEbpk/cIQfPVzdC8THwCJAl2vrFayaqRdNvPbMGte3y5x9WqQ+dHed?=
 =?us-ascii?Q?lNuF8Az3pfHFbnpGJakXLqs+8Z4g8u7PNiQ0XKbl6acBbqISHpDHbykmR1b7?=
 =?us-ascii?Q?PNE9rVHfUHwMbwkyKcgM0F9vnxHD45k86+1OO7N2irrF19AsFb0zvvuGqXCE?=
 =?us-ascii?Q?wtswXokJxdLbt8NGr3HAWnZtO801XusLLOU2PIh?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: m7/uLKsx01gmVgZ4+B+YOT9x5gpB/VjgJrvjsF9/K/8E+0rQhXJ9ZpH2KbAzTjCXFXSqawukE6tOkMya5n6op8YSd8RXxXSzGF3HMGx8gTgXT/ekUryzORFazBgggapBsEdQgCiPGpHHwk8emVnF02sIRyVN51BQ6GjjYSCFhrrEbdyf9dFGGqJkYR8IV8yv2QqyYwvvryxkfecmyQDUdWsFSPTR+uZXIRmr468Gs38Cb3fzCcKBZ1I6Dm3fvV8LiBoYBFGK45wZkwpoOqAoMvlWRZeEEAzA8DK4LlKO7/4JBO38wEsW6QXg8LTvUy5cKVq7cUx9M1qxOtp9sQSKxDwYy+4QYBwea/NsthZkB5o2tElrhyZCixiN6lRvcD7yuAvEuRXGcBa0bjDYrdiCyjOEfwh/eLCspJrNeVo5ui8=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR01MB3745;6:ZeAMHkJyeXu/ZswXVRPapcrgKAi0WHhYdTRHKX18e82MUebyR//7p+IiOPWgbtCjBCgnWAf9jN3ul99CR6Dq7BuGaivUWijMTatVdzcK7cTPKyu+GYO8MWGTSWLkBUB0HqZ3a341UKuIkaK7g4WEgo+LxM+54c5e9nT3L3HBpcGPMlEKpPKjBNBybNwpW49SSqioi2m8WhwmEZMRqbhDClvjWKiPjaQBEEhg007qgOhbTFFhtPr6BNKHfH4sfcpHxT+18B3qgJR4VuF7PwyB0BIG8TE+K5cfedcj0OdXjMNElnED2GvmKj1BusB7qK9U4VjvJCBt33LKXAKRFeggNGv0WFvslpYhuS+e+fHNvGomvHUwymRIEc9IFM7bnQ3pl2fvjqcRPdGQvDsyFH23ZgOAnl6ZuNz6/3GVJmP1eQmxHQ52Sp09PtXwqZdFQz5BxCGotgcVnLoJN9C2jmQB8Q==;5:O+PHfBTTgCBPjm2KOYDdOa4VZjItjLCxMemVa38EFBf3XWBnD5RIYdeEw9kzqoZcPE1ULLRbtKlsXo6GoeXLPAa48/t4gJ6oacvUxig7sQjQi0pud+JGIWAONXOH31QSe0qsUByOx+bYQENAhBJLncy5c2a6D/cOdR0uv9VOifj+yHuDO5dtOe8wvtP4zM6A7vhoDGHL9s+bDwx94NluGw==;7:o20b0egz59Nw94DwOA46aq1JkTnHrmT9NAvS+WIHIrHKVbtim10+Gtabq7ayMRTNUxKST6RRiJDlwsgp0cba8cdsWQ7pnbA6YW5ev4sRn/5f94WZ4gfTLsn5Vk7YG+X169pEky3y9YcgdfiCwdM96g==
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2019 03:02:43.9689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49b47c8-9f9e-4967-658f-08d688bae80a
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3745
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 01:08:31PM -0500, Prarit Bhargava wrote:
> After 43838a23a05f ("random: fix crng_ready() test") early boot calls to
> get_random_bytes() will warn on x86 because the crng is not initialized.
> For example,
> 
> random: get_random_bytes called from start_kernel+0x8e/0x587 with crng_init=0
> 
> x86 only uses get_random_bytes() for better randomization of the stack
> canary value so the warning is of no consequence.
> 
> Test if the crng is initialized before calling get_random_bytes().  If it
> is not available then attempt to read from the hardware random generator,
> before finally using the TSC.

If you want to trust the CPU's hardware number generator, there is a
way to do this already.  Simply enable CONFIG_RANDOM_TRUST_CPU, or set
the boot command line option "random.trust_cpu=on".

Also, relying on the TSC for entropy is not something we should be
recommending.

So, NAK.

						- Ted
