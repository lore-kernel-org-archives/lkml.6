Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeDSQ4J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:56:09 -0400
Received: from mail-eopbgr00116.outbound.protection.outlook.com ([40.107.0.116]:55925
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752854AbeDSQ4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:56:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [bisected] Stack overflow after fs: "switch the IO-triggering
 parts of umount to fs_pin" (was net namespaces kernel stack overflow)
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Alexander Aring <aring@mojatatu.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
References: <CAOHTApjPwWDxHmGrfMwFvszWubfjJ7YfBgZL-DQ0mdv00UtQEQ@mail.gmail.com>
 <ef45eb94-4480-0683-ccc0-eb1efaf7e96c@virtuozzo.com>
 <d6e6f694-1bd9-7f3e-eaa8-1947c47f523f@virtuozzo.com>
 <20180419153447.GH30522@ZenIV.linux.org.uk>
 <20180419164424.GI30522@ZenIV.linux.org.uk>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <188a05bc-de07-c048-6a8a-63dc899cce6d@virtuozzo.com>
Date: Thu, 19 Apr 2018 19:56:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419164424.GI30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::32) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:gzqvQg+H/yrO4g1WnMQgtuKAqeM13iiAJL96intWKdNcf/7RIB0zs7mTZ5o4xra9F2oS0A1uWGlo6Vobsit29QloREPGO9E+ZK7dlyvHJbkj4DC2qTegeJjPXLTaiyQSb/5/xYkkyJ9tYgCVGil596WIgIh664l4ycBE98ysES+8VvYZGGDzZOUJqkMlEW9I/V+Z0zk7BcJ/Icdosd+KX1CBSsNwBL+txRKXO/+H7KMQOQVbbQFq8VxXObhpPnc6;25:a/IHOhJYnja4FHvfKm3b2DyTKaaSD/TflUfpMdX7t9DBElOT1OOAmU9roTGZ9DbjMXeOpU9/2JhkGytQp0tTC+Xk5gjc1Hls4SHV4WiHovw582UEm802EOHcT1ReCG+0gChGJzQcXcCyCgOblsODhI7y+vl8/cWms3pIxoEkBNHXXaWOg0otuQWeb/rfbSLMRHbcP3URa82S+Qc4o6YedFeAqhJuPqPlRS6qjAlHY5/hPSGVd7M2QojwF+MG+mlaAUPJwWl7xOaM1dqt4qqNcSXiUjFOxuvXA5YW6c6QNnL8zAGh1N01LoojlKZqmieU6hvm+4avvWsnMn0QSJPJLA==;31:GqGuHT3VMnh2EQuyEdUxINNz0kLfGrWxNXE2Wo8hI3/I3mv6yAHkDMUQbKzCcdNMrZLiY9gKjrU764COjiaXH6v4LZW5AearKzQrMyYKawB9xihctGG4QGBg2H4yLDNhO1dL4v4f5qeqvT9d897u0PzFRQiVTwfH+4y/QAzaPMHa4bGjzWTuI+dEb3Vr/qtpu9Ma7oYNOS6evt13bmgdS4MGsrZT8EDDrmBNSOdQnos=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:92PGiQXx29OoyDH+8AKsy84d3gMzNFvwKJxRM9RWOEIoWmqSYitc5wVticLOKQe3SKQgXUy9alycz8tMpfxyKRrcOuCS/19qznJT1QBzUKCUB3Y93V1INaktiE4csLyNPv3sNv0/cfBctUcNVPRSwpwpdXDmgR4gfg2M8+CxVjOjHm8DSDaXV8FrDkfM8tSJszHoTT/KMooh+RI8+CDAxJ+fooDdz/Q/1kr6IodA61GC527WnwM3NzBQ80EaT+c0+UaauMlk3r1MP/WtOcsu6u7jV4aOCeI1JqzMwp1nr/2rtWQE27AeR9KyIkBvc9ZtgsUKgHD+7F4mbRf1l+3SxoSebBM7SmBZY/cLMUls/+lKz80zQvsy6ZEpJ0FPFkdbmxZSrCj57HnCUGSNVSX2Rz1DkpTCcH/pDbmtYV5q5LTUAhrBJwk8InlfzZTCVAB7Pk0OU0iY+OA/OSHuQjB9YiQInyZckaccdQQdlvs/KwLbLE+TKibTAWfImte9ybJs;4:ewYZHSDAFdqH395zldmy05AMWmIDq62zseY2loNtKboCeoTl9oNh6sj0TZnmk0VBdR0918Js2vC/dTZlW9ziGdvuGI560N2OBC7sMzRKr52NJZFpfngznzktCLzX5AkRCUAXOCafU5dz7Qn50G12Bs7uwKfYdadnIK9Xd7zBuRKbyRzSdRIi21tKhj0gjyW0V5qGTcUjDHKjISGxQtUkJouCe5EyJLTRQxh8vPJjMT54hIIZ4FgTu3jUr7YCAXeSWRsI/jnPEqD2uHv7gqtvOA==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13300AC8B4EB7015150B4A95CDB50@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(376002)(39380400002)(346002)(39850400004)(366004)(396003)(186003)(77096007)(16576012)(6246003)(55236004)(16526019)(305945005)(4326008)(6916009)(31696002)(53936002)(65826007)(5660300001)(86362001)(3846002)(386003)(316002)(54906003)(6486002)(230700001)(6116002)(446003)(2486003)(93886005)(59450400001)(23676004)(956004)(58126008)(2906002)(52146003)(7736002)(26005)(2616005)(476003)(52116002)(229853002)(76176011)(11346002)(53546011)(81166006)(8676002)(5890100001)(36756003)(31686004)(25786009)(65956001)(47776003)(66066001)(478600001)(8936002)(50466002)(65806001)(64126003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6bElsRC9KQXV4OW1zdXdXeTVWL0xhdHZQ?=
 =?utf-8?B?bXB6SWlxaDJSSC95elYxbmxmZ0NNN2I4eTY4V01MM0NUdjJYMkFmZ0c1S1p5?=
 =?utf-8?B?dXU1WFZPbVlvWmJEbGMzRCtERkVxT3VZMXdwTEhWeExnU253MGsySTJNY1NK?=
 =?utf-8?B?TjU5bGVWSlJNV2F3YVpiMjlIa1FiNHUrd2Y3MTZSQ3h0ekRDOHIyOWtXQkFi?=
 =?utf-8?B?b3pzWDdEemMwM3BYMStKdUVuekQzeWk4cWJHdFRmS2VaMkJRTkxOc1Yrbzdq?=
 =?utf-8?B?QzFkdldIZTc3eFpkallKRFE2ZGl1bmNnbGtldjB0c2o1U1hIMktlMitTTXlO?=
 =?utf-8?B?YWpKanhMeTJlYkFteWFpMHpMbXljZFhFZ1dvR25sbDR5d0gzdHdNeGx3UU1G?=
 =?utf-8?B?TTZaLzVkTEdMNHNGQjhEOElQY1RpaU5HRVA3WUpxU1JSd3lWdkNhNU1LZzNO?=
 =?utf-8?B?NThEcDlqZHY1ajE4SDVxTTcxMmpKUXNud3IrYU9YeStucEpJMzRuNS9wVjNK?=
 =?utf-8?B?QTY3TFZQY25yQy9ZOGpUdEI2bWQzYjh0VjROUGpkcTl2UWtCcmR0OStkdjkw?=
 =?utf-8?B?U1FoWjR0bzcvYjlQREZHQ2Z2RUJ0MlYweUEzUUNYZEF4MTFnNTZZVW5FeXpC?=
 =?utf-8?B?QXZnRHR4MUxDZi8vNzFIZlhQL2lyT0xDYlNCeFlOVmE4ZnJrNFVQUnRNTmY3?=
 =?utf-8?B?Q0NDTXcwMTU4bllxaWt5ZGc2OUhHb2xjTjUxbElJeFJ4emVNT1ZwSk5MWVVO?=
 =?utf-8?B?RVltZWRSRGlOVUU3Vy9mTE1MVTM5cTNXMUpQWjZvNzVOcWk1ZVFVU1JuOXUr?=
 =?utf-8?B?RmVzRWg4WXBkdWFlTzNnbHpPZGxwUlZZcGxXcFVmK1lKNXVxMUMwVEx2TEtU?=
 =?utf-8?B?cXVGRnM2NUFpeDlQSTNaQVcxRk5yUks5UnVuZ0VabTJENG4wMm1yc3NlUlor?=
 =?utf-8?B?M3RCMTcxWXNNa3B4dlgzSDU0aFNqUlNkOEFEcHJzalJVdUJiWG9XOHVKVlNL?=
 =?utf-8?B?czZKcEphODdqNW5yVk1Nc244Q3RWUVJLYmhzTXM4Ull1dDBXRXY1dDJSeHVs?=
 =?utf-8?B?VDFRVkxrSEFzeldyVUJUSjMyWTl4OHY0eFRhWFRvRnVjSnRjU3NZaXB5aEdQ?=
 =?utf-8?B?Z0xRd1ZwWmQzRmU5VlFROEtnZHR0U1hTSE12OWFTOFQ5TGFMWGJOMFAvOEhZ?=
 =?utf-8?B?Q1Brc3BSbVJjUG5pWTNWY09vd2tCalhoSjJPeUJjM2JJUm1ESk82SlJTaDI5?=
 =?utf-8?B?cmVKQTNtYTlXSzZyVzIwNUNmekhHZ3RFUjkzdVlrOXBYakJMSmFBMStJbm1S?=
 =?utf-8?B?OWFSUHBXdk4wckhVUndjaDM0ZTlDZklFdXV2eFdXS0VubDJDR0lId1c5TDVP?=
 =?utf-8?B?RzRZR2FpZTdaNjRraHgyTWhuSys5Wm5FMjF6V3QzZHlIcTd6Vi9lNTV4RWZC?=
 =?utf-8?B?bHI2M0RwMm9xVmpiSnpxbVg3ejZ3Mk5hbFhwUFVXUjUxQVZEWUtnbENld1V5?=
 =?utf-8?B?dWc1bFRTMTVXYTFpaEpldDNESy9MMy9PMjJqcVpXc1FPbGdzMkJ0emR6c3Rq?=
 =?utf-8?B?bFRoMEQ1dDl4dTJRRE9JdXRGdENYYlErbVZYdmJKbjFYNnEwRytQbk44ai9Z?=
 =?utf-8?B?Q0lPbWZUZGNmdVJhNExTMnByNWpLVXVBMkNDLzM0NTNJenJ3SWFCaGRTSVN5?=
 =?utf-8?B?SnkzMGVjdENHYUtNZjE1OFlWeFgyY1FROWtzc0JnaWFxQXM3VzJ6UmZScmVv?=
 =?utf-8?B?WmlBRDlUT2tILzBxUW1hajQ2ZTRwTjJUdVp3MXk5WTY5THlrZXlUNFA4SE5D?=
 =?utf-8?B?Nmx1TkZScy9neklmVTFGeXo3bXhFQ2xRQzd1eWk0ZWI4b3B2T1hzOWxnYVlp?=
 =?utf-8?B?bktnVklDM3c1b2lYUmhjTGt1c1dQSFRqOXNheVJtYThVVGFIVmo1VnhZRGxD?=
 =?utf-8?Q?6opR+r0ELyIaT68D0EdVm9J/1CbTjRok=3D?=
X-Microsoft-Antispam-Message-Info: Khs36yrvSaTNBXU1tx5Sgl8Gsmno0kFHKpl8/V02Bo5k+eZ2/tI8l6hWKaPSntKbx+4PJfyaENpt4OiJK8q/HSOzLwdz5rHGH3PshO195C8PjEyjNuhuMoxOMsKPqsWU5ahFBV+y9JSK+h/o2LRsUpTFpN5B/fpCOBZWTgDGsRBhduXO+8w1Vla7vVvaubjN
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:bXUSYtQO3370ZIr3H0m8lF2chwwWciHAKLPkmLO3Q3WK141X5vDkdE3DLgZ5Zl19eryrZ3ELg1psQeCKeFfe934c5kAFbmoEsZp3VI1ukJGGyAncGVnIoI1dBW4huhCNHbs9pr38R5dRCb/yJM4ZUuWYVTNetUXqBHTqGA4ELlk+ax6incbucMDIZGMqlJeAGVuLHRFb8Fu09pdxK/HLzTKR65M3bKFg/qTheSlZcjhBPFfRqzrX2q1WjeoWCzUXyiAD2P4nebTULMCpebKzq1m7XSUvxVdCDJSLiXIBX8kOlIYr2UWk/nGdXJDhGa/rb9iePn0a0EPp516o6+ctOW2HZtySohIvap9PrVKA1khDGGPeeAdh5haEFiBIzlk0nIKgg+XAgg7nP1V2Lq6PGP6Lg+yCdoA/zwv84rjycJXTSpCTxmsxX5sIdVGPHb7vIYpnOiO1tGKfzv3VrqqRxw==;5:Y83PkxLVOwlCWwddT1MbUo1mZyvlkxeDVjgIiqwnSoUe1paLLGoVcBYNelCM17KuHoglaIxJrQbzDOcQc2wKovFo1BBZBZjbhR8jQOhDf1t0RdxngqeQoXnFS9wO2JowqTLzkWHNZE9HfWiX2oNgxGt3CfXLqS9ARBp+c6gIiEY=;24:c6FpI24JXKRchNQJcmMaGRijmPAdFqe8gqOEqmlsPrSeOHc4HBOoyF03LnC1PU5JkQSgVjxp2RVurvuLT7/2bhnaJUI0lxGvNkMOtmoMHmA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:Gn4zDBPrkN+FxDahPwumdjysmtPtrVM7pmz9naKMvWqqWpRkEns+l4Ecmdp/M16UcC6ggvBQM7TzXrfPfNl7qv5z+YlYWFHe3Mc8XQh9s66zge7jUVL7+EnwO5PDkH63PURPaEn7c9C+RLjQDeKvsShkLJRZ0+PU08UmD3LjCj40HKANLyDF/nu0+zrQTCvVawElcr4Woqe9iMTlzqDAl5jQtumYJJJgu3FtkuSobg39a+SId4XlxJLZxX9PKOyq;20:fd2zEgUtQmrkT+cXCcnYs4G7UQl1n+6QhTWe9wEBf0rCtmYODcozFm/HaRYYRpH6WQRtMOigKtFmpztzlazeAZMXlmAljiMJan/g+K3JocoFh43Izebr7AUV1jtakS2V/uoUqFjC8sHsibrsxy0ygt09TJ8eI4SFt3A207Cr3M4=
X-MS-Office365-Filtering-Correlation-Id: 39872234-4b75-4c91-f700-08d5a616701e
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 16:56:03.9088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39872234-4b75-4c91-f700-08d5a616701e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.2018 19:44, Al Viro wrote:
> On Thu, Apr 19, 2018 at 04:34:48PM +0100, Al Viro wrote:
> 
>> IOW, we only get there if our vfsmount was an MNT_INTERNAL one.
>> So we have mnt->mnt_umount of some MNT_INTERNAL mount found in
>> ->mnt_pins of some other mount.  Which, AFAICS, means that
>> it used to be mounted on that other mount.  How the hell can
>> that happen?
>>
>> It looks like you somehow get a long chain of MNT_INTERNAL mounts
>> stacked on top of each other, which ought to be prevented by
>>         mnt_flags &= ~MNT_INTERNAL_FLAGS;
>> in do_add_mount().  Nuts...
> 
> Arrrrrgh...  Nuts is right - clone_mnt() preserves the sodding
> MNT_INTERNAL, with obvious results.
> 
> netns is related to the problem, by exposing MNT_INTERNAL mounts
> (in /proc/*/ns/*) for mount --bind to copy and attach to the
> tree.  AFAICS, the minimal reproducer is
> 
> touch /tmp/a
> unshare -m sh -c 'for i in `seq 10000`; do mount --bind /proc/1/ns/net /tmp/a; done'
> 
> (and it can be anything in /proc/*/ns/*, really)
> 
> I think the fix should be along the lines of the following:
> 
> Don't leak MNT_INTERNAL away from internal mounts
> 
> We want it only for the stuff created by SB_KERNMOUNT mounts, *not* for
> their copies.
> 
> Cc: stable@kernel.org
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Flawless victory! Thanks.

Tested-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
> diff --git a/fs/namespace.c b/fs/namespace.c
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1089,7 +1089,8 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
>  			goto out_free;
>  	}
>  
> -	mnt->mnt.mnt_flags = old->mnt.mnt_flags & ~(MNT_WRITE_HOLD|MNT_MARKED);
> +	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
> +	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
>  	/* Don't allow unprivileged users to change mount flags */
>  	if (flag & CL_UNPRIVILEGED) {
>  		mnt->mnt.mnt_flags |= MNT_LOCK_ATIME;
> 
