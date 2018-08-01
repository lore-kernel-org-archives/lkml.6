Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B977DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DF3208AC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aHRkuI5L";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QAGQrPRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DF3208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbeHAXZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54708 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387633AbeHAXZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:28 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LYhpq002833;
        Wed, 1 Aug 2018 14:37:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=SS3hL9y/Kz8AKahUGvBHEw2nIAlhiKXXnDeKs9koJN0=;
 b=aHRkuI5Ly1c4uKrUh10gPMyFu5hMKjsnrT5inYWUZD+wr7VZPBVMXBg7J1/gv+p01q7F
 35DK6g0V3e7CbP8NtKoo8JzzBJMo0dvz6R+BXk3SjYQxaCDMriReKLww4PqTiUHvWlOE
 3iYl8MbL1rxlqJae595amrB84rg9Kv8IS1Q= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkmqb0163-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:19 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.22) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 14:37:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS3hL9y/Kz8AKahUGvBHEw2nIAlhiKXXnDeKs9koJN0=;
 b=QAGQrPRIzCMv32czqkFecqSu/vnWZAD9dBFqPTExO6aKlQvYEX4knMTb/Xl2P7zsT3vJfWwqnZZjPkbY8Bz7txiq3oXX/kQyhh1RJ7+Ro7TxUnz4dB5l9cK0XpH3I0CVGAQBVqPrAe3QSFkuOMFk3cVfKn0kYwE/aw/Z7k+agGw=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:11 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 01/14] bpf: add ability to charge bpf maps memory dynamically
Date:   Wed, 1 Aug 2018 14:36:36 -0700
Message-ID: <20180801213649.30751-2-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213649.30751-1-guro@fb.com>
References: <20180801213649.30751-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:18d2]
X-ClientProxiedBy: MWHPR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:301:73::30) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d2edd5a-e15d-491e-48ed-08d5f7f6f0d0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:eRL/j+AOOTN/zo3iJUzfWQCawhRgX3LEDIOj+fX/kMij44VpWs63oOqmCe09DgryHKO6gjXRVd+7xk7vBNwjbpg+3hzPFJOcpOJ2STqcxgUtOtAUyvexSbDwOYGUOqrcLZSsTg34Hu7z3InUSSD+5sd8NpUYQM0EXFd7DOEOSWB2617le3ss/5nODuuN5JusYTdmOJbaD4IFl4BAQLuToPOyEPj1D3OAMmVJmmA2lV2KvvF1hnhDXQqqWUJyf1ld;25:GgqqJZuuMx5mNYNkYo+HVNEtmPPUexYsGYvmAFOJ5L3fbMz4+Hs/jLGvCiNQ5WFzbjatV4k2QYR4PV7wrL6XpYo/VVKSgI6hv7v3NyfY+FfCFjOfqxNdnup2qEcR/5SPkRmpThfby7sDku5Fg9UOhQgV3RyOirXb9aL/snO0DL2f4c+4i2IHiQGxPnkbkFuoMaKbBdsr0p5LO916SJn6/zezjZnvF2FEo/uE8RVr+p18mdqa+sCVqLecTOJ2Zy4fIX4xbfBc2ksz1rjed10twbzCz3leOjjgNx3/SiSlSf/d7tMdXdjvk4kINrrxUd4i3ZGeINO4VJ0ARNJtdTCZGQ==;31:Z1fNCsXXdn4mvsQXMcd128b3dzUhOCeWsB/jm57T8nBEiq3eOqeg23x+IKsY9wYis0MSEq0fgL59aCejT6R5B7m+hX/VLLviSUC+r5arqKazRMXJd/L+BGWwup4Yfh9AT18oHWinHUW06ofL43GqiS99oBRQoeBpZWKvr1zYTTPzsWAHSr+yR0gVcPcfGyvcmRe9lGK0CPRXpwlGwBRW9l/cd2b8g1GPVeV++6D/wQs=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:Cegrlmgd95qhr1wOlnXblmJUghFiqz7Wm9/VnDzDrfKUEXQrKpz2n8c4wTBdBsYcBTHeRop5Rx5VzGkZ/03veiGW5BwET58t14XZ4j4Hqt3AbQsGySeHEwY4d92V/r70wvyCWbzjClrRPObEU49PIsdkyz5etLVPk+QaRPRff9ZezkWj8GiTMZ8aD9AreuuHohbyiI+5JRC8cPhAq/djwf8/5RkQmlGrbSvqQ5+zwFLXuF6p4ooKql38Evu/hGe3oX0Ue/kLIPw1Fz0lH2GzAEyna2OVi4ywMD86W/VwX9E8dUoGvb4yiCE90PQAu2MfOFuiA10o0itgZnoacBAuLvGfiCqYDt3Hy6hVFDCSdjz9hbYNIRw2dwbzNE4n/WwPD4sR5EpMd6R9XeWUzUv5PL6CVsAo0pUgBfisdwXQaoXUxyVXXWFn78gT03iJtP1RhpRUcq7jJLgkVSUcxfrBk/cLyvSaMhTEqN5w3BoIGb79GoAOPkaql7DMY7Tym4zU;4:xDaqctBwXdBgpWKMD9AHmhJgi6TQOUXk82wk0rgGLYz6gVHGEbqwgR6esR+eN0kPI+te8k+BUAKp6ZT+DSZgCIS5OXOrQM6mpDZjkDvaia1zjAesv6e4SH2GrZ/dpIfQ6E0WV8mll9Wo5TAAPa/6u8v2/upwq1VC3pS8m4dTTyC93brK19F/C0vcc4QuOdo9T4aOCxI3gIKm4D4g/jTyehjD21/5At+DqNo15v2px7k9Ysm74tYbDxQdFN3hTAl3i58xeVaQiXP1zgTHRqzYoctteq6hYMEk7UJHd5NIhwAh6o3IgpWekXQCJK6BFNR9sa41BKmPncV0lu9OMD1g9nna7aeG0tcT6QPObWPVsfE=
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167446EA48E1FA5C931D780BE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(76176011)(6512007)(6486002)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(446003)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(69596002)(14444005)(106356001)(575784001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:JmLejexpLl0aw4jZXQjOFGaI9uvDjb1UMPVebM+cS?=
 =?us-ascii?Q?T0Ju4CDrKboR05tua4BEC2LE68DXf8pUTzJgjmx4n8M2yWXdCdMCMZ3giobB?=
 =?us-ascii?Q?g2PiriO4jM+kraTCbxxg75k+ACAG96R0lKsKcmwwPI8wuK2jkgRyrzpkmMWa?=
 =?us-ascii?Q?5veSbgaTZEHjsdxylSZgctx8jJCEYZI99rUBK15uJi3WH6UHxBBddDi/ePki?=
 =?us-ascii?Q?PgF1ZJTpHk/eBtl76ABiLKmEx7EE0n8jfNDCIlOz6wzYXC8d0I4IV/hVm/q9?=
 =?us-ascii?Q?O/Ahr6Q7irNF5y1OfTIWxO3k37Vy2RHPPQKz9x2WJ7nM2uwezjI5pTbVNEbF?=
 =?us-ascii?Q?VM0ZvoqZlXsbIi7Jv1HkvyvL0vgcdUQkeZtUn3BC0DCNP/3tOq1eSdOuYs+v?=
 =?us-ascii?Q?yCYm9gVFv5cIr1mK4yEdugXHNOzHvLn15HH0kTfV3NIhPeqFxVW/DpsUR4up?=
 =?us-ascii?Q?Rl6TIRoYML6jv/3AYoO5GI7Ecuvu+4sRyvVTJyedgF9HTw0VsFUFB3t8snEq?=
 =?us-ascii?Q?3uziuKQK39AW6+Dam9cV/dVsWQ5BbSykGQYPuqTGJ6pk3l/M2q16/Wb0VVDs?=
 =?us-ascii?Q?477fvYDCjuM3G55f7pg31bJ8wA8A/h26IBKa2k6TldiXMcAyTXXhAZCvEEZ1?=
 =?us-ascii?Q?2lDwV7GATj/gUKbMj3gASVcSC6iy6Jm8f51sfLMDq8s4exRb65lck2pKVGfN?=
 =?us-ascii?Q?2dlFmjjFU++ZJQ1jj0CvrOZtmQblq/pR7xO8axY3phK4RUhWQKpXfiR9uEpu?=
 =?us-ascii?Q?QxaG3S7d1WyDmVNiDIGTvvYZWRYlTOLphLhjdPQ4OmUI4UZVh8W8q8mz6QDK?=
 =?us-ascii?Q?ZwLfisXeAtGKTdasBfYB4VeHsblh3/C0m4MqhaENOd/VC+ssc2C/lQ8D4up6?=
 =?us-ascii?Q?AFJls4ltb4wcCQypGHmhhyV4uoFXMos133CbcE3UEzH1Jk2hst+SZxaAsuxY?=
 =?us-ascii?Q?L/0z+ZEkR6rM8y8sXmdoZt0X7GH6vkJuj56fkeoBTLCA0JIH3wwvr13D044r?=
 =?us-ascii?Q?a3ygG2Twj1luP43w22uYEt3MZ6E/nPuACngajK3Kv9dP43AaO2sq57vmRfnH?=
 =?us-ascii?Q?4Flb5Q0rb8SFYt1ufi+cvhdHbLclo9IFUQcN+SEdOBVrRayJ4mxzGfqW+Tu3?=
 =?us-ascii?Q?nlk3hvSUyw5OPIn738IlQwJOMOuDuH+Eo4Yv97ezjuAwsxV9FMXlmz+ycOQJ?=
 =?us-ascii?Q?9ZMCfyebSY3aUEr2EQLYuVpUshK6DafSIR4obU9o3IzKDFgwOr0v08Zf7fPk?=
 =?us-ascii?Q?xAxewDkR+VGumpN594F+IXEouHbSHtQNsw8G9dfGVKQq5XAWl3vsj39gkfF6?=
 =?us-ascii?Q?qtj9BB6QjSvJW5aZ4Fzd8Q=3D?=
X-Microsoft-Antispam-Message-Info: ZDMVIKGtaFgR6PgrgfHxFSqSzW6BcGy12GEj0RL32iUwT1pHnhSq+2wvmc3qxAtRZdvzMVHHdwHBCKtMAzXtxT2RhXMP/vQJqJouGj2kd3jR9yHYr5aT/XWN+RSd+RF5DasdNz8Msv0gavmkywcRdGWq7XPWOhXPF8oiXJqQ1iXfMJYR1IOrDIPbv02478/ozNBlsWzMi3yRJkkE8OYdPtx+9I+ftWZ7xrwg7bBWIiRVSbK9CyYgA2bi0csZXjWbRLNNRwRka2I5NPWFcgeblDywhhV5nzkvjmjg7bIB+FjP8Lqf/wH1HCua7JQnP3juH17SfuiaIdpDCoAT0oFfPi9m37srbumU0x9WNYasAxo=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:xOQzTnU8KrGutybR7LZnZOwzABESEt2O07Af0iPR8+VuJzXMpAJVBTXLo/JgJxm1sdMCbo9TthnB7f1Sk7TA43eOMneWWoYCwxf3rrQO+BXE6r49qE0Rq+92im3JFYbt9cmg+va9A415CeSZ2DI4UcjqN1pdvIhF/l8fAhx2IC1LzQHsPirHEC95zxaal7df1Ri4/JoU2S88V2jRjNOg19fXSDig3+1hJd7WPo8jiwnFbsLD0Vuq4zgdO9rxqe9TDB3CUXdafpqniJHMFDpIYFeUVNz4246uLg9d9OFtu3NMsUwEI1obBsj6sJ6bTRlR+dInjNn14lSlxXeHMPrR6VJ5ZnG3QwO1dXFBCa4csMSDwtheT/a87PnTT0cr4iKPWjwz3XqS9kJ4seIYhUKKZcqbFuqT0bsAy6M6N5rue0RXTZcZEvW9sYRZLPXhxOKz1TfkYhF/NuIpYGZmNn9SiQ==;5:mTWn+FNJpb+IUnoNHkJHqUxgJKGhJxGorAQH6SMGkqnF1OtZsxL30/MYLJvEhQd0EYLY4NswqokD9GABwHDcRSb2rz6uKH84sQyB2C6l//d9Gu20XjjVVqNDge2u5efuBgbUGxmqQmCVa98v+dKl6U5waaunXYKT96Rf87ehBX0=;7:XHtGQx7IiPB/J6pl4gqays5JhCkIvfXQIvqpXR+ozgCBqO9AUpMTlfuubLjiPAudG2AtcGqdlGVRocoG+19EM1nzNGXf9IXrJufU/N5mFfu+THxcR6YzdkfH4GkWAfIBeuoVVy4c7EIWZxqb4xktF+WjOAJOOyYh5pSV08B6c2c3Mdybruq3eHUuBQySNaSb/R3u0ZpFab9Vf/qQ9nz31Xe84goSTPJmg8rHt2JH2owour8poLiSUcGuQuNBjtdZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:ysI2FfbYQUV0debBBAE3ySEgCtGVpP3fqJlViOEeYpzFQ7Dz/Hz8rmm2Xei6QZJz9D+E6JVFJHwGp6Uw++KlYj67jQBBB17KhCWQ37jAYb59Q5ETJqOydPOJenHOnh1vxRdEFSa5vsgG4Q4dAE0FHkOK2kxfHVEKoZx68sSc31E=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:11.0785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2edd5a-e15d-491e-48ed-08d5f7f6f0d0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits extends existing bpf maps memory charging API
to support dynamic charging/uncharging.

This is required to account memory used by maps,
if all entries are created dynamically after
the map initialization.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h  |  2 ++
 kernel/bpf/syscall.c | 58 ++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b5ad95cf339..5a4a256473c3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -435,6 +435,8 @@ struct bpf_map * __must_check bpf_map_inc(struct bpf_map *map, bool uref);
 void bpf_map_put_with_uref(struct bpf_map *map);
 void bpf_map_put(struct bpf_map *map);
 int bpf_map_precharge_memlock(u32 pages);
+int bpf_map_charge_memlock(struct bpf_map *map, u32 pages);
+void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages);
 void *bpf_map_area_alloc(size_t size, int numa_node);
 void bpf_map_area_free(void *base);
 void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a31a1ba0f8ea..7958252a4d29 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -181,32 +181,60 @@ int bpf_map_precharge_memlock(u32 pages)
 	return 0;
 }
 
-static int bpf_map_charge_memlock(struct bpf_map *map)
+static int bpf_charge_memlock(struct user_struct *user, u32 pages)
 {
-	struct user_struct *user = get_current_user();
-	unsigned long memlock_limit;
+	unsigned long memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-	memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	if (atomic_long_add_return(pages, &user->locked_vm) > memlock_limit) {
+		atomic_long_sub(pages, &user->locked_vm);
+		return -EPERM;
+	}
+	return 0;
+}
 
-	atomic_long_add(map->pages, &user->locked_vm);
+static void bpf_uncharge_memlock(struct user_struct *user, u32 pages)
+{
+	atomic_long_sub(pages, &user->locked_vm);
+}
+
+static int bpf_map_init_memlock(struct bpf_map *map)
+{
+	struct user_struct *user = get_current_user();
+	int ret;
 
-	if (atomic_long_read(&user->locked_vm) > memlock_limit) {
-		atomic_long_sub(map->pages, &user->locked_vm);
+	ret = bpf_charge_memlock(user, map->pages);
+	if (ret) {
 		free_uid(user);
-		return -EPERM;
+		return ret;
 	}
 	map->user = user;
-	return 0;
+	return ret;
 }
 
-static void bpf_map_uncharge_memlock(struct bpf_map *map)
+static void bpf_map_release_memlock(struct bpf_map *map)
 {
 	struct user_struct *user = map->user;
-
-	atomic_long_sub(map->pages, &user->locked_vm);
+	bpf_uncharge_memlock(user, map->pages);
 	free_uid(user);
 }
 
+int bpf_map_charge_memlock(struct bpf_map *map, u32 pages)
+{
+	int ret;
+
+	ret = bpf_charge_memlock(map->user, pages);
+	if (ret)
+		return ret;
+	map->pages += pages;
+	return ret;
+}
+
+void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages)
+{
+	bpf_uncharge_memlock(map->user, pages);
+	map->pages -= pages;
+}
+
 static int bpf_map_alloc_id(struct bpf_map *map)
 {
 	int id;
@@ -256,7 +284,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 
-	bpf_map_uncharge_memlock(map);
+	bpf_map_release_memlock(map);
 	security_bpf_map_free(map);
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
@@ -492,7 +520,7 @@ static int map_create(union bpf_attr *attr)
 	if (err)
 		goto free_map_nouncharge;
 
-	err = bpf_map_charge_memlock(map);
+	err = bpf_map_init_memlock(map);
 	if (err)
 		goto free_map_sec;
 
@@ -515,7 +543,7 @@ static int map_create(union bpf_attr *attr)
 	return err;
 
 free_map:
-	bpf_map_uncharge_memlock(map);
+	bpf_map_release_memlock(map);
 free_map_sec:
 	security_bpf_map_free(map);
 free_map_nouncharge:
-- 
2.14.4

