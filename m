Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9085AC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E4B24300
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Pbdml4t8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E4B24300
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753064AbeGDO4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:56:16 -0400
Received: from mail-eopbgr30128.outbound.protection.outlook.com ([40.107.3.128]:45281
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752578AbeGDO4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkI0cW3AbEzGFgC7PTynHSlCu2n5vh/nCri3cT9Y2dM=;
 b=Pbdml4t8tYfTN9GDiUGVU9SQ9NpFAG5cWNCRpf5+1lDE5Kndo394/Vz/Ld5z5EuxmfIqydWG/wUioFIi8lbRKV+duxyzvrLI+Ctsx2Zypc5IRgNCB2J59DXvhQ0aVmyh3PwNVmiD1y/MegaJVZdXqrF1iIjPaM8nVSCndMqYRag=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.5] (185.231.240.5) by
 DB6PR0801MB1335.eurprd08.prod.outlook.com (2603:10a6:4:b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Wed, 4 Jul 2018 14:56:08 +0000
Subject: Re: [PATCH v8 14/17] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063066653.1818.976035462801487910.stgit@localhost.localdomain>
 <20180703135813.ed4eef6a4a2df32fa1085e4c@linux-foundation.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3fca0622-6f70-25eb-b023-2046c52734b7@virtuozzo.com>
Date:   Wed, 4 Jul 2018 17:56:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703135813.ed4eef6a4a2df32fa1085e4c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR03CA0050.eurprd03.prod.outlook.com
 (2603:10a6:803:50::21) To DB6PR0801MB1335.eurprd08.prod.outlook.com
 (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87ff5800-792a-43ae-ae20-08d5e1be4837
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:d0IYeqqD8716tLheoTXuMWUK4dnvyWK8IoZD7hZp30n4J4sraXQROmUttUyjV7DA9l3Q0K4CrRImT2Xap0fjgbnbdxiuLGQLbIXL4Nn0kDc6npWULrrGapIyiw88WCA/Ea6GTZ3bBeDPmKTwrmNVJF2eFLZ8rG8OsY+RuF9zmD9Wncp9KTJoaSHDIcx7OhW207YdcsUlIj4TZ2TCfLMHk2rKuamrlhnn7Vua9vqWKHY/8bExRMXwYZzCKZ/k3B24;25:o5TT6Lofi5eSVsKSih5z+10PAYc/eWVMNB10CKAVfRuluonHSOJ+tCaVs7fTTKly23CFv81OUsNxnPzY9Q1bsq8qpMPO4do1SwfrG0z6bESB/ldS4kbPxvJVvLYzUI5sKQNYNloN4YQ2UrtHwOvB19F8dZBVZRaxxei0Mgw2glLzhObe9fA3FtjLEI53jKSVRfURudW3tP/14btzMMWkWSYHvKGCqE6kzXpkOho1B38YAL+eyMmOTNQz3gk0iJ/4DEdpK2odtQje5znFTTrxFLgNUnur/L+sQW398Y6nImIZ2xzvyG1bheIMVvXLyOxhJy8iJdns1hQaSZ534JuB8A==;31:8uzlhOYgCZrPm8+dcxCP6PcajING3zdoEZ79QBCBjugbH9GTEei97eCv8qb3JNAaTLP3B9W7M/KJPKo5fwHDMwNcAMya+STvbiCGlhrEmoeSuZsnvbCHNTDaqOxVz9b3Gg7g63tr7xZDcZfNW4PvT7jlXv5PnQfa2q1x6PausxIWbUHAAaOZz9ZfifbJ2yKJ6xeUmkDmzwWtS2CKRIWAPYbDchAcYfDOYdewVREFiYE=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:edTyWjH9WntcaS8YVbmd26uCSLg1KKFQsLgfV/VlOVvkj52Vo0TKOuNmU1qZDfyvVGEU0HuPH6zVfjtLVmmL1NvGbwjXl6UANNruIzjcUWPLSjt1iiwEUpf2dp5OKWBlWh5sVDnEoVb68VcuOsqNXhOPvB2iabixGISW9AFcH/8d9qdsFBb8iuJVKjAIVrLrDJgvCxBdq80QzPw5oMDMLsnlI/bjI8ppx5fi39vuXuF7Zkl3SkR+iBXA3ptJuYgtMHmN3HMKLeAkGzEKWHp6KDKvtMB9yBkgGZh6k/92lQyt+qBg5d1QSKC49f9A7wm5RFSvxdnwN6qEIB5CpuS8HQxeuCbNtQMy++fch9F8hCV32Mt8WP+kjgQRpfzXbvWL6iz4px5gIfvwB30NG8Cw/l1eBvZDI6I9cOGPILpXXTgbIx+Xjoq8qq1QyktrrZmB0dR6SqzdQfbE/uF0x1kKeHTv3kKuNggIbplne+b5wjGrIl+Q1zA0te7ZwJq00X86;4:M4i0bv6pnlTjs09hLbIPdyMJeW7twKb2qQsmwTBx1beBFCnXFcxQDTdvfT01+QvAfXddbAo4H87SFPA80FIxBWvBas/Rl98R+A7Lkc26EB+KLv77m0Mwxlm0ic3PSMXIEeJiyE96AyMrlr6N8NcFs5c8vK+jts1MYj06VEtVHMQe2N5bgJeh/ZGO2c87k5Q+/GNB2294lKH3+5kscHXi2hH+U3R3YI62QHk5Mit+edpIFt0O5CAJvUxVuD62tWi/kXC4pfXGJJBuNOfLg/xwSg==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13353035AAC597D8C7070571CD410@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(366004)(136003)(39850400004)(396003)(189003)(199004)(8676002)(6916009)(31686004)(66066001)(6246003)(52146003)(39060400002)(4326008)(65826007)(2486003)(5660300001)(65956001)(81166006)(81156014)(7416002)(107886003)(446003)(68736007)(97736004)(8936002)(86362001)(47776003)(6486002)(25786009)(50466002)(486006)(14444005)(2616005)(956004)(476003)(305945005)(65806001)(229853002)(31696002)(36756003)(58126008)(230700001)(3846002)(16576012)(316002)(53936002)(6116002)(105586002)(2906002)(26005)(6666003)(53546011)(77096007)(11346002)(106356001)(7736002)(52116002)(386003)(478600001)(16526019)(76176011)(23676004)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6akZESnZLMS9tNndzV1NueXRQUEhScWt6?=
 =?utf-8?B?Z1ZyS3hXTUxqMVJVT0srYmUrR3VKUjJPNWExMFhobXkxbHExdVhEa0lDeFZE?=
 =?utf-8?B?RzlVYTBZK1Q1bXR4NVd6cmJjanZrSmF0VTBHY25XdWhXaVRnaFNGbnpubzVE?=
 =?utf-8?B?L0I3YlUzTXB3U2FhSENzWEZJN0F0WURrNkRUcFVmRHZzOFpPVTlvdUFVYm5i?=
 =?utf-8?B?UGxkcENwM2RObndPVkNLaDd3UHB4SC8vdFRQL012R1F3aVAwS2V2U1FteHo0?=
 =?utf-8?B?dDE1dHZhMzM0UmF2bFJHN2hsSnZtNlRjMVBNbTJLb1JXQlYraGxQelpLVXBs?=
 =?utf-8?B?REdiRGdWUGlEKyt4MEFRWVREb2hQRUgrTm1jdWFveWxkQ2V4VzVUQWU5VGly?=
 =?utf-8?B?UlhnMGJlY2M4eE0va244eEUzMlluSUF2RU5YZlczTkNZcXc1eitGUlE3aUpI?=
 =?utf-8?B?QjlTQTk5d3dCVDVyV0xtNERKUzNZRFNVT1NQa3VHUU51YW41c0tkRXdFdFht?=
 =?utf-8?B?VElMNXNGL2F4MHluYk9CdnF3eTlnc3hsUldXYmJHcmdYcTdXTmY3SEwzdlE5?=
 =?utf-8?B?NVJ6MlNKSmFUYzV6cXhoZ0thRWVlczlGcmhKVUU1RElXeVQ0NE56amU4dE9j?=
 =?utf-8?B?aCtYRHkzVzlMQ2hRVU45TnAxRXRjelZYQTUzdFRQendpZ3JDbjdCWkl3SjBU?=
 =?utf-8?B?NnpFNll2UU56MUZyUUx0Mkd3alJycUlWME1sMlpvSGlDaXdCVGR4MEN3a1Av?=
 =?utf-8?B?aVhxL3M4UUN6NVlTRFNFaFFGOUh2a1RlcWROeE5DQ3hZVXJyL1I2S04xay8w?=
 =?utf-8?B?T1ovZ0VnaUl0WXN5Rm9CMHllYk1XU1lKN1lKOFVDSk95OTJoemd5SXhraDda?=
 =?utf-8?B?THRjYWdIQ3pGL1V0RVliU0FhdGNKcyt0RUdKNmNJYTJUdW9FbXBrYkNuc082?=
 =?utf-8?B?MGw1QnE3SXpoRS9uVGtXTlpLdTJ1TlVVZzJ5WmQ3amMyS2Q1NnJaQUhFOXQ5?=
 =?utf-8?B?aW45NjBQR3VaZmNZMjJIN1BwK2JDelJuK2tmTmZ1SzVrcnBSMGc0VDdYVHFo?=
 =?utf-8?B?UkVXVlVsa2ZtbmU3T2FUbVNuMmM0djRQSzcvdlZITjZZOXpraldNbkw4K25M?=
 =?utf-8?B?U1hNOVlFMWprL1FFZXlJbURWdDZUZFV6VzZuRThrZ3FpOE84S0l4Z0VMSGE3?=
 =?utf-8?B?SzdUUWNFS2lOV216dXYyWUk2OFZZK1g1Q3Q1YW84Wk1lZmRjUVNQb29wbWZW?=
 =?utf-8?B?Umg2UWY3TGMwcUxDWEdobXh0QkVYT283MW5NTEVWSmpuOTgwbWEwbW0vYzd0?=
 =?utf-8?B?cldWMW1QWnB2Skp1VFNkZnhFYjdFcDVMM2ZoQ1RQN3JpeUU3ckFwTmE5VlZp?=
 =?utf-8?B?YlQzN0x5STFNcjZZZER2bnN1V0Nkc1RnRGl4alNKRC8xOUtyRXk3d0hwdE1E?=
 =?utf-8?B?NFBzcGQ1dXJ6RjA4WmpSdklkUVF1ZzhTM1Jjd0NJM3U1R1V2akcyRWo1TC92?=
 =?utf-8?B?QmpaeEJCT05vWkhiK0FhSFRqWG96azRYYmFHNVJiVlhuYS8zbk1oSXlJRWwz?=
 =?utf-8?B?TTh3VmplbEJGOVRkYXpwTFk4dEV6K3Q1VndZeDRyeEUyNmx6VVVwQWg2ZlhJ?=
 =?utf-8?B?ZEl6RHlJS09vekplaHBobEZSUEgzQ0RVdG1NTDJzdklESmVHU3hLTGV3T0hK?=
 =?utf-8?B?djZxbnRnOHJhNUZWT3JXK0NNUTIyZXlUK2VHOUZTT0E2ZlRUMW1LUkJRSHox?=
 =?utf-8?B?OUd4QWZidXNUNHYwNXJGTDBacDhqL3lMQU1aRWNPV1p1djhEWm9WRUpVbDVL?=
 =?utf-8?B?bzUzb252TnB2WUlpRFp3TzMza0Nyem12cG5yQkxMQjNJSnRnQ29uSlFYMkJ0?=
 =?utf-8?B?cm1hMk9NVGdlVW9aTFNpcXhTMjFOYlFFclhxVDB3K3l0K0RpSkhFR1RibHJi?=
 =?utf-8?B?VjdTVEhEenQ4bWlZRU1mLzNuTkN0U055Q0tmNXowejZHTGdCNGxCRTJEcXNQ?=
 =?utf-8?Q?BiLFuv9T?=
X-Microsoft-Antispam-Message-Info: nLIGeeKjZJsMgh0OXdOkdxLq3jxciMBQeuLFaD7hz+3SAdf8A0a92o+q83qi3jyQzO9rlaYpmYtUZE0l5CDU8KrU+/GObkNVl/xrLenDQVhCn2plt7o3ZWbJ+Np/mKfPuWRI/2h4ytTN4HyDlo5xFXpjyD8uj1o4sPtnN0AW9nBaq2TpYo94ql6hcfKDbzpKPCWWj2otGNfcTYWSujWTZ+8XUsY8AxMrw+aepXrrO59TTSISu6qrzw+yii3vhJsSJyjwGeMDyi1lGbBAmPLVsRvuOVhYFrZtE9I/ukp/595R9DMiBrv8gNvhIy4aCwoon9aPpCMNkTkfm/FvFo/81LWHM+6FIA7BHArJGEwzn+I=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:EqikGgM1qH/nbiRNKeKuTgGCAAFSTCsdSOL/I2cm2GEmtuihRVeTQ0zgw1XH4wvd/lq5RmwLt/y6OKzxyrhAexwBgyicKufG2dGEr94xMb1XY5a1jPxSkvnT/Gs6cwwCaPvIjq+GlTGJhPXNtNKcWXnKQ2Hk9f/kijf8e+XQlyJFY1AdU9+gg/4sx6xva7mVcXnuJeZkqcb8bqmpQpqPHP1JNULhgQn8uRINlg8axt/5VPJx8E9qUZfcdgNbWKk6O+2TsB/9mk6Q+5ZNzkA7rF5pXw56MV8XQqINFHKdC6kskl5KHm4GdJE+dpHg2qw56JdcUGKfQekWVwGxVu72eTYSoY8En+qqgwTSVzyJ6Nx8zhzKy8fdE8z2Qh7mPjXoO49xIqO7UZSNS6hPpFxTh7bPQg3vIF6oALrmqsfNmPhSvHwwtfJFb+vQuo/LVIWd4MW3oBqRzuRY/tuEDqaVvw==;5:idwk3oESkjA/ziIGxlnPnUc9r3ZTQfIjjJNe04gs6FNFh49SbL7G2Q5uZlOjDZ7C9vX/x/fRUwEeMG2cAl55g6DWR60dCnzxINfKE3+utDxtVxW7X3QKRd0juhkXzvBoM4gei6hH6ebgNCm0tkUsKD2ZUZeP4ZwukQrwtOlS0/I=;24:HXFUfil07K2NL67C4JTxTzYgVjtfM9kpdzCX/r/xCm7mbeGNWFbWEOH1C4n35rK7LBN7g+9DgLcjoVuHHpbMf6GC4mVyhtrd559nWRwFWNc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;7:u+JoF3IUDPmDBTWJiuRjWWeBA0OFnBSeHwkQIBlOmKj9qg0Z1GW3E3hZEvqX6/QxZSL/tPOKZRn3uWZFKEa2QTU7GrD5FzscZSsL0J9FppgOpFz3mb+Cdp5gl+dKP11CsdEDLw3NRMH8Rvd3sPHlwl2pC/+LfJnyroOWQKzzJ3rFC6NA+zJHw88wCc4nAUChXtugQBN9rxVHF0tLuSq6FZtMRYj5/g2eLRG9V/MRlIqTkb18y2cLxYR+0/hmE37y;20:vcbtPiwwNByYrBJos3IpH3YL0CEg79cDOPFJsdm8mbL6DJGPSwSQBNHLNdwImBbzIhsk7KXb3IZht4ur/+DwC9ETqkUGa1rzZoCmuNEEI67GVbMWVI9OdU8CZlbfF3ZY56SReOKipvU3lTa8I2mCLAjQggat8YMYMGgfyiP712A=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 14:56:08.5073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ff5800-792a-43ae-ae20-08d5e1be4837
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.2018 23:58, Andrew Morton wrote:
> On Tue, 03 Jul 2018 18:11:06 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 
>> Using the preparations made in previous patches, in case of memcg
>> shrink, we may avoid shrinkers, which are not set in memcg's shrinkers
>> bitmap. To do that, we separate iterations over memcg-aware and
>> !memcg-aware shrinkers, and memcg-aware shrinkers are chosen
>> via for_each_set_bit() from the bitmap. In case of big nodes,
>> having many isolated environments, this gives significant
>> performance growth. See next patches for the details.
>>
>> Note, that the patch does not respect to empty memcg shrinkers,
>> since we never clear the bitmap bits after we set it once.
>> Their shrinkers will be called again, with no shrinked objects
>> as result. This functionality is provided by next patches.
>>
>> ...
>>
>> @@ -541,6 +555,67 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>>  	return freed;
>>  }
>>  
>> +#ifdef CONFIG_MEMCG_KMEM
>> +static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>> +			struct mem_cgroup *memcg, int priority)
>> +{
>> +	struct memcg_shrinker_map *map;
>> +	unsigned long freed = 0;
>> +	int ret, i;
>> +
>> +	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
>> +		return 0;
>> +
>> +	if (!down_read_trylock(&shrinker_rwsem))
>> +		return 0;
> 
> Why trylock?  Presumably some other code path is known to hold the lock
> for long periods?  Dunno.

We take shrinker_rwsem in prealloc_memcg_shrinker() and do memory allocation
there. It may result in reclaim under shrinker_rwsem write locked, so we use
down_read_trylock() to avoid deadlocks. The first versions of the patchset
contained different lock for this function, but it has gone in the process
of review.

>Comment it, please.

OK

>> +	/*
>> +	 * 1) Caller passes only alive memcg, so map can't be NULL.
>> +	 * 2) shrinker_rwsem protects from maps expanding.
>> +	 */
>> +	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
>> +					true);
>> +	BUG_ON(!map);
>> +
>> +	for_each_set_bit(i, map->map, shrinker_nr_max) {
>> +		struct shrink_control sc = {
>> +			.gfp_mask = gfp_mask,
>> +			.nid = nid,
>> +			.memcg = memcg,
>> +		};
>> +		struct shrinker *shrinker;
>> +
>> +		shrinker = idr_find(&shrinker_idr, i);
>> +		if (unlikely(!shrinker)) {
>> +			clear_bit(i, map->map);
>> +			continue;
>> +		}
>> +		BUG_ON(!(shrinker->flags & SHRINKER_MEMCG_AWARE));
> 
> Fair enough as a development-time sanity check but we shouldn't need
> this in production code.  Or make it VM_BUG_ON(), at least.

OK

>> +		/* See comment in prealloc_shrinker() */
>> +		if (unlikely(list_empty(&shrinker->list)))
>> +			continue;
>> +
>> +		ret = do_shrink_slab(&sc, shrinker, priority);
>> +		freed += ret;
>> +
>> +		if (rwsem_is_contended(&shrinker_rwsem)) {
>> +			freed = freed ? : 1;
>> +			break;
>> +		}
>> +	}
>> +
>> +	up_read(&shrinker_rwsem);
>> +	return freed;
>> +}
> 
