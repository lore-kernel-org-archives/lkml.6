Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZr46ckDJSpzTGVsugJ2tfDxMgBzvpHLZgQT1XR7yaTh+63/YdAse54owGXQAjZ5lI/cdX3h
ARC-Seal: i=1; a=rsa-sha256; t=1526633021; cv=none;
        d=google.com; s=arc-20160816;
        b=ncBR73RZeSONf617SyZrh+9tRqD++2mhfd5bqo3+JJHVqHrSIQWeF2vYer10iTSeXE
         RSQo5xmLv2OYiuaD2/62ZD9Rr8pApJ15D92HNrvNzdDn1ssy/jl6O99pDaPBSyw5L6Dj
         AAY0cGS38eEBnomlKWmDKzxM6C2g1QfyUJPITrg1tVUW6IYbN+y7Kh8DJgJQiJU6veqW
         gBN7s8ur8eG/b62eYG9fx2Ul5rUwEL9bd7ihXD1MKQklzBP6j3mkFqSc59dJ0qUhPxFq
         3eyKdho/1flHdEnr9lKZ5n+by0IC09x7BsjOde0ymMF5TdmVahipeEAibWAUGmnuushq
         QuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=VLs5sGQTk/SBzLur7L0/bJRpBuflNB6tFsb4nnW9LAY=;
        b=p1BL4JQWPraLuUPksxR//5FX9sDcApEPh41cXTKSwgSQMuEmOrr5RGdKJN6C4M5L+w
         xAVmDG1TpoMPljAEjIfFMS1t3F7QpOyBzfYZCg24aYkcdk5bkAMshxFSsFkSee+Z0TRi
         gqobxFWyu1G5wgx3YOf0InFjPX5uA2xiAG4C2ttaLMXgEj0/zJFGJEcpl4BcUFmaN2u6
         Q7Cex+2vMVcmhecFifctew92Lt+bewizs5vcmILOICDJEpA9jNK8EBxaYTHHTF1S0npq
         SeyjEcwn1JO1p5EBZgCxtEHkPcKRYizR41P9k4w99TjhNbdHAQbU58cGfK3GuFUQ7tyO
         go2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Dz+YKoyU;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.133 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Dz+YKoyU;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.133 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v6 11/17] list_lru: Pass lru argument to
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
Date: Fri, 18 May 2018 11:43:34 +0300
Message-ID: <152663301468.5308.11453847445952411196.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0007.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::17) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:yL6S2K3eR8PrmkgxTj35K868jA8wptIY1qYNXx65auFk6rJCpjKIYlnyPi1WfOJrBC/8GwFx0otnMpJmTRGIWUX4FoFedSuiEBU+Zp+l5V7sd4bD7XYzw94ug7vfZd0iZDoWQpvYnPwjvL0KsXkB7FDpWrG5tzpupDocht/6EVhzIeIcsp1d4BYCT5VAFGbWAoTDkrPAxpCbuEtaYKH8vGXPKxiDQFeSNB9Hr7y4w9ts8Sr60ow93VnQCyAs9ONe;25:JUOAnRx50ZhVoS+AJ+AjBGWJdL5VU9K/o8p2SCFKMmNF6zlWdZnoUuXa3pVzv/MJ++4zSiT6wudDX+ntksAUcDumYbpiFAHxBdXv4i9qJSIvIKPZ5zRQHBUm7++ClParkRLyRoNKKmRHUxMbYjNOR0sn6O+SdfO7cwpe7WBY4kI0NBrcNjGbydkRP9Ah72ZpWnA40U432g1sshttg6K5ymiYtVBAvVvJANJ3/HeCOp9wid+Wl76lCssDZk73ACzW7qPxmaT9rFJtHSD/hy0b8ql7lKhM7pEpTqhUfGfxmbMyAOCTD+2K4lJW7NOI5p2gJ+IJpW7UOx8/g9vwh0ZG9A==;31:ADI5/rHPbDbDUmi4dZh0itzwkmAa406MM8Xgdq/ZiVeGfjjDObNERGtO1e243w19Rc4T7P5HMTSNVAL1qxEjLRHv2SWDBiz/q2e7BZMz8+9ArmnZYTsBfBW00u06C0oCZhhQEmFkYG0t5yeQfFK1AHPS++0TO0tERVoolGMqgNK287Baek/Y89y6OXLXz2EJCjmii2U4O66b+mLxQ+fcDSGzQflFplfLpQZ+nyiptUQ=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:RrpbPYOvYe6mGhdUWn5zwPHLi8x+Vuo8JQyB+7DyN2s/VKJYqELJMuwI1ct4cgiuTqubJe+X50sZR1IOqpoUhWLEgiViviT5bKLEJhFLvmifhHRJrhlnKZ1ewCHkjdLGlTYnqjStL2LpuAr8hz0hLgz9tzzscxEOutICGbZa+0LKqbbIS0D7J6Y4MqDArSclhE/q2L7l2M/NMEBjMow4+Y/wVJW7JF3pqRxSY4CJrNXkraMRMdrwMBe2Yl+DfkykpuAkH0B6iLmiMXChJ1tcxb2zdeZCP6jUAk7lLvp3PZd2Eqt2la6yTdcw+APBYwBXoBaBNsCKeG5f3a3BulXPOET2NtyCWmLiMRgZREw+5S7P7VPgQxjbd2CiwzGGDUETLw+fO+ZtjKIdZ0/smniQfvIlDDzeMYr/On0mepLGSxE9uRaucGgGFjO/3HsML9f4yAlQ1wugVida9IPQ3Vvo0S3gnx3hP//a46Eb7Qky1/QO183C73veCoy9i9DNxhgg;4:MRLjZHl2yes4FLlI+GmO7bgNQjnVGoVgKS/SBS91j/eq8y+c+BnlHqQna3kMgRnNMGM1Wtf821abaH5YoHzZoJuhBWFGnVsarj4Q8VsUxGlpzSrxaORPuNoWjDiK7Zg3gHVTGi40iJPRSeOLk8Vm90M8EuVFXpVMtrBmZDOyfPx+NtcdSWDNvrHPb9d0MjYGCtSW3OUcyaOCjCZJ0QER0WIBkM7BU39vMk9ERjzLY44x7xeNDXROT95lRGjSiKl8Ynbz4Mk3h/8mXWmMxWJ6dQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13385105EC11069F9D23BBCFCD900@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39380400002)(39850400004)(396003)(346002)(376002)(189003)(199004)(25786009)(956004)(68736007)(58126008)(50466002)(47776003)(66066001)(8936002)(8676002)(316002)(81156014)(81166006)(6636002)(478600001)(486006)(3846002)(6116002)(446003)(230700001)(103116003)(476003)(2906002)(76176011)(7416002)(33896004)(11346002)(5660300001)(305945005)(7696005)(52116002)(39060400002)(2486003)(23676004)(186003)(16526019)(26005)(6506007)(59450400001)(61506002)(386003)(55236004)(86362001)(105586002)(106356001)(9686003)(97736004)(7736002)(55016002)(53936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6YjZQNHFxdjRXL2dJOXM4cnJDYXBLemFM?=
 =?utf-8?B?bVNhTXg2dXVDdU9sUVJsUVVzQmQrZmlQQmQ5R3ZGS29ScHp3UVBkOFI1dXVn?=
 =?utf-8?B?OUN6MEZSbFlYV3ljYWRVNDBVd1dtRnJ6QnExKytLWjIvVktNMnpQQXhFcEVo?=
 =?utf-8?B?U210SjNlSjBJNCtWbkdUcjJVQ28zMnZEYXFRU0lkNUsyQVhwRWwwWGhidkd0?=
 =?utf-8?B?MldlbXpOZTJzWVdsWWtYLzVsSDRDRVlUTjRoOVRqRGREQ0Y0clNmSjRYRkll?=
 =?utf-8?B?REcvRXJudmIvemhkNHZXMkErK2pwRE1jM1RwZEc3K3BsVSszOEl3WEpJM2Zr?=
 =?utf-8?B?TDlocFYyUHc4VTlWZExITnlxaHRhdFVQODliSWo4K20rbk1wQm1qQTdMU0tG?=
 =?utf-8?B?Y3FVTElzdjB3YmZmRXhDM29FWk1CNk4zazlNNVN6cWJnOENkS3o4aUhiN0dy?=
 =?utf-8?B?aFN0TTZJQ3N0d3NoL3hMVkViVVhwbU91VStVU2tmOXRVVmFNeTk2d3NKRjRw?=
 =?utf-8?B?aERYWnBBQXNNU2RTcW01UkJTb3dlSEFVdlY3TUhsZ3EzYnJlUFRsNzRiMHQ0?=
 =?utf-8?B?NHFBR0N4eHFreGQ2b3E0eXk3aVNITXV4Y2dmOS83TXJpc2V1V2NKZVBLNll5?=
 =?utf-8?B?czhOWDAva2VRQU1IUVNlV3hDaWpORHRmN094R0RNMFJ1WjF2SUNvbFJnVjJk?=
 =?utf-8?B?NERKSUxNVkd0bXAvc0c0RHFDSHNaNVNUblpnYlN0cjZDUzYyTGppeUZiY1BV?=
 =?utf-8?B?V2Q1WDBEN3NkV1NrV21LNXNGNElOd2tBK3J4eXhQSjM2Y3Vzdi9JQ0V2M3o5?=
 =?utf-8?B?aEN6T2FvUTQ2TWt6R2NUTWR2Q0w4UWxzTEt6czhDRTZ5OXVWMGR5ZWdIK2lI?=
 =?utf-8?B?S3ZJbUtzSDJCNW1wclNxb25VeGJMZVI2SzZrbzM0ZzhPTXY5NWQ5aUFzSkda?=
 =?utf-8?B?SVdYdkdiSmk2MzZRbFNiVnFzSGYwdStycUoycm9hK0p3bFVkdGlVYWJuTVZs?=
 =?utf-8?B?bGJMczRiTEJQbGNsQXRmdWwwblprc1NOVGJRYjNXSG5JNEx0c05LSWYrY0lQ?=
 =?utf-8?B?VElncEN4L3hQbXZJU0w4TWk4Y0tlUFc3YjZNWCtIR2lGV1BhRkowMXI3TTVV?=
 =?utf-8?B?eEUrSkNITXdlTHJ6Uko2Y0t5YnpVQWR2VER1Zk9xaENsTFBybUd6b0cwczFn?=
 =?utf-8?B?ekRFMDVJaCtvbDlBNEthNHhOQVV2aDBGazQrZUlEcXROUGhFYlIwSFJyeHhI?=
 =?utf-8?B?VlphT05HeVlYeHZqbXNFMXVCU2M4RGVBc01EUnk5MzVUeHVtKzFRVFBWTmZv?=
 =?utf-8?B?N0IzblA3YzYzZEZYengveXBQL2IrTzFNNjlKL2o2ZXRMcjZxQW55YlRmbEs2?=
 =?utf-8?B?MFo5U09uNnNheXpJTFQxWVg0MXQrNzN1bThaSGIwWktzMk4yNTJMakpKaEs0?=
 =?utf-8?B?Ylc1OFdwUUZWUzdmTnozaE04Ri9CaWozeS9QV0pwQnBRU09MVG1zOVR3cVNL?=
 =?utf-8?B?NEVHNnNuSDJjdEpqNEkwQU9hbUJMZTRsZlU2azRaMktpSDRlUTBIUEdZVk82?=
 =?utf-8?B?eE01bElneHBsR3VRZ2dBTVdzUkMvbVE0YnZQVzlTbEg5UkhWNzEvQjRFZzVh?=
 =?utf-8?B?a0FtZUJhVGdLZldocC9hUERGWXFxWlY0THk0b1JWSEZFbGNLck1vL05XcmZw?=
 =?utf-8?B?ZVVGLzVxMUJaQkVMMVpCL05TVnN5dTRFNzdlRHRzeGFwa2JxQlE1eFZCMkk2?=
 =?utf-8?B?N1oyMmwzSmlFcHlpU2NrWVpvbjBxMjZlV0JyV1JFbmFyblE0OGVCTXRsOFI5?=
 =?utf-8?Q?8nEjkfcMJAsvqXe?=
X-Microsoft-Antispam-Message-Info: zQQkthc6EFy42YxJsqwoJHtUqqViTcSQy3n+L3m4T1sxNIJPY90eZ8k/tYQFCfFdwa7v5pJOVl4qtGhK9zGDm3Bz7AY87XjAQAO+UqE+o4d0tEecrZCEcpe+aEvqtXiYGkKd75eCnLhEw1KZmjvrof+EYOGnF9OrxKW/7r3scVoa6emp462MBfZAGsXgAeSh
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:sMwy+eb2Z0sCajFIb3313OJLbqByKpUcVvHh+oSl6j+tS0QMsXenJqqsdWLo10ZefuhRMnDPRbzYVpohc6RSCzRLT4Cn+PFyBAPK5zx249hMlTz069MC8G0tCX+v8u503AYlZowfbw4Ou0DVUmQ2uMkKGHyMQx0LGEQhNUwnyA/oKT6H2AlQ9USMeS/GrcTK/hS60zYVx8GolP55KFaLhBgw8vEMaShZK365mY3a6oOz8WiVv7dda/Q5Mdk2iNWXwmGvXUJUIyD4Wr/22e0d930y9P5Fvpw9XtAvGKERHDDcHYrjJLZE0sg458hw/uAzIU3mcKqRTstiaFkcSIOXTH0X3tmjauhUjq46GC6TZaOQJ9/tcxIB8rqAUeBa2F4K3QUYFE/YbmdsGPptwi+5PN1ixTU+jMAJRvAmOmnack0GpxYjBZ4e+E8pzuAHVq7VyX9EmIo1G3D4+ltoZba6yA==;5:zlilWCUPAaeocTXQ14vP367dIZd3vHExhYaFk6nzocZhVPjmbqW++tHZ7MNQXx+leiXNMZJeZTfZzywoTfdZ11/zcIPKahbKuOFxrPzjennJ9kKaYVB7/UaaCGmuiY0BD/PQoRhPzMfgW6kUC9oY0Oec0/Cyl7EAxR4U+P8U1gA=;24:CDGSnnWNcfWPL2hF6z7jieDln9qJdbPsrAADr8eSzu8ancLbq3CBkCuQuOaA9berRywDOLHOuJcnFG0ZlPhAam98d6NjNNO2v63Kc2fSHzs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:Zy2Rev/TvULb961AxykWm5FldblL8I0MVeairguHoqlS5l3sURf2B0W+F+NkwuphI5C0/T56mD3cEX6ws/Bq6KbEwlrY+OLZ+Qwdw5DNOxv+49ZMIpioiuHv5HBkIRWkRzjPVvqtoxcZlA6OqOuTF/qe/ckI251/3xQ0I02wLytQ3zDnIosFAjIIT1+lA1kIfyvs+t6/fhhbBhHiDR23Af+sV7ZrQp3bSJNXj+RugcWfJB2xWVnlyoSNeEiXa2a3;20:D/OwerPGUMI4ZyRpP9aY8sDU84lnauoo3IXDjQE75RvUwBczdAy1Z2PJgujsL+lBysN1Swod9T948JeqLdenevOrQUom2LDfX67iqVXZqv8fJRwZsvn+aLr6F/yHel5fG+IbS8Ezqxtp7MM9Mu5LsvGmQ4vFDENahTzZlQvAToA=
X-MS-Office365-Filtering-Correlation-Id: ebdf1151-bbbe-41fa-b92f-08d5bc9b72ca
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:43:36.6196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdf1151-bbbe-41fa-b92f-08d5bc9b72ca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790747166520835?=
X-GMAIL-MSGID: =?utf-8?q?1600790747166520835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
lru pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/list_lru.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 43cbec52a48a..cab8fad7f7e2 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -514,9 +514,10 @@ int memcg_update_all_list_lrus(int new_size)
 	goto out;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
+static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
@@ -545,7 +546,7 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
+		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
 }
 
 void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
