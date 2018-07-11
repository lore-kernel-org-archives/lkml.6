Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEC8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14DA20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="MM8Wn342"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14DA20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389623AbeGKQVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:21:05 -0400
Received: from mail-sn1nam01on0104.outbound.protection.outlook.com ([104.47.32.104]:30352
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbeGKQVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSCltipNurYgn+YNEeMjYVz6rDn3251dslSJPyj03bA=;
 b=MM8Wn342Ve/zU6+HpYWybMfCyqFk0elsQcS9uEvg/LmqhQit0rByYXaLyTfenzXJg5lWad2zhbFTGaAnQoFxKSXXlXphG42oPG6yN5LvHXyHOueTKPOg4yg9fspgussVKgL4Wzcq1Xs2LFmrd2+NePX/vhjoIvy2tPtPCp3rOcM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4935.namprd08.prod.outlook.com (2603:10b6:a03:6a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 16:15:59 +0000
Date:   Wed, 11 Jul 2018 09:15:56 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mips/jazz: provide dma_mask/coherent_dma_mask for
 platform devices
Message-ID: <20180711161556.gmxgfo7y46xbdw7z@pburton-laptop>
References: <20180711113852.2734-1-tbogendoerfer@suse.de>
 <20180711113852.2734-2-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711113852.2734-2-tbogendoerfer@suse.de>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CS1PR8401CA0033.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7503::19) To BYAPR08MB4935.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1fcdaea-51fc-49e4-1a6f-08d5e749970f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4935;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;3:uOA56X6/ImjCS7D/YsLpXl6GzmzeQ+sPZK/HOYqs6mi5ZAp1y+yvyByTqKo6sePUkuWdPM+nzaqKX07syifrhmCA0ODJ5+xIKgIQPxwSKkZLdFHd05R9aL5B4TJsuTZmg3fob68OAQzz1JPSGajrpukthranoBDbwLxMest7lfyPXN4TaHwOIhsXeCopy8CcvyjYarzzksy5RvA/XFgyeQIaGCnQz4waynehsC5v4xrwRRjYpWW8D0XeCr2b8aDq;25:oBsl3btayhHNB7t3jMANcWabupAI47NgEa2KBgErkx/4HB4lW4xhEd3ED1IoMJdzJsksIaiobCtrx/vtuYQvXnoBSzuudFqOhBxUAE6cPcaT4Ag6uyureizn8BSckbsxmcQKDx8x9KPa6bJFvDTSgdVGTvakB15oMdRUpQxrE6UUtWRS8dLeGvpRXw3NP4GiO/lfYeJBrwJPBOkgdRr6607v/dMrs7wvQFcrNOL3Rwj0j0RHASuH78EiEMp3R2S5h2X9rW6+mAsWGE8A+YbhsyFrxi7h71IVJ+ZiTXEu/S2qctuK/O1zEpNXi7YCbKaID03eCKuGrDWPPEE4Jb0Uhg==;31:S7z3dC3ImH+zEDB2V4m8LdrZjBarkOUmwxhJUJRY9KxknxzjqtBtNT9u1GWNiXSbURcS5e1zzWRuChzA/enniUxAL1taTWaggitDw8ICRQIRub+gpA+zNm5glwtV0GflmOJwm1cSiH6EfXsy/KTfhwW6PvAFsa3X5uwFm+2tGengtD5BOjxvYTus5englzsqGwzj0QWfsKloQ7z2uTqzu2LMHIxeh9hMVCqqm2E7XRk=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4935:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;20:2bPIaJRKkbw6vR2os8NSk9R6m3DtYS0fcLGfAb/3Qz9EYXHb3r8GviH/67WP/gBx8fk5IqHdgftKUOBT4+Tki+b5GJx1bhgu2UEl1P/o7ITbiBjd1Lj4aOl9Ic1wMEfxCJhLqaOiRb7tuhsHfneknsmY6P5YuAdWOtHQB2O+WyRQ+T3H3VaLmq4uGsOgNZdSJP2may0VpEDQydRh0wqS57iN9DGzKmomr66/eL9C5qJMPFmxnL0CaaupTebbPz1o;4:yEk9UKRIPNQHLW3rxIgxe0BCXfVBbJK1yn9hwVohkWzeDAngbxtYFBK/4yWVksGyQHzOUFwkbVL5XhX7MmgV8J3Si3kcqsvtJa/jZpthbRik8LwRuWjW0L+sB1wfTHLraf6OB1Y3P5HY8Ih6B5numg5IqwL1Ikg+Wu19INUTKFVDvU0yc1a3smHbEcz+Dojbjdfx2bYpTryIXJHRsrc/o4K1rZoEGemnkFcFzLqvx5CX71Tt2bX1hi8OEjneyaiAvvSMtt51MGSSFvU3VJazFA==
X-Microsoft-Antispam-PRVS: <BYAPR08MB493575E9120ADFCD84C9AB96C15A0@BYAPR08MB4935.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR08MB4935;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4935;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(39850400004)(136003)(366004)(376002)(346002)(189003)(199004)(81156014)(6666003)(316002)(66066001)(386003)(956004)(25786009)(97736004)(76506005)(9686003)(6246003)(44832011)(486006)(47776003)(58126008)(14444005)(4326008)(33716001)(16526019)(186003)(42882007)(76176011)(11346002)(26005)(53936002)(105586002)(106356001)(54906003)(33896004)(446003)(52116002)(6496006)(8936002)(6916009)(8676002)(229853002)(16586007)(478600001)(5660300001)(68736007)(1076002)(50466002)(23726003)(2906002)(305945005)(3846002)(476003)(6116002)(81166006)(6486002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4935;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4935;23:fx9a/TjTupmxAxeE2iD167uNRSy3FhcDE3/G3Vkdn?=
 =?us-ascii?Q?dJCrMjLtPYpOKVbaoegcew3P70/66nrx6ClzgNwZa4ao13kxK0NLppb56DHg?=
 =?us-ascii?Q?rK081YEycUJblwpLtn7xQZDJ3GAKplew5nfQqdHFpR0/X4Z9VDu+WA28DL5i?=
 =?us-ascii?Q?5g93CtW9Tc9K2tRzkB6+pJBlN2dgBfljKXTnwFA7P1T75wbr1mQ9ncr7EwZc?=
 =?us-ascii?Q?bi8drANQREnlr3hrWi3aT2V8egc8IHqYIGykM/rmweVsvLX1EMjjOBdnf7Kq?=
 =?us-ascii?Q?ZSjy+zP57ormnnyCKcUNcN5s/jcyUWGxU5pCjTGqlxyXpfpVOXM3Zcfnn8gv?=
 =?us-ascii?Q?GUSCqsafHJKrW+FT7Rbh3uqj2NJwBcaRdtXfKNdp3oJ+qUWSRMgXV8h7/BzQ?=
 =?us-ascii?Q?w9VHt65VLzQOG+GFVP/o3JgUgkuo9YATE9T1T2FzRW6hjhuE0hWs0AlOUeti?=
 =?us-ascii?Q?Ei1AQ4R/oTKONW6j7SHnO3tgoIj34WTYleFPBfSkPHXzPewDApl3pcCnyhxB?=
 =?us-ascii?Q?04h8VXhtjdqBRWiR2RHrN0aNS2qy+E81ChbC1857l0ezNWMuQreNwxBce3jT?=
 =?us-ascii?Q?ZKvvl5JbbuLiB+9uff9ThUmWbXx+LTnj+jhqvky0PXRAdr2UEMDQmT7aFMzZ?=
 =?us-ascii?Q?tyX7LA/QQYt+Uw/Do0BdCIV0bTD4sXw7UUwR5YVtHDevwdlhRpOeMEbeXq5V?=
 =?us-ascii?Q?9QoSUs4iffIeGLQp4zkV4o0HoM6Mhv2G5HEcxR3N66zGfZiarhB5nvR3ePiT?=
 =?us-ascii?Q?EKLeo4ezyiWZ3sDwD1ozt52lX4n7aBHmW/CQ4vTEdf/ViB+ZdkA/RaXuIS4O?=
 =?us-ascii?Q?hnGopvXA3S0V1iBmjGtNK00gBsXSdmira8ReoQUdgUJ/beD8HfnWu/yEZp8r?=
 =?us-ascii?Q?7E5oYXz585nlOYI/tOxzZzR9GDzQx3c7x+o5s9bBIu/d280V610GdQxx+yke?=
 =?us-ascii?Q?U2juFmuNlkkgRbPuVBN1YC/7PXtlGkUWk0BHjzx+zcQrf9P/gcRDwImxx7/8?=
 =?us-ascii?Q?kQX24uSzYKxr96XtuI1UoV0RkL3nlb6s3Hkuw8zmurXIVbwjXvnbWp16NvmF?=
 =?us-ascii?Q?3As+EfdIsBEtJnAYoa/yz1rm6pC8wvzEQCi1JsTADaXAnFwyobxCEREQvLF6?=
 =?us-ascii?Q?ATO+fAMS3RmsLWCyPVYjt+c3Cr70ZQoH26xFcU0GPodb/pwso0FQWixtMTIp?=
 =?us-ascii?Q?jQj61inFg06rFF/igSvFhX7gh5HJwpxJTuzq+qniJoruJZTLaD9Lx2Uo2nm5?=
 =?us-ascii?Q?kgCPc50GFB/nM/2z3emt+5hU+24F5WEPNz7dXYJhayn1sWkAwFV3D0bbotRN?=
 =?us-ascii?Q?Lb+xfJTq7sjy4qTGUlEkuaVJbjhkpfj2ORRDJFJA4Uj?=
X-Microsoft-Antispam-Message-Info: x7czJ47GA7WcoMIJpesWA5IO586utwYRfiQnehPQFvcitIQLtNJkmUVMxZgq6h+le0cBz8Aa1ktBf+aJE5evFCRhrDiWRvwbxRLMX08ZISqVBARlPyEn/3vIWnMh3blesc7GqtyT+YEk4b4OzglSdsRP9woU/9TGZDW2nDAhEKsD22OpeZqJEYjv41HGAs7fP66UmT3JIS02cqvIPyOl2C1Gx2IBlJ0D78DjHE6H1fUGs2CQ3srW9M0DUsTBfBjX8QDBfMbIsK0fy8Fvmf60h9WO2DLsIPz82rpFkvKqEpE/4yuCVvDSYnkN1NAxgzfUZHM72IdFmemtodsdGOuop2J0rZkcRp36VElTuUbgkYs=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;6:4PER0QrIU6iixKbrAtMzlPMZvvtsQvlTNwyWqx9KLClXKACC4yxzk8MqU0qBjcikoo0LPsvT2tmrE6KVa3Q6GqZbp8PyyAyy3ezaAzOJE/67J1rd6+eGkJq2gP6cFy5or9V8zf1Sxmf76dmtqhZ0gP3s7bBtL1PhFPVuhM11M8WSaiYGD6jwlYQBdWsV64EbrN59hxgSzwJANfQrspvvt9UNKPAOhUShthLHk9Y6HBjOP754jafTmt9Oi66FFa9inbAIFrVDmBEJf30NT+d9MJPJ9SR2M1kYbDnprGsvmF4hWHnaSNzPrnYHPCGbhDD29MphqkobL1cl+HYeKKMFSDFtK1mYYy7VFKG3KIuQOPzYFadly9RtYPBlFnCiJNDhsTTIzDHno3A4sSY8mwfSzPLJsis/mDPOuNALMHUqSQikvHO1LduwcqDJRLBTCgafOCb4HsDIEEaDUikAlRB+5g==;5:TjzlP9jM5mONQ48vunxfJXt4VpHYGFQSx2b+ttg7+UtTGVPeUk3Sy79195g1NWB+/uVJ4XFFlF2r2e5zbDC2QAPC/8wdkRBsniP5Us+BcUxxMDckp1mPuhmo26X7rSMy3Xuk1Tm0hcQ2otXZh/+1ibf+S1eOH08H/1yGFoKFe+U=;24:ru3jx4RxMAep/lMg6B7W0vLMnS1uhbUjckGC3cH64fzPXo8eIROsjK94KVCUebXIDvzxtnpmlPRqwDX4mlExrHKDEsi6JjG6jaRrI9gUQ4Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;7:7ApHzm1QcSmBgwS7oPrIPy/u17l43SjsIgRJ9MQy7T+4vTPGPl6g3AXGTU3KE7XtReDIMWnKXUdPcuW3x+jdXrZ6tFHJf/TEnAPHh53h3kzIubXpvwgfOxBJ5X+klxDqdS0XCXg7VzcMuyumRMS826LwkEzxYs0WQU4TQ+FlTnSWGb/uIIdx1p5EH2w6WudrVrUB4Vs7wmfqqydtThgxMLB9pFlh9cZuXlwEYn5Ul3Hg5ufxxul0rhMQeUfU6uLE
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 16:15:59.4030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fcdaea-51fc-49e4-1a6f-08d5e749970f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, Jul 11, 2018 at 01:38:52PM +0200, Thomas Bogendoerfer wrote:
> platform devices for sonic and esp didn't have dma_masks.

That's a very brief commit message :)

Could you add a description of why this is a problem & what was broken
as a result of it?

If this is a problem you've encountered it'd also be useful to mention
which functionality you tested on which machine to discover the problem
& verify the fix.

Thanks,
    Paul
