Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935719AbeEXHdX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:33:23 -0400
Received: from mail-eopbgr40097.outbound.protection.outlook.com ([40.107.4.97]:45125
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935691AbeEXHdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:33:15 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-i2c@vger.kernel.org,
        Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: [PATCH 2/2] i2c: mux: annotate the nested rt_mutex usage
Date: Thu, 24 May 2018 09:32:55 +0200
Message-Id: <20180524073255.22495-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180524073255.22495-1-peda@axentia.se>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
 <20180524073255.22495-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0174.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::22) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:8TJyck/aZBTSTwN2XXPMFuuG0M8skH9uQkp9hKf/eHmqhAbmZ0zJsXrlmyAzdXNqNPiAq7U4JdtrAuA67ZNmot1N+sq38CMlfQfVB29GWPdQ3nIheuwaNKTVTT9WWXL56NkkxGb0MT+coEWqJk1GP4wq48ZQRDitGr9gESqD4byATlXm1UAbD4DeBcyNkcEBrpOJMpHJP22UGTt/YCBaPe8wSv8oM001/hx96MGy+EIwQfMxfIK+W1t6vLszmMiy;25:JGFLq3U2IH4tR22TDFbSj7SEHh5jG2/cTK0fQmye9fPPWTxh3wS72cJwrOqfRrJIoSdEW8EQnyvt+RrwJvcSqb+/9i/S6eHSGqguXPhauqAzVT5K88KZs8YVWZqYhJvDehU8H3zaYYXOuIipGbDO1inF9v+CT81Ag/Zz05hESI2PkLWYshlhXtEJsYq+gGejHF1WfxjGS1ir/YSRqPA/QZtwhWLccl8BfgH6SU7EuL7MpZf7PNWdgscamiRb3yOiwduscIrQGTjz9Ff9hXqyeS25798fazAELU5SYRIdHhtu3d36kpfHMor/Cs3hNsRRTbLVy2+trUUf1mwPsDJuOQ==;31:wuaxDETRAdoVPsJ0UCZSyjgmZELOzAE/rNG1ILHe/8EGLptihaSaY23qHgq9Zqcg7ovuEKrzOJySUUn9gxZ1tcc3yQC4BaCcLQCwNz1DBT1UpcNbiOih4B1FavZZrRA9khWAcJbPjxGvoEiC0m2x03mNp+DSpXdTagHbQygifxRBD50+SwAVEsKF2yzldctSrO0txw/0WEz02vA4WQ2t5bfX/Nj3PlUM9hrhNEqbH+0=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27769F554DCDA88C309A8B01BC6A0@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:kaDhrazU2xwWgozXxhF8kO8qELBuM4UiUn1eEba+4Wa46V1f/76kzCifIoCr9rSgjAEy+oYVOWwOBA+saQDv0ypOK9PhIXixUlHpRPoWVngsp2wPWH0H6i37tWXpLAjTVm6rlTk4MPhSnjsanpZc/NLENWRKg483ERyP0j5ALoW3Ta/hwvh8owyGPEV+kZPX4BukOLbuYHWYdXaNngVbMtaHOFRSqZvn8KC4CTj4M+/e9s74MUih03pLlMSNedQSh0yFMkkOTSLJEqmcK+Sf/3pVxAyzxo9fPQs47RqBe6TppcwIluLuubZmFY+pYipcAoXAd4EX/ZRu/1TrcXeE7JbQ/IbdSOFPeogTaKgO0d4=
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(366004)(376002)(39380400002)(396003)(199004)(189003)(36756003)(2361001)(50226002)(5660300001)(2616005)(956004)(446003)(7416002)(476003)(25786009)(8936002)(16526019)(186003)(486006)(6506007)(386003)(478600001)(66066001)(59450400001)(6666003)(47776003)(26005)(6916009)(74482002)(2351001)(51416003)(76176011)(52116002)(86362001)(68736007)(106356001)(105586002)(1076002)(4326008)(7736002)(2906002)(6486002)(48376002)(3846002)(305945005)(6116002)(81166006)(11346002)(8676002)(81156014)(316002)(53936002)(97736004)(50466002)(16586007)(54906003)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2776;23:SQziEGjIao4fFHtihUOwK0lKf27VI+JjQHmNuu0?=
 =?us-ascii?Q?WLtbJV/HKNHu25VCebB6KyOE0/Fo8l09YW73cIqEqArGgGSeNMay6aqk5XVZ?=
 =?us-ascii?Q?srE3fs+KDjmPolFZpex9kgewiiXedZ8V/FW3vJlIVH5XUqQ5NLjlS/Vgid9f?=
 =?us-ascii?Q?1ZLGvjO9xjq+L1qHCtKAaZ4WSNf9/f8mCrPC54+j6VbGaHcEBfquOit6b2Ur?=
 =?us-ascii?Q?quSdl8rob1H2amAXgzceSYJvx3d/RobnQ7e64WTWt8u4touEYVvxz0sFkpYy?=
 =?us-ascii?Q?bQjOul4uC/zEid2dgis5ETHEAz4VeqzUZ5y96khl8c9VaWEJhXXplJjzldTS?=
 =?us-ascii?Q?HQG+ynAPBuMZTgbhOl3F7fl6uXGMvyyS5GbUIbHT0tf7BLOD499jVLnq1kQc?=
 =?us-ascii?Q?3eFmeFyqi6OU2j5cpdCZei+jP0h2QqIDSt8Kk3EJTAKq89PPhId2XKN1M5hu?=
 =?us-ascii?Q?7XihHTEvNaptTWwJlD6fQqWR7O+o+uhsgGnvsQKFfRvUVb/ihr3Emou3fr3G?=
 =?us-ascii?Q?2zKoo3EcSpyMqGX7v9HQM4wdnW7l3Rvvls4HHE2VWqAdZlQHRuSWCRzEjCuQ?=
 =?us-ascii?Q?GySt5xalOG7WIkNRPdcBmZo2idircQ5u5y3TrHqsS1LbgVPjjWJ5cujV9OSi?=
 =?us-ascii?Q?P/hQExBMTdF7/qhpiO/egEDRpiSrUd9W5fo9jIxBB07pGChsPOZfPkKz3i0X?=
 =?us-ascii?Q?V8gFZQBOYDZgVRkQY3lC8r47vd/g3FaUZ+ETU5oSrFQLrIXnLCd4BzpiyoV6?=
 =?us-ascii?Q?2jKL/Ea6WYQnQx+cqQwMwZV46RwUqn+hWytEz7mfqY82j2yKaNCroGtZsunP?=
 =?us-ascii?Q?//IzELoTZainitR5OiAeBEz2EMWgMyEI0GSAwWw0E/TfLA48Z/dTP1BzFU15?=
 =?us-ascii?Q?js9uiQyC2fvxb1mgVRpKpmEupsHkZXnFoWQ7zNPPBAYOto6gyWP/Z6iYGBis?=
 =?us-ascii?Q?yqxPINMvtWmCtx6TkusHE28heULhfG1isJiyZrGFZ/IoXZ29nPOfsMnrG/Xz?=
 =?us-ascii?Q?26UEDGp57avkCg20ZOBXvHSB+GD8lE9FP6W/3nEsVflownb8B1ErC5qpGIl3?=
 =?us-ascii?Q?99QeFaHPpFoosaQE3/rH5EkBySb8YeMNHSJWKDs0jFjf/jfXcRX6gQi+i5Vz?=
 =?us-ascii?Q?u5xlgASeJ/Y/2Ym7QDP65hIgEDpna561+wYRGx9cSSjCQGg4g2R1rs4jfiv1?=
 =?us-ascii?Q?fscXCyN7Gku7NitxIiqS5DiujEHrxC1zJnMv/UJB6gJdBnMYOSDbMUWJ1dSW?=
 =?us-ascii?Q?/WDXig1tLZqE04FWc1Y+JXEXnBXGUzhwwTAIowc0RXufTvMSQxC9LU+YFXcT?=
 =?us-ascii?Q?3tozkBBYzBaxPhg2ivQfWkA/0sH0JaVKXmSS0OYUiFfZw?=
X-Microsoft-Antispam-Message-Info: zoILtnXzFkprXWtxt3OkOoAPJ6Gh3ZfF3HCVpvQmrRY95Poph444vYJyKBQXCF8jmjVdeOzyE3wOTtP55AmWoljjZQMXzKKuzxdoSF94pGdSKcRg2cdW2+b37o0QagGXAgmH4YQxGbtK/DV5g6I54L9vvQ7poN2wDbhZnU1dl5nBYaP8eptlu0YNTyeQux+R
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:1lqlryX2QyaQGu9s/t8tmLNV7TPwtskacWP6R1jYAgTmAbl1P0cfpqiEd/p+6qRR/czQxOOvzzJ785DEZnbC9Vw6LJj0Qu4t2dmM7AwkJtBI3us8sNMpCuZEXOyjtMOncW9SZdd7V8NLjZ7qPyNKH0jUBmcLprLfm8TTuEoVs1mG25GqdW2W+DTzD2rE42bRPn+W0SIEDOde5/cCIhdqDQCe/IKVdLV4tJ9aeFPVG6duXPwzP+yqfjijclJc8SwH7PyTz8mJlMdfy2MDgaAnzvD8vIfWt1z2fcphZHObJpTP5OF9ZIsIKyYEQrdt0Dt6ZGoDQqFa6ryBvr4AdXrkmiOJi5tmvzyUa9+Am7scrZe17L4ALJtSuHAoul63dmJQmk8BLRuOpfW+4HR2Upq+4A8sJYQrmHQi5/uVzplAfW4Bmb2qKsnl/3L1DMFzaWvLC7rZ1qdrM+DaBLcnkLKCxw==;5:9q+bGn7cg/LoCQGe43cufOSUPr6pYM5qSkRBG+dOiLAmsJ2V3OT1rOqt/WcOAuALNjTk+tTI8xNf3kH2cPVBflstfvyhTEDZPeZhYkKSA4SCGpg2Pw4HP8eEHTlKC5x+PwcAstf309JPyNj6a3/2YtkzUWdfcJzbD3gZWqAaC2s=;24:pUuw0WLBFH0jWJTFrvmztJjheWIN0+llgQM4QBrayeDP4OXS5QmNdx2GaX7fMhfDJEfqDVPRGRFsL8jTcxg44Xg/pia4Nq9SWjPmE5ekj9g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:KR+inQyaLNLjbq4KUQrrwiu7AH5ot/6bcJE0XfBrzPkzOFedJ7YYwn4faPD5b06w/v9/UxvmRRF+pKYkqBxY9w3oFbVpOshMQYwAifT3jPyt45J0S40SG1LZkY+347n/V96gmfzC7alqf97LNg31npILqwf5N3/zx+K4aGEm61qsVkbDCvRjBMHpgbJcE0IKgeQcE/gKLsn4Ex3aYQGMjkTZcs/XdjqbRM39Kx8lm/uq3FE+NROPqsr4zKjy7Yb7
X-MS-Office365-Filtering-Correlation-Id: 5b5a115b-b35b-4716-d5fb-08d5c1489b7a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 07:33:12.3430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5a115b-b35b-4716-d5fb-08d5c1489b7a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
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
  #0:  (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50
[i2c_mux]

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
