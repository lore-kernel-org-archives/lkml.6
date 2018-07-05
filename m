Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBD4C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62ABF23FEA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GQdZIJ3b";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KoOPTVD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62ABF23FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932542AbeGEUxs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:53:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44128 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754356AbeGEUwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:43 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65KmMgq015406;
        Thu, 5 Jul 2018 13:52:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=HPIsZak8jSoibuxtYIdHwIpLrNgrA8kygXJ18pHJlMM=;
 b=GQdZIJ3b6eKNsGErDu7I2xloU9ZYuvCpo56HcvFTWe1UkH3Tq3UQe6cuBVwwVuenjIPs
 NfRKWXLwjb+qIkMCCDapoJuNkn8c9+INWv9tXCdGPb2q0rG9TjRibhKLjOma+dmcTOSs
 h8kZosS4eM/gkU+R4upiorPrzAR+r2TsBy8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k1r3m0eus-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:22 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 13:52:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPIsZak8jSoibuxtYIdHwIpLrNgrA8kygXJ18pHJlMM=;
 b=KoOPTVD1FCWeetr4d4nI7Ob5Gs+olK2exBxPQ2dhblXBW781mNWS5jjTbBJD9eqHVzgkKtYGkIYK84QiKtCbXh4YFNj4s1NCmpFXPeuOe/LyBCnDkATTrf/UvsK0kjDoQtHQwr0B755xJoyV/7o23iyRrqbIJubJLMmKS/WnPug=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:17 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 10/14] bpftool: add support for CGROUP_STORAGE maps
Date:   Thu, 5 Jul 2018 13:51:35 -0700
Message-ID: <20180705205139.3462-11-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180705205139.3462-1-guro@fb.com>
References: <20180705205139.3462-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:9a3d]
X-ClientProxiedBy: MWHPR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:300:95::11) To BY2PR15MB0166.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c475be29-c64f-4aff-89a2-08d5e2b93226
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:TY7kvM8yIP+ZpErbH4KgtuI5j26J3qqAlcOEShz3Xecio9wQrFV9fy8A8MuemeHzIn1f1l5iI5S6+Sw4btmxQeq/OBn7ctbl3KZFPdDO4vSCfyLJ+6jD/fRd5P2rOd5n8LOQzLTigCb+56GRZjwj3rCwT5QZPn5U8ow59p/9KWleI0f4K8tcnaGyqL4Evxq3nG7xZUvv0w2MQIWnWxLUyNrducePaFdlGb6YxwdufcXWlEO3SXGgvrzFf2SPh6gX;25:CV+6mn0N/EidoK+ixGuPv6zkBE+cBLZiTGDYoTTnZIVYj4aFJd6E46qo7JrsaTyPYeWE/2vL8+ZZhG56ZvLiVOXdgWc7O3hKcJaUgvkO1SEY6utZ4RoVwByWRuocpiRj4IkhFaCCL4OVYHH7LKrnowVgmpGs97OvYxooGNSlHUZ0mL+0ZqjUbsai6vfpH07ny56YUXI/XpH/ZL9LxX0tK+XO1HBTgILhPGkhv0GUMeXC5JbIy2+eKU2M1FW59um/nheq4hewtzMKkVROW2fGRqz7UeaCjHtD+aOXR6tH6CkN0IFsEl304KIkB6h4mocwFljofyI0d9tiU3PuAuUkZg==;31:YInYH8Xw7LPWM2wF9dTmJ2VwrK8ie+ixJvbjhT5UsGqnN6+hlITvxyqVTrKINSIu8NKeW+2uWEh321gJCw0ANdFQHDyspryv8Vu/MhzaraHREdAJT15O8QJ+em/5gGTcZ6WEagdgM1VwYELtybMQFe8Jwk1Y+dd8yEC91CA7uoUudj5vh4PEAf1lMM9U5imCCvr58zSsBnj527nkTNjyWzMRRN8rPo+H+9qL0iJYh9E=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:+O5ofTaY7XjsjxfssTDBjLkttws8KjOyMmg7uj7tcYfJi5CelvZtBopEn/XFIq1Pk6s2ojT1Hdv8BNCKRBSe403XFLWap6cweKQpwr4IXT/iHZMuaHGvytQqfZmdrPd4gaqgtG2cMKfq9nrx6JMpMmC8f5hKejcOTnXakqxUii1BmkMVBt5o7TI4+qeohsoJvMbTmGx277sOFpOhBE6xLFpMxMB1HDfp+3GfNXrBMkOVpMeSRaU333IgGUeTE8aq4DBA0gyT7cs2mGh/YijJpob3+iZCNB295I3+phnNBAl2MeIz0LxWDcT6lzySxj7cYns7lvTB0y9fcptrj9NiD9ZFGCUe1VHWW/dtZ42CUBctTZBE6nwXhC4Q3HuWvi5o5MCD8q0xsE4lWnwqZp8UIkaHo5zkrICzuufjjtsOEBLm3ItLci/AUoL38KKUMeBwApmuTlPcFy82uC2Zqbbl2sb+PjndZljBsh/e8lbGEnGOJWNnyv6B1y/P8ppsZFSE;4:hoZZIYy8zLL9wHA9uulKbL+AwSeWB8tJtJsxuGbELxqHRW1OS/yeBxVIxPL9Ok74BFH4s+B+I7kWRQ2ECA6gGpgPQ5Fs+uVwC2o1EidK9QeqJhhiO2xD74Ezya51VQFrSNEMokP6gG+m3Iju8jwzdNl5tEM/e4yawNxl+VdtKMO++RYara9mZMl5SUCyF2hLVAVbnyA4XuvEidf8jQkJ2KYvdM47nPMI9nMaytN6ls2jw+uUBvYc+CO+eW0lmp0l4Ql2A7hIMAG25xxr+4ymLYojKbm4JsmooAZc/KK/HRAPZYvg+Ihshhg7kTOUB5kW
X-Microsoft-Antispam-PRVS: <BY2PR15MB0166DE124032EBE8720CA9E1BE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:/gpPGUHEYD05MPQM7Tyw/45se02Ep43C1q1DYkRfe?=
 =?us-ascii?Q?HS7pD3fqHZ/aVKidPsC4Z1uhin34QeFdgRicwQVPhoS6ruIkRILZfGt5QHyf?=
 =?us-ascii?Q?ItROZjRO66HCvX+8386JHc65I6m3FT3bTB+x0ezsDVoosLiUO5d+hqM7knTO?=
 =?us-ascii?Q?/fVY1xOwqJy0pyeHOJOhe2wH+OVLEoMbqhdMS0wT7CbdWdPaZ8rQ6W/82eJq?=
 =?us-ascii?Q?I/U8o4mdpDmyq2xS8bdXTf0PppoILPDg0aeeREyOBQ/sSe6AFkrVzI/RgpOE?=
 =?us-ascii?Q?jruG/Wu3WpLfrqMyJGcZhKmcJVZPcyuqCtvMyzVHFGyMnSKgXdsdAZxYRhJd?=
 =?us-ascii?Q?Fuhnq0okb8MLdnIx/Rh4yhYEGzpjwfEXVZ4M/Vu/sq3ERDivHooCZ6cCtaXP?=
 =?us-ascii?Q?r7aXa2Ya5Uu9+kGxJDVrAWoJ8VE6KUHREjCy/nu/hJhN/0hRp4MJgAU0VZnJ?=
 =?us-ascii?Q?0j3XBrSuWMoXNWL7++O9QaB9ZUOKyz8dlfSnqCPzRACNyBvmK5hY5CErNuZZ?=
 =?us-ascii?Q?9Pesq3qfiPadu+W5tACSYWowntGtJLkOTsEZqz+IFvtsTj3z5OUzUQqtLJmj?=
 =?us-ascii?Q?h3NrwBexxg0SkdTeKKtkdlQeggXtYecoWC/DNnKCfJOyQhViYURto4LSQ+Dw?=
 =?us-ascii?Q?vq850m9einCjRorRJjjHWdXQd0b+h/BOiH8wRrY8Zel8DoaSLpTbrP3R22GX?=
 =?us-ascii?Q?+5k+bEZZdabI7QV3V3UDOZ7xkzc4L22LM8UXib4n0nzy/phuI4iyhbs/9U5f?=
 =?us-ascii?Q?A7dRzOUZVOjFw3ed+1VY1aSB2WAwY4LAeQhpJUtKI/v1cedl+qKC8vOupUxa?=
 =?us-ascii?Q?gzijKVi/O0G9tZjqnPJrz9FvunOcjrL9r5CuYFBtvDhYo+sc8Tagtne/YHkd?=
 =?us-ascii?Q?5VpggdK1Kq+zkHfJcByJ5iiL2EY6EfQ9QQKaX/D7BBqXuafUUx46y+VDaaZ1?=
 =?us-ascii?Q?eiAHCMaVQfZdg5Ewx4v4ZYjL4Rm8cC01ggSN/6K5eOGlxnZzehu3Wotkwqm3?=
 =?us-ascii?Q?f3XZcP8CjSs0om7HGt881URX46wTaWzCq1/3wnVeqQTZSvGuv9W+Bf9dz4SU?=
 =?us-ascii?Q?FN1Lg/JS9AFToDnlMdn5PQyQ2xDky8qnNj65LIDpCAPcNOjw4L9F0HwjtFj7?=
 =?us-ascii?Q?5jnmlU+zkOlKDM2oHTNmLdvMtKhGmfMALMDcsYTe+mMNagz/cvAPDqGUCkqT?=
 =?us-ascii?Q?mxYMJL0RaCYrrzY6RER2k57q4QJQffE8+vVK7Y4J+G21gEXzfy2aw/zsJI+8?=
 =?us-ascii?Q?Q+5L/xieR0HnUgam2k90iGAOUd/FfuR90O5WsR96Ihf93oGsS9lKmPeoYEca?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: lJMZzKTBqKyeJe/QpRNK5iomC0nvY8kAGbTuQpQYCQ7JmzBbSvaVXq+VI5eE7V4tedeD+Z/F/Tp29E39h6yTlaVX636o1jGE0zZLmEXZZfHfYQRWSpCUCIi70RyOIyLxgBnxIeErsj/7sOsY8eXY2DX85Y15hEy8hv0zfT1e9vF1zfQi4rIYMu+QBpdomBUv0Z0JxS5ItOUBIE5iIR/UuHIJOVIm0QYnRJsLHiqT2eeJELr4W2cTCzBc6f8KCL/aulFrDEa9fxC6oQF2nO3sdlRjlM+OpTHpQ6TtRPyUzhHoRjlkMGPD+8poW5WmvpysfLLNvcQY/BM+/weQw1oFYTSSp2y/DWmnhoQl6x7P414=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:nTEFDw6gmsV5d7sZHdRGJCmGj8xhWdOBQlzlX/8Z3rIeWV36t36Pp1/61Hldg5ZDM1eMh7Fju2N7UdAntiBkY72Mh8N0Q6SUVl4OUhpKsuXg9D/rkixDGA7KPJyQ4yShkYSWNmpiMpwYlzQOQBzuzpDqo2Bt8xr0TogudKalGnLoElTNdSx9oCX/eW3qD1SBWvh8XZFWBxyUp59xUZdQMaHC1Qq4DAigSEwuRvGzw0PdYaSSs4y8YzkaUPspNcyL4b2V4KPqzvZKXlpvcbxN/h3idKtF9gLXHDMUVoGRTNhKO6Y8lnUj3UYpcpGqRFu56EXeqlIIOfUOsc4DLhuQ6qNNeR4c/gfC1lDKs7Aon/IhLVuIbthmCqhPUEpNvuuRsetljRIzoEdB7Alyk7NsJStHw5tfM3QihQItkiDshhXYPwm4rlASpAzgy7mKSdT8cHwHOVw0cQfR0ZQ3sLWnyg==;5:+C0byGqYfSdeTZ3wDrQIoDM+ne/OT/DkibpXOV8V1EQiRkFYs3IsCgNezB9lSAXrLMs6wINtV9pFKA9yH8NjJvLF3J7oznwOUImEGbooGaEnkzr5tEZuLLAVDH1VD3hiTICjE7RygtD2L3N0aCloqj6kz47QNMg7fykDZxfAFsU=;24:3tAYSRYVGvoV7Q/zwBgRVsOyUl1qNWZcBWQiKnDINgcJfCdZnl3TAFfix/ahWsof0yc5vyAk4MSs0RFF9SVgWqRl15DMfq62yIFYClwWO78=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:qZO2T9RlB40ZtTJUOiec3b6YJR1mgeahZczr30lnZvJM3sdhyRmoyt1m13fO6sJ6cXsyRx3aGEoWihknufh/MjzNrqS1h8L0GFtnLx7wuetBHg6siE6+UN/R5XvK3v8IoYA9yObIt6O1YdV0+UZDGHNla9Fo2OPmceVZa5hZBJ77wGm8UKbbCTcwSLjittMX47cWnwhHev6l1z6YhDAmK4Q9LetJYFUva3u5yWYPiTXTyfltopktMCBmX+1GY+BG;20:ztvn70txKRSjtLU+Y/aR7VAWIwPEZkuIPW8b6NwQyruSwiZhwYkX+K7mHJ124hsfP1DBzaDWUoboOBm0WaYGgfMKj1l8jviRJJkkeSFulSx1BJTYgBjYG7m2YkINIHZ0d1wcf3mRnw2lrMSxvMiFBTDFw4NTmdrNxRzulsZgG1M=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:17.5171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c475be29-c64f-4aff-89a2-08d5e2b93226
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BPF_MAP_TYPE_CGROUP_STORAGE maps to the list
of maps types which bpftool recognizes.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/bpf/bpftool/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 5989e1575ae4..14bef5855d8c 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -65,6 +65,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_SOCKMAP]		= "sockmap",
 	[BPF_MAP_TYPE_CPUMAP]		= "cpumap",
 	[BPF_MAP_TYPE_SOCKHASH]		= "sockhash",
+	[BPF_MAP_TYPE_CGROUP_STORAGE]	= "cgroup_storage",
 };
 
 static bool map_is_per_cpu(__u32 type)
-- 
2.14.4

