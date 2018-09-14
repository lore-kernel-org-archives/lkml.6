Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93899ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271AD20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271AD20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeIOBJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:09:05 -0400
Received: from mail-eopbgr710121.outbound.protection.outlook.com ([40.107.71.121]:11626
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbeIOBJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTBOF57pRZN09jH/vRVo+eIE1dj7gUt6HsRqOr+Bv6Q=;
 b=nxWidZhdD7dt0lbBMktVjQYz6DtFwNaiXNwP34dHibY0SPx5rnXNj/ZFSZ8zX20H/u0j6kiiIbSydWklL2NF8S9iJJbkveFLkd8WL9patvg4UpVyJxWR4oJGx6kp32FtMOjCc7x+t8JTYAy/2euZfrTlIrQTsXA7F7JlkEy6zzA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (63.83.14.10) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 14 Sep 2018 19:53:03 +0000
Date:   Fri, 14 Sep 2018 12:53:00 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mips: switch to NO_BOOTMEM
Message-ID: <20180914195300.7wnmsph2qhpixm7s@pburton-laptop>
References: <1536571398-29194-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536571398-29194-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [63.83.14.10]
X-ClientProxiedBy: DM5PR2001CA0016.namprd20.prod.outlook.com
 (2603:10b6:4:16::26) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 193f22f9-f3fb-41e3-1024-08d61a7baf22
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:ubwlE5EsdXX7wcH8wxZIFsuF6dFiJQWYlAtnCR4bjzFq/JZ0YQuGvcFdhN19JhCtBUnx06oyW/pOxGfjld7GtS61dQ6zkG3YdqS7Yj755w8jSNdsjmwk7tvI+XYev3j8Mxl70u8wqSqOnIvVBrQxP7oYVZ7nAXvOdbzhJq2mEgijjm+tiUsMQ5wjYKxYv8TJtVtdnPmpCKDuzddJDJavwVdUAKeyIOqY/lzmeRw9j/b/ovWqMFI0Fn+BIsEtPv61;25:NUe29ecq6hZIm81EJwRgQ4CQP1zQqxZP/P7tXrsbcS7KCKR4WebRQWrrACvslnHESRQcgydYCqCfSeO/7tn4K3fT2lmt5lLN42kU367T9i62BsER5g33ICZMTXHAzDB95UKTHpcRT5PdNgmOcCuF4R40d/TCuIpOTxlNu5VVSsmKS3vdkiQB1+Y5ttNu0RI0m3lI3HRIBn1TvAb+CyWtsqlL9GAiE7ehPxW2HgWCDDkfsZsPrwsTE2Wwzh8cDM3ZazWSgzfTXT8y73EBclFq5uQfQTyfAwjmSSCLShzTwynoY7KjtQm5J6kCrioG2fkEmiYBWYqFpWQt3Aor3zrNFw==;31:0T13TmmYBmGDQ12raLakkteP9p+eU8fm7pcxw7eHF5D04r/84qVrsFc4euQQQ7SAsxlaDSpWjI2qa+87zc32Nuk+/k1QRxFKKdYW/rLVyEVm17KvlNMhzwLrCO1m7d28XMXp2gSFLb7EIMfgf2z/y3048I0EN2uK7KIWvWWBS3762dI5R8rR+GJ5Db/fiS6d4VtmflGNTZFhdQQWkqDEkiYMsswwykOVnmE33Pt1LeA=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:iFU3nTL4bAkxwuwgKPe2rOfUBAx2HZjGQES5YThiNGkAaOTifNQjEYj1ENYSQsKTYzp2fuYh4j2Zl9RIZw2f42S1Z7KC1CppjSJwZQcx3pORH7RvGKBq9Zf9YF2vpRPGT4ZX7U7UPQfF6sPB363HKuT56om763L14Y+Rsf/Ohkziy1vICj6REMX/C+p+KsNJE6/35qtpPGCkmWP9/jqFxskxhDQ8exEatz38M1DypQ4Yv4Ta2mZiQAEaC1iypezX;4:S7l8Vm4E4cWt6RkUdIg+KZjnYKin939hM7FXO7qzM/jT+WPOny69+vVOndNdD8U9DOAUIAr7rlOI3unYZtHW00hCup/poAS0d+wASfKZOmdgixvNcfVi4ZRGGh0LL1vahqDoC8b4/PGWvFYljthkW3eY8OGjx6qhtlpz4E61KdEufC6ROHcQit1oGmoeHTGn8kehLHqF4z5ru+ebfIyYyflxWqokeANb3BVtjupMWg1qrUDAsm1SSObzxVTF1KDglRQNO84HOpMa0XYx31aSSdBmjV+UEyYSSROmaVNUedZRFhn5+oRfYsk3HaxGUJ5P
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934616442D9E297481560BEC1190@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(39840400004)(136003)(396003)(376002)(366004)(189003)(199004)(6486002)(386003)(68736007)(66066001)(106356001)(11346002)(229853002)(33896004)(476003)(47776003)(316002)(16586007)(5660300001)(478600001)(50466002)(52116002)(76176011)(956004)(486006)(6496006)(97736004)(76506005)(6246003)(8676002)(25786009)(42882007)(44832011)(105586002)(16526019)(186003)(58126008)(446003)(23726003)(39060400002)(9686003)(305945005)(26005)(14444005)(81156014)(4326008)(7736002)(6116002)(6916009)(81166006)(2906002)(1076002)(53936002)(54906003)(8936002)(33716001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:SSvnebWv0ejMjgbqb/4t1Pp72gg2aITQXR69iHGMb?=
 =?us-ascii?Q?fdLub1AEFc/A7/EdIXTTHFrsSQQkC9P5RnifWMYIQuar1sRRk0CddYtzAl+0?=
 =?us-ascii?Q?NqqqKAkO4oU3w2Sk6Np2x2/FVeoAtcwEO7fm2kUeGjyYkIjjBnrADnXRs0CF?=
 =?us-ascii?Q?KLJX3xNJhyKX296XnPDG2tMk8Ekr8SzUcGjrJ+dH07/Eqc35TQ5v8toT2okr?=
 =?us-ascii?Q?Os+BLr8gQ1vE82tzIbDV0KdqBUqXeiIBKiTCOiONaNE5Bfj1UUDFX9nnPSBI?=
 =?us-ascii?Q?bIbJ68YNmjpQLOmSDKU8PcLzLX2T8wCtS31lqrR+2ul8s48Ra0ZQNmud5Xjz?=
 =?us-ascii?Q?gs7Smhi+FyNFKwwWhZmZY90d6cOlcOPDAFyGih5lwNchBXcF/t/QKqOcjxoR?=
 =?us-ascii?Q?eBF7pcfFh6xqvbdBuIp/kdzA+4/W+VWTadoPN9W4jo52pBa+rRBbYnNHzT7q?=
 =?us-ascii?Q?T9P7+7/eMzd8KjJZz9mck4QYEL6Ms75CQzy7gHaluVpwnzHhWrSUR9dehhZH?=
 =?us-ascii?Q?aojUtlggqPfY8DoVmLykhXo4T2BeUG3N9qEXFIrygKXausVCeZUZD3NplH3m?=
 =?us-ascii?Q?Git0VioTdMYRxnutF3crsJfpvC9z54jPulPFIJQ6g8D+45+pB+9+PjjJHqpC?=
 =?us-ascii?Q?hYU2N5etgbAMWCLvxgd06ZdakeyJODB4md/on3YcHy0gSr5wR+cwK5N7PLlO?=
 =?us-ascii?Q?BS6nRgf/l/ypqrDOhPQv3SAcwTSXi4tRVfOH431G3uwu/pVt6h0328BxkjKY?=
 =?us-ascii?Q?H17XF4BC3rHoOXkHrUXO2bk0XPRtAFMCo0gAbXmrul59W/Mh8iR4PizcXT4y?=
 =?us-ascii?Q?Y/Gfik1vzC2YjL8HL9f0ejYX86p+5Bsp36jb6hKGqW6zcqLhe8CIVb3tIi3O?=
 =?us-ascii?Q?hoLJ3JR26TakMAMTkqO61/uebTTfCZEv6h2LnP1UxPYzhokt5fbDMRs3pBi1?=
 =?us-ascii?Q?q1np97nI4jY5uGzl7SQAMGfmFKrCP2Orn63Q+a1pz6yJGSokZH3+FOkCiVpb?=
 =?us-ascii?Q?5x16Si/8C4YHwLwvmJpF4ap7V7h328i5G2GYF4aV0M1Y3mYjENkW+aaZjRL9?=
 =?us-ascii?Q?OLqKWFfxLxRH+egsuQSklpzO2pG8yOi0TUBmO5wcf6WCGRYKnTmlt4E65SRL?=
 =?us-ascii?Q?EKbOC8fhCUqy6Ys1T2GXCbvYUpixfmFen33J9pgU1MJRfjoUGwWQd3uX/JOn?=
 =?us-ascii?Q?jVNKyiwg+WiWz8E7bV+AQohF5B5CkQLnwxspby9PNVSWo067YJNCb+8nPuKO?=
 =?us-ascii?Q?P7Fn0wWESzfnnuusWojwcEPbJ8mqEsqv6R6AvnyT4ZHui70f2w4paQDt5yJn?=
 =?us-ascii?Q?ocxVlcsx0mvpYWd6ABGjZqSnvuu8KAiF8AIQuyeRCEx?=
X-Microsoft-Antispam-Message-Info: CEWGiZkBtJjiSy2szz38joCt1/QPBbPfEyU8ovU+SA/SfrmbaBR0JQE2ZctMlJ35P5L81g0bkg54GkRYM1pgGOmiogEkA2KZznFR3DsFs01fkwIgsQWMLC5Nn44A+v3kwPZcnSzV33AS1Dh6oC8a8p8+W7SBrjOtC8Shku/IzUKjc5AIy6sz0Yk/69J0XD66DE4C9ZX51rqW3fxe97XyDXfWtkT5GCbBvh6Xdi/LNUL347qWpnqqORXdHAqse4+QnyHx3HecUis6A75ntaE0Q9SUAEpCmfpYdomT5EUrD84yvqbcLDPIXNtRtyj9rdLnw9yYVwSfN/e1JBlLNif9x5kZz5ILpeeG2n7oPDu/mAU=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:01MnLsezWVYPYcChaCUivE9By314IJGQuSJQ4hUZjZ7wyFjm+xhK4hSxwnoU+i+01DqvTuE4Zq0QIT7FpXkYJCZZuRgoTF3INhy+2aNpyJV5Oiu48uWs/oP/gU80SYmkvZKAQOvXcqZzpPUsWgQDapVn6fEkaozYj50N8kG3A0RJj/K2NRkvazdvgFd13YzJN9MwYbdj43aUgZ6eGtrBPx/hvK2U4L/gbRS7Lru9s33p+zMHJClxWGuMb02zNLJLRTXS4pZQQCLFi8fTIH3sw6YQ2Hh9iQ1MOxkjOfOA4EEv9xTKkpWveKWy3W5hi24slL+84faGOMt083SKubkwqoWWhtSqwYXpv2NxLoil45lV3hqX52kiOKgidGHCBA7yNg5JgWVCaNKU86zxo/k6tun2vefI6Lv/+PZwiO73/VKFbniQyeAS3JuvgWDngVl6AhhMGpVXIqZ4mvDEbtXUSQ==;5:LWZLp2XZfAx/dFdZzJrkP3eE/bLLdEbY9Rtx0pAE6kic0V/cKacOnSXrgl1x47axGKgz5Cpj342H5YwIp7qBvHALJ1GRgOc4hBnlDHeZe9f7uksa4t1Me6rzVSOAoi6QyaTp2t31jyPytfYlL9orBPXZwFrqzG2Dfsnbc63381s=;7:XPysvpPJItubq3D+uwe5h7OZW7LYm3AevnEVal6DlH0R33DpiPqlVca25llot8DfHPk3bZFtXEOYfNmNiN03FrMkFUPIharbcabAAQfO5ySYzgovWs10zEPt1OeC/uN8aVPFATvYxu4AehDlAWxqgv2LyYjc0Vvrd/DpAFlfAOQA7KqjbyTlhaiYrotCqk44yvaHgk4lIU9pXAXzrp8AWhsN89lC4/5iytPyNYwQDUxCGqxEaSXHYeJ/pu10ZvIN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 19:53:03.8686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 193f22f9-f3fb-41e3-1024-08d61a7baf22
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Mon, Sep 10, 2018 at 12:23:18PM +0300, Mike Rapoport wrote:
> MIPS already has memblock support and all the memory is already registered
> with it.
> 
> This patch replaces bootmem memory reservations with memblock ones and
> removes the bootmem initialization.
> 
> Since memblock allocates memory in top-down mode, we ensure that memblock
> limit is max_low_pfn to prevent allocations from the high memory.
> 
> To have the exceptions base in the lower 512M of the physical memory, its
> allocation in arch/mips/kernel/traps.c::traps_init() is using bottom-up
> mode.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
> v2:
> * set memblock limit to max_low_pfn to avoid allocation attempts from high
> memory
> * use boottom-up mode for allocation of the exceptions base
> 
> Build tested with *_defconfig.
> Boot tested with qemu-system-mips64el for 32r6el, 64r6el and fuloong2e
> defconfigs.
> Boot tested with qemu-system-mipsel for malta defconfig.
> 
>  arch/mips/Kconfig                      |  1 +
>  arch/mips/kernel/setup.c               | 99 ++++++++--------------------------
>  arch/mips/kernel/traps.c               |  3 ++
>  arch/mips/loongson64/loongson-3/numa.c | 34 ++++++------
>  arch/mips/sgi-ip27/ip27-memory.c       | 11 ++--
>  5 files changed, 46 insertions(+), 102 deletions(-)

Thanks - applied to mips-next for 4.20.

Apologies for the delay, my son decided to be born a few weeks early &
scupper my plans :)

Paul
