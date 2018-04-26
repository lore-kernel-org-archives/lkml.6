Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755466AbeDZLBD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:01:03 -0400
Received: from mail-he1eur01on0111.outbound.protection.outlook.com ([104.47.0.111]:58811
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755352AbeDZLA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:00:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 2/4] exit: Use rcu instead of get_task_struct() in
 mm_update_next_owner()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, mhocko@suse.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, ebiederm@xmission.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date: Thu, 26 Apr 2018 14:00:49 +0300
Message-ID: <152474044955.29458.13116121113099868575.stgit@localhost.localdomain>
In-Reply-To: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0216.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::16) To DB6PR0801MB1336.eurprd08.prod.outlook.com
 (2603:10a6:4:b::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;3:IifCW+/0zXnjXXL2RuHKc+U98GmkgOG3HcN8BfPtehbkzdKz1ytz6ywSpLG6aPrz8sK8dEjb6/KzHEbdb4ZqVrpG6PR+ku4IWnBSmasKTdIbhBfS+kczhBl6mE2jMDy+z4FhVe5NG1Aml6BQJvBBCe36MwKAnbjhu6VP+v+yfZv0lOWsjYwyktiHCi6MEOHJSX089jOow0FYEisCdjwyeBU6kLqGwH9GEFP17CGWXWM6VQSVjIRfxsE7+9FUq00X;25:4rahfUi7D43C6F1vz7FlKRBq55m5Y5Xwz+w9Nktg29KXAC12KvGFccvoaqOjFC9CYnTV10E3epy77yF5Eqvpejnm2SIrCPT1LuMg+mSiorFXy/IjOyi5S/y7Q3Gaqbn6xBwhchFxLUCJlurSSpO2lYFo5SC7m0WYsyunXYoSD9DbEkTUqgKr4SeoFgqwfD6KQiEOOywLoqawHYmGqcfj6FmZV17ZO6RQA/MgB8zeQVC9TTVHVoaEibboyYmN1CzG6UM5ZTTsD+kdzPiwMa//vT8Comj9iYlBFens9c2Me1wb0c7ezto9dx7Vprwu/NEh+zPkuB9qixDoteBEBxHuaA==;31:VT42obBAKv/XjG34XdwZGdshHKKq0YteVQkESd+Mhp30HIpP4aHH2/8mklZH/KkJWERsdj3lU4Q4hG2WopL0SfzZBK3cA8mKifVXpCza9KfzaXh51GyrovMCvH87CVndvEWyyYyQUROU2/kXzXE8g8yjc+FfndT0OiE9mzRxKH3nps8RA5ef4VZ0DTDJNHqc5flw3dmMUQ3MpLrXvuyg6DANAptRD5h7J2k8bQoEBIE=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1336:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:abxh+sE1Liplb7zwoWdkuWJq4ulNBrYL2I/bYizGoHQv/wL04Sf0f/4SLVSOSe2f7SK+C7ob8wG8LCZwjZQERjZN+VVfLnnVUle5fwHycLhdSVj6uIOMA2r9KV/PoF25IQlD2S775rlKhOuI2Sg/zm1xQT8NRoGX3cnwrjY7FUOKzchaBZ9DaFpkG5WLIW7u/ei7ltZUHObRoNon01iXTIRiv50UEKYeA9C0p2BVWS92bE8j3v9SoKUCjd3kl3HvgjHhh9ojmRRtGJuB3dQ5IDzFDmMFcvGvm6vs/HFygUqMKfMeNBYwHAzTrn1m3O0Z+QyU/zlX96b37iM2T/6EK39A+69HeS/Sj0GipmasxxquxqEz7eW+GkEbES6Qu4gpvtOE9ZAMRQP8x4XuRth5i1pYpITyYbTvG6tPCCHA81wiLivp9jSsWZmcgUS2F65d9dImpHHPeylsO3Oh+MdIkMoO4QVNaW4kIs/98Mw+engTfQr54RdP3OCYkadwDiK9;4:XxdV3w0DeLH/uSweaxXG4sXM5iLLbo8xzOhzXS4Tb3wcivi8nSepJ2xicjUGsIgrNsEqi58YSwX8Ip6JJtIyQord4C6EjrYvSeShfjTv5yaGitlwWftfkap/jHLKkHhhp3AHuXO9fWjETg4OeR6RK4+bD9Tb2cwIWqh7s7b8YWfvhj6qAiSR9ji+LHQlMu87gzxlk7l4exmnbaoeJ0G2itN/LwRpiCXr/TSYTkVQ6AmMcgDeLwnd9pfQlZtdx29AI8G85vXn/UPjcjnOV3vyJg==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB133620BDC46A0A9D3330E8ACCD8E0@DB6PR0801MB1336.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR0801MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1336;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(39380400002)(346002)(366004)(39850400004)(396003)(189003)(199004)(230700001)(58126008)(6666003)(50466002)(5660300001)(478600001)(7416002)(305945005)(3846002)(39060400002)(97736004)(103116003)(25786009)(66066001)(6116002)(55016002)(53936002)(47776003)(9686003)(105586002)(2906002)(61506002)(106356001)(16526019)(86362001)(81166006)(68736007)(316002)(81156014)(7736002)(8676002)(6506007)(8936002)(956004)(59450400001)(486006)(52116002)(55236004)(2486003)(76176011)(186003)(11346002)(26005)(446003)(386003)(23676004)(476003)(33896004)(7696005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1336;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzY7MjM6VUhvaUFNckRva09JeUV0cm8yR1FsektS?=
 =?utf-8?B?MWhId1lyTlFCdlN6V2lSQ04yb3FhZUwzV08vSHRUQlFIaTdlcGs1TWNSNUdT?=
 =?utf-8?B?YWdtV1FYMDMxYzhBQXZSRDVLd1prZndpZjlQY3pGdGRvS2htakp5eWU2TjVS?=
 =?utf-8?B?UUtsbGxVK3ptV0FiUkQ2aStJVWNUTlo3L1Fza296Vy95VnlMZXhjSk04Q21T?=
 =?utf-8?B?RWJmYzZlekFaUFpDK0xVQVFBR0c0SzlEQVY4WXdKZ1hDdzVtbGFuVXQzY2cx?=
 =?utf-8?B?RVpaU0hVcVU3eDg3STUxSStDMTZTZUdPajVIKzNuYUFMSnlPdGJ4N3BJVFk1?=
 =?utf-8?B?Q0lZR2ZOVmtjRG5oeVdCM3BuMG9TN09BRERMOXhObEtxd1FDMXRSeEpIbHQ2?=
 =?utf-8?B?d1QyVldNRTAwTEU0a1JUekxoeVkzcU5VSVNkVnlUek55eWtlSWhOVUFSVWlL?=
 =?utf-8?B?cEViQkN1cTY5UWI2d2xIU0R5d1N4WFVUZTg0M0djaWExeXNKMHlyZ2hjWHND?=
 =?utf-8?B?cnNobEpDWVpETTkwNlNiMWU3eC9KQ1V3ck9qYXFHRTNwUTVPd3ZtVURXUDFr?=
 =?utf-8?B?UWVVVWNmVEw0bXcwUG5EU2Z0TTltZ0NBZ3NFM3JWUU9Ga3pscDhIT3JLU3N4?=
 =?utf-8?B?TERHb1hPWGp1Y0JqN1ZCdTByYXFKZC9ma0hPSk9NeWk0N0p4ZmlYY043V0pp?=
 =?utf-8?B?M2prMzArV0JaY1BVbkVYRXlQc1RPT0NZMldEdG9ucFdiV2U2eitOczhrWEhK?=
 =?utf-8?B?aElOSmNKNFRoRlV4WUVtUGxKUG9aYlR1TmRQQzlsWHdJZEpZbzNVSFIrZXN3?=
 =?utf-8?B?aVU2NEFmWGVzaXcxSUZ6S1VES3ppNmFkQSt3Rm5aV2I0Q1ArTUZSY2lTUUU1?=
 =?utf-8?B?Vm5EWXR0YndydHNIZ1pjanhRdlQra2VTamNxT2RpRGpyRnZOTkhiOU1FZElO?=
 =?utf-8?B?ODhwTEdRNHI4aE0yMGVqTGNna0FPZjZyV2lObTUwK3orbWhPVERDZmRnL1dy?=
 =?utf-8?B?ZnBBUXpQYTJJTGhaYWRvNTZPZWQ1YytWRHdYakI3VDBBKzZLbThncFpHU0ZI?=
 =?utf-8?B?b3pFaWg5QUJkMDVhQStOZlh2T0FUUkxPQStGcHNVcFNsRGtORU14eVJ4SHBK?=
 =?utf-8?B?RDV2czQyU1k0cStjUDE1VHlBT21WdHgwRVk0Q25hdnZjSkttUGNjWWt4c2Ju?=
 =?utf-8?B?SWlsdjk3WHNPc0xOTXNKT0pHUVIrSXU1T29nRW1CQkErelV3S2FXTUZJb1FU?=
 =?utf-8?B?bVFqVmZtMGdDVjRzckluVURFT1h4OGtJd3JCT2JDZzd5WTkxbitZd0ZFV3Bp?=
 =?utf-8?B?T3V0WFFXd1puaEFNYWJ6ejNXSXltVk41MnlLZHUvVEhzc2tsSlZBbXRZOG92?=
 =?utf-8?B?T1dNSzVEZDVYSWUwR1dxdmtWQit5UnhQSlF1U0pwWmlwNGJ0N2FpTHFOLzVk?=
 =?utf-8?B?Ni9pS0diTVd2ZXJtSGZhTFB3V2ptSlN0c1hSRFo4VGJiTFBnZ2dFMnNPZERO?=
 =?utf-8?B?YVNldEptclRmcGRRekxyamVMQVhScGR1RUVwdk5ZVXppT2R4VGtDeXhDQS8x?=
 =?utf-8?B?ZjRGckxaWmgvdzAxODlEbmNDbDYvVFk3ZzRHOFFmanVseDJ4TTZYc0haZGRM?=
 =?utf-8?B?d3hhZVo0M3l3VGRmalVZak43TnQyWmVid1ZwSlRkTWlEcUtDZEVQN2NGdDht?=
 =?utf-8?B?ck9rSmFVQ1FheFp2bHdleElLRmdZSDFzK0ZFeFhPVCtyRVJIMmNNQkpjQXZR?=
 =?utf-8?B?QmxRU0xXMjdQNzNhZTVFRlBQVDMvR0RpUlRPanNNMXI0NXN2bWZZdWpoUjZV?=
 =?utf-8?Q?+dY2s1ol3L2Dxs7?=
X-Microsoft-Antispam-Message-Info: xyDsCyO0xdUYU5YB21VxQ/3PnefoBmB15WNsv2Uxxi11lOkfrt7UwPAvRUDVdH9466Qi3LuGopgRqAgJ2cBRXVp1GdEOzFXKOAorjTI+SoxHR78OZ6VHx/Agft+kvFytr/4UcAoD8nunKcOzvbKps7F7WKxQPQ7Mv9rm6NJnr60/dribZe8yYAP/3dzodMEy
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;6:SDJwUrkMcg/VBuoTjmo5m0Sq6/nQicJPMFtgTflZ92NcDM8hi1itE2ohS83o/EcA8F8Cr7H6kN4z0yTfzL/aMs1eR3dvN+BJVpKRppE1ovlL/1n91ogFzs1VMpk9O4dSi1pGoS4AARRe6T7R8pjoC63GqM2OgxxUL2ORNdSSGjsTMfEQnu8SqkhQgm7c1wYSoQO9a+SPzfWZXgZRvb95Nx9VF6z9TsBEl9WBByxYTEfLgmyShq8Oz5i2VDZXe9MDBuGF9Cj1uRGpcqG7eaRmpcZ5NEa9Qh+rioKpWCpLapRBEDcAp0KDt63SD571KcF252VbxTukmD072udOiG9CnCfY1UiXRDZZzQEIIXoORoXs1X/qGSMKfUYZhKt3s50x133DE0o4n/IPqgYOCiRmQRF0hhN+1tj/tFbP1MKZ2nYlSl8cQkkHPuAaFCrYyV0DwzOCQlH3YEU3tmNFkJY8jQ==;5:dQQlvuO8Al5mLsaP22D4AiT37J78hCSH1fb5sxeTPV9kxsiDs4wW8hXaCDKBI5k3COyQY/gIPLF3dfRPebGt+2oePbnZV/ml0kZ711PCHl4BNExnh1o8v4iau/JYH94w1bsAWq0s194219mvFsvyx1R0r5K/Ghvg5Y88C73EZs4=;24:vwVZPKn9pGqVxCnMAb8x0zmTsIXdMGSN3m5DOhTMvdZfzfuCLlmDGChOFaB9zikdZD0Zye7Hc3mVHaPr6WF6BhXqoXAM+9EXoFhq2cvJ69g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;7:z5fJB6yqT3wZd63ZKWNp8hOcqT5l9Z0fuUYOKtr4/ISb0xMLBFUKSarsj4FSY6SHuiy0eKSYh/nkg76yCszwrZE7nAMTUnV6LJm6yybVhYaAxFRwPRALcOf23u6t6Pkbl/ROx/abjxscMR3Q57op349ZUhp4sre9YF/NC/jmg6RWebubGIXmp8TMf1Unz/F8a1cYru52e+AHyV2PadXrF9IyijNX+6QG77/rPtm7yfuCWHNMzf880ZO6gaVQR+2h;20:/IHkAtd/YOYkjO+neQXtVt38tJh5X2jIpSSCDIvUUyxnWEwHcfC6owYqHVngT1O4rakKvSJnmee9tV0+H5G6zRdJIIYqvKbDnHjS5RdGt1/Zwh3qm32mOq1IGjqrqyDlEBh8t3tZ7Ro9kiWp5VC422qAJS/gblSJ1guSQq8Kv/U=
X-MS-Office365-Filtering-Correlation-Id: bf06c0b3-16f6-497c-b74e-08d5ab64fb35
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:00:52.4346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf06c0b3-16f6-497c-b74e-08d5ab64fb35
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1336
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since release_task() puts final task_struct::usage counter
at least one rcu grace period after removing from task list:

	__exit_signal()
	  __unhash_process()
	call_rcu(&p->rcu, delayed_put_task_struct)

rcu_read_lock() guarantees nobody release task_struct memory.
So, it's possible to use this primitive instead of get_task_struct().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 kernel/exit.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 9fb7b699bdeb..5c42a9b9c1d7 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -464,7 +464,7 @@ void mm_update_next_owner(struct mm_struct *mm)
 	return;
 
 assign_new_owner:
-	get_task_struct(c);
+	rcu_read_lock();
 	read_unlock(&tasklist_lock);
 	BUG_ON(c == p);
 
@@ -475,12 +475,12 @@ void mm_update_next_owner(struct mm_struct *mm)
 	task_lock(c);
 	if (c->mm != mm) {
 		task_unlock(c);
-		put_task_struct(c);
+		rcu_read_unlock();
 		goto retry;
 	}
 	mm->owner = c;
 	task_unlock(c);
-	put_task_struct(c);
+	rcu_read_unlock();
 }
 #endif /* CONFIG_MEMCG */
 
