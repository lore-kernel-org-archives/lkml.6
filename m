Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77720C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC63421546
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ay8UERSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC63421546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeI0QAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:00:00 -0400
Received: from mail-he1eur02hn0211.outbound.protection.outlook.com ([104.47.5.211]:32368
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726790AbeI0P77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj8tk4euRkRUugkWBKZ9l5tQqdk91VzKfflKF4vAoqQ=;
 b=ay8UERSo3+0kL9wvmIvIResFpDp2HTyFKIsCFiJ8IJF7maknHpa9tyaq5EHIUoWshCF2f5viPQFHfqmPfQBRXOvU/oBxBL21LBlQaNFekzSNvdgPu7ZztAWFU1rgN6L0BSIb3dWkvMEgwaVooH5jnpD+nTacvaIA714CtCFZz+A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 AM0PR08MB3588.eurprd08.prod.outlook.com (2603:10a6:208:e1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Thu, 27 Sep 2018 09:42:19 +0000
Date:   Thu, 27 Sep 2018 12:42:15 +0300
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
Subject: Re: [PATCH v6 6/7] KVM: x86: hyperv: optimize kvm_hv_flush_tlb() for
 vp_index == vcpu_idx case
Message-ID: <20180927094214.GD4186@rkaganb.sw.ru>
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
 <20180926170259.29796-7-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926170259.29796-7-vkuznets@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:4:29::34) To AM0PR08MB3588.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cea06f4-0347-4f6d-b8c9-08d6245d8517
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3588;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3588;3:jD0wlJxQ5j0kaE4IeRXel1UvaVqvi/ICvEQSAXpoQ1SGUH+Jn4Lgbo+XkUhk/sDGpv8yXy/RAeLJPF6RU3YWRxZitCpef4h0tSFcyoDTjhBq8iswyemVW3obUB9GBciwz3Bh14y8q8TaP3JPkE2edPifnuUS6er/C/oXhcTFj9o5GKyVxpejkmYw0zsoL3+Nyx/wvgcqIXcGQbBwTApTgiQLjOmUAy14w95SNWxj4RidvNsXFxM/pYP76xo1YKl9;25:N6W+tELbMeqx7X6GIX5CY1KF/tKVXyDyiclJGZiS+/zGehQCpKesdtZjbpzYLReKOAyyENMY+LdFi307rHpiyYCbwvgNWgFgDZE6bizonJaf3yS6LzaZa5i4Q3xdj9BIXwpNZai+TxwUvvMpLScdK5QkysRSSaQPMuUg4VnkSHY/Ydrh2M1DU3VvUR9bggEbtRO36VemUTdkDqf1NVk0CD04fBlKL4UAwYQwLM3d2trWIQGB7bHG1vHkyxReoaMroywUoGYVdlFIbMtpGTU7FwKwHAf4y26qvPGP/23fgDXqK3trF3jdOf6sVpmEskZnIy2MOnSc0J+JiWcarcH/9w==;31:BLfI3FUOvxosvxPc06ndzXl3wV8cVAk+bQcDfzs+cE1mSJwejd8D161yBPMn3bbJs+cqQFfzlLKZlFxJOaz1ztsSzkwTqbFDcsqTHE1TChnapjOrIH0GnqxEU1w7ha6kvbsB+hc17ccgJ2hWBoKzF1nctBxxrvuHSkTTtiQhnvffHsak3SVAPTg/YYFBiOiCRTe58LuOY8C0AXuak+RtMcECpyW3p/P+RvX+KTmLvWY=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3588:|AM0PR08MB3588:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3588;20:aPlA6uGg8UxPwwM2Vv10ljm7UERS4Rjfje9eVvEWjRu9TjhR9GgjZPG4D/53hnmnkBHoqMpAE/Mw3ze5hHBGrSkHRvGarknjfFD51VgbjoA1YESJBe2Dua5ib2BgK8vWPG1yU3BfAbJO8i15lNV1UA85QsO70LJrbk7NMOx3nvT+ApoJsJ3LrfutXaI3Fp9txAO/FMalW7VJ++9r5yrNcUZo3doeqXnaYPRfvwv3e139JXuk9aOtf7t9IvMXjbzKhlqoMD0Zb2PSxEhzCM5qzEx9vPkK1aUpyA/lh+beZHaoU9Ntz+4ZY2y1E6alKULerhYimcN4l1kh/DtZmjyWrPJp2a7acgSIv0kcSdbD6DuUDUWFhMQAd8lOwUv/kMYqmte6lJyNd32cpmWi6aB6SqCuafynpWX4yAB86mBR1/Q0kz5q2M3h//wWItDKGe/1drsNKv0cm40To2hJ63uj2pnu/1QVNrQXjyhqAobazBaa04hfDygyRgMHKeJWRz12;4:kUHiglBESLpH+VYOWbUneqCRWguCkM/S3INySf9ixdbN3KfwLSY/Kyrowwcj7Y7xTWET1P+fQwSI5/tNTGhYPK6VavUWIXHsumIorjZHMG4np20triKfSf7xedLXFryqXA3xq/U1LL37u7TItYI+p43BEEzBMcd8jnqhKg2/n4AeGPoQaNMFhTTfNw9oz3bsBJfOT/5HSII3cLLyXGeAEB7Q7civd3NJPJd/APrvHVyeDV0MMpmp8GeQHGalvHtDiDsNSdmrN/+PuJX6pdK8OJ9m1Dnv87HgBjYwhjl75iPOWy0sd0mp2VrpMNr0+ATw
X-Microsoft-Antispam-PRVS: <AM0PR08MB35889C89AEA01D8F0D867DDDC9140@AM0PR08MB3588.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:AM0PR08MB3588;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3588;
X-Forefront-PRVS: 0808323E97
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(136003)(39850400004)(366004)(396003)(376002)(346002)(54094003)(199004)(189003)(34290500001)(476003)(16526019)(26005)(186003)(25786009)(33656002)(47776003)(14444005)(76176011)(7696005)(52116002)(23726003)(69596002)(1076002)(3846002)(6116002)(7736002)(8676002)(7416002)(8936002)(81156014)(36756003)(6246003)(486006)(68736007)(11346002)(956004)(4326008)(50466002)(305945005)(81166006)(39060400002)(446003)(478600001)(58126008)(16586007)(316002)(2906002)(9686003)(66066001)(5660300001)(54906003)(53416004)(6506007)(386003)(106356001)(105586002)(229853002)(55016002)(86362001)(53936002)(97736004)(6916009)(6666003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:AM0PR08MB3588;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3588;23:KmmQdLqnwSy/m+dLd41Grnmw9N9wLiS/6icwGyynw?=
 =?us-ascii?Q?KLSHSwO+5RO6XBvpZxHL8KC1273no4O03uCGhwQtYa/tKTdEbEtrJ56TZL0O?=
 =?us-ascii?Q?E4suB/wyvYcfxsM0IUegK6G0flabX5yAqXaQ6qkVSXuiOGjUvG3RzAlX/NWB?=
 =?us-ascii?Q?P/lyEj5rtxWruIY5mP/rLiZT5dK7KNKhYsv6TF9vXnefg9ne/MFCipD98dpb?=
 =?us-ascii?Q?zvV/7lpxgWaNQHo/JIGi9ciWtwbyeoKdrJ9A7N6pfLBSonlXB2ZbgH1jvDug?=
 =?us-ascii?Q?+sft5Edezol9GjkFJoONFgpRxfA+bVQga12mX8q31sDmjOq9KD0FCizquGp9?=
 =?us-ascii?Q?jk9UwU1N0F7ARgPstbOk+8NMcheIKOaGbr9PWzXLcIDRFxmp4ziXHJ1P6kN1?=
 =?us-ascii?Q?AFL9fr7lqX7p7/XwQTTaYLe8BPtu6k4eYOie6rZFOppJ3epiV42R41sNTVrR?=
 =?us-ascii?Q?0x9k106Un/GGtbOGKGswann5K6Iy336kArYqZPJkg3NDZc0TO2ZowjrmLm4y?=
 =?us-ascii?Q?uGJGrxaaYJpPjad1i2NZ+0Cayv3c9R+Z8/gsTTxZpL0IVRGlUE6ApiBU2DvM?=
 =?us-ascii?Q?V3JYECAdLDNEHBdqJKz8PzIAo9IEP82M2OK6fR5OiGdljgCL6a9ax4mlyjv2?=
 =?us-ascii?Q?6Sujivl2Qgw9EEA24VjE2TI5zp89/yZxDTYI4QIHAOu1iDz3oHA2n8cEwTvk?=
 =?us-ascii?Q?x8DakNpRIlFbvJEk5g88ciJdsCnVU0YwyBTT1Q1bGxI/DOjsNa+R45oUPkpY?=
 =?us-ascii?Q?En+ICdiblnEPUnbLVl1t7BsXOKyNJHyRKiSyHke3O4MC59D+XSyZYWVI7B3d?=
 =?us-ascii?Q?RB77V5h2VWUZMbop/dweIX+C6Lh5VsCAjIW7ox/Zt1L7MtOgVNOFJWKB2J1K?=
 =?us-ascii?Q?1HJpp6mtl3pZnxG5evBfIT9GQOLReZWZL02hF2o/9Oxlm/Y23LNyII3xswIs?=
 =?us-ascii?Q?I28W00GcTL9Sj7/y+STI9EHKvHc1ZCF5sRyIxkw9Vxm006YL7r3aPtt1cdTc?=
 =?us-ascii?Q?XTywB4rVQ1FA16u/4DP9XA7pQOFEMFxDdew8gVJvbg6s/5MWXvxPiUKnOZKZ?=
 =?us-ascii?Q?yQ7e4Bak0gpS5WXHlPU9BmwO7WWsQW/p2niX1B0iFlJWCeyUF+0iaf03HXqm?=
 =?us-ascii?Q?lD6uDiwD+9iBr52K1rTq6Ok6fIAuFIlfQoj0FW+Kfh9urx88MDdrzTnZPaab?=
 =?us-ascii?Q?H3pxRt23KR1NE1PFjTMtSHMnS4yL+dxlTR0ARiIOUu1FUS6TaaRAqqTUG2Wa?=
 =?us-ascii?Q?oWq6nncefE4BmoSi1zMDRofWENzqXazqIZd3w57VJ8TE0Gdg4RO/HaShnxbd?=
 =?us-ascii?Q?n4paOi+vXOaq9UQA7XHt9nxtnvaRb+dJEfSUJHt3n+vrSrAZmzGD2gM4tINx?=
 =?us-ascii?Q?hbgZPlbCKWuSncO7+VfIn0LqF7Ut83aPGT1DBv5e6jEuxg9vJb9e5PzYHKW5?=
 =?us-ascii?Q?L0l0s8RRs4cmgMpo6kUHLb96mZtBZmEneDO3q1R+OWkp/e+/oZ8?=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3588;23:C5hGZ/QRdnlCK+z3S44od6nyeaYKlcOuBsVVtqbf2Oj6a8Ev8DSdpeJx/R5fpsnz+rYA/iVkbFSSMjpeHLNPi/YV/qEpQnkICbHZJqtdcNh0g9RHtlqAVQWAwBw2Rt/xp64EYLYhMsAP8hPyvAynEg==;6:HoHn+lLVyEjjI46bodQmtQpoy60OVInb7zlBNQSa28KlRNoR5BWJ0u2VZSyZmZERmU07M4r3bZJz/T1jDxGW9xJGSeaqZqc4QKIPFEZAB0fCvdrehEXyHYG2D6KHSKRzuLesIGWH6trh2Buj8hdsB42GP2kp+3YY3Q0NktCNmZNsmkTStQ18ZcGA0bqkKv/mdXz/R+uDdhcWydP4Sp7iIvUjqpLemtdumbaBWe3hsGzsON5sq21fhM+/ckC7esKpr5LhXjW+r6q+A+wO5qZh3YTK7U/MfDoT/ZXiEEBSyl3W4A6qcIdP61VnNVtK+fBZgubzyKgNvWLPfgTrNbflioABzm9xJh8MkUlgkkuOJsmTWHwFbNXXpLG1PsVYpBkZUA54og2+C9W8Ihf6wOVzugx2svSkYChNwfCvEXFipcWYXllxYDX1LhD/TF1iQ9n4i9Y/VcwFeEZ9UC7cF5sbrA==;5:SwjpFIdWvx/GMQIZonRtE3sBerW1h9H6wkD0oGxJvqrn+p9qpjhDnTvEAFFngMPLoRa7DYQp0VOg1d0bKW9ariFrxc7sWxP7nCSQNhVF+WMwDp7IYwXj39ouCXSMgYO7ozhehFziHUke/Yg9n+eJnk355JHCtDvXw2OJSVKaviE=
X-Microsoft-Antispam-Message-Info: 2WqEGXD59sX3Up6RrysbjTHR0rzxyMWu9mIYvnpUR0R14BiNq6lO64NRfCJBf92lsCQmarAxqpb8keNibas9oELgdi64jkl9Ud0D0UHaQ96wVShVM9/CJUUQvKMoEcnL8OYGhFflZpMozEIYd7bGW3UZB525JKQ+IX1rKRUQZGZ2GkhnD12/iAm9szu5fbjCpAPOLbWeqPEtf9WTUmITZxfbAOyDoMm80PLec/tV5qQj2R+BWwvTuBlBm9mPXW16WQnNYddqM53tj1M7JA888QuFTVOK7a6Ya/zpS6d41x78B4s68DOM1Cfg/bJEIxPfcn6rywPfB77gsCpPGEMF1BiMBwlG4gJiLSV4MKEu0a/WsfVj0hlgSJ/vJsNZl2YoFOxOgPTgfsuNSnFByJ27WXHEjEnBSqFfReXZBecFY1GpdTF1o3PAzDvSpTc9wKG5tFQAVgik50EcdG3en3MqJEaexNycJbNWDx94pmcRHAFwqgtqbH+eWOyhXfMbl8Ac27NUUEYdP9YA0nWg5/e/Ucfk0ouDdNDJzyFzNhLjO701olRUQW/CsVOan8ATIzcw
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3588;7:GE/T/SezQ4rLOoisoWxv7BGXWeiuPxsPbApogZ1uQFHvPqaV2PUcxURMTyglQM4gSZokua2zm76M0/87dne+l777avGuEH30mENaQeNJsBfida3K8i6rHCnXNueESmJSh7XompeUKEwz4Lq+IC2xBakkV5DfDZ/H59//ZFvDoXGkbEkvWCAiDb9jUCzFVTRFZtOUIyBrf8dvVhDpyOVykatpEXYAhDL+pYNk+iJi+SCOZogaWO68938NybVkPE4G;20:zqZoQ6gyx0LzGVo2RBsgueOxEAgErhsnL6ccJn9s87sNttmyTLMJbA85Ux1e/9guA9g8SBewmrrJAUC30oegsxKJzRtVt35i/ngoYn1hzKAeyDljMAFTbxSciESlR/mm5ZCotjw+oZvhZpOWk3EwqA/snvUKiwDHmPS0du2kBXM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2018 09:42:19.1228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cea06f4-0347-4f6d-b8c9-08d6245d8517
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3588
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 07:02:58PM +0200, Vitaly Kuznetsov wrote:
> VP inedx almost always matches VCPU and when it does it's faster to walk
> the sparse set instead of all vcpus.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 96 +++++++++++++++++++++++--------------------
>  1 file changed, 52 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index eeb12eacd525..cc0535a078f7 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1277,32 +1277,37 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
>  		return kvm_hv_get_msr(vcpu, msr, pdata, host);
>  }
>  
> -static __always_inline int get_sparse_bank_no(u64 valid_bank_mask, int bank_no)
> +static __always_inline bool hv_vcpu_in_sparse_set(struct kvm_vcpu_hv *hv_vcpu,
> +						  u64 sparse_banks[],
> +						  u64 valid_bank_mask)
>  {
> -	int i = 0, j;
> +	int bank = hv_vcpu->vp_index / 64, sbank;
>  
> -	if (!(valid_bank_mask & BIT_ULL(bank_no)))
> -		return -1;
> +	if (bank >= 64)
> +		return false;
>  
> -	for (j = 0; j < bank_no; j++)
> -		if (valid_bank_mask & BIT_ULL(j))
> -			i++;
> +	if (!(valid_bank_mask & BIT_ULL(bank)))
> +		return false;
>  
> -	return i;
> +	/* Sparse bank number equals to the number of set bits before it */
> +	sbank = bitmap_weight((unsigned long *)&valid_bank_mask, bank);
> +
> +	return !!(sparse_banks[sbank] & BIT_ULL(hv_vcpu->vp_index % 64));
>  }
>  
>  static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
>  			    u16 rep_cnt, bool ex)
>  {
>  	struct kvm *kvm = current_vcpu->kvm;
> -	struct kvm_vcpu_hv *hv_current = &current_vcpu->arch.hyperv;
> +	struct kvm_hv *hv = &kvm->arch.hyperv;
> +	struct kvm_vcpu_hv *hv_vcpu = &current_vcpu->arch.hyperv;
>  	struct hv_tlb_flush_ex flush_ex;
>  	struct hv_tlb_flush flush;
>  	struct kvm_vcpu *vcpu;
>  	unsigned long vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)] = {0};
> -	u64 valid_bank_mask = 0;
> +	u64 valid_bank_mask;
>  	u64 sparse_banks[64];
> -	int sparse_banks_len, i;
> +	int sparse_banks_len, i, bank, sbank;
>  	bool all_cpus;
>  
>  	if (!ex) {
> @@ -1312,6 +1317,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
>  		trace_kvm_hv_flush_tlb(flush.processor_mask,
>  				       flush.address_space, flush.flags);
>  
> +		valid_bank_mask = BIT_ULL(0);
>  		sparse_banks[0] = flush.processor_mask;
>  		all_cpus = flush.flags & HV_FLUSH_ALL_PROCESSORS;
>  	} else {
> @@ -1344,52 +1350,54 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
>  			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>  	}
>  
> -	cpumask_clear(&hv_current->tlb_lush);
> +	/*
> +	 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we can't
> +	 * analyze it here, flush TLB regardless of the specified address space.
> +	 */
> +	cpumask_clear(&hv_vcpu->tlb_lush);

Maybe squash this hv_current -> hv_vcpu renaming into patch 3?
(And yes this "lush" is funny, too ;)

>  
>  	if (all_cpus) {
>  		kvm_make_vcpus_request_mask(kvm,
>  				    KVM_REQ_TLB_FLUSH | KVM_REQUEST_NO_WAKEUP,
> -				    NULL, &hv_current->tlb_lush);
> +				    NULL, &hv_vcpu->tlb_lush);
>  		goto ret_success;
>  	}
>  
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
> -		int bank = hv->vp_index / 64, sbank = 0;
> -
> -		/* Banks >64 can't be represented */
> -		if (bank >= 64)
> -			continue;
> -
> -		/* Non-ex hypercalls can only address first 64 vCPUs */
> -		if (!ex && bank)
> -			continue;
> -
> -		if (ex) {
> -			/*
> -			 * Check is the bank of this vCPU is in sparse
> -			 * set and get the sparse bank number.
> -			 */
> -			sbank = get_sparse_bank_no(valid_bank_mask, bank);
> -
> -			if (sbank < 0)
> -				continue;
> +	if (atomic_read(&hv->num_mismatched_vp_indexes)) {
> +		kvm_for_each_vcpu(i, vcpu, kvm) {
> +			if (hv_vcpu_in_sparse_set(&vcpu->arch.hyperv,
> +						  sparse_banks,
> +						  valid_bank_mask))
> +				__set_bit(i, vcpu_bitmap);
>  		}
> +		goto flush_request;
> +	}
>  
> -		if (!(sparse_banks[sbank] & BIT_ULL(hv->vp_index % 64)))
> -			continue;
> -
> -		/*
> -		 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we
> -		 * can't analyze it here, flush TLB regardless of the specified
> -		 * address space.
> -		 */
> -		__set_bit(i, vcpu_bitmap);
> +	/*
> +	 * num_mismatched_vp_indexes is zero so every vcpu has
> +	 * vp_index == vcpu_idx.
> +	 */
> +	sbank = 0;
> +	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask,
> +			 BITS_PER_LONG) {

s/BITS_PER_LONG/64/

> +		for_each_set_bit(i,
> +				 (unsigned long *)&sparse_banks[sbank],
> +				 BITS_PER_LONG) {

ditto

> +			u32 vp_index = bank * 64 + i;
> +
> +			/* A non-existent vCPU was specified */
> +			if (vp_index >= KVM_MAX_VCPUS)
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +			__set_bit(vp_index, vcpu_bitmap);
> +		}
> +		sbank++;
>  	}

I wonder if copying the bank as a whole would make it easier to follow
(and somewhat more efficient):

	sbank = 0;
	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask, 64)
		((u64)vcpu_bitmap)[bank] = sparse_banks[sbank++];

Also it seems equally efficient but slightly easier to read if
vcpu_bitmap is filled first regardless of ->num_mismatched_vp_indexes,
and then either passed directly to kvm_make_vcpus_request_mask if
num_mismatched_vp_indexes == 0, or converted into the real vcpu mask
using the regular test_bit otherwise.

So eventually it all would look like

	...
	u64 vp_bitmap[KVM_MAX_VCPUS / 64] = {0};
  	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS) = {0};
	unsigned long *vcpu_mask;
	...
	if (all_cpus) {
		vcpu_mask = NULL;
		goto flush_request;
	}

	sbank = 0;
	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask, 64)
		vp_bitmap[bank] = sparse_banks[sbank++];

	if (likely(!atomic_read(&hv->num_mismatched_vp_indexes)) {
		/* for all vcpus vp_index == vcpu_idx */
		vcpu_mask = vp_bitmap;
		goto flush_request;
	}

	kvm_for_each_vcpu(i, vcpu, kvm)
		if (test_bit(vcpu_to_hv_vcpu(vcpu)->vp_index, vp_bitmap))
			__set_bit(i, vcpu_bitmap);
	vcpu_mask = vcpu_bitmap;
	...

>  
> +flush_request:
>  	kvm_make_vcpus_request_mask(kvm,
>  				    KVM_REQ_TLB_FLUSH | KVM_REQUEST_NO_WAKEUP,
> -				    vcpu_bitmap, &hv_current->tlb_lush);
> +				    vcpu_bitmap, &hv_vcpu->tlb_lush);
>  
>  ret_success:
>  	/* We always do full TLB flush, set rep_done = rep_cnt. */

Roman.
