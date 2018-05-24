Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970102AbeEXNxI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:53:08 -0400
Received: from mail-eopbgr00093.outbound.protection.outlook.com ([40.107.0.93]:13536
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966066AbeEXNxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:53:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: [PATCH v3 2/2] i2c: mux: annotate the nested rt_mutex usage
Date: Thu, 24 May 2018 15:52:40 +0200
Message-Id: <20180524135240.10881-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180524135240.10881-1-peda@axentia.se>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
 <20180524135240.10881-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:7:66::22) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:luXPWjR/wAjxa1dDDBAvo4qULH4NuPvQWLQ7Cxt2zfoVKPsXMpBA46WWbju7Fad5fcQL8D2Af4ILgM9PomOg7vrvS5P7fFWLBit1FYlahG0Ij2mcFiBREMdoc2miBZI7pIR3CSXiyNYEnm0A+mdJyGCIXWCDeio8q9n7Zcflmoc7HgUekKBpD7c+sbU89FcdI3fdlnxcv7nFkdw+Ny4vENygKNZoElGUwSYdT0JGDA/KQgS4Ehdq2aV/AgnnSUNN;25:AOAd3PQXofzzFP7/fT5OtTrf7pSGtBSaqfaxgEX2ClP+BJzYDlyNw8ZBftgEgtM5V77ybIgMqNy8LoOZLaNkyMU5CwVVDmZj5A93ul7CdfrczuhMNR8B6LlIEMKMCbi0fHWAw/fgZGPAdrQ4hQ28jcvy16et6YJc8Clb/ZZcfaVlHELq82DuD4yXj0l0kI9JPuE36lUD/3nBDfTbo8s5JqwXMw4k50Pz7ydW4LVBx6Wz/uKvo6O8H/k4er/jM3lKmcgk+x78mkhATQ2FWG9+M5GrzwRDgHJ0A+vvB3yNQk+SxoaNX94LzutJqlWgYNfr2GDju4hqkgu47Ucw/gb/uQ==;31:rOIv2AbsFsiWrcUYqdLsLMiVasYUQVa+HPhfrEJj6u1FlrR5mY6JR5dV+f2doXhjYBuTWQGN/pPQGIBAp08KfbNmvsb7YuFx1Nti469ggBUtCNAG5J7+L3KzH+vsUjb9+R20+yE7puKFjC2HI48t2Y3kw+iv0SRJZLe1kUulxbFU+gBd5NTQMaIAxbGk3uf37tiAEn+gjexbPQPCn5zNDRlzS1IAlVNI5zQkFjpCL7w=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782FC643761AD98AF43481DBC6A0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:PxdhV4FRiBG9On9B5rLlyQf/mCWhvtmhg2EEnd/uWfBr+Oqif5af9mzjxd5xHFxqfnioUTUKUXNuDQeXpEq2QbtKURnV6VLX2M6j6/LdoLq+rdPqBKGyzDjiOvDNMDuGB3DqDIt0ENWNf8uEHzR4GKBw7xDm46ugxXFWVCCqTanvWepEHXasJDx8yLfRv9/iaIKsB+I+fDp/lluVsu1hiqBlH9LFqPOX5gfOYjpSyvoFYiMrg+f5T1/69X86CsHGy5ojmXHJaYEdOKlUE5ZJL7t3qXDZxn8ODP/Q3w2vKfj9BQV+XND46b5mRlBf32UN3qut1b3gN9WXmMvscz2WaILs3qb7PHrejSzgHP9r9ec=
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39830400003)(396003)(39380400002)(376002)(189003)(199004)(25786009)(8676002)(8936002)(305945005)(7416002)(86362001)(7736002)(16586007)(6486002)(76176011)(59450400001)(52116002)(51416003)(2361001)(26005)(81156014)(186003)(16526019)(105586002)(316002)(6506007)(386003)(81166006)(54906003)(106356001)(48376002)(50466002)(2351001)(47776003)(50226002)(66066001)(74482002)(6116002)(68736007)(478600001)(956004)(486006)(97736004)(476003)(3846002)(6512007)(446003)(11346002)(4326008)(1076002)(2616005)(36756003)(6916009)(2906002)(53936002)(6666003)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:5tjFAnEJnEp29ibaWKNbXF7X26k3nGAsk4cBX5z?=
 =?us-ascii?Q?oldnjUfHDlR1uPDnX5HJXzZlbfkEu0on1vt2tS1yfWgf4Cd0gM57WjHvSmmQ?=
 =?us-ascii?Q?+TIB9Dx2cp7Fy7C9dBWKDOWyb+zVSg1vA/s4w8r5YQDY4gXNqGvfRmGh9ppU?=
 =?us-ascii?Q?NvlXpkCxTKB/SR/EgwzqjuxOG7yj25VVseGTdUD+NOyQGxnSnbwR4KaOfVhi?=
 =?us-ascii?Q?m9Il3snFj7fSaMNBClz2gNH2Qa2tcmpzheOgOZmza48fG5cmGF5cthEpY8vY?=
 =?us-ascii?Q?SiSceZRXgzgNLx84/pz9MNzbobGuj+PMWvEgOEq7Xn8Cg5kKLxKsjkrrgIuC?=
 =?us-ascii?Q?m58R8QX4UNkRZG9NFShtS0m7XB/2GSWvknBCcCC0MxVx+VY22w4AVK72rw9F?=
 =?us-ascii?Q?hNBtXRLDCnIHs/P1SzJ+4LHPA1yCxal30rt66O2rYWfodWRhrsMqXk1W3/Va?=
 =?us-ascii?Q?tuXh4i7+WtjgyUg0tg2DUGUPmSxjAe7JMGrR1g91lNc2FvvYtPiJJuj5071J?=
 =?us-ascii?Q?DSnTR/4DuWCJfYPyijc1SuaiMjSfgbErMMEPt0hAAYEhBFadUUkYSUMoIBVp?=
 =?us-ascii?Q?OjWjbiewBJ/62WGzAltSv6OwIohYAq+b9GZ0MBDN6VfbRKtrTIfsxW7n9tmT?=
 =?us-ascii?Q?WZv2ihKWm8zQiqDXwykFXcOwsrRaeA2Jv340526M9ozUkJ+1x3B9HOpbMZ8p?=
 =?us-ascii?Q?Ul+HpbFtfPAbMyCMokBsn2G2hRP72PODbblajiBJjsJ/LgFLL+1dYVZFG3X9?=
 =?us-ascii?Q?KbYZo9W13wgC2KPoau8uGQ3g394DUdSGmk7KTWk2SdmOr9ieHIBCoxatrqjy?=
 =?us-ascii?Q?9GvDtR5110+B7SOk1VZ92gdI/GkoxSHovSsR9kunKDxt9OHBJK9AildOJv+S?=
 =?us-ascii?Q?xTa9U5z+gjdnxLD3A8RXMNLRNgmIJAG/2+aRvUIIKMNT5UYviPbuYVQ6JP5K?=
 =?us-ascii?Q?EaSfQD+NjV1IXDDiUm2EBPqxkyAyrj5+CVpq9W6KHR6GltdRpmUUy84AM0M9?=
 =?us-ascii?Q?AJcF0od9npnGd7yJy+snau8j+ihw3yFEAv6IfV07JGzZKfSNCCqLVId+eBzs?=
 =?us-ascii?Q?ln1syEBTb8LOpiNn5GCEn3mo+Vir9ven6xsa5D8SB89tl9RN/PoY/6GZ7WRs?=
 =?us-ascii?Q?lBFYQVxbw6ozs8Z4SDsFeqoXWj/F74DfCPjQ4V6wh2MReZHn9Ytui34jCLSy?=
 =?us-ascii?Q?wzdWPrFms+1S0G4maNdP+OkO8w5+214CvNAv4tsOYs7rSv34BzXFItveX2Q9?=
 =?us-ascii?Q?KIus538pUpY8v3tE54WwLL34lK23jRvSPj8HyysMmHFgWZg8aANOMCrcGQ+X?=
 =?us-ascii?Q?SQfZ15gvctxrE/r34N4Q377eF4pZ68Sx0xHbVb4FrgYq7?=
X-Microsoft-Antispam-Message-Info: WUUtI/P7kLxDrIkYDtr62p2MTn8l6p8Q9FmJtYcnbM34vKob7FG4dIblMkgKSjxPjKYu0gQjGH8lAiNJFLfuQbhsnDqVPYIdxF2A0vdQnyZhTyoFiUcSOk+W/O886U88x6NltBvlT5o6SsajozrUTvektFPS/GXt5FBpa9XLtJR6Ql2k+Hl6/VOseqM8/us7
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:spnEOfKEu5rpft64MWy5JKcEwZnFfCE2TwOMACrZb/CX/TJjYeyQGQGgIEHc+GUcbOmYve1/JMnW2Zu/L9BJQKt2rZCa2ryjS4A9ph1HTLIHxCKQ6smjudnret1uabCxJV4kdivsw4kUKbrxBzmruouhSdGuRCwK5G3qG+7Or27UAtBKkKZdCj1RaR5vE8Mbavz3CW1084NG05fZab4eYvomb87iwqKFfU7sDzy7QXXd3/m3n9SkizASnyPtApQqLHpCTs/coRRQ1/DYk3qjm2W5QEGefZzerDOsGkyZz3UulHzdpg/RSasz25g8VHM7RWexeHeLUBnWDXCBoTOJcVqud9UVlocSipYNL/WcHMqzeULO4qutbdlpFkABqG1/uNAlRSVhfG32nIoQ7UfcC+oirMRrOoUFeiqaLFrJE/AMqay6XOiR4JMo/2aeFL/wCqpa49QSlVSuZTod3ss58g==;5:l+GBPVcoLp/+mM6Ym1l1fdYou+t+z7t05XxyRa4dHJ+DOAgDpSkoA8Zzy4+Hfjny3AUwYpk9xbDf55Rb4iaDsFVxws6ZKNZsXAdmw5TWDxSnAd5c14zpX8J7Q4S28PoAoWOvSbrUq7w/Vb6luMf55LPqOEbEvkerj59Ukm0u7cs=;24:jx30VrnhMphW2pdaDLSdNTrERWW3Is8JWUMogZ5oYyg2OBK3uGV/eeKin5fCoy7ExfyQOacTAUatSrEIuc/CPwttrW+7+DK4fkz2/kTVEEY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:VRiQnX9R/7iNblT0FMjvZNk0jwgvHlY88E4YBsfHS8L0Ku6GMfzjwiuIlAE1ECwCkiMYDECKW+FTDKGTEoSnZTuvvmAVWzIGynsJOiNggrb70Zzklal7L9tHJ6QiNmFXOKk79z8PvQS0Cmd0T4CxrbK0EFJjUPiFZsq2pRgAxgOQMEvxYp/A7GCXll1/toVSSjWOO3lMBNb0yPSUgqHSH3GYHr9Du841qLs0HJAKEGNrYe/HuXWycgmujrk2RKcW
X-MS-Office365-Filtering-Correlation-Id: 3cd320f0-7bbf-4060-0278-08d5c17da875
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 13:52:57.4262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd320f0-7bbf-4060-0278-08d5c17da875
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
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
