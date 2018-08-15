Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094B8C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413F121557
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P7t8/nzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413F121557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeHPAGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:06:14 -0400
Received: from mail-eopbgr730070.outbound.protection.outlook.com ([40.107.73.70]:19882
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727340AbeHPAGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wSsi+S1CSPfrumOcWLf2mFMcDvvyoLWieNjYWlkCYU=;
 b=P7t8/nzlEB3Qn/I+7eW98gxjoNba5UclYZY1Zo820rxOuYq+PonP5qSES0mDsZVZcZLgXWeFg9t8eP3n87Hs7ae15pokIG0UHAE2e/2VBs6umngssJH7DAr8ME7WzYoJSu+H4aJcLrONVJIwWxSVh1VxbvUPwOfTI4xHM+ll4Sc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BN7PR12MB2674.namprd12.prod.outlook.com (2603:10b6:408:29::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.20; Wed, 15 Aug 2018 21:11:41 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     linux-crypto@vger.kernel.org
Cc:     thomas.lendacky@amd.com, Brijesh Singh <brijesh.singh@amd.com>,
        Gary Hook <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH crypto-2.6] crypto: ccp: add timeout support in the SEV command
Date:   Wed, 15 Aug 2018 16:11:25 -0500
Message-Id: <1534367485-4386-2-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534367485-4386-1-git-send-email-brijesh.singh@amd.com>
References: <1534367485-4386-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR20CA0066.namprd20.prod.outlook.com
 (2603:10b6:404:151::28) To BN7PR12MB2674.namprd12.prod.outlook.com
 (2603:10b6:408:29::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aef628b-88c8-4b5a-377a-08d602f3b294
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2674;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2674;3:wIQp9uJoUrDINTFDnTR74ibCMoGA+Ms5T7LZk+Y+1+wFmsj9KYsH4oZ74oWLJ6YBduqHVZ2znW99IW4I+IIQizRYwgrrkPKIoGAM5bwkw+PQEzXDVohWl0OCkHETFZsg/hVZiryuCdYL/ZvIfq4BVboBCXcQ1/7mTqfy6x8q50UxcsJ08GuLFrg7U0XQ01zChF4uY3b2XWC0Fs5jTTZdwobTGVcJSk1fF8FpkqSNVhB6tO4nMNvBRjGbo57+yhzM;25:HCIK/euHj/l6TdAVN33HwCRb4fU3kXPsY2ezzRAbeeL9/GkA1V5XvXFBU8rPt9W9JTFGrIB9SUEgXKNZBvIBoJ8QA7oJEYmMTnMVH2Y/ynXkdWM8UakQwaQ5C8pj+dAmsPAw9veQPqhBU/3r2vorBgYtP7VZ7Cq/1dUfSz90g+Na4Pq9MxBs7Tvi4YI6xTqLlyVcuJ0XbVx9ixM6hADC1k/X148I58MtDJn0WddV5dbFNCnx5dfpcGA3uDjA9RphupiPhw4k+MALH673mubPbXGHp5Zd1crixI72OtsVqhvOH4Fcs0IQb8cg+XyAEt5Yw/7Psa30miPnWYHhsQzBDw==;31:uYz1c5kTe2vFPeZsCvgwUppPLTM/38IhCCWPyHTaDPkGHS4y3chs4FYY8Qxd5LKs4JqU0fnTM3YJM5BPkzaY/CWnxvs2KXYTQyZXO8onX74Uz+XCPXlf9MItLkGuNll+m3owrwd5DsB9qz8FHNj3mThIA+xsIfjUtNldRYAXaq1sFWEaXUo0DYwL4b59GCQ3yWNTGL/ASi6n+rpus82/FFNv+GPm5hVO/lpL6ze92C8=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2674:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2674;20:87gnQcDziQ0ImvsebC+74dRJUeLFIxHW8IabEMol9i3RpZbiOxEReHDcLlfxJAT8U4py2gXYgbv6Yxv0ErjRRFv+DO+FGerzhYfU5S6Z0BlBdVEsv4fB/aJLqD4uBFvs+azPD+C6/hdn1b9guD8rCbGV1VIhaoZVXhLhrS1cTnPfJXAC+Yr4HG7ig2PTP7h+biUQjsnfYf0hWF2V5dJG7pOnr2WkZHtylOIjHDErUHEXSrmOQuXr8082UUps+kKyuzT0EN/7Xu45dAwKwBXIcSMspgdUGKvKiujbb7OTpWv1LuVzWq0bKJgb0OYFrQXYbWqKOUsTah0b0hCI+Ed7exZq1XgPAC3x+UKG/+oNJAyPxER+xmQSgTxWLw5CVtFF5IeFKTsIqxsx+uhMZLMnMvLdE3AAFm2V8nlw469qYB6zFlZqottvb7Z90IcPmCRxZNjcOL9INrRASTNxa7zqzn1f3BNOnU0g+zWJk14NXky1s/eTdRRfu4XblcmR9TPQ;4:donNMN8rkt5GH15sB7xe/+ibn6dluNVcKRVqEBntNqeP5t9RNZFl90Sl2DdUmrWFrL73aKYQH6ehBOii7ZJbhHuFzHx9fJ6NtiaJS+ZDZChpvprSb0ILe+srNmeiet1k79e9jVdqa4zV0TykeI1oedREFk/NNIGAW/qTFDVNdiGYc0tiaG/T0UnTlv7bwqM9+gV6OoIZjT4bVpPeflE5EUInGIoYSKvEttcDu/egs998V3VAsOW1Tx08Ap8I7EyxhZGJsU40gNsyr+keCCcWhcOmJgRmL1WTA9HN+y5lyh2KPwwSFQ+ibDiF9JpL28Gr3RZ6FuRO4PnyCz7OxBWGIg==
X-Microsoft-Antispam-PRVS: <BN7PR12MB2674B4E2D1E3F8D99A649E7FE53F0@BN7PR12MB2674.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN7PR12MB2674;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2674;
X-Forefront-PRVS: 07658B8EA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(4326008)(50226002)(53936002)(2906002)(8936002)(86362001)(14444005)(186003)(105586002)(106356001)(26005)(6486002)(486006)(478600001)(2351001)(53416004)(6116002)(386003)(16526019)(81156014)(76176011)(44832011)(2616005)(54906003)(446003)(48376002)(66066001)(36756003)(16586007)(8676002)(316002)(7696005)(47776003)(6916009)(97736004)(25786009)(3846002)(6666003)(956004)(50466002)(11346002)(51416003)(7736002)(52116002)(2361001)(305945005)(5660300001)(476003)(81166006)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2674;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR12MB2674;23:K5hUFOU8eNQI5muP84MN5Rm9Cm3ni2cMrFkPqi8ou?=
 =?us-ascii?Q?cJxtgm5Vg+pW2VmLWlA3RfzRHGT9KqDcvPIQRNTBGy3fH2ku3sWximeu1zWo?=
 =?us-ascii?Q?Xv/EVb1ZCTmFWVyWITXnthJa5NbZBRknFP9hD4tGn9nyzHLgMKWcW5SUEy8o?=
 =?us-ascii?Q?exRHPUzkNGRetEDrkoYk4hik/ElA6gG6sfljPpnJy7PLPrd+wo/PAYCrOxQT?=
 =?us-ascii?Q?zDJ2W7LTKxXRCrG+U+5I+/aCytKbjLe1OnmOq6Xsq5iOJyixK56PJvAphH7H?=
 =?us-ascii?Q?K1oZqR0Ys/AMw7kpyDPypDhmCRNlHIOlNcSVSi0lk46yn1CsR6GgRS6h8S63?=
 =?us-ascii?Q?/RRYmYmZCU6JkIQlyUtv5HUie0ZShRPJIk8GJjY8QQCFiVZM8fcW7Ztau+vz?=
 =?us-ascii?Q?7zwHIt9Ezbmdh8YhGr94MIeyJ8WN0zzZ8gk7rKROCEvoQInlfVayWYqdQjkk?=
 =?us-ascii?Q?SYAUd6PEeAGgpI2IF+r4g+F55tsyo/dtFP9fkUR7jY6II0W2h3UqG5pcc0QL?=
 =?us-ascii?Q?T5FnSLO+tFd9KhsEXAnInUOyKEStvs31dSFKa+W1wyuOT/V0CxS8OHy1Lr+n?=
 =?us-ascii?Q?5xQfB+B3j+AYzae/x9qJ0bC+9eDH27s3xxyGnOsvJTp1YkW8joJ9xdedFVQ/?=
 =?us-ascii?Q?enjps+ATpsCC7Y3C32/LHUn2+Q8O/BHSz4B3HOCmPowJzF2K2AAKqVz/LS92?=
 =?us-ascii?Q?cGMq1UZKz20TshqdIqRXXYcZeMqRZHYE03FXjPx9Gbr8+2LPNAvaPgG0/NCA?=
 =?us-ascii?Q?yOIK6KiUEEhdLBSNfCfv5vVJw/a+0c1mHgiVCbrOz22MGf2bQgblMTFnED3T?=
 =?us-ascii?Q?9jc7nO6Ct7z/QAnJoEBEqZBgfPsvYvAFI+fQJEZQQZfiIHWk113VDh3KHx2r?=
 =?us-ascii?Q?dg+2jhuCk+QxpK3cRDZbZa0g4MR4A2mBw8khsJMW0AAW+afb1eteJOJ1sfvO?=
 =?us-ascii?Q?Nq/KFkzFAu1FeeSWB2gwho/gyrkxTb6VBRAn5MOMDACbKQgCwBTnW2Gxir0K?=
 =?us-ascii?Q?Adm9FH6ZP3Oai2riCTnLndenK06TLEa6qY8rf6TpBnCJPitQyvhSH4q+bgqH?=
 =?us-ascii?Q?6A0lWobhNnfSy48RiHZ3x/e7Yxpn8Ct3Bdz6aR6Zt7y9HU7DKRt17MunKa2e?=
 =?us-ascii?Q?VSijc39PrYD7Z9OGrQ+xRahYFlDXK9PgCkKWDQ0ox94jDBH5dLszCE2Rbz2b?=
 =?us-ascii?Q?+FPVHU+mrajI2HlbCZQQUWidVJwYon/2YiEX9madiP74fjPfMxA1cwxxT2Eb?=
 =?us-ascii?Q?3JIgzUuFX9cWBbW6wB5jWkPxJp27fENaeiwMKIw?=
X-Microsoft-Antispam-Message-Info: SO+il1eycJtpiqU9npHYU+xsmBm4s3fjx/duj1p25pYU4JWTCh9ScPYwnYiq5x7N5IbPK1JwD6PaHIxJ/A88ic9qNzaNOfaaw6wIBfwhiuabzijWKGkFvDE9+VEZ/V4W5LPPGslzSpnftKgOTijVpn30wfWWQj5t9uYLuDPecfBEg83T2I/GVuc1p/iMrtWHFfIztguuAlFh9LvnVI6f4pn/ITYtwTTNuQEFoioCHCyLeKgFdN3kWxK9Kk+OCZvDHMAEfxqK919WxugruFI+hSl6YXeTFCwIqbStC5MbBq0vwQXC/2c3J9ltnPPENJ4lat3o5JnkwYEwmb0waDrqePTbM/1S0I15SodANuuKrys=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2674;6:nMP8WBc88UdCikAKv7sas+Ex3Z9Y8aFfXWCxna4bX30L7ENE3BBdSYuhMS5Co+RHKqXTwjHTcXy+0zt3vKlLtWjjD9IOVjGFr17gZDMW9B4o//pt5U12rPe/3ylosfSqemrSHqttWX0jx8r8V6OP66D8ECCiJc5FMY0WxVcBj4r4RFsZH7QygvIG/yngxwEFc4kWKuuq2WfZSVYfF9BB25q0EkE2FbjsOuZjdzAikY3wDCPRxSHMHOBgAQTNFZ6EdwzSlY4qtkJWJcHh5A+a0hu7HdgTPmFxJu65HbVqLCqAgqCUHcVUZCg2G/ZUUy8mFvjd9F0xX65H5xaoMjQMXFNGd54LiVXstAWKVljDfXBjBEVUU0ONp05kFWR48FwvWJ6KzheMCE037XCo2BaNgPX/XHFvvjF+KGELfSRlQuJLiGHLDWuVE3fzJkLhD53ZG1W0g/tpYx0syTqxq8FmTA==;5:XmZQdQZPoIeoTAn4u7LOWpCpDmnylqDqq0PNhl+s5lzKjfj2dXgh7x/ffJJoGvBzyqaVmaNdBUGOXvlRnzN3BzHjy9++vinJPku+6SO3DUYAWdEOByy8T/5C2E/7K5IdJAE6ClJYWDGyplw8kD14+DNZ3Vcxj26XMKf+kUkRNXE=;7:TPQPidMtbQ+MPilsv14NhdJX9dusq1K+35YNdfhiMDneXzOnHLePpCVKr1fs18wUwYs5gFt4t1z8Q0z2GkGP81xGgHAJIGLl0K95IV7I2eCCcsSQCqcS2/m00sEPjNaXNvBnecO9OyBueEz53q5e7A9h/Mtb/tJya+GxBPiXMBi352kOU0JewqLS3iKC0S70ibNMMXVLMuprRqEMQYhurHbrRi/c5QdOtty2zIhHT7+2C57QiA5bhE5yumCe2+fm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2674;20:mnYSqC1jZW0tTMXBNgyA0pQ8fcL6uYosyyZi1DbwNvINMObv2g+7Ol7jSxmPNfmR8FZ2/h0BkvEybVglmEW23t6o8awJnaBtsIGzxGEtN9C1x/Jh6Vskjt/aoDJjq6TVz1R3o7wvYTExR/397p8cnAY3by65U7rqqo5qyL4h/Uso/NLPCf/D+05MTqkECs6SEcP5f3nd9y/GPMu4Nv8ei92Vozh+l6yUkB+eL5v5VKvxESuYCTo+lNToiPTikTVf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2018 21:11:41.2276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aef628b-88c8-4b5a-377a-08d602f3b294
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the CCP driver assumes that the SEV command issued to the PSP
will always return (i.e. it will never hang).  But recently, firmware bugs
have shown that a command can hang.  Since of the SEV commands are used
in probe routines, this can cause boot hangs and/or loss of virtualization
capabilities.

To protect against firmware bugs, add a timeout in the SEV command
execution flow.  If a command does not complete within the specified
timeout then return -ETIMEOUT and stop the driver from executing any
further commands since the state of the SEV firmware is unknown.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Gary Hook <Gary.Hook@amd.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 46 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 218739b..72790d8 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -38,6 +38,17 @@ static DEFINE_MUTEX(sev_cmd_mutex);
 static struct sev_misc_dev *misc_dev;
 static struct psp_device *psp_master;
 
+static int psp_cmd_timeout = 100;
+module_param(psp_cmd_timeout, int, 0644);
+MODULE_PARM_DESC(psp_cmd_timeout, " default timeout value, in seconds, for PSP commands");
+
+static int psp_probe_timeout = 5;
+module_param(psp_probe_timeout, int, 0644);
+MODULE_PARM_DESC(psp_probe_timeout, " default timeout value, in seconds, during PSP device probe");
+
+static bool psp_dead;
+static int psp_timeout;
+
 static struct psp_device *psp_alloc_struct(struct sp_device *sp)
 {
 	struct device *dev = sp->dev;
@@ -82,10 +93,19 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void sev_wait_cmd_ioc(struct psp_device *psp, unsigned int *reg)
+static int sev_wait_cmd_ioc(struct psp_device *psp,
+			    unsigned int *reg, unsigned int timeout)
 {
-	wait_event(psp->sev_int_queue, psp->sev_int_rcvd);
+	int ret;
+
+	ret = wait_event_timeout(psp->sev_int_queue,
+			psp->sev_int_rcvd, timeout * HZ);
+	if (!ret)
+		return -ETIMEDOUT;
+
 	*reg = ioread32(psp->io_regs + psp->vdata->cmdresp_reg);
+
+	return 0;
 }
 
 static int sev_cmd_buffer_len(int cmd)
@@ -133,12 +153,15 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 	if (!psp)
 		return -ENODEV;
 
+	if (psp_dead)
+		return -EBUSY;
+
 	/* Get the physical address of the command buffer */
 	phys_lsb = data ? lower_32_bits(__psp_pa(data)) : 0;
 	phys_msb = data ? upper_32_bits(__psp_pa(data)) : 0;
 
-	dev_dbg(psp->dev, "sev command id %#x buffer 0x%08x%08x\n",
-		cmd, phys_msb, phys_lsb);
+	dev_dbg(psp->dev, "sev command id %#x buffer 0x%08x%08x timeout %us\n",
+		cmd, phys_msb, phys_lsb, psp_timeout);
 
 	print_hex_dump_debug("(in):  ", DUMP_PREFIX_OFFSET, 16, 2, data,
 			     sev_cmd_buffer_len(cmd), false);
@@ -154,7 +177,18 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 	iowrite32(reg, psp->io_regs + psp->vdata->cmdresp_reg);
 
 	/* wait for command completion */
-	sev_wait_cmd_ioc(psp, &reg);
+	ret = sev_wait_cmd_ioc(psp, &reg, psp_timeout);
+	if (ret) {
+		if (psp_ret)
+			*psp_ret = 0;
+
+		dev_err(psp->dev, "sev command %#x timed out, disabling PSP \n", cmd);
+		psp_dead = true;
+
+		return ret;
+	}
+
+	psp_timeout = psp_cmd_timeout;
 
 	if (psp_ret)
 		*psp_ret = reg & PSP_CMDRESP_ERR_MASK;
@@ -888,6 +922,8 @@ void psp_pci_init(void)
 
 	psp_master = sp->psp_data;
 
+	psp_timeout = psp_probe_timeout;
+
 	if (sev_get_api_version())
 		goto err;
 
-- 
2.7.4

