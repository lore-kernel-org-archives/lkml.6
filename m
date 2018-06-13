Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1B9C7C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB88208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="DQFYyI3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB88208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934644AbeFMHsU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:48:20 -0400
Received: from mail-eopbgr720061.outbound.protection.outlook.com ([40.107.72.61]:8762
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934418AbeFMHsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG5kvXnzNEXPwkT+6W8sV+3qmYmEtGWbQRpwlcu/C+A=;
 b=DQFYyI3rPPkjutKO2dlEcjDLlNWYEwaHA16LH4flsvXiswhjDVU7qiwvUREEcdyNn88LIPVkB6WkBGTVlnD4z5yUGcUeXQ1mCdBxD0B/Bh74FIIsmzUoJRRQLhDoPcnJadI8NLMWDHnPMHdWcj43hcgpr5UZK66GqGo+PLVXGP0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 SN6PR05MB4589.namprd05.prod.outlook.com (2603:10b6:805:38::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Wed, 13 Jun 2018 07:48:14 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] locking,drm: Fix ww mutex naming / algorithm inconsistency
Date:   Wed, 13 Jun 2018 09:47:43 +0200
Message-Id: <20180613074745.14750-1-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0402CA0057.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::46) To SN6PR05MB4589.namprd05.prod.outlook.com
 (2603:10b6:805:38::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 961a1c8a-6d90-4d8c-9744-08d5d1020574
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4589;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;3:qpMxxRVJX5atpbOH4gTAazf91VkJ5VradU5pf6xfDtT7QsyNM6TojZ18yAS7bKl7rgGgYOsadHo7mE00PDW/a29T88QvkEEeHgfeHz2hd6CNC4jqYheJ9J4eiB5IsVutVw+DoamHPFHxGWoikQaD2CNqxSqlwrhAl9cjdw0qTqXpd/GDDF3ZCAJ2nMQpMa79Y/tIhNB507o99ONUtbZ4f7p7bEXkVcaIFKOGtXCMGLe00FMp1AmRZj0gdN5+mnj5;25:oQcT6ikZ5PUcuvXzqKZgB/Vkz6AnIQANRUuSyTT4L/KEZ15+jkFky7SfHh18gl3910aRnmmRnx3mr5WC0LC+QdzeRVHonFhhg9h+qkYzmcwrKn8xNpIDVtd4Gl2sK1+94WPFar1L0S+cLN/W3Tdeuf5hWQ4rcRUPypR0tjGMchT4fL3QILyFJTbD9NL2vGfLw1P5w3NZ9MXAVIfysjOaxEujTaDH8Gr8g0lnDYDAIt2ulmMog3Ey8nQYs1XuFpiI2fzGz3z8hTYrlWj03B96oYVGFzwpup8gJ4eih+WOGjxdaBYeMeYy0nTSjDes76OlFxBXVAU23wQ054Q5yi8rMg==;31:wCgz36jLuyheDMvjm0pJlA1unq9J0XPx0KwgSdZck2llFv80ZSM6uI5Ln5AIYAxWSU6Rn6JGMzfnOcZGeeTlvrsLIYBHoeTFr8q4jp/yUzrnk2ktaStx1rkVTf96LVqnHbHSCJIXPRZ6+FUTWn9JXoRY1WXwKh/2Mp5UmdCLFNuJ+HMBy4rrYk4JZLhdSs7ahfEwCl10uP6nfUD5r17tJ1oLjrYctDcyX1qnBL6lAYs=
X-MS-TrafficTypeDiagnostic: SN6PR05MB4589:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;20:yzsV1O6/Spj6xh6ITwk4x5xu6WfEa6jjxGvN12ynxJ3FBCVSCX7I7y+Jwj7OQlqK/MSZphdLnhyGZwGVEgdfrhiGzyhT6aBJrJVL7lrlUOvouVeT6GxnJTCk6M+2bdGr/79OcBQVVftr4vkkW6sCBHg2qAEkU69tKyYUS5TcVKr+enYkERtPcR6ydtPattbsInYhesRkSDvXp4aisjXX52hpkcso/bpMKUoyvxoRGOGDJHa4Artuc4UG24IJKsmZHR8+LAXdb4pYuEPkn6jQfoz3Y63ll/U+e71QEAIHGgtGxQjAHNNVbiWKSjV2fUYu8DRapyjqHM31NOMpkOTWhYICN8n5zbpUjM6QCQBSyv8R/810pdW4LKqxeOSIoJxw1FatgUVlFJ8ev3xd45I42fh4hip91tp13yNxdaFNOXxS/mIOlEY6wvBls7D1GTDPdG8GaMaXlJa70maaieptdClgDHOo/ACyCRrkXSlJcugJHJclWQxAdt/dgDITJIHq;4:x3JgE9i1R3DGZWhJm86jzCfR7WQeJwEW+zNiVU1RAeSkxQq+pwVWOqw/33fdiHNU3ZHpTjPL4MpMRJ+M+CBtSRVEHQciF0Q7USxvH8CeTZFYpQkS0YJ4nZWCesEJjysHHycMrGHrL3Z/HINNVf4u/Fych+mDjF5h7pfHHFH8pB5DGwpzMqmG6HNRjxqsG/18zCJtOd6X1vhS0W2GydSegLrPUn813z7/uOImYLNmgcTU1HbdEbH5Buz+MrW2EMUb9FoVZ6dzqQpR4V9DGJCwjtDGoxn3TbL9w1ABJYVWUI28dB8O8Rciow76YfCm27Zt
X-Microsoft-Antispam-PRVS: <SN6PR05MB4589DA079E789A38AD28AA3CA17E0@SN6PR05MB4589.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166309043207732);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR05MB4589;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4589;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(6116002)(3846002)(97736004)(47776003)(1076002)(50226002)(66066001)(51416003)(36756003)(52116002)(16586007)(68736007)(86362001)(6666003)(106356001)(2906002)(486006)(8676002)(48376002)(53936002)(50466002)(81156014)(25786009)(16526019)(551934003)(478600001)(476003)(186003)(966005)(81166006)(5660300001)(6486002)(386003)(105586002)(6506007)(59450400001)(316002)(305945005)(8936002)(2616005)(956004)(6306002)(6512007)(7736002)(26005)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4589;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR05MB4589;23:/mqrXcnI3ZBXyD5yE+IKJvm5C0OSoYF9ZKYWAKwS7?=
 =?us-ascii?Q?+UrFaMskvl5f6tzfbTUfSdbm+ByulHDQO0tmL8ZVnFyLzgzzL3b2de4gBtDN?=
 =?us-ascii?Q?ouZYzIMGFWZQVnOpZ2I1FS2yOnWp+c7+bPn7CWVBOBMjL+y3tzxLCgBd33x0?=
 =?us-ascii?Q?nhExvILF7V7jrb7cezUmvKc2yHVhGpSI1Pwnu+FM7WbSDfSl6w/WvD+X2BXi?=
 =?us-ascii?Q?A0cfy3G/sqziSJdnycPxePB7tFtMLztE8QfL5BgPthZsrodl6revF+F/Yeht?=
 =?us-ascii?Q?fkmqTXTCyM4BdJn79CUrWorJ0Z7QbJTJjJij4YXC6Ds5kvQb8W1OXa5i+7PS?=
 =?us-ascii?Q?8gBuSPZWqlouOhm8Cvb1VgAep1Y4+NURQzmV/9/DA3TzAut/0sjIdnY7rRqI?=
 =?us-ascii?Q?FgjOP5QzuY8TKpSHnjgmiyvMUEgFLOEbUpUSs9CqH6bc4d8zPUJom9vsl5rB?=
 =?us-ascii?Q?Ul8jB0Code5ZwjlOa2dEs+LXvnYUglXUFFzzG873bn+7NP8hRvB8uUQ0BPFZ?=
 =?us-ascii?Q?I2sBJQmZ3RCFAnw5PKZMxPOuqHVZy1COrk3j79AKtRohC38x1NpORd+sMh0b?=
 =?us-ascii?Q?ZvZ1MnP/OPAhfxXONxELj1MR2I6+Qq2B/dR6mDv3kvxVfCCSmKxaFEb4TDjq?=
 =?us-ascii?Q?I/j4bMrW54VjjcYrw9+wnQYg5CLj/gl1kvBcutTU0z5hzIELm2BFuvaAbQFF?=
 =?us-ascii?Q?TDM/IqKBQBTc40SwwmLZVxzFdkCNK8txxOWoW/1I71J872A1ITuWTW+zgp+F?=
 =?us-ascii?Q?s+YVWvKZMJdp0oRQlG6Qjj3x724QHFahMhJj44IesPH/CV9DH7EXkiyb7q7K?=
 =?us-ascii?Q?bigwF+Okmo/DJgeRDsMNYYKGQu7JInQzMpK0yaReO99mn3w+tncgn+1Jl8Th?=
 =?us-ascii?Q?n3rnomhbTUi07jRI5TFG8mfN2RQ05WgHRIY5pMWtki8nimF/9ENgxPqc46q6?=
 =?us-ascii?Q?9i6AHhiOWjZc8TtYk5e/zzQsUFBv+int0YgGvvhY56zn4Ev5VVa3wWrF1X9j?=
 =?us-ascii?Q?Sn7JlFMhqHxlGHaGTIGmEFOTYkUWdbYlgQ5LH986jG7vKinDVIPZ+Y1vj0Qr?=
 =?us-ascii?Q?lHzWKFOMd7nntVaq8ww2NOJQflbiJnOwA/jhWQTK9+D04MK5963LNNtDDmWK?=
 =?us-ascii?Q?WmczTLLeWxsHaOXNTaQTth4lnbvHSEQtGH4v8J4nd6v4PL+LmNygnPxS4eLQ?=
 =?us-ascii?Q?6j1wS0B8hHZ/E4TGl4lONncdpC/d9sF4wpZFxcczMXm8QQySievry9cjQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: DHKNY/0yZVRC9I5Lrp8EM9edynRHJyd6RIhq/aV7udK2TKM7c+S5/9wnDLH2Vp6dLPKzf8wfSukH+DnZEDinEcSFDv2goDGWVDdlNIFxMj+eGNjekSYr01q9xVOVadw8cAsrOjoftVZL7x4TcN0GflQsJn1w/XCv4YAYA6N4tpOSMSzWTt+U71i7SKi9Mc8I
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;6:GB2FKGAlMyU4KH1Vv6rM925B657dQvyBiiZu23mUwxG0l2jWpf5zBMEONSUx3Gak/HSaaFyrdKY8aH3OVMmZ2UIzMAHnuqtZJ7S2xwabLGJmPMpwe+KDjl7PM3uSmvgdU3tpLCeg0osVAv8B+L0oFCHoKfkEuIsr/a8r9rPSAEqrWIwYUqB1mQG54Ze6cllRM/LEt4r/vZ6hhFvaufad9DrDJAYin0VUVfMBaQIuP0a8RvKh/owfEyf2l8qLlut4SaDTbZ4hBqMPidX+ZqN6Bee98YzcOZ99AWulR6wgtUi/g/ZFjOW9AAwN/rF4t47n2xNHO/DBc3w0/wCykAYVG+/GNjRGfgXszdWyPhKsUcU0HrwKnkzcPDGc64lpWMOacmkj0ipmNQqe/2Bf1BzrUB5/vqeC0yzjT5xlx+rj0iSuVuPaTqvmpw9c+NhzXDR0KWtdQaQuwAqHOIl1Jg4+RQ==;5:5AGgtTHz6Ow+E+QOHLe/TwKSIPEJfputOZ6zYy513U5YuWhKA5DuQzKX0eSPiSqWE6E9gdvIIQMy4IF6nCBZeDjXd6oDcdEXPKy9ai2qz+77IqYzDC22aWlFws3wOfUOEQqYadsScrJ/gdJzmgjo4sp/xFDSP3WC2u/E5ZEJo0g=;24:9R5fAFKE1BmvZ33O9IahZ4SleLHB143e1nAt9PN79seXG1+mcyYrY8ywUM6yjjo9O1YsO9xjVNWMbwI8HzmnWajJGo6eqoPrVXdsCmkI/vM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;7:fBSxmfeV+7eLFbSQhoEJ/2OLW9saBOPXU9bbKOhmXgOM/Y8r7fF7yzea8oUQ6c8DSykx1uxNqp1nX62HD00A1dDPcQgNCwuQNQD+VNJDWQneJypTfszO9VG9kG5KzDDMoz+Zzf1iPDl0hrETVNw2vMrS5a18Bb6/q+/7SKtvYZ0IlcCl+bxpOtbpSzh8pRk4JgXI1AG/ZKY8WagqkbCW8Hq9lR5OmUwXP+NcxPhn25hntfiPhBwKcMiq8mJ13rTt;20:4E+C6PetRVDYIRCERCTA7160F9mN4vW6qF4L3xYsmQKv40u+tblxdh3PHTaulny5lxUkeXsqMqPsRoMxnYs8bJ9koyn8qR905YjTMHp08Xry1tOJPGV0pU9HkAM3BmgwxZ9csdVW7zQp61AZ55wZolQLIYEYH4ASa7JfmWFbXSE=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 07:48:14.6803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 961a1c8a-6d90-4d8c-9744-08d5d1020574
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small fallout from a work to allow batching WW mutex locks and
unlocks.

Our Wound-Wait mutexes actually don't use the Wound-Wait algorithm but
the Wait-Die algorithm. One could perhaps rename those mutexes tree-wide to
"Wait-Die mutexes" or "Deadlock Avoidance mutexes". Another approach suggested
here is to implement also the "Wound-Wait" algorithm as a per-WW-class
choice, as it has advantages in some cases. See for example

http://www.mathcs.emory.edu/~cheung/Courses/554/Syllabus/8-recv+serial/deadlock-compare.html

Now Wound-Wait is a preemptive algorithm, and the preemption is implemented
using a lazy scheme: If a wounded transaction is about to go to sleep on
a contended WW mutex, we return -EDEADLK. That is sufficient for deadlock
prevention. Since with WW mutexes we also require the aborted transaction to
sleep waiting to lock the WW mutex it was aborted on, this choice also provides
a suitable WW mutex to sleep on. If we were to return -EDEADLK on the first
WW mutex lock after the transaction was wounded whether the WW mutex was
contended or not, the transaction might frequently be restarted without a wait,
which is far from optimal. Note also that with the lazy preemption scheme,
contrary to Wait-Die there will be no rollbacks on lock contention of locks
held by a transaction that has completed its locking sequence.

The modeset locks are then changed from Wait-Die to Wound-Wait since the
typical locking pattern of those locks very well matches the criterion for
a substantial reduction in the number of rollbacks. For reservation objects,
the benefit is more unclear at this point and they remain using Wait-Die.
