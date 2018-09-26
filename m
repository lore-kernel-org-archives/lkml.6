Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BE3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF282086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BYtHtJ6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF282086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeIZQvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:51:09 -0400
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:50866
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727003AbeIZQvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9b0vWjEeLyMN+ddqZVGWjMlHaC2kPOGOFIxy2/SngY=;
 b=BYtHtJ6ok2Jn/KxACvBKSBZtIbnZZgKFSgQ5ubIPZcslFg7taIXKQNduI7/8XGdymQgOHXr3/o/o55604U4TRy19lML8vuTNi5/jawZv/vtnQfAq9eClcsnuWhMFO/tVMP4STqFXWBMcs43R045cg0n5HwgN6K13f0TUKInAIXo=
Received: from cheddar.halon.org.uk (93.93.131.118) by
 DB7PR08MB3500.eurprd08.prod.outlook.com (2603:10a6:10:49::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Wed, 26 Sep 2018 10:37:04 +0000
Received: from bsmtp by cheddar.halon.org.uk with local-bsmtp (Exim 4.89)
        (envelope-from <steve.mcintyre@arm.com>)
        id 1g57Bm-0001pw-55; Wed, 26 Sep 2018 11:37:02 +0100
Received: from stemci01 by c30-smcintyre.einval.org with local (Exim 4.89)
        (envelope-from <steve.mcintyre@arm.com>)
        id 1g57BU-0008Px-SU; Wed, 26 Sep 2018 11:36:44 +0100
Date:   Wed, 26 Sep 2018 11:36:44 +0100
From:   Steve McIntyre <steve.mcintyre@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, linux@dominikbrodowski.net, ebiederm@xmission.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        oleg@redhat.com, dave.martin@arm.com
Subject: Re: [RESEND PATCH 0/2] Don't use SIGMINSTKSZ when enforcing
 alternative signal stack size for compat tasks
Message-ID: <20180926103627.b6kxzdmqqsj3545h@arm.com>
References: <1536158083-30166-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536158083-30166-1-git-send-email-will.deacon@arm.com>
X-attached: none
User-Agent: NeoMutt/20170113 (1.7.2)
X-wibble: sender_address steve.mcintyre@arm.com
X-Originating-IP: [93.93.131.118]
X-ClientProxiedBy: CWLP265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:11::35) To DB7PR08MB3500.eurprd08.prod.outlook.com
 (2603:10a6:10:49::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81ff54b1-ab4d-4d65-04c5-08d6239bfff4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3500;3:1yU86AQYlsbVIXVFOosQGCnH5Knwm6rpvN46s14zPDAKlIC1Si3u91HkOfNJL0YHsj+woQAFYkHKPE9++A2Z2PxsUIKMr+wt4MjyPYsO0t0NROpOgzPRfDCLXSJBW8mcSw0SlfL2Falc7QWwv0Tqm+tSXP6hr6dAZv6e2imSjV9p5xkw5zZZe+f6ROJ6eyAOBXR6vITIPURIXJ+3VTPcPEUUalxM3x8PhMivUYf1tXGzIeb4gUNThd5oX39Is9dh;25:xCybhijCVSRcH6XsE13HZb2rbtgkPNt8i3GJDM4sJvtQghVdjUyNZM+wSh9tjm6kU2KNpkUP+MspVBoB3dZy+2pnmU1cwLr7WcBTxTQUd4ygHOqfVTCVWUt5auZt/tcRm+zjwC7sPUW7QYIpItr9Cih4DIxZP3UvERvga1tTTBYxO0NBmaTb5EQGk9Fccguq6u7or4i76zLWXzkye1xKIhkS922MiT8yVsG0P9wSUeqXTqNJosDLI1IjBmwcE0V9smXe/D5oglRG0V1A4/4MaJV79v6fzIfnBCKuFzCkFwyhK8Tj2hsgzr6D6FfbtTVVUVmKiNnheO9+IKGb5Lw/eA==;31:dEC6F0OKXgNpl08fGYOE8F0nPt1G5bk95Frnz0Y29JIiv6bDoPgmkP7X+jttHqiMBLOM0aqeX21LUbYmUlhw2NWM7nMtubacuUPePSDSSzdeMwlED0fIgYla/QRVHC6FWgPB6gj1jpjmDRxkv2uJ0wVJRogB3FgrZKFylueeeL1RXfMO5A1JWLCTZJO/veHD4eU75z3kkVfsRWR47iiDw4P5yx4m714Pah5YOXqIXZE=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3500:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steve.mcintyre@arm.com; 
Content-Transfer-Encoding: quoted-printable
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3500;20:Wlshx352YXOjFYxykAthL/SfAoX9ObTE3LNIzpCpP9i53TBUIoItMNHEJxzbNLU8d7dBVyLKwai3bcdKUnboBFcmw4dt8qA8ueQVwnWXNNPkEMiGmkkp1RoCFR6YiGR4LQ8i65SDgLypgVN3cx4PLVy9L9d4ezocr3IAuI93aCRY+B+gS3+Q9bI1XozP+Baf/tTF4PPQUjP4lNWfGa1qhcBGkJ6b0BP9kvh1U0kNXUPsDp2a4JJpY+BchG2YOu6sEVnKUMdkv0g4XskAnBGIUnv2qKiKgoCyfdhX62FU5bp2a6p/1QWq+JPfFvZJlteEruH18tElA1PzCsLm4E1sMi/ecNJfXrnihFlO2VTlAkGiFlyFIRbhc9w6uz3wNqhewi8lisB4ZVKGoiyLzkkl0S7hO2lBjMb/clNYAmt3+/qFneUviw/eP9sN38JGrJK78Z1Zp2zy8ccgZ02IfhUPgUlfH3uybJzNH+u2YISlAdZ9hLHBuzNhroBBLKmPm7WP;4:85NrVEpptD01LpUo+xEV1/EeyOuJKtzqTt22NwrANAniFDllLPYwTXN0iWp3duSHEOA3gtov6sk/2J5L1rpyfBPdHz9PWUkvyLL1spLFxIj4n6fGGKq/CX4DDdQ7v7oVHKQIcB8jV+mcEn6VclMRUd616T1qTkZcztfU1asUPSNJW1YY1jqfIHfxDAKOgIeBYeaaIkdBYwmCAlhLdjJXDHCdsMmAJjLnzc2MvkUV3i8PsxRV+hWl/h4NiLNzWNq/HT3hf1sZYkNO5CkWIOQdtMy82kHqeFEvNoF3OA9JM4Ku/g8AvhrNt1lCoGI1L6MDrOf7Vg7uLRBCljgy1AXovyxzZuSZyAIkwefBkNDsGRs=
X-Microsoft-Antispam-PRVS: <DB7PR08MB350015A8D5BA1233BF3D281F87150@DB7PR08MB3500.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(258649278758335)(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:DB7PR08MB3500;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3500;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(53754006)(40434004)(199004)(189003)(4326008)(6246003)(6862004)(86362001)(5024004)(217873002)(14444005)(9746002)(9786002)(36756003)(9306002)(8936002)(8676002)(8746002)(81166006)(81156014)(316002)(122856001)(6116002)(68736007)(1076002)(3846002)(23726003)(2906002)(446003)(476003)(486006)(11346002)(2616005)(229853002)(53936002)(47776003)(46656002)(66066001)(6306002)(50466002)(478600001)(966005)(105586002)(106356001)(97736004)(6636002)(69596002)(37006003)(83796002)(5660300001)(58126008)(305945005)(76176011)(7736002)(34290500001)(386003)(26005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3500;H:cheddar.halon.org.uk;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3500;23:jGM084+6OXQxepKJlAy6wm8C7AANnw6dxY/IxD8A6?=
 =?us-ascii?Q?6XUJSqtjbeHAjTPa0imjDyWiW+PWQmAYx9mjwAfhsQ3xMCGi1m25c1H3Ula6?=
 =?us-ascii?Q?rbBryHI8L1Ualcx3rzD9npJKgRxHwX1Zg/+6Gl1v97sDlzE13SIjZDp959NB?=
 =?us-ascii?Q?414+ub3pO0hAdSBbfxuhSdAnNmnvOTyJ1b0OsOxWbVWX+Z+0X/fU3J6+i0Ji?=
 =?us-ascii?Q?hBAdwALryW+bF88WO+Uv2Q2295XAUF9Fel4d8q7vMkYI72dpD5QGARCjMhTN?=
 =?us-ascii?Q?u5gdyWYfeln0b7qIhjJ85LYpSP3gBAdR/XdFaj75FJtz5v3Blvs1T+lRyBRp?=
 =?us-ascii?Q?smiKYiAqsGO6kTCA4wBNeZPV5Q1cGzmfQoXnbJy5kuAYM6zpXnqup7uECPU6?=
 =?us-ascii?Q?jrkz/ysUlApgnLDDm3ivFoo6hyNa+/jcLP1A5stoYmli3x8IUKZ+dSYwbJiY?=
 =?us-ascii?Q?2yXn2fKmPalW2oo4SjQaKfSl2cV1xZLh+q2NntTM1kcR+HqJ+LUq17ORzdxr?=
 =?us-ascii?Q?v6cMbamoHAxim6Q96ULXs/KJU8U3YRL3hpROFEvJVTCjy9YzFyWvpgsKFvZ0?=
 =?us-ascii?Q?566HZLpgi/GOKl8ffhldjWcz5N4N1mg2zWpgKCmgWufer14dofYYGtrE0fCG?=
 =?us-ascii?Q?faheTE0fxKS/Cu+S1fJEwTW70o8WeZoAMueD61yFQruyZXGNipBrD69yYb8E?=
 =?us-ascii?Q?mQzuf33qgU+c/RLbmweaw5r9kPDdwa+XqFW4Mvj89u5chvfwOhGCiybt2KqN?=
 =?us-ascii?Q?VjSKVv8e7UhWzJcM+FDc/QrzaaQA6fcrEW/sk3qnF9Rke7O2W6fcdMsGMj0i?=
 =?us-ascii?Q?WYA8+a92/7phdrHbsvlRUjOlDgUff4A7Y1f1NOrP8zhJuQ9BqYhBZPd83MDF?=
 =?us-ascii?Q?8HsEJ4Y55OT0at5p4DJiSj85GuKrGa9eiqmclWrb0fY0R2JUh1MtNPslYBvs?=
 =?us-ascii?Q?q33XMG3JlqQICFlS4oJzkLEsEfrPhBHH/JDE8Zt/fKs2mD+HIdyVXz+n9xuK?=
 =?us-ascii?Q?f3RV70kWMKQsDhl/MSlPrrdncBYCCeHovMmMCuFaA8eewgxtdGVclMAT8S7T?=
 =?us-ascii?Q?+X34sccCVGeH0FrzLXruFWNvUL3+iAwLN5MO2vvTExwj8c0yyFFH7NEXRZld?=
 =?us-ascii?Q?OQdb3/rbpTKqruCifAceU5a1Il45ZVWt9vVMRA6UFvm3G+WMD+rgR/L6b3bw?=
 =?us-ascii?Q?RB7XD05HGK2A6AyGB5oKQavsaZZNprN7WuORaKeQzbCgtvhqiq/Jb/pmSkKt?=
 =?us-ascii?Q?wpDy79b4ZPNIeD3v6zp6hj7ZRwyJfJw4cDeLzZnsn0b81nwKlDNlIqKuTtuT?=
 =?us-ascii?Q?I0k/jfhARgNMPJMabxWjA/1kV0ti4RyZXKMIpGBx8KfEOFbj4164Ry9NhW1E?=
 =?us-ascii?Q?L8T3bJSo+d+vSR1KrGJSR/MGvvSO/MO2d+oZeLVahkfwRKM?=
X-Microsoft-Antispam-Message-Info: kZQRjOgVfJ4tbOEX6JpXER0bojhNlZEYuNs35rl1GtVmi40UKRxLrtGoH629KlaKa28097nrmOxo9K6R2e/D1zbUIGSVO80zy8VEE4nCWQ2KMuGzMBj3BSjvXMiwi3C58pbG8L58Ai3qXeuWWl6dXdcV4/u9E+3WZlN3i1axe4SNLWhwR/QniK46IFgXe5jC1I+h5jADSDC892WDnowXKhy60qyrJY82vs/SK7uPVfOpCYt1nWSMjJ7aAUwzM8JOvp1zwvMN5COrP6nB0fOVvfmFZghaDh6McnT3rb/Z/XDkMFtn5Y0iUfSUj1WNjPG0+XnFuH29F8JAM+kj0zfJVuP6FPB1AeacAKgxefhoido=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3500;6:qF7jjDkPX1HrbjC0NU4SSfDkhj2n8dHv1tVp/NGbfnQjJlOKG4cOUwVj+Ygl7rl+BdAoWiNPNmIMER8DG/6Ydgmc9CeFePyK8v6FWIrIepX1q5FizgL9vkXdRNfVQ2r5UODOw4K8KKBlZ8LNCzvg3N7ubL+5r6OTcw7Ya1MhwBiwaDZOCdJ4W0pbyFv1wUxkkb4LmahCvD0EBLOEw3HFQAxYv5SQ3nfdYCe8lwgkN3/V+5XKA6wghxhLNFi86QzN7YPQKJxIMLwmG9PxVuZFtOnAxGEJmOmeDXRpvIJXtK/QP5qyKYm+dP1wfnYMdlXFMT/8/npvn84NaDV3sJ5hTPwEfvhVJvkH0OmFAD0dLB/KNrUKnIW8upv7V70DLe/LN3NJ8rAqx9hnBeBz30BMt6NcZIM2r62PkdqeYrSNM0hc7pudeu4tXP6kvTiuw+AeX4NYoVPRgpNkdsVsZ+c35A==;5:/DUh6akiDvEI62kCMRPmro+aDCn6mLikh6h5601eRV1DqG/BdCnrcRlckn/L+bGm7E0OP5uIvN3wlcnFMVzLYZObRidrGUrhARpN+pTBTUUyqOjb3LXp3E1dRU6/VX8/Z0rvjfrwW38lGDi5Zt/xhYS68pZElav8sLxp710W3MQ=;7:++vTnv6Rh6e2Vp0TOKFcddtrQfbjPceanPdn7SUFgifqlD5m/JeEjFoDVUAoWPYf3+UX7gcAAkofaVEn8Zqd0hf8TaAFVRUCiROm/ZCdaQ8TnyoNC+zq0uzGY/Ygjzet+QW+UGGUUZQPzrFneZvsAOzW+gnTK+UWub+hSCIHMJySgwfhDabRz3lQPDVVSvNKnB+Ol7oUa2esTSnSS6KRd6xmEOqTqD+RX9U9L4InxNZqnfUrj/L4pII+5WRHVNZg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 10:37:04.0276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ff54b1-ab4d-4d65-04c5-08d6239bfff4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3500
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 03:34:41PM +0100, Will Deacon wrote:
>Hi all,
>
>This is a resend of:
>
>  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593559.h=
tml
>
>now based on 4.19-rc2.
>
>The Debian folks have observed a failure in the 32-bit arm glibc testsuite
>when running under a 64-bit kernel. They tracked this down to sigaltstack(=
2)
>enforcing the alternative signal stack to be at least SIGMINSTKSZ bytes,
>which is higher for native arm64 tasks than compat 32-bit tasks.
>
>These patches resolve the issue by allowing an architecture to define
>COMPAT_SIGMINSTKSZ for compat tasks, which is then used by the sigaltstack
>checking code.
>
>Feedback welcome,

Apologies for the delayed response here - conference travel etc . got
in the way... I've just tested and I can confirm that this patchset
fixes our reported bug (as in https://bugs.debian.org/904385). Thanks
Will!

Tested-by: Steve McIntyre <93sam@debian.org>

--
Steve McIntyre
steve.mcintyre@arm.com

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
