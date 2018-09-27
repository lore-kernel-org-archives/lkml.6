Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544C9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14752156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XWPeniFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14752156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeI0OGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:06:48 -0400
Received: from mail-he1eur01hn0243.outbound.protection.outlook.com ([104.47.0.243]:29557
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbeI0OGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6QlVv1p3OUK0jXUgPS2SmEElLF47qdhfbULHjJnHP4=;
 b=XWPeniFO4bMr+Pfvrjz7xy+TkpLqmaue3+zBpTFwoSdBxgKhgCFDfDzisY6kwERPmi+eVpLmnIoukeDecrOfjbjEeNCZ+e6BCmAsa1JPIsoQIBK0ea//9Ltom+OCGzjkNu2yfAiQF4ADdjme7gv9RqrVnsmfxR9MWkU8WKhPEIc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 AM0PR08MB3585.eurprd08.prod.outlook.com (2603:10a6:208:e1::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Thu, 27 Sep 2018 07:49:39 +0000
Date:   Thu, 27 Sep 2018 10:49:34 +0300
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
Subject: Re: [PATCH v6 3/7] KVM: x86: hyperv: consistently use 'hv_vcpu' for
 'struct kvm_vcpu_hv' variables
Message-ID: <20180927074934.GA4186@rkaganb.sw.ru>
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
 <20180926170259.29796-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926170259.29796-4-vkuznets@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0134.eurprd05.prod.outlook.com
 (2603:10a6:7:28::21) To AM0PR08MB3585.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea6a8a6a-9e79-449f-98bc-08d6244dc7c6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3585;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3585;3:AB5Wr87Z5e/GMwCGWYkaUC7WYNC6715fzpBCHGk12PGokgeXQ9uNJ7pPcMK/LDkug0cTIVtYXY84mDGPQPx4MSNlqgyvFzMxH4h2FCwI3vKqc/yaBbai7l3Eeo7PUVPxzME3ygeKs4/bte8qH/Zx5rUcQIRVB6gZSFg4X0frHL3TxdYsrTdS+t+pQ7PMZ1UBYTh/9Is841CamvDDigCc4x3IYWK/iiv9kV+/8tbmKJwaegJisihMckDT8epp45p/;25:+S6rF2vhYIzF/Ry+H8VApYqPuq/eaWq9E+jIEx/tSvr7u9RT63kKSgygAFv8aGaMlfR0o1ApOtIwW+FaTckN1ihxOv1BquawRYFvaej3azmv/wFbrYaujKQAm8ehpfCQDW9EeTVezLkAsfDNPooVWNqqbWLyBpOkj7thfS09/9hlaFZicQ5P50IglHVUJrRBqUCyMOoiMTvvrm60BjtPhXR48pedBoRjCXR6Xkni9zGvsdcESWVE2m7IJWYRtQKqYFmdQn6/3UoPelHKzqkoviI7q1F4loV+4Q9Ce+Ft5xyjVc9bajYE0MAOawliDDTgtvj1gXAaZY1fIwaZODSIwQ==;31:5u+OQiRmvvky5Oy4vmWFYVZHcHc2rULE55inIJPyfIUCGC62U8svGWyytnZm8m1DN3NfsBnOHtgyPo5mVFokagZ5ji+cZTIpm5KaZypiOWzontL/7hdAzRjoVFmofThG2NK7EnAkLybnAx25fsgZSXy56v9/skrB8Cb5RoMokMEcJB5xTiHwjWXjbtwPmgFoURU9SydQH2xzz1Lgp2S8lRevo/J0Tpq+HiwPUaAHe0I=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3585:|AM0PR08MB3585:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3585;20:S3rgJ3X8hutSl0BNYP5Sfh+XU7A36z/4Sc+jK6ce7nm1fFHn49f7hhpChymv5kagkUTSy1CbsWc3niCYRKZ1GHKYoZu6nKAVFpPAamrRZOOZuMyp+dZrpN+1bM2WTS39v0zrmWOv8xW1ZWyY+7yr+i0vpcR0tgtJPjggLhld0JZB8mIa0zoPlyRRhxgKfk/XW34+DK5gUs4s3tXNA4PHduh1v8qXnBHeD83RHfCfvGXNqUo4i0ZNSzC0ggRYJB1MWJ9QWUF3O04lCZ4oyiV3jtRT/hoPZRE06P7Yr47e7QsvB2sgDbZU+sqPOJS6XDtLFUCwAv43eljdFUIogN8hK2TQRQcANHmrSr9W35MOSAv6TFrEb72gNdCCRRFRnkjnBJMmI9E7vjIlTWUclSC4+2fWebVzJLtidr9RklDtXhOuj4J3Fne702zupmDZ0ngy8aQv85sFX9Bm5adUckQb7SqY0DkJL1m7RbQQUdVOaiFOrwdiux9x83psXgr0ftL0;4:dlG+C/as/5UjJc1f61RH7+OpV3hOncrPLtWYl/f+6ZtLJkS02Hgvc5RuMgqT+iyoy6Hc9V0/yP61BU/7pmkTR6B+SLghWfPcdKIbjc4fFccyYVhPEzUckJcBxeCc0ZBLLKk6XlJYoZPXYtDg0t5UXzMxxNYaGPtLs450gLVKWeFyRw5/nE84u9huKYuiVV+89psp9HnJhpfLJdsAxTv3tuoyq1OHZhIoR1PTeHoWgYRaJQXfwm3ILX6yXkoAhgORHe2m9wLeopDMXfYTFrO5TA==
X-Microsoft-Antispam-PRVS: <AM0PR08MB35852A8BCF94ADB9A61A90E4C9140@AM0PR08MB3585.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:AM0PR08MB3585;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3585;
X-Forefront-PRVS: 0808323E97
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(396003)(136003)(39850400004)(346002)(366004)(376002)(199004)(189003)(7736002)(7416002)(6246003)(53936002)(23726003)(6916009)(478600001)(3846002)(53416004)(1076002)(39060400002)(9686003)(6666003)(68736007)(305945005)(8936002)(106356001)(8676002)(316002)(86362001)(81156014)(6116002)(81166006)(105586002)(2906002)(55016002)(5660300001)(4326008)(97736004)(26005)(6506007)(386003)(66066001)(36756003)(16526019)(486006)(476003)(34290500001)(956004)(229853002)(25786009)(50466002)(16586007)(69596002)(54906003)(47776003)(58126008)(33656002)(11346002)(52116002)(446003)(186003)(7696005)(76176011)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:AM0PR08MB3585;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3585;23:Qsd1I5HG/xTJZoP9rMKTtX5YUu5fOv00u8BcxQl1M?=
 =?us-ascii?Q?3WxyC+l3ESLjcE5FwMOEzx0Of20XNkhPcA29yfM+kdhLxEFY3azOv/6zlsOY?=
 =?us-ascii?Q?YuCrk6pZo8hYDyWRUzPpommcqDshoBvVqnWo27tbdV3FIrLCUJaQco7LtO+3?=
 =?us-ascii?Q?UIdcN9jTbBWdYDt6UtNiOrcLYz3mHOBwDJXLDyCSyHekNxsxhFHHd9l2IlTe?=
 =?us-ascii?Q?/urE1a0OKbAp0W6wlO+H8vGb/Mi7xMLvoQ/cc2fwK1DJgJvJchASsSy9Zf7o?=
 =?us-ascii?Q?ebhIxSc0DHWOhpb1t91j0xxfRZSChwbuGASdnutpD535jH2xt+dnMO39HlJk?=
 =?us-ascii?Q?n76vu22rTAAQtzfCrwfw2L0980fggv4P6lAuDLRG1uXEmk3NJec/7Wx/h8Oz?=
 =?us-ascii?Q?KGQ5kMFRxALMddo6YcjOGUEbuvl9T9t+ga+zL0UyLu5TZaZCl/VtpP/kw8ui?=
 =?us-ascii?Q?S0kyprqwTkr+A39HdUKsLaQzzVIfDsA8wRM5H4Z+hsyZkWQh1pPYWSjrUguT?=
 =?us-ascii?Q?HatZLhjBE9+3picunxLO+jtgsKgu7T1CKfWyhnRoBcNaVxez6wndjhm7WIgy?=
 =?us-ascii?Q?D3gMU8q/zjkOkICpj/YGxGxl+JGrUYoyON9Es7Hp76zp/oMhaXBOUO1z9JIW?=
 =?us-ascii?Q?tYL+l2JN5BvO64Hk6I24roU6ik8McefR/dFBvaZGIGYVy6ZYXL/OFRWh5Ubd?=
 =?us-ascii?Q?vUos34SgpXXddS8OIQlDvbznpcmjYXCl4N1nT/9ORYiWbj26fvujhcP1PG1t?=
 =?us-ascii?Q?VbYUzXskyr2oubZii4noso/lflf5hIVk1RcXhUqt+rhmDXKBDwFUKa7APzFw?=
 =?us-ascii?Q?KTev229fAiJkx3QiA+vewnxT18SaaKCSVfJX7i7xtz7heq4aZi+YZCfnhLmH?=
 =?us-ascii?Q?LACpNgXBvo/n81tBGW5p/5TduCXYQtZdaBs8jau/9xsQqk66qYBBf28t/pBC?=
 =?us-ascii?Q?NdT61THYQY9WqhsJlvkJ2GTWuDTR6qRGbHDBV3NLMw8eT/kWFEP7WGvzCdKM?=
 =?us-ascii?Q?cTI3EyPqY5XeHOO2V67aHemcPtmpS9PKhAw8s3ooFrSSf5oFFtUKvzamgbbr?=
 =?us-ascii?Q?MDVDT/z21xXJUNMJZcI66/ugE+oSmlZ/DTpG8zgzh5+yUAw6s+tAbXOdjezY?=
 =?us-ascii?Q?T81NG5n7QQbY2/YWFN2uJNToS6rybI13NgGKzbvjrJy9e8BUrhVSAJ9P10il?=
 =?us-ascii?Q?UKMDMIX7HENhuQpzfIDhb1A626BU8OHjjt7LQdyL5DwwlsQ0gGk32vQKZcM+?=
 =?us-ascii?Q?mQa1D8va5dTSFZ9wDDTlN3a7ZqGnTpcUMN0+uCak8/HQS5P5myf40Pq4byN6?=
 =?us-ascii?Q?YQ60L4jesnXwfKZ9bA/ErY8MPRVgLGB5WzlMycHRditkQhyYY7+DqGrFQo+A?=
 =?us-ascii?Q?s4D21Gr8NB8IR3VucyPx4vhr2g6+K7llG2ybpCunbeFtq8/XMVSe0Lj10FqL?=
 =?us-ascii?Q?dMdBgaAXA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3585;23:iGcufyVR8yyNRfNMZzaC0UWSY8Ig+hLNjlTcwp9zDnWYoMhMK5dHArldNe/tkiptKOHoPSIS/gTQ3plgP+LYBiP850fKvG5qD0gkTOqG4TrJuoSEWv5Xz6QhHL+FN9Z0I1yXZJOeKpuBPSgwxYobuA==;6:27S7clP0SE2Z4Md2zzZ/ADMX8bA/kY4m5PmamPsG+4wjIxLq0+l2cAloKCT5HmyO4ELJbcLKtW6HVkQHC+xTQdHqqRmqbZp9rRU8unZ/WgYp5gTE6CUEcpi5mpbt9NHGorNdZKiOVmvP1X4rufpeJhwMcOJGtjoxqmNNPVxYVbA458fwKP4zHgIh2lz8YDn4yTZDPwmKESWyrBnYXz3a7s+ly8z0AyQLIOwG3yll1vjkDjx75QroH/c0Tseg9Ccma1tbaBz+TzauRE40xuG3Yqj7VWlI3r3m1Xsoe9XulSuwTxv4cdYKzcKVXsfU7iVhl7VLV1A+Onldtp6Y273KarIcDqOlP7Jiu6yhFqtZHRpVf/TOUBMpodGuiFwZC9XXxIWvcYlksMmuPnlNSQOCAilwE0ckBFuvpjIko4cYZUDwV++rpMrKQ+R3f1dC+Rr1w4488OICIxj7M0ShtSLiwA==;5:HXL09qWO8bOS9gKojQvd5yfvlxLnsrigbnAL0fTjHiqbabK7xZBAvV6dO4bDSB26nlrwqPufQCPrnIetNsgNA3FPPpMNIp9gMrUFh1+aRc5QY14FrCLGhD1VKzM8v38D9fcSQvt0IeCEpMVw55rOpizWRLcZ7d6fLIDPK8fbbNI=
X-Microsoft-Antispam-Message-Info: Oa43qf4pIlWnlxwQIgRAmQ8kk4JRg/HT3ezV5dqo8C7d4muaBpSIGy8sQWQufXwkBuTLE34ADxdpvYVyJmkAI7MWgyBo9B9XxBNBxJ+u/ON8SBD8e1lF3qhpP0KFw13QaJ897whk2GZP1kYAhH8vODRPr8lJgzeSudMAQDOXQdfHbFRkdsdBHvQV0JmibObCHmVM/hzFw9PZLkLJfRSPq39Zb2PjKjMHaykPOauXq/YXcMtzQesdkQYsDRGNBEQ5JJln0GetFg/JSmECkb6l1Mv2OJ0i1rza0zPVQczWEzOKhg9DAuWvRR1is3SItsKLhk0sfPmLXWqVqFo/cxV8XuCe+neF+YjobjbaU3E4sce3Pn+E7Zvcqaycga3gOQSy1MJZudsP3IItZYccBXjq19KIttGt7gx64uXOSQlRAHf7u4BqFHHEQ3aER2c0a4HuZ8lifn9gpluXAdtm80yiAYyv3P1UaQD2ZMuR8aPSgvjbFS7BhRhcQB+VdKVK5tH3aGPIeQUCe2w6BsI4gsWeGPxgyaeqaV8f4f7YYEn6umfokYRvBYbTLqe6PkgtBkHsHEN0jj0VO4NVqkGxp9s2Bg==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3585;7:DNyNs5v4qZ9uPbCvRk3ScnY8Y8wOOrRTPNLdqgIN9cNoxUnaQbYMV1aDE81pYbNnTwfxqvWlYoSN6Mj45CxQCky2G75GNi8fnxQEGEg/guIJFBsT9zZN2v9TiFmJu2lX/9Lv1RuH+I1X47JQRxDGDX0cF9IXnbrslBI6tMGIWu8D5zqBUNJPxh+6FZbkn9l2zKHwl5QzdoyR+jVd9TjvqKZCDcC5iy2ZsrLz2NFZC1Lwr3m+aHsMk/igMBbMaa0b;20:qLWzk2YNzGBTnXKm6fXVyQbzEmiAjTFGiNyAeFi1dECFn38nlQ3y77dj5VLn3RANB5FqhqQHc93KcvRQYpBPrrt0kpK6SDoC9W1Ok2egzDLn4PivhBl5Huri1CryyhQahqGD3PTtZunpPurkov1vtEJRPtA74KWaKeGocEpIXSg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2018 07:49:39.0547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6a8a6a-9e79-449f-98bc-08d6244dc7c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3585
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 07:02:55PM +0200, Vitaly Kuznetsov wrote:
> Rename 'hv' to 'hv_vcpu' in kvm_hv_set_msr/kvm_hv_get_msr(); 'hv' is
> 'reserved' for 'struct kvm_hv' variables across the file.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
