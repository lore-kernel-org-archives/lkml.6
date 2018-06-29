Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7148C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FEB28028
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OHeEWPEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FEB28028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755497AbeF2PB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:01:26 -0400
Received: from mail-he1eur02hn0239.outbound.protection.outlook.com ([104.47.5.239]:1152
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753194AbeF2PBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUAjDJWfHEOvGOJoHjoFI5AnanwWMDfqIiQFsD428LU=;
 b=OHeEWPEFdj5Sar+8bc2XO7YRudmK9IUNVMccYAL7UR3pm9xtjkl8jl82b9ExEYF9SZ3l9JeK8R2VC9kzZ60zJrA0eZrhYbvsuH5qsV6Z5pdO0kAJVkAFikNRAQA+VGT4xwviQBkKaTteLWSKDHLj1FpgvyiiDrowe//F9aLw998=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 HE1PR0801MB1980.eurprd08.prod.outlook.com (2603:10a6:3:4f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Fri, 29 Jun 2018 15:01:10 +0000
Date:   Fri, 29 Jun 2018 18:01:05 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] KVM: x86: hyperv: use get_vcpu_by_vpidx() in
 kvm_hv_flush_tlb()
Message-ID: <20180629150104.GE15656@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180629141455.19525-1-vkuznets@redhat.com>
 <20180629141455.19525-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629141455.19525-4-vkuznets@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR06CA0148.eurprd06.prod.outlook.com
 (2603:10a6:7:16::35) To HE1PR0801MB1980.eurprd08.prod.outlook.com
 (2603:10a6:3:4f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18123736-5ec3-4ed1-bdb5-08d5ddd126a4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1980;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;3:uhavLmh9N8fM0MlZZ4T1G8SNUETWk/gmkhfNhu+lsPF5QoTonXnF+M6lEzgdbKEDKp3M+M1qR+kbvmHf5HYY4MHrDIrgtlPJG5gll+EA259LyvcUj0QoAiSkX+zUhHh78dfyJqubnSPNp/oFVWz94/9C1lfDBw2Kxm1TGmmdaQDOnu1+mVO8wMpgnhTewrIdkIEBVLJyDvY3B969k0TmFwl1kvCCX/3xvuM9Pm6MqzfPoQz+sbaRtBqyuQsg1lZU;25:wqJl//EEYuwL09UWwPyXCwrlc6zpjbWPkc89S2RVwgYf04fM24hcxL9C+BcTR3H3dobmz4JBqD5fXs+cMF+9N6dN3v8rcVHzHdHyHMqywjlinSzvUylZf8sbiVOJcZjdlm31RKXrjumbSBYij3oNklPqd9BYWRhRP4mOmSp/zV/GFOO91qQXaeg7JiZafSLsn5QC2y/yLGWo03p01xPLXVcIhkjJ/JtDMCymo/tX3IeFuyO7c+jgcQyeIlCJ+fwxlXrID9NexJneO8Ur/WSOISzvvGvrdiZ+Qz5ORqt714q+WgyboNbKbV3yDJXZYhT1Qyuvf75duaLZuB8TEjiKpA==;31:kq1NE89K7VknTIHgW8O0TT4zBIUgBPxpAH/ZC7B6cAbGCInwYxE/WHaW99kCUULJMPVnPvOGAUVnLfXYx2ZS0ixVnNCp2NPtoHtyTodML3ymmU4K0711MLih0Sg/DcoDGO+Yr0hmCKEe69DB53EEbz5T2XM4jMCwgqCSmapXOqv05OAO7nwAEKVPIwAq2vpyp+VYXBmn9U68dMgxZq0fAdKeHTMJWR0OZ1Fk6qpoX9E=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1980:|HE1PR0801MB1980:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;20:dHVU1X2hGVS5+9KYoImQQA9JSoDmLZ2FtyipyYRuYH9iEwWwsC8V0HEdtUBI0+5ic9IIuNNOkN1xk0zG/rLcbb1B79HsWNK2yvYbGcqPbSOpoSVBqWcvGot25L1lmWvYzisKkLhfLvvgUpaEKThFpxwH9RQqFluYcFm9oQs+i+xK4WKZ3XphZJwQwOpMeBjuY024a3obLBvAWny7YK6uvZAXDb/AiSpISqJw4jOtm9f1QmSRGxKLiYXJiNhmigkd3LjV92NqlvWcJbHYNdMZk2IqeW5h35b3/PMnY0w8ursM0RqEsguRpwPbqCvCqa4Ha4irHlDFdBOyJ5kqBeo9g0ynvhsfGKz/wioy9YNbWMjRglnDXvUm0L8Tpi2eFiSgoAX6TLM7TN9wrqf/iAWbECHahpGtnpNq8kPKDmW2EfY4XnrNvs9gg76lMRf61XUq/sDHqb+3hXm9g2VLvYqVbiwUNRx6HEOS69lJiUKO3kQtnrvg89Y4FePLgD1hx4q5;4:yBDG9FEoeg62WSV6wZ7nOdxByKPTG14v4nFdfmRO54aDIsxEWzGDDKqAwX7+qKuj6sqAy9m4kMlz3EdjggaPNW8BUJiNYysi62T65PeDr0H2EQL+H1V2WdL1wv5AkcOkEMGk2PoN8Y39GWxmGtBvhSctEmPT/lnWERLPWUpNT6pE2WTFScDl0couy58pb5tMzsZ4EBIv075cePo5EdFcw6dbq0I3SxJ8/soqO354dJ/Hy868i4r4gdi6oLBPSzrOtXvNONO4H2Pnie3cwh37hQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1980F6CA8565B0BF55579ACCC94E0@HE1PR0801MB1980.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1980;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1980;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(346002)(376002)(366004)(39850400004)(136003)(396003)(199004)(189003)(6246003)(6916009)(486006)(956004)(11346002)(6666003)(39060400002)(7736002)(6116002)(66066001)(476003)(3846002)(47776003)(446003)(55016002)(76176011)(6506007)(7696005)(52116002)(386003)(23726003)(33656002)(69596002)(1076002)(97736004)(229853002)(305945005)(26005)(54906003)(105586002)(16586007)(106356001)(16526019)(53936002)(7416002)(58126008)(68736007)(478600001)(8676002)(2906002)(5660300001)(36756003)(53416004)(186003)(14444005)(50466002)(8936002)(81166006)(4326008)(25786009)(316002)(81156014)(9686003)(86362001)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:HE1PR0801MB1980;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1980;23:MiNz/qbkGi+wGYcZhSq1GodQUFnzwzSGjNnOFn2?=
 =?us-ascii?Q?t9H0oglLw4HNAgZULM31IafqtOlOXKr7iGzJ3ySqQFE7vOzW32bsNbrEQwoB?=
 =?us-ascii?Q?0Z94HqzPu+zJ8qC4UVtJbE+JjEGqVPfgNoM3E/myO8dZL+9xiwiRAj6Y2Ou+?=
 =?us-ascii?Q?/765WLQAB2Mm7gdIX3lFktDnl3dRt7DNRCODd/veo00xjVbbgugaFGL2HwuZ?=
 =?us-ascii?Q?QXCnrJzSpjkdNJzIxOq/F472ZjwsYfjI67i0nqAYR4j7pcQZRE6F0ONNsUVl?=
 =?us-ascii?Q?0cw50sD/cSmMeyNQy/Mj8Ee2kUKin7UuE9YvwLJAeOGfEDV98qg67zd1oWj/?=
 =?us-ascii?Q?7q7UcobWb9DASCCh5wSCbYSR6xXwGPvS/Qn8vIKH9hNzbJSkoOJPAkbl2KNp?=
 =?us-ascii?Q?q8JdOUBj3nzYxboZ4ONY5oi6i5iVHJlRGP6CQae+OidOzlvgcg7vFvuYw8CF?=
 =?us-ascii?Q?EzovkL2loiSxKgBNm29i/6vhWMHfg1zCynjbxuRKrQ7EBbPDjMGob8kHpRSc?=
 =?us-ascii?Q?oyDv7U0Sevgf2ZbulpuJWUhHRBb7IJkG4ELqDH/AbpN4WIi5YdhbWsp+Ozlj?=
 =?us-ascii?Q?pVwMTpF8x+DwwqSsUBHxz3oJQ8OysXfzt4e8m2PqVofCxkwMJI9/xnvXyg+G?=
 =?us-ascii?Q?R9laSbZ2i78oidSupHdVJgLnSH0RwWysUwSkOAyfLWX21ovOy/f5zTWI7NKP?=
 =?us-ascii?Q?PM17sGf3Xyhmgmh+gb3Z0BologwT6L1th41fpKyVQicPDIQ81NJSpZz8xIKl?=
 =?us-ascii?Q?ThyW33uxbFzTNv708sSvsou8IjvBzZqbNFCDeFY62PS1fEkTbXCYeD0D5iRN?=
 =?us-ascii?Q?4GJ2Hh6TvH3JAG3g+5xCRbo15xnFYwj8gR85Q8ofIuVma56TXLtX1swBT8JU?=
 =?us-ascii?Q?CZjS/KQrWRZxQcXSfpg3HBCebryZczA5Mbuk6vSXRtxrnVC57P52sh4drhWA?=
 =?us-ascii?Q?Nrwx8bKcHfaypxxrjqi43brKbwb2KKel6e0GRRdrcbWRndSBB7UdQeydfrcU?=
 =?us-ascii?Q?DCSz6mlgpyEq3L3PkkF/jww6lZaW4LcIRJArUPf4syT/FGsm6ELz8AMVWuMB?=
 =?us-ascii?Q?L17fZZUX2waMzN3Q51hQ/2+LO+bDFVpe+yitYvBKvD25h+MEzSaJkOZ6Xih4?=
 =?us-ascii?Q?umBOLY9R+XwQsuBFpw2wkjGY8PGZzekkl4Zj+Ew83XMVUj8VncapReMaIIh8?=
 =?us-ascii?Q?SAuNtleIoeUdgEbbekESEfb/EdXd8Vg1HSHFvYduXEZn3/vbz8RIRKlz8+hS?=
 =?us-ascii?Q?FJI3NyiZak4n/aye+NFjwrOSDSgm2+XMlExDlGetFgWTapWUcZ6vrzXPw7si?=
 =?us-ascii?Q?GHmboX6bbidQzKXi3NQ/llydcxaTmlH7uybwMD38WZZzBtnwFWtksq5zHBBJ?=
 =?us-ascii?Q?oioXcpfCkliH8/eHVCif7TW2/VwxK+j/8e4/hcvwo2k6T3a59ad/Ivk9KIa4?=
 =?us-ascii?Q?96ivqAAijPw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;23:kP9j93Aj3GWDHphMWt41QAn5+hR2WW+njRFz+ygI5Ezf9flL7NLeO7U+viS1ead5fyZTHBpfG+zeTFYa46NQrMLEBu2U8FWPqUnUGXAr8TEURgNf03lGyv1GENb6XpUHKsUfdHy0Ln3IpkH9J3IbhA==;6:eHsAOYg3EV0rXTPFPWyJwjVqy50lu+fLFnThlC0VfGcSTcNwEL+zokX/lj7/QCj2y3ync9lErXr8XQVZ5G8+wbfoHqGra0fhiWSspQDGht0Hlm+e/+dGoUftQsJcHl2hqRTW+FRzfec8UaJqeB1kZA92XDStHN+lcM13/kqb8b0RJRWt0Sk4NBzwQSHXCaoFX7AIgPrlTBuITK77KRsdpJGJHOqrvx1KwUMArbj+SD9b+DjRkt/XuIkqq86XJaSQlIrgOAcAWxTZA1WwfoLemRYyOuJ5CFsPuYsurf71ZDKfzTPH9eEBuhJljXX08aMhRLbvy3U1p3+CAdy0SzMdlfxxO3MmVWdbcukLT9nmZcTJuknxezyyFnpU8KOLq/YRskNuYJ1FYtDrFOxm98yYMMtFu4SMBr9Ufo+m95swNK3snJRGaYxzL2ptmSkcpXA9sV8F6eOvZFMfDITZvvQZ6H48ijcxeESbygTYkq62dJWbOskiwKNIkzowyxLH1oH8;5:7QBN8WmLia9fedI5APfMwMky0aEbsA65thKtbYdHp51A9V8iKiQ7GzLGjI8hRz70I7CRfqYjmbFwGOHNEzLVs4tEE0zkKXmedhnsE+l/HMPjanP/2V+yvtYlTl3KgyMsGKFHYvg+QS1d4o3bCW0mBtpqR1mPhqJWWw8TfFxHySA=
X-Microsoft-Antispam-Message-Info: Rn8c1OsHznVZ4j0uM0YM19ddhR94y3MDgfR3EUMMeHfNTfTzIXnV4NGNmuDY4JpVpoq0GHR+Sj5Nk0UZR6DkaUXoedLefVzQcJb/HzB5DVFiiOji/u07ECQgkXQvFLVeXUCPwK1S38D/uY9xpF5CXch37OBYfDajcEXOQqU8iVIhiKv8bKYHliZl44OZ2uPvZXorh1tEuQoisSnDX8mSlzs1s37v3jsOcohG4ERJ2gMjfXyIEHl5SVj79xi4B1jYhzxrLyDqfXNtRI3ABW9qWvomqrfkdaSyXEP5XY3/jZsA7MSz64TmYVi5/ZATVmEtFWMy9I3/WvWi8/mUxnMB+XktGcxAjMycmRLntiwfJJoTBn+ALMjPCL9fQra3a6daOreGkjHg3icENqjtTOdyf1Doou5CJDSw2H+pUUHI2NjBSHG9KCk+XdGuBmBhXdKtEv7WSUl80FXxhWQdujYOhP4cc/tjyTxzQksNKUJ6ek6bFnuPxSY8pzAZHadKKQdhlaHLm3CQvKImG5MdKqq2lISR/aRyQENiAlOcAb51pdMB4kc/UUcD/glJ4/MRiS87TPFzKiIfbVQTrj42XVn11w==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;7:FKZW4dyyceTGcCwDIjA51DM6VuTMedCtp8Xi+dUTlM+oXFkPf9U6gJHomMScSapGmN3ZNEANIOkqF6qW70z1sAp3jQrYYOZoDxs0F8CrSoBubXjzjVJlLl63bBu/91UloYYH3e2wgxPwpwdTL1PfECWrSUADqiXEyfGEo3sU+xfh/1inr+G1CyNmAY2hvfoMfILEuo89xOXvzz2LUSEpHyGx6ne/Gq7sqy1dN1KKqAzH1OGxJJvINZzpOLnFI9mz;20:oK3Qh5jDUd7qxo9kSOCVmS4F9PGtl+yqpVWDW8T7OLmQH4TnyK2NZzHMOE/JK2x8SSpXUDSd5KO6Jb5266v7ai+8UgVcCrKf4eGbhWvCDufU70TYbTOHXcpGcRlu8/9wxviMsY3tuBPztJo6N+G8w8alpVP4YlWPvOAFTkefwzY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 15:01:10.1214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18123736-5ec3-4ed1-bdb5-08d5ddd126a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1980
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 04:14:53PM +0200, Vitaly Kuznetsov wrote:
> VP_INDEX almost always matches VCPU id and get_vcpu_by_vpidx() is fast,
> use it instead of traversing full vCPU list every time.
> 
> To support the change switch kvm_make_vcpus_request_mask() to checking
> vcpu_id instead of vcpu index,

I'm afraid you can't do this: vcpu_id (== apic id) can be sparse, i.e.
it's not very well suited for bitmaps and can exceed the max number of
vcpus.

Roman.
