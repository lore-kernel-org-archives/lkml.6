Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D216ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12532084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Zy0jvyFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12532084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbeGTJ06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:26:58 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com ([40.107.3.109]:37367
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727331AbeGTJ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7yg3MY1NA+AhRolYAWJ0kiHuFFxLIjBiaA1ntjpiBk=;
 b=Zy0jvyFNUQKIOrQI9+dmGOpEzDjppuwMG8LcxlIcCSh7Qce+z+2P/pfoTS0BsMacQrBJYGgxj8pa39ByTx26D1PnBZo3mTDe1USa/w9NoEOWl+yRMzUnFOQ2Ijn4Xct+PNxfrhPcnfuC+Babizm70oka3LHqA72b6+B+rdcOUU8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2459.eurprd02.prod.outlook.com (2603:10a6:3:82::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Fri, 20 Jul 2018 08:39:41 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: [PATCH v4 2/2] i2c: mux: annotate the nested rt_mutex usage
Date:   Fri, 20 Jul 2018 10:39:14 +0200
Message-Id: <20180720083914.1950-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180720083914.1950-1-peda@axentia.se>
References: <20180720083914.1950-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0010.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::20) To HE1PR0201MB2459.eurprd02.prod.outlook.com
 (2603:10a6:3:82::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bea5e6f2-9a86-45fe-7c84-08d5ee1c566d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;3:NISYvXnMNjZ2rx5YMAHaoxMU3Tt2kor5d1CWSJIP8cAmaHFDsbCNqcDqJlPGTkUtFEAorF011UhvVqXbn7l3od1JXQojN7K8H8uP/acm0WpkDK/V4+ubwOal2s7URxoR2cwTS1hyIh3S30ubUgeXI4QzNI5G5VPgQJqX/VJG/gMssR3vuYQcA5iHYWYYvnKi6DcOp/pVpigr/kKemiWuNphvszviHObZUtiTp1KM9HEe6gz+JGM3dNZ9igtNtXzW;25:/lRD/goozs0znbmxwAvHvVG0nlJS5VjZw++fZRfNsyEvoI1A9KlyKayKswoNTU7arJq+u+nEwG4Ge1wBE762X+3J6ysDOVI5kPaUOl6HoTMh7BH40hi9jWQU/XwRwoSLGrECR2C6SMkI4t8QixqnX1JUG59gnZvLMZ7SzLfydLAQrletZE5G/1hIpPMalWcum00huRF/lBF6Cj29Vfs6/YdbX62JY8cIDk6R7ALBzeex9Bfcfb9HtxUoK6DV5tzjuJ0ziAsLyfguYOfudXDVOKIPMcysU4suEu4K88vFpy59sHK5izCw+VyXfnQB5Cm+35w7eCkej5n0YyqpkwI78g==;31:f60LhUvKLPaWi9JpdAdz7vKDfojvzJUg5WvHYu2FuennDNHjdgt8nh1Bzso2mOP7Diz++wsQeAVGzG7K/a+Df2RfAm+Pl0fZM+j93DRiYXQdrVwSygnX3ph3goCc4cEvWj+Nig6Ma4tNsMt7vfW92n4EkbBkqkkw7lXcE+4ZbHHJsXCUncbDLMdTMAPfR/aAiBNfNJSP9Uj8raHDeiFz2QU9NJxur2LmzkSsmTEIOJI=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2459:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB245953BA25A8E416F8BD4810BC510@HE1PR0201MB2459.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2459;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;4:d3beZmDFYD19cI3rT080+zeRiUNF4OqciHvhOM1xsggzMedkHalQo5+l2JIiuzMcbAqUkQy3rhYxkQgOvQj1OWpxtYbJeSNhbS34P9b7k/Q5/0lY3F/PXxBa/QB2CbbAAMnSAoxbhMXUxkm9eRnyH88QweVolCGLzHmvbzcKMcgKutIOsK0Rz33nMHGGY8nr/h7xNWNpusRaXcFAPafK9ALloVJ4IKnqmoU2f1KMppaqxtVKNmweDm0bdxe7M9VTaZUYQWFDNG8y12glJ35dG7wmTYvhK2rnDH+9zrqouBt2BlyDdTZQ9kXQGiwK/HRD1cSlBV785+F3uJnjgWRiRM5TJjXNhZeQfj5Avbu/sgM=
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39830400003)(346002)(366004)(376002)(199004)(189003)(36756003)(6486002)(47776003)(6512007)(478600001)(66066001)(4326008)(7736002)(14444005)(26005)(305945005)(486006)(476003)(11346002)(446003)(25786009)(956004)(2616005)(50226002)(316002)(76176011)(74482002)(52116002)(51416003)(86362001)(54906003)(16586007)(2351001)(106356001)(6916009)(6666003)(105586002)(97736004)(6506007)(386003)(68736007)(7416002)(5660300001)(16526019)(81166006)(8936002)(81156014)(186003)(53936002)(2906002)(48376002)(3846002)(50466002)(1076002)(2361001)(6116002)(8676002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2459;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2459;23:NargasxTfMpRDPFZz6WoYsuy4njMfE7E0zjrgA9?=
 =?us-ascii?Q?Ui119wIwi77hebGyZW8NSn318WEJ9fRpEJA7sebjy66rSgKV7vWkJIUAq9sO?=
 =?us-ascii?Q?iUttBoLl42fA5O7GcwEkS8ETimmAWOyWTraULHipUHcG7AV+Gmoi2B6Zrlhq?=
 =?us-ascii?Q?FXdTkO8of3cNq5Jm9Wy7iR4ZWvc/FDxt9W41SLI7MVnrrETZLA+eV505ZivI?=
 =?us-ascii?Q?JbruYD54YGsXOe1I8zvilbO5peiFTD3mqX5Ic2ehhROI1pizfhTozwsrjVyX?=
 =?us-ascii?Q?gkS2o8zSbWxaNJVY4fNj4eYVwfDbKRL84UI4ZQry8R31dXH/IMuN8F2qJ7G+?=
 =?us-ascii?Q?h+VVS0uSZjLW6CyZkyiwUt0mblJ7gvDQJFjUm1R1cfKuDnz3dJh6+YWwSr2r?=
 =?us-ascii?Q?3/qhr+dHIn0LGThtifygFZHx8hi1gVcS7zslP9uyYeBcQiiKeArpkCw5mB+f?=
 =?us-ascii?Q?lJSvaW/Z1VkV1+MH8tzOqygAo26xAeAq6hAscljj7x6rjwEvJNuo33JpB/Kl?=
 =?us-ascii?Q?ljRzijVY/pTkJkrPpXFIjJQQ089LawAkxglSbPf8PmFhJGnPRY+ZFdVAs87U?=
 =?us-ascii?Q?zcnlUGASg7uzJasZ7scj4EThpiSIAISb1/4mDoUIQnf+8fcFgv8FVqbtB3Mi?=
 =?us-ascii?Q?7FQSU8RwRkmcg4R+n9bDH+2CUz3GmIgKs7YXJ3P9+JPTKJgRy71NNtN0pHFr?=
 =?us-ascii?Q?ss+pxk+0qfElCzEmgGqkeIBS8KlST0vsbU3tS3x0UHNie7sSR0fPFmVj9LH4?=
 =?us-ascii?Q?GeMuALH/rVxKX3EEHI9OLD/uyQAMZekMlGxdVvbMK4X7et6o7bw331yoISzK?=
 =?us-ascii?Q?Ukh1j6oL0fk85oPriOcgPHJYDuFHNgHZhozs+MovIwKj4oOm0DW0YJZsenul?=
 =?us-ascii?Q?zKwmFEZ6kK2zqBYrdBq8CQJpbIKFi0aTUIY2SdCdAebi4EkCOiuRxLqAtg35?=
 =?us-ascii?Q?Gn+GNepwL8ERS2CKtXGISK9Hf049f6J9UCcNof8rGouW96quSsPYMqf5U5rl?=
 =?us-ascii?Q?+6pjv4GxLrWdm61FbnTnE49tKVGjf6bT5I0IZ6NN8prF/B9cwCrzsL/9UMel?=
 =?us-ascii?Q?nPn4jo61AOiW3YPIg3G10Ot7IxTvhXNUnpXhpc8owIZwU2Hnsx3/3INCms+x?=
 =?us-ascii?Q?VNXnAnuZVHEO/iMlmYb9aFFcmoElwV8quSL7oGrDOrwnuY+gbFQfDTcDriUY?=
 =?us-ascii?Q?LB8oXAIRLFfU2cb2NVFBjHLCt+Dsdb6i0MIyJ84ObjhuLWbyfI318raUfL0r?=
 =?us-ascii?Q?M+pVuPWu13U/59ao+6A9/ljLQUqGoAAV2GP/BGmKL3KDMTkyESn8Ba3z8u+N?=
 =?us-ascii?Q?5EVtEttEH41G/d9bUC/R6db+gpLt9PFdPtPaI/eQ4faVc?=
X-Microsoft-Antispam-Message-Info: F8fqTrBErEPZF8WQ2iAFVC+BuYXZ8i0xtpbNDm8FICA0CB9+PTIXniFfviRuZu7nfCtAxU+LI6n5HO8lbhypGc2aZkFx77sUqIbdJMmyZcK/HCtfJwcuHnx/NBxmulxXFVnZtyiaVVwAi8/yiNPoqfALXRw1G5ZaPz7Z9Cl7hYeAwNfPTWWElzBdtO2gM6boKVchJyBP9d18TdgS3SOb1u6GmY9yo3R6zZPQcJdCDUvw0dJhJgAqgTp4UkoiKpGtwru0aop1hXNIwXTZu/5Fk8Q/B0i7KLDvjfYEYClMfdFFpNpUzNibxeVGxamm2q0kmh7IrOcatzZNf4Vnq9ffTi0Z3D6TIDiv/HdPB6Gq+5s=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;6:85Yzcl9LxbVoxJ09WgzPLwRWeLWH0pL4nLQzaffp0+zApOHf7+faKEUj4qvlTuJo+vgjDc+k96ROOVcQV1ZAe9YOmYohskIl2u39sD0J26WjdDyb8C6ssReT168iIf8uKzI06YeE/Nu/t8DFxlD8PYvpf8834VQxN0Em6JRchFrPXhvF6R/kgg5mzoAlEevBf3eEt8rffbZtwU+jlkN2RH+VSBWNyAzev2PosV6ine0Wmc3sj43USPxk34RByolp1WiYCjJSHQ7F84gPLPcgD5mDQjz+5ckH+re/7tx0jooa26Cdm+Knl18037q95XWWd9+PW6esuUXOIDtUdaPYlkbzxuPn65ghWhvC4wha0pkYW0j1v4fcmIkmpg9zNtZZKpo7Camf3ABBqa3Ivk3iSqJe7Hk36a2uZspsBSjKNVyR/Usgl2fLscsTgdZvzFd/jmPEdkFLbzOOkq/qgKQojg==;5:0pmnx5VdM1aB4/1StDEEhLCKMZpdqtZY3mjmcH0/uoGH3kDTGBILavgrT5FQ2CM8ieNA45Aff/yxYLqG8tfB5x2OrQ3IQQw58bb/58/Fi/YOi5i3HJLsCAvq0mfKVDKOxFpb++1DEztFosv+gWQ50iASyNVeU7RYkQX3dQCWqwo=;7:eHtkm4uYudIeWA1qObuuQjJpSRLASHe5KsstXzPAH1rtMbtLWR5H2LsT7t9qenx5VY/k4gH4Q/qChaFkcus5iX3keJ4DFIH6Kq9T8EfiBOlNe3ub1AMXBtgqSGmshPuiWMoxpbWKaxDlGINucNCsA4BWwDw/syVle8W450P4Q+Ys+P0qm+xoHpNA6bBGQruk3vqAiglBd6a31EsNL1sxeRxfl5e/tyoIGJHG1x0L4Ln7HEjQ0k5Wsj4qRfg4AN8I
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 08:39:41.5851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea5e6f2-9a86-45fe-7c84-08d5ee1c566d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an i2c topology has instances of nested muxes, then a lockdep splat
is produced when when i2c_parent_lock_bus() is called.  Here is an
example:

============================================
WARNING: possible recursive locking detected
--------------------------------------------
insmod/68159 is trying to acquire lock:
  (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]

but task is already holding lock:
  (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(i2c_register_adapter#2);
   lock(i2c_register_adapter#2);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

1 lock held by insmod/68159:
  #0:  (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]

stack backtrace:
CPU: 13 PID: 68159 Comm: insmod Tainted: G           O
Call Trace:
  dump_stack+0x67/0x98
  __lock_acquire+0x162e/0x1780
  lock_acquire+0xba/0x200
  rt_mutex_lock+0x44/0x60
  i2c_parent_lock_bus+0x32/0x50 [i2c_mux]
  i2c_parent_lock_bus+0x3e/0x50 [i2c_mux]
  i2c_smbus_xfer+0xf0/0x700
  i2c_smbus_read_byte+0x42/0x70
  my2c_init+0xa2/0x1000 [my2c]
  do_one_initcall+0x51/0x192
  do_init_module+0x62/0x216
  load_module+0x20f9/0x2b50
  SYSC_init_module+0x19a/0x1c0
  SyS_init_module+0xe/0x10
  do_syscall_64+0x6c/0x1a0
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

Reported-by: John Sperbeck <jsperbeck@google.com>
Tested-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 drivers/i2c/i2c-mux.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index f5ec6ec6776f..1157a64c7be3 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -615,7 +615,7 @@ static int i2c_check_addr_busy(struct i2c_adapter *adapter, int addr)
 static void i2c_adapter_lock_bus(struct i2c_adapter *adapter,
 				 unsigned int flags)
 {
-	rt_mutex_lock(&adapter->bus_lock);
+	rt_mutex_lock_nested(&adapter->bus_lock, i2c_adapter_depth(adapter));
 }
 
 /**
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 9669ca4937b8..7ba31f6bf148 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -144,7 +144,7 @@ static void i2c_mux_lock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	struct i2c_mux_priv *priv = adapter->algo_data;
 	struct i2c_adapter *parent = priv->muxc->parent;
 
-	rt_mutex_lock(&parent->mux_lock);
+	rt_mutex_lock_nested(&parent->mux_lock, i2c_adapter_depth(adapter));
 	if (!(flags & I2C_LOCK_ROOT_ADAPTER))
 		return;
 	i2c_lock_bus(parent, flags);
@@ -181,7 +181,7 @@ static void i2c_parent_lock_bus(struct i2c_adapter *adapter,
 	struct i2c_mux_priv *priv = adapter->algo_data;
 	struct i2c_adapter *parent = priv->muxc->parent;
 
-	rt_mutex_lock(&parent->mux_lock);
+	rt_mutex_lock_nested(&parent->mux_lock, i2c_adapter_depth(adapter));
 	i2c_lock_bus(parent, flags);
 }
 
-- 
2.11.0

