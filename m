Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZrH6nE7UjFm+HcSgspoC+ZQQGt3SYGx7pFoayS6nCnBK0OIlbSsxF+n5i0NlQtbU6mQn4Gm
ARC-Seal: i=1; a=rsa-sha256; t=1525946024; cv=none;
        d=google.com; s=arc-20160816;
        b=PrJOlikKbaSFZ4j/J3Al+/HtvfxvI0XLZY9SQwJSm+kdwEnW4T8ejWRlPRugzZmoRi
         LsDv0sX/J7yAd6fbREjq0IyobRCEOd17OWzPKmqBcCuAC/UN0CgyhHRZiHji76Y33EMF
         7CPBPoW1lDqNuMuj0fuJ7VtR6krhvAcxsSJRRWPT04UT0NtqzSTUu1ewI35uD73ZJcKC
         iBxWwTtFZH+2QiJPQBuM+IsId+H1U9G3aS84qCu9IiBPcwGSfewWQ6mmkuwQuYwe/HSF
         x9HkseYSvp89Kxsa0SUQA10+foh+XGAV86E7wnUS72sPiJ8Zjv5p/hWgRlf0f4MgJpuh
         pXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=30UUA/43I6fvy95jAew38qQN5ryIAizCvz7wTqfUPjM=;
        b=tnhhfanZ/qP3lEhQou8GMK8gtbA7Wy68kkLe2glWWegDM/n+t00xEeQvGD7LwnqJB9
         ni1QyGiGYUUVDiA4aY05BZmZbCF66IjNG13yUT493Ecgay4HYVMgdYbbVU6uTUhWlvVV
         il1xRFblWoMiTqENhDxuHaXspWG1FTRaV/AH/Xser2zG1h4vthD3hkWuoOhLYVDfvSpx
         GZMp38ymq/52bRWNpU5Fd9xpVQwQLA0ZMxwu56mbVUxajRTeOayNi0+MnbSmUCKePBRZ
         543VxVOt/4ccOO8n3/IUOYYxx+9z2l5Aww6XCIQh8xdnM0rqqjedDifYtFJBcGXRizs5
         izxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=hGkkPA2A;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.90 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=hGkkPA2A;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.90 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v5 09/13] list_lru: Pass lru argument to
 memcg_drain_list_lru_node()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Thu, 10 May 2018 12:53:36 +0300
Message-ID: <152594601636.22949.5066059978522726025.stgit@localhost.localdomain>
In-Reply-To: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM0PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:208:1::35) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:3r6JLrObVO8H2vQpWvWH5r/JchCtf/UWu/JGXV46hIw3K0lP1VBUVcijKTckJT6g+VMrn/AhrN3Q95pfbCp3n01XIv/xA+5fu9Wm8fqSAguWPcjoowXemQX4hBQKawzRKNc36QOU3lIhM9fM57tqMt8r/R3PciBEz47PPxpJM+0lkX9ar/4zyvNaL9AIoDhXi02trNmnCI1O5ek7SBmhqyD454qusXNvVqCvSBBWyR8zUxaSWLyeK9Hjw5WO200A;25:tc3KP0FKOwOLQh5t68IdHMoD9kjWG3Hr/0HXKcP40szKKj/wTd02VwpyiVLGxnkiOV0VJ02jy+eSPBtJ/iHLLrZ1uMnUQB6GYs8ze8Z7yMwMeTQVIaEmwVFfmljFelLx38noUzswIt2cShpRH4/D57Ic6HjLt1YD2tLNoyzAwXM23DEw+4XzpvNV2/6/++CVmzsvXOduMqtlq3QBkMed0pq32k1f1S6jzi9KkEvqi+v3hkPOcaKirs+EO73GD544jaN6/U721PWzeG6gbU/J4zdMr2KAYPPyXs5YhstSY3TbE1b2VMGQ9gg18OMUHF5u2EDIgzjlOpSh/mkikIj6zA==;31:dUaCJ6PcnoVnI72JbS4FGm5yJrqOeZsv9mAztlnWnGoTCzj/CWDN3jpx0naHnVj25LosXpqn4siOygs41PIgZ6/4VeXXrj2HC+Sv5yHE/AZgzSaQKaIZZsFo4m5mWhXk1e5beE7Q/aV+kaFMN7dE6Gjk7hFMEz7fw0RuDIWXujSWL8nP4DnKXLIPT0bGqx2cLIqTjHwoUw7cb6/pLOmUNi1Inr3Gytzi2743/p2ok9Y=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:k5FVW960D4EmgeFjMfeQHyfZvCf8CtyyJUqV8+BhPYZOhovKSFVePzotzpJVcpOlmbnmSHe6u/PqlRetDbM2jNeIJex44DQPQMZ00qmP1QHibgnXiRECfNZStu0a1iQ+RpK2nMD9VBo0VJ/mwSW4kUvN56OlLUd2oV1c4ktDmkLQigVhbX0A1T0Ex9kVs2WXm3lCpY6cGPdZliy0rlRPTugviVKGh4wyVdLYYiBHSJcMOhksqoXeCuhUFr01kgglSKmMrpEKTucAdKBpE+ktBPFoYk/QVFQOcYmwvLpDtZOUSO7y65qeAgR/5cOdZ8FzryfHgM9n2W+dI0Mt8NsgRHE/R5F0D/YYnDxqDCA26hiXu4FqDv3dT4rKTYVQlCWkuFxOvNKFxRYyooXYG8mjIlToFp7QCVVXQCx81EC5eMHeT6E92/d9IE4YqDkI567z/NzYSsJgBHuC3uYMOOSGVAo+XF47nhooY2qvZG/CgpSnKdB2ek4OQmq3qgrgagyu;4:baqGlLpKKFeZeWFHzSQHAzf0I98sfE23dFlyu0/d5tT/tPjqlRi6isOE33d/mWVWmWY6bY88FJBQUGa7Y7Yk5Ll3o3ZE6GMPk/R34/q8h5sODj9A7C74aEnIgZh2tlmadVM4A8/gG/I+Mfa0tyI+fEdgU3/TRlXPycZiZhS3tcQ6Nw8vhWyiNLZyR0gavX/S4zTPz3YCAhhmoS+gVvIifX8svLEe1nytv6XJ0/eKLuhi2VrjR+Z/lnp7b16w1XgPHJb+1Lme7Ngf5G8LDntk0Q==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1342C24A773C68D8EB4994C1CD980@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(396003)(39850400004)(376002)(366004)(39380400002)(199004)(189003)(52116002)(23676004)(26005)(68736007)(186003)(2486003)(6116002)(97736004)(61506002)(86362001)(3846002)(105586002)(106356001)(16526019)(55016002)(66066001)(11346002)(446003)(25786009)(486006)(7416002)(76176011)(8936002)(305945005)(956004)(478600001)(7696005)(5660300001)(230700001)(47776003)(386003)(316002)(59450400001)(39060400002)(476003)(2906002)(55236004)(7736002)(6506007)(6636002)(58126008)(53936002)(81166006)(9686003)(8676002)(33896004)(81156014)(50466002)(103116003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6VEFPWmNrQStKM1N6alNodXF6Z0hwUVo2?=
 =?utf-8?B?eGVXeE9rYVFlOGJiNmNhTzJTZEw5S2oxb2Y5b2t2RGs1Z3FXZ295WnB6eWV2?=
 =?utf-8?B?VmFnYVVJWWlMajU1UmlaaEYwMG1hVWZyWkZzOTYwNy9ZM3V4U0RLMWtBSklW?=
 =?utf-8?B?eFg3ZVdhamRCN09yTkNINmt6cVNWSjJ2a0M2OE1hNVAvdWszK3NxVW1NSjQ4?=
 =?utf-8?B?SjhGTVJSTFB0Y1hkREk5ekNyQnhzWis0ek9kRlM3cEUvL0wxdkdtd1hwUVc3?=
 =?utf-8?B?T2k0UDBsUFAzWnBUck9jTnJvak1mSUJLSHIySXNwYmlFKzZmaEhXQVQwV21n?=
 =?utf-8?B?c0xOaU1mcHNoLy85SFJ4OFZacG5DTWw4SjhqcmYwMEJaN2FDMW44WnBPelZY?=
 =?utf-8?B?VHpjV2dhendYUWwxUkdxcDVhbkEvR1hFSlUrNE9CWldlOXpSZUhuQWk3QzlI?=
 =?utf-8?B?NzVVejc0NlhWTE9RVmN3ZUJKRXcxYkpBRVF6R29Mc2Y3S1JDazk0NWtvb25Q?=
 =?utf-8?B?eGN5ZFo4K2ROUDF3dmsrd2lnZUlERUcrTVNyVG03TGRGZllLSHJPUnZYdXFP?=
 =?utf-8?B?YjlmQ3k0Ui9VaEQ0TjRmYmREMVNTMjR3bm9RRlg0eWh2Vjg3RDQrKzlsc2FY?=
 =?utf-8?B?MG5iaWx2SnRMaHFGa0tSaUEyTWNENjBNTS9zWTdsMU9wR0VpUXV3b0hlc3pp?=
 =?utf-8?B?Ryt1VGNjUm56Z1c3WVlVaHBiSHljQlpUdUZCYTh3U1JpclZKU2VFYlZYWk1H?=
 =?utf-8?B?bEZZOVJ3eWxKU3ZaVm45dkhRak1TdGpKL1dNNkhaRmc2UjdQdXh3WkJITWlL?=
 =?utf-8?B?QlA1WkdxUzR0eVNLZ2RieVRQS2I1dy9FbVFONWVjbmV0S24yaEU4YmlGMmp1?=
 =?utf-8?B?VkFTZTFibC8zMHZDUU96Q1d5RTErWXRGWVVJSVl0U2FOa2k4bEU0UnVETFBh?=
 =?utf-8?B?MU5EZTlsMXE2cFZJajYrZE5pQ2lFcWg3WVorclAxVm5kc3JSY3gvQkU1Zzds?=
 =?utf-8?B?S3ZPN0VTZFFjYmFSeE8wMnFCTkwyOXBTZzlwdnFneE8rYTRIcHZUQUs2dXdx?=
 =?utf-8?B?UUpuMSt2YU5rTkNuMlUzb1FFSURMRjZDZVJXMzRKakRJYll6dDZ5M0pKaHox?=
 =?utf-8?B?TE53YWQwMUNYZUh6b2E1VFdlbEhFaFdGSVBNdzJnK2ZqeTRHanRLcVcxVTVL?=
 =?utf-8?B?VGczbU1tNnZYRGFFMkhZOWppQ1Y5MVAzT0JQNDYyekhOTktMOU44WW5EVzc3?=
 =?utf-8?B?a285bG9WejNFeDkwWHRtWGplMVpUNUVSYlFtTFZMYjNpS3ZtQkxUdG91ZjRi?=
 =?utf-8?B?Q25udlE4anh3ajZNaTZlZTlnbWlSNzRJN09NNWJuUld3YlBJenBkcVpmc3Ay?=
 =?utf-8?B?K3EzSzY3dXVSejZHRm11TURvQUNKc1k4UzNLVUQxV1JUaG1wZjVmQnhFa2F6?=
 =?utf-8?B?UzBWU1VhOE1ZbXh2NVFJcFVpdlB5VjFDcXQ3VUdXamNKYTBCSWVIYktVZDFy?=
 =?utf-8?B?MFBQVWlMbXBoUnlzbzlMMlgwYlA1Q01rN1I0QTgzcE5FZTlJUVdIRlB1amJI?=
 =?utf-8?B?bXFxZ2hRMndYSWlBVTZUcHVlNTI1VUhrZkc5aUZpQ3RPTnJJTXg0ZjBpUHZH?=
 =?utf-8?B?aENrRFJ4YWtGdHJwSzRhNVFsSlpuVmFQUU14dFBGdUlmTTZBVWd6Nnowdldz?=
 =?utf-8?B?bG0wNlZEODQ3eVB1MGkvcjFGcVRzNnJDUTdSbTdxK01lc3BDRVZyblUyVS9i?=
 =?utf-8?B?VkthcGFIYmhNTCtpMzN3UzNKbkxFcjF2ZkNkMFpvdVI5Vkd3dGNLb2JsTTM2?=
 =?utf-8?Q?A8HzhV59UuDoynK?=
X-Microsoft-Antispam-Message-Info: PB51o8k4GIOlFdxa4ImPhFIiuWIHGYdkX4Vk7JhzYlr2CG2pSWwHqBKzxGx2Cv5J9Jc5d/NMnz522IKtG8hJnUR8DMupB0zdoyFIioLo4EkJJfa2rWtMM7dEve9fM65zpJ7Mbmniz39DqlzoAC46ugS0E+Wm7Nlz5Hc+K0N9ec3ZrafciTovtgx/KcsyOPbj
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:tMcH42VWTpd8EzEhTy4IvEK4P1+HO5tmPXqHPTp1BYQvrPwbXm+3GzdYJaEuY7HYkL/6CJq0E7hQOTFT6fhbo/nO3h/aBTmaCkJKJxJtU8Ow83ZHjYKbHegcUwPnKqDqsYPLAGlAZp+omuUBmDeVEg84KSbkby0kSWaElCoNdzIZ3UG6KfDj426RjAE00eKwHY1YNBo1vbDztrpppr/Zwans012BHjmE8h+AzX3VLx4fi8rY00zCI5xHcG/Edl9PBdqAE+ETw7pvptArysxGDphvgWqOnDepcerRqYLx+LhRDnnAIvK+LGPT0Pt6DXGo8i+nWQPk7fEZ3m+tF5cjShWXj6n4PoJp2MgvAY3BVC24fau72UcnOOqQPujSYfuumvMRILPLqfEKsU3+4XyTYHfmWXGUmcUUThsmyF5hEp0M5jkwZVcq0Ipn3TaLObDHoqRQufFksxLZOsK0beGBqQ==;5:33XPEwrXPM9ldm9Gx4wwIabZrUN9Q5NfZ6iFC9GuBIe3AaWS3ITj9q1XHaBXbyLykVCqrZ9A2goKoLgXePnilazqknrIof9+VkQ9+NJvTNOXUKa1GcH0M7OlFZXPtIYdfwywjmjU9d7IpLytX8IZoxfETcVbwGsZ1QtUVy3s6C4=;24:rjwIPFoI2PyED0+6xYNdP/fE0e4hnWgirYt7V34L/hWM8wSvRCBKC0u9H0T8UMk7+3IPYvxORNEXTZ5bZDJgiS2dHFydIVlunqnYCM0dBLY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:gCSZtF2QVZW8xbMmhuwYUj1hqzGoIa30+UGySL+Tg0EyqVW+sO1dVefv+PDKiOhrh2a759BtaQkUYboUMC8Aey3NHzgSdOjxOUIik3hvc6GdduDQRkxZoG5kTcdQtP3ZH5+TY/HksBjmqrGiPsGVYhazCnYDaeDZCjS+ykTdwzx02n+Iz8isvDU6s6d423e+5GZm29kpgE/zmdTDXmy5Q6d8zn31Naeh8PnZjEZrhBmyTkbb6fB80GDxuAStP2Uq;20:XjRPoPdSV/5Fhr/mqnBjPrSFGBd4ZNgVogJf8RW0ZG8tChx0JrCH/3zC99QYtwqnjQ19XEYN3R7T4G/GbMzx+N83Ko5dMYloM3cMZySNITl4dwveFXaT2W0s6Ofb4TP2W/hy6R7kwsWgwFbP920pKeVwfIxY6BI0sr/H96PMa0g=
X-MS-Office365-Filtering-Correlation-Id: cc986d14-84f7-4324-0194-08d5b65be892
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:53:38.3891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc986d14-84f7-4324-0194-08d5b65be892
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070378759525829?=
X-GMAIL-MSGID: =?utf-8?q?1600070378759525829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
lru pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/list_lru.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 46b805073ed0..7f6cb27aa2f5 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -516,9 +516,10 @@ int memcg_update_all_list_lrus(int new_size)
 	goto out;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
+static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
@@ -547,7 +548,7 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
+		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
 }
 
 void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
