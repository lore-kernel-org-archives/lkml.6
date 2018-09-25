Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B3FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DADC20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Xotq4/Bx";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NtYTnfmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DADC20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeIYVaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:30:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35898 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729626AbeIYVaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:30:02 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PFJr18031887;
        Tue, 25 Sep 2018 08:21:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=hV84EyB0b7HqsXGAmADc+Bzu4NVLroWRqLE/qTLewEI=;
 b=Xotq4/BxiX6CgaHUj0njeohUENTQS0eEFpSH3tc/3vIFZQN43ebV+XOd6sJWUs8pYE3H
 W/hxdg+G7woOW7JA7Jgdi1GBv5+V7pbLNYtq/pm5qSSlmMgtGiRKa+1FofP3mke+oFG9
 9d+PWwZ8VD6RFdtgRzib9Qp6wVfLk0DV+lo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mqpp2079y-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 08:21:41 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 11:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV84EyB0b7HqsXGAmADc+Bzu4NVLroWRqLE/qTLewEI=;
 b=NtYTnfmzwVvsK06aJ3y9l1F0xrvbc7IkmfqrRvvLH63hczn098YHQbz6Khqdbz+KeQqxvrSNVEvsQxOyQUbLoMa8nxzNDqFQeXiW1rY2+AvbL5zetio/jdQ2PC952iFAIxHOn1d6dWM/oLtjbQayZVAjMiz/P2iEAEN31GUKcFI=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:f4c5) by
 BLUPR15MB0163.namprd15.prod.outlook.com (2a01:111:e400:5249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 15:21:36 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next 02/10] bpf: rework cgroup storage pointer passing
Date:   Tue, 25 Sep 2018 16:21:06 +0100
Message-ID: <20180925152114.13537-3-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925152114.13537-1-guro@fb.com>
References: <20180925152114.13537-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:f4c5]
X-ClientProxiedBy: AM6PR06CA0025.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::38) To BLUPR15MB0163.namprd15.prod.outlook.com
 (2a01:111:e400:5249::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aa403ec-4742-48ec-bef1-08d622fa95ba
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;3:cANY7qvFc9n9E6FOYPpRW/9A3xjf30tkEOB0y/DslLwj/303euQ8Qyec3gyc+4s5bTys1plxRB5j0jnZGHEBVMnwhFWbFYwawCpdDfuAstBUmUPldjbJH8GXxHb22OG5R5dLaTwQ+dW+o7aZVMPtcPlJ3rC1n6xZk52v7II3V4QKFWz0v9WZxaxw4rrJXD+Ap/OCrwJ45ZCKoafaO0406jV8Kr2tUkzocnXoe4dkg9kHBZJkapEUVUVJ7IgJOAJm;25:l8Q1WTGfEujannbbPOxG4deI5nRULqzHTGqjeaDJsVs5lKQ56izPhKQC83coLD/okQResnjT1E1Qw75MzY8icwQast4lhptWwxfNth0qeskLUI3OTpQDPYtGw/V40xNbNNohTD6osSeCNapgbHHHlcx3kY4C6bGKGWv4mpzz/densZlLFg29kiqdBSgv0ZEBVszCI1ugnE9RrT1ApblwZKWhb4UIbMXHD7h0cyEGSekBpA3a65axew/OfWw2wFFSN8Chra7vXG1OZewa/976DfbCuck7osmSJC1tJK6M45bXjExOM5yBYtTWxDub/4SriqEJYhf+i/gmBNH9ce14Gg==;31:M3EBJlAmSn8VJ1qQ//lGQUCHsHE4Dl4kmxqmvtIOnhAvReZn5bV+rjQ30EvcLSxuwoGQcoI+KGW0LsrrHuhbJC2ngcvLePtAj2jxVqaTfkas0TsC121gPLv8RkBrPXSof7v4wUhPyDW8fCQ3IxOqDoq923bqkYhNH3KTo8FiFnYSJZUA3UV1sKI6I9ysoPAWvbHtdiO7VfsJEdsIH/9Ya7wFjTnPSslXacBUmbRFBPk=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:uH+LkKqilAKVRquo8As13EnVhM2yaFLKxs/l4dYh08eV5v3DxLjMcy5Fscz6R3krsdAoGjGi5maHNz9//aCCVpm1MLdgld+AvK5B8TRLPHbUhuiX89cs2vZkjy+aJWQAOEoR6vpQqxAKqvug4ynBwdkCIjgPwSEOlYLpHhI5YU3WmJrEUO10SdEgsz+Umf2NMdPzd2xu60lCdFdgpVYZH6YlNfF/MoMl+g5AAtDvG0Tv6LswM8a89ewI9oTlSqDxRgBOLnOMe2eZIf/3n1Sr/72/7a3X0ItWWg+ASkcRb1zZDKI1XZ1CF5nlh0nJSrVi24fMkLXmGGvILNjfZbMlCLaqFaDIsb7aqMfpDLb3EdFO0RiQmKa8k0a0FWcHw1SVzXpA0dzL3B0fZmlbDSQMs6Lg0mQc12qrgw+cuTlfuRw2vmldma5Gx/MTwbwZv5/7A4+CQNtI3I6HXM1+DZ9vZYYjCSJcOllwLmoXVt/SU35gGl/uAuBLTKJABX7vO+do;4:EvSU2NEa9ZPVpNY9baeqCOupBoB/io+weINyHUU7uCg84HFy89pyHoaD1me7HaQ5pvdpZ/nRZOBUW+LqFkWP9AJvQn2idmDyhND6UJfp+a4tsGUdAwk20mwGkKyt1fVCHfBfCckaY6vNXsVRI/KkFy2TRQGk3KIpAhghMp0gWUXEmoPb7kEYvqqv1pt3vybZnS1qDfVef7Lsaq2gIrLjsG4RkxrwzyUHI/m8Q76kvOtTG6EScE4p2FZ/TiD4aUC9pmSaUeZ/lSqOPl3sphUwz10Zgiaylpr4y61tz66DsGenm5dMcdlkl3QpVu7qY5M2
X-Microsoft-Antispam-PRVS: <BLUPR15MB0163A86EA4E65FC85E7AB429BE160@BLUPR15MB0163.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR15MB0163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0163;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(106356001)(105586002)(16586007)(2351001)(36756003)(6116002)(53416004)(7736002)(1076002)(305945005)(2906002)(4326008)(6666003)(186003)(16526019)(54906003)(47776003)(6916009)(50466002)(53936002)(48376002)(6512007)(316002)(5660300001)(51416003)(52396003)(486006)(446003)(52116002)(476003)(2616005)(76176011)(2361001)(6506007)(46003)(386003)(68736007)(11346002)(97736004)(25786009)(6486002)(8676002)(81156014)(575784001)(86362001)(478600001)(50226002)(81166006)(69596002)(14444005)(8936002)(34290500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0163;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0163;23:O5M6uThE9R/p8NoLpHFoquvQhkWDx23TjAB/cWa9/?=
 =?us-ascii?Q?LVEOc1qx6SdsFwlVZ3haD860Fbdb/8ozKtoFIffYIw97YdokwZ2ADuMKk3Rr?=
 =?us-ascii?Q?af5Yx59j4owW5TKsZwpbk9hXHug5jweHGqy65OSI0Yd9MQI1fTrjSW0Po+Dj?=
 =?us-ascii?Q?fFQiXoAWb+ILos9OAPAM4+VLZBPIVgEaBuZFyf/zRwRIpiNQCtt48wH/LqIi?=
 =?us-ascii?Q?AJUWeQ2Xa+GB8xr+JTxrnnItQiJh0ac/ZfPIFhyjJ9n6SuZaBWTap4FnIGva?=
 =?us-ascii?Q?LPFxVO1PDQUMhk+Jr1SMbrYOOoXAzatJ/lPj/jSm/zl8SNIl/AEV8Cj9gQpR?=
 =?us-ascii?Q?2d2mYoOlXnaDaFN5mZpE0RFX58IM8yILHySqlVBasfH4sL1ymEjz4CLVvvkG?=
 =?us-ascii?Q?R6CApY+0XvmCAJgRsbeURk9Dw3ySpI/duon4XFoPTczeNVyFR/1ObGODi3cy?=
 =?us-ascii?Q?TYvYNsQj3Qw+8wEgN1N+DT9T3Ljhdu7MV5l0SBMzxqSXNN1ybye6yQGfwYDm?=
 =?us-ascii?Q?ckP6hjCDbWOP7VlkDED+v+GV6GoCYvKVugQ464iOCo6W4vvmdJga/C3pvglN?=
 =?us-ascii?Q?aZjz27wkcSSSk7I0ZulUtH9d0Ug5B/LhbxlcdeOwAg9N5DWAIPnYaL3cyTAZ?=
 =?us-ascii?Q?+2smFnP2RRe32ctkr3sm8jMq/jEfWaw2V6aRbcpDq2haTCmosM/RLTD6JQdl?=
 =?us-ascii?Q?oxSeiR2zzm+WHDlmsDY98ZwBpjLc6OnRlGp9+OD3NqEVoGEavPkO6+F4o7i9?=
 =?us-ascii?Q?GRJS5zLgo/xuqHwnIATaIlTdxflhAjE/ep9+kz5MH0o5cVYTJ8hMfkgXif0K?=
 =?us-ascii?Q?Cbl7i6bHv6ARKnhU4c/UHmUyApO+LaltMyAk7Sl4nehmJ7akBaY2Ev15lP37?=
 =?us-ascii?Q?GY8EzlwJ/NmfV1ou1m3PAsbXStSyc7piVj7K2fxKDw68ay502i4hogVND7hn?=
 =?us-ascii?Q?96+CeM9CcAVZMWWds/CULxns0oheUGFrA+44zvuOOm88Soq5BKPCI5DGLPf3?=
 =?us-ascii?Q?Nts+R7zY5IbXEFRu3uOGSDJRaWSWlIO8QnEXf6mwaVMQMx0td2C5Qo8rt0RX?=
 =?us-ascii?Q?wOmO3OvRepNsiN4+vi2vX/N3ItdW283NQrcllcM/Pu/QYfiEbbdRb+rVOsiR?=
 =?us-ascii?Q?w6eKESxwD/dK4JSUWBo8j6bbPevzvHsQzQoAhiJajKZfFB7p6N/vAcptHG8i?=
 =?us-ascii?Q?lbQiiBZd2+p5hj8KOSH1AJUryuN+qnXVXI1nICyWYOfzs4q7OrYqE5g6lZw3?=
 =?us-ascii?Q?H5fe0TRys6rut3JKuiPZAjlF5n9w6jgLJmaHJwriDo7SMNlAXqO8dT08SYAQ?=
 =?us-ascii?Q?7E1VXsKzErr7T8Tkw5WGxrJCwRbxogflrxNllwsDNgv?=
X-Microsoft-Antispam-Message-Info: GsumcrfRqL+1Taqmv0UPLcAAlwUeOc8e1zf6JtSLSvqrX+Rrpq3Bs+ly5xdxJhDvI0CcTzk7NZA1TfaULF/hbmylhSW7bIz8fbKi2Kd9uJOpa1RDw8UH9N2Iwfqj8TJuHiOyQHpNZszlgGg1NCJEYbrT02O3hX6RogWYipctxsExZRX/b1pfU9Zoxen21+uzM0k6tScRWOToOTa/KbulYjzyH4AGXxMGXO2yUTBrgVOmK/rBqqvMAbf3nb25r9sH8T1137fAG7JnrkyMZk/ru+H+kDXz3RTTbOrNIaOfoTRWuPdxRonVEd5pi9CND1jrphpJSAcD0yYCwesgOhTLBeFgbkWoSP+M0Ora0z8C/6U=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;6:TLmVWhTBSfDWe/D+Gzb3Mqip+hYPB51z0cGrGm3El4PgLjrR4Mm5rgXz31zZ6yp/WW9r5IvMiAJqE3Xb/AN6pdY2olaoknKjjff7TIid/ZnMSz3VSvCU1qFeXacHBqPlB81s/pdCyppHICVXOgQCutvzh5oblC0g3mEpZnran+vS9oowHvhcrf1O+4QJgMd1RulbrW6J4n7Yd8WI9kizyLMVO0HcGthwWTIzDOGnYG5/eAVTp4ZoJejp6HibvGL2GVvNyIVPLhx6BJQPkk2Ua4h+jQUA//TT6SoPANLpcTk0hreo9uex397FZHD1a0j1/W/Gvr7gnDvL3og6dUjnJW7iDoLyuOVSzhSUJTCDpeWtbbjSXIVSS14K19VCTcj9umbz1UiWa96/dfzb4urdyMjfqyW475DwbahSFz6wqtQsLwQ1igDzoRpgd1LKix6mUYiAw1PQwd1/ydEq7qDRUg==;5:FjgbFcgvhemZ1atv5cfP4YVHy1ACI5+iRLkaS5oE6v5Qt8e3ZNUhbzhosGzN9upMTTqX/W33ar5Kdafw77dEi+jTMHwJQfulXJugbaacU7SZZ13rbXYTzQV5L/n0dNHwqi95/d2j1Ug6r9Bbasiz2y7NwIbH+jwr0CQPBCYJey4=;7:CITFpWSEmDUQBUADhN+QCUBOcV9wznxpMFbtb4HYSlyCg04SfumAQTH84qKoa29UO/mU2fPCh7j5F2bOH4yKQoUXhlvHFYzyzIiNAvECsWs9R4CVyZmRVIfDBzUXt25fvHsSo16bqNsT8M4JeCZ/Q5CWbxUkRPcUa1nj8dNQ4g1npUzjlxCg3SQzZkJyKo32ez4mp3Meem7y27ddOKSvBIKf97ZeQaHfsSP0luFgM+VIPWNsyGbXf7ErQuc6fIdW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:ObzEII9niZbiMREx1HlK6sg8IpqKvtzlBKEDTb5uelW7/ojqQy754hRyZeD2iyWFrj5jKYkUIqUWnoPLrxtICke0Ehsdn6EOTJC8pqLKfP2mW1H4oB8VyysfJXBr3IVqumZRJC6tPKUT2QLjPCnWcuVZxh0RaWYwWI8kDGCQBRM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 15:21:36.0057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa403ec-4742-48ec-bef1-08d622fa95ba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0163
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify the following introduction of per-cpu cgroup storage,
let's rework a bit a mechanism of passing a pointer to a cgroup
storage into the bpf_get_local_storage(). Let's save a pointer
to the corresponding bpf_cgroup_storage structure, instead of
a pointer to the actual buffer.

It will help us to handle per-cpu storage later, which has
a different way of accessing to the actual data.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf-cgroup.h | 13 ++++---------
 kernel/bpf/helpers.c       |  8 ++++++--
 kernel/bpf/local_storage.c |  3 ++-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index e9871b012dac..7e0c9a1d48b7 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -23,7 +23,8 @@ struct bpf_cgroup_storage;
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
-DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+DECLARE_PER_CPU(struct bpf_cgroup_storage*,
+		bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
 
 #define for_each_cgroup_storage_type(stype) \
 	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
@@ -115,15 +116,9 @@ static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
 					  *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
 {
 	enum bpf_cgroup_storage_type stype;
-	struct bpf_storage_buffer *buf;
-
-	for_each_cgroup_storage_type(stype) {
-		if (!storage[stype])
-			continue;
 
-		buf = READ_ONCE(storage[stype]->buf);
-		this_cpu_write(bpf_cgroup_storage[stype], &buf->data[0]);
-	}
+	for_each_cgroup_storage_type(stype)
+		this_cpu_write(bpf_cgroup_storage[stype], storage[stype]);
 }
 
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9070b2ace6aa..e42f8789b7ea 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -195,7 +195,8 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
 };
 
 #ifdef CONFIG_CGROUP_BPF
-DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+DECLARE_PER_CPU(struct bpf_cgroup_storage*,
+		bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
 
 BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
 {
@@ -204,8 +205,11 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
 	 * verifier checks that its value is correct.
 	 */
 	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
+	struct bpf_cgroup_storage *storage;
 
-	return (unsigned long) this_cpu_read(bpf_cgroup_storage[stype]);
+	storage = this_cpu_read(bpf_cgroup_storage[stype]);
+
+	return (unsigned long)&READ_ONCE(storage->buf)->data[0];
 }
 
 const struct bpf_func_proto bpf_get_local_storage_proto = {
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 0bd9f19fc557..6742292fb39e 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -7,7 +7,8 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 
-DEFINE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+DEFINE_PER_CPU(struct bpf_cgroup_storage*,
+	       bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
 
 #ifdef CONFIG_CGROUP_BPF
 
-- 
2.17.1

