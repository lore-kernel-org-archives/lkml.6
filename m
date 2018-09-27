Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43604C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A879821570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="co//buYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A879821570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeI0OQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:16:30 -0400
Received: from mail-he1eur02hn0240.outbound.protection.outlook.com ([104.47.5.240]:24992
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726659AbeI0OQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCpfcTbmfbmgfnuc5q7sAfq64Qt7vmNpkFW7bmJTQE4=;
 b=co//buYIRhLIOWe9OD3fZbgO2YSAl5Psf0GxZdnwp1208ldIg5pD+Iq5IhCYAU4USC9SjydyIa8EAWa80jDcIzisaPd8u3M7EfuMCr1fV/7lZJnDTJg7y6Pn9XjPwpDoiDiJEzeBdir7N+Phfz8n/oK1AziA2whdngtAc5+Eyao=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 VI1PR08MB3599.eurprd08.prod.outlook.com (2603:10a6:803:85::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Thu, 27 Sep 2018 07:59:16 +0000
Date:   Thu, 27 Sep 2018 10:59:12 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] KVM: x86: hyperv: keep track of mismatched VP
 indexes
Message-ID: <20180927075911.GB4186@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180926170259.29796-1-vkuznets@redhat.com>
 <20180926170259.29796-5-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926170259.29796-5-vkuznets@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0501CA0042.eurprd05.prod.outlook.com
 (2603:10a6:800:60::28) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddab3a1f-6b75-4c98-66eb-08d6244f1fbe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3599;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;3:9VSTIq3Yr5ZghAxLNul9S/G/r5OoSQcZ6dRbGGtUOkAt+eWFnQ2m1FEMwqOORWticOFGMDUs/P0gn++eyGJ5zqI3+1C1tJVzR89zb657CnCTK0aOB0NXm838YwlnN657K2+Z5zS3OV8fWuuw3Ac8ixse8hkZSMqQhi+fP5R08ZHWS8qHiWkq2o5mBmcwNNa2IMVWtuglsL7TM2snRuDGPTWk5qVyx/uyfY8iKcnmtYMQ4VDZ0jVvHMvfxsGePEXE;25:RY9BINLv4ZlD+EMgDHu2vp4sDnCneHFgIAR5vpYb0Lp4+UWMwzN/FD57FgBTPjqop0Se0Grxuy5quElsB8otJQQS20/6BRTowOgOT7k8vYCD/yO2BYZ8GN2g3YP6csyoKoywdElBBpFCrdC4rnFIgGK+e0ZTMOHELDOV3K9/J7k+GqYH0vmuLtP66jKen9bOFDW4xYDFldglH3w1I9rWxubJ2lnygFJxJuFSJeQbHd1YTCLZZVclJvlbAnPUsOyRTVVNhE0JEi86LkFvNvSFQmdJWrtIjGLcoM929VZgHy3vaEY0+zpVSFC6oWubE1SGBdgjh67Umu213Ut7+nI0Mg==;31:l0LSA832GCBmcTI1ecgJvuOmveHoIR/ADp6yBp7+cTN9xNDGFnQ8YFfwojxTxjyqEfkqzZEbnUuYvPUABfED1bzLOfpvcoB0rwtq74O3EmvfrkekLKCaHNWatxi2nHWtP2faeu+KA/uzTD0KvOZsRJ77gj8aMf5WgKaC/TNuA4T3E3krOf65yS2PM1zbEdYCQEqdl0fr4TSIlQbdSb5IAuKkaB3GSug/bRUiXpgaN9Y=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3599:|VI1PR08MB3599:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;20:DUK7R1sJ2KUmfCr7D6LxxpneQAxq9Nr9GDdct64btwQLJQpGPfJx0QubNJnRKTC9R9BQ0j8LWnsDrEwCA0zlv0GHJ/+n6EIGJhHUNnlHu8N/kwRwDSkfQ4bf70vLL40aeU3LxrX1/+y4jRXcHheZLoYJ7wHZgw5qPgZ15Zwf2CUzjt3sgr+yG6fcLVd4DPZmmc5xbTU3TvsEZkwEiUk2LZRJVNbhyl9pxahzd3E1ZVczddlnhSPdBXzmbHoa1rCb+E8FoTjJxYqWiW5VBXALx8GQsox4CCpLQ1jyFetNqvVhatAA5TMxqPUxJ9rGHMdLR2ynwlvydEDOSBenIvKqVRDMj9DcK4IqWHqwbC27ZFk63PQRNkapUFfLsekUD3pQLz+De18SL+/UjHUdo0RpXPZB8LdwyDOKFzfgiRw8R5yPPED47Dx3d2ADcnGLMUI6K5ZJqLph/fJXaDrBc8kOLA5Fx8G1K2vfvwApkeC+4s5cMoFKprMpm/pCFxlPItkW;4:7Wg+AG9wC5xTiyQxIi6Hdgn1ZiBFDZgzAWElVgpsy7+aY6fTWHXj4qUUKmCsfaC35Zm3bZmzKoRJUaw162sZ9dvSvvPbpUP3Ark59Qi1g7Jz86IEiKxkMDziyQHTLqYOpUO0Tj8gHb4w/+q+yO0AyahM9tcjNwkpwUG7Pq9VOYYQzN6qgDlHE5OxHn3Ove/V4e8i0CLtuwQAUYZPzq+SKqku2Hox1/EqB/ORGR7vphPp1Xy2D6YTiuultKL1YsjZuSpB5DqE/d9nujXzYgzldQ==
X-Microsoft-Antispam-PRVS: <VI1PR08MB35990DC40FE38350D8FF4430C9140@VI1PR08MB3599.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:VI1PR08MB3599;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3599;
X-Forefront-PRVS: 0808323E97
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(136003)(346002)(376002)(396003)(39850400004)(366004)(189003)(199004)(52116002)(478600001)(86362001)(76176011)(486006)(53936002)(105586002)(39060400002)(2906002)(14444005)(7696005)(47776003)(16586007)(6246003)(8936002)(6666003)(7416002)(5660300001)(316002)(81166006)(81156014)(8676002)(50466002)(34290500001)(6916009)(97736004)(186003)(23726003)(68736007)(1076002)(36756003)(26005)(16526019)(386003)(6506007)(229853002)(55016002)(58126008)(3846002)(106356001)(6116002)(956004)(66066001)(33656002)(9686003)(54906003)(7736002)(305945005)(446003)(69596002)(4326008)(476003)(11346002)(25786009)(53416004)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB3599;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3599;23:dy2YvWUcj3YhMudVTgpbWiMupz8ZgUsrIaUU/5Qs5?=
 =?us-ascii?Q?SVB8HA4IggGY4DXUNFwo4FDasmCqPaYfV3YAhys9+H0fIMqt5avZ2nn5on2b?=
 =?us-ascii?Q?Eu7OX7mpQ8PYMVXWo7ECvy8YSKF2DafDTBF6W7ksCUSC11bHCmcmWOBGMG8I?=
 =?us-ascii?Q?Xhbu1zLozvmq6kuQMEJp9IpDLhfpGFjxXIU+nHOfaaMCBAud9faCJrJHk0xR?=
 =?us-ascii?Q?5/mq5TYOosP3QnwZXweldTIs9O1Tq3GQthkPW8ZksI5BkmUvQAv/qNrqqnUW?=
 =?us-ascii?Q?YSdN8w+cps9gKe375jjmlnyknaxGSvey0WO+dcaW7im30xGkbqVvHnugJpp5?=
 =?us-ascii?Q?py7Hy104aFi8i263aQMjlMtND3timF1+Il6wbzRZF5eFw0rz3kSJv48GYgVB?=
 =?us-ascii?Q?tlUSRaE4NtDcRLX0Lc4yZNOmWMpjAGsVkXppbelzdDSH7tf1b73MELTfCkab?=
 =?us-ascii?Q?+wz4O3L0aUBy93t7+xPVn+BRncOEyPn30EHijK/OEGG1yrJuYqkKRAqeX+Ki?=
 =?us-ascii?Q?/jbTmkjFrKpML97i0PAmmnwQ8QUAEPjV2+UGSfY2MNcE5Y8d4PDzRlGgwbmJ?=
 =?us-ascii?Q?JclAfjE1DRwh3H10KQ/s9C4UiGaTVM4DMQhYonRWKJc+LaASVQDS9E1hrynm?=
 =?us-ascii?Q?ZS2TXi9bIphwA9zwFDi5iEAyTY1MOO7bahdsXEFoOf4OMjK4n+w/qZLaWSU1?=
 =?us-ascii?Q?y+z8miXgYsBZ+2BMwNAGP3ZgztLmT6UZUMxmW4ToNMn+w7prMvDQ9gVM3evt?=
 =?us-ascii?Q?jlCzenPrlw/uulxwSUH8MdOvvRThJN5Xhfxr3+NtAXC/DAQDenD69NyIeHil?=
 =?us-ascii?Q?dp/4+SOjJcow7AQdEqy/X9nMjAmaAlFr5BkUJuQOjA1266nyzUfICI8zIPSS?=
 =?us-ascii?Q?e6ef4nMQ89wKs2ibtc8WRTnqsILphUiU4ANMKBtKX85nSk0KgRmoxCWqpcnC?=
 =?us-ascii?Q?+EYN++ALKgWNGWkFFMk+eUjDfTh4smqwu5OO8RqE0GfVf4JQXXH/t+0cnKh7?=
 =?us-ascii?Q?P1ZlhSUSjU4g8UGSBafWYuIo5sEtjA1TgwatUbSE5sGJyJw/5rnn9chfxFgx?=
 =?us-ascii?Q?Ga7KMczWx0iDLJImgqh6gZvc33lkhiVOKzMlbaxe6HsiXMryZBteExl6YXyJ?=
 =?us-ascii?Q?lwzsf7PTT9SLd+meMO6O25vcjGpxzBCundQS7Oy1Xdqh8C4Yb7PU4xM4SXrX?=
 =?us-ascii?Q?ZSA7ey+DEob7gMi7DXRUybKz+vl7600l7PwnvFbZMQAprfAbWZC1QNfFlTlb?=
 =?us-ascii?Q?svCN5siQd00IH0JGUKIOxzXT99/z+cw3WcX4asIPKJlWX7kfm7CDjlzkULsY?=
 =?us-ascii?Q?mNHzWJcUrvKhklrhFp9bOisphwgYnlb8qRnDxE8y8a/RPtP43qoKzKYQ6aej?=
 =?us-ascii?Q?d/FOqv7MtM4aUJnupNz6aPKlio4SWYBBbE6o7ccNdYBtlWSczghyj5D+REG1?=
 =?us-ascii?Q?1tHnGpv42+j115xlMyv2gzELgK0hOY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;23:1YBx48Hrtdm2aBzEIxV6bYuMjjKNeytkuaXdItPkCNwB1mFY+ywsHYT9/3zosFXWa3n8brWh07vQffXj7bbx2RrGmuzhrv1AJsGWme5NTcDfSOdI2LG4UgWtbhNVXldcw1QXuukEZvDW82jSL2g2Ng==;6:icwvaaH4ffyPhLuS7EGR68dOSzcPd31CdVKd7U9H34I/Kw8QvdWKuUaoZvY/PXThT5BybYJ3EoovRTakdalv9phif9hSX9flhm3dV96Qzl19bi5ViQlPD7hb0jSrxRB1QVJJxVsjBZVmu4GGRLxgkuOjtcz3bciTWZxbjQAICYbI3CZ6uMFOTNG+M2x0NRhVNBYWXFT0EN5ZfSVWHLrrjZXgHGIm4JNF6A2X6OFCqr9Gbnp+vdN/jvbyBgRd/+lGB09oCgJ4tA4hKWH3e/D+jlLqxLPrGwGNisGaCz1xfqNUcjfoC75zedRZChSMK/KPxhnxt+8YMH9EFYfj5I7dXJ0MeCgw5Dp2smtYLhswA87S8gWdsUzzpVW31SS59lO9lf5+xzkOAqbVYBcjeLTjasdIO1v5DPYwsF4AeFH34T4Sd/rfU5eJSaZCbzMrFMKy69HAJKK7moFRkCIi/my5cg==;5:072u8+FgBaYA8/E4/re6YPQpFqxyr7b8JhoECooUEu616TtyX3CVFynFCP5EkOW+oLi9RWkWENnZH2FWQUziHdj2CSj5UwqsyVSFCqynsXI4THzQnDCMsvcbBBVFJP9OpKahE9K9o7vrVoCdlUBCdYfkG6tKx9LWcyhF1yRLpe8=
X-Microsoft-Antispam-Message-Info: iTLCKgaRVbJJV+ae1nilX+iA3OM088tNoxt0lying/EPW71e/e9RDvayRsTV4C7f+ks7uswSrPPr7V+gf2PHLBqaBKaI1z3MRSh385JQK5fUrv8QymZMyPkWxg6Ta7TIyXivLZPuPSWwPpTQH7/ANJZyNLUzZUJAeN+jGBUxwnEbfC/rxK7gfbp54u0BKjpxRBEZwhlih0SL7MUPP3yf33RWaVOFIsS0OxR9mJ1fu5muNUZDXmlMdw1y7CtSdYYlQKP5NIgQUUUVwU6JGtoP736nV9T0aH0TU8/Lf1qjg+rW+Ic0YBOZr+8NWVntWGg2HjXqdOZVkEfLq2CBfPGhIlxmxIEsQbzMvbDp3iHPMT9KEgc4PtW4jCAtfqytgXqzXZJbD9N1sQtyAZ7l+DG6OLtzMycCuCCTfwXYS8YgcEGQn2dpO2NlWJvhHSSr8U+7OAlUkKtarP/CgWhN26AfTl8RoA8ybGBvXCp5j3vgokxim+xOu+NHgHAVp2IjchP0zhCt7JVSgjVRZEdGcad0Sp+hm1QQTF4NOAWbQhZq0k910ZkyqU3zeAk5z6ot4wxbueBbO1tMCEV1a3BnxDqCmA==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;7:9kjCY99YgqSQ5GuHyMXb/X5alOrTgBxaQyGupSyX1FnGr6Nfp2b+5tU73xJEuwAM5pe9zsE2I6Bf37YMZXChC5is+elY05LNSeaboiZWLvH2suJr66TI4c/9THrOeu4XbM8IBlcvsqwNGWKjwPM0D48BQ6ez4qb+Roz9MxX0n5mY80W7oXLGK1pC8fszVLmORQinm2j5Yka+/SOgFhtIq1BzLtLMkFOoQ1OzABG8WWce9r/i1u7AFX4goXgpPMSo;20:OrN+BMuMJA23svdTXkVGnWFSmGpbr+oSI/DMONApfLDLpiQS6UQ2J+EfQMqLltkga9BlLdBleCSL+mppr/96jLrOyG/UMcHd06TzHBUF/w7FnolDfFjovdRx6/5qHaqRoB7epPDNFp3UJ/QMCwU+12ONRTHcXo9TfFdjQD9/Wps=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2018 07:59:16.4185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddab3a1f-6b75-4c98-66eb-08d6244f1fbe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 07:02:56PM +0200, Vitaly Kuznetsov wrote:
> In most common cases VP index of a vcpu matches its vcpu index. Userspace
> is, however, free to set any mapping it wishes and we need to account for
> that when we need to find a vCPU with a particular VP index. To keep search
> algorithms optimal in both cases introduce 'num_mismatched_vp_indexes'
> counter showing how many vCPUs with mismatching VP index we have. In case
> the counter is zero we can assume vp_index == vcpu_idx.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 +++
>  arch/x86/kvm/hyperv.c           | 26 +++++++++++++++++++++++---
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 09b2e3e2cf1b..711f79f1b5e6 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -781,6 +781,9 @@ struct kvm_hv {
>  	u64 hv_reenlightenment_control;
>  	u64 hv_tsc_emulation_control;
>  	u64 hv_tsc_emulation_status;
> +
> +	/* How many vCPUs have VP index != vCPU index */
> +	atomic_t num_mismatched_vp_indexes;
>  };
>  
>  enum kvm_irqchip_mode {
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index c8764faf783b..6a19c8e3c432 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1045,11 +1045,31 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
>  	struct kvm_vcpu_hv *hv_vcpu = &vcpu->arch.hyperv;
>  
>  	switch (msr) {
> -	case HV_X64_MSR_VP_INDEX:
> -		if (!host || (u32)data >= KVM_MAX_VCPUS)
> +	case HV_X64_MSR_VP_INDEX: {
> +		struct kvm_hv *hv = &vcpu->kvm->arch.hyperv;
> +		int vcpu_idx = kvm_vcpu_get_idx(vcpu);
> +		u32 new_vp_index = (u32)data;
> +
> +		if (!host || new_vp_index >= KVM_MAX_VCPUS)
>  			return 1;
> -		hv_vcpu->vp_index = (u32)data;
> +
> +		if (new_vp_index == hv_vcpu->vp_index)
> +			return 0;
> +
> +		/*
> +		 * VP index is changing, increment num_mismatched_vp_indexes in
> +		 * case it was equal to vcpu_idx before; on the other hand, if
> +		 * the new VP index matches vcpu_idx num_mismatched_vp_indexes
> +		 * needs to be decremented.

It may be worth mentioning that the initial balance is provided by
kvm_hv_vcpu_postcreate setting vp_index = vcpu_idx.

> +		 */
> +		if (hv_vcpu->vp_index == vcpu_idx)
> +			atomic_inc(&hv->num_mismatched_vp_indexes);
> +		else if (new_vp_index == vcpu_idx)
> +			atomic_dec(&hv->num_mismatched_vp_indexes);

> +
> +		hv_vcpu->vp_index = new_vp_index;
>  		break;
> +	}
>  	case HV_X64_MSR_VP_ASSIST_PAGE: {
>  		u64 gfn;
>  		unsigned long addr;

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
