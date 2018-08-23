Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22EAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D5920A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="yUu159Ph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D5920A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeHWDoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 23:44:01 -0400
Received: from mail-eopbgr700128.outbound.protection.outlook.com ([40.107.70.128]:48096
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727162AbeHWDoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 23:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5nNx4wqFLrOAvforhbV36WdOQeFTa5U3SQd1y5iq6I=;
 b=yUu159PhItc/DDRm+q7BMx6NVZo8ZaiZvVpPH4lqXd5LDTZ9QnwviNLiOV92t5D++QvVvQJGn/Sg23ulAToVJfFYruGdA2molca1ITw08d2mSbbSQeFdRx+0N4RGC5ZgkoiKyAvKWlcUb2/XoSXsPZrD45THTOObZrYJsrE8c1g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
Received: from localhost.localdomain (172.56.38.39) by
 CY1PR1101MB1132.namprd11.prod.outlook.com (2a01:111:e400:5bd8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Thu, 23 Aug
 2018 00:16:55 +0000
From:   Ryan Lee <ryans.lee@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ryans.lee@maximintegrated.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     ryan.lee.maxim@gmail.com
Subject: [PATCH] ASoC: max98373: Added 10ms delay after amp software reset
Date:   Wed, 22 Aug 2018 17:15:19 -0700
Message-Id: <20180823001519.20056-1-ryans.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.56.38.39]
X-ClientProxiedBy: DM5PR12CA0055.namprd12.prod.outlook.com
 (2603:10b6:3:103::17) To CY1PR1101MB1132.namprd11.prod.outlook.com
 (2a01:111:e400:5bd8::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d2e2d16-5d5a-4c6c-5e94-08d6088dbcad
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR1101MB1132;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR1101MB1132;3:niwYZZvMRAl+qQbwBYGjUfAFG/8K//Yt1EbJsd4MW2/yq9JYkS1tQqoOQbj6bC/DqA+M2XiE6ZtFbrfbLdl7iPFCjimkofliOOxE122edeGTLO7P3+MDjEMbZNjuTlhvw/tHIn4Sfx0nBtGx3N0PS1Lk5seL5/mjyIDFbPdHZVXGYsq4cGKnjxhE6FJayA1LF2Alkm65cQbFv/4rKBvBu104eDig1a3e8KtqUV6Oyvdtennv1nbOUZ12U8xckDst;25:yijsjPPAFlsj4cKHRAY44yoxsoC6aE/gyiCAynit1FElhWEcM0lDsAdAUIOTH1s+HxGytXduw13DbrQAgq1tyrfTs9s0a6Ey7bIHYluFOH6nnq9N+YNXnuk8VCPHwKqeuliwaW9GgJWhEJ2tAuCB1uzFfpmDuL42nkoZZw7lpXMVGe8c0bar0XJ4zpg1jDzfoh2mWzL2WIFZNNPnACVt8N5rsE9xM4eCgS4qx0US3Ray1bXYX9Lw3bIVo4tg6Umkae5YutiHn7u53D7YaV4cQ6cxMrzBVO/he+F4Rxf+F6JytERkPKev0ZFNpYdbAaVVlXnMp5Se+5aEnMn3nQMHqxS+WF6VXef+V2rkpc2zLqE=;31:xa1Uet6sgeuHOgCq/eL9Im7gwnoL/JY1xzQLZaPP7xs8/QKRIlKvm+Pu9Dtyd7LvxmJMCkaHWw+qHrQBXFHJgqUbmSvyPxPX09cZmO73tvzzbGHlZT+2oE8qqBl0kcvd0sVaIYBQL78GK0mxp/aoKpvA/DfE9flpJhP/we8rdEuXW2hjodDQCc/7YPqcwZHE1FwcJYW1JBkvLtTGaXBVN0GGo3Q6dgTAFCwoSd/ue9Q=
X-MS-TrafficTypeDiagnostic: CY1PR1101MB1132:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR1101MB1132;20:zStTSo53eBYFFLE7pt4c35JY+leCjpo5VbEYBuW6wZ2Y5HbuxDnIdmI/RwBF3q67V1GD249cfW6lLpxqHIiQyd86AzkzwJcDsRziDE0kuX/tCuKKkKtwbDr/nqbEiNnnwY3i3IKCcvRKt8xzwZGwBMJRXx3Nz6/yTzrhynC2GZ+ySYlTLANq41rD7MjeQASMaBj0bj8Nh5OL6CtGTwFnw+HwGqehhRQxwRRraRxveU/Dyx2m1lD6gsqFCagZLH7pncIYNY0LHhdD/zJ2Mgb5HuGiEEx2wn7IUuN5vCRR7yaS02Fz813xbXEaOg0+/jXWtiRlEGYRcJrFUuR62YsTOazUwAe68F494yCRvbGOYZgVkh0D8h2iXrTYhsmg+FgxGYTTZzQ4L2PVK73EVAxSo9kOBlyNip7NDHd9OGBeGWJ7q06mRzWXyVJB/apPDYNbTMNjOMWn+j4J0Xf31bz2Cs2fRvidQKlyermvZX2STTaupf2kvsXP9ewD3FGxRfSq;4:cRSOIiUvzJMbwmxgcaUPwROzZ3o45ym2or8EyJThNtRFMYPgjUFKWduz7cTg/UcrmEADzCsTUE4qSRQolTDypu7xdnH+DrftY3tYaD5u6OsqujJHQFZIjEXkvXg0xBFOdk7RrSGZbLDCsoHx46VrXAjsgCgX+At1Uh10bl6TOJGW0WqbxuGEABaaZCT68Cyd05iYDW/KhZXHud1nprZor31Xb1sdaV0GnHJd83Vrm92CiQgNgUAc/1XOHlxbWn/wMxHqVlrpa8mjUguPCwrotU1ArL/obisbYy/2G8T+fK6G0OLljDAlL6oEHH5knuZq
X-Microsoft-Antispam-PRVS: <CY1PR1101MB11321C2C3EB4CEC74C282A2FE7370@CY1PR1101MB1132.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(108721460000369);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR1101MB1132;BCL:0;PCL:0;RULEID:;SRVR:CY1PR1101MB1132;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(346002)(136003)(366004)(39860400002)(396003)(189003)(199004)(81166006)(97736004)(7736002)(36756003)(2906002)(81156014)(478600001)(305945005)(8676002)(66066001)(53936002)(3846002)(5660300001)(4326008)(1076002)(86362001)(8936002)(6506007)(386003)(50466002)(105586002)(48376002)(476003)(956004)(486006)(1857600001)(6512007)(47776003)(2616005)(186003)(6116002)(26005)(16586007)(51416003)(68736007)(25786009)(106356001)(16526019)(50226002)(316002)(72206003)(6486002)(52116002)(39060400002)(6666003)(89016001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR1101MB1132;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR1101MB1132;23:yMq3kqn8a64oxg00V2o/QwbeCYvzf7eWzpDnIcA?=
 =?us-ascii?Q?PEV9VXmEk3xGT+3ztOtSJcC8e+HcVYWGa88E53bLB44Y5Onu4DXCfppg8QP4?=
 =?us-ascii?Q?0UjEiNwl3XOJm79tKDw6LftzHIXlSc/27RXazSV2sSYAAywXZx1oKB1idWPg?=
 =?us-ascii?Q?ujqJs8LqYnsbLsDfWTDJAi3wyd6QJRzx7h4HGI+rJC3uP5cPOGXHIOIN9CuW?=
 =?us-ascii?Q?amC7JDVad9eamI7Xb3JdkY2lO+SXwdyi4CjkWfqOGhD/e66nfzI9b8nIqHVV?=
 =?us-ascii?Q?wIl6lkUywTF3GErwVSNIBdnQk8RVrHSdn0KtHU+9w/YMEIBJQV/0vsxIvMFP?=
 =?us-ascii?Q?KCa/zllj5AjGsyxepXzPGGoPaGedkJghxiZWPW5tn6nnej//ioQIESC1Fg//?=
 =?us-ascii?Q?k9KDuVYyMR3vjueeZl+fchyF20Uc2jv98Fl4Nv0T1ShiLxiPsD607tg8Q38M?=
 =?us-ascii?Q?HIsnPIF45ua9axrmnLWcpJ4b5MkZuDXI1FIJJ0BcqlKNmEQNzidE/STbd5lz?=
 =?us-ascii?Q?CMeefeI+id9JxDsaX5kXWod5sR1u94QHLkDnf8WslXrLefLT5MVTbUFgHRdx?=
 =?us-ascii?Q?jyZntr8g6+uHPboCutb8TvJTeBrVBkZSu+pvYsL9bnGZBfwOVOmvhcVE67yU?=
 =?us-ascii?Q?uUzHKei3qNHyF9HmUfytnAX3i4VD2rsQT8Y1FHZL6p3LzygRDZ7bBLADJKJG?=
 =?us-ascii?Q?eqcVfBTRYOc18wADGQMrNk7OPTV8Hfdv3nuBbQ2qIpKmXhQIqxwHxPrhjZfA?=
 =?us-ascii?Q?cDkLrGQHtyG67wm027nOP7u/gzxK6H5a1lAna3LhWuO+IstGZKAkUCsV8SwE?=
 =?us-ascii?Q?wNJPjO179ETgDceoCz7G9DbHwUuHZy5n9ikMl3HbbC3yurPaK6lQJebCkIv5?=
 =?us-ascii?Q?HDnUvbDQ7gfj4ENP0e1HiwsQ4fd38bO1oq2rr2mRjn+8TY7WSKfHs1NOzQ2n?=
 =?us-ascii?Q?5ZzEDHxZLXkexgJIDeYYcPi5HN6DMt5HFSiPD8BjSqIsA4Vxg+PoxiOhhefd?=
 =?us-ascii?Q?qzq5+DiheFgmkQVkFBIpJZKGlrd1G8hpe1rzO57FE+F3BF9/ksfMmRMFbZAU?=
 =?us-ascii?Q?tGQEl4rnV1cTTDXbGIFTbdBtggy0HGDl/1SLOSFpljViS263iU096q/iMrfl?=
 =?us-ascii?Q?TJJT0Xzp786u2z8/gz3CzQiSB77lazE3VTfWXNc5z/IPAgaMyejsikmNN4p6?=
 =?us-ascii?Q?XWm+TPEW+ifkg+fsCf813pPSpX0a39jpNFnJ+EJaDguB8UWxHeFAgfJUmpw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: kb97gpcUiykvhkslnaEDDghR9CQ2momTQ5cPADvRDkVOSKf/H2Eun9rEiNz5ZZFT+ND3Csw74y39LMznuplPK0Hl/YtAEX3tpzVHzOVs45of7Ig3w+7RiOqu7Y3mxDl4EoPqUX1dL9X7ZWeU0ovpYk1Zn26hEN0aoXUw/OYU8zLRRLNsDdcnGlExv02LdV+9Em4arb+fpSEFmhE4hboK4KwIpW8GcvJoMni//UyW86R0evEkeldUqWOp7UdGdYPORDGuN31yEEC5Uv+NLeI61brODM+hPjHDbynZMQurq/igAS7xjomDesWvev+1ILb/qmcQa+KVZBrriew6/h7x1UjBlYAtks0D6RH0eVg3tEU=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR1101MB1132;6:nr1mRVWK4x0yx+XgA08VS/QqCi4buQm9o/T9nCrdUWhkPPpaM32ba0LR69zZ+nNLRzIN3iHQvazbb4VtljkCUXrD7R6gJFQ76s+W4BX3gOyiujypUfYTrRwxSbBCmVWcLuRWc/KGg6WzCDjkjqJ9q684gFG0pN5H0YXF3osXTAZb+b9kxqC+wjIG70ZQHV86SkQNhhUqUzD2ENBEBnWTVP5e2nKU+/zITMt56rLfod07ca2olAl777vTHHN2VpjzbmzXJpAXeUxw2fJJpwnjv14uuYiJ5i1ozMdRGw5zyW2cmkEUS0YiZmsZwGdqK8sKkkXAIEn3icy/frI/WV9AlwOWXrMtLSjDnEHNlHA4bCtFEALWAacQDS/axLsfifxZ9zp09qH7EXj0OmZJvhOtfZp3fw93kBZiEb/xlHNUMcT1P/h3AwHeuOi0MX+6Wx27Q6UPY9X16npopz/uJQzx2w==;5:MTtlboCKtimZ8GwOlGmZXTAeKjH2mhtuzzchxZRz+gadyvPUTtkczVKHehb2kZ1cC9C2E8fNjTjagg4RbMK9TGeYNltLkoAAsuNA3Rj6fd9W1ndcV8E2lVzQZNLUtM4p46Thyu016gLaivkvMEWoIPxctuoq25MFLWdHLcYoJmI=;7:mZljYdCVvjZV8/uMeinSmq/vyiTMnLhJT8zrwIhutlBYiSnxtGuBfqciwAD+SyCwNTKZ+MNWhbWF0CG+ZppImc5TLrCpGThJWWtJ4E1mdEZWG/9lqmkbiqUtI87bDx+4tkkZd4SPYFAeATC0+Q4e3nE0jTG4ByY4sH+TQL34vYPzX0cKqNAhQL7TzAL2KIDtY7TyzHT6M7cos6OXvP3vborc62zu9D0roeB1xhr0jjk6uFSVEpeaZggeK1Hp52Ix
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 00:16:55.4840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2e2d16-5d5a-4c6c-5e94-08d6088dbcad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR1101MB1132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 Changes : Applied 10ms delay after amp software reset.
           10ms guard time is required for stability.
 sound/soc/codecs/max98373.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 2764fae..6aaff03 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -730,6 +730,7 @@ static int max98373_probe(struct snd_soc_component *component)
 	/* Software Reset */
 	regmap_write(max98373->regmap,
 		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
+	mdelay(10);
 
 	/* IV default slot configuration */
 	regmap_write(max98373->regmap,
@@ -818,6 +819,7 @@ static int max98373_resume(struct device *dev)
 
 	regmap_write(max98373->regmap,
 		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
+	mdelay(10);
 	regcache_cache_only(max98373->regmap, false);
 	regcache_sync(max98373->regmap);
 	return 0;
-- 
2.7.4

