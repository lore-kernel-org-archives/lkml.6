Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeCPUh4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:37:56 -0400
Received: from mail-by2nam03on0050.outbound.protection.outlook.com ([104.47.42.50]:52192
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751672AbeCPUhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:37:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
From: Babu Moger <babu.moger@amd.com>
To: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, babu.moger@amd.com
Subject: [PATCH v2 0/5] KVM: x86: Implement Pause Loop Exit for SVM
Date: Fri, 16 Mar 2018 16:37:21 -0400
Message-Id: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:404:65::28) To MWHPR12MB1776.namprd12.prod.outlook.com
 (2603:10b6:300:113::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2036fe8-3a60-4902-5bf5-08d58b7dc92e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1776;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;3:QsVmUPDlNnbuotJupIAr6YY+208Jd2CU3qnythd7IIbI3mHz8NjZYWeZpNgABzPNQ3QnixUgO0BmZ9lG2VfchjOBwuln7UjNKNQS1CxPYl6NEcV6l3Sq7PHjS1oVab+lZ4cfnbOYCXu4iwf1+uXZB0IvNi8bjHNeUM6HjnKaULJW3bSGDUo2O4KeSEeGqBW4Qvgs1HtwPR081usWA4aXpHkpn1s4nKxBLGX5iZevL1U8PDgqB/2VKFHyCyl00H1U;25:KV2MRbHvJkpOnlrxgN4e6HgPM4nsoHtbw3ZpHBW+qdeclbTiorprnrBiEOhZqarW4tU2nSl3NfjVxzPx+8iRaJv06XdGRGVLuPd/MBLVIOmyA3LkS+cbNgsyVGH1y0hU4efNPs9wMgp2lr2My6X5cUI/9gs8/fsHKZGNy07QclzZUco+HNz+1z8G1wHDyeymaNRc+qUDebO1QGVKZ8g5tKF6MHqf/lkKmrDQrf9RVPAYgM6A0iKTGgOH3Q3lP3EBmU8GUMin8upAJxatlF7mRtC5lE+osXHaw+sohdYjQBdAlFZndhf+b4Qg8a5/iohu/xDo6XnzVesXWD87Kx+mfg==;31:ELDUZwFpcGM1P3Ku9pa1pVTKjfclCYQN3ZoFenBeXATmKbf+y6i7V5YxwkbBNBoLYc4zXanUraw0uDrGBAyf1k4CSw4SAicXaKyMuC9BvwWcd3KMuSqSjEiTip7+fXS1qOO1ePpRnEJG8AjRihkMNlbakM6egfk2l2eqvLK29dPs0MKXO31T/w+ttJGjg2nrUh6yK1zh/D5+D4s8DVMdYWYGSAiSQMEkhrNCtbytk1Q=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1776:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;20:xl9q7SRyDL+Pebp0bHJbMTt5X7mhat26IhYr16v74nQYCuhO2LxjqBvy/wkePyBV9QOuaME7/JYkAP5z6XRMG+9/w26gq4rkHPFBtG2r6cFXQYojKYPwSTa77fHzp/CX609sK1CudxdStG1PE4HQCqbzIGqdwWknvy3uBttLGnV9ZzEE2B17ZbxkNxUqltzF4fVuCpZM5YrDnLz138zkVXxZkHfyc/o1iw9UYNGNY017k/AYwC99+ihaZCzqwzhnCMzqt7emUzfhYgWSbpKPA5o1YwDfCsbqO8w2jynfNcbQXQaJ7wa7nVdGl7VcMKb5CerNU5yDBTMna51uA6JkLXWgmR6p+MgIylsKqOwEmtUAaCHxtU84HYWPg00Vtq6x40Y9OjIxT+8/ybG+IoAHV+fQUtOpD7sXW7GWxNFouAFb1yfkna9rwn/5TQQIyogy5eY8tgmRXPvS9MRyJtXOE5cf5NR1QqUq03pHIkzMxiJbwPxIobrNzMSoIXuBBPN6;4:+cH3UrLJz5Idn6DmxqOS3xVG7Cjnh8sqRpQgnvtaMHIWTDg1+Ug0VxOHpoL5CQS/uURAngjJQVXxYa6tsLvLG8itM653ZgLGIGTRCqL9hv17FqV6l4uWIgDKJ9RrUJguskLX+kZ8Dz/uTdZeKyEs3I9vis0FoZHfHzQVYFF3R88OQHDX86NiUfFLXE5Xpev8XUT65XXj2XPWVd46yOX2BKkM+HcroC/sh0Va2KCVf8acpdUSuuMRyZ380QlzhGgN/rg1ttEScnQnxBAXgj3H/w==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1776A361C60FB5982B07D6C295D70@MWHPR12MB1776.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1776;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1776;
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(81166006)(8676002)(81156014)(50226002)(6116002)(7736002)(186003)(16526019)(3846002)(26005)(305945005)(106356001)(16586007)(478600001)(4720700003)(386003)(6666003)(25786009)(316002)(66066001)(97736004)(8936002)(4326008)(50466002)(48376002)(52116002)(51416003)(7696005)(68736007)(53936002)(72206003)(36756003)(105586002)(53416004)(2906002)(6486002)(47776003)(5660300001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1776;H:linux-pyp0.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1776;23:bOh7wMNZR/CMnyhm7LSn+tV0rs9R/gQkuCFNfhE0Z?=
 =?us-ascii?Q?hdpeiSSEk6WtHFiJzKdFePmVTgJD5O13uuYr9esY2Aus4BZzGvFBrWUmbBVy?=
 =?us-ascii?Q?NtuKA0eBUCbx+5fHK6UlCr3W4fbqNfR8vDsn4xtRirT0YCiIy6Yxl2m/cFgA?=
 =?us-ascii?Q?kdgQlm0VvstbbjmcxXOU179ipXjnVZwsGRaILn0UEK/MXh1W3mvO7VvzPUKQ?=
 =?us-ascii?Q?XDVX1EZK9GluH6Kv8VMiPZ8Dt3yASMUf8JonUSAnCFWm5xM6BPKcQbDVFojd?=
 =?us-ascii?Q?KVc8YpSaHXTrg95GIXgMxWdodJxGX85+Yk6t2DNywSr0uzKSxSThLcm0I0tA?=
 =?us-ascii?Q?o6iKwtMqeq7uGdY58eqPMSG9OS1dL9fmVedrG7Ag9z/gTiqKyDfkvOciOpBk?=
 =?us-ascii?Q?ETG8CTf9uP8HJFQMM3jGl4fc2789RxE5fM06fYEREBCeHpJYPUkgNVBKTYBG?=
 =?us-ascii?Q?CqDNvmTxqOHCeEb3Y/1vC4QibnHzj+twD7h8ugohIZ4Iu39clVB37lk1OfRw?=
 =?us-ascii?Q?fRybcMV6IQ3iku75SMp4aOkItgBT45p0A+U3D6rUdFKl9aRpt6PTGguOFBpX?=
 =?us-ascii?Q?0cCyyV0jeMDoTt9eSl13I225pTvxbVRKPEJLmEwTIwIO17796bAMIpgyD29y?=
 =?us-ascii?Q?Nsvf7UGskBmfuCIZj6xtXSNQ6Ibe7vcBp4iIUKWtCW0wz28Q0oLda0utgSlh?=
 =?us-ascii?Q?epUYFtrEMKpMLnVRjxB9bfkOcWar31oiriOEI+3RB+kwyvGrbTIoFbt23iIa?=
 =?us-ascii?Q?LxG+SIGkcRkH4wa4sVEHw2QoyTuxs0JxY+UV/vwAadr1N//+71ErtEmaIrGG?=
 =?us-ascii?Q?YvxfPJkgrlVmFll0pje4BPjILw6erGvRNrNtCXQegJhYm91LIxYeaDxtaJcZ?=
 =?us-ascii?Q?jvVtFUGx+BZmG8zfh1UiumZg4bfQsRTz7aEZaFdSrAtECY0a0c0CqIRjTxdI?=
 =?us-ascii?Q?/vKJQuOZe/QJpyerskSJojGUNPjVDhTynmYOXc12snwh2mkWWrUBLfolzYzg?=
 =?us-ascii?Q?qqi9WdBSKUnIB8ZVpRbqXHAwsXpCokozxjwmJgmvx/p5c8+ioByEPr2rMgS7?=
 =?us-ascii?Q?1Gu+1Ag2SW+pXXz1FS8FuPk3M1e?=
X-Microsoft-Antispam-Message-Info: kQPp3mK4WppqNPbfCsyTQhJhRGM0i5vnynFMXYyliHOKS61Huklz10Z4Ov2T7nQ8hWHni0mBcXRR5t/iMjqNRbegNb0jyheStb8W8qnsx8kGCBhbv8fK8VJ1F10YSsrnsidYeyIlMDVEf8xtiVp+Ikm0Mq9UxloAZLMxWr+8PGhmCpoSEBRWidkn84F52xl8
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;6:gjQz2GsV4XWBkjFWsWe0lUBq9oZLl3iLc7tB25BW/aFUDGzK+Hf3zZiYjwEducDmzQZKu6wx2yc37h0OKzPiot4w5sHuT9ZOFfqGUWPhUE0aoin9uPpm0pZAWym+tRpI/gKgYlKjXGDXMNY1jYDbEgdMgqxon9oH/WoFtvAYcJsBCquvVStzskTBtLJm2FJ7BU6Hmh76sfgQsLFPbLvDXhoX6X9swK8qtwuXbj9G1D5JISni5p0kVCdK9SG7GaJ6KHak4K/3RhT7+8RUdeYB35tF0SUqVO3HO3/wvSjYKbgvuJvkMLDen4bpu+KqENW/rKJqkNiVLrb7oG+EjjvOSf29bGzPMKjfys88SJxZF+M=;5:kpHBfWjVUGuHWB1Vsl9D7RaDFchzkPSpgHUTx4MtNQyDjt8BaxtjXuH2JvJM7fNetQU2TxW9x2bbM5LmymOggdK4yO+k2b0w+ywbXP1RpZnPihcL3zpoqQajGkOtKnTa7N5/1SpqCiiQzZPLeo7aRZJO9ChnDTb9eVRkoj0r2gw=;24:5q6J/98LsYjEdQHqKLE0IZdNM5DVJDYO06kCbID5V5ZuiZ3QXG7SW9Tz/ixF5alIvVPgogkNFULzX1wDJ69KoqQ40V9LnISOFK6KAIa+JwI=;7:NRy/x+OOXHWMLIDDEdMwrAPagGMahIUTnjcMqAO39CJ5rd44Ddjsr1TYXSDHxTzggBeHN6R5wrB0yL2rF8Yh9aZhoU/2Ht3R6WtDNqExXCgsXbZiTtRG2uU9kspNSkyBoNGaUSYcHGIPBzoElBm/Rc8o1QNUL9ddCWrGcZSu2wnsinxVezvqW4m7lcFFN0VHDrxr1QtM+YNTQDHsKuIoFY40upAwWzNy3bjJzfJGJkG/FlziKZaoVuQeYjllc02+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;20:JvN7PWwyQvb0L2LVd6pebw185TSLfBPx5lyY37Vfebi9b/i16m1NIe4BQifMZKm+addw/y529zvZCd+lWtF6Q7H+hGxmngeNX1J1+c0cJ4SlZDpI+mLmGN+l1gJ5SAnFdBM97tlWujA+JzPynbP2voVdIZQ5O3hqsy2HzhwXli6bfh0AqGcVZuKoiLfuWCgYOC2799RHlS8b/FislurXAkbTAQ4Ia8K4s8Da2X1gbu6+cxiZ9ofZ1McF67kMBrt9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 20:37:49.0537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2036fe8-3a60-4902-5bf5-08d58b7dc92e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds PLE(pause loop exit) logic from VMX to SVM.

We have noticed considerable reduction in number of VMEXITS due to pause
interceptions after these changes. Here are the numbers on one guest with
32 vcpus on AMD EPYC system. We have used boot parameter idle=poll to
simulate extensive pauses on the guest.

Here are VMEXITS in 10 seconds interval.

#VMEXITS(in 10s) 	Before the change  After the change
Pauses			810199			504
Total			882184			325415

v2:
Handled most of the Radim's comments. Here are the changes.
1. Fixed the module parameters to unsigned variants
1. Kept the default pause_filter_count = 3000 for AMD.
2. Removed the ple_window_actual_max parameter. Added a check
   in __grow_ple_window to avoid overflow.
3. Fixed the naming conventions for SVM module parameters.
   They are now called as pause_filter_count, pause_filter_thresh,
   pause_filter_shrink and pause_filter_grow.
4. Taken care of intercept setting and clearing.
5. Fixed few more text changes.

v1:
Initial RFC version

Babu Moger (5):
  KVM: VMX: Fix the module parameters for vmx
  KVM: VMX: Remove ple_window_actual_max
  KVM: VMX: Bring the common code to header file
  KVM: SVM: Add pause filter threshold
  KVM: SVM: Implement pause loop exit logic in SVM

 arch/x86/include/asm/svm.h |   3 +-
 arch/x86/kvm/svm.c         | 108 ++++++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx.c         |  82 +++++++---------------------------
 arch/x86/kvm/x86.h         |  37 ++++++++++++++++
 4 files changed, 161 insertions(+), 69 deletions(-)

-- 
1.8.3.1
