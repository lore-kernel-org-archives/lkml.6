Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/kTSrG4PfEKfcYHHNE0GZxOLy8mU3Ynf9cJKb9Tl97MdPTXQWub1fRiKkcQO/qwGGwl2Ol
ARC-Seal: i=1; a=rsa-sha256; t=1524571949; cv=none;
        d=google.com; s=arc-20160816;
        b=a6yv/dP6UeyzcXNAxZg55gzyPQxfOvidFZ8hC4kRVabmxUfMQUsgoo9PuB8304utwc
         bIxaEFkVeRYBmRZr3lltIT/QS0cdPp6+dKkUB3yhdwrkoSuPnv8cRTqBddJkT+2amMEa
         856cNudKWevtYqMo0bkqnlaOQQAog4t/olfHBYLoM1wCDWuJ6zzNVWvIHhMvTkB5FcTo
         Y3cq6Q4vFWNhT3Uu09cFXMAWhp0r10M/2MdUQtUGs7+IlpB8th/FHgTUPzMDbUGmi5vQ
         lAPbsw7ybvWwSQldMxINSLTcBfmlH1FuHvHo1dM1gQUia5aDxrVe6pNU0oGscZbm5p+J
         7zCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=QWokW85yAjSRM3MT+DFTpJxDBbSyNB+VNxJbFapWi9k=;
        b=Pgk8ZcAamPSaM+rAP0eIh4vTBpLvCPc7s9/ql4B2afF1NXZx/i6i2tENJagI1ucyGZ
         BRQilNUFB5+xXNmO6eZE7N8DdqcgEErPb4OeJrgB+9sIflbw8I/8L57SkJTA+FGbFOLT
         yF5HHOiV+er1LpJJfNE4HmKqGXva7QSPC7kNNXjEFinHzl/U2g7CuMLt7HudshpPEP7s
         dka/uBnbJ0qEgTGKJBnOY6DU2is6PS9EJJkx2Xg8S+lI6zOXqaY8oV2JdlRs/GexauWy
         F7PEsx1aE8vi9qMpqa27sQRpeiN8Z1PpTid/2U94lGqurYtlOdK+K37Cyu+8D1VMHGw7
         1HWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=SUxCOM2K;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.110 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=SUxCOM2K;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.110 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v3 03/14] memcg: Refactoring in
 alloc_mem_cgroup_per_node_info()
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
Date: Tue, 24 Apr 2018 15:12:20 +0300
Message-ID: <152457194082.22533.13153436126073546795.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::13) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:f69bklP2coEUCKumrwT6MqzXGARutQEXXD8JjKLl1EAq2v6XaQr+11CPFMiwUeu4CaHV/CNg0UHfckVmWtiKuVp5NVcvqolMDoLNX2mLcos9ZJ8pKQPS4WZQlqMMFvjNO5gIrK2DHH7l5VAkje13jOBuOANjdc1jfPFrkYFvVveGZRvKEb9PyLnRpIIoFYU1tunSjByJnrgKvuoeQntwBu1bq9m617plqi5NacDityvfFKrpDQQ2js5yhFNb3Fa6;25:EcA8kFhjiUlTzfsq8wM6omedDer9u1Zw4Ee1wJlbzl0g+c76s9PtvNMyVAIpM3LucFZFBSVu1IEPpjEyyU5/kWVWNiodsijIpw2nkrlWVVRiWVBejbszNxqbSKlOMmloGucIc7ydxOEYISTJd/wpDP4L0fiaCLetr6ZBavw2JfQNsHFSmzLMbFwGDbI8AyMudIey9PVVQ8akrQVxjfPzCacSg1tmO87mleohUKbzv9e+7ZVsXK8rZ+cRqv3ESQJz2/HbTDQit5zdB52u4U2nIqRPBM/x7I5+vUGOPfz3WXioC698m8E9cyr3p3w4+f0w6YF5QoIhp/J3/rc+slLzRA==;31:QAKSXh5Ff0IKdIFqAntUb+SVLkBUyCuVF2JRd2VLyu9H2A0FaJaphDV7QVcId8YWYMMy7BisJXohiEAPmIppllpVzMLzVEomgu07/e5IdOO/322njsjoA+eSaL3Uy/gusj7XPxw7ExlbXFt2YZfg+rJnQYwK7RVoolsaRxucFKeLTGKwwjBA/+AiCfYyliRbKIEOpJd22b1+N3d++w1c9oPby5AnnY/5YjraeNsw4Ng=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:NkSuh1Do8X9K344xkTkYnQVob/ckirgaFfN+vK7Vwd1vRdc3Kr7XRmox7Vl+GhxF4kEfDAJhgL2ogGvdkcGiCj7G5G1JePxbvaz3SgMPjUMDYWgjyv2r8Aqsqpi2+grX3aQ7/7wI0ZjnzI9LWgKVfK1uxHiJjDkkFpV8b7FymiYyZrQzXrM9G4K7SqwSefibA1q0p/rJHubQjFqrrh1herDAVulu+Uum3q5AK51u4ioESMGNRtur0xWx2Yhfqvu3G0ZHJ6xXTa6MdWBSXhoh37JgmbWH8z23eFd7ayAtUQaUREgk9LIU4IAhwc/hdc+lnc2hSFn/xuQwwWnbv8U8gIKxgUZBthpDqSHm0n/EoJYXGehRPGp7u0LNp+YUUL2KlSphuW0DZIeTCb7gMfbOpO9I/6V6DtuXzuS99EdvArB/MDcxWjJGYyD5vJu1n9OD+aLOLeiFyEouJlVVz17tiY3GcXrtjgDvCSxP/KJUpIxlb1t4tuDEHoL4n9vrnyll;4:ITxxWMb0EVYWROmJAI8f4X6Knxc59GeBVykzCetIH2nrbSsc8EJBhT2Hj/dZ5c+cw24dfHkqK9fUf8qd8M0x8g7Kz2tmt101HKKlGBEHWcYld2NJLHp7dY3yq/Rl2x9v9zPkCQcprHiZJcfCesr932zydvBLuqBYlSZk8oufXlF2IZHXA/4lGHYdx5puEDOSghsZjST+HGWWVvLEgedGELaLfgWZc4WXYr5xfFXJ0KVlgnjR5MKIi5fpfhmHzIG84xxlhwuCpUzuDn6Ll4EtQg==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1329331710D8105B35EED712CD880@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39850400004)(39380400002)(376002)(346002)(366004)(189003)(199004)(97736004)(66066001)(58126008)(316002)(103116003)(47776003)(5660300001)(6636002)(486006)(26005)(106356001)(446003)(956004)(11346002)(61506002)(476003)(305945005)(33896004)(68736007)(9686003)(25786009)(23676004)(2486003)(16526019)(81156014)(81166006)(52116002)(105586002)(7416002)(86362001)(186003)(2906002)(7736002)(53936002)(7696005)(39060400002)(8676002)(76176011)(55016002)(50466002)(230700001)(386003)(55236004)(478600001)(6116002)(8936002)(3846002)(6506007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6d3Q3V1paOGRUbjQwUDdET0FPOXc2SU1K?=
 =?utf-8?B?Tklrb0pKbDY2ZjJBbTlaUkhqMGNYQWppeUJmY01LS1dqK0hxMWZ3KzlQVEU1?=
 =?utf-8?B?aUNMQ3pPK055dkhJRmxlQlN3RFZISkg2WjdJRGl1eWMrSTdrTHRmQWRlRWIz?=
 =?utf-8?B?THVwS3N1aHo0a1ViOGtXUTF2U3JRSUtvUjEwWW5GeXlsRmNLWnBQVU5zaUFV?=
 =?utf-8?B?OVZldlRvVnZwYUZkbTc3aXJ1UFJGaE1KeWEzVkliYmZXWkFkNEJIdnRnM0tq?=
 =?utf-8?B?Rkl4amQ1ZEQ2NE1UcGlsUEdkbDFhOXR2eVF4NFJsZkZIeVh0SjFJaWdWSGVQ?=
 =?utf-8?B?Qkhod0pQOXh5ZWZJbzhodE5EK1dva1drWGs3Sy9GaXZYOEo1bFdOVnQ2Wlp2?=
 =?utf-8?B?em9JeVRHQm9UM2RvNm5YdWxCTTJTMG9zeWpXM2I5M1RZNkErejdrQTRoWmhD?=
 =?utf-8?B?Yy90a2F2M3ZVajdUVGx6VDcrVE5sVno2K3psc1hEbUNMK05vd3FYYndlVnpY?=
 =?utf-8?B?OXlDWVpnNlVJWFUwOU5Ea2RvR1lMV21DUE1BQm5EVGt1bFJKMFpxcW5jeG1h?=
 =?utf-8?B?Y0lvZXY0b3h6NkxaK0loaVgzMFVpN1JRTFY3TERhTnNCMm9OWVUyTkI4bHZ6?=
 =?utf-8?B?YWRGSVJKdHlRRC9qNmtqZWM4eVV0UXc4Y0s0L3VOVzlvVGlTRFBLenZ1alEr?=
 =?utf-8?B?WkNKc0pZN2tWdWlFRzNpUTV4TFZEd1l1MUF0TlBkMzNkOG9HRVpZdmdVYmJK?=
 =?utf-8?B?UjAwdWE5bkRBNjRvT0VwREI4UEszOFlXQ2xLKzVJcjlvYlBoNGQ1OVpyRzB4?=
 =?utf-8?B?RmgxaU8vb3pJMkhha2VaeWN2Mk9obGw0TXdGcDFlejQ4Q2Y4Zyt6RllZOEdq?=
 =?utf-8?B?S2t3Ry9GaGJ6dWZ1eHBIMnU1UTdEYlV4NVlOMlloRUFXd0hlL2h0U3FKLzhl?=
 =?utf-8?B?bERhbVE2MkZQbzhLNDM3dGdMbmw0YXNUZ2JrZHlEU2IzN3RRQXQyMUlHMGNl?=
 =?utf-8?B?MXRSQlB4akpTOVhGVzJrZmlnZUxuVGd5ZlRoM1cyamc4cFZveDlTVkk0azN1?=
 =?utf-8?B?WmV4eStqS1lTV1h2b3FBMHNSMVdGbnh1UTJub2g3UG03ZXBFbXpMamxERG1V?=
 =?utf-8?B?T3NUamV6SFEwSlRYeFFVeEV2V3ErN052VTB6N0pnMFhVMXFUNUNYYkhCOTZ2?=
 =?utf-8?B?cXl1enNnOVd3SFc5OGhQN2p3OFhNd1krbVhqNmdyVzBYMkRCZzd2a2VHQzNI?=
 =?utf-8?B?VlBWdDZ4aDlXZ0hueWQ0RWZ3WlJXSitoMmN2R2NCOXU0VUNTYW5MTkk3VFVC?=
 =?utf-8?B?RjZQeWEzSkE0TnRUUWxld0F3b0ZLNU9DR3BaMWVleTBBS0hVcVdORlZlSS9W?=
 =?utf-8?B?YjE2V0ZrLzM3WHhZQ1BlY3A2RGM4WWZuS1kvN2FwZ3g3TjZTNkU4WGxtYmRk?=
 =?utf-8?B?SmJWenR3NHV2WU90TDJQV2t1QytCT2UwQVJ2a3greTJGQmFJVG9YMy9WWG8v?=
 =?utf-8?B?L0dwYUQrSmE5TlFOR3IzS1UxS1FlL25HTlYwSHdlbERQSVlxT0wvOWN2dUpj?=
 =?utf-8?B?UDFWcVplR1VJejJzZG5qcDB2dFhSUXBMRzBUaXF4MXlSWklTZmNqRU1jMjQy?=
 =?utf-8?B?R1dNeFlQUG5SSER5YklqWkpVamJBajFudVRsSWF6c2NNNWp3TzZuTG90em5Y?=
 =?utf-8?B?ejZ0OFpkUkEzOXRmOS9HQXRMTDVHYXVZTGRsRSsvOWZlQnFMQUxkKzg3WXhJ?=
 =?utf-8?Q?HqBLWc9FpEi1yzc3A9lnfi22n4Q6zy6G3I191Uo=3D?=
X-Microsoft-Antispam-Message-Info: FBMaAh314K6R4wVpfIX1agqHn+W7cpAMsbVcqsMspVhDN0wQCn95ttjNyziF+SE8Em27ZdI3wFJdltnM5aP2V1K0zsAFw1CGi8IwDcqNPF50EmXXPSk2wScvmTFVQLs1MWT++EK2liKN9HO/IGPVieQewdn6fyq+xVMC/s/rheuvXiOJ43iPZoHC5BukHpa4
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:OPq6aDJvEN/bu3UhUHa+MaRIjcC3Qzbuv+fcEEKOBzlJQSfyjHjwALJmUckf/W6NncmxkxZ/NCedxXGhz3maaGRf7vJxG4st9SbbUnpQDtyj79o7LxdOWFLDIiIvqU6inwfyNjqZ3GSeusmtHiIi7ZwjDMeCNB6+HfHTwE9dJV16p62Enb/Lf6M50jLCLk79Fn7XasgN+NQi/yhCGlOnbgNw1atYnn9EbBGOuduAySq8IyzwKOIkVGGsJ8LHeLOfzzI8eypR2GIlefFYrHz7kGBqqoSUBGrozv3KYlIwDiQtx615WHEKK31dj0ehNh59to4BvtXkoCpZsPJRt+/Owb6OI6Dk1SLSJPdRc6kOmWcyOxdezufUxl2TP1PbAZc7mNgE6OP1//w3SIEFgtHC57TmrwVx021ULT1/fTQVZMbbZM77hTptnETgSxjdRFzDQQMOT+NcUbHGytJWWHbrIQ==;5:Edd7Jliet7LwwkJvHhjPSuTkEWOntoyM0bijeg4IVVofQoc1jtQrxcloIoj2GKvCur+8x/lsygzY8O3uaYKxG8RtjODkGmqB0J5nsawdYAsMR7qYfIVTdVCu3zI8ni0+ECok1vdl+rcOnH9cYo+S7QodKUy6Lby64jEJ+w8T3EE=;24:WMzdGIeMMRDKGzntS1WLyttCH7oEEyiFtuZNajPco28+P5pGyFhBy/cy/J9zz/EG723Y17Ejq6Z8ct2aFLBvYlmlM/+t36vn6bP87fCxau8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:jrxFjpEw0TLy3ebXyOFJTycwkyxsbJqxYk3l/41ySmfaJ+SEidmiacHXCi1FBqeFlo3F7CPe7/oZxDBHYwScu9f1cXO0gRx9meZl+eo5mZdChPJRmb6xl6DoRKoRXRO/VwiWWk1H1bofFAHd8CGdLMmz1w9gs/sSCszhazx9lNnjxAR+D4JXP+VOl1hjtn5uZW5YA/0M64bSp12+8osaHmTQvdEz9v0WgO01jYlx3a8+YhC1PWUdex0r1xBQh/6z;20:lZkg9lYmtzyh5be30nTeRzZMn93+BobRh7uvmXxrv0tF7VnPwLM9l0DXahzBqzwIwsAN6Z0FIRqL8qqK0tsmNd8VNCNQvTVT5ZgNeN51b7qfZDy4Vxfn9O4bWDE9LC9uN84MhNxbX9mi5VAjCajGQf5Mzr9VNgrqdtRevA32nSk=
X-MS-Office365-Filtering-Correlation-Id: 038b5d42-11f7-46e3-869f-08d5a9dca417
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:12:23.6978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 038b5d42-11f7-46e3-869f-08d5a9dca417
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629556656569038?=
X-GMAIL-MSGID: =?utf-8?q?1598629556656569038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Organize the function in "if () goto err" style,
since next patch will add more "if" branches.

Also assign and clear memcg->nodeinfo[node]
earlier for the same reason.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/memcontrol.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index acabea274cc3..38523c8ea7c9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4326,20 +4326,22 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, tmp);
 	if (!pn)
 		return 1;
+	memcg->nodeinfo[node] = pn;
 
 	pn->lruvec_stat_cpu = alloc_percpu(struct lruvec_stat);
-	if (!pn->lruvec_stat_cpu) {
-		kfree(pn);
-		return 1;
-	}
+	if (!pn->lruvec_stat_cpu)
+		goto err_pcpu;
 
 	lruvec_init(&pn->lruvec);
 	pn->usage_in_excess = 0;
 	pn->on_tree = false;
 	pn->memcg = memcg;
-
-	memcg->nodeinfo[node] = pn;
 	return 0;
+
+err_pcpu:
+	memcg->nodeinfo[node] = NULL;
+	kfree(pn);
+	return 1;
 }
 
 static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
