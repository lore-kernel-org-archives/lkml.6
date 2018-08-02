Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59644C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCC121581
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Z5xSYtV6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cIINB7hO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCC121581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbeHBXWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:22:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49824 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732253AbeHBXWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:22:54 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LSxYf015349;
        Thu, 2 Aug 2018 14:29:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=R6SL8MWP0Mf6kG/U0G20BLxim8z8t80VeHH9u/nOJrs=;
 b=Z5xSYtV6lZefyKFWNTpG7sj5iRkHTH2hLeagUGWOvCYXpNn+sGeWwqws6EIzprn6pKGB
 Xp0mM66ig167wNx/L9vvBT6RYZu1QzZGwb8q66ID/mRbGRJ86bO9+WjxoLOUx4c9U7zk
 6gwzu/zODsujp6JxnviGR0gBdgCICGHOpck= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2km91w0510-8
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:29:35 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB15.TheFacebook.com (2620:10d:c081:35::27) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 2 Aug 2018 14:29:30 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6SL8MWP0Mf6kG/U0G20BLxim8z8t80VeHH9u/nOJrs=;
 b=cIINB7hOqMQGUOIiOhKLWgD8mhNy9CD3GOW7aeYt26Adh5ziS3rM9BAR3K7z6pvenzcCns0bDXEiILtzHr9cDhbu2/Jmgv1BN/1qeFUTTrZGgmfE8mY54c9j/ydNde/rj7iweOTxkimPa6NvhD6WjKvOf8p8H++lwo7fsZ7DyW0=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:28:04 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 10/14] bpftool: add support for CGROUP_STORAGE maps
Date:   Thu, 2 Aug 2018 14:27:26 -0700
Message-ID: <20180802212730.18579-11-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180802212730.18579-1-guro@fb.com>
References: <20180802212730.18579-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:6653]
X-ClientProxiedBy: MWHPR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:300:94::20) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2151fd71-a430-4cda-d406-08d5f8bed5a1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:kTwK87Cb8qV/6Dolmg409row4+HmOSX4jzbvJe8Er+t4RlM1uzvm4I+7DbPjonIalWjYkI3P/cTgVEabhpkBvL0F9unznAzqrBUsjttAs20YONpHUkIuvW+kjDCib7D9AvDFLYsHNwhd1wo1+kfYef0ISWZJrb10lpOVbDQcJC+45wXsVIIu5e9MFVU/Jc0+v1J3Wj9mgUgnqzxEL3Hbi8JCSjvxEfybd0L4RORAyTDmGymwaA0WBzrqp0905NPu;25:+Rfb5dIlcJ6G3QLMkAjovUU8qdCBszMXMkGxXJFX/u4BLJBTq7GSOm5oEVBSNMw7fzytyBwinhtebbyYt3fPCoiwGIQ8RvTDQbmHvSEKevk9yW+fJ3nuXo84LuDu9NoZheTk5YjaH7IMkkOiQV+sekyopJUX43fCuszZyzb/0oNF9wJqKJ3F70c1RrOndiLrhyxq9rAPHd96Da0ZEOV9MGyCEQ9gB3sFyX3/QXv65RIaoDLSuNUJWtsiI5hCvFYYvwlQne531/adyqWRlg6HxGhBVaqcm2AnkUPK1o7DDsnC3iT1LNIO+eLp5+7aPjV/iy0auVCmm/nyHSJMJDQPvQ==;31:wxxzm8+wEJ4jPLIW7OFJMic+wp0XLbBWZhWom9M2OJVG/SOQ6+Huc52FtblEac3lAYg1RT0Ahn07iriN94D9vuslbiFVFA1Zl2L1mfRHEukXG6NeHZJowloEcNmPinLMt4/fuYuI+Vjb8UtqOdFkgYN/G4IoUYWyyb6MzxH5+0IV6XWYYRH/Ke7lca5efU7zzZSUdsXfs3adCZQCAm73TVAWmjHWCYc+nGS2TH2sxcQ=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:JxPAvu6YutjZswuegrixf2ueIvoP60uuqj2nyOpQ1rLfT2c/0s6Sn+oP41IamtJ/qqFpnt/4uZ/O3ZfgF9SxBR8MsdY9YuU49QRXL0rID+Lb/tW3W4mTA41RXKcuvWWepVBqNo5jeHvrACfbOYmi4t01dRAEFIcs2Pp8N8IQjGb3l9N2wlhH1HrzY4D97kZOZRmQspyL0bFwMktyL2+LbG2h8P7yMgbFMV6SR6RVJLHNdXxUyEbQ8eh34pa5EBloHZ02GV1smlNGxeFa7BaNsMEezuxJySV3TNxiGJ3eT5yrfuW+Y93Idy7iiA/cdMWg3w/6ALlTsE2Z8g0x9lqQn3KOAeRQo+6lSMdAA/HH9MqAqVYPYVgk412KmtIfbHHkrOwy/zFTlx/cxZ+HY8OXYyerJEsDyDTzX6uYF+OTkqkqEumRrHflKN8EiIh6w9wSpOPhQZr/kCCjecZugFcXzKKejlJR6z39qYQ2m80Sqv7kR73kwXrSpwuem2ci3Kj1;4:pjz43BLZgwn88co5C2Uhy8x+fNSHRdVRmsjIfqlv52H/rog1KqYHnPD3enfQNXwyy60+E06h4SYQBUaq9bXj9xyYL9wmgO3a9IEcXqlPNE72cwQPpdLUyvli06dXrTLCVf1G725Ehe1b3I1fWHxKjpQfV3xqx86l1NXxCb4WYoATDRPXS2hgTtNkb74vydB4M8Ha/43f5jSSVQ0mwpsl6FcXR2Xu5y5qMZdA9OIse6eMWR+dN43qIfmP2ZA9clEkwKZT1WieYZ7bDSUi2wm5vGhEZ9TMXklDKqrR8qV3I1b9e4WmmtLVhU4PS2hDQraE
X-Microsoft-Antispam-PRVS: <BY2PR15MB01675378B765AE4D92166503BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:IdKGnQEcAIaO3Spa0F/7PvPi0hOrf/hSA5It9zlbC?=
 =?us-ascii?Q?hCXFMWhp0QprEZw3xZ83vMb5mBj5ucMqwzW5mbKz5RssmLxEgdQCXDwqc0kP?=
 =?us-ascii?Q?VZpXNfvxjESZoFZeReCcCm1TLIPCLJUWkOXIL9eZ25YD6meiae0T5g/AHyRl?=
 =?us-ascii?Q?t27Lc1QKlqsLiy7CJJCzu2P5UISB3qCvjloIWjWBWGKbpNZ95NG8raJ8PLjz?=
 =?us-ascii?Q?LqWevZttoSP2FgN5DkZfqQNH7guUTRJ969lFZ4PIy2qOpwjq42h2VYujFtU3?=
 =?us-ascii?Q?KWK1qPJI/Lp4MWDAnx0/9N2nbpcGq3ze2qpvCzF+0KLq8aZ99BS3WJ3GoLRZ?=
 =?us-ascii?Q?MMIKQmYXVVkIADL7NdekHWIwJ03RL0Eu9doIQAImcuQyvYV3+Swjll26q91U?=
 =?us-ascii?Q?fhNSnoISno4Jr1eLHr9sNPWJJ/+gitgHqwzC2eSJ/wYmvU8MZOpwDZ2eLkrV?=
 =?us-ascii?Q?BNLF3t/xSwdnyw+e+Gn6C0r11sN5pmzstupce6++Bwbam2C7QFUc70NOBVZD?=
 =?us-ascii?Q?eu/IuDo/SXinCman/SdZuuUWQCLO+CfREILH5fnZnZKnEIcmktKcXvNGNvxM?=
 =?us-ascii?Q?aM4EclVMyo14GqU9NEErURe0nmhi6Bx9K/LugsRk2UGF4Lxkhgz995aQWSF0?=
 =?us-ascii?Q?LD8REDHyriN89/XlDxYZSBFdQru+DgFzY62saKwXG97kpXdeiYTnyOjzyiF3?=
 =?us-ascii?Q?+4+lxEwNHhfz6F4U+G0eAFSVDW00rpp0oUKv8tUramlFVI5+l8rz4aFwAIk0?=
 =?us-ascii?Q?W19lnzLriNR96exq9sP/rwK7DLNz8et7Q1TKBAX/CZ1K4hL04pyu2RO/IgT5?=
 =?us-ascii?Q?h9Q/9F6xG8OOWqztVX7sFh6Dsyuj2rOrZagCg95rJJV+ArSP/szM8ZhAnqaO?=
 =?us-ascii?Q?50kfOw6edkpROJxp11DNSo39afffyc0TPQVL8xJeJLgCT4p2IB6kBMcGckjE?=
 =?us-ascii?Q?Chdaqo+ePgtf0R4yT71r++4yJdm8RUsN8MI2/uTFo6dqLPwXpawuF1w/d6iL?=
 =?us-ascii?Q?EO4ADMkvS2dcVV2BIbgLSDWQ/4daxcwgTWVywGxZMVdqUr6JeaUF1IvuRUBS?=
 =?us-ascii?Q?A53LbDjLWiJwhACQbC5Vl7qfTV/TnHPumsF9BNITBtr8YHhLv5tSkcw/tNjz?=
 =?us-ascii?Q?1Y+Gv5FUIsz0382FYPyDAkLR2AyoRrHEUpORmNcqO55+C6layau9KbzKkZ97?=
 =?us-ascii?Q?t3lTUJPfAH8zsgUo6XWYVWMXStikP4wRIQIq1G21KE8tbzxEyUY1K2BMHqIU?=
 =?us-ascii?Q?+Atz+Pr7yIeFNtEDCrPutevacNWX3irQc1lhdUPqNfV3zoVkwLlAFSEoJEXh?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: +Y7hYCX53c5XW3rO5n1/pfnndZ2rQAKIB90su2SySCcltAa1DWIGzACj1mgWsOoFSxdUpUW41goJ18w5wLOoYgthdZ0yMPPT+qzRR6DBwfe/CzKcTvT34Zl4RyA7PXDBzUH6H8Aiksx7QLdctjxPl2ov7+0RLCznt9voCkJrWcz1TJwgEx+ANRa+mEP2UA6YxmLLXtsaFF2KHp1FsyVbbTValgEwuKElMUzMA4PmkCIjByiO2oME57AwCprX3zx6koHCmxpo6V4NGjgBSimwTU3I8KQVLVujHG12UqfbZxq+ZVlLk+157CiLFj1WNcBI+yunfUiJ+hFHXAJ147fsdrUb+yv/mX+P92C4xIh8AUE=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:CG1nuCU1sA7FppKjcl+ywXgPLJT142hfTNhoTCeGFrWptDEMsiJqj3M7vcQJbJkDtDCTIpTHRUDZSTa/Yth8dPIoffPsMLKWM/UBg/p/PGjYuLU3EmBltQSLoYd6fG+FPcl1DzNKychX/li+t3Ik4KZ4Sibll0wUdTvkya8l3N/xWp+Du6uqW3ieEen5wJSXI62ZE7gYdf4kPrMn1fU2e4WW1AksaV3zR+G3HqLbCax6bZyfGgAi+fUnDTWIBT3AIr2+Oxk6RYq4tAYflz3dbvtgPccDAYWSOhkonSil61UF+dzHXxgU1jtKCYDb0WcdjMNVtiiJj+H5GVB1zuaXXpI/zQrvr2Pu2mAfZlq55Np8Wron1n8mrsccIIEto8lfS/bApPh6S42bQJIbO/Io8kUqhgi2JVKT3oukSlEgFgrilA69bLEt8FF4rRHnpf3D8uUgmlPlNrilTec0G05i1Q==;5:s3AC4Fa0AMIksyO9XR0762oleIeaccJ/5LC6AoklvxI6s6gGaJvjh+Pog2s8baq4ZLwVSXGraHJLGFnpPn518N+NVLRnOFJh8fpNc3Xo/VI8Zw6JE5pzAXW9WEM350AEaFlY0iqTIq7mqtasU3Hz89l6mpQQlcZuy4Gqz3HCcGQ=;7:cOtJVSh4sIwcZ/cawnJYu+8xjVtLcfLrzbTS6QBTVBtsBQglBocaldLxHkgnz55HJiHvndEMvGmfak4ZXNs3G4FboSMCU7UzTkcfzeS7Rsiyo2uSnrTsDAHpSkb/fdvbDazwcQDRUhkP866MAidGYxfxliqZ6Bmr+V2HHOZ5mTs2csHHB+Yy70Yy8WjoDWUFVwcZOEIcExGfWuhfAnL9/h3IqcwBqBE1Myal7rRUhQqn8y4kw9r/7hd6UynH3z52
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:q70M4RITfzAQ/KebbmI8lyqGXPnH1c9e2ohfQilnC/YktHUMoB7FGSbZi3uE5+ULVz2ef24O+2tkEmNP3IXAuCnkV9nvaKDigTsIRZdXydhDrrypsQghhnsbanuVQKitDtEFVagKYqsPpKmtU3SOKD3PXOTc7yt0MxxcQqt/y+A=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:28:04.3160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2151fd71-a430-4cda-d406-08d5f8bed5a1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_05:,,
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
index 0ee3ba479d87..2dd1f8d9cc2d 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -68,6 +68,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_SOCKMAP]		= "sockmap",
 	[BPF_MAP_TYPE_CPUMAP]		= "cpumap",
 	[BPF_MAP_TYPE_SOCKHASH]		= "sockhash",
+	[BPF_MAP_TYPE_CGROUP_STORAGE]	= "cgroup_storage",
 };
 
 static bool map_is_per_cpu(__u32 type)
-- 
2.14.4

