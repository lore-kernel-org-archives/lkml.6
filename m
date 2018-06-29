Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770F3C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E0127D32
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iCAHUqff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E0127D32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935170AbeF2KLz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:11:55 -0400
Received: from mail-he1eur02hn0242.outbound.protection.outlook.com ([104.47.5.242]:37728
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932266AbeF2KLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icP1pTjPajoWCQ2q2/g2YEYEyZA0iWshDXXhuIpYeqU=;
 b=iCAHUqffejt7Ck9Wl6VShJ2besAgiyTw3pep9PN3H6xMt6D7rHEySTN0T/S4cfFQxI9ropLExZMvRUUZ60H9CawDJMVZTxnGtL1r7XFMMGk50H7au8cB0y3Og30Ju4CBLQ1BJaWcylAwKWEUVhod9wPda5Ay/GWxDVPWeBo3deE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 VI1PR0801MB1981.eurprd08.prod.outlook.com (2603:10a6:800:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Fri, 29 Jun
 2018 10:11:41 +0000
Date:   Fri, 29 Jun 2018 13:11:36 +0300
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
Subject: Re: [PATCH v2 2/5] KVM: x86: hyperv: introduce vp_index_to_vcpu_idx
 mapping
Message-ID: <20180629101134.GA15656@rkaganb.sw.ru>
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
References: <20180628135313.17468-1-vkuznets@redhat.com>
 <20180628135313.17468-3-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628135313.17468-3-vkuznets@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR06CA0161.eurprd06.prod.outlook.com
 (2603:10a6:7:16::48) To VI1PR0801MB1981.eurprd08.prod.outlook.com
 (2603:10a6:800:8a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f4c1e00-7896-48fd-8524-08d5dda8b640
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1981;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;3:L7ejv+EgTLB92WSvGm8/My+Xs/h2yL9Gr64m94YXfPhOWsmdmbT/kT6GSsdG2sl85ttF737cZsAYu7fn77RkyOKtVY27ESISNp6qDLK9CNM6i0Cjm/BNXVPBrld5VVsd/rBbanrGvBWWgOErUBiXurvDvzz5kCtampGaOJUYonXXFHV8Z7Iyw+J6yrbDKAEC+XQLqFZyjbEBXLp/3q3dCp0xGt2thfbQan08NDwmhZp4m+Tm9PvCMUW2V4+bWmQu;25:GPTQDnnT2qpkQUZX7HN+7Pdqu9D5nIfKTvuiGAWgkWrV/8Ve2tOh3AdqCcrQwNNb7l16B+qpTrTi73DQrBUXEQio7NvC5J4bbQcXIC0RhJWJydFm8+JIh3QX1UZnGyjIPw5YdGE52n6Uyr/jMbZoOV+X/c69wK6zZB/ifKiY3LYmIxvmunHJPFKLuYuIjDg9i3OaToXZFnHHqA95BQtd2CMxnbgavrkRcAIVHlD+w/bM7tYZDnDRNCp3W6fder+/UXLMRhfug3AHJDNPjN6/qidamYSha7bIq9/vDcUx5fBQ6iJtYKTK4JO0pA8EUCtfjVEz1/Gwdn9UZUZe1tiIWQ==;31:DVBuqXAqmt8uQhUSbtitiNwAPeQptKrZxNgKW1iaRKOj8sfzQ8+p3aHW89N1E6+eG3TGBHpjzL0Qs1xdC77VyVwx1H+uvmdUbQZTyqcIeGBzwCjwRsdtTs7yVAMy5xsnAyRLmXycOrgo80fz+6FFenTqdoJ5nJCFGZR06uAf3JBvjTJkUxZFZJ/+KXG37XJiZf73g37lCneKPhOh5tQz0WGFEdi8lVHzVYgQ16ywBUY=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1981:|VI1PR0801MB1981:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;20:tUtupfh9yc74q80YrAEY0AOxYaX/r7U+3W0YP3d4c++YhZVSdatlZbKGXluTCkL7v67PSqO2MuXLtykYcwGNitDZbuaMhNIVoHowYkroDogAxZY4aw0NuiblNtvWoFqNGgflt6bx/gFPa2SRORaESPFlOSFayIS0gfpW7dQ1+mQVO04UIWmlS51HO158ewgx9nnX0BFNLuM+WIJbbkfHUYgtFZrvDPEOu/NKjuhIbvkdRs3YgkC7I4i4QAOTvJ9OAu1ZzT6odLtbHsRElsyUfb/ZGkrcTZjIpgKr+Dk76B0M/1GvsAUK3kDu24By3FHtqedjL9zo+sR6weHZRsaJmtp+XQlJ7gswOufbdwwkvOu1PF8fshOPbewp1HqCNE85liTYWFnweVqmSpTzcHwwSbrxobKTFMgm0cXpbULJ72ta2Lk2wM3HQQGbdJxFdet0ZjyAHI4IDMdDhmzHYPdy9pvolXxIdpygs6KyTCCLZ+NGmUy6yL5fQGIo7ANVfDxT;4:22ScVClX8ieXaMxQG2xAQFJx5D8f/ddW5T4gxXCUEZcJ/qy8jDU2ZNoLGNh31FnUOWASp5e23s0iAZ0l9x0Zxdcv+ksYCzH3eDfshfCAUB4m2MeytGkCwEGBpQOaB5NF70na5iscG6wRqO+sfY6Lu19KvB7QpL87r1U2bG3/zISx8J5WWoppgavvPkcN6b7vZs49RPti8xYTxiox8B1Wf/WK/QwAJYYnWryV84IdncEb5BKJ/NxOeIqilVC3ijtJZ0aiYjrwDwnOnnq3DWlL1Q==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB198178D64B7834D669516A01C94E0@VI1PR0801MB1981.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1981;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1981;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(376002)(39850400004)(346002)(396003)(366004)(136003)(189003)(199004)(486006)(7416002)(81166006)(186003)(8676002)(386003)(16526019)(81156014)(8936002)(36756003)(9686003)(52116002)(6666003)(7696005)(68736007)(26005)(6506007)(6916009)(5660300001)(76176011)(6116002)(23726003)(3846002)(229853002)(1076002)(4326008)(55016002)(47776003)(69596002)(66066001)(39060400002)(106356001)(105586002)(53416004)(478600001)(6246003)(305945005)(16586007)(316002)(86362001)(476003)(54906003)(7736002)(58126008)(11346002)(33656002)(25786009)(956004)(14444005)(446003)(53936002)(97736004)(2906002)(50466002)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR0801MB1981;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0801MB1981;23:KHMcrdKyCdo+Fr5DI8sA2oSFI58Z7qUSfFrMo5T?=
 =?us-ascii?Q?oOJnqSnyTayCBc1pyIW5jNJEAYqM7stnzJfTjw/7vDM177rwhxnKxjrIiHDc?=
 =?us-ascii?Q?tVeTK94DXD7zrwIocVtnL6y9vTXVOXiq80jqxLn41as4hhVDBA/wD/ymgk5j?=
 =?us-ascii?Q?40UEdgdtu98U/LNmF8IAj2N6KWqPO1Z2559x39n1mywSvGH33yAXf3VpfMTg?=
 =?us-ascii?Q?9aJouaWBaVBYdZupy324jDui9VcOtf1jsIuHkrjCIUKL1Yq+TawDWSBf49a7?=
 =?us-ascii?Q?B9C+MHtAXn/5rmMXtY3ByBZD5Nj8t6bZ/lpeaOX9lhOh22ykd19Xt2w4bZtH?=
 =?us-ascii?Q?960yp9IOBPzcgbVe3+BecD2Om3RYnoO28lg1CClrblqh6QVQFtNDxiHRe5WY?=
 =?us-ascii?Q?rZbmf04zvmKVgwEiXj61xlvioznW68d6UA4h18nbEANeCOv77OFsrimy93/F?=
 =?us-ascii?Q?CT8FhTznzJwd8kSPNA86ai4TV7vzTKJSxzNsGER2CAQ5oUGsAUzDcw+Z4c2d?=
 =?us-ascii?Q?ckWc6CEvbEdLhLgo/L4+iZfo1CEYzfgoi0mY/yivt0eqI+8c/rMH7NUJN+3L?=
 =?us-ascii?Q?vxfGNezZUyl0ROQ77DkJLdVb1OWVBJoNv3I+7OzJuLDAeIeAbskHhh+a0Oad?=
 =?us-ascii?Q?TE8FEWSAO3WvqDtNtynCdqFzaR+Em7ezFu7ERea5HJYD8nxos1P7E5/5CkxZ?=
 =?us-ascii?Q?IQSF61a/HKWS2s6nX6o/2ju1BwfCNfbqX+aiQ82Darrxtlvh6p0jcHbIDj9W?=
 =?us-ascii?Q?Cpkg3xdklFWwLd4Hf3QnRUmS+N8BTE5JMAns+uaxc4NCo1sa4WRqx1Ty0FWk?=
 =?us-ascii?Q?vNuzrvq8O+yKvlN71xWpSovMO4rBbmfrziHrWbzuVq4f7D+cBHLuJlbvlMvC?=
 =?us-ascii?Q?O8y3oUDKlmWp+mQkh+qoU9adowhJENDiNqGCXEUUe7zlxL7zy8wOdhi7JUmr?=
 =?us-ascii?Q?AnPjA93y7Z8XuyKSqu5m7y4paR4MxOrqVzIBFdOU4Os2UZn6H7VHoKbQNy1G?=
 =?us-ascii?Q?mdCGABKJd1+1Pi2aKbFmfRjgV1Anj4O7xyZYGp1y8M+qZcwaTiRXbZyihi7e?=
 =?us-ascii?Q?GZCPaM06Vyu1/zQSkGkLNb/4/s6G9f1RX9UHi/kG7WUxdB6EW3c89hQqZ1m8?=
 =?us-ascii?Q?k1ti4gzaLHk5byyx4VEl6qZA3HU7piAaKeO+/5ft1BropGCKOUb35pqxX0gW?=
 =?us-ascii?Q?RG83pCiMehnOZNOBqf5tBMMGqgaleSquyP1gYXQaIpYuRvpz/mbxc0izeJMl?=
 =?us-ascii?Q?AD6xudsszu86gd4yOBsbfJeruYzNSzcPebzSkGNP4psTob6zP19zZzp3Kpct?=
 =?us-ascii?Q?OcvAC9nxfddjRJ8FEkrH3Pcia1tSIZTNUnUr81Vv/bfjjXiJ55qIR5cbMUJV?=
 =?us-ascii?Q?9O1UC8JwzdCKr8Vx84UbEyFT3zs+/b80Lc9s0tQFZwE+VzINfkjifumitZ8G?=
 =?us-ascii?Q?EAnDLLsQS3w=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;23:x5L3RyoOSYQP+772ysoF29Kqi+vTBWPceQKe77YEWyzZEGQPMZEPt45yj+zh1f+rfCWV1Rl/cecjtk7bH+rAFtBtXwGACpuwNWIRaXok0dDObOQG5gMAvNmTT84gArBdIobgDG2Gp/a5PayZcSVEFg==;6:4ZZcDdXuidKUeuTyJ4cWb71rDx4qKIvWIW6IFz+0+MQlaSnHLdTLx/W44VMigmX5cqsyPeUeGldsjzdUa8xJlwfFMSMtYVA6SUDuk3gMnHZMgbYBKM7kxxB0CYtzrKRxPiox74kM3REkvyT/rppfCb2tLnQoxwXWElTcc9LdQh8OLhY1R1VviBl7/8uqlVL+QK5OZ1h/TWii+QkxX14m5wmpTKCj7VIBDYKALQGy0qYowovL5U6tOGcYCY/JO1bfd0vjWbQrJZw+o5K/1Sub5/r3CLO35FiHYQUfIrahedYk73xV4SWqh9jBsEPueBSdBnNIDag+rAW5SCSTUFLx5lVJMGYRYxnHQBNcITYGcYMBSoGfo/b5swWEIGWAxXXkZze/na75w6vpSylHdc0d7Hz8Og1F381lecfhyTRAAm5ymEm7jlCkujOKpX8izhODGtRfn/bb8vi7Gy+MGoYOLPt8JHei5PjLJh4VKUMZZ1CxqcBjk3c3qtz9YnMVpdM4;5:oCj2Po3ic6tr0FKEa8JOXeD+i3uDj00BA9mhm32499KCH7S5I0vnSGp/V5MLF+/Ah/6C7nVJ60RsaKKd3bhICpN3YcG0uCRMAqKHExRe3DnXTiqelK4j0QJG0rUkIEF/0E91SLyfaXmYfDRHLa+rNqA5CqticlYCKPRfz1NKXCc=
X-Microsoft-Antispam-Message-Info: DusItFNXlEEFRUEhIfQO38YlTyF1DLvquJX3rOsrrEJJCNWPOVyt8Rw/82E4h4nNdtuTQbpg7Ha/uymWtj2KzkKkYn/Xc2+8sBgXipIA1TWz4o577Yi70D7R6k1avV/zbitw1sBhyDg2Y3BXTPraJy37++aRrqBqGSQWScSyKAQ/7WIUlBgDmhuWpYuNsu8xrja2CWIVx1FZuY4C07/n1kHF9WBXyH5O3dc7aVzpk0iGKnKfjkcxeHLcTl+fAc1MFii4BzcH2GzqUmVGpG2NUbDv4wA/HZ7936iPlgHBpLapbg1xb5+EVj+RIno/hksoJzw4kCeS+PgTALXgeqo+zK0+nobJ9a+N3gsGIzRg4ownJGeTreEhOEOAu2DLordqOCvuyH+QKsJJ+U5YF43joWWYBqDxvs7Ew0bhJM+Bw8GXQRv+oQnP5fq24qGUc9RTCzKK+hVApm76Wfp4imc0Pstq8cDhortWXMNQCh2pgTXpPzvhQ2myjaxXqZcp4mNQ9HxRVk5f/rnDpBKJZ7di6jsKGovZnq+ouim9dia3FnVmiArIpFw0osaRGXsA91oSHrBxCTuDayr2ULWtSoUGAA==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;7:Dm+YZWGMXfjBC2udRYjkHshO73f8hOCog7T8vIpRtUXAeO4Z5kEqANBxCtSYzPxVaPeHnvS0AxaKpYODCWaW4ThrwMGqaYcNZsta9OKIMLyf1FbeJaClIw1++fmluxgAy1+u8N21XxVhE4BZICrP8rGK1bfJ1a849ddRARl/A8TwHtGXX6UPrqq8YR0gjos32lQhXpo8oX+IEZo1MaxCU3Lswz4GhLMbPlrPAYS6Ug7GoKGWUg4gzZZih5YhIOrv;20:8y5ZF1NAP2SPbdyZ/DwREtQye09lMaE3ns8Og7uAdwJKSWLZgquBKPZu/ehMK9/bm3Zkzn/oOxNHeB9dgo02QKS19QLT9pvSb3VGJtZeVdSRCazjlQPrP9xTxmMHd7Zv6aqgBWPoF6qh5eeVhvKLV8GkhKGrLK63n0wXV33v604=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 10:11:41.0957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4c1e00-7896-48fd-8524-08d5dda8b640
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1981
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 03:53:10PM +0200, Vitaly Kuznetsov wrote:
> While it is easy to get VP index from vCPU index the reverse task is hard.
> Basically, to solve it we have to walk all vCPUs checking if their VP index
> matches. For hypercalls like HvFlushVirtualAddress{List,Space}* and the
> upcoming HvSendSyntheticClusterIpi* where a single CPU may be specified in
> the whole set this is obviously sub-optimal.
> 
> As VP index can be set to anything <= U32_MAX by userspace using plain
> [0..MAX_VP_INDEX] array is not a viable option. Use condensed sorted
> array with logarithmic search complexity instead. Use RCU to make read
> access as fast as possible and maintain atomicity of updates.

Quoting TLFS 5.0C section 7.8.1:

> Virtual processors are identified by using an index (VP index). The
> maximum number of virtual processors per partition supported by the
> current implementation of the hypervisor can be obtained through CPUID
> leaf 0x40000005. A virtual processor index must be less than the
> maximum number of virtual processors per partition.

so this is a dense index, and VP_INDEX >= KVM_MAX_VCPUS is invalid.  I
think we're better off enforcing this in kvm_hv_set_msr and keep the
translation simple.  If the algorithm in get_vcpu_by_vpidx is not good
enough (and yes it can be made to return NULL early on vpidx >=
KVM_MAX_VCPUS instead of taking the slow path) then a simple index array
of KVM_MAX_VCPUS entries should certainly do.

Roman.
