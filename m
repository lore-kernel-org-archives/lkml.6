Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCF4C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3562089D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XCdPoGC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3562089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936941AbeF2Q06 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:26:58 -0400
Received: from mail-he1eur01hn0205.outbound.protection.outlook.com ([104.47.0.205]:60870
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933545AbeF2Q04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8Gwbj5Vs8NwuhXQ1gqKdGOhrdcmcH6fHNF4tfR9dVI=;
 b=XCdPoGC7qGfJS1PrZMAK83RjTcEkOjYVu0BpgaqaNdptRgehTv2TPdy3rdldtVzzUUVoTPj8iT9c0pyDRRqE/BtiA8X9bX2lf7Wo6c4x2t+LS5Hy6qim66qiLSJ5tWQ3jLjxCX5kRul6bYbO9YGKgqIHhArBRhPEZN8wy81AUyI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 DB6PR0801MB1973.eurprd08.prod.outlook.com (2603:10a6:4:75::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.23; Fri, 29 Jun 2018 16:26:40 +0000
Date:   Fri, 29 Jun 2018 19:26:36 +0300
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
Message-ID: <20180629162636.GG15656@rkaganb.sw.ru>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7rdd3ec.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0202CA0005.eurprd02.prod.outlook.com
 (2603:10a6:803:14::18) To DB6PR0801MB1973.eurprd08.prod.outlook.com
 (2603:10a6:4:75::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fad3b74-db9d-40f8-6307-08d5dddd1933
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1973;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1973;3:GpOaBnSTLpbFusPwu0hK/pBroD5sQejTI7VCuhLroVdGp8P4XzNjuup8CitqzDzQzkrRJhXX9IbsVko+s5M8Fjp/GY7gyNr6i5sDIM+ggSdSHTGpgFlXkNVqr9FKktPcdzep9vV3SwonI9zxSmOU5Tf7W2vGQPc37YR26F/Ss/33FZ6RHCMLBGTMiegITjtvjRCJMh+ja58aQAnSYfzBv49dL2gcFr9bDOTYo2hTigmcQo+knwKzYr0LlRUeL+D0;25:CDZhWvEp/2xAp1jTpqXl+c0cnR3/nesykMyzEwV+KIaq59RDOgdtQv/lVvIDPwtFzJtJRBu4uHL+4dYxOSGSHlZCVBJG+hHe319MBuEzkwO5sE3kLBk3CRphgcesVwBLM9XGyKMvGmY8nPfEC52vFJb2X3giseX94/TGl5nyrvsWwegsnLz7VQA3ULYR02wsPEJW9sFz46d2j7YrpJva7N7v60zdQu6if+EwwUoa13PPRzulDJRfiyim14uD/HkUdPYBcSKRloEfVtUrq4m1thHRebYYYXa6H0XGof+FYIn0t5kXPulPCmvSWrTdPF8D6XWYRRIOPIXRORIMemqJyA==;31:GZa2abv0gsolI7jokDlkeyAaINH1fhfaFWkeycA65JgiilKZnG5u1APBcdhC60dLmYKXfwPUckpI/oMVvT3eTZLbmPoCymyhMBrAUTRJjOAsCIMdYKU972Giq74tWXaXD1sOaKfIfE4dm0emdCocssCQNnzIRpEztWEdy6Q/kI7KnRgygQxuE6IgmmRTGATpZ9I+9Ci2P8w/C3ErT/Cu5pbmKE6Mc9QtbyN3YsreDf8=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1973:|DB6PR0801MB1973:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1973;20:mLRvpYDClG8ua+urRcAG9XlYmt7IWA9RrkDrByzvjGUcSvnLnPRLQJBrmC25+5zuVZu0j4kuFE/OvQoywH6FLA69RI94kRc0MZ/MMX+EwFvnNNORlurZUv9Gyn8mHFhEuydP8NavlyNJ3pZtws27ivFaPqhaSUCrwVKfulk0CFWFhzVRcTb2smvm6ODuLXM0Yx8s7WvzNJT9o5GDUEhj5sQM+2uHGT8iuD6NV7sKPzb3FsWD1L/t+WRhWoZ1d/+UII8Jg3dK3S90kSNgFCPKesSxzq9NhtCx3wMg0DorloZHdbQF5IhP+t+GNDVlf+2pet4gQoFdfcfnj9Ml8m8m71tekufMl2HE8TW6Zv1/0BqDEpQpI7qTP401z00F18KcAOsM+m5Sl8JGnoRZsP2+7ELpA5OnKp3Tn3Xt3YQcqUOmHxwQ1RbCI/m2UiZ64UTnLPL9kvP/wfyz7gJf+iKBB562oxNozlPS+qW8BVaryf5LoVp2mZ1UJmi1mQ+YcjSr;4:YFrVmWyofXmCU+jLpubCCZSLfDo+fNmaGKbE3rEDvjJoSNiDAwDy4RPkTP6uhATbFOeOLUb0v+B6tg0INnrZskeTRe4WtX4B/0qhiuVH2ZGmcWCKNxwqHsrOXWaM3AcUIQqxd4gqqsRPT1P+kCC9Hhbaetn9/rbnCZQa4hZBo18LPInmfF2pegvOa9bD4KNtYg3/tKCUWlSVccZKBV8SAlkyPbM5ZuLJBtSnfiRJ/AKv5b+74t7p3MIZSwo1uGSmH9ZkizF+oWiAvac++FQYVQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1973C70E9AC768D60DA797E1C94E0@DB6PR0801MB1973.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1973;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1973;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(136003)(39850400004)(346002)(376002)(366004)(396003)(199004)(189003)(23726003)(52116002)(47776003)(476003)(8676002)(36756003)(7416002)(3846002)(81156014)(81166006)(486006)(6246003)(14444005)(4326008)(1076002)(39060400002)(97736004)(478600001)(68736007)(25786009)(11346002)(53936002)(86362001)(6116002)(66066001)(7696005)(6506007)(6916009)(6666003)(186003)(105586002)(69596002)(54906003)(386003)(106356001)(446003)(229853002)(956004)(7736002)(33656002)(26005)(5660300001)(55016002)(50466002)(76176011)(16526019)(8936002)(305945005)(9686003)(93886005)(316002)(53416004)(58126008)(2906002)(16586007)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:DB6PR0801MB1973;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1973;23:Ys69M3zRZ7W0EtuVh91kMN/j19b5Zhzcc/hN8yS?=
 =?us-ascii?Q?SbwrM6b0p7kr9Aj8PaBSI9AxAarhqBZwQT//rNu5H+bM6mN1i8GT5iwC1ZyE?=
 =?us-ascii?Q?l8JpbZZpeddrwEKsdN45juOiaHvNNcRHYcOdZUka2kLw4+AMrmIIAjYQqpkR?=
 =?us-ascii?Q?wcuQZJ/AGk1RbSaXYYX3OsUbrN61/CHDOFixtoR7gEFjSN6Vnbv3PbmyLExR?=
 =?us-ascii?Q?y0FzSe/1Fjm+VUV6MGXsBBIhTYI5Fh6IHMCR8/yAEPe5LC5YjWlt2ozVdQSd?=
 =?us-ascii?Q?wFHrGVba1zMFICFyCO53a51YYE8097D0UAmFqx1Tb5RDZuJ0mNzx1G0xCIcK?=
 =?us-ascii?Q?GBA/WwToyTVbvORk826GoozBYiCxaf1tb4bntW00AhQ0zvo4VkPJWX6I7Vha?=
 =?us-ascii?Q?IW1WPeIh32llpi381I76feElceVB53HAfrq7guqxIO8VnIR5uCSx1MuhvtYe?=
 =?us-ascii?Q?kb776ucx/XLLiQZidqnXSaQeCBkC437CuFFwZsmPD5ih34UuYCmjG0dtJ6m/?=
 =?us-ascii?Q?YnDkFWKNOsg4GbXrKByp46g8mLynkwt8QbEWt57B5UeNnb95K3h1908yBCg1?=
 =?us-ascii?Q?J5b8bbza125QAuJICG4lgBftycvTH7V2iqcWUn9aQ1D8wZBJshpZXZHNuV2/?=
 =?us-ascii?Q?bY+tjjBaAYM9/rXkoS1t7EtrvF2lvw1UWq0gqOMBRGxBrFSAgYiHsElxJ+kW?=
 =?us-ascii?Q?MGl2r8hHFQqs0CxjUgoqrWKpKq/qCHPx7OC1BtOjOSzSyw3Jb1LrdqBNzFRd?=
 =?us-ascii?Q?CxwDo3+rkpM0JAkmhBOBzp7nRXoZG6flGCC+mj0LWkDZL8+dt8O0jP9rLlDF?=
 =?us-ascii?Q?FL2WcYSA4S4Vc5d/h5cbaJwRCcY+sHpgIn78ocNVegYHQEyuyimXDYe4s2cd?=
 =?us-ascii?Q?QuHjoe9giC71JnL1M7fXQk8Q+IIL27OfY5Ako7HwreU58yCES5u/0m4DLcL3?=
 =?us-ascii?Q?RvWbuJVaS4Doy0cOZMF15Ha/PKA2BhBsT6Bd2eqnGbLjXhhUX/D4JgYot0hM?=
 =?us-ascii?Q?iGEmLeMUyZGveWxpVzxoC21Cy1uCgS5OnklMw494liEcOyG7x2rhrHWzaQP6?=
 =?us-ascii?Q?qlrgb4ON7Naah/lPNwBjky4AsUZhidZynj8A5oBFGZFNYREd8Pl/309O4TXl?=
 =?us-ascii?Q?WvMiykKjn2f0epA6ELDPjIM+rgk+fPYfs/VERmg3gJc6MdYNvqX4HeVWMiJq?=
 =?us-ascii?Q?SURkB9aeoSe3A+XuX9HaKaqByrCTvBLLGskid4yc89tp8YNYJ5Kkr01eo/yo?=
 =?us-ascii?Q?Z31MXGUpYWxtAeLAuZkOMPu5FPPzCRNP+pqmVwNAYa3zAVgCeFK1gFI4zZHD?=
 =?us-ascii?Q?CnomENNf+Ejs6klhkxcfAF0oVV5w8UnmFXIqxvMcO3VcJQQCIjY88ZOdRiKW?=
 =?us-ascii?Q?72b1cvoqICS6wwpN32xaxB0J99PVKk986q9sPYA1sHeYgijRYLdy9q3/h+tQ?=
 =?us-ascii?Q?a+M5g1P++4wUnneS+4+Q0BsXJW91d2Xs=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1973;23:Dk0n0BBz+VEN7LvAIR0vU3jYKEfM/A8uO3ssumku2ClYUMG/bW/hSWJ5QCD8KfSqJvuH0/WxZlTpyOqjTLKYWr0MerDzuBj9aR5Ldg2GL4m/KuOPbrKkGzeX38RfThIi+Vh5aV5gkBbYJK3NVzmg8A==;6:/2KGqGytp2U/5ateEknxYdCTIrgnNjYeX/mLSGC9wgw2NrEG9R14vbOkLP3md6wv79aL2Rp7jEJOEUVhJD49qfG27r8xqEk8Fwv0V7md9RS5oteXx0zhC+fBGA47mDmTVEQ/I8b9/GZQqgRAgEB24XkNJtnycmGLBRzb7r+xxZV0y9IOQ6+wEhpKNGuWrtCeEZS7d7WSjY5kQJpwkiH7xJsXj/33+hxMAERRIdyvXEzsBGaOTSAo+1uQT52l1SjfT30EafzbczQaCCrYjMlRmHOzNL5TCSqGU5nkX0FD7sBB04HA8vyIatnaKhPVsN+3zkIBJhca5VoVhev7ZWTKVN+69OxCbYXQNw0gw4V2wG4kipU6A8Q/IM/gv8Ro5Au+heR8fIMYc1vr21I8tOM4w9X0XVMpDTOhtoegHTu2peKSTXYhylfMlX5qsHAMj0Kyi2yI/gnj9si69/q+EhqyZh+M8PHEHfKOux96d+QUuVmSGE06yIIoad0t3l+r0Vpk;5:rwMwAgchhdNC9sRxHnw8Te525dCrITvDh//7hfWa2i+Bpife3FmEPGZcY0J4UA0QjipOI7Y4mxAG5I1T0WQydcnV3+MSdsu7/UFMtvBGpgL91IcMIhg453/TaTPvl77fY3RZjjvHaAbqCEkMSyH77A/Vb6crBB4kk4mkw5W5GfE=
X-Microsoft-Antispam-Message-Info: k2ezHPmkc2SioSDh9PT510GkkUuEAtxVZVA57t3e2kYUa8HV+iiqpcqAI6PPWhfx4H1DpHgTviGY98FvLhUqMQBQXn1rI9y6tpS5BMakzEkCd6jikF4PeRM8DZB+yLw8OoO8D2EqgfU4YyBjaP+oFGE4P+o3yVfM+PsjQx1rTGoEA/D7dHd4EcWkpsjcCpbpDrUVeaTGBLT6I90w/rYIkOlKcw6HUyyhHjX986OEUMEczdb/J9b2+cRNiH/dOGw1m6AQRm6a3ASpBWkKwxkVH+Zr8o09uSCwcUvj7s/quHu0kF5z6ijeaUdW1FQWcWu97aMj+qprj8G0QfsmOQW1hR50m5cnEduMOAbYRPIcjO5DB2Ysj8VQ8fl20Ryv0GJ8gBA2EYSs6UrODQORYi43nZ+an8eGvQB8A4LRxnuyG6ncaMxw4HwKHW2G+aFB1ShS37gT6mqdxDmPetHS5zNtsvt4dTGYFBpiwf0EecpXhbcV5onqq4OB4YcSi5QkJgmip52FarIAMxIVscZ/sGmakrl54I5qK7qWhO1JqLMZ8C+pQL5I5qwPzAlViWkuNWLOdfDQghIjVLWQ14n4bYmD5g==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1973;7:mCX89CnBJocOoJt/dmhw7mURNDffVC0uxTZVuCpbJy1pR2A6nHwtPUyLzwEdFWq7bXzbGdu3J5ByrbWu3ev/oI8OZ9pH9gU0UrXD6NMRWiMQGS7bZR9KQGs3Wd+wl19EUi2F8fF5g08TE5HR/uS2IhGJx0RT/6BTC6JybJFE6Ah+f80F0jGL/2Ebwswtl9QJujXFcd/l2PinQtCCodt9nqfcd7+fvUveKREKIunfo8f7e9j8xMQ4oPnY3vE0jKfE;20:6NxhSQ5FB7c2TPyIv7TETbUMOguxjP/XQ0+SWAbu17wi/uGmj3kM5cjB2sHowZRVA+LyJnqKKT38XhA3rtVk3TNIm1BVNBanM70jrBtyfptRBa/cPK6BK6ZI3+mWRPqEkly07lu2KViHKiwa/IEi4uKXX14odExezYwUAIQnyds=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 16:26:40.7869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fad3b74-db9d-40f8-6307-08d5dddd1933
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1973
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 05:21:47PM +0200, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> 
> > On Fri, Jun 29, 2018 at 04:14:53PM +0200, Vitaly Kuznetsov wrote:
> >> VP_INDEX almost always matches VCPU id and get_vcpu_by_vpidx() is fast,
> >> use it instead of traversing full vCPU list every time.
> >> 
> >> To support the change switch kvm_make_vcpus_request_mask() to checking
> >> vcpu_id instead of vcpu index,
> >
> > I'm afraid you can't do this: vcpu_id (== apic id) can be sparse, i.e.
> > it's not very well suited for bitmaps and can exceed the max number of
> > vcpus.
> 
> True. The bitmap should be of KVM_MAX_VCPU_ID size, not
> KVM_MAX_VCPUS.
> 
> Unfortunately there's no convenient way to get VCPU idx from VCPU
> id, kvm_vcpu_get_idx() just walks the whole list :-( I see two possible
> options:
> 1) Add vcpu_idx fields to struct kvm_vcpu
> 2) Keep the change expecting masks of KVM_MAX_VCPU_ID in
> kvm_make_vcpus_request_mask(). KVM_MAX_VCPU_ID is currently 1023 so our
> bitmaps will be 16 longs long. Not sure if it's too much.

3) rework get_vcpu_by_vpidx into get_vcpu_idx_by_vpidx followed by
get_cpu, and use the former for your purposes
4) duplicate get_vcpu_by_vpidx logic in get_vcpu_idx_by_vpidx

Roman.

P.S. I'm starting to wonder how safe this get_vcpu_* thing is WRT vcpu
removal, but that's a different story anyway.
