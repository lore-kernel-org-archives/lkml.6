Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23D2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671EA206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="lpOUIL20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671EA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeGTXgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:36:19 -0400
Received: from mail-eopbgr680118.outbound.protection.outlook.com ([40.107.68.118]:59857
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727518AbeGTXgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeeLMjNI9729p/6J4BkOIUQ0hV1G9AJAOlCyXMbo74A=;
 b=lpOUIL20ogrdTdvV9YL+8+qkHqmiQkHNT3Mx91ewcNhLnXH5kmFCYCMXu8h9xxmUE6NDbIKF+oc40XFxVQAecuvtFI/YVucuDmpptXZG8tjnOPPOCHIFibg+PnRMQj9t51vZcYFI6Q8Gg1Y5g5l1ON3kSK6zA+rmz5KTT7DGd/I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4931.namprd08.prod.outlook.com (2603:10b6:408:28::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Fri, 20 Jul 2018 22:45:53 +0000
Date:   Fri, 20 Jul 2018 15:45:49 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     jhogan@kernel.org, ralf@linux-mips.org, hch@infradead.org,
        okaya@codeaurora.org, chenhc@lemote.com,
        Sergey.Semin@t-platforms.ru, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: mm: Discard ioremap_cacheable_cow() method
Message-ID: <20180720224549.ykwuwfam5ud7trho@pburton-laptop>
References: <20180720201427.18845-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720201427.18845-1-fancer.lancer@gmail.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN4PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:403:3::30) To BN7PR08MB4931.namprd08.prod.outlook.com
 (2603:10b6:408:28::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6669c11c-3d7c-4634-d9b4-08d5ee928cc8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4931;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;3:lyQIaxrsG5lgVhwOJ8dNwf5tB51gbpqZmOO1pXAEPeCqcAaOeCPvReuppRnXf0DhDkcdjYBO8F4uVki3i44GsnaQza1p/FRHJ4BMTgPUnRDOcaIQ1AjhZle0NZsf79Jpv5j9pTf7LW0otfmogytV0EVnbEYveNkd3qg2gl7GPcQ6+U02KMigGsy7PT0m2G+uba3sFdR2AxV0dSMqSvrOGk4RRSm0dgu4vuWZ0CfQf55WfwpCLNwVYPsnNqZtFIC/;25:YFqAPL5wJjA46ZwPNhDvljYjxOea6hA8IyKadda5kBOAugutNudvwQsaf1J+iIE4ZJM64NG4WwUX6S7RvSKyAScUNiqHhxbSwuR5E/5YdCo6MEGhPPDm4wyjzG+tu16EtZcOYHt35NaHL1D73K2vh4mF74UbFVJ/Ll2QS8dHCDRWcy5jhNqtronSXABUtBbefkz+EWMeEZaRyIa69wvsskJroAdieubUZQjgx4TSE/fJ282OX3UKIXS7+zP36797bRfUHBzRYcOcrrRo89iFdt8Unjk8eOZH1xDVgiyQAGlTTqtUj2UH9yujmEbOuN7M3Twb+/LVml7JsKGNiGR7Ow==;31:DVKI0bK6px4Kc6vqyxNgBzfK8x5/vNkzI8DAjSvknONQkPFxlw8yt5gbnTXrHGrdSsQSWIqf2VzviFlARUhLCw2CXSPodf4TyA++DTe5ksc8sEZ3+u0hy0tMvMWkrdaCHxKH7RO2Nrk9XW/TQILhGVscw0VZkAQ2BdFdslYLTTirUxEpUjpyzRIRqEeuszWctlJahO8pVydAiZxSwfxptqrT6uUkLuDgdR8gMSxBBRc=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4931:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;20:Hw5rZCgiI47xuwqPfZxGXau6J/aE3M9JELPvaTy54Zb6YVjWZY9DR3I+ZvcSa1Y5Vnc1oWJknsw4jm2rQbqKOPvUVKVhicze6kVcRliwCKJUk0aDZ4LZY/sIXr2HCYXeNwegAlYzRYsyXG3aod8ENb8G4LaJCorMINCan99DK/j1Td4dabfJ8ATvTPJxD03M2bPLEVuH0+eUEDwKKjjIgodtZxjUpsVFt93FgqG1O20XeqLWpCeZLDqpGv6qVTlm;4:N8kRdDhqpIo3uG4xfXv6kf3tEHADW6X2AtiVrpau1JmlSF+erclvwR0GATc0B1AcXUIhrO6FdeX+/hBXbqlt1RRzZqUdpIbB0WIFxJ7Mw5pqEIgTzcqAdzocFC3n3PIFdBnCLgDVUZBPP662tC2uqr/lQstceaFHGUkVvtfZ1xhVJ2I3AjbJ1bkUQo9yRrAAMFXtR0Asw46yhD2I2MVt8GMKI69/hBfUuX56lhsfnaulyL7GLke2GMxvvmxgowYkugo2nACNS60bu0YzTTKjIk3/saHHIwcIAeNQbxpqEZC7Joz30jpVf8qh4dHFc09xQtXgzEvrRZnZqHFuvL49osj36Uy1nYqiCBjCWqkrvuM=
X-Microsoft-Antispam-PRVS: <BN7PR08MB49318AED91981C0D5549665EC1510@BN7PR08MB4931.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(2016111802025)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BN7PR08MB4931;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4931;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(346002)(396003)(366004)(39840400004)(376002)(199004)(189003)(81166006)(2906002)(105586002)(8936002)(476003)(106356001)(68736007)(9686003)(50466002)(25786009)(47776003)(42882007)(956004)(6916009)(3846002)(8676002)(23726003)(97736004)(6496006)(11346002)(446003)(1076002)(44832011)(486006)(6116002)(81156014)(6246003)(76506005)(305945005)(4326008)(58126008)(16586007)(186003)(33716001)(4477795004)(16526019)(316002)(33896004)(7736002)(52116002)(386003)(478600001)(76176011)(229853002)(39060400002)(26005)(6666003)(6486002)(53936002)(66066001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4931;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4931;23:iH7BxCkcNTSZTwOGeBD6xLKKgeRwkIM+t3CuxYwTt?=
 =?us-ascii?Q?1kfLRl2I5ln+Slc3YmY1lZdKUKP7h3F6D7EOPiCA2yKh8q4gDuzsfcolecSg?=
 =?us-ascii?Q?PomHRb//AKPvHVwWENYXggl/OfPXFPJTpXn+yTzus6OOmbAmrKB+QYBfU4tU?=
 =?us-ascii?Q?HaIWaC9zjvOgagWWynDQ+iUKe+Nkkx956ogEOHAn0aGVKEXA5VwINwWyoCc0?=
 =?us-ascii?Q?cJu7lX50r8bbqIB04CAOdcEUj2gVTyL1+rkV9O7UOtOTMv/ce7+bfdP+bdu8?=
 =?us-ascii?Q?H6zKHccxkyL5nv8sZvtOFBwl+v18uS67JGXjrxl/lCJjZ7YHk2QAC0VC7HqG?=
 =?us-ascii?Q?mkKAOxOvfB6uhrKLbnK4BJ4MQJx3p6ZrTIZgvrAzc15hh9XpoEwugU53Z32m?=
 =?us-ascii?Q?c6y+obzC2QollggqeO95qrk+2pyvVpM95D/zg+BT+FaI0ehNLUDkX5TRKVDL?=
 =?us-ascii?Q?qjpC2OOCChTd4AtgS6L6Fj0OqhN4kmVo10f4XhljDTYSIZTAROZWKWHVHNJW?=
 =?us-ascii?Q?2lVNDXDKEitdcyoW02Vrdj4jXzT19JGI9d+jSVU13gcQl/aioYz4r1x8lg+N?=
 =?us-ascii?Q?n4Zb4rUpAymwlxhw8q2Db6yCXXl4VYllegmgkFiapi6kOtI6hqvo4pty9FN8?=
 =?us-ascii?Q?EFh1xS8OY0h1tQoxZSyc557rcG/rZDbkZOsDAE/hdmpyqEufPfy2RjQEKCLm?=
 =?us-ascii?Q?LMSErBTyw/59TCM5eSAseBSpIDiwPVBnMJo8dX+R7Pe4DuZRK3VeiMHm6FLn?=
 =?us-ascii?Q?BL11rkJHkGRBiWIqSAJ0vKFnfAAFaq2ANEOvhvsLl/hlPQ+I5SKPGdMYfF7v?=
 =?us-ascii?Q?IB9Y/R2TUt3dbSovu7wWOuQHLbCJctZcsQv3nzWU5RYfm1IAkyvsyx04RMM/?=
 =?us-ascii?Q?r8xRf3b4Zg8gemSEkAbjs1wJMG7/n9ppjB9OK/mrCMetMcdZ8Q6YjKOJvVb1?=
 =?us-ascii?Q?eIKCxiUBqGbu3mECaKZJVyFhqtA7/1V6Dofz6NmIGuSNd6c465LirMDn89If?=
 =?us-ascii?Q?C1QP8VJeRxoBUWCGWdrsOtNULJ2dG4HBF7K84UECyt6OgiIDOQ2gSkzkNTaM?=
 =?us-ascii?Q?GYxydgKLEQJH5E+k7ytDoaiCz7ceCFed1ILbMlcASElqtXVcjmH6l0UZKnha?=
 =?us-ascii?Q?oJptxWK2kJmbrb0HJbV1PEtzbxIUaJejRJ2anPvzSppIWUfop/ZeegpNpx+Y?=
 =?us-ascii?Q?tzc/b1rXMWiRLjkgWMuCDLvbrasKhiRCHdhTbq7/Y1K/nCWICY2U6EqyYxnj?=
 =?us-ascii?Q?qWSO5f8GSpnmEzIRUOohAeiP2etsi41SuSb1J0m0Zi38YIMN4DEuSJOGS6Ze?=
 =?us-ascii?Q?G1TGML/VbWpxAL29GjhSGI+CmJSn912hLMTz6wN1vBo?=
X-Microsoft-Antispam-Message-Info: hKvVJ5LTxVAtlXV+91oWRh4b2wZqPlE9UesYw8XQ6uP0YWe3H3gPPLBik3eR7nm6D5jJxaiLvNh/MOU6de3lzTwZFHf2T3wTnEKthUGScwOZqqz8wVxW8ZYA6kccACgEaxgxgfNLsgKJpsJoFxMbHjyB7DN3jbnpTxnAJAZsOA8yLj26yyGTdHdTNX1LU9AJC+UTC+1SNA8pXKFaoIOxt97C4rAGPCpxJRmVlnZ882s1wCR2+VwxrkqWWdRMgyKOy/ObgLpUrmQFkQ7G3V7YZrxxF+wHoY1s3KPKEC0ILz9Tf1pcY+ePXsHXa7Ayxoh6RC2IuwdgWWOopQ0475NyZj0lyoi6B+j2FEYeaSLkGgQ=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;6:1ijGn33JeyGBp/a86htPk6FGkyiXog3vgo48cAWNI8aWUgJJsSJJwM5LS+d9h4N98J3ncaNgJIfOo+hCWUBAAlKjS0XfYtCpJC027uBaiFNTI6Ht70Va2Vt9zMx1n5lymkOcxZrfd0NraccYYW/KXklbxALTafXURTECe5XN+DIt4BMQNJLjuRgnTQbzRJIzYqJ4W9eT/VzibMt2EOwdR8a2ocfhH/ztqTyCig1nDDnT49dFbZut1Xxnba2NFEunF0yqh+WkJPTDgQ2gTvq2Kt3Isdz0hU1QNuOpo2h0iWrqluZUl/vs/mnYlYBLczau3gPxpJFqBKbD/28IzsucGNpVogeL1jMP6qb9KmtRmGszKN9O3Ff6hNthGJR9BwsPNfaprHKtLWeYTwpjsfUFMEb2AjEdXJBQQMm4H9W5REhdvgmFsJhJTYXfqU16S+jX2FMWcm6FAZIM4dTQklm/Bg==;5:D64R4uR4NSb9i1hlgBOslDm31MUa8IMXhXL/aKky1aLxLaqQCau2ZcQoHVlqdo5o6YqG6ImxdJSQIEqhHvjg6tRRdhKx1/A16vCnBL23H+9PFKtnE+TE6BsIHp++vsxYIYQoeNFSdWUfvKByFkBQMnoXT1pUAo9ypHw4OmUrKKA=;7:iQWbx6cCxKTL4s//oFeKxbTkIkfsysTNS3KzHQu3QTqEGTBm2k+p+KaEN/VDtP9FzYiRWR8Y4a+APLT+tnPfKKLpAbnxU1HBcEgbXXvFLV4D6wa91rsp7rWLYvFgNH+krjH+BdtLy+T3piN357o/GetMcm0SpHoEjAjgS3Zcz8p5QIWheYbQjN9y9W5fY1Rgt3vHFAKzAAGaPuhRo9FeSsmijbojo7S2xmdryAdcgZyZRI94DTzGx+YKLibnlhFq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 22:45:53.5214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6669c11c-3d7c-4634-d9b4-08d5ee928cc8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On Fri, Jul 20, 2018 at 11:14:27PM +0300, Serge Semin wrote:
> This macro substitution is the shortcut to map cacheable IO memory
> with coherent and write-back attributes. Since it is entirely unused
> by kernel, lets just remove it.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> CC: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: Huacai Chen <chenhc@lemote.com>
> Cc: Sergey.Semin@t-platforms.ru
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/mips/include/asm/io.h | 7 -------
>  1 file changed, 7 deletions(-)

Applied to mips-next for 4.19, thanks!

Paul
