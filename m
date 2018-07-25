Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81EDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D5320856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="bpXmgHiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D5320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbeGYBnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:43:37 -0400
Received: from mail-by2nam01on0092.outbound.protection.outlook.com ([104.47.34.92]:19485
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388441AbeGYBng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLfXF7WZwq4rz00dCCrZNbIKvMc2gH1Et0Wf/Ylt7/M=;
 b=bpXmgHiDj0dIC/IB4SOkfOBXnGbxJ5mQLNWDDFb1p3t/b1Zc2h1woiplNv4WB9ifmK/T+ZLiEjfB9vJaWAGboQ4ZDykH6jdb72UzZzyxAhFoi3CcFItNk0EuY9sd7RicSfyFc9eqzqGUjMTZcn0qvHS3CbjXZPGP7yTxYuYR4aM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Wed, 25 Jul 2018 00:34:32 +0000
Date:   Tue, 24 Jul 2018 17:34:29 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, jhogan@kernel.org, jejb@parisc-linux.org,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
Message-ID: <20180725003428.jsklz7pj4m7lj3m4@pburton-laptop>
References: <20180705110716.3919-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705110716.3919-1-alex@ghiti.fr>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CY4PR19CA0027.namprd19.prod.outlook.com
 (2603:10b6:903:103::13) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01fb5f52-30fa-4e62-feb6-08d5f1c6641f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:0f443Ub5m/RZKwAx64ZMGzyvjvGXzt6voB1AcPTJxVgmx/zp5G1ZVKkmYQZMlDINB9p40gQbe/qeGwpPHhRzWYQxQt9JWqeI6nffXz7hZ/NkvY6zp8MpbQIVWiDP25htRjZs0i0cNTpyp3O3Tf52STrSwheBzA6kx7qx0vMuOW77+yjwpZC12Fl7Httiqi2OQh60LtXGqKhnWlTEnT7xzq4LUT6Ta/JB0QZyr01o80+RRPhKckPXHCL3zHH5Flw/;25:4AR6Pm1/pIOqUBSDID7+eqy7jILsWVBxhYb0yJE+WMFckUPVZ32d6/ovPwj4ITjwD3XKQ/naf/DLzObT6GJch7zud2ehfdzsqmqKV8UtbayV18iFeWrNLreD3P9kUQs7PW2Ed/zxgS/7s9DlNKJuG4azCymoiq9J3W3N0q4iu3mrKtvGKIXyRl1S6eBg5h2xZx8Lo2VxAoiTJu8cSRcAfhA33CCC7cxeyNl0wPyrFat+xV3ub3QyTG3wxzC/IIWl61ZL3hzycQHuyRfJ30UrPvDJ5vgOQ4VdZkeu1ZPCdl36Hu5UD7aRH6dvBWeBKeWvWtsCyE9PT8pBAiFHQRbwlQ==;31:gN93pqNAlJ55JqJ+ik7/9V1mGWcF20dzwiyhco0x/zjdRaPhKHvjAmUiXR1W02eAr8LJ0zoCaMFHhnymNMKWJDESQUAPLdcEP+OmkrFuzP67vz3plMfJgFyfmqMUBnrH8qS2zlzJGleIzzJxUIoEcQSvAQaN4ArqladycmitG9J79u/Wa5Wfp0ECgxNiQoPUMqwtwniypKCX8fkKfO0RNkO5oYGDrWjFG7NqTG/Ydd4=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:q6LKqlxqUxCOSgncPrgGUQqQlD0tbykcp0acG8So1TwSTQr5aWchmghCc3SbFcfF/hxecLtdmi2z5Gu29b97+G2YsaWVnTO8wXErzA0twVc8s3bpc5fLrtCCEoM707qWCLcWOoOul7wvgbV3+Yd90Ki15vG/t3krGgVd+44JxMbpnaNRCTkc2IOGwOmBPYa+pbcc5WmjKZgMaTWhSPqeKNxyNzSG8KFj3B/G7XEMOO6lrsNqSxdi/tB7U9yHzlBh;4:BA/ouI43UD8iBWYeccxTRCxOD3i1OA4LCiTVOvisXK6IMM4GdWA928b7LbPuWsxVK/RwKGau5ioCYQjs6jyLGEAPT7PseXZV4Tt0fYX4xkrYxFpJJi+DoJ6RkXMoSX4V0FQZttRNgNn8y98EvkQy4j76SNQuqFNl5t+35oTWb3IEkWtgHLctCu21Cko5wH3wN+j7Ta3+Y6MLQH5GnqyaWITH5L7/ww+3D2Rgz5aEP6UrS7lh44bZbEb8vOoOJtC1mMRIhq+12GI3i5deu+FAcQ==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4932207425E72FA779B2051EC1540@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 0744CFB5E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(376002)(366004)(39840400004)(136003)(396003)(189003)(199004)(7416002)(50466002)(7736002)(76506005)(105586002)(58126008)(16586007)(81166006)(478600001)(52116002)(6496006)(316002)(305945005)(47776003)(76176011)(66066001)(26005)(54906003)(33896004)(386003)(16526019)(7406005)(229853002)(8676002)(186003)(53936002)(81156014)(6246003)(106356001)(25786009)(6916009)(8936002)(33716001)(2906002)(23726003)(9686003)(1076002)(3846002)(956004)(6666003)(97736004)(68736007)(4326008)(6116002)(446003)(476003)(5660300001)(14444005)(486006)(6486002)(44832011)(11346002)(42882007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:ykWb0C/AZifqLurPLgdiB9kTDnuxwzRZFAnTJZ0uJ?=
 =?us-ascii?Q?Ppms2DDzR6SGY6QeeOycT7edNq8qRtyTTNBxlYBdclA2wRN2JnkdL73rpU5N?=
 =?us-ascii?Q?TAab/SHx5REKpQhUuluuACB6NEbVNZekRmb+23L1AK4T3638ofA6OrYpofpY?=
 =?us-ascii?Q?taNm7WW41t/qLggZY+gmJybFDevPwl0H6yFxaJqOXJ/b8F2W4wRdSHM/VTkr?=
 =?us-ascii?Q?2JE0TwEmSHWdrNGbiMyRp+5mELxYmsksj2dfBY/10eYQEugmydKlcyYoOKka?=
 =?us-ascii?Q?by3QzzZhqaOBZClnhoz+PIrN/xFdFy8n7zT3Nq7AIIDqZ7oV6WmKbtMom+wb?=
 =?us-ascii?Q?1CXKfxBiktM6vo0fwYXWZLAt0Tl8D7Ge92k6ENeLvbsXwSiiX8hHUqcDDWAg?=
 =?us-ascii?Q?TOHZbUubi7XzF9hkUzjEEufJnMyVllY9J2vlRt948x4NYfOUjCejPSw9jzjW?=
 =?us-ascii?Q?R7b8og6C2kmCSeWHMW4tEMV6inUwZC6z0joR/Q8zFF3qHZv354HZFQEGBpvl?=
 =?us-ascii?Q?xkCBHUZwB+h5AW+Wjdjyzeg/qeFRSox+KLxvtBA7cIlR1OjcJrGRISMQJyqU?=
 =?us-ascii?Q?e07RvP8fgfK0mjixbz/RWLYjus2ehVhpdtlxmtO7knO9d6sJjWvTCroMA+O+?=
 =?us-ascii?Q?Yn9Bt/14ZgIm3vCiaLsnH+cBvD4pyh9qJ0DvMNd1/5xoj7ttThnRO7WlzKvd?=
 =?us-ascii?Q?jMvQKGHz2zh6H4Xk5Hzrfd80eJq6OD5tlWHbhMBk3OhqPckfaEhPoZOoIfVQ?=
 =?us-ascii?Q?yIvPedDPJwD0bPImfgE7XISqIY74D0xCOxlEjWfo+IfwnnMf9qe67EaPtse6?=
 =?us-ascii?Q?Y7cwuYr2PpoQr2dfbbH+uRFd9XV3HhxT4Nu8EmKzWfe+Fmn695llSMN/wokF?=
 =?us-ascii?Q?W+nw1rjinoTRDGiELSOCm9xOIWsSMeGw4FHsGDyG2L+VkeFW2EtG9HDjgRQq?=
 =?us-ascii?Q?h5xMPlRjbTjtc05YaAMePH+jyeFZ36C7Bdpl+qze4unA0HCpp2XZP1D/qHBe?=
 =?us-ascii?Q?++E5NCeLEGASlleuhEoqb5mzOn+9PaYqx+WthKIMHyRhgM774xxRFsYSHp1W?=
 =?us-ascii?Q?wIkvIdKz5k+w2VjemXY/Xk6fIHYAEUaoFS6z55i55a0OY6rxPberpJfH8uod?=
 =?us-ascii?Q?HZeHnRTx/0lrcikA+hlaUpbzGY4nJbdTV6RrCtNYopYE06qz/kLQJoRhvcq7?=
 =?us-ascii?Q?ff3aDcl4CDbvtYD5AZjHqtOPUwMGISZYlSihqCKCU7y7fodwmhv++Cdj1QBw?=
 =?us-ascii?Q?gkB5aMVW6WOQoK5FA0FGLWeMfZFbmu3syajJY1xj3X2RM2oRJAbQa9niWmqs?=
 =?us-ascii?Q?O/rzfjOMFzuEcKO0mYMPoBrqBTmwsQ0WqYv0tg7gB1scdTHHAyWwcWjN/+mg?=
 =?us-ascii?Q?JwQYw=3D=3D?=
X-Microsoft-Antispam-Message-Info: +5YB1DRk88IY9SbJV3lgLNZTNElE94zMFbaZu8n16Dpesj6oyPM7CKmh/XRn0sI+cXNW0ZvcBxLOHgYDHCTAH0hy2c49wmDr1YQxv3QbX8XiULbZKzrqvvefdVTDHKGwc8cXA5z3i+R6poECWDYetD5MsqUiyeeZ2GEErhy5eJzpT0agLnfAev/R9EET0kOUsib5Feen+OIrnPXLNzjVnsp0oDsiQPifL9/Ny5eVLNEnTFMPFzjMd18kV1J0F5zpvvSMTu/KH2FV55yAsgfXiLrGHT+D+rlmlhp9CKChNDMgf1CYkPM7pu3khKQok6n3DhtGVyOm/zaCS9G0S+iARKJ7NjhixRCIjMsRPSnrh4A=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:c0410fq5yUiqNK85dbEuLO/zpj6NEeigf+AFB4t8+EGyfnadIYAm25z2sSp33+MoZ/uFzv54AqVKjO6mPh78gEa0Gl203BuIPFshOF9RbLN579CRc3FlcZ9NHO8mGgb3I3lmpmZrAztHuqZviBVNDIrlI7pSBjg0/BU6/o+aauy3zgYqyy2+Qu+5rAgmKYIMeW2hG4sCeh4rF2yMIQcehpIxbbwA7t/JNuKU1hPpisUlTZ8Dv4Zv29U/+rhIn5HKGA2WOgl6zQYQHeYKUTGzuG5UMlUGR4+C0meP0GKMrwTbBAw2ZAcxX0Vhwjp0MtHqjb3YvNuQb9wGv1fyrs/dXwZFrXtUjGQWhu1gU/+Gowo52iIXm8h1mzpHM110mI4ngDC5BCAjhAyWOw5SgWngcqALrDP+27e04yUKkzGdm3T+1aGlWugQSWbxyBw6a6Dg3ypzJrMO4UjGJ5TfGVh3Eg==;5:bvpOPu+nmcPW/B8Y2XgVTCZ7x0Fxb3VaSpk/0zgF3s97R2ec/itJjDanboIpHsJmxh3Ju6BOGZBizFqV7XdfR0vRgDd0170Pa/CPR5C5tx6AEITNFpfxpOoxYD2U7DbjRHxu59HBJp52f1oTVl91le0Fo4ggIzaF3zUrRCnZpZs=;7:qsbrhbh2hlaVz27iF1pahCd7FloVJRhonEg52BvTX6NKSRlqOiPpJVv7vVDt5NofTlerS9FNik7/mR2dJUX5Lyxf/Ib3JSmy/feyXu3objTlG9Qll/AwTq5iepmusjKbIXDDfNA27Xms0Ac1RJaw8srApb0fNdv7j+wwV28gBVwTHY65Xn/WgDyl1XNVJkGAtiabYSrQas58I8+y/QqRJFwNZ/dlS48fj0Lc9vZ+VAs+1oAhj608yTZWtohX2Tn6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 00:34:32.6488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fb5f52-30fa-4e62-feb6-08d5f1c6641f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Thu, Jul 05, 2018 at 11:07:05AM +0000, Alexandre Ghiti wrote:
> In order to reduce copy/paste of functions across architectures and then
> make riscv hugetlb port (and future ports) simpler and smaller, this
> patchset intends to factorize the numerous hugetlb primitives that are
> defined across all the architectures.
> 
> Except for prepare_hugepage_range, this patchset moves the versions that
> are just pass-through to standard pte primitives into
> asm-generic/hugetlb.h by using the same #ifdef semantic that can be
> found in asm-generic/pgtable.h, i.e. __HAVE_ARCH_***.
> 
> s390 architecture has not been tackled in this serie since it does not
> use asm-generic/hugetlb.h at all.
> powerpc could be factorized a bit more (cf huge_ptep_set_wrprotect).
> 
> This patchset has been compiled on x86 only. 

For MIPS these look good - I don't see any issues & they pass a build
test (using cavium_octeon_defconfig which enables huge pages), so:

    Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts

Thanks,
    Paul
