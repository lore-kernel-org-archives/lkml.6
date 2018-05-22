Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeEVQZe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:25:34 -0400
Received: from mail-eopbgr10121.outbound.protection.outlook.com ([40.107.1.121]:60800
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751278AbeEVQZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:25:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v2 1/2] kasan: free allocated shadow memory on
 MEM_CANCEL_ONLINE
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>
References: <20180522100756.18478-1-david@redhat.com>
 <20180522100756.18478-2-david@redhat.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <6666c564-916d-a145-183c-362e6f72c409@virtuozzo.com>
Date: Tue, 22 May 2018 19:26:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522100756.18478-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0022.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::32) To AM6PR08MB3255.eurprd08.prod.outlook.com
 (2603:10a6:209:47::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3255;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;3:zZ65rcVrquTkgHsBX6HbNNEubjM4lSpfoTJhoCypsbBjlmNHTO93E4RBtc+/1q2My6ykLNP1cmuUa0MyfRXbRMY8pbN7Wb3FyjN6TYTXMaGVfD5OgpDTpwnBygqXiBm5ICfeJLDGoLNby+SuJHseQBxoKAyRZZfQlOmWDKM9mfHJGQlQIDWwd1/F2u4/6QPcvnD9ZA0a77IW/XDLdTLaQGONXFBpaf6k8m9n3XwkNz7ld/DY+kn55x8b+TxcE9B0;25:gRnNobYMe7CgXfOkSmAhTr0oxRTfSAYEtu5uwQfDGEYyvx5nW6xuvghgjZ/qeCayKKV5XPZ+YGwtZjMhmpWnm0+jKeL5oVWw9zf40IxsQwbdxYudYTPdx+7RWCt9q6b4N0Afdom6QpqiURXRZohpxO49AgxD6hHDcUv46/uR2rDw5jLZuFWQQul9SiO2tp40UxVn5GOLwB6E+B2dmXmsFHSSbhIsuPesO+EzvAtftEBg76aVmXu9jhUCZ4XOeMOGxpSM4EpSFMb2dE6utYMl5kPOGt/zLoT/JJpnumBtVyxQyR+5nttF1yE63InSlrsrZ0v5Ly4fez/3TRcKfJpQZw==;31:TNgI5qXTQMUfJ/0yBtHnEFH5BP4KsMrDkwL0hyzpxPnQrGHCvGpM8DTJwLJu6XOAWATQJnGkiFQlOt42dL9XTxb0aD1DRngZIR7cczqvIDkKGZ9c2GlFVBuXZZT7b5PmpDFO2T3SxFAsu+b7o5wN7/MOuG+F2OZDr4LPFVQsp9flZE8HuNZWz8dVcZcrwuV85ckTyMZgW4DAktKxyAPTzvlNk2wYp0ynjYS8/hLLbo0=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3255:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;20:GLk+fVbB0KfstdF5rcuDJhVs4j/HQLBLYxY5jLHO22zAzd+uE/MVinJGAHGOYjpwE8mMCWzRwLXNOZ7YzxSyl3Qn202T6rfTlkLBnt49uTsoG8IGI6HA60bgssPgcv/w7X0xC+vmYqwNa+QqjxBGC8QoLg0t/cx+5UPjXs5VknbSCjj5Qk7RDemfTVDN1zcb1ZMaNv/3wnVB6m+D9gMwheBn8c5bvdhr/Cbaa2r2GAPZvNul4JefNBtAXryqD3g8HNxzOst6xQwDyWYuJm8Rj9ZTYNodAyRLWEf4xPR/RtVTlG/7R+mAbEp/a8MvkxYF+tZi4cVVWFOaYGO7kYF8zCbVm7by+ALaruQiIt1kJ00H1m8ClbhVL1bWqtbvY1OZbp5cBLLM1EN2rPS3zxUod6XO6vcWHYtCJ+Sg1S3wbFMGNOMH93mZMo0UA7OLa4QjKc2u+5IwppHh/3I00sARbevQCyeAk/TW2Fn/WiedpSGhuCEErvBuCvtDGhw2GCe1;4:o1hnhtdibyqT3YNwCK33Gc3/COLVANHIdr0x3blkiK9MMb/P3EIFoUtZHDsMK5sH+UqnHevdDLGxkh8YjkYi1PZmNZfKOyYlSFYdv7iNmlw+pAATntyu32kpqxXNSBQenvzltvmgiWx9NTQOcQpMU4m3rgD7e5ubcagTqYaGUdDn2/CM4i0+IMg4M0n3LRhSxL5NblEMqFvnNj3ONFdNIFT5YxtfWFqyqdA6xEXa7A8EM9YnmPSZhBJxXOJUJPdFvFCunayegUnihYjM+GuBGYeWrzk/rVsvVpf2FIHGPVulZRyqlmIdz97CAKJwo6wQ
X-Microsoft-Antispam-PRVS: <AM6PR08MB32556234AFB5BE4D672A0D97B0940@AM6PR08MB3255.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3255;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3255;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(39850400004)(366004)(376002)(39380400002)(199004)(189003)(31696002)(8936002)(53936002)(6666003)(6486002)(230700001)(5660300001)(54906003)(58126008)(16576012)(316002)(65826007)(110136005)(6246003)(8676002)(81156014)(86362001)(77096007)(81166006)(65806001)(66066001)(26005)(47776003)(65956001)(186003)(16526019)(64126003)(7736002)(50466002)(3846002)(31686004)(25786009)(76176011)(486006)(4326008)(305945005)(476003)(23676004)(68736007)(956004)(11346002)(386003)(446003)(52146003)(2486003)(52116002)(2616005)(53546011)(55236004)(105586002)(97736004)(229853002)(106356001)(36756003)(6116002)(2906002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3255;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU1OzIzOjBOZHgwR1F2ZjJweE9LdXdDb2dUOW5mM2Fo?=
 =?utf-8?B?bUsxbU1ZWlNJbUNpd3p1KzRvV2daaXQ0WW1ZVmdOTVlVR3RjUXE3NExYbVhh?=
 =?utf-8?B?NDRvd0V1V3VLVnh1VzhvRHQ1QTArQ3ZqYmRSRWFCeXpETjdkZEVjWlh2WVFD?=
 =?utf-8?B?dXgxMWp6YkpMa1ZPK09VUlZQTjNlMStIbVpFMkRtaHpDVGxhbC9VMzJjcEVD?=
 =?utf-8?B?ZGdRMGJ0OSsvZ1R6Ymw1SkdDOWh3UGY0OHpzemxtbDJ6ZmZHVEtHQTNYalcr?=
 =?utf-8?B?WTkxZWxNRlU2MDl1ZmRGV045VGVMYXdSZktIVTg0N0FHWEFJZFNzaURlSDBH?=
 =?utf-8?B?MHNqTTZGTnNhQjBhYS9rRE01cUI2Z044TkdTa2xrYXhXU3dQazFYMzd3RWVr?=
 =?utf-8?B?YjJ0elhhelhYa1BuS0wyL0lIQjJWZ2R0NEUzTUpmcm9tR0RyQ1U1TjYzZHRp?=
 =?utf-8?B?Z3NTSFZ1L3pJaGE5NkVpMFkzUlRraWE3aUk3M21uNit4RmRXWVFxZ3hGK08r?=
 =?utf-8?B?TThETittK05qdFZZQUkwUkNFNk1zWEptcUxvek1JTCtONlZYaENlRzlucUVh?=
 =?utf-8?B?cWRpQ0pMWlNsbWRFVzhvOVdVTnVXaENZVnBtb0VpUm5MUkl2dmd5NGNoaHZr?=
 =?utf-8?B?aHhpbnNGUk1FK0JCZTdDdTZydW5JM0JRR0VaZmJlNDU2dzZGNzZZQ3V4dGdO?=
 =?utf-8?B?RVFxdGxDclhXQWQrRGM4elppckdCQ29ScFZQZVZUS2xLTy9IdnJUb21ZUXFz?=
 =?utf-8?B?cXdxeXFHY2VaTktKN1VLTTdUZUduYkxBMzJDc29SNkRmK05BRUtpTGlWRXpy?=
 =?utf-8?B?a3VLTlUxREE2Z1lBTTVMdGpNNThVWUl4dE9FaHNHNWRKMmFMZFNWQ2ZrOC9q?=
 =?utf-8?B?RitIUnNUeFBjOENWL0c0Zm9DMzRuOGtBZFRPaWRXOUVHQ0tSUUJhOGNzdDc4?=
 =?utf-8?B?VVY1bWVNeWF6SUlRQ3BmOG9BVE9MNXF3UE1IVFpyWWpoc3EwTC9hcUlGQVVj?=
 =?utf-8?B?K3ZqdWwzRFpYczRMb2g2V2dzdDZMdDlYSDk1cFgxUnNJaG9jZHdNQXNvaUZo?=
 =?utf-8?B?VGU4VnNQTmtWM1B0SFB2dkZRNUFIL0FBMFFZbHFXYjIzNWN4bWlkcFZ2alQ2?=
 =?utf-8?B?NHdlSW1ONVJzTmw4K3YwRjZUc0JHS2VRT2x6M05xSUxmaE43TmlaZG9xVVg0?=
 =?utf-8?B?cTdTRDExblRJUkV1aUN5a01YNjZodE54ZkljYlB1YUtoaS9VbVF4eVB6YnJW?=
 =?utf-8?B?SUg2UHp2OFNaRDBxVktxQXM2K2tRN3ZrY2huMkJVdStjK0xZUmo4WVBuM1lL?=
 =?utf-8?B?bnpQWlhRa2xNT3VQNndza0gzQmkwZHl6dXRvU0lNRUkvbnAzVmJuM2N3RmNJ?=
 =?utf-8?B?aVRtRkgrY0Ixa1NyNWk1RFZRM2s3WnlNT28zMzI1UExRNmkrbVZwMUVwRlNZ?=
 =?utf-8?B?UzZtbE1wTEFQblRaMmdCLzltQWVLQnBqN0hVcUkrZTQrTzh2TVI5cDdsKzNP?=
 =?utf-8?B?TFdSU0IyMGl1cXZOVnc1Nmh4Q2tQa056bGZmbFQ1NktrNXpYOHNLNFIwcVRi?=
 =?utf-8?B?azY5TFNFUjVrbER1NVB4a1lWMmxhWktqMTBpcGNMTFMwR0N3dmxtY0pWUE1K?=
 =?utf-8?B?MnVPLzlEc1Z5dXhLTlQvS0Vid3p4cHQ0UG5PeHNpVTQ3U1V1bU1LTFhRV0pi?=
 =?utf-8?B?VHdMWEZOSDE4NzA2Si96c0cyaEppUUhobHNzTldqM1RXeklrSnZKa2l5UGo4?=
 =?utf-8?B?TkJDRkEwV3k1aWljYkFoT0RBc2thSVFZc01mWFNiYTkzTllBWHB0dElzK1Av?=
 =?utf-8?B?anRJek5EZk5GTXFNYXJ2dURObHg2SEZRWTVYcFZDSmtVWlZrS0ZiODFUUmdO?=
 =?utf-8?B?c2hPK3VqdUVvUU8ycGFFYksxL1plZjQ5UUVTOXB1Zks4dWkvZ0VrRE0vQitx?=
 =?utf-8?B?WXF0TzhOWlc2ZFdHWXFyenBGanZqbHNLbEtZUkRHRDlqMWtaSm91UEphaERr?=
 =?utf-8?Q?UlbU77?=
X-Microsoft-Antispam-Message-Info: Rj31jLpU80vg8iTs7DYRBaFyA+fDREl7St252z+1IPWNNckxwyP3OQllx9WrrEdXx0NL+thaM+HW1pRQzTIWBu6gw42ZZAWrhkfBjLaq7PqINTbXVqFgjSBUqJYVzHrrxflS4pgWgUXn2hAObgrzp1edRm5WBMUdb8PWJ3h03LxKTzBG3zhl9iK52FYNIZSl
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;6:2giC1bCNypcSUt/KpkN+6oi2QAj75gt77kXl00Sz5eV9Tl1KE1WZl4PE/lluLTQJ1lRfeD7J5f+5Z2++NBnpgc7HpHAAWUNALqos+G30gi+fImXl1P4DtF6aDPnPtjV2Fewxj4LtoFGNwo8rU66P3oYFrsSZZYKJb8y3T3popxgFl2NjOx64XG6ALPogu+NbatPtO2QFq5bcWgBOAqhhsHdb0uYzNO2pym8kcfICF+zbDzSbvhXZGZ3UOw59CDiw57rHaL67msyreB/mE9aRt8aB0ifV3Kwj0XwDkQ676x72aCtcQ5ULKAigXS7uPunT5XqX2S85Qz67dcsMl7Qs+RTB7ToJnH+3IqAGwwQYItVwJxieZrO1yyC0+CWmadnIkYMwyhlBIoO79123qPE8+SdHhXhJ8bwp8eDAN9FFPgvtZ8AP5dcokDp0wpIiyBpm/kJgYpH+wceMzkV0t50l1A==;5:F70bA0h5VehlyrRwUPOwUXpro2W3UPl9n/+VYiMQHTMy6lnDEkDjRAb2/Zve0L3poKX4Q5KoMHGU34RJHXHbR8VV/J7xuE14mDRbcdvXsl6sy2UTlFgBe7OxsOWHIHYY7Us+Q2JQLxXtEuyvAwihMm8clXMaN0IgS2agpU9M9C4=;24:B7r3UcMc3+rA4sjHTQxLHe+BKqDBfum6NOpOqtyOTdbRkaXcVqRRNrCpMmDUbnRKapUWRou6GiXINhYInCLakEHC/42fxJtinM23JHEnyEk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;7:XZhFqWAUZ3mXqpT0XEq00sEVRUcz9/7vvjnUGO996h3K4C8IvbKYMhWI4JLWJzzM3POMdCDQXkgzXlMfTEB6XSBA8ZjmEY5SQex4z1o04GrCXdB7m7VCafABI0KclEfA5SXPV7r48ip9dNamKJDwl2UZsNlDOCIhFqbE/tupwS6KeqGw1+qygzc9FevZ+9MdZa3Z1lRn5ARHv84PeIO3xN7wrlrkjspG7J0VY41SXlu2dQFgrb/QgpPosOIN+VrC;20:rz1ISw8Xt3BliO+wnRrvkSJ9HUt1LdEMfFSEdhhnhtq7XGUQi7Nrm6it9m73yjqjS8fK5EtkepGABqApZcdkmPWA8+/qMfQoblZOVOvCxvUdOT68a3od6Vb6F0z0exl5Fv6DpJaNNelAYeLPhx0rBxOxUMcw2o/M9kGABX+1tfk=
X-MS-Office365-Filtering-Correlation-Id: 5813fccd-9b22-4e27-dfb1-08d5c000a1bc
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 16:25:28.3523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5813fccd-9b22-4e27-dfb1-08d5c000a1bc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3255
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/22/2018 01:07 PM, David Hildenbrand wrote:
> We have to free memory again when we cancel onlining, otherwise a later
> onlining attempt will fail.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Fixes: fa69b5989bb0 ("mm/kasan: add support for memory hotplug")
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: <stable@vger.kernel.org>

>  mm/kasan/kasan.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> index 135ce2838c89..53564229674b 100644
> --- a/mm/kasan/kasan.c
> +++ b/mm/kasan/kasan.c
> @@ -867,6 +867,7 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
>  		kmemleak_ignore(ret);
>  		return NOTIFY_OK;
>  	}
> +	case MEM_CANCEL_ONLINE:
>  	case MEM_OFFLINE: {
>  		struct vm_struct *vm;
>  
> 
