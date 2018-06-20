Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CAC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17252083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="FYVjr2WM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17252083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753832AbeFTFSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:18:12 -0400
Received: from mail-eopbgr720066.outbound.protection.outlook.com ([40.107.72.66]:35767
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750968AbeFTFSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWnOaDosdQMK1ZfdLjHQbklSK4N/diML19qBlvBSp1A=;
 b=FYVjr2WMbSSxAFpJ3r2mAHobBD4cbLGQ1FVYLnSfflie9yzdy97I6opLjh8CUuInLpHNNH43ifl01DDfFp041j2SxkwSY/pYlc0Qgz0lkhAMDqZGuqDDcTNQPtt5YJ16L0mUfreN/WILCYDYxGUpaYS/WfixkwTtlM0NLm64zgo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 BYAPR05MB4584.namprd05.prod.outlook.com (2603:10b6:a02:f2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.16; Wed, 20 Jun 2018 05:17:55 +0000
Subject: Re: [PATCH v4 0/4] locking,drm: Fix ww mutex naming / algorithm
 inconsistency
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20180619082445.11062-1-thellstrom@vmware.com>
 <20180619094554.GM2458@hirez.programming.kicks-ass.net>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <f07c53d9-a22e-41c9-59a4-71ef6f7d96bb@vmware.com>
Date:   Wed, 20 Jun 2018 07:17:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180619094554.GM2458@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0502CA0014.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::24) To BYAPR05MB4584.namprd05.prod.outlook.com
 (2603:10b6:a02:f2::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f9a74c6-ba5d-4583-0a0c-08d5d66d3109
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4584;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4584;3:KTYU6V9H0EXb9IXNdIDhm3iegt7Iyeq8Y0AxaYpwUs6JV7y5x7oOuDdO17I9n6puT2QNn7a3PWLdarX24SfKygRy5Y1zsAJhQMgFiaPRdKAsaOe1kZ88ms4d4VXXsVBzZjJSP6XWAmNwnb3JU0jlGF74UMIkitmyNdCngf8OaUUEluvCicztyFozAKKb9qwTueVCHeCoJc0Wzf9jvWdPVwsMwXWBGtEb8N/ZP8SdsFtxY4U9jLYh45a98pI3V1oD;25:kHriaqWx+O8Pi6k7xtaX3mFDoBR9pDEVk+Wo30b2/QINCeburACEaxPcT09xgJ88izEsYmDL2udnwnAv6bz1IxcKhdb+ETuEcX9d2SZcRTWsScl3mI6G8KsZrtTIUMlknG0Xanq3Q3wCCoRVbOc9AAEAcGWOCOFnnotXkAVkEaYWrVc9mNOzj181cuz1lx7sgI+3oFKfs6pyVbwK1bZ0wi9kUfNERnfO/1+0VvqLVxLL53ZJaev9gwg7iCKqphhYqdWAy4YMMOScy3tJNCsx4mVHRlyBvXR3TLknfW4jKNIxnRzoyiZojqN/fDd5DRwhWJZWZUyWA3swws1W+WhO/Q==;31:Q4VNld5PuNNZw64FK8V9lOEWKshn18YazVPGFJtBEDuHvWKOb9FNY0ksYakf/spZVTHrWYLrf0gIFMIcj1wsolgitbvRce/XdB7td8NyfO+f5WLmPcyLJo98DvD7nIEXOPyW88NjQx2/ZoThP7dWkSQBQHAsj3kuyYvfih7Db9QdcsuvVCOoILwpuI9wO0zXMyPKfR5EAj1bIQtOdQV7vvhgKUyt107+1ixzr3BKSwM=
X-MS-TrafficTypeDiagnostic: BYAPR05MB4584:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4584;20:vsRtUa4MJHHhVyaUL88V+UArsmiiYKWjVTOje1E9EqOmoZ3Lilu80kbYIO8x4xwaJBSX4KBql0hTWDkR9Ul19SHgMhbVoQ+Di3xhZ+VnEJldHTLjbSprSMYrRf7M3BDSvGv/OmTXsp21dpukFuIUbjHuLhezCPedGne+yhqCgGVJYTNd8otXlIQm0YCsNYXrnO65YmkWvikyIx5E5eQ62jBcaoLZlwRUr552737YJn4w1OP10h5BZTLlDJbBCzhEmYt58uFwnJmINLyUfskGJVM3MnzWsvuy+T/evNYn4OPXFpAOOYzY1Y6AtFVM6ZFZ6Y0lxjFIK9DjPoYchnssl1toPN06SJ/uYEyx2e0YVPAh9TTMkuXyJqs/4771aP3qB7KEekSADbP05vyP43+no30ewVUFQ16V5n1VDBPToIOcvGjJjj8NSQ7X5Us5sy5B6nopkgC9qHSeSSWO9xeSZ8wR5hxbvre4mNToU/Nv9KHxJyK82KgVci7ikUXjF2vD;4:EswcmkLrZ+89ZOBsk6xaxIlIM/4zxemcnMsyE/iHJ9oOl2Tg4bmKoQYbO9/941Y8pjjD40CI+KZieHK+V5JHyDa3nzdyLhbcTLVtEEW7QHAVgx8uEoCOfCI7f1dNMOnbbuueti/qQ1zbYEWGCYOOUCBxdkH1Qp+MNENCZPr6IXpSSAUnXjv7YcuAD0/VUaPg6RKdeDWGZ+7n6dD1FqNG7COpTlec+N+8LsHduZEcTy91pdESDMyQd63Gu4/L5KSBYaxXwvnC7QDLu0Y8cykxYQ==
X-Microsoft-Antispam-PRVS: <BYAPR05MB4584A5911A83DD6CAEFA800CA1770@BYAPR05MB4584.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4584;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4584;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(376002)(346002)(39380400002)(396003)(366004)(189003)(199004)(53936002)(23676004)(36756003)(52146003)(47776003)(50466002)(31686004)(4326008)(81156014)(6116002)(81166006)(64126003)(6486002)(65806001)(76176011)(67846002)(478600001)(106356001)(2486003)(558084003)(6666003)(230700001)(229853002)(68736007)(8936002)(52116002)(105586002)(66066001)(65956001)(2616005)(386003)(305945005)(316002)(86362001)(31696002)(6512007)(6506007)(53546011)(58126008)(6246003)(7416002)(97736004)(7736002)(65826007)(5660300001)(11346002)(486006)(25786009)(54906003)(26005)(16526019)(2906002)(110136005)(446003)(8676002)(956004)(186003)(476003)(3846002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4584;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjA1TUI0NTg0OzIzOlpQdHJYTldwVmp1SmVrQTdKbGpRM1orMERP?=
 =?utf-8?B?ZEt4M0tuNGtSaWJ0TUR0aDAyQXdSVmhhL3ZVQlZ0VjlNNHZCWGtsaSswZGtB?=
 =?utf-8?B?SFZHcm1Kcm5HaWZadnUySnF6R1Q0cGsvZDUrRDRtNzVjcDh2OTkweEVRcURV?=
 =?utf-8?B?SUh2VkVFbWZHSjhtakRQM3dLT3lrSmI0TWdOd2M4dHA3Sy9SWTlVZ2lMcXNu?=
 =?utf-8?B?ODlNcUMvZGYwbTlYTGwyRmMxRVkwWTIyYUNCWFBGNWE4QmE0MnFRb3p3eGRp?=
 =?utf-8?B?VTRwcVg5bWFJWGxQYUhWb1FmT0xINmNPVU1heFJpM2U1Z3Z6dGtTV1FBcys2?=
 =?utf-8?B?eXVrcVJXeHg1UUdnR0JGRTY5UnVZcU5sa25jNXVhN1NrOWFjdGdDWXM0dkww?=
 =?utf-8?B?ZVRBam5Cb1dpQ0pOVlBOemEwdit0WkJxNlEyWEVzcm9lUDlXNnJhc1ErN29G?=
 =?utf-8?B?SC9ybGltOW53dTNXbkdlM0FJQnFDZGJmeDhIaDhtNkE1YVRTekRmODl5M3F2?=
 =?utf-8?B?amozUVhML3hyb1hqNU5PcDgxRDk5MkNZVllxc0VRZlBlUlJSNnkxUHFVYUlV?=
 =?utf-8?B?dGNYeGQvZWM5TWZsZDdmNTVzSWlFZm9XMTNjNHY2ZnZtRjFUalZieGlJTWV0?=
 =?utf-8?B?OTU0UndCMllKSmpVVDNYT2tCeng4aHVNdnhOQlhzeU5aclMzMUJvU2ZUek92?=
 =?utf-8?B?M2hQS3l5bWZQdldpS3NGMWRCSzlrcDFIaHhpbzdlZVpPUkhFbjZCWTcvWTBS?=
 =?utf-8?B?OVovRWZBNWRQMmg0N1ZxYy82NURjL1JPdzBnRlZmNG0xSFpHbEFwVktXdDdW?=
 =?utf-8?B?KzIwRnZNa3loMVRpelE0UnI3aUVxOHlNdDFTRHZPZkt3MHU5WDVmVm9mblNj?=
 =?utf-8?B?RnByd2RNZlVVaXAwaVIyYmt2RFVqeWZIVFNDcFNNQTM3NnBNTkdIWnQ4OStx?=
 =?utf-8?B?blhYUVJCZlh4YWhFVGoxNUpYN3VEVWE2dnRoMERicER0YmkrRUx1NjA2UVVi?=
 =?utf-8?B?S2ZtRzR1ZEN1b243WDB1d0JKOWVmRnA4UnZleWhrN2JyTVhHV1V6S0t5ZGVv?=
 =?utf-8?B?aEZnOUtFT2dBR2ROZzNTS1A0VlpnTlhlT0FmR2pseUFSVzk1aE1DSk9Nc3Zi?=
 =?utf-8?B?K2VUVkg1M2pQUnhaUkY0UENPTWdPcWZUWUpUUVZzK09lUmtOcUtTMjMreEtw?=
 =?utf-8?B?c0JSNkNaYjkzUkZDcXVHdSt3a2IxWC9VOW1NV3puTXpsdXpDSC84TXBFWHpW?=
 =?utf-8?B?aTloei9mY0RNMnV2bUN6NzVuUW1qT1h2ODgvaGZ0cHJ2MFI3WnRINi9nYTVm?=
 =?utf-8?B?azBiejVjMm5iTzhETmFQanJHa1laeE90NFRiR1NDNEdHMFkxSkRwUlVtTHhk?=
 =?utf-8?B?elpvRjhEbDAvemFzdlpnK1dSeFNCMVRYczF6dzRUbVlremRORkJjZGJCZWw1?=
 =?utf-8?B?VVJYVWZBb21GYjdlQktHWitjS1hTbkxhRDZESE5DamtGakFqdkVQTUJiV2hq?=
 =?utf-8?B?bzBEZjFSZktuVmJDN2hpSEhwVU9wUVd5NFhmMHhNT0NNQVErNEJZU29lQnFQ?=
 =?utf-8?B?c3crU1FEWlMybDNJaXpzYnJaNmRJejE0Rmhsb1ZyYkdMQWkxOWlhSHJMaWlu?=
 =?utf-8?B?dUkzNzhrS3BIWFVuRU5iT2RiNEVIUmdoQ1NkVjJJcGxUdmozZ2tCbVB4aGdp?=
 =?utf-8?B?MDhVWnQzVlRCRnpRUGpzbVcxalhXV2ZqbUtyanVvZFd4d3FHL0NKV1B3THgr?=
 =?utf-8?B?QTMwWCtsV1E2SnJhVmpEWjRMaWZKbUF5UFpHako1anJJZjgzYlhtM1ZxbHA5?=
 =?utf-8?B?TEpDVXUzYWNSZXZmbEVjRXlIV3h6SW1vYzZKUmFrcU00bmpUaW5jdk1Oa1Bo?=
 =?utf-8?B?RXZvR0hDNHFQMXJLMlRNbk13dFlTMUVTWmRtMnZQMGZLVklFNUdHWTZRWkRq?=
 =?utf-8?B?V1NuRjhMWXpFQkVJbTdOUjhjb2EySUdoa2czUHBpd0lZTXRDV0hUTkJ0cjVU?=
 =?utf-8?B?bUplRmhnb0ZrekNIZERMT05wM2FpTmRlbUd2R29nTXdHTlN1alp2RjIweEVI?=
 =?utf-8?Q?FnWmVovHDShDIT58Teoe0hoGy?=
X-Microsoft-Antispam-Message-Info: +82pR7zQKA5sw1PLQW4+tDdBem01PC7pTdGkTJNiUMN6p6Wv2VJEKlNBwr8cTbEiA6kmT9TlpuhAaGpwjA6N2zkUxpN0MvDEHad7y/XdGMAeVPL2wXfykKn7RQvynaeaQa9exfrObQ1/bb3OhK2taPzzo5O8ZWl0AY3b1Eg9shM673wartTTLeBuCf69bCltjDU5+xoVHU86Tmw27pSMj5jDECS4/pWu9/IfIyolVoaLbHLZ+Gy5NNW+BSKVxMfDTb/OSoNLPufcz0sF0yOIM5ApNQparU7nihpUPTipLesM6OR8gbxta8lCC1nWMmExfGPlOkYZua1MG+7EhrmuIQ==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4584;6:MURiM0K7q8icwnSrJaRPKBqJTPm3fvj1uDX2zBSQjLFkbevaKSSrDophI5gWeCsP8deVAt7uq8/gRNidt5GqAzpVIYs3Om3BJQ5aJppUn1HKtxnsRtqgL2nNUrSwZ/odMev1iOMFbrNYCI3J3KwwAjMPv9kmKk2eZBbDEi771QEu5xYsxQ9eEXDqiWgUW8pK1we8kqx6StCZEwUbYR8zFnQ/m+wqsNFXPEiGOgeR8ioCdSHjvUtvhBCcfQ3cmEBG+ISiBfYbXixe6+pmkMI4GQ4thtlI3vg3Cd10W5YPdiaZY4MjebFIVsv3p1gbgk/Y8fBVF812egyEmmt+la5ygT333XbuflZH6+3d3gzHyLul3Eyk4IWIRInNNTeDpOSxkfqW8ZoWd0QxFkP57QJYHyZxqh/b+2v2LwpPxgqy7kXKGgDp6CRZl7S5+fFuVOl1RSgtrw8BqXGwfeNP9WDdyw==;5:3f30dd6lJE/6rVgssR+um/SgH1BWKlX81Xgsc3Oj8HgN1E8xp/3t2L4VgiHhIlObH7C7jWWCVxWWvJt9u4qNo1pU/vIrcqF8FyeLXZ6zQKcRbD1UBVdjkhDg1387wUKADFMrGsh6jtSmpq15d6lbI345FYtJ5CP8S3BMlk7SnjU=;24:IYB0HJrY83Vkk05C28QnJHAziO7+/WA/mZ6RF66JodsA1o2FmrcyJ9pl6+2+o4CNDbRRDQ4ehNGNajx4zlJaKbWLtL1WvP/qbkSUdwtUGxs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4584;7:NomIG6XQEMl+g8M+OVp7ejWSGgi6EgVP2W4+uNS/0FYQuaKtG+FPSd7boeCgCcEIT1GJe2vMVBbWuPdseF/TaB7L/lZi9VbMAYzPFfZ5iqYrpr7XNLTYeSldDwQiSfsO0NXDs2JwWQCVJIq61B4C57VvdSsWgX91fUwqF1S2/RfVG9NLVofcVwRzmVg/Zh4vQuqvbwxzdAmjABWsAMqxvUxCToznfy/RbloYG/dGKAQ7wdDk7nyY8i3QQnho2w9g;20:jWGXHhVE+DI7MfcRVblccvOno7trTt+n/gjOW3XuSwVFAD57kTBDbkT/alR1qOLAEbzLsY4wW7V8YzjpgKwvghEBOTkq1+kbUcJy3rHOm2lRRUHrUqQM3gdVaod780R3JZGVSdjGJjAatCR+m3Jr4d3h5LYQ4TNk+vzGXUxI+2U=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 05:17:55.8705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9a74c6-ba5d-4583-0a0c-08d5d66d3109
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 11:45 AM, Peter Zijlstra wrote:
> I suspect you want this through the DRM tree? Ingo are you OK with that?


Yes, I can ask Dave to pull this. Ingo?

Thanks,

Thomas


