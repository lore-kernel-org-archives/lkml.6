Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E787BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE2520652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oOomz6Nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE2520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeH2WXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:23:32 -0400
Received: from mail-cys01nam02on0069.outbound.protection.outlook.com ([104.47.37.69]:40616
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727698AbeH2WXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX4LbIK0sGaMzSdq9U2Kk6bncbqQs9X3wYZKgzNPqfI=;
 b=oOomz6NkQgZulIg/I/rJlaKnMDJEZI4Mfli94MWtvFm7HVL7ZydP6m29Pzm/3uRFPefdcLRhXi31w2wmNnyzZri7b++rnhsRyDj+xp5MaQ1kLFiWuMUnRAPiTEnzRfHrPVXDS+vyM3CEHHuufWB15KU6+iLgaAlSd7Gr/tG65OA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2678.namprd12.prod.outlook.com (2603:10b6:a03:69::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Wed, 29 Aug 2018 18:24:13 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v3 1/4] x86/mm: Restructure sme_encrypt_kernel()
Date:   Wed, 29 Aug 2018 13:23:57 -0500
Message-Id: <1535567040-1370-2-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535567040-1370-1-git-send-email-brijesh.singh@amd.com>
References: <1535567040-1370-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR1801CA0020.namprd18.prod.outlook.com
 (2603:10b6:910:74::33) To BYAPR12MB2678.namprd12.prod.outlook.com
 (2603:10b6:a03:69::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee44659f-17a1-4fb3-52d7-08d60ddc9fe8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2678;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;3:f6Jb6iF3rqdye7o7kQ3IsLHMYLcQe08YO10mTKtPYH1mM2Gtd1EdABuDaOJARBdpnpripILmLwttbON/h56x4s2wfZ7GzB3KsR3nPSxS/71JwsZgnfshwbq6sWPvZFzsvqZhJ+ISN/4NRjKrnbROm7GDztjs8xULZrXrLOiAmuKIVThV8mcd+n1yg1kAPNSlmIauYGLzmMv1Ib/XfwuRE+V4fekGrDq6PGuz70PO6z9J7JZEaNg4GHTLImZ+VPJy;25:IXwOYhQAsjbMVNurp034YhVbpN0N/GwfzvfOuavEmJRPKaqb0palPk14wYQwzKr2LwOdffNzY+igDu+QCmMSdNVNlOyAeG5K9C7UHg0XE794Gwj0KmlF9L77k+lRR5bXTbwv4FblJOeo9h+AiNYdjMxntY+WgLrXxHtJAi2CtmNEI66cH7UzsdQIwF3yBH2oh1z6RUb+bl6cdcAp3zTfLwoqJebqVNZK8IIVFaVXeqFEM8SHsRveDiIj3f1GBavjJrnYdd/JrawMlJzpvNvEKZcpQUOs39QfJFZGTdxqgmzVm06utCh1Id9U+1CLy4DA3q9OVexO6iBMlIHKPSIVTQ==;31:gNN7m21JeMtvovkTBWrCiz0XuG/aUP2/lHBI9o+qGkAgHfkzBH9kmxL/Dus765FJA//SCSJOHyypBxrsGJBk9I1+20iwPCPu7DnkGxEs64ekm8Gj5HLvFZqR9OeXJBdAIqpzXuJn9g29iKti79NZwXso4y0aryyj4Q20qL7i8ZJficREIjuUPL5EVhEIQ9oU970T6l76J6n7Yhora7dFiJbaLQ9A+dYsXumcHvHgQFo=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2678:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;20:0Y4sRPNCfielccncY9725fDXxSz/SmT1po5niZCzATt4PrT1bkuqWqvLzt9IRSLwhvssAea6JUc0qEc6UScWsqDGf9anGn5zqzQe9eJ13xiPqe0BjI4UC7fyHwJtjJivlgnGk4skwZqa6dJrkxCveCjoItE1eWfPJX1DVbDN4y5d474z6zVlEg3qc2bJY+yWmRpfVmxaPAn5vfR6x8iPQsrar3gbCLx4ersXPQIAq6HevR+JvmQ9bcLvSuD3cP1xQTWISq0GBXIrmFRkWHwncDvjqhdi/6Z3ivXSgoqUfeA4158UGyUr5zNjtWkSsqfUtw9SPgs11ZYnTT3obzppzzjdhgTp2KkPGB74NKnXhc7AoE5ETb7ux6F4fX1HDwDm/xWBrOfT+VkwiRnmYvhXIPIr/Hf7Xd1Gdb0mujTFv6JV0KR8teywc2AwoS4a8+3Wt/0fT+6hCXjt3W4nleXKXbIMVcZsloH4npfoCIoQMT37BDYwL5f5FbBGNqUCf6nS;4:rW0pb+khw9BU5qkpE6TnSVyoRYlP3siFMvJ3Owwsho0673c4g1Hy4higuM3szsRvMyymSCTYVUpiNQUcHalFwIqFKdkG3Q6Kbr8o7F3MgtZ0ZDluJfTSAlIVAna2CoJrAQJb2eGBU+TvZ/z3ER8hvpylohMlvSllpS9qt1DX8YifNaFDhG66N7787Bb2kQXnezdMX8AxAqlGA8W0Mjh1a6aZ3KYw2TWvufLR5tB0Z+n51mQwnRQgRaiQCn5Rpw6GGTMAUlnschpWHguyiCWAoNZx/wH0B4ad9v/LA4g1CfZ4uZNN/DMAgy38dh0VEFZhDmwFz45wToO19yFVwiCP31pSg5tSETNX5TQdcY6dK0XWJFlW4WoiDTgR8Oux692l
X-Microsoft-Antispam-PRVS: <BYAPR12MB26787F86FD945842FCB35DFFE5090@BYAPR12MB2678.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR12MB2678;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2678;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(478600001)(386003)(6486002)(53936002)(5660300001)(14444005)(54906003)(4326008)(6666003)(97736004)(25786009)(23676004)(7736002)(52116002)(7696005)(305945005)(76176011)(50466002)(50226002)(53416004)(36756003)(81156014)(81166006)(8936002)(106356001)(2616005)(956004)(476003)(3846002)(6116002)(86362001)(2870700001)(2906002)(47776003)(446003)(68736007)(186003)(16526019)(486006)(66066001)(316002)(105586002)(26005)(8676002)(11346002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2678;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjc4OzIzOmhlQk40YmQ3SjBFS2Z1ZWFtT0FVamQxSEpQ?=
 =?utf-8?B?UEx3aFVIZGJtWUo0bTh1UDJmY2xFQjVPc0VwWWxWWGpiRjYxTlh2OE1UVGJi?=
 =?utf-8?B?dmZ6Y3l6djFjd3FTL3pEZVNXOTlGM2QwQlAzNWhHUllaMjJSajE3MzdMOHR3?=
 =?utf-8?B?REk1ODAzQUNvUWd1OXlWMHI0WFhLVGdRdEIxaWlIbFpuRS9oWnREb0dEM3gw?=
 =?utf-8?B?eTdvTTNCd1lSbEM3VjJkNGVPUHpMSnBSNCtNYm1HL3ZiNnZvYTFwbHlVQW9M?=
 =?utf-8?B?UWpXQ3NCaDkxK2JlWFFmTTVxSG15dTBxQ0Q5OGZ1SEdOb3Rwb1l4eGtaLzZa?=
 =?utf-8?B?M01RRGRtdC9HdmFjeHpCMG9JMG1LRUdNOGlpZEMwN0Z1M2R6YkcrVnAwQXBs?=
 =?utf-8?B?bGg3ZDVGaTFWaWdnK3ljUDhtVWlZRWRhSTBVdEJaZGRjd1NtTGQzYWFvekJw?=
 =?utf-8?B?bElDQlVlT2lVd2dhSjJRNVFaNU1pbVh0WlNyYXBYQ0w5TlA3RnlKb0pHb0I2?=
 =?utf-8?B?Rnk5UkhGVlJTejVHbXRIamZSdTlwVTJFOGY3OFU3ZWJ2dzJzakVncS9RUnh6?=
 =?utf-8?B?K1dzTUpaZDFwald3ak91ZWc0cWxUenF0T3grVjlsdnFYSlROaEc0aUxjWk5W?=
 =?utf-8?B?N05Lc0hPdEtZY2FheUVoRXBVam5aKzVQZS9yd2dLNjZFajMwNjJERGp3bHhp?=
 =?utf-8?B?UmtFbjlHS0ZiV2tYdjZTZlFxYzJ0K0VWczBMWUlvOFFYdk9DTjZxang2M0pK?=
 =?utf-8?B?bDlxS0xPR0ZTdjY4YUs0WkNzYlZwYXVNS1dWSDBRUlAwbFBBdXo1UGVRMjhz?=
 =?utf-8?B?NTV1UEY1azRSbnEyeHpsK3NFNmN5dlhQVEhRQUJLaVJyQkdjeDJyT04zb2N6?=
 =?utf-8?B?WGx5STFaUWR5ZWdqWXFYaGFkalplUkthTnV4S1BzRzc3L3NtQ0lLUUpvRW5l?=
 =?utf-8?B?WG5nRmZiaVlCZDlFa0ZDUVB1ZjhCU1B1WHhkVXQ3WlJoVHFDdWV2RkhuMVg5?=
 =?utf-8?B?REJiM3oyNjJSenZxbTVVMjZyMWk4Sno1VUlNSW5EOGtmNzZLSlRPbVpLMWll?=
 =?utf-8?B?U253Ti9FazRxbGNlL1pvNkpuM0pJbHQ1V3VhcEcyV1JDUzlWMThTK0gzeGVW?=
 =?utf-8?B?RkE4Y3BIcjAvL05VQXErcTRuQ3JhR3NZeU90SWg0ZHpWZnF4VjVZTGlRUCs3?=
 =?utf-8?B?ZktJdVhRbFEzWjlRdGdSaXk1anl2YktITEZyZnNUQkR4ZlgveHlGRHZrWFdI?=
 =?utf-8?B?bWpuU01BRSszamgwSlpkbmhYOWhSWFd2bzFHMFVvVXo1TlZOTW5BS0g0WEcv?=
 =?utf-8?B?dlZrYUpXQXpaK2ZRLzFLZFlXd2NLUXpoeWR3dWRqRC8xc0U0Y0YyTmRveWxO?=
 =?utf-8?B?RVZKRHMwZGF3K3AweEFqL2l3NmJ4VTRlZDQ1SkN4cDJVYzY3WHJqSmF0L1lt?=
 =?utf-8?B?SFdpZVJvUGNHSk84aE4vTmtlaDAvM0ptdXExUzhWTVJaaituN244alBuamN1?=
 =?utf-8?B?Y2ZmUmJINmF6c2FyelNlQ0dPWlpmSkN6dHRkakJRdHNZdDBrVEhXT2VYbFE0?=
 =?utf-8?B?MEdnZ3Q0d0pZSTZFM05wRS9IUk00S0ptRm9xVVQyaU9McXNTSjBBYzJMZ1hp?=
 =?utf-8?Q?slKaVETfQSch1Z04yiEm?=
X-Microsoft-Antispam-Message-Info: LUtQsaj3AbCb74JRzM6HJZUyCJrF/8bvYM3Phkp/2VAj57YqlUneBTyl3cmxtfWissUkqG3msBE7fkkLsnZwjNIyEsw/BDCNNctrVhp1diPYvf9r7fwm7Fbm4ZUc7+i6nJn99MpNfeUefgn02xvP8kdR/HPDnZhnsPAMth1EgCi1xDtHToXboG5uCXl07z7kULqBtcu4lgkS781WnLPZyN0LunjRDL+WbeRA/4TwjNSDEUXsTRPLSA10xPY5TwPfrwcJsTPHiESKfafwzEgbPt2wg96CytUmenGK57an0fe87QBYB21qun0nYB0Nkq4yayZMXmGEvIE2z+MQauEBOZ6jEyV6Bx+suAi4MJUg0Ow=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;6:ZKAN9nS76Y8AbR/9FrkZdvLGP991qXuji88Fth8YJVrf+px1WZKVfR2sMKEcfscEPv/0/pZe3JrHP/4Vuxd1v/rjtwfBzdgatgOT9DHt9tcy12h4IH4gWU3DwU0ahXOFuxPJGV7zna6rLp39B/0QjNMOp/D32XxL2h6oEnq6WYUc0v0lUmB5Rxg8ofyafovQuYpLuhHfnOLneh6+NcdbFLASdbdaBEkMsX95h5pWn2P5leAEOm4rlO+dGHPEKe9U87UW4Nhe4Q9jpHSuec4Wt+TodDJfPCIC4nTUWBddO/4fnI7WAJ2AaQHIXTS24qwutQtjSR+jFJgPGo6IAF5ZSZGzMwY7UD1PdIGD1DFCSHpbQvoyV1TQcyrHp7kJ9Ccde7MiIkZnGXPpYxSGS40tNwMPaylnmCefx9cVzYbfepe9J5OnbbIM+0IZM46oxSh7axw1BiiUF7FSshMsQw62gw==;5:W2H26iEuNMO9+0ISNd2n8N7+dsWS/XdXpUryiOW6c2d2Rqng/uOi7HiiIInupdp9rWX6lejz803nnv3odFgxeQboAbc3IK/byT7AhvqVHcQAbLfji1ewPdwyhZusrv0XOPqrNPQrQqT0Tx74t5fYayQbgCzwLWttjjDnt90CozU=;7:yDWQDev7gxv39EjXspvGla4OaXq3vUwXibj6aP5pcsIH+6rXg3/NnFyD4aROWTgsFWdXSKNZ+nYnAy+GDGs28di5xpTjCKc/0enaWCWIiasfp95+ev0rb1BarM032gKPP3zRG5cF7sccZrcEpXBzYuHD8oIraDZySCgMNZfz6DYUeTOzblFunDnpQJ1Ii17NYJggjNwc6sZ4E8gbdrUyE2GyBYPxgoDUMMJhIAWjYVpOi6W2ysntuI7A4TOWBlxB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2678;20:0HV56jxf1q2vZQXfANzvcJdKZKH355/vOA2SXqzpqtPgtSRgR9NCFfsAdevL9Ldp85KUqtaBPIyiWOqLou23g4cuQhNlLQPdFKzc2xL41a259aPr8RwXHfJhUZ3U/KO8drmzHwW1F4QIPffYHdiTHBOCBSkMQ8uo7owIE5SF9yFpz3l+ImD5iiJPa1Ir+oxY1CRUiMynSSyf0xstX9PLZiR7/omA4Sxldif/mRyj+ddGCVI/oiShVELFVXUo5rM9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 18:24:13.6897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee44659f-17a1-4fb3-52d7-08d60ddc9fe8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-arrange the sme_encrypt_kernel() by moving the workarea map/unmap
logic in a separate static function. There are no logical changes in this
patch. The restructuring will allow us to expand the sme_encrypt_kernel
in future.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: kvm@vger.kernel.org
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
---
 arch/x86/mm/mem_encrypt_identity.c | 160 ++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 56 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7ae3686..92265d3 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -72,6 +72,22 @@ struct sme_populate_pgd_data {
 	unsigned long vaddr_end;
 };
 
+struct sme_workarea_data {
+	unsigned long kernel_start;
+	unsigned long kernel_end;
+	unsigned long kernel_len;
+
+	unsigned long initrd_start;
+	unsigned long initrd_end;
+	unsigned long initrd_len;
+
+	unsigned long workarea_start;
+	unsigned long workarea_end;
+	unsigned long workarea_len;
+
+	unsigned long decrypted_base;
+};
+
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
 static char sme_cmdline_off[] __initdata = "off";
@@ -266,19 +282,17 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __init sme_encrypt_kernel(struct boot_params *bp)
+static void __init build_workarea_map(struct boot_params *bp,
+				      struct sme_workarea_data *wa,
+				      struct sme_populate_pgd_data *ppd)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
 	unsigned long kernel_start, kernel_end, kernel_len;
 	unsigned long initrd_start, initrd_end, initrd_len;
-	struct sme_populate_pgd_data ppd;
 	unsigned long pgtable_area_len;
 	unsigned long decrypted_base;
 
-	if (!sme_active())
-		return;
-
 	/*
 	 * Prepare for encrypting the kernel and initrd by building new
 	 * pagetables with the necessary attributes needed to encrypt the
@@ -358,17 +372,17 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * pagetables and when the new encrypted and decrypted kernel
 	 * mappings are populated.
 	 */
-	ppd.pgtable_area = (void *)execute_end;
+	ppd->pgtable_area = (void *)execute_end;
 
 	/*
 	 * Make sure the current pagetable structure has entries for
 	 * addressing the workarea.
 	 */
-	ppd.pgd = (pgd_t *)native_read_cr3_pa();
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start;
-	ppd.vaddr_end = workarea_end;
-	sme_map_range_decrypted(&ppd);
+	ppd->pgd = (pgd_t *)native_read_cr3_pa();
+	ppd->paddr = workarea_start;
+	ppd->vaddr = workarea_start;
+	ppd->vaddr_end = workarea_end;
+	sme_map_range_decrypted(ppd);
 
 	/* Flush the TLB - no globals so cr3 is enough */
 	native_write_cr3(__native_read_cr3());
@@ -379,9 +393,9 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * then be populated with new PUDs and PMDs as the encrypted and
 	 * decrypted kernel mappings are created.
 	 */
-	ppd.pgd = ppd.pgtable_area;
-	memset(ppd.pgd, 0, sizeof(pgd_t) * PTRS_PER_PGD);
-	ppd.pgtable_area += sizeof(pgd_t) * PTRS_PER_PGD;
+	ppd->pgd = ppd->pgtable_area;
+	memset(ppd->pgd, 0, sizeof(pgd_t) * PTRS_PER_PGD);
+	ppd->pgtable_area += sizeof(pgd_t) * PTRS_PER_PGD;
 
 	/*
 	 * A different PGD index/entry must be used to get different
@@ -399,75 +413,109 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	decrypted_base <<= PGDIR_SHIFT;
 
 	/* Add encrypted kernel (identity) mappings */
-	ppd.paddr = kernel_start;
-	ppd.vaddr = kernel_start;
-	ppd.vaddr_end = kernel_end;
-	sme_map_range_encrypted(&ppd);
+	ppd->paddr = kernel_start;
+	ppd->vaddr = kernel_start;
+	ppd->vaddr_end = kernel_end;
+	sme_map_range_encrypted(ppd);
 
 	/* Add decrypted, write-protected kernel (non-identity) mappings */
-	ppd.paddr = kernel_start;
-	ppd.vaddr = kernel_start + decrypted_base;
-	ppd.vaddr_end = kernel_end + decrypted_base;
-	sme_map_range_decrypted_wp(&ppd);
+	ppd->paddr = kernel_start;
+	ppd->vaddr = kernel_start + decrypted_base;
+	ppd->vaddr_end = kernel_end + decrypted_base;
+	sme_map_range_decrypted_wp(ppd);
 
 	if (initrd_len) {
 		/* Add encrypted initrd (identity) mappings */
-		ppd.paddr = initrd_start;
-		ppd.vaddr = initrd_start;
-		ppd.vaddr_end = initrd_end;
-		sme_map_range_encrypted(&ppd);
+		ppd->paddr = initrd_start;
+		ppd->vaddr = initrd_start;
+		ppd->vaddr_end = initrd_end;
+		sme_map_range_encrypted(ppd);
 		/*
 		 * Add decrypted, write-protected initrd (non-identity) mappings
 		 */
-		ppd.paddr = initrd_start;
-		ppd.vaddr = initrd_start + decrypted_base;
-		ppd.vaddr_end = initrd_end + decrypted_base;
-		sme_map_range_decrypted_wp(&ppd);
+		ppd->paddr = initrd_start;
+		ppd->vaddr = initrd_start + decrypted_base;
+		ppd->vaddr_end = initrd_end + decrypted_base;
+		sme_map_range_decrypted_wp(ppd);
 	}
 
 	/* Add decrypted workarea mappings to both kernel mappings */
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start;
-	ppd.vaddr_end = workarea_end;
-	sme_map_range_decrypted(&ppd);
+	ppd->paddr = workarea_start;
+	ppd->vaddr = workarea_start;
+	ppd->vaddr_end = workarea_end;
+	sme_map_range_decrypted(ppd);
 
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start + decrypted_base;
-	ppd.vaddr_end = workarea_end + decrypted_base;
-	sme_map_range_decrypted(&ppd);
+	ppd->paddr = workarea_start;
+	ppd->vaddr = workarea_start + decrypted_base;
+	ppd->vaddr_end = workarea_end + decrypted_base;
+	sme_map_range_decrypted(ppd);
 
-	/* Perform the encryption */
-	sme_encrypt_execute(kernel_start, kernel_start + decrypted_base,
-			    kernel_len, workarea_start, (unsigned long)ppd.pgd);
+	wa->kernel_start = kernel_start;
+	wa->kernel_end = kernel_end;
+	wa->kernel_len = kernel_len;
 
-	if (initrd_len)
-		sme_encrypt_execute(initrd_start, initrd_start + decrypted_base,
-				    initrd_len, workarea_start,
-				    (unsigned long)ppd.pgd);
+	wa->initrd_start = initrd_start;
+	wa->initrd_end = initrd_end;
+	wa->initrd_len = initrd_len;
+
+	wa->workarea_start = workarea_start;
+	wa->workarea_end = workarea_end;
+	wa->workarea_len = workarea_len;
+
+	wa->decrypted_base = decrypted_base;
+}
 
+static void __init teardown_workarea_map(struct sme_workarea_data *wa,
+				         struct sme_populate_pgd_data *ppd)
+{
 	/*
 	 * At this point we are running encrypted.  Remove the mappings for
 	 * the decrypted areas - all that is needed for this is to remove
 	 * the PGD entry/entries.
 	 */
-	ppd.vaddr = kernel_start + decrypted_base;
-	ppd.vaddr_end = kernel_end + decrypted_base;
-	sme_clear_pgd(&ppd);
-
-	if (initrd_len) {
-		ppd.vaddr = initrd_start + decrypted_base;
-		ppd.vaddr_end = initrd_end + decrypted_base;
-		sme_clear_pgd(&ppd);
+	ppd->vaddr = wa->kernel_start + wa->decrypted_base;
+	ppd->vaddr_end = wa->kernel_end + wa->decrypted_base;
+	sme_clear_pgd(ppd);
+
+	if (wa->initrd_len) {
+		ppd->vaddr = wa->initrd_start + wa->decrypted_base;
+		ppd->vaddr_end = wa->initrd_end + wa->decrypted_base;
+		sme_clear_pgd(ppd);
 	}
 
-	ppd.vaddr = workarea_start + decrypted_base;
-	ppd.vaddr_end = workarea_end + decrypted_base;
-	sme_clear_pgd(&ppd);
+	ppd->vaddr = wa->workarea_start + wa->decrypted_base;
+	ppd->vaddr_end = wa->workarea_end + wa->decrypted_base;
+	sme_clear_pgd(ppd);
 
 	/* Flush the TLB - no globals so cr3 is enough */
 	native_write_cr3(__native_read_cr3());
 }
 
+void __init sme_encrypt_kernel(struct boot_params *bp)
+{
+	struct sme_populate_pgd_data ppd;
+	struct sme_workarea_data wa;
+
+	if (!sme_active())
+		return;
+
+	build_workarea_map(bp, &wa, &ppd);
+
+	/* When SEV is active, encrypt kernel and initrd */
+	sme_encrypt_execute(wa.kernel_start,
+			    wa.kernel_start + wa.decrypted_base,
+			    wa.kernel_len, wa.workarea_start,
+			    (unsigned long)ppd.pgd);
+
+	if (wa.initrd_len)
+		sme_encrypt_execute(wa.initrd_start,
+				    wa.initrd_start + wa.decrypted_base,
+				    wa.initrd_len, wa.workarea_start,
+				    (unsigned long)ppd.pgd);
+
+	teardown_workarea_map(&wa, &ppd);
+}
+
 void __init sme_enable(struct boot_params *bp)
 {
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
-- 
2.7.4

