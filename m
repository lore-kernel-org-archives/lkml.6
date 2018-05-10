Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZpXhuA6WUR+t2LKRDs1GL8PYShHkT6atSYuhmm0ZUuK1ogqUYmyW+mxc9Dzd6WYOR47KAS0
ARC-Seal: i=1; a=rsa-sha256; t=1525945985; cv=none;
        d=google.com; s=arc-20160816;
        b=jz8H6VmDSF7NHdGFppEz454YcifQUrWb1y3RmOf8r77tU6R5nRCd553+oLGibfniT+
         AOYuVXPnkMhe+5k99tRwvt58e8qTj7vOHA42bmn6+f/YR1PSHngVq3mvNbkBqYTxTANV
         FMvAjMKp++JvHrtoY8ncllKCNBMG22TXlLGTj1ZwVlUE/Rx3MPWLu6z0ZkxGWzyn1T08
         n4g7Lo7r3B9pc+WyUFI31tyRhO/IxKF/nyBi6uQjirBlylA2HwcH+Raq3bz0xha65hcl
         XXarDicPRizYXTC3ek2BsPIkyEEngWs8trUU2b3HrWgYe+qUPVykNACA7oIZVtga+st+
         99GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=ZdtmdxTJ/MK4qbZQnUV0snIHkiYYUda/wopTbvNwoCw=;
        b=oFsBGOSWnjr0nhV43I+Vn7spxyW3++sBnI8jC5LibEmOf5r0Zgi17+Yvie8C0HR0k0
         IZtRo8pOcHXi6k08qmArMurlSxTI4X8KeScDquB63skxZtf3Ncy4I+Hr28JnWhi5pHzN
         LYzO1rBPplj/YCcVXbM6+c6jOqCrB6QVAlZfdMwUaYlbHIWOGWU4lxm6N36FIi4bJ+5a
         tI+Onr7jtxPUe0F9w1XBbMeLzYp4xZYD0KyCc2WQkgjzI58ZMaISPMmzSlbmslYrdEk3
         bcvQqVSA8noXadAHhbwobEqUYF73IiI8atvrUMJVX2Ib0hDqOJi6uXU2SJNWKKv0eogd
         kiKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=R9M/AcEC;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.99 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=R9M/AcEC;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.99 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v5 05/13] fs: Refactoring in alloc_super()
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
Date: Thu, 10 May 2018 12:52:58 +0300
Message-ID: <152594597832.22949.9366506937000436227.stgit@localhost.localdomain>
In-Reply-To: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR0701CA0019.eurprd07.prod.outlook.com
 (2603:10a6:203:51::29) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:R+F/NJ8Uex/3uZiW3EXHmcPIc66/eXT7CNCGAiuaYY9fjVROr4FBQLIl2KuwlEQxIya/Djf13X8X65YzKHLtqw4v/s5EfCwnJbzpll+LKTsVwtEjWCzoB9AxYLjrwy7vkOYfdREGP7N5VGweJWaKq1IlJCLDBTsf3a1RUWLzJxzx/57CjWuxaVZGa3TqsZJvZi/ZIpJonRFgSl6Y3xaSqaFzOnZ9IQHVDxDZIWbwClw8ME8g3CFqRyi9ltpGaEvp;25:BeSRiroViPzfKatnWvRYuLmopZuQU6q4asJeHhxGoQDW+vSLYbQbpDssM5HGfbcHA6u0mG+aytV4B5karQclmKMzdme5fJ79jtvwBRhN4WaLR0CnaXs6sL0Of8e0K7Y/9/REYLrpMQbwWjqcy/tYR7gtR4UGfl18g7rCxl8wGTSHc7smRP08v0+xVIYD04V0E1Qey/+SrEv/Civ/3qe5W/MxuD3L3WoB49xze0752UnnPPw6pn/JhVcR8RQMb72AaSQSAwry7VbfkGU7yUd/ylnzucSwbPwyCShDXNk9xtxuGlc6602CliOR0GxSMHPpidr8qnjMxUwxZNw2GJF7tA==;31:bwRA6OQGPeEuAHDYQkDFia8xr4JaEuSQLu50Q2o7Qlo9xpslacRBuMkTUwkSSEoeyMF7hwGkiChjwBnU5JtX0g6/8ZMRenhDaYqoHoCbBCj8XihxvKluEXKCKheN5gmRhHPn9deudfchQaESpZ9RL/MYatZGbM8Pg/t63P+o9eZZrJ1w6k68wmJLwfg9sMYumF4N7guT+nNb3R8W1FSrPm1KcF9GaMrpX7ZvAaDhen0=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:JyRJ1IjGEOgbclxYjD1mZTBBYiTwQNSs5VKUA5tK0d6Z6BtaAjHCG695JYbQm0r/1PeccqvIWaB5vKAfVXtKsMBmABEAPysU4WxsG/oZ5J/rqyNnBPSl76gVusr/GrQo5yP1eMQAi4cui25dmHMN0K3y7lUNbhtMgS+smLmhZub1mYefGvYSpPHfzyPyK3Z6d/ry/0YXjR4tqVkpXHZEac2vGJFYJV5q7sIn15ESHjuqfqe39+l3xFoBYG1w9c56YkLkgCQNQDTcDNDyVVPAI8qWOSn71MaUVWCxA51vPTOEamWAqzkpYhjWfHqvVJdWL292/+0+8mc/BbNWyWb+m+gkw5olqWz9aP43hXYbozaat6rXtbUKufyWL3MhUPD88/0t8t8dx5JHmKqoSrZqt/VAKIaj/3wHLRwZY+414eSKUrrrm0f+zWC6isuHyikgwlIGxblOijnOgGcHe37El02XALntQjF7YQvpXB/AQH10DNAeIZqhRM5arWXnnjD+;4:Qr1S0BGdguIvFOhDeEZXpQE4WDuwbjUSAiWTpgGdx9o46GQib84Kne4lWM9gwKXiHQxbjP8dElMK+3kAfWLG647+phB8/dVlDJnUuvZw9lM5xob9zw/gTuIWpsIxxDbeoEppCjY2H2muAKPJQOTn+AeBmfG+e9VP+1fDl0U7hSYCQEkHI9Ev4XBUPQwalpGVXUOnSVsgAgzhh1jUZw3Jo3lVL5Num+VmOUt9bMsg8TI+U0i3FVtbuAcWXSublyP8QugFRlBHkp5edLH+UY05Sg==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13326A2018495BFFD299DBE1CD980@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39850400004)(376002)(366004)(346002)(39380400002)(199004)(189003)(105586002)(68736007)(5660300001)(66066001)(3846002)(16526019)(61506002)(50466002)(2906002)(47776003)(6636002)(7416002)(59450400001)(103116003)(6346003)(76176011)(305945005)(55236004)(6506007)(386003)(81166006)(7696005)(33896004)(23676004)(186003)(486006)(26005)(2486003)(52116002)(476003)(956004)(446003)(11346002)(478600001)(106356001)(25786009)(39060400002)(97736004)(9686003)(316002)(55016002)(7736002)(58126008)(53936002)(230700001)(6116002)(8936002)(86362001)(8676002)(81156014)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6dUE3RjlYN0Q2Z0l5M216Z0F6cUtWUzcw?=
 =?utf-8?B?RGFtRVBQWlBNaDNLdE0zVGtMTlJWd0hzOE1wdjZON0h5VXk4eExzRWVZUkZQ?=
 =?utf-8?B?VzRiRm5VYm9kVVJXTXpoN1RUYlFNSmVHNE5pU29TaDBJaFF6cStkek51cVVt?=
 =?utf-8?B?QVNXZXdQd0J4UWxPU2JCL0gvR2pQVnM1OGNjWEtsM2Z6RkZlY2orRHM5T2RE?=
 =?utf-8?B?SEozQ2xPMTdYRnAwZlNSRVBMU2pIazhMN1R3cTJQVHhrQm9oZ1RRcEw3eDRn?=
 =?utf-8?B?NDV5RlZBcmViYWZXYUZIZG5PaVRjTytqQnV2am00ajY1cWZjSHFzbklEZ01t?=
 =?utf-8?B?UzlEeHpYakVtRmN0dDJmbFp3dUdtSDFyQjloR0IvUEdablRUMi9VbmIxbEx3?=
 =?utf-8?B?Z1FwNjF5ME51MjhlR1pyKzNQbzdBODJ3S2tNNnRoUFIyVzRxU2szcGxqanNV?=
 =?utf-8?B?TUduL1g3UUxxelB6VkNEdnZ2ajdQMVZ5bFNlempRdVptTFIxYkVuVjBBMDVR?=
 =?utf-8?B?bmFVL1BJQVZXODhLM1hLclhJaWd3S1dJeDFMa2g1NDdKM2hqWGU4VTU3MVg4?=
 =?utf-8?B?SW9ON3ZSaThDcDArK3drSGwrNzR2emV0ZEJMdkliY0x5QjZBRzM5aVRtY201?=
 =?utf-8?B?SEl6RVZpa2FCc0lRRXdBSk41c0xwaG1GZTNYbGlWQjNWa3ZNM0ZmVVNqTCtK?=
 =?utf-8?B?OXpiTC9PS3hzbkpZbkdrZk4yZjVPOWlGY2NWOE5pR0ZqOUVkaW1SeS9WV3VM?=
 =?utf-8?B?VUMybDYyZFE0QU8zaDVTNEdNQmFjKzc4Z091TE9EVTlmVzAwbm5mQktOQUZk?=
 =?utf-8?B?WU4zVHlmVkNaMm90RGRkRllEOFZ1eUFzS1ZLVVFIWktqcWVrWW52T29uUFhw?=
 =?utf-8?B?ZS9uOG9sVGpnUVNCeDQ3RnB0K1dXMC96cEhLN1FZQ0lDaU14WFNKMzBFaE94?=
 =?utf-8?B?Mmx6azJnLy9BUlRvUm1zc1dVYVU2eUhSZ1oyRFU1aVpBNzZBS0FhNmEvVis5?=
 =?utf-8?B?TWxVYlRRZjVVWjlZVTBLVG1yQUQyLy9Dd0hHWEFyNk5uTXpsZWFrSkVMYjRB?=
 =?utf-8?B?TjBiYmh5NnJzckduTDlpQ2hKL0sxUDRjMVF3c3JCTStDbFp0Y0VoV0NhMHFB?=
 =?utf-8?B?bC9XdW5PKzU2eXF3eXRUeTBad1B6dkk5OEM1V012VCtiU1ZHbys4NTQxNGxk?=
 =?utf-8?B?L3BmVXYzU0F2UGRzMFE3N0VLSlJSenczTDVtc1l4WWxsZlBtMzJLbFZVeko0?=
 =?utf-8?B?cjhneDltcWpuZDdqaUZFOThqYWtqTVVUbS9DWjhjYnNaak54Q2s4ODIyNzkv?=
 =?utf-8?B?dmJmbExmM091M2RoRURseW1kU0tIVGJhVUNDeWs1N1FzY0VxODNUMWhMT1NM?=
 =?utf-8?B?RnpzTGErb24zcjkveEs3L01HWGZDTm9kRllVV3Z2UnhUS3FJRFNzSktvcFZC?=
 =?utf-8?B?d08vYmNYSHB5ZDRNUnRlaGRWaGt4M25QMExFT2FOSEFzV0lqU29DV2pQV0lH?=
 =?utf-8?B?blVIWkxkUEhBUjYyY3hFeEUvUEljcGVaRnBvdnRaY2xPcjZqeFovWVBtcHRZ?=
 =?utf-8?B?b3I1NEZqRW9uNEhYSnhoc3d6MGdWczBtUXZXNnd3bW9CNjB6a1JwVERBUkhy?=
 =?utf-8?B?TjVYcEZ5cHVsQk0zMDl6RXpEQ1gwYUN3SmV3am9WSi9MVUY3czJSb3hnZnRE?=
 =?utf-8?B?d3BjdWkvTytIMHNQOHdZTmdYdEVCalV6eWVNME45R1kwWU5kT0lUMHdFNVYw?=
 =?utf-8?B?dVN0QmR2YnRkYy9WUTBzb3pSQVVIRkFReGN6UWJZdmEyS2lYOHNtanJDandY?=
 =?utf-8?B?b3J4bXlmVHBLUjRCdjNzVzRxSjJDSm1NVk8rN0YrM3g0ZU1DUT09?=
X-Microsoft-Antispam-Message-Info: jGWOGAG9koGbXafefUnIAdE3nB1NoOC3vMUsFTKgzs137BlENRp76Wl7y3ql9E7dCP8pPQWTlej48gQKRNYplg6Bn+SQ3ParV8g8fDRLNsQpv9HGKgT3y0/XjEA+wiMFWUKKVVGc0Idufz3SfH4nEObzNmLRL21cYKHW1lSNH1N9d1crAOP8A8yFVn8xpdtu
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:R8KD+WMzklyHJNfVWL4/7b2nRUx8byTltGHs4sx2rJ98dEg6aCc4MQZA1UOieOx7+b23k3GW8knWy4mz8469AZF0/xmrpPC+VnmZEfNLxipLyCGir3wRe65jnsYLFB7oW4Sl8oVifSXAEwaxgyq/8Gpgy9dydtZPo1Eg2HOUjlEvne8uA5grbz+6WoVdN7BOFzjzsyN53zLW6hj13x/7xRtCsl4F7JFpwq8ZlFGxZjF74U+DZO5Kb2ItP3UvNF2WDppBy7v7fWsvpkE3JBIlotBVb2f30qp9Wuv9xWUWuHx2Cb5za+PDZuFGIxMyxcUAk5TR4/6kqJ7QtYBPr1Ibqe6l24Zczrp+m1pak2jEb1fkanzCu2LG8KLPaKZIEkbOzPiPv1xJnmWIgQUglAeOk5FRs/vzRJMkLOY8+cHy6xMhnNUdTZCCRLjN2/0pDjTzkAWlFrcGAOD+IC6vc4a0sw==;5:a8jxEiiqPBLTwE4FcnUlzMIl0CEGcFJ2edVmFUe0rfXofElN1SdwqbcR1l5L/4yO2RzzrwCI1fq2jdZJkMUHp+OyWiLDIPkYIeoQxfLs+3wj0FE262kMptF7PbthiJ/a0P6P6popyPsn1Fd0MYWDdzbqHSjAywny/NSTqXXSXSg=;24:rQKQh06PlMjhz3kPHRarPG7KJqtwCNvuav1L4vWzcDIFIGlOVrc9HaYjBRkbY+xIC7wCxbl/qQsSal1jU3DYZSBo/NitGX16Mfjy1/zOHxE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:kW9Ckvk1F16YGwneAKzDbm7hzJyescT0SaYDcSGLVPo95dFbyC2ZolxMsY7fIo4YMtLW9GcPymOTW/cxmiUE6EFWVmyiOMr9tpAyp/ddrvtuIborJjpuTA751UYLji8nCBykkPUqYZ7ZixK0tv2nZoj+sXaT3DHDEAlsembmxH5RlFQ0iRxsxzRDvjJ+cVJqQHncTpsWirA2/KMxa7DoU+Y89rZwKBbrJ3oCy/0cN/GfWAfjno0OJ1KVrUo5zmJl;20:nnguDEJdbLgf0UpWLJdEpUwLL4lWUtjGWpHg2fWctHxgh4EehwIinxYmdMO5wjygH1dja+BWGVKGhKNCFEuqd7/SyFd1/C7fQtTiO7cSNCgHqx/We8LotdOK4EmNeFO9ltN+dfiOpnx+s25XU0IGQJdZxkE6Gtr/Nk9rBOnazGc=
X-MS-Office365-Filtering-Correlation-Id: 75540c30-8f4c-4a9c-88dc-08d5b65bd185
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:53:00.4200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75540c30-8f4c-4a9c-88dc-08d5b65bd185
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070338094290002?=
X-GMAIL-MSGID: =?utf-8?q?1600070338094290002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Do two list_lru_init_memcg() calls after prealloc_super().
destroy_unused_super() in fail path is OK with this.
Next patch needs such the order.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 16c153d2f4f1..2ccacb78f91c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -234,10 +234,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
 
-	if (list_lru_init_memcg(&s->s_dentry_lru))
-		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru))
-		goto fail;
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
 	mutex_init(&s->s_vfs_rename_mutex);
@@ -258,6 +254,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
+	if (list_lru_init_memcg(&s->s_dentry_lru))
+		goto fail;
+	if (list_lru_init_memcg(&s->s_inode_lru))
+		goto fail;
 	return s;
 
 fail:
