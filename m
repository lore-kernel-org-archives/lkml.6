Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932440AbeCOQqp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:46:45 -0400
Received: from mail-db5eur01on0091.outbound.protection.outlook.com ([104.47.2.91]:63912
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751770AbeCOQp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:45:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH 4/6] mm/vmscan: remove redundant current_may_throttle() check
Date: Thu, 15 Mar 2018 19:45:51 +0300
Message-Id: <20180315164553.17856-4-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180315164553.17856-1-aryabinin@virtuozzo.com>
References: <20180315164553.17856-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::22)
 To DB7PR08MB3257.eurprd08.prod.outlook.com (2603:10a6:5:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cba814a-6c31-4a14-02a2-08d58a94377d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3257;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;3:AFAWvnVNV3C4vyXSX9GExi56IfWTfMuNcro2nVSzQmlWLoOHo0hH6kprsNYt3OS2ACVGQUwqM6KP3B0QCc0d6KUsUt4clotZmu2Ioc36bTBreAn+6JmvZilaURIZdWkL7Qcyv4J3kDc12H17OgLQfaYysbMnySKqYyN2fgj0Q3msmrlDnYDrrVTd5QsSAndFTA26kDKm9dlNum9CKAzW+LIyIGifRCWWJnRsi+lrZo45d7WdAQQJ+DuMRU3rQ6Kq;25:htpnFfXkDep93WFYNdYEs4jsHPCA16DSOS5aKkxunKkOG9JztfmHjwJExnMtA44JIanY8re06Dsa6vFgvdDCziMKB3vymjbVkkPeVhN/vjKohfwciHVe47trA5CHUQDxFgj1Um+I/AJ9A0VoN4pl5Ublk0UTcXHQLOou6V9b90bmgIEk9qSHlT5fJb5lQ62vbPIlQLkyvOpoGvnnl9ojkWDu8IFe86CH8ECD52JIUmfV0kld6qqtiWoj9sP7OlJ1U0qVaUHGWfU0p4qif7mgSakXw+ny6OePWJrSmzWBqN5fBSlaI+MHLhNTiDeU+svLJcZOKDrUSvZ/Kq69Jc7BWw==;31:9ZYbI9dPvtnbL5/9TSiunceDT7iyTH0S62d8TruEfU4tNUkUjqyOdHcTgiCVTJT6u906c3OvHZPgpdONfamMeRVWa5miOKDoPIDTXehjEY0wIYdtgKyEupy9HCK723UYhg73IFW6yxMQ8xnaQBTPGkzAh8mP6sHfKAzgms9TfHNLAlBTFj0+PJFe0fv1es+mSGny1i6c6sX4gBTM5YvdzwOT0xsh9HxaVMmMWyFkwFA=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3257:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:ez54tg/zIcRVZj5AeNnaRfds0r1EkWs2dmeH60pqFKYmAYhpuCjfchfhX7W7ukt0TFyTG5+QsGbT+m9HulyDHEQTyftaBAIRIfEt2fUqHxV9KbMqPu2pWl5BVoQrApJyxaup/jido4n3C25n1bfdziZBmOvoUdfzPfNzhb5x2j72yjetgnZi+A0o5dG85FaLgZcMUIH5H4krm9/E/XNU4cwpM0FvjJXwaBlEgw9CBGqSEICRKwmJmaBZuAAV8BUENbzFcdUnFxU05msBIbSbcl7ghwlNhJeHIcJhXqJ1Hglh53DP+K41z0/2pQTHZxRYVh5CpttR8eIhJqguV8mdCkt0Xsl7AOGxyT0L/zJ+x4BxVBpmXzBkvqvs3kU9AUrIrVVnr/TVLG85XBXiqrkRh1B9ibW90elIN1KVeH3j6F3f9MnZLckA6c+yAaj86F2P5XH+/40X14LNpE49QLRUcyZSozQfvCjfmxnZixU3Yhd7OVdYNt5qCxcNJDJqCa3l;4:X4ivNbtZlfdprQmqMkAwzAr3Xy6OcupEZuWytkubMwYXosCS3VkTg7ivBRpYJnAraFFNFrlA1jIJMAxIE9uOUhiYtGmXlN6Oip06vFpDeV14XkAxS58T9Ho48Es7HeyUv9Vcj/3VKJAaNUezczlWnNzYWhoyy7L86rR6t9wWVazREyG8UtSaNM1NYC87Ee1JSFGF5/Onx4H0dDFn5GUhc70aqGC1AH930L/5WFhr7KAAeFPalAOEWGxv4tHQwnV+efVTlihoWiL2eDZ5+23MZA==
X-Microsoft-Antispam-PRVS: <DB7PR08MB32576F2F5CB0284324F5345CB0D00@DB7PR08MB3257.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3257;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3257;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39380400002)(39850400004)(346002)(189003)(199004)(51416003)(106356001)(8936002)(55236004)(59450400001)(36756003)(7736002)(6116002)(1076002)(6506007)(386003)(3846002)(47776003)(6512007)(105586002)(16526019)(186003)(86362001)(54906003)(5660300001)(66066001)(305945005)(53936002)(316002)(81166006)(4326008)(6486002)(50466002)(53416004)(68736007)(16586007)(2950100002)(26005)(52116002)(478600001)(2906002)(81156014)(50226002)(76176011)(97736004)(25786009)(48376002)(8676002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3257;H:i7.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3257;23:MVR5mekfILGIeJTnKLJk+PQtYPzKSNw93L+HA8Bau?=
 =?us-ascii?Q?J4whTSlFmm1VcwgoGm7G7Eh5enZdvfEbNJp0ZI9di8ZbjpX/nafLsoLMhgeH?=
 =?us-ascii?Q?/43BnZMNUQsacPKPmTUJaoWF+s2OB1dcN/Qdz5ZEkoKYtUzX5kxjqR5MkB9n?=
 =?us-ascii?Q?bm78hNBXBBZ3j+KTmbIoAst/xaEpqvLLf7dDECVMW3AWnLp+CcLcOG7wsNc1?=
 =?us-ascii?Q?VZGFQITKE6EoIR+NLmd+CT+2te7ptXrR8T4QrUzrW2G48dGoPG89ThH98tsu?=
 =?us-ascii?Q?79a/1izHtGIGBWqdC5+/pM62txjI1bDvtiaOWnDbGU8KLfSQJS+xCmwq9xPv?=
 =?us-ascii?Q?EJqxQXDTiP/BXaLAYcHROZXe2wUQHAGacAweT4ZqJrCoNeqrPfkst/m650jG?=
 =?us-ascii?Q?KF3WPWEZqdgf/rCWf+e80yXjhu+1Mt/rvnii/BzMgugWbyFDPkkSj5u488JE?=
 =?us-ascii?Q?SFdY2UtiPaj4b9GJUhbj7htoX2D3TzeBHvyHRQRkERRyYWj3gjB6nAryJu/G?=
 =?us-ascii?Q?vL91CP70Jgh1JddZ2pPpA6Hc9wR4K2ghxFXuLnKXQSV7bpd++h74Z/zbMpDG?=
 =?us-ascii?Q?ccY2AUAQC2oSnXupX+a+/1TXCyCQqvzha2xW54hmWzOZd8pMLbCroJ4gF1xx?=
 =?us-ascii?Q?di9SiLpEVQj4bCkQdPuyGD/4sIzE9jMBV0GKSgUnl50t7gCZTy32jHs7ZF4H?=
 =?us-ascii?Q?EInOWoUqeRus5zIjwTrDhbIxm92ZR46Jun0iUATXdGMsQlCde9aJX1nyrfGc?=
 =?us-ascii?Q?PizQfJeN2gM9pmpvLFVb+OJPOkR/CFvZT/5OlvHwveJeiYXh9I6hQl814NNW?=
 =?us-ascii?Q?Ll/jTGZyDwpOjwmA6fPVXtFHUaaH3ylWUjnQC70VuamuokRJHMRO0OxLL4nT?=
 =?us-ascii?Q?Jeu7SQP3XAF/OGuHN2TO7QbP4f2pij+u/IF33G7MuZ5KBSGEaethxamB225l?=
 =?us-ascii?Q?xU2qrXpZJPcKKbqOk5uSGyOmwYq08/pETKxTlQAsq0TVY274LNSB/zaEITEz?=
 =?us-ascii?Q?ovVZ/QwdK8+yVnpGBvlldehjVe1tXtpXY0sC6s54Z6P8MBVCaHPxWRKFAMsH?=
 =?us-ascii?Q?hurPVzRyZNoxZ2nCLMRi/GKCupqsT2dBk/BO36WTqfMesr24gJDiMqP3V2t8?=
 =?us-ascii?Q?0E4szdXeyyo2AUU8GuwGQr/BlGIo77omjwwDIXoqoidDRo287Pe6foSX1B3Y?=
 =?us-ascii?Q?9X9EhiBg4IleC0=3D?=
X-Microsoft-Antispam-Message-Info: 1brNuAm6TmtOwn1bYWo9IhfzYtmdzm3WWzjBzPZX+q0T8CIPCn+XeR5SVpxyWrhl1FlKqgq6I5JmvL1Tq3hatdiWo1HIFKddZfRajPslxujm+Wrn/hc2ga/hIoVUL4e+WuiY0eSOsYA+0tP9Hm1Vo329uxOB5rUKaw0JmYHD8U50sfLvt54a9T7Oowv+OQm+
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;6:HNH1S4zC0AL53u2DI+yZrRsEcugnFEVya9t0CLT97x/hvXXGfXas08AvUUOh+Iq9Ga2M2Brfgng3y1OxwaZX+L5q2K3pqNKeq2omgkcMrpxgYbl59hbQSXxR2iv5nJNdokyv49kYkXa0aF2/AWNVROW59QgFBE1we7UgNAJge+Xj64jO+aAa/bnr5B/iAw4E44QKxMS2tTj6r/MsHjgNOYWjZtJaOCfa9f7zBgb6RKAF2tSsWhFWCREtWEBQpwacKZP6Zq0QF5BiRMnglsX5KomYmm7cDqi+8XRXdQVejK7SUkOSAUnoFEp9QpIBrqs/Cu2wsjjQHUtUioheBlNn/wJZh+inQF19o78pSIMQKhg=;5:WfrvF+CscZBkKsb/0Gv9DiVA9J6l+18jkVqS2AeIcI2r7qAYKXqP/83qm2PK4uy4OkwVWR1rqxQZODQkNq4YI6rL0RbRltVg8ScjJAG4OfFmKkljcl6YT8ngaRQnPmvPNtJceY9mzcVnvpGjWlE96gLs97v5iEtfM1iYqIBkKnI=;24:LrnxMiRimhBMX+pCCVGhdDoe7eOFdizpkPesmGa0bvNOkbX4xUltzNXxrwjGz+7Kr3x6S4L09+An5nqPzmD3/FEahBG4Y0NZEU6esgutvtA=;7:zSRoGYa3+cl7bPVnsnHUa/RngPHY+qN2ReHZgXiTYW9dNnmmzCcfieKmnh0mwFs5QE6TGUdI7m/sli68BOOWjJIeBjTqQbqFI4N08texYvgS6ur9Qna4aNr3Ig0/rKpeuk92x0CnTJo2FYxYu+YdEsZhH4ZuK7kDe6cCQFN4UG63n3l7AkEamsj8soa+SPXdjgR9iH5cyth5IY3RFeHf564VIMsCXiZiAODfY8IpSx3T3Ef399AwnQyIqYflOi5s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:6nnvdbCaxSAFooyuD+UZLD26EQgL6vsmC/5Hdz+fDEd54STU6e3M0lQnTvkkH5Khyrj5iZahiMpF3KBWhIdL3nOLGvQV0P0raGUvU0GgnvITCMO7wxowbvT5zp0NV2M5T3/CRLNH2tihZNFRURFOyMUJXx/qrWucK24dvkLZs70=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 16:45:52.5088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cba814a-6c31-4a14-02a2-08d58a94377d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only kswapd can have non-zero nr_immediate, and current_may_throttle() is
always true for kswapd (PF_LESS_THROTTLE bit is never set) thus it's
enough to check stat.nr_immediate only.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0d5ab312a7f4..a8f6e4882e00 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1806,7 +1806,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 		 * that pages are cycling through the LRU faster than
 		 * they are written so also forcibly stall.
 		 */
-		if (stat.nr_immediate && current_may_throttle())
+		if (stat.nr_immediate)
 			congestion_wait(BLK_RW_ASYNC, HZ/10);
 	}
 
-- 
2.16.1
