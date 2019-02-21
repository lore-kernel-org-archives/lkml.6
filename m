Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A92C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8EA2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="cNK7eBvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBUAcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:32:31 -0500
Received: from mail-eopbgr700117.outbound.protection.outlook.com ([40.107.70.117]:28256
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbfBUAca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjYcX06eXsZbL9+qh4cvoFVYmikYN4bl6k4UStlm0SA=;
 b=cNK7eBvmB+GI04ksqNBeob59ksMj2/NZHdqK1ZwYifPW0LFqF7vsaBM1dcEskUukfDPst0imqZ5ui+0WeYFN8vrPZXSjSoPecFvruDSFq0jQehdT0saCUQGsvz7FJy1kf11Zwu90AZ4CtAMtMjwMYPlhA8pLdon63ttxmT6H+Ak=
Received: from DM5PR0102CA0013.prod.exchangelabs.com (2603:10b6:4:9c::26) by
 BYAPR01MB4853.prod.exchangelabs.com (2603:10b6:a03:91::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 21 Feb 2019 00:32:25 +0000
Received: from CO1NAM03FT006.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::203) by DM5PR0102CA0013.outlook.office365.com
 (2603:10b6:4:9c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 21 Feb 2019 00:32:25 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT006.mail.protection.outlook.com (10.152.80.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1643.13 via Frontend Transport; Thu, 21 Feb 2019 00:32:24 +0000
Received: from callcc.thunk.org (guestnat-104-133-8-99.corp.google.com [104.133.8.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x1L0WLfh029161
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 19:32:23 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4CE037A3F7C; Wed, 20 Feb 2019 19:32:21 -0500 (EST)
Date:   Wed, 20 Feb 2019 19:32:21 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv5] random: Make /dev/random wait for input_pool
 initializedy
Message-ID: <20190221003221.GA4062@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840E7DCBEA62BB204CA863DE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190216182355.GE23000@mit.edu>
 <VI1PR0702MB38400342893473C16C0C6D70E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <HE1PR0702MB3834CF349C1480194E35CADDE4620@HE1PR0702MB3834.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840F83AD88C7808C49E2AF8E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB38409DE458C09B046CDED5DEE47C0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840AB9AD3865DA9F3FD2EF8E47C0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <VI1PR0702MB3840AB9AD3865DA9F3FD2EF8E47C0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(199004)(189003)(14444005)(36756003)(446003)(316002)(33656002)(106466001)(97756001)(486006)(26005)(478600001)(8936002)(6246003)(46406003)(6266002)(42186006)(16586007)(103686004)(50466002)(2906002)(75432002)(8676002)(6916009)(36906005)(106002)(54906003)(93886005)(786003)(58126008)(47776003)(53546011)(23726003)(229853002)(86362001)(1076003)(356004)(11346002)(4326008)(476003)(305945005)(126002)(336012)(246002)(52956003)(88552002)(90966002)(26826003)(2616005)(186003)(76176011)(5660300002)(41600400003)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB4853;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55fc68d7-d385-44b7-ec3b-08d697940d2e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BYAPR01MB4853;
X-MS-TrafficTypeDiagnostic: BYAPR01MB4853:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BYAPR01MB4853;20:5M0sOPdGl2R8hL4lj56AXRRmw+IFoucVi47fIXZmaku0A3+11J7K9urzkQy3ML9vfm7TC1Kq8dqb7M/zFk9KVaInUyvA4BduB/+InEDRSAK0jpTBsd1xRRjCXnPQEq2mBifpbJXYty9eBHtfWmDBShSWOnKW4bqMNzad5svZebZ6JTRM2piPih8oilm4ut7uiumpp2UXjErl7lB1le2DuYBmcfy3c8+16xcbqpN9WNH7N5OexuE4E+pXuz1eCLVulVOcctxbEBPqogTbVncJil69CW+JfKHwwb39XuNNtZTSm75S1AwA/ehlV7SMHN0n9YxQqoXcGbCav8hJKq/p9KQzG43LolVARBhZmNgR8cLtI+p0oqQle++W/aMfkA8vZKAEWC312hMnugI1DXFgvzO17wfryxHuxyqLTNf4VFu/PUoFMOBwozA1P4BzYaqmKX31bdcm0+j8KwokgcT465YVA7iBVDEKz/qhL146EecB93yqBXSoDO7s30zGYpS/KJpibG8XnpA7Z55gOCfr7X/LOObbMk/Sn5Wt3jRRRrCrdrLOHnn+04agNaQeaxZmMAZ9t4lxNHLjWJXfyhf/hSTd7TDBYs3Lu5l+wXMltfo=
X-Microsoft-Antispam-PRVS: <BYAPR01MB4853D455F5149D8AE2B9030EB57E0@BYAPR01MB4853.prod.exchangelabs.com>
X-Forefront-PRVS: 09555FB1AD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR01MB4853;23:Cc615txA3hasFTu/mD4PAxPa0bF/3G6t9h14V135V?=
 =?us-ascii?Q?SBTulgsRpCiq2T7oxdFlG8khpyVTv8gKl4RohBD4NCr/YQu8iDiQZrlSnbfH?=
 =?us-ascii?Q?eZ7iKeUzANGceWaUk+E1+f+0od4+4AlwV3dPt/HCpHz65I1m0RAdv9tZSgwU?=
 =?us-ascii?Q?n/7oHVkpyusEc9d0imVT0l/gGgdAfEMvvlEl8br0t5jLC9DPLFxfNDc5fqPL?=
 =?us-ascii?Q?86UGd0vIrVnwNpOJveSfsTrVDvtzYx6gsYjOaqa1U3eyMjG4GbWHpz7Unfqf?=
 =?us-ascii?Q?mudx+uw8NEm+dVWjm4UaKdl80LWpalVumAUDYBrDH4zvI2lHrwVA47itDaYG?=
 =?us-ascii?Q?q0uhMbbLZCGRhP6xusFLPH7zp4JS1MfSR+SBusdG2zlYz9Dn1cmbc6oo9fab?=
 =?us-ascii?Q?jARtDDU0Q0Mn8k3xDALYqNSyyUggAX3RX1q5hMnc2cUS9P+WlcYrL94Cw4AU?=
 =?us-ascii?Q?R9C27dRcL01sJz1HkzCFoVvVeuBQu49U/kAR0QI2FAWoU9WrBo86EzLbf9Fc?=
 =?us-ascii?Q?NRRcHws3IuzURokvnE0jwBGlNYTKPBoEhzWKoWYf8yaA4oQQWg10L5VflxSP?=
 =?us-ascii?Q?/62vSbK/PJr9CVFPl9M1TApq5eZftOJKVCxSHSTJ63h2GZRLih/hp8mVuGqs?=
 =?us-ascii?Q?2+nnPWWa5upZNnzDXnCJMgRDuLPaIYYun2c1skvWJVN/3R77mgbn3tHHfhRq?=
 =?us-ascii?Q?CyhH5V3nqZJ7hPYJ98rfXciG7PdiLhNyFgz/Im7zaf/XJWJVB66ZN5pMCCxy?=
 =?us-ascii?Q?ksdq6THmUe+SRw+vrj3oeatBDgzzzZhwxOjf9MSvpjCfKhlfRGefgVrnUIbV?=
 =?us-ascii?Q?knOaToskekaeyqPitQ/Z5oIoGlTH/LtVTTosvHfaOpwNyVBpCAAnjVacZRRp?=
 =?us-ascii?Q?645+V0sLIp86nKMil20G0Ejgw5asJLN6Gt2zqfwpn42VPxDo/gYaHFx4LuoY?=
 =?us-ascii?Q?CBaoQ+gwZcNU6TA3hG8O18Fm1M9o6UJ9RkczNAFTu/X1Vj/Rtv0HBpoCOfF1?=
 =?us-ascii?Q?hywesEGBMGkbh5U3CH7CkGiPP7PSpWBnxEC4VTQkaEmB6+DOWqVkiOSORs7S?=
 =?us-ascii?Q?9vY4MVKuzhll9nc+zfF/L2y2WtcEzBy5tHLB6kY3qr8T59FWzymNnGoadVe6?=
 =?us-ascii?Q?pUC/Qp0iBTGEznUj23IVYB34iBKYBnWWyHRlMBNv+Da3PNnCJKs4usfZzYvF?=
 =?us-ascii?Q?Zbs6vW+mE30GJbhcGfPQ1CN8idQ7/zqr9mtaUlPiOcUDflRHTqK2yx4DWbJ6?=
 =?us-ascii?Q?tMjDrOMJ/r4LuHMM7EwxCDHz2ElitkiSabOq4JToubRqkWja5UH1r6s3hsj6?=
 =?us-ascii?Q?fF7r0QrNNnAaJpHR+L9qCGm+7bF2ubyFIO+SzavWBinFchZ75jvBr79kylhP?=
 =?us-ascii?Q?Aj+FQ=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: clhbQfKxQkzMrMT2qZivZGYRxDJUo9kZuo58vtaKX0S17zsVvtQfsayLJ/fDefQK+QnN7U1ecg/GSr9lODxs12oOPJFfc0j6jcCJqMtl6B9I5ZgPM9o64F1baRzdABvjCCwgFofp/X2XDTNg51D4gkwdUXoDKgn5s8cUgnKRtPDY1zwzRxyKYe97cJLEkNQSAYIWVwNv8FzG2VA3FF6Yk1uFP1NNdh4DLvn9AZb2bwe3e7gzKBMmsA7aQ2jAG7ZOAJf2+4mTeTqcRQz6kL0G+li9ltGZY6CHN+jWnAqZw25ed62V5IHTlhUhe2hMWS7cM69JxJ+JUL2ZBZAL3hgZ8gubK1kt5igTFlrRMcDKGx2KAfRCue5XYAsBid87PRG1B4ng5Fvp+2jT2ZGRY3D7iA9OyNbptaKAVEcY3AfUlsU=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2019 00:32:24.8404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fc68d7-d385-44b7-ec3b-08d697940d2e
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brend,

I've been looking at your patch, and as far as the core part of what
you're patching, I think this patch below is a conceptually simpler
way of fixing the original core problem.  Please take a look and let
me know what you think.

There are some other auxiliary things that your patch is trying to do
where I'm not sure what you're trying to doing and I'm not at all sure
it's correct.  Those things should really get separated out as a
separate patches.

> Another minor tweak this patch makes, is when the primary
> CRNG is periodically reseeded, we reserve twice the amount
> of read_wakeup_threshold for fairness reasons, to keep
> /dev/random readable when it is not accessed by user mode.

I'm not sure what you're trying to do/fix here.

     	  	 	   	  - Ted

From 9275727af22bc08958bad45d604038aa8e9b6766 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 20 Feb 2019 16:06:38 -0500
Subject: [PATCH] random: only read from /dev/random after its pool has received 128 bits

Immediately after boot, we allow reads from /dev/random before its
entropy pool has been fully initialized.  Fix this so that we don't
allow this until the blocking pool has received 128 bits.

We do this by repurposing the initialized flag in the entropy pool
struct, and use the initialized flag in the blocking pool to indicate
whether it is safe to pull from the blocking pool.

To do this, we needed to rework when we decide to push entropy from the
input pool to the blocking pool, since the initialized flag for the
input pool was used for this purpose.  To simplify things, we no
longer use the initialized flag for that purpose, nor do we use the
entropy_total field any more.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 drivers/char/random.c         | 44 +++++++++++++++++------------------
 include/trace/events/random.h | 13 ++++-------
 2 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 47ac7cd20fb1..e247c45b2772 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -470,7 +470,6 @@ struct entropy_store {
 	unsigned short add_ptr;
 	unsigned short input_rotate;
 	int entropy_count;
-	int entropy_total;
 	unsigned int initialized:1;
 	unsigned int last_data_init:1;
 	__u8 last_data[EXTRACT_SIZE];
@@ -643,7 +642,7 @@ static void process_random_ready_list(void)
  */
 static void credit_entropy_bits(struct entropy_store *r, int nbits)
 {
-	int entropy_count, orig;
+	int entropy_count, orig, has_initialized = 0;
 	const int pool_size = r->poolinfo->poolfracbits;
 	int nfrac = nbits << ENTROPY_SHIFT;
 
@@ -698,23 +697,25 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 		entropy_count = 0;
 	} else if (entropy_count > pool_size)
 		entropy_count = pool_size;
+	if ((r == &blocking_pool) && !r->initialized &&
+	    (entropy_count >> ENTROPY_SHIFT) > 128)
+		has_initialized = 1;
 	if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
 		goto retry;
 
-	r->entropy_total += nbits;
-	if (!r->initialized && r->entropy_total > 128) {
+	if (has_initialized)
 		r->initialized = 1;
-		r->entropy_total = 0;
-	}
 
 	trace_credit_entropy_bits(r->name, nbits,
-				  entropy_count >> ENTROPY_SHIFT,
-				  r->entropy_total, _RET_IP_);
+				  entropy_count >> ENTROPY_SHIFT, _RET_IP_);
 
 	if (r == &input_pool) {
 		int entropy_bits = entropy_count >> ENTROPY_SHIFT;
+		struct entropy_store *other = &blocking_pool;
 
-		if (crng_init < 2 && entropy_bits >= 128) {
+		if (crng_init < 2) {
+			if (entropy_bits < 128)
+				return;
 			crng_reseed(&primary_crng, r);
 			entropy_bits = r->entropy_count >> ENTROPY_SHIFT;
 		}
@@ -725,20 +726,14 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 			wake_up_interruptible(&random_read_wait);
 			kill_fasync(&fasync, SIGIO, POLL_IN);
 		}
-		/* If the input pool is getting full, send some
-		 * entropy to the blocking pool until it is 75% full.
+		/* If the input pool is getting full, and the blocking
+		 * pool has room, send some entropy to the blocking
+		 * pool.
 		 */
-		if (entropy_bits > random_write_wakeup_bits &&
-		    r->initialized &&
-		    r->entropy_total >= 2*random_read_wakeup_bits) {
-			struct entropy_store *other = &blocking_pool;
-
-			if (other->entropy_count <=
-			    3 * other->poolinfo->poolfracbits / 4) {
-				schedule_work(&other->push_work);
-				r->entropy_total = 0;
-			}
-		}
+		if (!work_pending(&other->push_work) &&
+		    (ENTROPY_BITS(r) > 6 * r->poolinfo->poolbytes) &&
+		    (ENTROPY_BITS(other) <= 6 * other->poolinfo->poolbytes))
+			schedule_work(&other->push_work);
 	}
 }
 
@@ -1553,6 +1548,11 @@ static ssize_t extract_entropy_user(struct entropy_store *r, void __user *buf,
 	int large_request = (nbytes > 256);
 
 	trace_extract_entropy_user(r->name, nbytes, ENTROPY_BITS(r), _RET_IP_);
+	if (!r->initialized && r->pull) {
+		xfer_secondary_pool(r, ENTROPY_BITS(r->pull)/8);
+		if (!r->initialized)
+			return 0;
+	}
 	xfer_secondary_pool(r, nbytes);
 	nbytes = account(r, nbytes, 0, 0);
 
diff --git a/include/trace/events/random.h b/include/trace/events/random.h
index 0560dfc33f1c..32c10a515e2d 100644
--- a/include/trace/events/random.h
+++ b/include/trace/events/random.h
@@ -62,15 +62,14 @@ DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
 
 TRACE_EVENT(credit_entropy_bits,
 	TP_PROTO(const char *pool_name, int bits, int entropy_count,
-		 int entropy_total, unsigned long IP),
+		 unsigned long IP),
 
-	TP_ARGS(pool_name, bits, entropy_count, entropy_total, IP),
+	TP_ARGS(pool_name, bits, entropy_count, IP),
 
 	TP_STRUCT__entry(
 		__field( const char *,	pool_name		)
 		__field(	  int,	bits			)
 		__field(	  int,	entropy_count		)
-		__field(	  int,	entropy_total		)
 		__field(unsigned long,	IP			)
 	),
 
@@ -78,14 +77,12 @@ TRACE_EVENT(credit_entropy_bits,
 		__entry->pool_name	= pool_name;
 		__entry->bits		= bits;
 		__entry->entropy_count	= entropy_count;
-		__entry->entropy_total	= entropy_total;
 		__entry->IP		= IP;
 	),
 
-	TP_printk("%s pool: bits %d entropy_count %d entropy_total %d "
-		  "caller %pS", __entry->pool_name, __entry->bits,
-		  __entry->entropy_count, __entry->entropy_total,
-		  (void *)__entry->IP)
+	TP_printk("%s pool: bits %d entropy_count %d caller %pS",
+		  __entry->pool_name, __entry->bits,
+		  __entry->entropy_count, (void *)__entry->IP)
 );
 
 TRACE_EVENT(push_to_pool,
-- 
2.19.1

