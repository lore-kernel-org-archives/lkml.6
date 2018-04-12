Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeDLOwN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:52:13 -0400
Received: from mail-eopbgr30095.outbound.protection.outlook.com ([40.107.3.95]:18907
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752917AbeDLOwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:52:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH] memcg: Remove memcg_cgroup::id from IDR on
 mem_cgroup_css_alloc() failure
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Thu, 12 Apr 2018 17:52:04 +0300
Message-ID: <152354470916.22460.14397070748001974638.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0375.eurprd05.prod.outlook.com
 (2603:10a6:7:94::34) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:cze17YHZ2a19mBDpl+sr0ET/oHZDgVy2S86Kf32jpFavzBnq7AKmJTxCm+SpW/TWuhQrdgzmAVpV1Djp+eRJUgRdOdjSj6yH0CFkVv+DMJsm+7CbjRuonHM5ulh4nxcr3s0A1pdbyP0FRUBFYrwft2b16flEyjxs55O/woGZLPmxL6sCStOe9DusayZidUUdCZOizaAhweQU++z/VRCN+YcVQUi/OMq8mt709PSkPi1qC168P1pxyQTLW6qs7+qe;25:+uVJaeKmChBqfgaooIUoJnKdjlIsULuGGcue2RplYvVjJS5iCZWDwpDUFeI+ORoFTx7AuR6oSJfjDGKjyRv5TGA2oj7HVCQp7jowpaqjwN5pRPD5KkrOHEcpkyyFrTfjVLzENBIvavVP6quFESNHU55OelvKicTb9DGWuxvHWS2joWZmo9qU0e/CWd9YWIgq0fTXOgK03/MgWlzZpvR9dzcR4WHyxbTOiAWmKAggd1tugNZRI47n8X5vNPW66+FgigGz/UgYXDXTv3ErRAA5rEOBdqPb+3sZ5nKUGAvOWhYYkHycoFgpxnDPQwW7NJOPQNdF3K11H1DBeOJ4wUCfhA==;31:RXtANJov13fQYjXv+W1p+vtUk+9R+a8PozSkRpe6OweZZWAsA0w8qrgAjMm1gWVu1XSOO/rJeBgc8pzuNDbX6laBkUfN92dEb8ByE8zi5JTN/obbEO+JhUrQ3+KKt0Bj3GcC6tsYDvhFcUOhBdggD+P3o86YYnp/MGSLC6u3RST3M0hJwLKC2r4moN1n8CJdN+QEq0QDwzkFgewexTwzFqGvl/bwlhcqG7vaXqRc1ZA=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:8HSelcSGxWtk2yG/cR2vadx5cwJWCJv2BqX1pZLDBtQ+I4GFEqiH+N5CFsk/DSfUoQvN3rY40EKkbViNGIPWyn313Si6Nhm5AJ2cv4oe9bkvtXSGLkhFmvL+WlZss+UeTHQZsnr9W1UOHpnOA1KZDfDX2W7WxcuiGnWfGBFOR37rOiRXoFKX2lQDWrhBQFTMc82uFXbflz7b6WJhr8+ov7x/SRXrdOVAI13Flmo1fWOOCzhHsQvOmy6Q0M3N5SHNBV4mtBtlo1lRLuvTFXwUgDVWVTKaNkCvl9+QIGu58H3X4O1O/9VXPSR7Lz/Q3wCmQSp9Fe5JCTfKdIvCLOB+6dmK2HkPssB/7qtHfvy6X//VSsK5OUz18KPv+g188GEsBIZbdIFZnnv1kJXyETJj6mH8ZYdOxkt23t99vtLe7VlLs6IVO66YUqH5DIrkqCiujO9Yr6OUpDapyg1BPklhDquWSem+VuZ93fy7qnYBYBNzMKasiH+/WBgloRDd8fJK;4:AHDKkUGlnlPL1VpZMEG+oEnx6I/kmPRY2DX3WOjR1nYiaKemkS1rrcpgQqxLwyj6qMFLZZVbJ7Pz2jLMpnY8BQfr3gJbNbsea/UDL+7oEZs37GEGbGgeHtwxRuEnZ5+xauFoz8RPIPT11cObZ4IG0x5auEetILFt8mHmQx0jEvFkZaTCISWO+SPrlTpHWl7lCvDm7aNfRBWv0A0Q87k4NnYrM4qZgg7F4gekHzdoT/OJ3SjYkKBDoLQJST0yNhMSlN+smX3RwfNnra8nzVDmMQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13382A87ACBB7410FFDB4914CDBC0@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(39830400003)(396003)(376002)(39380400002)(366004)(189003)(199004)(58126008)(386003)(81166006)(316002)(61506002)(6506007)(103116003)(55236004)(33896004)(81156014)(66066001)(59450400001)(5660300001)(3846002)(86362001)(7736002)(39060400002)(68736007)(47776003)(305945005)(25786009)(1857600001)(186003)(230700001)(55016002)(26005)(2906002)(478600001)(2486003)(486006)(8936002)(6116002)(476003)(23676004)(50466002)(97736004)(53936002)(105586002)(956004)(106356001)(16526019)(9686003)(7696005)(52116002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6dWY3Mmp2ZTRPZDdHU20rRTEza0J5WVRm?=
 =?utf-8?B?QVlFYWUzeEtGbytUQ0t2YzVhTUJFM1JhRTNYSExpRGJQcU4wejlNa3E1MHZp?=
 =?utf-8?B?VTFmYTIyaWtPNkUyeWRVemIrQ2FlcGlVYXVKVURUVUVQVnZHbnFNOXpyS2dW?=
 =?utf-8?B?Tm1RaGt0ZklBNDZLcHcvM014NkFETFFQcmRBdkhvTnVpVWFMYm9ySW9XbTJ3?=
 =?utf-8?B?V0NHUEV3NlljRmc3WHNGTEtWZmRZZXlrOEhtcGRZV3hLb1l5L2s3TjVENTRx?=
 =?utf-8?B?b2RSQ0dCZDZGcjlHUnhuSGpOcDNValErNkNMc2tEaVpJblNYN2lYRHhJVXEz?=
 =?utf-8?B?TDZtd0wxWDVCQzlqcmsrUjJnc3J4Qm15ZC91Q3M5Z01RU240Ly9JYnZWbTlm?=
 =?utf-8?B?VlpmTTRhdGN5NG1BcXdNTURwZGx1OWdrYVdOdE8wT1JiMjRsYUExcTJ1OWJH?=
 =?utf-8?B?VDBoTFVqc3QwajBDUVNmVmt2R01YRE51V0MrK3VKbllxaEJ4WFd6QW1Gd3dR?=
 =?utf-8?B?NFQvZXBKWFcvZmJkbFlDeGZnTndkbTF2MWxHR1A5V010MXlTWWdiYVZNZFlu?=
 =?utf-8?B?TExqbkhOeVpLclZqdlRJUjNaUk1QTi9ZUWhjb0I4bVhja3dLZW1nL2l0MFpI?=
 =?utf-8?B?NEFtbG9rakRIRWtjUHc2Ukdsa21CZXY4bVpnYThKVUFIRlhDQTAxY0ZPSXg5?=
 =?utf-8?B?aGpyK1p2NERIZjJFRE15NzJzMFFaSzhVUkpiRkpVQ0dsV1Qxb1pOV2pOVUlp?=
 =?utf-8?B?Zi9HT2g0a2lUZGtDa3FqWXFsNFJpUDdub1R2cXJYVFZuQ1BxckVFc1N6U294?=
 =?utf-8?B?a1ZISHM5SHJ1dUgzdm4vVW15WVZ6ZHgxK09nUWdnSDVtUzJRZmRlY0xqdWgz?=
 =?utf-8?B?anNzQjZOWVFXVkpJMnpDL0dTMllXa1Z6V2YvRWYrcU9vL1liZURBaFlmRzRL?=
 =?utf-8?B?RlZUdjI4WVVSQ3JoUHVCaStQaktldUwrb0o0VDFUcXNaMkZBVStINzFTV1VE?=
 =?utf-8?B?L3FEU0xaRmdYSmlKSTlTTlZUUnB5UEcrSG1KRnZQQUpCd2lvQUhnb3IxSzhi?=
 =?utf-8?B?UmtkRDdPcFA4SnpOVUd6N0dWMGlJK3BXMTRKS0JCa3dieHJxbFUvK0pPc0s4?=
 =?utf-8?B?Zkh5N21zNkx4V0VtcFBEQ0p3YXpSYzA1WmhIY1VDMTN6YlJvcTJDOUFJcURY?=
 =?utf-8?B?QnNSM2JoZ3hBMHN6Y1ZKS2dDQUZJbFlQblE2dXhUdExwZ0laL043bFdlTkx1?=
 =?utf-8?B?OUwyWnplZ3F3aVBqZjhsRUpycy9EM1ZXeGl2WmxzcUh6dDJSRWQwWnRVNXEv?=
 =?utf-8?B?NzNweWN1WHliQStzbXV6ZWorOHlVYWxiN2s1bnk5dlNHOHBJd3QwVW1nSk05?=
 =?utf-8?B?YkljQ3JGRTNtZkZuTHE2UEo2bDRyZlk3d0k2U2NwdWVzc1NxTGY4cXVEcmtT?=
 =?utf-8?B?NmFCWGVWRlJSM2dVQm9tcWxaOVNiRW40dGo1MExGRjdtNXNWeEFRVjMvNkZj?=
 =?utf-8?B?b2IvQnY5WmZ0ZlYxVFN6UTJCNzlvUWo3cDZucitLNmtHMWpVR1BCQ0NPQXFW?=
 =?utf-8?B?ODhucEs0S0JHaTBmL3NJRGtJUGpmbTBRVXpIR2d0NW9MaVE2QmQzd1JLbHNz?=
 =?utf-8?B?a3JOKyt4RWozZmpDbyttNkVPVUNoc05GK0kvZHp6aURMV3lBTko4eFZZaHc9?=
 =?utf-8?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 8fBvjdbv+ATPzIMUkmhjqQNAU+tM3ibvRLyWNVzYMa8xBSePK0iOvc8NCV+jHosRhE1E84bq8J2h5kEDuBNwiqrr/Dj0BFrSDPW0AAlCYWTXQ+aHU1s9w1X0238EPx4pFNJobQYrcxksR96+QPHVQofzyDlqkXW6hm5WdLmMgq2FFLW/RCh74/75Q0vSc3sU
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:etwy2D4coaqHNb2RDoUJFXgurY7zk7kzeH5Eh63h+hgnn4HQQYx02x5z+cLoCxwSwXElRiX8uZRnihWGagvzhW7I6tSVFTa/a8oro7lbjBV2lDOhQitiNP3LQ5Ee0IQQfkj+G9cKcFKpEq+11EGBQPie5nJrkWNHo/IwazNjWIFJtn1UHJ/zydzwju1swEo/4LE+zjGzgHhUuaTTKehvzcVa9zh3shjEnsBGdUS3YwEZIOfBvB5aScglOyeBxR2mweGv1c6Q5c7oipNJZTdIe0boBDSwuXXGGT2t4AVSxmgWZCaMvyjEnI74Kg08Q0FU51TjMgfZs0+4gSf4JQTsN3HFwcCNIevyaBMYjVGGluhmvQax54JxjU6m3JA99DXw3PmVcQNA20+O2VpaYoj0BueYAtXJE/vkzjEkyTPKO19LM1wcl1adi3zuBq2WX5mJ9TmP3weePAijny8yGcy+Iw==;5:uoW0VYt0UzoIny8I37MCtO/l+bXfjyM9oGt6Y5cX4xMQwwJo+EKDBzKwc/6b8AjoCqQxxvSM9akFP6hyVxvqKAgRgAgTsYNbCl3F7Yq9n5iF4XCLfvu14Yv4NyoXPvVCORluOrhyhmN4uRmuCTR3fkblHlOLc6+YszcjkpJ7Hxc=;24:4VFbhQ9ApJ+PioO0ihgXi6yUdjI49bO5vqPqc8mU3ZFPggvfdebTuSLpyb4XELPRX8TAWUAPmF9J9xW6P7T1AtPTAEujgvJ+t7b2iR3pKgs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:oBLAYgfv9wqG5O5cqnR4BX7IiF1VcJcmVNrqRjWk4Ngo+cXFdKLhOII0KSZcWKISQBMMZgNsZorhtjsDFxrLDMEqgQiiFJdUbfFV/OUetFTZSkCcD4N07Z2ahvdmuzUxFI2gVAaXnMIsQWN2Z+jawbjbUIWJT2ovmz2mEkwTZ3aDej72pZ515l0FYqICYP6BSdaZ2dZLV1A1imWQn2d1vDuNxSvgYqOpOpMNJHUmKJ8pt4/rxY9fHVimybkJ02j/;20:05rNec4++nSxaVHkjrcQOmnYYQAxSQwDMczH1qN9uS3OkusUA/Q/Xd2XtWfDhCBPxy4lRjnmeeVtOwrggnUc9yBePL12ZnxQEGFG2GK8cQGvY5P+kbFfyoaUe9HluqbcgIFA3FAsEQMB3rpIpeshcgHuJNRZTpWTUClwIBJ2pHU=
X-MS-Office365-Filtering-Correlation-Id: 2977641a-c0e1-4c4d-6130-08d5a084f630
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 14:52:06.6316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2977641a-c0e1-4c4d-6130-08d5a084f630
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of memcg_online_kmem() fail, memcg_cgroup::id remains hashed
in mem_cgroup_idr even after memcg memory is freed. This leads to leak
of ID in mem_cgroup_idr.

This patch adds removing into mem_cgroup_css_alloc(), which fixes
the problem. For better readability, it adds generic helper, which
will be used in mem_cgroup_alloc() and mem_cgroup_id_put_many() too.

Fixes 73f576c04b94 "mm: memcontrol: fix cgroup creation failure after many small jobs"
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/memcontrol.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3e7942c301a8..448db08d97a0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4263,6 +4263,14 @@ static struct cftype mem_cgroup_legacy_files[] = {
 
 static DEFINE_IDR(mem_cgroup_idr);
 
+static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
+{
+	if (memcg->id.id > 0) {
+		idr_remove(&mem_cgroup_idr, memcg->id.id);
+		memcg->id.id = 0;
+	}
+}
+
 static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
 {
 	VM_BUG_ON(atomic_read(&memcg->id.ref) <= 0);
@@ -4273,8 +4281,7 @@ static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
 {
 	VM_BUG_ON(atomic_read(&memcg->id.ref) < n);
 	if (atomic_sub_and_test(n, &memcg->id.ref)) {
-		idr_remove(&mem_cgroup_idr, memcg->id.id);
-		memcg->id.id = 0;
+		mem_cgroup_id_remove(memcg);
 
 		/* Memcg ID pins CSS */
 		css_put(&memcg->css);
@@ -4411,8 +4418,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
 	return memcg;
 fail:
-	if (memcg->id.id > 0)
-		idr_remove(&mem_cgroup_idr, memcg->id.id);
+	mem_cgroup_id_remove(memcg);
 	__mem_cgroup_free(memcg);
 	return NULL;
 }
@@ -4471,6 +4477,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 
 	return &memcg->css;
 fail:
+	mem_cgroup_id_remove(memcg);
 	mem_cgroup_free(memcg);
 	return ERR_PTR(-ENOMEM);
 }
