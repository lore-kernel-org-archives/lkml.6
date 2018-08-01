Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B52C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918F320840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gfvu8iD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918F320840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388996AbeHAKsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:48:12 -0400
Received: from mail-eopbgr20109.outbound.protection.outlook.com ([40.107.2.109]:23244
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388689AbeHAKsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/YT0Argz+VKm0ZzpyHcgTk855R+YuikgSgu9YuFAxc=;
 b=gfvu8iD4JqyVA9Cp9FZr+7e1hyJWAyvpRq66LeojA7bVEt1zl6v1l5/cK8XOTxvOG/cWguoKbt6UJlWbRwAyHhcC/wEFDsRh715cb3qHa8tVTxH6YEdVs4O3AMFrk21WixpHchzSM/KfUySpArN+3g4KmENujD6DD0pHgFccWNw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM6PR08MB3256.eurprd08.prod.outlook.com (2603:10a6:209:47::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.20; Wed, 1 Aug 2018 09:03:19 +0000
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org,
        Network Development <netdev@vger.kernel.org>,
        gerrit@erg.abdn.ac.uk, dccp@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <30ee6c72-dc90-275a-8e23-54221f393cb0@virtuozzo.com>
Date:   Wed, 1 Aug 2018 12:03:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0501CA0045.eurprd05.prod.outlook.com
 (2603:10a6:800:60::31) To AM6PR08MB3256.eurprd08.prod.outlook.com
 (2603:10a6:209:47::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89e73043-1f89-4249-241d-08d5f78da1b9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3256;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;3:TOmA5IbUbRMpsUPSmFAqd7o4OZJiXfKJpS8noosqHzzgUtCaguhmxbgXaSR/GlP663IvBLgX16/UQV0tkDfObZ9YEI4yR0lcCaSY/jL208+RbWZylhUEQRZdqtBsDoMAoTeu/3T1yqc2u618Cjy8IdQ2Vm5R5QkVHgJ89YctWDL4M/uEGvFtK9r4iWbmSd9wD0ViVyF9on5ogB5UuMVLyp+yoE27V+IXTRclbLkvv0ocYKSPyMPNgd6zqgRS9MbV;25:rW2GhM/qnOMoPGIx1FA+SaNciY51J/POumJBJZlOyeN2dw1W2CelA6qA3jj8eZp8qs/QPLdTAsjwL88AG+OlP4jPv26dYisxXqyli55LlmR9OrUH8efgHcJVRqTzh2i/O1hwvtKeKhTN03jE67kvandVMRy0IfsOB+Ix8aqrJ2zaylb5zyczoMeYAozc47TSjXW92yWfCmN4xW1F5d+Mdtd8RaNU3kHX8HEMoCl+dp9I4Skpnol/tgL/HBYWQelHyxCF6jusdH0rGM4MhaCUQ4L9t3/3cS7M9CsiIfGX2d4BZmJZ2Oo3ywn/a9sGijqXBFm9SNAjvR2FUlDUMV0//Q==;31:VykPdpnDkWY3dWKxvngqahLUz5ic9qltKnJiIfXQoojshVLX+yiZPEWiQGvl8DdZIDkyI5amJTrbYGESrfPb9GntcqfhnxQPGbxtWuLwD/cBgGX6wpG2P9dcblpA570YFZZICUROHRykPKdPMWd8S+q0b3iCRLWr0lbs9dVvyRVO7PXsiF+Uf+WVeIjxgBvqpd0wO0ocOE5MbSJqc7ifO+B+/7v0l6GSeiC+tDe5CW4=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3256:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;20:iEtK/DV9DbI9/H3MlxoFHYmDk2/XILvQu28a2FnugkAbApu8tfSq6eiYFNGw6ToAX8v42oH1rpkrlc/8CwhZs1gy0uiheHqPucpTYM1wsNNP+EkGOi8rN3MyQNUq0nNelW6diEag0GIFO78bmH+Wa2XuYE7ngL0/6bJWUdsG3Sl/zMNQ+d/ATZNeTWaPrrsnlNITYg9GwuysZoBFZSyoC449FjWcRd1kt7WYMjp4lZtLUOSJnDyyf24P1sKlTIAqYcUhLhXOGvGKlJRTe/fiuLKc8iatdchFpJ0AL2rlWdHuSI8hLgccjTuVyxodhr8HBqeQ/Uj7kn/zcixHLFXILzi38K2VHG2R94jRNtDiikkx0AyLkwPLrKiTbZ7m7VbLUm3KCcOz2E/eLWSudHGgBqD5Ef2FwDYEnD6H+D1Ns8LmFSkBXEWWEv1by6b1LRO7URckvBspLr4h8k4s3I93Rimg1bahEN3KbZQ2OKycx8jpr/VRUejoKHJlPumF5vpf;4:RG0mp6q6oSshfmCM/H5qsIOTNQLOUpMnz1jzS8ZtVNHwmj5yiIaDD3Wcl+4y3d8Wk1VGKx9B8/kvzURLiPhf+HhGoHF+7pg0iudXKqMy9zaN3R/5qkawAmxgAhUd6aEns6/l5Sr3Kt8fsJaLZ2RBg0rTPmhiYaXj4DwRpVHc82+J8wPv3PRUdlG9CO70Vh7ubZhmpViVjGX/Da3Cvb7uW1I1/BzrKNw/xF2NRduUlxmTEUA7KQHoTAydc7nhdtxDnjVWC7PhgmD5zc2H8NmHww==
X-Microsoft-Antispam-PRVS: <AM6PR08MB325668C2D41B339426D3A7F9B02D0@AM6PR08MB3256.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3256;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3256;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(64126003)(105586002)(68736007)(106356001)(14444005)(11346002)(446003)(229853002)(2906002)(93886005)(31696002)(31686004)(956004)(2616005)(476003)(486006)(86362001)(4326008)(97736004)(25786009)(53936002)(8936002)(5660300001)(76176011)(65806001)(7416002)(7406005)(52116002)(81156014)(81166006)(23676004)(8676002)(65826007)(2486003)(52146003)(6116002)(3846002)(36756003)(6486002)(316002)(66066001)(230700001)(53546011)(386003)(47776003)(16526019)(186003)(65956001)(110136005)(58126008)(50466002)(6246003)(478600001)(26005)(77096007)(16576012)(305945005)(54906003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3256;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU2OzIzOldUUTQyOTB4c05qazd5cTBzZEVLYXBpZGQ1?=
 =?utf-8?B?Ykc4WG95OWR3Z2JWOXhiR0xmcmZ4Q2lub1JlN2tDY2o0S0kxSllRMTRlNGkx?=
 =?utf-8?B?OVJYanBFSHdGTS9TMUNWcFBodUt2Wkg0Um9sVFV5aXpCdXdWMlpxWkU3TU40?=
 =?utf-8?B?N283VDVZRUd2RTA0NlM1d1ZHNllsVTkyTndvengwSHBiaVkvN0xvMUUrVStX?=
 =?utf-8?B?d0NXK21RaFBBOTlPaXJnUnZ0Wmtsdm1mZVcxTlc4YmlVNzk0Yll3ejdLOGd4?=
 =?utf-8?B?U0dTdXBzV3Rwa3NuV2k2aU05akF5YTl3VEdRcVBwWDhYK1BmM3lHc3FUSThp?=
 =?utf-8?B?c3NYNVpkeFkvd01BbzAyT3RhOS8xM25nbnFmV1Zlc3JkQlNiN2QxK216Tkkr?=
 =?utf-8?B?dzhhUnVGUGYvM3YyOWg3K1hnV2drN1lpWGlNL1RwQ3FwVGE5SlJXUnBmL1h0?=
 =?utf-8?B?Vmd4UjZpZjREYjBST0hYcUx4dngzQVFONEpCT3AvTE1XVGhENXp2RkVzcGtz?=
 =?utf-8?B?TVB0czZKbTFzS0VFckxNU0JiRnFneEs5Zmk2N1JnZmJtK3FUU3VBUGVsQ2tk?=
 =?utf-8?B?Z2tTLzVOdW9sMTh1UmZIdlJDSVlpeW1nVUNVbkh2VnYxcklTczlYb0RmUTE4?=
 =?utf-8?B?V3BmSWtBaGl1SC8zU0R4dzNpMjYydnhKZi9kekU3N216L2tQeUk4djZhQ0lL?=
 =?utf-8?B?VGFzMHo4alFpamExeTM0azA0WEVwUzhHMldiM2puejRKOW9QOUx3WXN3K0Fy?=
 =?utf-8?B?cU5BNCs5TlQweVBRVjJ4VDhXbGE4SWt2MkNCVFRjaERaRW8vTVdiYlE1Uko0?=
 =?utf-8?B?YWRUMGZWYkR0RHJDTmFaWHRyNWNRVjNOcEdQNHZCVFJUa3d1QzhYay94dzBW?=
 =?utf-8?B?b0ZsamEyd0dyb2xVeklDa1FDT0Z5SEc5TU9LVytvcmQ1TVVudnZZaVpOYkda?=
 =?utf-8?B?M3Y3UzRHRUErN2UwOTJVWWJYbG50VVBuNkMyZ1FlSGV3eUtuYlNHV3V3K2tC?=
 =?utf-8?B?WXN5NlpyaUtUb3JndmpEbmhwNkVHNU8wdit6dS9YaXF0Sk9CZnk5aE5GeVo1?=
 =?utf-8?B?NHdJVEFTejJ2cW9LMDhxaVhiSWsxMVNEMW1peVBheTRjSHRwR3RJSzhhMy91?=
 =?utf-8?B?TmhYbGx4cmRSN1BSd0ZLZlUwWWVNMTRETzExQ3gwSnYvTVNtcHRPdk5wUXNX?=
 =?utf-8?B?V0h3UmV0R3A0bTB3ZnE2V25KZUk1RzRnVUtjcmg4Ukp1SVc4OWhwbklWRWhF?=
 =?utf-8?B?Q3dpNmxQcGxMZ2pranNOY3lNbU9tajFDaTUyRnpTOWpOZElSbEFqTWJnVlBT?=
 =?utf-8?B?MlFZSWFIczArTHZsS3NNdlpTTTNvLzI2cS8reUlLZHJtcGtzeWNPdFlWVjRQ?=
 =?utf-8?B?aDZCT1RTeWFub0Z0cnZ2ZDgzbm9tYXpsbGdrWHZldXZMSDFIMHRhL1d2ekdW?=
 =?utf-8?B?dDdhUk1tYlV6NTRsSytrSHRHczJ6U0FQSTFpKzRERU5hNFd0RFlJeEpCM3Jp?=
 =?utf-8?B?TlNITktoZVhULzZEaVFNWjVGUkk4cUQ2eERHNDNpQW03Vzh2cVlPQkhaKzBT?=
 =?utf-8?B?SUdaNTZiaG45b1dZeWVua1dwcHltQ0lTdVRjS0FzdERMdndLbGNPQXpka2Vo?=
 =?utf-8?B?cFdBa2xOem0vTHFVcnBNRnNwdmpUTHZzZ3N6dTBpMlhSSHp1YVEzYUJ0NTRL?=
 =?utf-8?B?blZVMGd5c0NqSEVFY2ZCWmJ5dzhueHdXbmVaSkNBVlpXdDhCOEw2TmJEcjJj?=
 =?utf-8?B?QklRbkM5MUV1RnErTERIczZVaGlFMFY1OWRxZmdNWkw0Y2VGci8wNnUvTkxj?=
 =?utf-8?B?UHZvc2ZZQlJSQ2paS2IxZnhIeVByU2dhSk8rMS9Ga2dvaG9xMXp3UXh0T1kx?=
 =?utf-8?B?QTdrQUFML3A4WnoreEw3YWhSVStSQkZNbTRvTlQ2RWs1VStOVU1nMzdyOFNz?=
 =?utf-8?B?aXVla0ZTbFpBK0tkVkg3elRoNEFnUGZEcjhDamo4K0pLVTFod05kWmExbGZn?=
 =?utf-8?B?OEZTbmVua0U1bVFHYmovQ0J4N3NPU0hkTjZPQT09?=
X-Microsoft-Antispam-Message-Info: iFvMIOzOLloag8S/0vq+q4PT/fJzJwHEK9YtWbYaYT4NROlX0BwoDFXmIv0JyhtZ8DtcPNAvskMvrOjqnkVoY1UWolnVGgO6MirKy4oK6T0bf+EPuCXc1b8HyK/LgL/W6tR0EafnPNi3hbWD5uiQuPMpp6cJTerww+ZdZ6ETX3kmlFD0KFmzjF5CC3XOD7M5PJA3vW4zsLdA2xj5mY2G0X53mloIBJM3bKu4FF9vDi+POLw3ki8VSkAAfXHpI2WAtFGHYH60AEHEdk3+9oEDMiACxLXrHZ8b8ZCrJXhj3izpzOw4WHC85CWVVFajabaVWSbF/LHRnqtLA4qK34z6+EhCi3P9SLPrOwPO/9U2pWQ=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;6:ORTvjTH0cwWCDq8jsF7PrMr/EHymgb/CRxJMT7x7iDzUm/0Q9Qf5sdhM07WXBUhOQR5TPyuw8MakueyboCXXchq7BloDOuYz8dIQR0xionDb/cfaHF3xO0uK+Jmn+bBHeWWDZJG0zi0h5p8RiP5o8RMRAtMijjFnyHCwdvR/rWXJPVR3WQQtyO3nG1Odxrb5saDOJ4/kBgaAwbDu3rKt7ZbSYX9oyIWBPJzMU2wIISxJMzEL/SyGI5lwE8bvHTyVzW1h7NuDDXWcE2EWRkKgbWMRaoL0GFT452XeSba1rxg0TcsIP55qqHb750+ZMehoROpYwWYJ2VLLXs5OMQ+0sKSx3cvPAGIOxnFL3RZXRlCIdmSd6WmrYfCLQBVEUzrkSrggIuhyalMzuEb8poH5vcM3zw/Xdlx3tC5Z/hUkraPwws9veGHutcxezV8hHcvLifCyIGQ293qZIlca/rTxRQ==;5:Ao12s1Zy4emLH4Talt0V+0GLCFFWNsKlskq2VLrhZNOKmaLxFOHOWh/11LPkM1b8IofeiX3ubUNKBAMgk2mgIV5G0wMQNp6XCs+pAYJzGIxg5dNWAM5DmCsO82ELUK/kie7fGAwza1I9LX8qWtRmw4yQnE4+lapydIAJSl59kIE=;7:SdYhnMglhaFVX9K0+Oe0omb9cY4JieHP02o7XmuCjGZXrAjz0ZkQWvqZ+cWQpPLMceemsZPjKttgB+pIzk8PWPXh26fEbB6oY3Ia0hz86pRcuSrSTOB/qDtHvEO7aPn50XmlL2825d+gHVE4ikbxFpvkddmxZQSNNjdc54Nl+lpwvkhTkw0NZaUyra3t3xJMyMN5GBJDu5tHsYmbf7s6nQ8aDfJwrwOeplv01peHAnVp7R5zqNhatj+M/HncqbW0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;20:URhqTSQ34AWjipgVH0GZa2K15OLeqCfePn+2scygb8LJklFdwXjURb3c56y8orPlYiCt3C6u3s+NGl+POHacJVyAYc5wK0mdaW+TxvNEHeG4WMU6BD0Nelm/DoOEMnNARw80fH8Tq6IQ65BzYzTuhVdzDM1zQwkSfJL19tXV6Ig=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 09:03:19.1298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e73043-1f89-4249-241d-08d5f78da1b9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/31/2018 09:51 PM, Linus Torvalds wrote:
> On Tue, Jul 31, 2018 at 10:49 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> So the re-use might initialize the fields lazily, not necessarily using a ctor.
> 
> In particular, the pattern that nf_conntrack uses looks like it is safe.
> 
> If you have a well-defined refcount, and use "atomic_inc_not_zero()"
> to guard the speculative RCU access section, and use
> "atomic_dec_and_test()" in the freeing section, then you should be
> safe wrt new allocations.
> 
> If you have a completely new allocation that has "random stale
> content", you know that it cannot be on the RCU list, so there is no
> speculative access that can ever see that random content.
> 
> So the only case you need to worry about is a re-use allocation, and
> you know that the refcount will start out as zero even if you don't
> have a constructor.
> 
> So you can think of the refcount itself as always having a zero
> constructor, *BUT* you need to be careful with ordering.
> 
> In particular, whoever does the allocation needs to then set the
> refcount to a non-zero value *after* it has initialized all the other
> fields. And in particular, it needs to make sure that it uses the
> proper memory ordering to do so.
> 
> And in this case, we have
> 
>   static struct nf_conn *
>   __nf_conntrack_alloc(struct net *net,
>   {
>         ...
>         atomic_set(&ct->ct_general.use, 0);
> 
> which is a no-op for the re-use case (whether racing or not, since any
> "inc_not_zero" users won't touch it), but initializes it to zero for
> the "completely new object" case.
> 
> And then, the thing that actually exposes it to the speculative walkers does:
> 
>   int
>   nf_conntrack_hash_check_insert(struct nf_conn *ct)
>   {
>         ...
>         smp_wmb();
>         /* The caller holds a reference to this object */
>         atomic_set(&ct->ct_general.use, 2);
> 
> which means that it stays as zero until everything is actually set up,
> and then the optimistic walker can use the other fields (including
> spinlocks etc) to verify that it's actually the right thing. The
> smp_wmb() means that the previous initialization really will be
> visible before the object is visible.
> 
> Side note: on some architectures it might help to make that "smp_wmb
> -> atomic_set()" sequence be am "smp_store_release()" instead. Doesn't
> matter on x86, but might matter on arm64.
> 
> NOTE! One thing to be very worried about is that re-initializing
> whatever RCU lists means that now the RCU walker may be walking on the
> wrong list so the walker may do the right thing for this particular
> entry, but it may miss walking *other* entries. So then you can get
> spurious lookup failures, because the RCU walker never walked all the
> way to the end of the right list. That ends up being a much more
> subtle bug.
> 
> But the nf_conntrack case seems to get that right too, see the restart
> in ____nf_conntrack_find().
> 
> So I don't see anything wrong in nf_conntrack.
> 
> But yes, using SLAB_TYPESAFE_BY_RCU is very very subtle. But most of
> the subtleties have nothing to do with having a constructor, they are
> about those "make sure memory ordering wrt refcount is right" and
> "restart speculative RCU walk" issues that actually happen regardless
> of having a constructor or not.
> 

I see, thanks. I just don't see any point or advantage of *not* using the constructor
with SLAB_TYPESAFE_BY_RCU caches.
There is always must be a small part of initialization code that could be placed
in constructor. And it's better to put that part into constructor to avoid initializing
what's already has been initialized. If people use SLAB_TYPESAFE_BY_RCU instead of traditional
kfree_rcu() for cache-efficiency and because they want to reuse the object faster, than avoiding
few writes into cache-hot data doesn't look like a bad idea.
E.g. nf_conntrack case could at least move the spin_lock_init() and atomic_set(&ct->ct_general.use, 0)
in the constructor.

I can't think of any advantage in not having the constructor. 
