Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC55C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FADD20839
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DK0hkBAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FADD20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbeHMR6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:58:23 -0400
Received: from mail-eopbgr70113.outbound.protection.outlook.com ([40.107.7.113]:34160
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729904AbeHMR6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YaMR1ZR7dpbBZoo4b7ted6983k4kiW+e5Rg9yQu924=;
 b=DK0hkBAeS+DfLwcVdp0try3eAJ6hHaTOZYCE/ahmF05ZGCI/u5Uc+uuUlSsIIXNEeWK3LCar0HYho3E41kUczmr46QIBRCebrjzQ+28stJGhIKQYEw99Q3BjN71AKGA36wpBq8bdWBzCieoI2WiqMPwvlK0+H/bLxXkFe6W+Dew=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB2022.eurprd08.prod.outlook.com (2603:10a6:4:76::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Mon, 13 Aug 2018 15:15:33 +0000
Subject: [PATCH RFC] scripts/tags.sh: Incremental tags file update
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     mmarek@suse.cz, akpm@linux-foundation.org, mkubecek@suse.cz,
        yamada.masahiro@socionext.com, const@MakeLinux.com,
        arend.vanspriel@broadcom.com, davem@davemloft.net,
        willy@infradead.org, joeypabalinas@gmail.com,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date:   Mon, 13 Aug 2018 18:15:30 +0300
Message-ID: <153417331829.2559.4172736805313132484.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0701CA0023.eurprd07.prod.outlook.com
 (2603:10a6:203:51::33) To DB6PR0801MB2022.eurprd08.prod.outlook.com
 (2603:10a6:4:76::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3303f98-7e2c-41de-35ed-08d6012f9e09
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2022;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2022;3:BtoK+KsRfsdFdqJIPzjDFXuaxUcIX38Dg84faOW8fFkGYxO1DE9/2T8zWowchHV0FzAnOqMP10Kpo6cwOnvoPZ1AD9Ay/zItVhrIQnL0bU0iqWFNLqQpHs6qtGP4pG5SruN3Nw63mCzRhmRyWKQ1UWlgiB2a7IBeU69ot2y0OwLNthhGQWxoqvGnJJOJvALx6+1gU2teg79bOfwyFCtZZtHb9y2kcHf3hU2IxenWFpamOwal/cm1e2o9C2tT5qHG;25:pp1kxbqZA/NCUwrmwxh2ibd7hCt+y+YsuMbfsCwOHJ2DmR7jlspgR/YWimHiukOPYi/UfFzcx2IquLhvGSx1Q+5snBeewca5Wvlpsml9qUa9VJ3XWdBR2BYNAPwXKhnjU8kCxejkvilY4M5keDVHbCMjCF/6yUWICBO3DsLfBtYO+TBoUjbI8oDTxAaKV+zhuctDKPcq9lXnQdRGf6qXgri1aOXc6n/RcmtdKnW09TyVxMEWwTD3GjS4f1CJSXfE0i55UwUuJ0RbADb4cwh5LwnGcm1GtESSs1c3RjB1MT6dWPRnz1BUo/OAygZq+I655YnGwKwe1tF9YDCQW+OXSA==;31:h65WdIaRdP8oqAfcbUqg9s/dKnlUVBOi6a6PFBjqJzTNMVmnEIOCWvb5Y3O9YPM9h2jY9e8seWSQRXzT6HoZzAZr/ePoyiPn3xj9136jAEczTMFJLlMsZQVpxt2Et1G4XnvVd5eZZk2M8sNLQB1ImeV0Cc57W0+NmSnhYB7UDe0mnVy4xUa44Ie8A74c1AAgB3gCuuDq7FRrcENlpKAhfO6lKLluPUMO15l3ZbRwBSk=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2022:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2022;20:16N15+ijAY9f+h8TLT6RELw89/x1NYDgwkv2G0+N+knDd4ZHzuQP/3eFZg1fMMw1CMxk2Lm96MbhztFrh25auruXCkaOHTXZc4Oj+UKT86IwgjzLjyG4VfolmSOiDVjwFwv81KL3ZUYnQ+U71EaK0sfOPQ5n2D/zRfMbbQhukb/T4f3J05UDtOG9E2hskcWpYlLh+7E7GcK0q1MfHbYqeyyXUO5dPQT3aBjOh8LZXixgaOl4kPXgdTGlq8hynx2kEBzomSOhU2S3Ru/qwuQ70S7TgmotQeQzmEsI818D8Z4rJg6pVWEgKje4gPTQnlyvwM/s225/PCw29HdMlNmIvWnNmUoyD5Dox8tQe92TCM0tCdihU7WR3uy2XPCELzbNRceeuu04CHGNBZLwMYdzetDBiGBHiuGuDn6dEvVdfOxNlIxZVT2VSYiI3P8+HHmGVYQ9/OiBWxZpdMx7GEFuXKkk+JfhJspd9m2hUfQhYHsk8dN2XDctt2IkyURosvuB;4:2IPBqjzwbC04WKm15JmpeAUfRXeH0lntQLEAnliH6gQZCcgCR66Bc600N8DW/6fpOIU29WtDUWGgB4lbxXjsRDtF7XAhqk6fTI907lkj8b2JTb0b8wQtBad6rwa2AaR9N3wE6OAGG45udNBcHwln8qU7U7A0JxK8VrZT4JtIynegp0C1J4RTY8qg1ExKNHXl8X3G+81r3BCaVhdtybcTGq09duZG5JG4urTo9jSZ1oZbY2AhyY2SgiLx4gwautewxUx2xqMQW1neCyZE5gI2zDybXur6jXEd3/mSY/Rx/FyfkAX4BuLGHtFbo59XyZv1
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2022DB25FF115B4BF4FAC0BFCD390@DB6PR0801MB2022.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2022;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2022;
X-Forefront-PRVS: 07630F72AD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(346002)(39840400004)(376002)(366004)(136003)(199004)(189003)(7736002)(8676002)(2486003)(33896004)(52116002)(23676004)(81166006)(5660300001)(7416002)(50466002)(7696005)(15650500001)(478600001)(305945005)(39060400002)(86362001)(81156014)(25786009)(58126008)(97736004)(103116003)(68736007)(316002)(386003)(106356001)(105586002)(956004)(8936002)(476003)(47776003)(14444005)(66066001)(2906002)(6506007)(6116002)(9686003)(486006)(186003)(26005)(230700001)(53936002)(55016002)(3846002)(61506002)(16526019)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2022;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjI7MjM6OVVSSmI1OXVaSUdGVnJDRDU2QzVDampq?=
 =?utf-8?B?dXArdHllZHRjdXRSOCsyVUs3UzNtcXRJVnNYdnE0MHp0bld5UXR1cVpOUXB3?=
 =?utf-8?B?QUdLRitaRnRRS2hHM3Y1Z0NCVnNyVUlDV3Z0NE05MGcxaURmMkozWUZ6ZXBi?=
 =?utf-8?B?SGZTdHd1eS9FYlhLd2xyL0lObEh5OHB4TkNjRUpYbnNXNkc5MTFpWStVeFhH?=
 =?utf-8?B?bmhSSjl2bS9NNGZpWnp6SEUvc3c5dVltYjg5TElMZC9iZXBaVEJMdXFYK2RQ?=
 =?utf-8?B?cWtvMXJ3RXFraWNmQXpqOHRTNHZOTVFRZEVkamEvR29NZnBHVEMzZ3RMbXIv?=
 =?utf-8?B?WTVPcU5PVzdNUGVWQ1FDQlFuYThRZUNkUGhlY0NTek94ZGFJZjVEalZSVnpH?=
 =?utf-8?B?YjBKeE1NSHp4Nm1TbG1CNFRmbXNaelo5aWJ6YjE4TjA0a011M3psNUtIekpP?=
 =?utf-8?B?RFNGNEIzZFQwVUF2WWlhM1UyUWpsdHVMTCtRMkRvOXA1QVVHa2FGMHFZNko2?=
 =?utf-8?B?VFNlMDN5KytvR1BDUVVvdUpad2g3WHp0VHhIV2VoU3ZZMjJ5OXhmRHFoRnRn?=
 =?utf-8?B?TGczN1U5Yjl1eHhwZEFvcjNTZ0JSSWxSYXVmamk4UFZZdTRyVU82cXUzSU12?=
 =?utf-8?B?MkZaQUJOT3JEZEkzSGY0c0lJM1dtS3pxU0cxMGpwZ3JnZXlMbi9ZcDNMYjZm?=
 =?utf-8?B?a2E1ZjU3RGtjaWJoZDVJQmhmYjhmTS9NMWhhaHpkbnN6TkhlNGhlUHJSYkow?=
 =?utf-8?B?Ti9VbGdlL2l0UmE2Vmx1dXZsVStsMlZsTFM4cEt1dkVNVzJFN25YZk9vRkFj?=
 =?utf-8?B?TFI4VlZta0tIMjBDckV2dTM2cXQyeVhGY1ZsUlVrVER6MHplMCtVNW9ORXE2?=
 =?utf-8?B?Yzdoc2RRL0hUQUhYaFd6R3VqYThNdGpQSlN6QzBXWlp3aE13emN4Qm45QWsr?=
 =?utf-8?B?eEw0dG5GSkxueGMzRTFpVUpROE5qbUIvSHFpV2FGUkpqenFURDJwMitrUDY2?=
 =?utf-8?B?cVRSZzZGYUU5MXlTaThlak1HVUFoTmxic2FDNng4cWs3cnJ6cWh0MVY4Ym5G?=
 =?utf-8?B?ejNNYStzUnV3bVREZDFBWjFTQnE3Z2t3T2lMVEdPdVlIaHFGcUNQWlVSN0Fl?=
 =?utf-8?B?Sy9uVGc5T1pwVW5UOEJYTzNtVXJPdU1obCt1YzY0NDl4R1AvbjcvU3FzdEVt?=
 =?utf-8?B?OHVuaFVycGFmeFRyTWJDeUI1RUtob1RSc3dEdk1pWUZ5KzFuU2FwcCtYa1ZO?=
 =?utf-8?B?T3RTTGkwcGljbHlSQjhGWmhRMWJsL0FNdGVIaTRGcGhBNFpqeWN6S2I2bUIv?=
 =?utf-8?B?TVBaa1hGWG5lN3ZUaDVIOW1iS1lyd2l1dVA4dlRGM2I0eDlqZGRhSUhYM2ky?=
 =?utf-8?B?TG5VWXFhWnd4UWxVOU93b0dFNmpaK0c3b01DOU1ndU1zQVZiWGxqbEpEVW9N?=
 =?utf-8?B?T083U2VOVzduZFZodjJ0QWNWMDRGSmp0Nm16MXlVdGFNVUx6Rkg5VjJQTFRR?=
 =?utf-8?B?T1J1ZmZBUWduOXRIeE9VSUdySnVMVy9rNjBsSGYwM2VLdXd0M1pRM3Roc2tm?=
 =?utf-8?B?SkVyczk4VnNDS2hsR0JEN2pHNEtCZmFhY254d2lmajlEODRKTkN2L0tSQ1Bm?=
 =?utf-8?B?ODJtN1Q2WloraEhkclRPMFplTmQ0TVdLL3kwVjJYbDNsdDZTQzJDVFQ3dkFs?=
 =?utf-8?Q?u5VBirO6PiG7FPxT3KCQ=3D?=
X-Microsoft-Antispam-Message-Info: C4iQAqbyV5kgRa2M3Z+5NJSKOp+HUh0uOqVZr9Xb2JIHBKyKu/ZzRkXC2+ilpJ3Criyx2OMGP5QDWOf+fG0sUYwQgfXqstf91q4ZWBnKoWGQ84B4RHydeepncvFG4pq/QyyqJAzX2p5aPeegQkaQO6yAp0gh6TnW4zAoai6IoQ+aTYZ4n1kDlklIH0Ujd7Tjs8MDNRlPwOhtUNYGdHTE8487ViFa96aw/brDoTdYLEsYetTUcJz8e0jUgLblUqFogOLo46p2mKZIluvkANYaY8pLgY2Q/vOgmzi6TbYL/cwPXLpUnKEZ+Ui/lBvnlXZ1teyUDBhuRWSfQVwHAUETh6sXHlV61h3zDjMMN1msuPA=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2022;6:VsnHYsaCgx3ga8Its80McQVhCXwHpPCdeStL2pFV1zkAUck/DDmSUpVezzlISFppFhnbG5QM+wVbR/vd1uL9xBEGIPsheTfpPPLk80kfc5MtHmv1H5JVp2tiipjnGhQO8MIH8lQq97N+CpJR3lUVKbcEFsvbu5hKLvTBQOvzlEqRks4KDFrLcrUNIwiipJNwAqFo23m8VyUYMBXC2rnxyiI9fWvq5L4caXFHXEB6xayhXu2vfasVDWF9tmqhF0r3QPQ79fjqwvfO3T3Q9mGICUPklO8PvI5o8GSE0217/rl99/jQiOSbnBlrtpLMgfgeX0eKRRRLSPLdVS4ZG/MQtNAhdKqjQGmz/GdlY1pCwzJRm6JFPgidjbXkL2VTVOcwtTPvrTF154EoQtRpsQnSvT5nyJCnuEnN5AK4RySRDCFhEJ7ifwONXmPuwQzttfK7RYaHkOCfL9WFuGMaZZqLIw==;5:tLC9JLsk95mnJF/OPkNXBrd+JXK/v9A37SZ+RXu6WGakyj/3ui8Uubvo1124Do8oFSHBEbc3H1Ux1VVkSsWHAQfkk5xedtxXMLf4r4dCP/tSQkcA9/YUxaSEa8bPU29KvQ+i89VO5dZrJKOdSrLY6rpzl3/c7ZF+qUzKLZDRvgU=;7:XwWVyrqbKXt61QRBK9TDHkBn8iGuaoeoS9CH8vJwSfqgicOQn2HG6oGrSL1u8EeuAWNKlrSwm8F9+mfEMfjoWVVUUc0tTw9YdVI2IKzFjYm0VxCI2cWGGmFA2RsLkkjz+o+Da87vkXGxLrlKdx5AZVSI2JxRug0xk0hwd1Qf3sIKExWHrZps8F+kgOk0mwPgHpRJvP84qQ+iQhBI0NuHGM7kJIad7228uBABQbJhXUSxRhDMoMD03nsDB14kbCfm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2022;20:yRSRnDkzhpUwmfq5Sjiibl/u2W70An+9rukkkG9vsziTuy3Jss3xEBIbOeWCObwQ+O7IBq8pTY0EU9q+7DuxFsXSUab1YJbp8eF/clJ/QiopWZYicXm5zEPhaBCcNGGQIjV1kFqOBhadEhHPeJ+kPRCQIoylbEMM0aOx73M2onw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2018 15:15:33.7090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3303f98-7e2c-41de-35ed-08d6012f9e09
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch introduces a possibility to update existing tags
file instead of generating it from ground. This is faster
significant, when changes are small and there are only couple
of hundred files updated. For example, linux-next.git tree
is updated every business day, and every time doing "make tags"
we waste:
	real	3m7,833s
	user	2m57,787s
	sys	0m10,789s

The patch reduces this time. Update of next-20180810 tags
up to next-20180813 tags takes:

	real	0m32,665s (almost 6 times faster)
	user	0m20,136s
	sys	0m11,341s

To make this possible, we introduce new "!_TAG_GIT_HEAD_COMMIT"
tag, which points to HEAD of current git tree. After git tree
is updated and we call "makes tags" again, script finds files,
which are changed between "!_TAG_GIT_HEAD_COMMIT" and new HEAD.
Then, tags related to changed files are removed from tags file,
while only these files are used to call "xtags ctags".

(Of course, all boundary cases like updating tags file generated
before patch/etc are handled properly).

I made several of measurments and it looks like, the time of
generating of a tags file from ground is nearly the time of
updating from next-20180718 to next-20180810. These all was
tested on SSD.

Possibly, we may introduce separate "make update_tags" command
for this case, or not. Also, it's possible, bash scripting
from the patch may be optimized in some way, so suggestiong
are welcome.

What do you think about this?

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 scripts/tags.sh |   77 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 8 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 26de7d5aa5c8..557cc64049dc 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -242,10 +242,24 @@ setup_regex()
 	done
 }
 
+changed_files=
+filter_changed_files()
+{
+	if [ -z "$changed_files" ]; then
+		xargs echo
+	fi
+
+	while read data; do
+		if [[ $changed_files = *"$data"* ]]; then
+			printf "%s\n" "$data"
+		fi
+	done
+}
+
 exuberant()
 {
 	setup_regex exuberant asm c
-	all_target_sources | xargs $1 -a                        \
+	all_target_sources | filter_changed_files | xargs $1 -a	\
 	-I __initdata,__exitdata,__initconst,__ro_after_init	\
 	-I __initdata_memblock					\
 	-I __refdata,__attribute,__maybe_unused,__always_unused \
@@ -259,11 +273,11 @@ exuberant()
 	-I DEFINE_TRACE,EXPORT_TRACEPOINT_SYMBOL,EXPORT_TRACEPOINT_SYMBOL_GPL \
 	-I static,const						\
 	--extra=+fq --c-kinds=+px --fields=+iaS --langmap=c:+.h \
-	"${regex[@]}"
+	"." "${regex[@]}"
 
 	setup_regex exuberant kconfig
-	all_kconfigs | xargs $1 -a                              \
-	--langdef=kconfig --language-force=kconfig "${regex[@]}"
+	all_kconfigs | filter_changed_files | xargs $1 -a	\
+	--langdef=kconfig --language-force=kconfig "." "${regex[@]}"
 
 }
 
@@ -283,7 +297,7 @@ xtags()
 	elif $1 --version 2>&1 | grep -iq emacs; then
 		emacs $1
 	else
-		all_target_sources | xargs $1 -a
+		all_target_sources | filter_changed_files | xargs $1 -a "."
 	fi
 }
 
@@ -328,6 +342,23 @@ elif [ "${SRCARCH}" = "arm" -a "${SUBARCH}" != "" ]; then
 	done
 fi
 
+update_head_commit_tag()
+{
+	head_commit=`git log -1 --oneline --no-abbrev-commit HEAD |  awk '{print $1}'`
+	if [ "x$head_commit" == "x" -o "$head_commit" == "$2" ]; then
+		return
+	fi
+
+	if [ "$3" -eq "1" ]; then
+		# Replace tag hash in the place (fast path)
+		sed -i -r "1,10s/\!_TAG_GIT_HEAD_COMMIT\t(\w)+/\!_TAG_GIT_HEAD_COMMIT\t${head_commit}/" tags
+	else
+		# Create empty tag file if it's needed
+		test -f tags || $1 .
+		echo -e '!_TAG_GIT_HEAD_COMMIT\t'"${head_commit}" | sort -o tags -m - tags
+	fi
+}
+
 remove_structs=
 case "$1" in
 	"cscope")
@@ -339,9 +370,39 @@ case "$1" in
 		;;
 
 	"tags")
-		rm -f tags
-		xtags ctags
-		remove_structs=y
+		prev_head_commit=`head -10 tags 2>/dev/null | grep "\!_TAG_GIT_HEAD_COMMIT" | awk '{print $2}'`
+		[ -z "$prev_head_commit" ] ; has_prev_head_commit=$?
+
+		if [ -n "$prev_head_commit" ]; then
+			git show -1 --oneline --no-abbrev-commit $prev_head_commit > /dev/null 2>&1 || prev_head_commit=""
+		fi
+		if [ -z "$prev_head_commit" ]; then
+			test -f tags && echo "Removing stale tags file"
+			rm -f tags
+		else
+			echo "Updating existing tags file"
+			changed_files=`git diff --name-status $prev_head_commit..HEAD | sed -e 's/^\w*\t*//g; s/\t/\ /g' | sort | uniq`
+		fi
+
+		# Write current HEAD tag firstly as it's on top of tag file
+		update_head_commit_tag ctags "$prev_head_commit" $has_prev_head_commit
+
+		if [ "x$prev_head_commit" != "x" -a "x$changed_files" == "x" ]; then
+			echo "Nothing changed: $prev_head_commit..HEAD"
+		else
+			# Remove tags related to changed files
+			max_arg=`getconf ARG_MAX`
+			max_arg_strlen=$((`getconf PAGE_SIZE` * 32)) #MAX_ARG_STRLEN
+			max_arg=$(($(($max_arg<$max_arg_strlen?$max_arg:$max_arg_strlen)) - 50))
+			for files in `echo $changed_files | sed 's/\//\\\\\//g; s/\./\\\\\./g' | \
+				fold -s -w $max_arg | sed 's/\ $//g; s/\ /\|/g;'`;
+			do
+				sed -i -r "/^([a-zA-Z0-9_:.\,]|\-)+\t($files)\t.*/d" tags
+			done
+			xtags ctags
+			remove_structs=y
+		fi
+
 		;;
 
 	"TAGS")

