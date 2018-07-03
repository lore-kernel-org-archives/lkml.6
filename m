Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB7AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8FC21A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JvVrJdsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8FC21A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933584AbeGCPJ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:09:28 -0400
Received: from mail-he1eur01on0124.outbound.protection.outlook.com ([104.47.0.124]:49440
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932648AbeGCPJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7y7KL4Lqxbhu5Dcp8ujOrJ9wpol4rIibBu3Z/sM1NU=;
 b=JvVrJdsKZgzmWq29q5FbLoGAz4DcGYaY/uv66Wxp+jMt6pQ3tbfuGXn9TIom1Vi271t4gkDDi9Kssjq44tJ21Sc3POHPiQmrbu8vzcz47yY/Yu9WzCk7guuXt9To/RhRNGiUWryFwK8v97KJbf3qMa/oGo3S1FIuKSItpTbiIgQ=
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB1332.eurprd08.prod.outlook.com (2603:10a6:203:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Tue, 3 Jul
 2018 15:09:19 +0000
Subject: [PATCH v8 04/17] memcg: Move up for_each_mem_cgroup{, _tree} defines
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Tue, 03 Jul 2018 18:09:16 +0300
Message-ID: <153063055665.1818.5200425793649695598.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0005.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::18) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3a04258-c880-467f-c4c4-08d5e0f6f453
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:bzCgXKGixcvKnDSEuvkLo3CG5PRI1WoYxc86vhfTJ7rAqkVRaKBQFRow3/nezNF7R0t6+5yFXNmpUSAkoGaLmQliTKOyLe6n9w8OhLw2p6yuNkVrusCYz4R+DnGwKXOvZm6YW6gNDnE5kLED+EzCkrqeiEqheXQikBjtldXD7HWeISGVjWt25qQiVnV9lBq5XPOxs/eEGYwx7KkF02U9hnz91jBXVlgXKMwN1AXM0pasQ9psHfOoZASnct43srQD;25:ptSYB+mPXJJDvgp7VTTL5F4TNKScNGTm3KGwyZN+kzbf1StuiGrZu09E15wfhhMRyKcLUeD/RGY9bzHhcX15r8M47HT2uIoWsI+vbfT8YfbRTaSs0wStelL0uUaxcRzqpqxqR624scSVv3dtCF5CloyD69lvx3xw0OgOdsERUJ7onKKq5pOjSuhOeDN6CaJvcBq8L0F2LyDSxasd89a4aQ8WU/lJ1DUHOOKaF3wOHM2s+6BtqYrCP2OBrpEidYHMS39nfk2dHFz8CpVPpATUCWMH3UwXE+kHkAHSnErSw4I8fKgorTRe50HBi1ObqL7cqeGtFT+1zdHgNy0nbKb1Ow==;31:RnJy94yKMGHb+M84bR7HkApYuQQljzBbowmvxcWt9TkkexHfXQgGtKHkA8zO1Hp4AzkNSZrRIj59gCIrGTv2/+TGcvGl8vs8RrrMMbKLRnPkQs3ZIZOKBtOtgFJdmMERPBKM4XNYq+l2FjWVFgjRZ6LDLVeprsMg/gGg8a/qzMHnS+8jaNkFZHcseujI4Q8j+rkdZm6uzVZbaHvJ2nWzrOp4QsvSXBX4PnUHjwFnobA=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:zxU0DrjPcPn2fDgNr4/gR6Dfe33UXr/uCO8eCgTz5zR/GlcW+cU5g36M88+Z8Rw23qr5XzD35HBm15zVZUuf7R8toeWxi1DRzpbSG9tplVKJ31D+qfOj2eYwv0ijlkz/CtqGRJFTw06y+YeEsEtQAbJhUQmgXw94dFKD2Duh7Akwz3OqgKPkhdJc+9doLK3AliNXy0Oggt/u3x+EBLgjQ5/oE8NDXM5bqPPVG8nLif7JsXDdJeyV+rnDvjciSCkDwAxsWQ+1ejqDhvcXrXlSBc4MwEKi+y0K471LSnAPXny9D+cKHq0iOzhuPYH2ZzI/eL6HTNWHmzDABryTUNRLq3AmOIoWf1V9lahSo/kFFcbf1AzuEGZUFObVylkBFYcXLQXOMRdeJZDvMElyuOc3+hw6ODAtIaYoBuyBDpMu0m9zmP8P+Kq0mmGjq4mdJ0H2OWU5sn4eD95gkgE2OntdOSoeBA/+nkG7XcPP5d0Lzwd00NFjB8dJuIrzhdBG1mCn;4:f6wmS8y3AnccWKttab235TkKScyuA0dxIOQfzLF1UoFE/5HJrGIQ1Y9xlIRFvOXT64WtX86+PgGs0aFJm4uz82czJQ92Xwr4NSe9FwQyqHWJpkWBftR2I0JIas00L4NVi136fSTNWW23foXXOEIwTtEiXHFBiq7P5tBVWbMFbfn4tOzqcATqitFM0AgAwWcxoZtDnf2P49YFJRMb52uCtM6DNBpxELhXoQVixoaSUhldlCKGeL4jl/pkZy9Vm9AMFUPq7hZuZVr3BHtqhGFhI44IZEt5K0MO75fgVw3YtytPlbhjCoH5pV2/4H779JSYEvXlhkXOkocZQmX/ORC/r5kMfFjH/CZCt4sVPhFVzLw3hrty/GTh7Fxd08kPW8Jm
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13327C7524BC3815BB939E14CD420@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(136003)(376002)(39850400004)(366004)(346002)(199004)(189003)(97736004)(478600001)(8936002)(305945005)(2906002)(8676002)(81166006)(81156014)(50466002)(7416002)(7736002)(25786009)(39060400002)(103116003)(53936002)(23676004)(11346002)(52116002)(47776003)(58126008)(33896004)(316002)(186003)(476003)(446003)(956004)(6506007)(105586002)(106356001)(86362001)(5660300001)(3846002)(386003)(230700001)(6116002)(68736007)(6666003)(2486003)(7696005)(61506002)(55016002)(9686003)(486006)(16526019)(76176011)(66066001)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6c1BSVldCVmUydFZHS3p6OWVlRlZlTGwx?=
 =?utf-8?B?aXNtTzFFU2Y5dE9oK3ZORVpDZE83QWtkVE9vaDZWOFlFcncvNHJrdjhoVEhp?=
 =?utf-8?B?Z0ZZTStlVnlhMWpybmFYSDJFVVZjU1FFVnRLelQ4Tmwxcy93NW5rbmIycEVW?=
 =?utf-8?B?bk5vOHlRa1VvWGNHQUZxVU9YRFlkakg4dkt2WFdtbjZBZnlndWVMWmp0S1BF?=
 =?utf-8?B?cWFPTHBIMXB4cVdDNTNwNWwxYVVwZzRBT0MvZ3FXVmtxMUM2RmlaSjZHeXNq?=
 =?utf-8?B?WGpQVW94OXBGb0NFKzE5UFYwVmp3dXpZY2c4RDBoVkcxRzFMbWRZTG5sWm5i?=
 =?utf-8?B?VEdCZWtiallkMGJGdDJkWW5hVnp0SVM4VTR3djJOVHdvMFZNN2ZDSVEra2tW?=
 =?utf-8?B?dUVKc0E1OE82UWR0U0czZVliSmNiNkZCWEQ0Wjk1MWdPRjVob2xxVU9Uc3FD?=
 =?utf-8?B?d0IzZVF4L0R6NHMwZlEyUmJTRTlqQ1VXSXVtQ3FUM21mTmdXZUR3ZzBldHdX?=
 =?utf-8?B?MTNUcVZGajhjbVpwWFZYSHdyS3lGamNLN0xOTVBXTytuWmVRK3pXSi9mRjhn?=
 =?utf-8?B?WkhSbStKUDh1NXY5UGhnNHFPMmlOS2xuVmFHeEJ6V2dKMVl2OTkvbkdpN2VY?=
 =?utf-8?B?Z3JKbGQ2U2FhZU55VFB6aUhZcFFSK2hnZDFEV0YxUDhkeUhGTjVxeFJXditB?=
 =?utf-8?B?czE1VjRiT0NFU3IrRTRXYklwOVFCcE5oOEFaN1ZDYXAxb1JEZUlleDcxSzVM?=
 =?utf-8?B?cXc5UzFoNzl1UkUwRS8wWjBHTTVBT2tZRWNEeFIxeDFGZngxWVRFUXVxQ1ho?=
 =?utf-8?B?WDFFejVqblh4aXBqRUVxOWFvSERFUU40K3ZGVjlRZWdOckxPZHpwY2ZUNldn?=
 =?utf-8?B?dyt1RG9zNXdvaEpHM0J6SUxoaEN2TGpPaUNuSkM0czZCME5VR3BCTU1YZklj?=
 =?utf-8?B?SEJIS05yMFhHWndISUY4ejlVNzdSZ1RXQVVrbXZrNVh2bEtXblc4NG52bWNC?=
 =?utf-8?B?V2F2YjVzOGxCU1FrNFR0a0RuK3dUR0NLUmFaNEt2M2xXcE1xcUtwWHlUakZS?=
 =?utf-8?B?MlF6SlFuR2ZPa3BIR1VVWHppakxyRFRuUmRNYlMyR2luaEppVlpkaUcvd3NL?=
 =?utf-8?B?MG85QzZqQWVTdW9jQlRNYVN2ditINzNyNkNGTzBqR3R2eHlUUzRyRVFVU25z?=
 =?utf-8?B?YnN2UlJ4em9uTGVtWC9EQS9Sbm56VG5ybnpPTzlTMVVHRWJ3Y3NHbjVjQ09Z?=
 =?utf-8?B?Tkxja3NKSzRDVUNNV2ZVZlZtV0hUTU1DVnQzcHRxLzhDM2QyZEZaUll2akpQ?=
 =?utf-8?B?YUdYWmJibVVrVzZndW5YTkhDQjRIMVJaSzFiUHcydFpNN2c4VmtudjdxUUFT?=
 =?utf-8?B?dXFnQ0h3TlFlMFFpYkt4Sy83ZTVEdkpzQ0prNFFvdklzYTlkUGRjQnVSOVJz?=
 =?utf-8?B?YmRHdFcvcmhpYnRnZjJqcWMzQ2paamlWM2ZqQmdYVlVCTWNxSlhkNlNOUEFk?=
 =?utf-8?B?MTViYXAyNjRkQnBjTWtJNzFLN0ZtbVU2QlRXVVF5bTZjWEo0aUtyazNCUkVG?=
 =?utf-8?B?V054emdDd0JwK3o3Tmo1eWxBZzBIOGhraGUwME9TWWxVS1BtN2RITEFqeGRU?=
 =?utf-8?B?U1lSVEIzN2VSNjRtc1BHTjB0TXE4QTJTYUxmZm82bWl2ejc0eGJLN2VUN0hU?=
 =?utf-8?Q?hNZSrArOKITsDe8ki23slLKHH9Sqg4a1Ws7PAquvm?=
X-Microsoft-Antispam-Message-Info: pkomaM2l2zTZCkr7GyUroR1ktNBMPalsDWWPx50YQgkuNjKNx/Sm71C2pWapwMp1oy8YRp3TgfH4Qrl/mX0k48dQHDLSZwXvTbAoc1pD43EyD1AlUxR344HE16zPrIyvH5cqtNAJ4H2oRYSG+uhtBEAxcn3z3bIXE7hn516WDCtnhICEomiL1goTvlch6lnNKQ5zJjYElA/y9+m4CKSM8+xmxTLl0JB+B+yxe5d7CLUzbbheU1NFikGykN0Z4xFQubjK4o/3XpzjzBp78lY1Ro3vAY9ZT77b+pikvfDUogce2w6Fbxb224lUj0HODYI3Sp+pjy7OIUOpw+dl1vDZhvszZ5hFU9ZapBWaBLNdGWk=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:IUX2jA05jNuxAZbPgzQUkTfw/SNpzrZbbY2QU65jX/U2xpso6FM3hcKZ9CfjQX1WEcgB13+kvcxielvdDR1X40f6+Iiby3ELPyzt+2yEJMJDbm7Q4lM/qEdVOonYRM6ujd29KR5+Jv1b+uGT42vCLXmFsLsO2BK3k0vz8AKexD70JDOS9Yny4BUTBH6Prc+rz5d8nSV/vW1KnnVuORFkPNJfZZo2c6HZ9vSoKl94bKDFI1ggqD5fnQzXWv/xr8oLb2UAZFpoECyt/IHYJ/J+29mR4DUlzlxzPN0GauLWaYM44PdVpfSuH8vhq1Chser1TkDQvV6CINgWX30j9pMoN1EytDZonU9q6jFvXEFCWQ61BmxMaRh5141A18Au84cKXHdj8Ze3Qq/i+LHEYB72dJ+dCzIiqKj51GMpt8vCgdGVX2Ica3+W9S64YVVB47F4saKSbMCQ17GUZVSu5C+OIg==;5:aAXZSffMN9WBtW4VMhOjOCHNQWx77jc1bN67/kx9R1f1IP7WB9ZvgvITPL0YXAFopApZ14CPessDLes2x7MLzcI28O1j16YvldHMAo/JpnA2dDzDejbZDwb7gJvFFP4M5Ytj+EEeXwJ8EJIIYI8/uZow8lmsWDXOX70U2i7/m9A=;24:pHKjr5rfmkHodh+0EVN6pKxiH6K0/ETjHOZ08mzX35en8NzvA70QjIeefa1eQuQ7W5oWMyBLtTZVp0V5T15fypfDSdsiHotHTL5DJSN+gTs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:El1iXPSrPLIhC9KxmJAnz/WGUksuyZ6Hp7y6Z/gFXXJPcgijIvQDPbIvbL8gEKkYyW4HPesqCyx23pEwvJFDI4sXGAnfD7Q0GorFKMNa8QoeNV3BuritSJlmK7lZkF5KKreHBbjTGccX/FfPdJAhQZbmn53LjF8w8Am+9CBCZVswyus+kB5jSnFYmAUC8DCiGo6n8l4IlHS6KFrJYHfdSw/NSbxuqiUuHoTWFw9s1yz6FZ2KGAwk8zgyu0NHQ94y;20:OGe9meH9lEHz5M9ELZsLBkvC0RdGTG1EePQl5Nq5p/+qLv4a7tuXMwchXq9/XhIQftYgtqcWjWQ1sp0QZCtgYjQlpnox34ho1Yv5jKD8d+ulzf94T0OrcBH9Bo0wURsJ1pmqh3nv+uB7fEkbz8eIG8x9ZTqgh4DVu2aNA7rP17c=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:09:19.4687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a04258-c880-467f-c4c4-08d5e0f6f453
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next patch requires these defines are above their current
position, so here they are moved to declarations.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 31d203099af8..74247a580cdd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -233,6 +233,21 @@ enum res_type {
 /* Used for OOM nofiier */
 #define OOM_CONTROL		(0)
 
+/*
+ * Iteration constructs for visiting all cgroups (under a tree).  If
+ * loops are exited prematurely (break), mem_cgroup_iter_break() must
+ * be used for reference counting.
+ */
+#define for_each_mem_cgroup_tree(iter, root)		\
+	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
+	     iter != NULL;				\
+	     iter = mem_cgroup_iter(root, iter, NULL))
+
+#define for_each_mem_cgroup(iter)			\
+	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
+	     iter != NULL;				\
+	     iter = mem_cgroup_iter(NULL, iter, NULL))
+
 /* Some nice accessors for the vmpressure. */
 struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
 {
@@ -913,21 +928,6 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 	}
 }
 
-/*
- * Iteration constructs for visiting all cgroups (under a tree).  If
- * loops are exited prematurely (break), mem_cgroup_iter_break() must
- * be used for reference counting.
- */
-#define for_each_mem_cgroup_tree(iter, root)		\
-	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
-	     iter != NULL;				\
-	     iter = mem_cgroup_iter(root, iter, NULL))
-
-#define for_each_mem_cgroup(iter)			\
-	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
-	     iter != NULL;				\
-	     iter = mem_cgroup_iter(NULL, iter, NULL))
-
 /**
  * mem_cgroup_scan_tasks - iterate over tasks of a memory cgroup hierarchy
  * @memcg: hierarchy root

