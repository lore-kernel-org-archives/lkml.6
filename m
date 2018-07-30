Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A46C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A8120894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="GOVQfk6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A8120894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbeGaACC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:02:02 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:54222 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726804AbeGaACC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:02:02 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UMOicM019980;
        Mon, 30 Jul 2018 15:24:55 -0700
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp0050.outbound.protection.outlook.com [216.32.181.50])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2kj8p7g9sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 30 Jul 2018 15:24:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JehkERYQhV7LWbVtpE/V5+1XGBDYaExV6jKA2nrdbsI=;
 b=GOVQfk6zOSCQTyPnn+Dlsa8u6Ho3jzlzeNvCChB8FaDWOWj5d63OFZSqWGCabnx6ahTiWsd+qB6NUbNSVe7XYuorzHvzgYPFfKJhlRlc2gxRSAhxVMPvCWAKey/QSQXKsoOr2oaV0WFjZ30ETmhQAJ9lcYVaGCUL8OogZrEtpLk=
Received: from ChunChenWA-PC.corp.nutanix.com (66.193.132.66) by
 DM6PR02MB4507.namprd02.prod.outlook.com (2603:10b6:5:20::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Mon, 30 Jul 2018 22:24:51 +0000
From:   David Chen <david.chen@nutanix.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chunwei Chen <david.chen@nutanix.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH] rcu: Fix NOCB follower not waking up causing OOM
Date:   Mon, 30 Jul 2018 15:23:42 -0700
Message-Id: <1532989422-1517-1-git-send-email-david.chen@nutanix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180730193245.GA24813@linux.vnet.ibm.com>
References: <20180730193245.GA24813@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [66.193.132.66]
X-ClientProxiedBy: MWHPR12CA0070.namprd12.prod.outlook.com
 (2603:10b6:300:103::32) To DM6PR02MB4507.namprd02.prod.outlook.com
 (2603:10b6:5:20::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bea0a432-0a03-4820-267c-08d5f66b44ec
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4507;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4507;3:cPKAPV4/+i5YphGHJY//bTHQ1roXC7y3cjE925aW5MniRaKt+UUlrt1OSNpBbYkoEupMbK9dpC1Uy4es5bOAxogM5Fhr8C12CLKCjsemBk9dGxzLsbcfdWxnN31oPTn13GOJuhmlgTvxU5CH4cgg0CpzzC6Isbx8h31odoGSRlYNhoCiassEesEIpjYtD7RM+0oRrH2Q67vWAirP8Z2wF7dDSxQWSQ2SK5LrPvK1GyY8RNM82hJohV5lMWuhc7NK;25:CF6MBbguoXTXQCVwfzjTOSy3T38if8w66Vjur8utcyy4lore2h1ouZ4Tp8JQ2E5cIU74HlPl1TpFQuZVv90GFqNbYB0Hvc/sTXywMoR8xd6WnsawXhvv4t0hWc9JSAfo21kr7zM+z/zPrc379lfUbgdw7eEEVaWf2/YRa5NzJh4zCCT6eCjrOUQEC58O1rlguBOGO/YJ2knvkiMSdBOdn00Lmj1tRNCQZKvaN1XehlOMeFaGFOs1QfW6j5YMVjawZi2GE9DeRAkns9p+5grFbpNADJ97M0VafyMgYE/Ei0AWq5MiUpELamH4ApNEEv4eNWoSeWN86BVpUUfd/MYexg==;31:P/f/jRGE6lNOx9v1qoSGM7cyQo30JZOcglTJ2LE/4azvwROa3LWJBKJEZUtteyRp/oiS+5SA94w/XNVZKX9ge92N456JgosrRrXfQJjDuyXy5H3CR/xnRL0z1cNE1FxhhPO98AlsqteaBBkPCuzfdIi8uj53cyLNOnQtV3A0CTwmPDmQ4t7PfYdaZVU3Ayr5rt0GIPdBDsF0BfyKOVfnQAXYobcN+4N+2xiD715E1bQ=
X-MS-TrafficTypeDiagnostic: DM6PR02MB4507:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4507;20:l9wtVaHX3goeAkE28R5IPjVVirQZ7iyjBVaqO0XoKhpnBsC1MOYmohUaCA4clZwhMPVxyDS7jst9Dst5D/C6jSmTc7AW6fr2xlLdN7QDGY0RmeoHX3eaCpUsyD37G980Ij55LMNKrJ63oQxdUDDu3OyW8JaEt/sb9VaoPq92HR53LLm4yB+YTGmUxMFI05/i5tXv3eq3+QEjFM0yOo1SmKRw8jouqXwWjWlSfREwsED11Y3tn0GYjfk5bm06JM6WKaWPzNIqwGVLBDXO/FDl/BKkpBZE0iWMaaFUr/CBZz0rwKYD9F5L0ktKOh2XFX41RrFWUOvMj5YQqe0FPIwzuimeq+8DyKoWvKfpBllyJcYycDGXn/TAJQ7idq4XICSqrHewD/eTJzKN9U4q+9X4aJcSs/VWD3vquFDAfGUTdllaAb42FcEcQ42ynhYD76Vi2cDSK9dEJeZ5PrIxEsm/9krqSgZzpaf7W+EBGFO8Pf5Zmdm7XQ/nTRZFRxMZOzI99i8+FAN6nkzZB+kBJreXC37GcXMwn8klyURFRBoWpBk0xlI/AycGYiuSqgiKGnvkiZ9S3xWq1qJt5a99X57kqB94civTw2V54sUBupQe+fs=
X-Microsoft-Antispam-PRVS: <DM6PR02MB4507ADDD4580837F59D5C7FB942F0@DM6PR02MB4507.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(52384705835673)(228109839391802)(104084551191319);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4507;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4507;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4507;4:rM27bC75LY0cgm3tX9yioIQ1Psl0KM8GdtggFkSDrXpMk4Dk4l+wjpCuClHSdL1JpcWO5cGxUrK3n9TD2LCANe9YnkQZKJbcD0CP5FEh1PlrnMkw+Wh+FHga3XfSy+lJZw/jbxFqu1dKuLmpr2eYwvnmU2CvYNiWgpOUdn+tJkZHloZawsFyL7yo/hrHSFM1AxEyt5ugWRV/TKznhlwVCMfTQzYmyPxc8ehwURfZsx32ptIuBj1cVOHyiiDtpWdUatxWsgP7LAnTjUrigdo6oRnNpUS5KLn8veziN/UuPH6x2dPbp3KKTMQer9bj4gq3dUzxV32qAiXIhZhQSAXaaUQvoedvY9zLi3XxQOLLzHjTI1vz3qJxC+3+rLtrJJJy
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(53936002)(2616005)(446003)(11346002)(14444005)(486006)(1857600001)(6916009)(956004)(6666003)(7696005)(52116002)(476003)(51416003)(106356001)(105586002)(44832011)(316002)(81166006)(5660300001)(3846002)(6116002)(8676002)(86362001)(50226002)(2351001)(8936002)(81156014)(36756003)(305945005)(54906003)(68736007)(6486002)(50466002)(47776003)(48376002)(97736004)(478600001)(2361001)(4326008)(25786009)(386003)(7736002)(76176011)(26005)(16526019)(16586007)(186003)(66066001)(2906002)(64030200001)(16060500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR02MB4507;H:ChunChenWA-PC.corp.nutanix.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4507;23:m4AUTzft/kO8GnLyadMA5Za/NkW+MTGByw34JA0l4?=
 =?us-ascii?Q?D6Nstc+D/4X3mEPlu+hz8g/lsmuadB428TeSIVcuoOm0KDNRnP+x1eCGeKIf?=
 =?us-ascii?Q?TV7lGWXvlnezlHNRc17hq4iLO5vAj1yWxEmGP5qm9pF4soWNal7p336PpLv5?=
 =?us-ascii?Q?GTqYAhvP0z2QEFDhBvF8l2tIOKJ7CQCljnP3lDHrodXmqjrTrY1awdGCzO+l?=
 =?us-ascii?Q?uxT+luL7FJodXMUcP60+CT1rhFLeFPAAFvmhxGV347zp+LGuycYilzAoOiRI?=
 =?us-ascii?Q?I5ISbiI+yKf9G2Q2RfnytlU3fM+iFN87OFFZXIJasjIqFkGiZTGUlhxtAXBv?=
 =?us-ascii?Q?lmWMKINyzjdENOkAKWuDzMWAZ2r3yLBnNWdlaU7tYwX9wZDCfoHbDcmwy9aA?=
 =?us-ascii?Q?gISCP6pqWGPIP+fkw7vw6k2btv+EuNGay1Ud0pay7Jhx7SKo5uxJtpd+gpFY?=
 =?us-ascii?Q?6TpesGATgSni0+NNlMrcLhBNzorq3Bnye993RuarouBJbavV7kaO1uWSPmzw?=
 =?us-ascii?Q?QesHt/pV19RrvZQpjkYnnoK1bz1PuaTV+QwOot9mzcXYZxbpPGXcDzzAHnTY?=
 =?us-ascii?Q?hYIPzSYQaW2KWGiY/dYaQhQrnIydrGjgdPpVYWAGOcThpDFr+zJPbHM4PEmk?=
 =?us-ascii?Q?uwq9Pv2ewpRSlhIHaviojdB/OO497iDp9dVJ+DsWsWxGVN6m/79/yemUIm+x?=
 =?us-ascii?Q?P/8fToNEfapckf4ZBsYjhXhBwS147mxrHB345oVdxf0MJo5uo47P2/s/tMU/?=
 =?us-ascii?Q?T8DXBR23J6udH9qXz6SGy4rreuZ8T2W++S/IL4qnud/6bjXxk6tGEKdBEEuC?=
 =?us-ascii?Q?hKRX1eROMza4av9O9F4JswXc4ehhHv7WVvbjTvUa0SHyTmfh2JOUlNzKAdv+?=
 =?us-ascii?Q?HdZgTbawIRFz9Y96EKpA7l6q2vNNo15mxQ4Ryafq5omnAZIbaw3tH9ga5GG6?=
 =?us-ascii?Q?YhWNk/UuRmWekkxya0mSiHgQUm04/Nh4BTV2PfNA7oVNZGluZhr6TddIG1hL?=
 =?us-ascii?Q?t6my/CjRqXYEHyF0AIbKygYk2JF/t9TRGbmXCU+my3+YDp8se0FI+//GtxuG?=
 =?us-ascii?Q?CBp/z4R6crFosJ/jRS285lx9SeEi1srQlmYbTAzbJVEh1VWLPfVJEgGgvmnb?=
 =?us-ascii?Q?a1zQx1LyHME70BR8FOfU++EEudZr1LUnI8fR+lTJG4C6vXaBpeynLKOzvO/+?=
 =?us-ascii?Q?fryvhUJ0dGmxf2hMcavNeYu5ls8zb7Dnw5ibvQzOvzK1LO8pFI11x8RDZsCB?=
 =?us-ascii?Q?nBtSI8c9Fd7pGR7nBb1KbSK4aqYskltXci+AYZ9XkWgUZmE19rXETKAdpaot?=
 =?us-ascii?Q?QAwwVZnyp52nTjOSWr0juC3bDPfrfx4raEDwOQmYNVb?=
X-Microsoft-Antispam-Message-Info: JpjwP2GBHUMe1h+/Hxc/ieSp19xpKq77BvY5TJZtmtwE3x+EHDQcD/Zu79rUfXhwj/OWTqOI7ecwIfTZOqOjzPLVUZjdsw+j9J58kwnnHvmgdlAi4d7OopbH33mgvuCPdYnaHbm7U3hJWDO8R9HxAMMDxZBWStb2TZQCqQ7gikDvsNjyhdQORW4AUNzN/F6qY40UduvGHjs2+JqjvfQWONlilPzvTghMfH1R6YX4yqCbKpif/mkVhUbn7eRTbJv4KQnm53SR8A1BX8bBX1D+pc68tl5zKnpYRKfOzBfXRNREzKkaDvtFLminzlqH/UbOOFbMv3m23Nj+5K6Xc+fWn7yp5L2k9LJouF7MlvR+tB0=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4507;6:GjGt9vkOGW7bwb/E0zfdJI3VD0o1gHFkSvqX4LuCL9i8jyZZhGXygt3phE6nrIlJVovrCcGdke1xcSlMxKBCDlpSs6JwYGVi4eDBg4s13zXxMC7bhBuQMVLa9LlQcNqr6YRky+wONRPCM2xRKAcPJ76yYL+jBMuwhztD6qHH/xQ/eN4nF/Q4YxOYIyuqq9D8c3hR2bZVYbMt4zcGOX1SCYjakH9mQgH8L2tJ4eEZKK0biF3SItn0h1tb8LQ7Whk98NnqLe9WAXQ0ddUvt59pwRyleYBHWTQR/TFu/tei3p7I8T/EoZiEH7h3Cws191PpA+JSrxo+PBBxtRnXJUJVC/71+PesaYu4h44X3gR5YVZsXNB7K/9Pr4tTJira5bqD+J7JVm0NmEx0krwSlXMj8leH+K2GfFLB5PFwbi3xNbPoi5FyadURTwir3K58U3enpt/xhRrSnsSAybTjqtqFtg==;5:DvmBov4UZJ9biW1R2MU9ZH7Q6sfC9QP0DRgO3qG77T2d9lNNqHV69UOBg+XTkdZzps14vBy42lefKr7+ObNSSqWHvHvjm1wFQa9c72rHSr9y/JkBT8baaa4ZtjS3909khaMxCkkPJFw8SYAJmKn3kVPh1jq9PROSw8upmfWmTNI=;7:Sx7S9JRitlPJtNVaoZeVGCCZD59ipLjUjYDcsS+eYbVXBqqG7AS/aiS/IvdA5t78KhQcjzfEkeqkDXTDFKMeJmpJiBzLLeTsy7IPe5kJYCwJGy7vOwteJne7TjcE/xxNXniP4I4eCyjq92LAn7hlFDCob7gQwYBCODZ0foUjFtEw36ygXixlGwHmSgWXZUTuzHlEmCZpVgymX1RJ0rqAA9dAZlOupQggeML4LfirQTU5v6J8sz3y4SWTglxrlSHp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 22:24:51.8866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea0a432-0a03-4820-267c-08d5f66b44ec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4507
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=591 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300236
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunwei Chen <david.chen@nutanix.com>

In 4.9 stable branch, we hit an issue where one of the NOCB follower
thread wasn't waking up, even though the follower list is not empty.
The follower list just kept on growing and never got reclaimed, and
finally caused the system to run out of memory.

This issue is similar to the issue fixed by 6b5fc3a13318, both are
caused by lacking proper memory barrier before swake_up, and causing
wake up to be missed. While we do have smp_mb__after_atomic here, but
smp_mb__after_atomic is only a compiler barrier on x86, so it doesn't
prevent this at all. So we fix this issue by changing it to smp_mb.

Note, this patch doesn't apply to master, because in master the follower
list is changed to spinlock protected list. So there's no such issue
there.

Signed-off-by: Chunwei Chen <david.chen@nutanix.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 554ea54..b2d663d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2090,7 +2090,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 		/* Append callbacks to follower's "done" list. */
 		tail = xchg(&rdp->nocb_follower_tail, rdp->nocb_gp_tail);
 		*tail = rdp->nocb_gp_head;
-		smp_mb__after_atomic(); /* Store *tail before wakeup. */
+		smp_mb(); /* Store *tail before wakeup. */
 		if (rdp != my_rdp && tail == &rdp->nocb_follower_head) {
 			/*
 			 * List was empty, wake up the follower.
-- 
1.9.4

