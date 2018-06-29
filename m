Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFD6C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8942F27880
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Mvw8KkGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8942F27880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937087AbeF2Qx3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:53:29 -0400
Received: from mail-db5eur03hn0222.outbound.protection.outlook.com ([104.47.10.222]:7011
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932296AbeF2Qx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3r2LTBrtL8L7ZFZHxlsuCLxaIuW+EGneUfCnysr1G0=;
 b=Mvw8KkGpxVeP3eCDGMSkTcCAmvArAJV0KlZjsvFCC/jdOLXdAW8WnxFrgY4GPjU2fk8rdanzeiZU8vm+UpkbE6PNVBEpj5BaQdH/N9lLxFHP+VGU/eJjbNn/6BbxoDgc7TFQ50ANc8j1lrCq2FTSs3Xmxqk1kGc82YJYdSRq+SY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 DB6PR0801MB1975.eurprd08.prod.outlook.com (2603:10a6:4:75::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Fri, 29 Jun 2018 16:53:12 +0000
Date:   Fri, 29 Jun 2018 19:53:03 +0300
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
Message-ID: <20180629165303.GA16672@rkaganb.sw.ru>
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
 <20180629150104.GE15656@rkaganb.sw.ru>
 <87a7rdd3ec.fsf@vitty.brq.redhat.com>
 <20180629162636.GG15656@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629162636.GG15656@rkaganb.sw.ru>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR09CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::27) To DB6PR0801MB1975.eurprd08.prod.outlook.com
 (2603:10a6:4:75::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baf5b5f3-e71c-4600-237e-08d5dde0ce27
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1975;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;3:yqHB3WfZG//8XrolLGUEPIpMpISNQX11cqd1Flk2eQ1sSMseyLEAflVDxnrorIEyIHepR8F6O34XArCHMngDDoR1ynIILVSVur+4OUfoIRG6A3JPZFHbmKAy+TtwoJPQdQA8Oljn8rCPSITqjqw++7qUdXie+3K3v4Je50qYd7iY3vc+YSh9k4b+v953L7UG6WSMWh4d5io9G1xKNYMWKUYOy+NhgvlI6PPoMNK2TIrwPHDX2msMr0J5BN5dnfeW;25:2Z1au8itJbAQDt7il/nH3b9FYTgSOTe+luus74C2Gi9ETI1kSN5f5WByMoMsm/KMZKKDIdLuCRQ5hq54FavLCuwCOxE9rMXYoO69gvjiHcW+uznj2/hZBJCOHSylQ1CMCECjEofYqJ/YbIGgCy4d5Rch+xVLBO70DYuVShn4wOsx7R+1Wy2OId/eSzRRZvhD8pZggtyN0Sf7MmYXbEfUJ2NQlvT5GLrqAYU4wiyW7NBj/jNvO2Hndbk+EFFUhQJngFJ3V/ZGJhmvqG6DpTiPHIwOcotlqC/7FJiRb2gqvSuKFWTLj17qQtafIkKqEUlBLtel2ZMP//gxGKowhv2A6Q==;31:UAld7esNtygRsmNAy42MqquNN2BYK79IQWu0WWu5AFFnV/nEB28ASPVCcsIPXJ9wQj8MZbtOOuqK9tJSq97bba5JrOjQtk6+MT5YaPysZuX/W2ZyjNoIu4Jj1aXw6mOpAPjYK2DwD5c2SoxEn9EWW+2/Jp2qKrUQbVbBj2mgL86PqmmCl+HSQPGFlrger1xrUWK9O//TRijp3X/7Jh8sTbuEKcXU4Rwt7Kz99iIoJhU=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1975:|DB6PR0801MB1975:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;20:Yrf8jIYeiUJxM1WZ2n9YS4R3wxc/cg50XnNAosIlmqBViT9ZnTfbsdbHJ0k6DrMyFRVC87hinvXabmXubZqkJDz4oANz2yOBNh4Uw7vUvqrypWYRWQR3nSzU5K5me4y+vY+ylOK7zhd1k0RjSGHba9yM+39bO8O4xzT1FXjiWYOAw8TtWKziHR+REa9sOiTPDXlBfI9xYFWOiRCgOe3hvJb9p2C5DkK/ACyhZy/MuV+71qzaDqFZ4mBh9dq35ZkbNlMReIngF3hCJQh2mujIRQK9VKG3DeagFN+qcG5j54k4wllfmem5u7XJmkfQ1DIupDsGCscx7RtswKKzwT7SrFlbHfbUdIPAIsuI5ZxD4+s4pDwWds99Xaf3ALQa114p2ciho6RTyWisatzchh1c/j4JBiO1rGBalwUcbcIx+shISLlzEChTlrMeoTQWjwn8eIv4EtsC8yQiJ40A7U+39fLk3uWp1AESrjx2F8fMosoRB6r+PeqskDjRGpLBjQnB;4:yE+PmR6Fk9UYSxDJ47syXtE8KdNF4+vwUr7bKaOc6chTxgW8FrYEKI2VTq4vPNFdHLMAGOlvGqqnUxBtNaTFj4bYQxZpcz9zdBiCBuoVOWn3KLltL28k5B5phDO4Mtqm0KMZrLRGV4pwogwXnWMkxZN6eDw1sWYSddZyrldG/+fsE1NV8g+MIwxFsYBJuxqNy06tEKrX5ZL0ukuO/glPJYEE616KBvbdg0heWgnDo/k7LekkyTZZYtPJECOLJt0FFIZZpO9CEMkv6amx1foFcA==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB197577836302ABB099C5F11DC94E0@DB6PR0801MB1975.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1975;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1975;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39850400004)(366004)(189003)(199004)(8936002)(97736004)(53936002)(106356001)(8676002)(476003)(305945005)(66066001)(86362001)(7696005)(11346002)(5660300001)(6666003)(53416004)(105586002)(52116002)(7736002)(16586007)(14444005)(4326008)(81166006)(956004)(7416002)(39060400002)(446003)(81156014)(55016002)(47776003)(486006)(2906002)(26005)(68736007)(186003)(33656002)(9686003)(69596002)(76176011)(16526019)(54906003)(1076002)(25786009)(58126008)(3846002)(6116002)(6916009)(23726003)(6246003)(229853002)(478600001)(316002)(50466002)(386003)(6506007)(93886005)(36756003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:DB6PR0801MB1975;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1975;23:ubPBT5PoL++LCnUQAqcU1W5vXKkHdBt+mq7akHB?=
 =?us-ascii?Q?gvwnR71oh6cLkRjutzhGJn1GwkkTb09eAwlm5x88T67AI6MnsEKbbI4Agccw?=
 =?us-ascii?Q?U5zScta05iATKL48twKmHItwEeokyAInfO4JQCyjVrbUG7caeBPQ85JD1Bj9?=
 =?us-ascii?Q?5piKKKZxD4RHLAbClqueW5qGY8R4TeYtpMonUe4G7p5rsqRq7OsMfRoWESpk?=
 =?us-ascii?Q?Jo3ix4kKqQcxzwyagpbUAkYKnAGlHDMFQSiaJXDdanrTGbWRr5kZ2C73JJvP?=
 =?us-ascii?Q?7KHkEu3H7doRwae4ifa3/IFcUldHj1dhWg0yOM13/630C1Rdzh9D6InxRy8r?=
 =?us-ascii?Q?NdNkldMHKFQzNiif8cOVGR3JK2wcfjEEZjvTpkzRsf+7VVgskkHK5A0SwyOE?=
 =?us-ascii?Q?BtiatWDx1AUV36GTFp3+y7AcldDuu+UIuoq08ZwvcldeGaLCM5qQzpLnm7ed?=
 =?us-ascii?Q?QjRzCSvsfd/vKBrQM3bc9gTRh9FOxfYEyQz5VwCyI3yYDLNC7RABliipKvy7?=
 =?us-ascii?Q?qQ8ucgVWJIRBTaCmXmTm9k/sbwnE4sfpseWGJpx08AXzKstEad8Tn4L8NvqD?=
 =?us-ascii?Q?eIaUiGq/ZdQlABOTO2+J2OPh3upwEIXyAJBEiW5IAt03GpiEX67ZF/Ko9yKm?=
 =?us-ascii?Q?rFd+aps0lnJ7dONfksecq6s4ujoY8/9aEDh7D8rWNWErBvTmI4zd5MUd/cDz?=
 =?us-ascii?Q?ZlRwlzluP3b1TGa6EAiulHTQrfA1lqrBB4sMRk6bhls83GbOJuzYcZSZ1Xq9?=
 =?us-ascii?Q?WMrdmfXtH/QPOuEbxVYDJfHA0Dq5/mKV4LHMqG+Q4/kYYjjb0L0XuAFP7zab?=
 =?us-ascii?Q?B5sGcJDubeZnOmAH8zOo431EOVzH7nsP8Dz2m7sRFCJSOWkHjyy4vONoLTi0?=
 =?us-ascii?Q?a/RnpA1VjF1xCYKCWkRfzhzFhPwt3c3OjqmF5WZWhX4TvX5tCx/uvy6MFFF4?=
 =?us-ascii?Q?nbM0CY0nWd2p9R+KD4HoX7cIGNnhq9CJ0yZEgzriipOgIXRj2ixaK8kOdVNR?=
 =?us-ascii?Q?ZlH9Ql51wW2KNN4cXtH4yIGQYweNGP2VrIMZ4xAly5U9wFeX6FNcqDc34BfE?=
 =?us-ascii?Q?tWfRfjQNU4mw5fJ4bSkVLmnJ589NK7KMQhOpqVielh4SLLtaBQ8xdANfc9Lq?=
 =?us-ascii?Q?H37cve6eq36c2HA0PWsyqd7SsjEYeUIsZYBpzvhyc+EQBOqBaJHvOw+TYZMI?=
 =?us-ascii?Q?LR4qT2mHzUbEIyAfFWwxWVIcQ7FlKSuT04VhEgwaoMjkjZ07Rs+R6oGalBYX?=
 =?us-ascii?Q?nFHQj/+ylvepgF62y6L5uc6q/MfxKeezOJ+G2+FoxLnmrtZ40GlQ2KSJmLb4?=
 =?us-ascii?Q?FAJS/bzGkWM3/BO6xCYeE/KAjENypnPkWyWUrzZtiNBHIfok/4EU9yCtCIbJ?=
 =?us-ascii?Q?shl6lhwNmMfytr39SaqrzdjlJF4UniyCK5DsSdMNSfC2ICQt4zluMkElq8B8?=
 =?us-ascii?Q?DfFwhynToJB7GYim3q9BdkUigvIfyD9Q=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;23:jCQ8c4Lt0CBheTCa/p2/zC7Yj3PIuImfw0ZYi8upWxbTsnnjIGxs71DrBHVZS0a4e3KAd/QD3hIFxH0wyXXESgplaa2SW38k1aierx0Y6qFXpARwk0ePhTp7LaXvVjVccs6O2YiD6TGbDTo7SfzX1A==;6:x05S6bpYkjouQdlGxeILQIEw3No2kCXb0f6OEtv5gUveQO0faTDGrzLOZM25nOCyxnFn8Sd2muBKiQI6h3JnzlTs9pmi1po83vEmOabt4bhn7GzI+rIStrbcDCjeO7p8R+V+DVnsSQ/WMRMbWtRHIytswX7q6Beut6a1pvV2Mjv7d9ovwfHeF6VtBvQzJjZDg7jrEpqd6lkV7ckPOddqmaysoo2l4cMDtDr/ejL9nRkb9NU3H/xmiyUC7PqEaW+heW7Kz1SXte+WC409knx1su6g7Ac9ODAdAL46pfIOi/zORsOw6zuAy8p2KiZNPqZmCSU/ymIUs9GsOUuDJwSMAwO97ogPlzvZDPGUu6mZm0l6sEH/0Gh6rdMW5mWbnnhXjtlagd6Ray8Y2TMzrtinAQT8dqMitEcIgC2BlUljYKQGc2eVd8i5aPahfPf+s+JOI3pAtCG+mMc3Ygx/uL2H6ppqAUAAZ6JJU8dELujHOttsRBZSsMnzMxam/1HTxvD5;5:AYNqiW2wKyUT2DpshwUGDx1ADK6vRrQFhrvnbOPRZpeNspw8RctXe8DhHBVEAkhx3fy2ln3TeDT8GbDXBEFWr8NjWSQZL9ZgDyoUp4pJVwCDctlxo61UUZZMdTLnuCgySnzka4gUTBLqmQo8koqrM9Y5xc2sSorSJPXj3QuNhVE=
X-Microsoft-Antispam-Message-Info: ms1bgNi8L4VfrfbE8rEBx7/Yp0DM4DNPTKP5k2XjO6CfiJTMsxMteNkRXp2Y/N0k7CPga++StZMW92xeoCBt/Hgxn9m2htCxj8pTfUJWvkAGU789D76P/Lq9nIrO7cfQ/UOr/IdFT2GIEIYPWag8R5lBR5+Dw5tW/gk/pRAVSxcxgBghZ9kUeY3wW24p2DMCQqmx7IaJ396cz2+1P7+fKwFQqI5DRqtsD55k5+IObykkAfPsem1exuwWs27eKJDIivsqjjPSOK1nO1odi45QMgRrCaWsHq5XEvkD3pM+RR69upsWVGb7tB+tIN0gLTda5xk+HFFtwb6xAqzxTBGmqapoeZRRklLLuD1pKfrkyafsPLSML+yKx/Nf/D30WnvAXa9R/qss18Qq51yaiwtt1uXtNyl2hG2tUyKAndxqhwtXX59/uLHcSPJIEgxwD55GQ0whcq92vjiDLNeMjjCA3BjTebu/JXyWzFWqUm1ZFnpvjj9T5pzdUTqsEBdJZRyjPV59mm1KUNYnuHV27eoDHO0c6nDkOeqZ6qoGdjjTsrvMlbj9maeyLw0hibnecpXw2rDWJuVEnM3z1cb1nta9Ng==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;7:/sM8klPI8mfqSwoW92e3O5a5VUxEO778pP08639HN9wM6/eXDyO18b7WFO1y2GkaJygsfNoV7T2J4uoLHuj0eLxUXZS9fEvlItP8rlOkdHYsiym62nmF0s+3KxJtw2xf5XXVi+p5ALvrDSDKMcpH2Coosya1vttA7W6VUxFsWDWJLEskAZbfcCuN6HxoElfdPKfhf8d8VUXiOZIqoFf1yClCHb/Yq82/kH2KYbJV4lKs/cfpbafaNuUfGv2ozmbo;20:fRm7Q1+cyWOC3a/gDWgCHE2hSy+63CyDjPcQvX9cn8xdRhRMUDIdHmmXxIWKGQ6lo3ExDJFkYihjUqrxZtVw76V1WpQAhsZ5G7XIbr9AiLRGAqDOXZ4TBlr6mJ2FRCsNijp4CzxPfgX8LwzoC5AcwC6zr55ikts6Kazb4jAivxc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 16:53:12.9345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf5b5f3-e71c-4600-237e-08d5dde0ce27
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1975
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 07:26:36PM +0300, Roman Kagan wrote:
> On Fri, Jun 29, 2018 at 05:21:47PM +0200, Vitaly Kuznetsov wrote:
> > Roman Kagan <rkagan@virtuozzo.com> writes:
> > 
> > > On Fri, Jun 29, 2018 at 04:14:53PM +0200, Vitaly Kuznetsov wrote:
> > >> VP_INDEX almost always matches VCPU id and get_vcpu_by_vpidx() is fast,
> > >> use it instead of traversing full vCPU list every time.
> > >> 
> > >> To support the change switch kvm_make_vcpus_request_mask() to checking
> > >> vcpu_id instead of vcpu index,
> > >
> > > I'm afraid you can't do this: vcpu_id (== apic id) can be sparse, i.e.
> > > it's not very well suited for bitmaps and can exceed the max number of
> > > vcpus.
> > 
> > True. The bitmap should be of KVM_MAX_VCPU_ID size, not
> > KVM_MAX_VCPUS.
> > 
> > Unfortunately there's no convenient way to get VCPU idx from VCPU
> > id, kvm_vcpu_get_idx() just walks the whole list :-( I see two possible
> > options:
> > 1) Add vcpu_idx fields to struct kvm_vcpu
> > 2) Keep the change expecting masks of KVM_MAX_VCPU_ID in
> > kvm_make_vcpus_request_mask(). KVM_MAX_VCPU_ID is currently 1023 so our
> > bitmaps will be 16 longs long. Not sure if it's too much.
> 
> 3) rework get_vcpu_by_vpidx into get_vcpu_idx_by_vpidx followed by
> get_cpu, and use the former for your purposes

s/get_cpu/kvm_get_vcpu/ of course

> 4) duplicate get_vcpu_by_vpidx logic in get_vcpu_idx_by_vpidx
> 
> Roman.
> 
> P.S. I'm starting to wonder how safe this get_vcpu_* thing is WRT vcpu
> removal, but that's a different story anyway.
