Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26888ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCE9214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="baWRFTGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCE9214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeIQWxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:53:37 -0400
Received: from mail-dm3nam03on0070.outbound.protection.outlook.com ([104.47.41.70]:28288
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726865AbeIQWxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFeqRb4D31dmnxC915JhDdm7jgiHyOf9o5P/a39+w1s=;
 b=baWRFTGPpez5V+E3ZNoYmn8T1xXJK1PDF7mMLdu1ps9vBmKv2iXJcEtpS7v3ZjHLRqM/W9lsJ97jnN0XAW+sR/SJoeWQdA6CYxelQoKDUiI5hOi2gMg3OrU6RdAlvjPOxlAso+Il5Cat6OhHwockE2tBlBW8mEFqjidE3ffA3gU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
Received: from rric.localdomain (77.179.46.10) by
 CO2PR0701MB0997.namprd07.prod.outlook.com (2a01:111:e400:1435::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Mon, 17 Sep
 2018 17:22:20 +0000
Date:   Mon, 17 Sep 2018 19:22:07 +0200
From:   Robert Richter <robert.richter@cavium.com>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     will.deacon@arm.com, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cwu@amperecomputing.com
Subject: Re: [PATCH RESEND 3/6] arm64: add sysfs vulnerability show for
 spectre v1
Message-ID: <20180917172206.GA3795@rric.localdomain>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180827143310.641-4-ykaukab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827143310.641-4-ykaukab@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [77.179.46.10]
X-ClientProxiedBy: HE1PR09CA0066.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::34) To CO2PR0701MB0997.namprd07.prod.outlook.com
 (2a01:111:e400:1435::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2bd75a0-7b9a-4617-a5d7-08d61cc22127
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0701MB0997;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB0997;3:nngoF/WGPCLIr1ktJ5oYJmMzEv4oRLFAKrdT0O6sqZr8+bqDI1SkMfRHml2Q06gFY6J/Sn03uRvCyl5Mt5+mafbwLXTDkYB5qSNn6jTPvCfvbe3VssCWwbwZ6Mycikb6wu6E8df6Svbyj7VrzOAr0qhG0DeQbbD+WlyhLmwUJ5WOxp9zFxoZGmMi7CSUSQX+b7HWgyy+2866ZY/pSneTPgmNG0hAU9UR3wSvjEmFLwoOUnGeonkY7bPoW8NcroXv;25:mZwOUmUZ4R11hPsnoj8X/gcOsuhxa0qMnE4RJ/UhLFXtbLlK/2OOevCByuhJgrqq0B3vithjDNmz3tQY7fZ8gRphP4sLuU/+empm6fogeb/sX9JHtvyjeG0HDlFOCTOdNi5kWduNI0LC6F6zXW300FsN7OOxOqgdSvhgvvbjAzctqVdBwxFTjRQ3G7vdsAPQLP3DPGFhlqNeAqhj8QE7bgGtO5JTBFmCAmw6qo6kLUjkaWUdYFF7x+pPikFL31uVROn0Shupl1yqI/7chTF8GT0KjF3RiS0ymeq+93lpg5YR8MlTvz6OvhSba/j+pxvKoszgCIDsJEsZ7cMIN+2qkA==;31:lhLehGGxwGz/sQdnBYPnUS43q38FumCfnD0tNA9hUeYaj1g22Z9uMgP+LRR2UUx2wwsykg9ffki1/LgKdhDcYsZZj0tZnQXQkTEPolT0zfedn0HpXTUcEdtlh8Bv5jVqXskjGsdpK/pj04mnQOdUb0udkO58i38WIzY4LnvhYMY7/9ZUiJkVFxRDddQNt6D1IH8X3qu0i+uuQzxy59aR4LoJ2kF2AEe2BUVCo/xbAoU=
X-MS-TrafficTypeDiagnostic: CO2PR0701MB0997:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB0997;20:aG1qU6in/cZkk3BwKvndpRj3PEd9zEDkaL3uMBzQTPITUYJgrm5Y2odjQWKa5SaYlqoVUewW72OSt7ufHADusa9kSkE0gTMxUw3z+o8eEhloyLohDmvaZHvI49dR1Q1jxHcQYA6t1mUxCdSkCU+5ygQMevty3wKFrw8ne1Tkj5ogFgJP+GmqSEy0fakGJ2058FOyBbX1x2Sm3rMKzDQxPJAqIng7vAScjWYl0Q3o2EIH5dS8gLm+3DPGi0K2RuIliwTBDB1YTKTJZK3cMJp0s7+w6xbT93bMuzorfKJYMoW2Z7DMEXJMW9djpo6Y2T7mTk/Ecwb3BOhj5V7QoCQSLF2k5tKLrwPPPusz34zmnFx7WONy9Zg35oFJKc2EOChfcxNMp0WlzRkE6Jwb2Azxc9Qd+x7exYtlXA6tVEoD77R0WqM9BbeJRx6/ptk/uWQWSXBwxIXG1Wi9VkV6AbFR/vQmhc0kWNM0660O/Yi3pqqasenj2dpe2xgh6pD36+KZ;4:BKqCekf1ZG3Cx5METy9vOKQY1rZ1FhDNjMvqk0zL8TuMUG+uOKsnyFmApP1dWOjC0+fwiGsLqr02IEAGE1Ru+oP3xd7VdeuYrwjDbFKS0h3IFn/7TMSjXfUZiq0shhGXS+qTvVYbMvcFUzrVShIK5kKcOENfUxmb5JMAFjqLLn2XrOKKb4BWMbe+H9TjMHndDINpO7o8N/3OWSHk+X1TWjoa5/U+j1HmrzKZ7zdLqQ/rGySsrnQRoorf1WCCkuLbywUWJmNP7teGQPApXj7h2A==
X-Microsoft-Antispam-PRVS: <CO2PR0701MB09977D11F0EC7B0728B894ECF11E0@CO2PR0701MB0997.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:CO2PR0701MB0997;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0701MB0997;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(386003)(1076002)(9686003)(7696005)(52116002)(76176011)(68736007)(6506007)(7736002)(53546011)(316002)(33896004)(11346002)(81166006)(66066001)(476003)(956004)(81156014)(8676002)(8936002)(53936002)(3846002)(446003)(106356001)(6116002)(23726003)(47776003)(33656002)(16586007)(58126008)(5660300001)(72206003)(478600001)(4326008)(86362001)(486006)(44832011)(6246003)(26005)(186003)(305945005)(217873002)(14444005)(105586002)(229853002)(97736004)(55016002)(25786009)(50466002)(6916009)(6666003)(575784001)(16526019)(2906002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR0701MB0997;H:rric.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0701MB0997;23:BBCly9+PvfiuNkmIUj+AVC8rtuPx55DqSwuCAY2?=
 =?us-ascii?Q?4V0FWJMacnLRL+GStHuJs+R/AWjJcpkWIzsJfb6nCOhMUYhV/H4psSURBVjQ?=
 =?us-ascii?Q?3w37ENxrZVJJPKRrBzskkEr2Qv0vw80sIlfolw4B9x3z7OuFja29cH8kGCgT?=
 =?us-ascii?Q?oPHXJJTS1CqO+LU1y26RkECEOXf7TdskmUnIwh/SXwPFSq0Q9Fh+c9UjV5gm?=
 =?us-ascii?Q?OtC0JxSJrhl0QY/QTrfM0HakFTC1EF05m9MF/Oh6bRxgoCV3pFvSMpvm90gD?=
 =?us-ascii?Q?i3EfW+XJBXq/xuUXsMrmU0yoFtmO6qabgXRfWYT3nw59eji6atBXZKymHtpr?=
 =?us-ascii?Q?hwgN6bI4jEFOoNHdiYrcDKUzEgUYUgRI/Tf3s//DQW55gmQcBp9S2237g25B?=
 =?us-ascii?Q?vEiHh4JMorfrZpbC5PCl4yhsvQeXqMhkACJlfdP53ylBqDqlKLmYiK6OztXZ?=
 =?us-ascii?Q?ntrE/+XzXpP+3tWugATYTMytbs5WHjTUlGHo0RODh4DwRVn64Q9ph3xgdvvO?=
 =?us-ascii?Q?L7vbKakE1H7WiBt28FW7BWDvk56y9suZBBQhz1OuU4g46SF4hIYh1NUQfOjO?=
 =?us-ascii?Q?POovLF4lULeC35zPHA49WYFvxNsaTwEkBLEBb0hr8HJj58XgnNvPIb3tsxT/?=
 =?us-ascii?Q?nYqSjas5y+KwZ8cqn8DOwk9nqA/SgPhqam9Ed4NvsL23ctqWkiz8m/Cnj55I?=
 =?us-ascii?Q?0T0ywJNGjiSJJCFUnCJnyLFw5hZ4eqTo+nC6DMjyaMo6qWZOMCxD7aTFknlK?=
 =?us-ascii?Q?kfbfHEYQ+OZhj6SwjV+9kFRRMyjXJNp47MWbn7hQRJ7wUWEDzresVmWrES6s?=
 =?us-ascii?Q?pjAs7kk4CPDe5/KkY86cEsNGFWPNsdZW+idmNxNYWsjZLkHKd2zfRhA2raGu?=
 =?us-ascii?Q?lfFXAtqVOmnDr8mfndGLoxG6uBklKS72oQwnXw82cRK41YpMePyB+VKhkPMa?=
 =?us-ascii?Q?y3Jt9kT7D/yeYS6yrW/5YEmdWZ4ti0GnvoQExnqY0oj36I2fTFY8m0ylDQrz?=
 =?us-ascii?Q?VmGBkDAIWmTZagkxIxw/lbAKgL4r0mW3319WDZPcPW7eJdrnubSE/29sSZZ8?=
 =?us-ascii?Q?HPGbnLQSbWEAfh40US/22aC4Nr3nm6ZQ+cZEnC4awAwAU1UWGIZcmUvi1Rhn?=
 =?us-ascii?Q?IXu3Wz4Cq7AXw/vntzkM64ydCNJPw9mkID5tuoxAJINZtHGerS3rWsZs+cn7?=
 =?us-ascii?Q?M5RAUX5bdrkECgM5uqGkbOaO75vfsoiUNqys1G94qUbIBpCUwI74oJPLuluh?=
 =?us-ascii?Q?Ffcc5g5evvzaDcNPWMM3frIvy8bVAMR9IHwitP/c7L+co0CU+Klr6+rwQTfh?=
 =?us-ascii?Q?y5+W3KyuIiLr1UiGLUtmXFhw5Prre2j2r6iAAAIm8YGg4jMU8T/EEPTPP7L+?=
 =?us-ascii?Q?mWgNym7eIPgr3bcoGoEOmaGDM0M0=3D?=
X-Microsoft-Antispam-Message-Info: 245nZeHcv8YCxfcwmL9j7TKq86P5F+4XuCwkW9jIhkMEMlH7z0wQCPQOYS0HIKQPpWWhdxheSdIycldB2gzXsb+FXsbQGnAnak5C/B+Li+k3+nx2yauaQ49V4pqt00RYPy5n1Cr16ezLRSsPaqn/MAa/DrCLUO9hACEA9DxpQqCHwSGKF2Z6nFz3hOKk1gb+wNt0yhPxSaGws0FjqtIMtmx2/KLoKezq7lo5QPseHB1crjfZbz2w1a1g1zegdif0a78+T0LTJRn9rXwn/TCIjfaXuC4HiydsOiPNPaSNKhiwPFv1zkF/IoKUbXw1yp0Nn+9LfoseWrJWJQSJbABdqRsKVWfDj1ebmXX08bbwJ9w=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB0997;6:5ECtxD2lN5YRmgUJoVZyB0jN2kQvHY8mp8ALbr/lZV4TszGpdkVJubLPuAZrbg/yrG1jskMCByFtKg9GQYLgrq/dl/f3aBCEfkWB1Hyp1ltnLRcgi7gd/11cWlfQWB1QJf/w9XY4yjd60WcJsj/Qg+S6ge9vtNaW8P6YJNvd+Cvd5CcRRaIDktxG32uMAzoU0VYc+/JftJMsAz4pbDECE9lpJtrOJa8A47UcH+bhC2MaixYODJmVD37PzP5OErMaaUn0AgbH+z+uAGBXh2RZNnP2W53zwD49q8VkstHOTI8UJkNh4ECbkZ2/Pk/zXh6MnSJ4D5SpY87jKGT6UiyJ1Q/9l7KWqY5rv1rNJiSsE7zaxwmHThgNf4RYLGmHeyLz7FP4bU+F+X1H7h/BuC2aySxNE3a+ZxMveh/HMLS+yJFaqhl6U2JNqg7aTvZtP+bjZVRX9DU3omEf1GCtYeSaQQ==;5:yrplhbkvbb8oAnMN9F1qCwJwOXXX3+XKS2lGHPl+XH7KOpU3g5VzxSEGG4805a7wYX71BRrg/dsseRqurBfNn5M/vXk8IkeZ8OK7JAX5zLE6lRxDRVQd5M0JkJJRmMP520BYK6eTnIXKgTMNEy+dgf0XCQFh+htnzpTrgNfhV3U=;7:1Q60c2gk3WeRf8ERsQyeLqjlao6sZmyM/ASZAY7n4m/v5F6nU0YAahpsiCPegT6Z4343J4hcQleykPo5bt+jc2AivvCaU7PtJnF9qG4h2H5n6vOOOxCQxMxm17ae/FKu64SL9rdVSWdV1a28uwB3Ndskt381GkDlgBkDb/bv7nywEbdiU0mVVXhAOP02c5CN2Trw04wXAaZTpdL5i6SgVRscMlwTiAwuKuIih0GAMIJiFMP5qgpgXvfVJBah7vxF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 17:22:20.5765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bd75a0-7b9a-4617-a5d7-08d61cc22127
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0701MB0997
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.08.18 16:33:07, Mian Yousaf Kaukab wrote:
> Hard-coded since patches are merged and there are no configuration
> options.

Could you add a list of upstream patches to the description that are
required to solve this? This would be a strict definition for the
mitigation being enabled and makes it easier to check if backports are
affected or not. A build-time check would be ideal (e.g. checking for
certain macros).

Looking at arm64/kpti I see the following patches:

f84a56f73ddd^..f3804203306e 669474e772b9^..91b2d3442f6a

v4.16-rc1  f84a56f73ddd Documentation: Document array_index_nospec
v4.16-rc1  f3804203306e array_index_nospec: Sanitize speculative array de-references
v4.16-rc1  669474e772b9 arm64: barrier: Add CSDB macros to control data-value prediction
v4.16-rc1  022620eed3d0 arm64: Implement array_index_mask_nospec()
v4.16-rc1  51369e398d0d arm64: Make USER_DS an inclusive limit
v4.16-rc1  4d8efc2d5ee4 arm64: Use pointer masking to limit uaccess speculation
v4.16-rc1  6314d90e6493 arm64: entry: Ensure branch through syscall table is bounded under speculation
v4.16-rc1  c2f0ad4fc089 arm64: uaccess: Prevent speculative use of the current addr_limit
v4.16-rc1  84624087dd7e arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}_user
v4.16-rc1  f71c2ffcb20d arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user
v4.16-rc1  91b2d3442f6a arm64: futex: Mask __user pointers prior to dereference

-Robert

> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---
>  arch/arm64/kernel/cpu_errata.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 996edb4e18ad..92616431ae4e 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -706,4 +706,10 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
>         return sprintf(buf, "Vulnerable\n");
>  }
> 
> +ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
> +               char *buf)
> +{
> +       return sprintf(buf, "Mitigation: __user pointer sanitization\n");
> +}
> +
>  #endif
> --
> 2.11.0
> 
