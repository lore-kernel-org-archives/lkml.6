Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965556AbeEXIri (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:47:38 -0400
Received: from mail-ve1eur01on0119.outbound.protection.outlook.com ([104.47.1.119]:9666
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965114AbeEXIrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:47:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-i2c@vger.kernel.org,
        Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: [PATCH v2 2/2] i2c: mux: annotate the nested rt_mutex usage
Date: Thu, 24 May 2018 10:46:46 +0200
Message-Id: <20180524084646.31697-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180524084646.31697-1-peda@axentia.se>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
 <20180524084646.31697-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0019.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::29) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:whpFVXywz9XeoKyTsLmVJuS58cxidJzo5/2MqvvActeotry87KOwpav5ZeF7Qab/TQCnnxJAc3icJYXJA+QGzXc41U1RZlItI1v4erhlxVad4+jKM8ITaU7n75EMyBRyF24YCoFRffyje6t+bmzTzX11xiUZtXcTen73v+mVZwMLoBCbRUcevhOOepiiuBgrbzJlS3H9fv7/uPzi5EF5HbCvKVDBIqAjG24sHUFstxYooe+2my2M0K53mBJa0p7Q;25:eubf3JnGmK5xRQ524v99366vBMYM+9GZtu8uRZsR1NuIrirtn+I0GLA6XjRCJ5cuMuERKNcPbxdpGMys1NUc/ExRojl0vJb7D5pa8e9LOsIMgEAbKGCfPEmLmCNMcD5N03HTK9XKRZ6eNhrohQjANiQeeqNDWePuYZoCny0yrw0iaegbb7RxCF5eM31gS+JQNX+lBVLWn5F2PnBVdjYMA7HoxgGqMwN04qH3hqqE9XkNEEUF31N71cs7YTtaNwaQI6NaBB/JM/g8A/aa2Wh4C5ad9Crc2KbOeBzZys/w+FTKh4enpo/brgeZi/XxC5FJ4tXfg6NLs1uHdZeIt2zfYg==;31:8n8qelnhQ1Xm0H6RPKqeiSGniUwNzfSW1waPPF9SoECKWDWaiqR+GtvOIQkDik7FBAblLo++hgioEgC3J4crG0yqVDvR9vYcQDZZlNIWIKI4qzVkjsajR1KLnPVdKflM/C0mwTIFJ0eGgBiZYKVpD0FeeQ80SqbVYLGuosxCGad2of8CmZ0gdMo//RFeRg8JQyVM4HH0be9qweP33zxsDgpUi7dYhv0icWWV6+/kKxw=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277942412BEB3B82C7779204BC6A0@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:UQWGQjoibB37iaki1FuoW+bxctVnbdqYR6vSn6PUWgjucsi9stf9JlK/yCo43RjUvVIxglfx5YSaMrwOnYqgc/BPfnpRQdN0cycd2iRFiFZ1uQcZyHW1e9oB4qyuv0gw29mFGSocUV2grOcnW80E+LZMxWGBJhTirAr8i2IFHEErFLLMqVYvBhHKAL9BL0ePsgor09+hlVWlBNE1RlB9VD5cweJWGHaE3SLk0S1gEYEH/tq8IvLe4e8fNfkKoPaTzOPst6fIV+rTBt/m+OxvcgoBydsqrZvc/P8N1iZTMh7QIOAqutrM4ptABHjinY0veJDjg+/EhgImRY4wYEl3putxO+J92QxMDHnPB31vp+8=
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39830400003)(376002)(346002)(189003)(199004)(74482002)(52116002)(25786009)(6916009)(50226002)(8936002)(6506007)(386003)(478600001)(51416003)(2351001)(2361001)(7736002)(5660300001)(476003)(6486002)(97736004)(6512007)(305945005)(76176011)(6666003)(53936002)(86362001)(54906003)(486006)(59450400001)(316002)(2616005)(81156014)(81166006)(11346002)(4326008)(956004)(8676002)(3846002)(48376002)(66066001)(68736007)(7416002)(50466002)(36756003)(16586007)(6116002)(106356001)(16526019)(105586002)(1076002)(186003)(26005)(446003)(2906002)(47776003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:bMPLe5vbYMpw8Mk9OnOuFc35mIk/ztt6djn9oPH?=
 =?us-ascii?Q?/Kac4ta4o3V6eKIoodJZ11vB1lpLlQgwawLYC+HUNZ+xdWXE9qZp/VryreWm?=
 =?us-ascii?Q?ibuJJwg5tt18I0atqoB6R3nGo1uG10B2dwVhGn4hG5yQTk0kn20W9RK0ygUl?=
 =?us-ascii?Q?6FTD01VlykfQ8HyKoIiCXdMJ7ocUe1tJS+cZQ1/mk9p8XHtvsJem4GeKi8nt?=
 =?us-ascii?Q?T4wvNH1LTrgpWNhlgP5T+hrvMrGZpZQdfz34FmkY1vXLhOfqY7Qzk+MgtWbS?=
 =?us-ascii?Q?yjdziouZSmdr3Ih9NMRukeqUTsmdskbjPCa+CCaN7mUCTVaMggDhszaf+dKV?=
 =?us-ascii?Q?Wp8PlA5TNYJrjYOwb8EKhQhfbZ430VU29rbCjQN9Jq5m+11Z18fpVzw9Mx4u?=
 =?us-ascii?Q?Xg8HG8Av0Z0S+VQee6XDVUE4+C8jVgEt2xrQfLGdr0QVuOiEi3xhBUOemtvM?=
 =?us-ascii?Q?429dE7j1O6pB9RbuYK38oBdhVnZUEbr9TFVqWz4DACU+ZoBz1jCJD3TTmmBy?=
 =?us-ascii?Q?Zv53IjG+lbiRGyS+34wbiVfJSMOoYJ6f8xwqfOoKgRDwgmX1xAWT3c/7s3vB?=
 =?us-ascii?Q?KTDNxhRuGtLhcUFxCYZgS2YQps7IOt0GGy4uOQro4ad+Zd3CA8xBwmI5esjG?=
 =?us-ascii?Q?W7xnr3xq08fJYjQCbizoFZqXiIqgy02l6IbmL7+PezeB4XmjMYA+KKdmprGR?=
 =?us-ascii?Q?iji+uxcBPX6O+HV2vyja4a0FC4HI9BkG4NkbYMjf8nDUzetBN5ZtRqQrHCi8?=
 =?us-ascii?Q?3YZ7mdqLiWr/UGB18mnr3KyBHAqbV+sZiw4cTpJ4imek50RPHSFdpA2whZMe?=
 =?us-ascii?Q?nEbAX/IpgcWHb+Cv//RKwDQreZSXYnA49Aqc76t5kz7dvsNvPwFbhfe6WEZ6?=
 =?us-ascii?Q?qn0XHeo1HRhNJmHoSPQdWTaK8b7N85sbvF/Pu6V1DZMrdGtx0Rkd++HuVtVp?=
 =?us-ascii?Q?ArOkfAGv4W45c7HnUO4HhJHM3rK5DhtEyu0G3QZ5TWMbJFkyfh29UOF3vJWx?=
 =?us-ascii?Q?z8FcRBJiSLr4yGM0m6O8e7iS1MTD4SctWN8Dl4naHYowH6ut7pt4WDUJ1478?=
 =?us-ascii?Q?84TnhEOj0W4j/1UAaVvNTToVq+JNbYPFbEB1KmVxZ4zBoSe8flHL/v16QE3j?=
 =?us-ascii?Q?ctxPnFC7pbFCNvmKPjsjkRRH/9m57nYKLhmqX1FXzVhn+8oZFzVgCnevMdPK?=
 =?us-ascii?Q?Mh20x4AbFE1eUlB6GkAl1VCt0Ccufo+1OM7j2C0yavZXChpGzr6ldRcDtcSG?=
 =?us-ascii?Q?jitK7NDPM5YurOhvRV1dzTazNJ5w79UTNsbjeecwComcosM9nY1BpDSu5O9D?=
 =?us-ascii?Q?3gN3qG5mJjGh4GpoJd4qgoVOvQ1iooYEkmSjdyL3Z05PS?=
X-Microsoft-Antispam-Message-Info: pGU1E/oND+twdVrh2e8t1nsJqxPGv5AYh0GFsLn8NcGB2A3LdMgmiMMd1x9U96KXkfcSp541F9LJxECNWcIaNnqLEOEdhJ/xZkx8jyVm6xUlCUjQygMglqGUTDXG8hb0BqdBRFNmm9nxxyfhuNtHxU3NTLJw5oE1lo5ABVIqE0AlzNDe0Dr5Trx7Dg2F1JBg
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:nrRLrgu03JrSN4iFW0lrjralFfeQcNz0nTfWKdoSpivqvqKoJHg7DDRqdotdcb17Os63zovTkBF8kON6JGXaPHoEv1u9tlVp+BqYoIsI4R/TQfMuUrMz6hVQbCmytsCjlR8h/0r1se37/tFGUFLm1DxkdxKiulN3XKatKKt0ZfiKSMXp0C/q/cjtIB4V/skKtfHGHc6uVDn7Di0H5Gx2MzSUszaZJLm6MHQITTJIe8Dk+rJny5E7sOnZMM65VIUnqfRw219V3brCiOMILyPXmzNCOWWqFECDhYETa7q7BrFp+xaGkZDUraXD2H0RNFvJJqcrEl0ui+TlylvUzpxAUmV2E6gQ/RtDj6cV/B14zWVC6SM3yaLMXu2HVx5zoIWdATJn3WSP5oyuMvXTx3Mc7r48MeyHjEAG6DUJoXzzEKG0Egk+nZ5+yj8Ve59xLhX4hIpcCsaBDWnL42xT9ybMvg==;5:8MFi4Um2Rwv/JqqRP68/nJv3XR0rHIp5JH7/uTy6POD2cIRA4L4A5HK4xCyO4hDNik7ScPgacObEwK0dOnG4i7Ek5O7HnLItGlLTNb+uuk3Z+4iv/hC/AioGPLh1udVTxvCN9wbhpgDDRtx/YCskOk8s6HpN7X3fxoq2V05lz5o=;24:W16w9CiEih1R0ApQhUfAlunN9+FCrzgrxPQz05DLvLXK/6kol7IDv07G11Yr1RiUysGDdPGymKop4Lk2BoWJZu3MtZ0eHMAu7awZzkYHf/0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:ZYke/DeJYFUiiwWE/mXPwuFqprkUANdOuY3n/Ke9bVYR9bMcDb99IuhxNO6vaZxhdU3KvU/0+EBx2xDiEtlKtCyo0OdL2R+PcwfxPJz4rhNbz9QYt4+2yC5+0CEzS/2KejiRSGCtutcUGVEAZfGOvQkNvpILL1y8E3fCEzhfj+GIZg6R7Qf9M/+0rDWuNjB8I1dUNTMo3SavI5fmDvsEepHI2URFuMMP66OIsuC3KlMXTalsaXnPVBWZe/9Ps4JN
X-MS-Office365-Filtering-Correlation-Id: f36df9cf-8020-4809-90bb-08d5c152f117
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 08:47:11.5844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36df9cf-8020-4809-90bb-08d5c152f117
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
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
