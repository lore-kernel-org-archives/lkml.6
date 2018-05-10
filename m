Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeEJTRE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:17:04 -0400
Received: from mail-he1eur01on0104.outbound.protection.outlook.com ([104.47.0.104]:17238
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752082AbeEJTQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:16:47 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>
Cc: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org, Cathy Avery <cavery@redhat.com>
Subject: [PATCH] idr: fix invalid ptr dereference on item delete
Date: Thu, 10 May 2018 22:16:34 +0300
Message-Id: <20180510191634.18796-1-rkagan@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR07CA0041.eurprd07.prod.outlook.com
 (2603:10a6:7:66::27) To AM5PR0801MB1971.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1971;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1971;3:MZNLj0FBPpNbwbaI5LaeIzHM1GR4ETG6aV3IEdsd68rWCW2fX3fXwcD5snMXAZkCi00l75EmJJC8L3ZtZzaA74nE+GDuwOb0ScLpcfXHia9QlOuBDyWwt7H1zHAcXrcjfyKhmJGVCp/WZosLCUWt3VSt+nFMtinEa2Q1Ip5n2WTf9nrjQrb3mY54wITMG1tm4P/u1ZIcjyiAxSDd51O+hqaWIqQnMaONIJ3zZIfGj6Z8kqHoAaslh4AC7hBgEcy3;25:MmzuYsL1airQjPlSfkcAHX5E+1K5NWiMRaOCkq1waJZiVrV4Wt7wpaqxofKDNPxt22HW3edx93Jsh/TbTtJWRYEoLikKkY7TyTwEbx4r1nWjKqdksIO+MH7TgexPeATSte7Zzsq06nsXdM9dWZvEGbWv7JA4spMNccIwFTWKJhQ+7+ZDXPUwutGSlvk+h6DHP3omvPiiSoCrDRoyUSrrdv433BJiX8AEZaUffA9RSHjBN3ROudTY/LwEBZjzxntf7u3M4d1nLzpLdjxsX88IqkfrJyrI9V+eNQmyNpwpuo9t4aaO6cmQjvudv0r5y6OAsusAKpqPrwtKA91xpu6oVg==;31:p+GyXgj28cvn6ONSpLztPy7MuKp1Z/tNmK4WYWgWV982giqkQXqFKb828iS44R3Hxu7erY5hhp9oA1Zzi1vrhP96wBUxUxXtOZ2dZK4Uwd3v6ZQxc4vimPbYfnL6NQaDvQHa4+MRQoSAxrzDADeY72R82BCZtxcWxgncjiUYZVfRJia1ikn3theb6bDzwI9/9WY0OIuHbTUzztKQqtH4QRix4eaPR6+JeW3CrylJ3FQ=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1971:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1971;20:yI2ujBv+u02tVCFGFLTocpZ/Z0+7ulHz9NENqrdEKQcneKlISh0sfTQE3z29Dj8qQLGuRpoE4mqvfrts3PqvGIzvjVMy1IiQj7+zupiHBe6SUsCyVqnsDACwYA/hyn9KVSkEvLbOf/pJtAHt5FdqhHAOWz7VxYjVyU4CJ3xEcCaz8idDZlDIKn2IFSymJ1U6s/dyIP2r4BUueqmD5KifgRoyWwN1yhJGY7NRKiDcGKhZ+TzUQnP77V0Nh4VymDatv+UxIDclPr3f7diYgtVQXTSvQUuHnf2JSMq6tHqR0yGjbi56gRncsEDyWCpJkf2dVi1QTD34aniO2DDryRnNV9KJMTgArMVyfRhr7n0hQYm+268PrZ6ZruRtGEv5i4LabmUOXX3p6uDI3veAu1KPd31DlTJyOCL7yXdCPf6Eimc10HgwnKd7dll3YmhAdkxN5dSoWGfoOsjphaWY4JxIHYLavDlabU1WAqvVQj8U6tCDN9jmp/DVDX6IwNl7I9bI;4:6A8JRh25zl4KF2qRUnGTELCjXLNCz24ZhLx4dRIWIOOlfOJWJo61pyj/wmRykP0HMQglZcmj1D138soF5bcMbWxyoFXunlvod+UEcU2ZdtSqtuUUPLOnO5e7xrVWSUQ5Vu3Iuk4OTN+ZKUZtR/+uxdguH9erAME12pPi9BTCEJfWMSGUC9BEOwp0feQyHjE83NbNk3h/60kRj83ulbrnJLvz4MV8DzyqSozZ+gZmt5OR/1l74C9rOvzRCCAZSSuBd816eaRoAMcEPv9kWjfpug==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB197159501233E908459B8405C9980@AM5PR0801MB1971.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0801MB1971;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1971;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39850400004)(346002)(39380400002)(189003)(199004)(2616005)(51416003)(186003)(52116002)(110136005)(55236004)(16526019)(47776003)(53936002)(26005)(3846002)(59450400001)(316002)(6506007)(16586007)(386003)(69596002)(6116002)(7736002)(1857600001)(1076002)(6512007)(305945005)(8676002)(1511001)(8666007)(486006)(66066001)(956004)(476003)(53416004)(81156014)(68736007)(478600001)(105586002)(6666003)(50226002)(25786009)(48376002)(86362001)(81166006)(575784001)(8936002)(50466002)(97736004)(106356001)(7416002)(6486002)(5660300001)(4326008)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1971;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1971;23:YAkWTsI9HMTUNEWw4t1juN/sevHeheRxGl7Zsqx?=
 =?us-ascii?Q?t0Gn5hqiN6phJji9WjOFNWFw1Afc0uVF2qi+ypadftMsLRvZtzMpGJZ4udlp?=
 =?us-ascii?Q?qbMIfsnEhVUeEbeiF8/BpZoBiOX1bJkSimAsPAWlfc2Hk5sDYd79zApRKCTV?=
 =?us-ascii?Q?pWGuyfde1212x9vPjVR5Qs1alNI2kFLxPXeWzZXj7/SIesIulQ5N7s+4nSUc?=
 =?us-ascii?Q?t49mVb2nhvwWbAb4nXU+snoYkTxg/4526/Tb7I0i6cp3Rmjy29J2h7KRlSee?=
 =?us-ascii?Q?i6EBq51TAVNV/GBCOb94A+U3ui1x/PqE7JNTrhOyyrd2Jy6nbzmCtbnNcYu7?=
 =?us-ascii?Q?8NvAX/tEuycnQ4jWCYY1PzY4kZLwyYawIqjn6V3369PgRDGyP3/M+tBvlDGI?=
 =?us-ascii?Q?ZmkhwlNISRbIK5jCxOLqlmsAE63p6qp8LrCcV3eYBYZ2RFtYmm1ftwBUf+YR?=
 =?us-ascii?Q?1LQS9wFMPoEGVsFeQ4kteGpIftGe3wrQPJX0z7fovcG6GbE/TCWYIYyOrSQX?=
 =?us-ascii?Q?uZ7npRvuRs2Zzq83O02KfHHcx55IvCuQP5vFQCcWdPlbDkrGhO1MJUX0Ex0u?=
 =?us-ascii?Q?xCiJqrtN2FaxkYwJh7GQ6rMwt3lXSCll5XEXSDzrd0WLxuP3FvTkiuImJC2F?=
 =?us-ascii?Q?LLkR3q5ospVgiiAvn0GNgR1JN3N25JicHhEyeISJfGo2pu1ogUoxq6zAA1+4?=
 =?us-ascii?Q?Tfz7fwFkVWE47p/QV8pkjM4TAnxAwn6X9lzu3QNTegWd8GlsZQtVRH3TcgW4?=
 =?us-ascii?Q?kIBbqEK+6I+XtfMiWyRD9tna8NS8i8dD8jclTskU4QPl948PKAdmJCtN+D3c?=
 =?us-ascii?Q?NtPD7cuhG5bA5+pptom0BUVwOWbgQ2ZecfLCMt9jk84ZgOI3FmGZwidacckw?=
 =?us-ascii?Q?ZjfgKSxjlU7ulymOH0hauEcZhEUiCXA/F3BPs1fqKAztJT6EOg5ek8CHAXxJ?=
 =?us-ascii?Q?PxNsu6Fd18ViLB/tpjXLFvG5/xFkVEnC0fTcv6MHf1OsWt4YANq125czcwT4?=
 =?us-ascii?Q?w2mgtJES5lKVXIe2Z8b7I73SlPCUPozFLVuchDCPnzzM7QVA9Ez0xcoaAEph?=
 =?us-ascii?Q?1DWfSmPxdKACDu/VQvc2LrYQNPqmAdbM+F4yay/h893kgsfTP9tFsswmiuuf?=
 =?us-ascii?Q?HF+OYPU99El3mTdH8DGTUDR0qK6N4QdgFQ4qli75Fn23to/F1Mv/J4o9ETej?=
 =?us-ascii?Q?xCFFIdQDQiuEvFHSzHSK8XBDcsjBB0Evc3r4wux9fVkCJ5UEkT1ZW9RnSAfB?=
 =?us-ascii?Q?D0ZPuAA/TGJ/frva66LhZMgDOVFSRkDZqTa7XsdN3dz7T9Kfhk4mvYzphNYz?=
 =?us-ascii?Q?bmQ5mtoTD5jhX8eIvkj5cPC5NqymuONlPELee1V3c9pZ6?=
X-Microsoft-Antispam-Message-Info: LaJ5hfCyZ3DDOoNiq04Ee6XNOT9yOr1xwm1HP4JLr0WsqXHQUzhgfusxscoEI/zesIKL64Z/jbXpriInRYr0zD8cO/kMj3U7jJ6mqjjuHH9gSQqa4xhORIMqtAT9A80d70uO/0DCtJYRud5tOt8K2rTCUmJi/5ROHyJ+5cPQsiwGHQcPeBRivU5EMVPdZaBu
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1971;6:5qCu2t8mpO79SvSBQaVl6cXTqG1j6IC1YX3O2BBKFDKBW4iViUjwm1A2mj/HDmDxxGAiDkLL0LrXVAT6H4cxe/so6xTqRfkgmUZYyk9J64uvyc7amwO+2iRmq1s0ZPJ6CT7xNgVF5fNl2Eh0K+Qse+Wn5cB67DTPKHCxNH+2yQjJg/je3PyVe+6wzQdWkGCEhJ8IADKm82JBOl6ZVipa1WTyePb3pOTqnzK/UrFdaLkIsgNA4hhrg+qxFJtMcDsIOuFOBEpPmflViR55lJUP0eIRM4VdGNvlXJgd5xT/z4wsYmbj9SS4ktzKpeFBBMxLvdkjzRjUlH5yD2LoQCppAuUsmH++P+3slyB8CKDmmQsiI+igMzYjVkuy3qtI5LxaDNW8X4Z9dz/h0Ru3HV40W48DnSalIjBvpAEy2bEP8AVoLNBfN5ntCj/pCzJoerNu1lrPVJl5ibzlm+qZBDPT3Q==;5:BiBnntPfms1Jr8ZDOhfMpPTkxuH1eY2BzX0KccbfWy15Yzgi4DyGCKuawzV7+clklf9TMTLSIiWhs/BQiUcVUUuhm+mIe0FKCfgnvUgXCxjGp3qW04U2o4OCXmbGwP8a3Y/QSJzKeigN49wy7a6Z0coTkS70YvhC4I8FiBQgflk=;24:IOvhomQzFcABopcZO6Fdv/917Nunr6tjNtLzFD1+M9jgagW4WeD8W67UE8VJpbXkAxBn+lwVrExZ1bXGaSC0OsTphR/UtkLA7MkGIOOG7p8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1971;7:BfvuovMJjwNloIiwb9pfY2+URgF/syB7q8pIH14m+eJ1dZ8NqBaA7MGdGfpYe/UCZcxshX8C5A8Z9GKLcCu/MPgUlLMjIiwufoe/9npPxWzUnP67LdvF7acDuaapwecHvya/ZbJenZIraTujP3jEPE0J9oXNlHcfB+raLVsfsW4debhNewnzOPpSCT1lAbQkinlVzfgXqL/S1UapDRnlWSNdozhlwARkMXXMnKUedxVL4O6SToZJ3yNNdJptQeKy;20:U8ggXBS0Gf93ZHEAwEHv1Gtf03zKEvrsWo5XLvCqo1/LlmsYzwtQaNkrvxmxSl+wHUo9CMqNyRLatupP9i1fl+p+aXcYBgDBIj9v1AkajUQjcpjxrBcFZYrXYjf0II6FfNq8AWa/yCHRRNO8fj+0cW5EOgPSzCzVK7cHWM42Hy0=
X-MS-Office365-Filtering-Correlation-Id: 8fdf5381-9621-4605-f891-08d5b6aa9115
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 19:16:42.9358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdf5381-9621-4605-f891-08d5b6aa9115
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1971
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an IDR contains a single entry at index==0, the underlying radix tree
has a single item in its root node, in which case
__radix_tree_lookup(index!=0) doesn't set its *@nodep argument (in
addition to returning NULL).

However, the tree itself is not empty, i.e. the tree root doesn't have
IDR_FREE tag.

As a result, on an attempt to remove an index!=0 entry from such an IDR,
radix_tree_delete_item doesn't return early and calls
__radix_tree_delete with invalid parameters which are then dereferenced.

Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 lib/radix-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index da9e10c827df..10ff1bfae952 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -2040,8 +2040,9 @@ void *radix_tree_delete_item(struct radix_tree_root *root,
 	void *entry;
 
 	entry = __radix_tree_lookup(root, index, &node, &slot);
-	if (!entry && (!is_idr(root) || node_tag_get(root, node, IDR_FREE,
-						get_slot_offset(node, slot))))
+	if (!entry && (!is_idr(root) || !node ||
+		       node_tag_get(root, node, IDR_FREE,
+				    get_slot_offset(node, slot))))
 		return NULL;
 
 	if (item && entry != item)
-- 
2.17.0
