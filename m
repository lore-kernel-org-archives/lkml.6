Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27DEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A5A2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="kY+3sp4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A5A2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeHXOo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:44:56 -0400
Received: from mail-cys01nam02on0042.outbound.protection.outlook.com ([104.47.37.42]:34988
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726714AbeHXOoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nB1ZvQ6evbIss+m1zbNaUROIfOjZwYcGCC32pBJtdMA=;
 b=kY+3sp4SLGRuKUuNTV4QmyK0x6xAA4IWtSYjdpdgLLFBtSV1ltZhAQx49AnRtLKxX5vg46mXSaWuwTVJHUimu1UirJAMMFL7KdOxi/cXb16A8v7jags22IMeEuM0+Sc/8803cFlmy7XMMbex/ZY4qijdAR8n01+eIKw1XOZJW/c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from localhost.localdomain.caveonetworks.com (50.233.148.155) by
 BYAPR07MB4920.namprd07.prod.outlook.com (2603:10b6:a03:55::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Fri, 24 Aug 2018 11:10:33 +0000
From:   George Cherian <george.cherian@cavium.com>
To:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Cc:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        George Cherian <george.cherian@cavium.com>
Subject: [PATCH 2/2] ipmi_ssif: Fix crash seen while ipmi_unregister_smi
Date:   Fri, 24 Aug 2018 04:10:10 -0700
Message-Id: <1535109010-5074-2-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1535109010-5074-1-git-send-email-george.cherian@cavium.com>
References: <1535109010-5074-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.155]
X-ClientProxiedBy: BL0PR02CA0092.namprd02.prod.outlook.com
 (2603:10b6:208:51::33) To BYAPR07MB4920.namprd07.prod.outlook.com
 (2603:10b6:a03:55::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 931fcff5-ee77-4bd5-632a-08d609b236be
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4920;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4920;3:qu415ExrlUoE7AK1yZMRx/N4icaoaBZ/8n3TNr2A2WwdM2Px/2odQvkNvGARnVXOzW/NiFHwT56nsWIQqFSXkS6OELhGg0y5tCRNXOWYwotPZLqepXpRlpjrNzjpK1fqdEdCjN2N7Bacgv5lNV7EvZ5QZtBSxwuPJP6cjhxgxXMBr/ksobWTarLxRly+yCaTmiV2/oJgXQCA1F1+sxHePcE8Wr9p1FVxScbSwdkqRNSiE54qgylciiureo70kWMZ;25:gZEOJgjFwNMxIF9dG8UveieA2uCvcTw3bqLpoRMFMf9FuZnx1HQWU0zTKat2HpDj4si9a//bGwqo+VBS+TLuRCmsWQfpew2ZnHdLJf7EL8IgSznj72bAW93VhfB2eZIjtekO6nv+fT4dRf/PDS6X6a90nhIu2jevkEbNOJvhvE5QjvdlOUGrPYdmcGHkRV1XiLBUb9+WYoIA9ZT+NT4wp5pSw4mwvbeHmmWAysTfBif6H0OFklABLozm/uJ7GyJx2wTxhBcqwUi8Tf3a+4qbe2YrWeTuSP9c33hRfJaVr05xXm1R184W5rl/Z8U77RoZUF/5HKvguyUtUYkYZVtl+g==;31:hvq9pNbbhCyhOoCMIG0IooLbR0Yf+SxqY1rv3HMtPf9HbnZYDe8c3c33Zz4A1iHscGm6TmVt++DX8sqIqqAKlt7C0pQeEX68rgDhqn/9mS5egSL6PnZt/QB9CY4fFcwk311o987AYBCQ5FCD9gRPeMkc/pFNqW9SUiBID0PtcTUNLJIdjkBQlwHk8Fnv1Da7iykbprTJ+uBNPvtb8XIxEyMgaQ0+1XTX3V/2B5OXlMo=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4920:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4920;20:+e5eQhMdBptbVv9IvCmmKJzsvbLs0bS9mp/1mzJlDF+KMFYeP082+YdHmG3ksM5vwEQb0EGjYvgMYXFuxLzyBAv3oYbFWmLVrTOi97caHxtRtydLEk0zWvzmlBLNJJ20Q0e4k+d8iCta2LZo3sQVVx6/u2Ed5gYGTpX29UV/WsxkTCBbv3ifh22ssP4oNTyYaq6/SMPG9PTX0YfkvTVPmFuJMvmuLpjEzrSzSNeAyi2pSpz0JoxXnb+X2MKgnXeSJ777ZygSCuqab3LCJ749PsX/02OKVMbnfGRhbTetNGZhb0gSW+qD9HfU1q69c0kbs8m+feph2mgvfCPLG8pecaR4AIYEmqGTn6WbNjB4/4LgIqYDTqOr7NqUjKvvwFO43cRaaUdj2nSQWbWYc3PhpoeRLAUc2IEf/ERw0Seo9ryLUciQIrMTwnj3CH7xsDwf6A9droDAXt8sJImzu93gZN6W9BYOuYp7Bt+DtaJqjlgKstpP1PSgxY+GMw3fuHn1;4:w0QmgUOZZ0Snl5ZsCh8fiM9sPan8bFOwiSr3w+NtpDVdP99q2RdiF2z9PE9/YlRmuRM6jKn+DRVG2Xv+h7JhxYFdxTCV0SENNU8B0iP1aQvBdfP/R/5dM470uQbw3bAQ8tSrgzww05CnNhU3RDkkb6/PDpFXrmTH/pgKCgXUguWAyBjgaaCU0+1d99uk4sZQpPbV13v713iUsqWBboMhkajevA0lzw2AzfyMNhp3TX6Sm7a5e0gDeLNMK8AeUit7l7p2EnosKQHkqzaXmWcvvQ==
X-Microsoft-Antispam-PRVS: <BYAPR07MB4920E322C5923A19D9F3252BF9360@BYAPR07MB4920.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR07MB4920;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4920;
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(316002)(16586007)(68736007)(305945005)(53936002)(97736004)(6486002)(7736002)(107886003)(86362001)(11346002)(476003)(6512007)(14444005)(956004)(575784001)(446003)(81156014)(6116002)(47776003)(81166006)(50466002)(486006)(3846002)(44832011)(8676002)(66066001)(48376002)(4720700003)(26005)(76176011)(2906002)(2616005)(8936002)(6666003)(50226002)(186003)(25786009)(478600001)(4326008)(36756003)(51416003)(16526019)(105586002)(72206003)(106356001)(6506007)(5660300001)(52116002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4920;H:localhost.localdomain.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4920;23:DvO4+RlG2nQeLEtnv88p3DJFLn1fK3yQHoOLBhIeI?=
 =?us-ascii?Q?ZTCo/2WtjBRrlIWXJHPNi8zR8RIzJE/AwtHadJulPthMTn67ePemT8Om81hC?=
 =?us-ascii?Q?j768Ed+9ovC+g/6WoSdMv1TmOTNnBt0tXnm25/cYgbx2GFUrkpIWhkHqDQ1T?=
 =?us-ascii?Q?qLUdWV+syVj1i1BvkBgsyKAeFr1Gg/GGvrz/3BZ3w2+FZ+ex52+2kRN6eZb2?=
 =?us-ascii?Q?4v3fekK1E1sAys0xQnZNVRL5hlfWkJ8Sn16CgOcCcRA05yYkrl7klDRAndDH?=
 =?us-ascii?Q?wkiZrYrIguSXfzfwrglu7MA5pFm9T6JBzESex2q9uGTAgIVrZowZou4/atlG?=
 =?us-ascii?Q?fyoWqVPS8xLBBfgeDAUO2ZV2Xq8H7QxJ7RIdyLiGobIM++ELrWDxCNhZDF1R?=
 =?us-ascii?Q?4Q6SDAT8oxf8g8aJtEQErA+lXJiaJwjgkeU0xpp5OF9ARaYpRQJyWHwCBmLg?=
 =?us-ascii?Q?FDLJ1Wqu0mHSJHg0092V5T5P4btgIlYp5/eFZVh7AHm3YXzJ9DewSAQFbiHu?=
 =?us-ascii?Q?niXQjemLf9j6N8S8o7GaZmvV4dYLdW9nsGp3UrrKHOa0Bo2oM0F/M+Ybzj2f?=
 =?us-ascii?Q?4NbpEX7oxIL/RV1EeLHYdsx+KDWmeQJVt0KqUTJS6CUbpU7GJsg2faIiyD0G?=
 =?us-ascii?Q?sxM+/udBWBz0zkXx6F83VotF5P0HW9A6wY5sN6OgEbqj9CWqnoXvJvciOYkr?=
 =?us-ascii?Q?UxVaZjN+a2klrz+lw+nnUcNFHzwAK4Efn47gA/e3WjvatPku5VGXZGgK3awp?=
 =?us-ascii?Q?VoiJOKkj/C+bcp8rX33234SxwR0QVbMHMfXOvjZPA/OrU+auwJj7KxWBkMjU?=
 =?us-ascii?Q?QXOqJRw3hCk5hg+YLsCvFWAsnm9dOng98d5EvANMcy+m5JKcOxkDWxcWOkzj?=
 =?us-ascii?Q?86795Yw231imiai4Ud33u673RGQukqwdp2qSf7uOFX8al7Pm8H55NatekGTS?=
 =?us-ascii?Q?5mWe8BzOJWe9A6QgrsTCyaci2RJhGRmxa3RxKNKRkYGX0wSTeJUGWE9birVR?=
 =?us-ascii?Q?vbiEOXqJ7HFW3SFYq+OlkT6gFAAsR9mSkfYmP98CkH8SkMJrkGeG6koScPn+?=
 =?us-ascii?Q?j6hkAEhjHdoUKJ35VIzsFdMepEuHcJgFJWuBSe+CAaGBsvAHgqew6/mmuuHX?=
 =?us-ascii?Q?EefNW/O7GvLn/gl1csyVVWB+nQ7HslfkYkPs7BXe7dN5egFo4aMXGz/PhXe7?=
 =?us-ascii?Q?giR2vXlrrRK3INwqLoQBp56ZR+y85mv2s/WfVUv8CcPcu9/H5rgHZ991TxR4?=
 =?us-ascii?Q?PImN1BhIx/NZFv/yceGFwKOjUgvzGlKyNye+3pIqSAvRrplyFymAAkWB4Rdq?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: Hi3PcYchZcbxbhWZMRDnrg5x56XFcsPWa4DqE29wZxLG8AE/Xx1dJtqNiNP82/OLlxU/nyvPG/w/EK7hvmP5ul49lo9R7kfc8R1K1gxkb1kOWhA3wklRHOnkIAPogJM6rEzJOztYianO5DFsC14qU34CBp/kvsARQfeX1Iv1f8LJnlxVH3VCnpO786+srSsrWl8ffpgCi3GNSMlWF0GqlcYLTyib8Xhdj2b/w/1CONQh1WkHgQFVTyaqNxA+AsJPo8jWvxOaBf2QvloDsXgM5qmKQeovumlH17mhueMeVHmMatMVRxEMheqn92RxtH3FVVIs9rIUsdgO+wUpxzvDVrJ+W6mBLynL4KlDCHToryA=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4920;6:T2xROT4xotKih8EQ4s0lCHAplo0GdxzhXF9zTmz+QgITL3nAvqM7R706rEA7XflMJgvoB0LgNDkAob3yeZTPqvwJcASilb6InBqTJp15tQNhbkb5XR3cPqlIPNCp6PHIcE6/p3hBi0fVQvwzxbScpMs+w/PUx2r3R15rFCfewlYOn1579W8eBBYKhp8yQ2EUCDfYEwAWcWo78GXQ/d/oc0pk1Rz+Xi3Vo2aAcq3blGLl9LpK1SOGXH5Mr5yIOa/1LZKq0M+q35f85t0AqmdZ55uuFBenD105stj8KzUNGTbs0p2N6/5+DAtNG/KD9afWo8HNDT50wWDr8CJ8WbvfouhHwK/d/qyEV7tFEVwU/1ySsVAWMgm5YSjnmap5zdPNdT70YckzvbhdY+iiidE+2tkUyUlTaKSV909PL+/qskxWTzTVaWJfbG0uugnTjPlAe7e3gye/m9cUPnCt1Jhf1A==;5:VF23xE9qr4sesBz7ier4eg6cgDv3N244yl6fObYA/23oeuu02gYABFQgnQxTBNgK4D3rbh68TpLfuvHXCXuhEEZLWjADuzd69fdqKLfejG/XDSsbcKe8wIdw8+lbAWzVgvs5tm8sMda04UnkqoUnSFQStIlDR9aHD4S+NiSBOns=;7:C9kv2yzUnVlptQwApiTqmGim75EoGqMTJcoUrvhKe9ksnlnIyl8J7L/N62AjTkzd9teHPw2wCekKHSN0AhGMDtD3tcwCpIzdGJocMSdZhnV1SgD3dTm2wBmd5xOGwM7cZlKv+3Z1tSMokh/SpJ1YchRJq8Ls41VZd/9+erB9ttxy2+a+Zfg2VvnQqPd7fKjfiGT8Z8/5RLzTDzNb0nwS5yKC7lxVs4pGM+CTr5LnCE7mTVL+OaYHEErEMlFJ2cXd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 11:10:33.5041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931fcff5-ee77-4bd5-632a-08d609b236be
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dont set ssif_info->intf to NULL before ipmi_unresgiter_smi.
shutdown_ssif will anyways free ssif_info.

Following crash is obsearved if ssif_info->intf is set to NULL
before ipmi_unregister_smi.

 CPU: 119 PID: 7317 Comm: kssif000e Not tainted 4.18.0+ #80
 Hardware name: Cavium Inc. Saber/Saber, BIOS Cavium reference firmware version 7.0 08/04/2018
 pstate: 20400009 (nzCv daif +PAN -UAO)
 pc : ipmi_smi_msg_received+0x44/0x3bc [ipmi_msghandler]
 lr : deliver_recv_msg+0x30/0x5c [ipmi_ssif]
 sp : ffff000037a0fd20
 x29: ffff000037a0fd20 x28: 0000000000000000
 x27: ffff0000047e08f0 x26: ffff800ed9375800
 x25: ffff000037a0fe00 x24: ffff000009073000
 x23: 0000000000000013 x22: 0000000000000000
 x21: 0000000000007000 x20: ffff800adce18400
 x19: 0000000000000000 x18: ffff00003742fd38
 x17: ffff0000089960f0 x16: 000000000000000e
 x15: 0000000000000007 x14: 0000000000000000
 x13: 0000000000000000 x12: 0000000000000033
 x11: 0000000000000381 x10: 0000000000000ba0
 x9 : 0000000000000000 x8 : ffff800ac001fc00
 x7 : ffff7fe003b4d800 x6 : ffff800adce1854b
 x5 : 0000000000000014 x4 : 0000000000000004
 x3 : 0000000000000000 x2 : 0000000000000002
 x1 : 567cb12f8b916b00 x0 : 0000000000000002
 Process kssif000e (pid: 7317, stack limit = 0x0000000041077d8a)
 Call trace:
  ipmi_smi_msg_received+0x44/0x3bc [ipmi_msghandler]
  deliver_recv_msg+0x30/0x5c [ipmi_ssif]
  msg_done_handler+0x2f0/0x66c [ipmi_ssif]
  ipmi_ssif_thread+0x108/0x124 [ipmi_ssif]
  kthread+0x108/0x134
  ret_from_fork+0x10/0x18
 Code: b9402280 91401e75 f90037a1 7100041f (b945bab6)
 ---[ end trace fb7d748bc7b17490 ]---
 Kernel panic - not syncing: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: disabled
 CPU features: 0x23800c38
 Memory Limit: none
 ---[ end Kernel panic - not syncing: Fatal exception ]---

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index ccdf6b1..1490636 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1226,7 +1226,6 @@ static void shutdown_ssif(void *send_info)
 static int ssif_remove(struct i2c_client *client)
 {
 	struct ssif_info *ssif_info = i2c_get_clientdata(client);
-	struct ipmi_smi *intf;
 	struct ssif_addr_info *addr_info;
 
 	if (!ssif_info)
@@ -1236,9 +1235,7 @@ static int ssif_remove(struct i2c_client *client)
 	 * After this point, we won't deliver anything asychronously
 	 * to the message handler.  We can unregister ourself.
 	 */
-	intf = ssif_info->intf;
-	ssif_info->intf = NULL;
-	ipmi_unregister_smi(intf);
+	ipmi_unregister_smi(ssif_info->intf);
 
 	list_for_each_entry(addr_info, &ssif_infos, link) {
 		if (addr_info->client == client) {
-- 
1.8.3.1

