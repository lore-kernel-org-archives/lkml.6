Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90627C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A21219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="i+C64HVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A21219E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbeHFL0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:24 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:48032 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729478AbeHFL0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:23 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BGSE009132;
        Mon, 6 Aug 2018 04:17:49 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp0115.outbound.protection.outlook.com [216.32.181.115])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn85wc4uj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDXC7a1lnzVuzFppSr4kRj29BY8T5UO+oUnCxGo9KmA=;
 b=i+C64HVwASICBBtj/pINZKazsPS4paHwA3fQyngjGZBXGPGHKdvoezA/KAwWostipqDLQ4WiOOra4PzilZIqYujUN3Qp/NMyiUb+Aiw5UBivRnVSh0CSYb0o4Z14UHwqs/HKUEHlzQdJboZ8NQx0+m9bHy/TbDJxfbPQDWyD7pU=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 CY4PR04MB0968.namprd04.prod.outlook.com (2603:10b6:910:55::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:17:45 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id E8F75302D78; Mon,  6 Aug 2018 04:17:38 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
Subject: [PATCH RT 09/22] crypto: limit more FPU-enabled sections
Date:   Mon,  6 Aug 2018 04:17:25 -0500
Message-Id: <5fc4fe6c1f808230483b805de7bf21ff935707c4.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: CO2PR07CA0053.namprd07.prod.outlook.com (2603:10b6:100::21)
 To CY4PR04MB0968.namprd04.prod.outlook.com (2603:10b6:910:55::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c39c79b0-ace3-43f7-8926-08d5fb7d78cf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB0968;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;3:2samc1g68oeeCU+DLUZwP6XlehJ0zvcT6xViGTPJPfC+0xbN3k1Bj4/AzwwfH0yuXjTaWHzSz5eYdudwiP6LoGUn675UL4EGAM6U4NqlHHXZ1MfibW3mJnHYgJhnPfG57ikEJzegasrxnvTws+M2sd8Y36IwFR4f1FFivn4ojO9JRR/AyiUycCFAN8kfNjf+qp9WBVguR2H/O3fV1D1mPgit5b2pJ9zJMptYf8+AZ3snDdgoV6smzbhNFcUnfqmJ;25:PcR8Wf3qxBti+xs07uE2oDu1BFlR8TLvAWjmpBYeBnGKgqOJ5YwF0H9VqcabjPnCtKw6KYGpBUwg15sOEeLsFq2tEYtZovtSbG4l3lyaau7Z2nvvE0NrMhV/KaRyOg3roSy7RyFcf9TAtXJxBN2Fhr36jx/Fvch0PSAuTlAZ9q9TWyhPXi2Dl7mBws/MngeEXcaroDMnCzwUVz3yc82nPXYaVloX9P9H6oRdjSdmWh5qiZ+LpZv2u7yIKzCgsJpzHK/cBSUMQ306e4ApTbe19ZcuI8z+16A1B/MecMu/p1oHEdEL/zXSVmxp3YlGFdhRPErH3TGdR8SFxc3AnYjMwg==;31:7wHuF2Q9puh+ZowfoEoZDA/fZ4T4fnHzqCPOqx5ur2iD934eRbRc/dSlS3fD3sSa5wduieO8QGL4t9fMmDjXo79pzV/bBUq0ogLoQlY/jukwwTnF6/4JLh0KGBd02yU82NKWLpNHFDYboM/rnEpDIR600xPr6Ji+BLdu5gGuF72sDIUp/OYzq7hinFkDt0capPrL/+DOOaQ/aawKLliaysnge5ZS/ArxpBs+H4XldbM=
X-MS-TrafficTypeDiagnostic: CY4PR04MB0968:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;20:jbExrF6M08M5UOakAl5Yyi+ivqfQrmj3Edz6rDv9kkxYaILGW4KK2+fQoWxFHLmEXZ480n6C4mbDPYWdryWmOxw86064EXyoCw9FYmwpQmtg0/Jlv1Tr/HqiSqnxvXS+qhLJyA6YYZYPrvaHld+apwlsrI+D0qYdufHFyz3GIUI+SBTomoMcQbEZ80d+AgbLai6BnVB4PjMF6it04LE0EQnHpcISbccyTGf2YYWBqUCU5tzg3uzoukmmzZPI6vOwi5O/um8FKg3/b5uk2mJiAuWEPYTMkAXeK7nRWikT+hV3ECzGwJYmrn2tq7xGDSe8djACoLNfz1zBMDx6ZmI1AuxcvjVwikGiMYIjUULVI4LC28w2Yk2qvN8ix9IiegABwRgWgN9LA/Te6P37vQhMdYMsRaaxRw5AW8SnUODkNsyIeozXPFD1ya19ONpnakm0RS3p7s4H6p8DKw4j3zxIWZOwteUpxowY7eVzSucc3gwtT7b9w5G2/vGTXEOIfKLpXfTeRg9j84FXom030VDLtFbnDPQ/4GGFWk3blbNfl/PFnP1O73lFsIyRyaRzvXQACyJbwp+9pGH9kxdJ3ecOJZjUBPOdP0ii67S7BQwiYtU=
X-Microsoft-Antispam-PRVS: <CY4PR04MB096838D866E27514869E5F4FF4200@CY4PR04MB0968.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR04MB0968;BCL:0;PCL:0;RULEID:;SRVR:CY4PR04MB0968;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;4:Q+4tOGgZ/uK7qdHq7jC8vM7fRnUSNcP/I4EytLM4Ikn2rpkR0U2fSvx0QPnZvT/7yH38Xp5l38KmdFKM0cBPbz1Qmy3zl2xoq+S8qr70/jytHPj/qBO1c5l7TMeQo3S8yubmtJfZ1Ghf0XkMcWlsF/o/hYHQ735k4AFMy5LL8b3zp2MAcmZ5XKLo9lwLgCrGkoSvJIL/D3cfl2PvaJVg3kErug6l4C0442urKGuAOWr8QI3rAm+a3cntABYC0cvIwqhECs0+N9GerWq1pZCEIAmTvQ4sh/htD0bF1hEnbh2LCSKoZlDh0a0AflHcmAP42cU0n/u1VBtgjKkP/VJQNe2fCqSlxz44vTzI3L/EfFE=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(136003)(346002)(376002)(199004)(189003)(6266002)(47776003)(14444005)(66066001)(54906003)(478600001)(476003)(386003)(97736004)(26005)(6666003)(3846002)(42186006)(6116002)(122856001)(50226002)(316002)(446003)(2616005)(4326008)(186003)(106356001)(52116002)(5660300001)(68736007)(36756003)(2870700001)(105586002)(11346002)(305945005)(50466002)(8936002)(7736002)(81166006)(486006)(23676004)(81156014)(118296001)(76176011)(52956003)(8676002)(2906002)(7416002)(90966002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0968;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA0TUIwOTY4OzIzOmNqb3ZnQWlsZXRFR1JUK0FGUFBoZmpPSFJI?=
 =?utf-8?B?eUVvQmFkOEd4MmVONWZ4QUhhL25sdUVoWmJhaFJGbEJ3eWVReHd1UHIwWUVk?=
 =?utf-8?B?bGtEWG85dmpzQzlFVlpiUk9LQkxPaDNXSjIvSFlyeVplK0JhNm5Nbm04YnFp?=
 =?utf-8?B?bnlrVzRzN25IMHpveTZKYS91eTdZSXRUb1VHS1h1TE10MTNuSGZvdHczeEcy?=
 =?utf-8?B?K1BtVG56Qit2NStDYS8wS29XT3Y4NWdjdkJiZ1k1OEJEazNhYzlrR3JOMm9v?=
 =?utf-8?B?bE9JUVBrNVM0ZlBXSFkvb29zS1dqWkdKV1IreDhreEZFK2R5MUVVMGw3SFQ1?=
 =?utf-8?B?akRZZGI0eFh4aFljbmloNy91R1NqalZjT05tcGpReDZkRlpmU0NkNXcrakY4?=
 =?utf-8?B?eVVuQVdNMkMxN1RtOFZxWTVsUWswYVRST29iOGFISXFwTVJGeWJBMmRaTDlW?=
 =?utf-8?B?S3VUKzJ1Y3JqbjZpVitPdmo3S0ZwS3BNWjE4ck54OEpBa2UzREdhbjJBc3JH?=
 =?utf-8?B?TDFDSTR4TENlT0pLWWpySSt1c1QzWHVCNzQ3aWRXU0liTmt2NHVRWWFhd1JM?=
 =?utf-8?B?QlJWZys4ZHU1QTE1SS82NWt0ZzJnSE1vMVhFdm1HLzZVcnhZcW1qMnhtN01q?=
 =?utf-8?B?b0JQY2ZlT1VQdmpRSXhIRjBQd3owMytSbHUwM3l5UUxwWDRKMGJZbWVoNXZD?=
 =?utf-8?B?Y0dxWW5UNnJkRVR5NVdxa3ZUOXpaYlgyVDJydnQwOUl4bXNITGRQeGhLZis0?=
 =?utf-8?B?a2ovWXBVR0lmWkZDR3lBUVVUcVcyRVRHZUg4ZmpoMkNsaStaU2UxQk5jTXFE?=
 =?utf-8?B?d1cvZ3lXekJPU0dOYTBBSThsTlZETUNYcGtPUTFDNVQzbUNYaWNXSnNtS1J1?=
 =?utf-8?B?RFkwOFFBaHFIWlVybGpMTVM3NUhjWXJGOXB5c3JlcThTYmExY25iczc4OUpO?=
 =?utf-8?B?aFBJRnN1dHRKVWdGcWVKK2Jla3VYdUUwN2wvcXZrYTgra3dDZVl0VkJqZG9y?=
 =?utf-8?B?VmZVYWovbU9IZW1YOW9RQ1F6YS82VHJCVmMxUEhlQ2ZGTkpqQWYrVDZQUEVT?=
 =?utf-8?B?VzdQNVp6S1NOcmZuUGlITjVqemFQMERaRTVpK1YxYmtRYXlEcUtBQVdrN0d5?=
 =?utf-8?B?RlUyZ2xseFBLNGVwM1NROCt5eW4rT0pkYUp2K3pmVUxyV2hjWU1JMVJTVUJX?=
 =?utf-8?B?cnYzbWZLcktFaGxzQy9aV3ErRnpBZWRWRDJ0SnNMRUtnV0EyUFZPZkFrR2hz?=
 =?utf-8?B?SUgxRG5pRHlER05oTHQycklmL3VDT0p2VTlKMk5uSXh3Q0w3VDRhL1lmYlZs?=
 =?utf-8?B?YzkrdTNRNzdPTkJSRG5WRlZMdUFHdWk1Ny93Smc1emUzK0xtK3JuNGZ1bEF0?=
 =?utf-8?B?UDlXTGFlRmE1SkdIdkdEdlc2cHBRbXdPUnBRbFlvMHUxbC9hak5MT1hrSjh6?=
 =?utf-8?B?UTh1b2ZUaEZyMDJNZDBsY2VCcGN6bXA0SDNkaVRseGJsVEJjVU1INWdIUUhs?=
 =?utf-8?B?eXAzZjVrWU1QT2FJVWJIWGlHaHFKOHpVa2Z0am5WQ1piT3JhaXhZbEtrTGRr?=
 =?utf-8?Q?yOCVdrCP743wsaO72VIzM5r5uHzud88FxrKkDQILm4Ts=3D?=
X-Microsoft-Antispam-Message-Info: dTNJTUNQvIhwPbLySGNC3pv2J9axc3gaTBDrX3hkDFQ9ZnK2ocJAZz9rReoXmKzxZ2zLFdj6uEyUHthFLARusZFOtM1dCTs7VN3nWObSNHK6uWfmGLwTm73hRjO3GGK56Srl8uHGW3yB/2PPe4mrT23U4olPBuC4uzYDL/54uBL59wELomCHE2Jzk4egmctTQ1Tcrj9dcxBljiGY2gERRFYfpFYrNh0aHl+y2x/enGwBE1NkzrVLb9EfIe8t0hvXiq3D1t9WMYWTuXylHFq9q2XTC2+0koH7VaoIrvXRyf/WQHCNmTFfnsx/EIwYknD0b4uZ8A71JxiR80z9IuyFcCFLUpszIy3lJxPXvsn/mRg=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;6:E3dkvgZWUnE/dfCgD2sBgrOYX92I2JeSEKqzB9lMArDa2pagzx6jGPGfcgAxFjmQm4PSlRku5juA7eHa/iAWBc1uizQSYsw3yTePyDRrP5mprCq6+YYIkzXuhOZpSOvxK3BEpOj7fAquYvdmcV3i76MFJFieecbISHL65yIDo7F+QsMx6D2UVhiLkPuQ55rDI5bcxmrkWGPiYTYOAbb7DzITyl+XWKiNP+pHxX9P8l40iLuHv7oh23TRT1mACaO4gMNYOUnJOPSWN4A5q3AQcCsbu6Wz3L309+GZ+txUURiyTnv9GHcuM2AOq4y7RkhmkkE3oj8CLgD8+y9Vf2VHNmObGjCeA2Yct32PTgiiDArvXhza9zgyu08h6Rwb6cSYkseFeI6Y77X/cVKZiHemeaojI8gjDHWzmcrDcoPVkF+V9Nh4NV3KcTTOOiOHwOe+mkqfPRAzo1PxrCxBZfFeGw==;5:Y16Pc1FwKac5mC/os4Fz9EVNBAG5GTTzQv//gUdCh57CadTbhHhtZKYQo29CDnJ2ZsimsQMwV1/81Il5BUmYDKiCR/wx2lWAsOKuZzHmE64C+H5adviRdGV1aEmuzyFBJDd+jV9/jfU3PC/gGTgAIQwwTZRGqJt/jxEnOE+gPVw=;7:9Op+RDeqeuEJLnsULyXPfDwwovZCWhq2jRnrOekZdLVzZ6C80o8Q0ZbS6qRfpxcCTGRxxTfJjf7hgiEgBhP4qjKU+kAm2U1kmzkviO8LeWnzJZ/t0LG7cRHQvDZXLjvAnX/l5l9FuW9azjAP1sSzqBELtjrHqtpWt4pLrG6IPn2eXgXwiZ0Br10f+yh6jqwI6t0rKUHb28f34k8PqaERc9fcxdqkS/aAKKyhpDzxHxMVfGL+lB4xg9SjJrlX0PTI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:45.8343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c39c79b0-ace3-43f7-8926-08d5fb7d78cf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0968
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
Those crypto drivers use SSE/AVX/… for their crypto work and in order to
do so in kernel they need to enable the "FPU" in kernel mode which
disables preemption.
There are two problems with the way they are used:
- the while loop which processes X bytes may create latency spikes and
  should be avoided or limited.
- the cipher-walk-next part may allocate/free memory and may use
  kmap_atomic().

The whole kernel_fpu_begin()/end() processing isn't probably that cheap.
It most likely makes sense to process as much of those as possible in one
go. The new *_fpu_sched_rt() schedules only if a RT task is pending.

Probably we should measure the performance those ciphers in pure SW
mode and with this optimisations to see if it makes sense to keep them
for RT.

This kernel_fpu_resched() makes the code more preemptible which might hurt
performance.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 0dcc4c1693ef37e166da420ef7c68c7047c996f1)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 20 ++++++++++++++++
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 19 +++++++++++++++
 arch/x86/crypto/cast6_avx_glue.c           | 24 +++++++++++++++----
 arch/x86/crypto/chacha20_glue.c            |  9 ++++----
 arch/x86/crypto/serpent_avx2_glue.c        | 19 +++++++++++++++
 arch/x86/crypto/serpent_avx_glue.c         | 23 ++++++++++++++----
 arch/x86/crypto/serpent_sse2_glue.c        | 23 ++++++++++++++----
 arch/x86/crypto/twofish_avx_glue.c         | 27 ++++++++++++++++++++--
 arch/x86/include/asm/fpu/api.h             |  1 +
 arch/x86/kernel/fpu/core.c                 | 12 ++++++++++
 10 files changed, 158 insertions(+), 19 deletions(-)

diff --git a/arch/x86/crypto/camellia_aesni_avx2_glue.c b/arch/x86/crypto/camellia_aesni_avx2_glue.c
index 60907c139c4e..0902db7d326a 100644
--- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
@@ -206,6 +206,20 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void camellia_fpu_end_rt(struct crypt_priv *ctx)
+{
+       bool fpu_enabled = ctx->fpu_enabled;
+
+       if (!fpu_enabled)
+               return;
+       camellia_fpu_end(fpu_enabled);
+       ctx->fpu_enabled = false;
+}
+#else
+static void camellia_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = CAMELLIA_BLOCK_SIZE;
@@ -221,16 +235,19 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	if (nbytes >= CAMELLIA_AESNI_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_ecb_enc_16way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_enc_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_enc_blk(ctx->ctx, srcdst, srcdst);
@@ -251,16 +268,19 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	if (nbytes >= CAMELLIA_AESNI_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_ecb_dec_16way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_dec_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_dec_blk(ctx->ctx, srcdst, srcdst);
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index d96429da88eb..3b8e91841039 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -210,6 +210,21 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void camellia_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	camellia_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void camellia_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = CAMELLIA_BLOCK_SIZE;
@@ -225,10 +240,12 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_enc_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_enc_blk(ctx->ctx, srcdst, srcdst);
@@ -249,10 +266,12 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_dec_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_dec_blk(ctx->ctx, srcdst, srcdst);
diff --git a/arch/x86/crypto/cast6_avx_glue.c b/arch/x86/crypto/cast6_avx_glue.c
index 50e684768c55..8caf9ba8c1da 100644
--- a/arch/x86/crypto/cast6_avx_glue.c
+++ b/arch/x86/crypto/cast6_avx_glue.c
@@ -205,19 +205,33 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void cast6_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	cast6_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void cast6_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = CAST6_BLOCK_SIZE;
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = cast6_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * CAST6_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = cast6_fpu_begin(ctx->fpu_enabled, nbytes);
 		cast6_ecb_enc_8way(ctx->ctx, srcdst, srcdst);
+		cast6_fpu_end_rt(ctx);
 		return;
 	}
-
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		__cast6_encrypt(ctx->ctx, srcdst, srcdst);
 }
@@ -228,10 +242,10 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = cast6_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * CAST6_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = cast6_fpu_begin(ctx->fpu_enabled, nbytes);
 		cast6_ecb_dec_8way(ctx->ctx, srcdst, srcdst);
+		cast6_fpu_end_rt(ctx);
 		return;
 	}
 
diff --git a/arch/x86/crypto/chacha20_glue.c b/arch/x86/crypto/chacha20_glue.c
index f910d1d449f0..f9e5820ae06a 100644
--- a/arch/x86/crypto/chacha20_glue.c
+++ b/arch/x86/crypto/chacha20_glue.c
@@ -80,23 +80,24 @@ static int chacha20_simd(struct blkcipher_desc *desc, struct scatterlist *dst,
 
 	crypto_chacha20_init(state, crypto_blkcipher_ctx(desc->tfm), walk.iv);
 
-	kernel_fpu_begin();
-
 	while (walk.nbytes >= CHACHA20_BLOCK_SIZE) {
+		kernel_fpu_begin();
+
 		chacha20_dosimd(state, walk.dst.virt.addr, walk.src.virt.addr,
 				rounddown(walk.nbytes, CHACHA20_BLOCK_SIZE));
+		kernel_fpu_end();
 		err = blkcipher_walk_done(desc, &walk,
 					  walk.nbytes % CHACHA20_BLOCK_SIZE);
 	}
 
 	if (walk.nbytes) {
+		kernel_fpu_begin();
 		chacha20_dosimd(state, walk.dst.virt.addr, walk.src.virt.addr,
 				walk.nbytes);
+		kernel_fpu_end();
 		err = blkcipher_walk_done(desc, &walk, 0);
 	}
 
-	kernel_fpu_end();
-
 	return err;
 }
 
diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index 870f6d812a2d..5c806bf39f1d 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -184,6 +184,21 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void serpent_fpu_end_rt(struct crypt_priv *ctx)
+{
+       bool fpu_enabled = ctx->fpu_enabled;
+
+       if (!fpu_enabled)
+               return;
+       serpent_fpu_end(fpu_enabled);
+       ctx->fpu_enabled = false;
+}
+
+#else
+static void serpent_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = SERPENT_BLOCK_SIZE;
@@ -199,10 +214,12 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= SERPENT_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		serpent_ecb_enc_8way_avx(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * SERPENT_PARALLEL_BLOCKS;
 		nbytes -= bsize * SERPENT_PARALLEL_BLOCKS;
 	}
+	serpent_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		__serpent_encrypt(ctx->ctx, srcdst, srcdst);
@@ -223,10 +240,12 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= SERPENT_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		serpent_ecb_dec_8way_avx(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * SERPENT_PARALLEL_BLOCKS;
 		nbytes -= bsize * SERPENT_PARALLEL_BLOCKS;
 	}
+	serpent_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		__serpent_decrypt(ctx->ctx, srcdst, srcdst);
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index 6f778d3daa22..46dcbdbd0518 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -218,16 +218,31 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void serpent_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	serpent_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void serpent_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = SERPENT_BLOCK_SIZE;
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * SERPENT_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
 		serpent_ecb_enc_8way_avx(ctx->ctx, srcdst, srcdst);
+		serpent_fpu_end_rt(ctx);
 		return;
 	}
 
@@ -241,10 +256,10 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * SERPENT_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
 		serpent_ecb_dec_8way_avx(ctx->ctx, srcdst, srcdst);
+		serpent_fpu_end_rt(ctx);
 		return;
 	}
 
diff --git a/arch/x86/crypto/serpent_sse2_glue.c b/arch/x86/crypto/serpent_sse2_glue.c
index 644f97ab8cac..7b135b4f6262 100644
--- a/arch/x86/crypto/serpent_sse2_glue.c
+++ b/arch/x86/crypto/serpent_sse2_glue.c
@@ -187,16 +187,31 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void serpent_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	serpent_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void serpent_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = SERPENT_BLOCK_SIZE;
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * SERPENT_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
 		serpent_enc_blk_xway(ctx->ctx, srcdst, srcdst);
+		serpent_fpu_end_rt(ctx);
 		return;
 	}
 
@@ -210,10 +225,10 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * SERPENT_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
 		serpent_dec_blk_xway(ctx->ctx, srcdst, srcdst);
+		serpent_fpu_end_rt(ctx);
 		return;
 	}
 
diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index b7a3904b953c..de00fe24927e 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -218,6 +218,21 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void twofish_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	twofish_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void twofish_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = TF_BLOCK_SIZE;
@@ -228,12 +243,16 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 
 	if (nbytes == bsize * TWOFISH_PARALLEL_BLOCKS) {
 		twofish_ecb_enc_8way(ctx->ctx, srcdst, srcdst);
+		twofish_fpu_end_rt(ctx);
 		return;
 	}
 
-	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3)
+	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3) {
+		kernel_fpu_resched();
 		twofish_enc_blk_3way(ctx->ctx, srcdst, srcdst);
+	}
 
+	twofish_fpu_end_rt(ctx);
 	nbytes %= bsize * 3;
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
@@ -250,11 +269,15 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 
 	if (nbytes == bsize * TWOFISH_PARALLEL_BLOCKS) {
 		twofish_ecb_dec_8way(ctx->ctx, srcdst, srcdst);
+		twofish_fpu_end_rt(ctx);
 		return;
 	}
 
-	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3)
+	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3) {
+		kernel_fpu_resched();
 		twofish_dec_blk_3way(ctx->ctx, srcdst, srcdst);
+	}
+	twofish_fpu_end_rt(ctx);
 
 	nbytes %= bsize * 3;
 
diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 1429a7c736db..85428df40a22 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -24,6 +24,7 @@ extern void __kernel_fpu_begin(void);
 extern void __kernel_fpu_end(void);
 extern void kernel_fpu_begin(void);
 extern void kernel_fpu_end(void);
+extern void kernel_fpu_resched(void);
 extern bool irq_fpu_usable(void);
 
 /*
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 96d80dfac383..6e473a44afb7 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -158,6 +158,18 @@ void kernel_fpu_end(void)
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
+void kernel_fpu_resched(void)
+{
+	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
+
+	if (should_resched(PREEMPT_OFFSET)) {
+		kernel_fpu_end();
+		cond_resched();
+		kernel_fpu_begin();
+	}
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_resched);
+
 /*
  * CR0::TS save/restore functions:
  */
-- 
2.18.0

