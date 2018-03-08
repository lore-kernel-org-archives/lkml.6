Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeCHUys (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:54:48 -0500
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:49942 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750885AbeCHUyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:54:46 -0500
User-agent: mu4e 0.9.19; emacs 25.3.1
From: Gratian Crisan <gratian.crisan@ni.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Toshi Kani <toshi.kani@hpe.com>, Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, Brian Gerst <brgerst@gmail.com>,
        Julia Cartwright <julia.cartwright@ni.com>, gratian@gmail.com
Subject: Kernel page fault in vmalloc_fault() after a preempted ioremap
Date: Thu, 08 Mar 2018 14:34:26 -0600
Message-ID: <87a7vi1f3h.fsf@kerf.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.118]
X-ClientProxiedBy: CY4PR18CA0053.namprd18.prod.outlook.com
 (2603:10b6:903:13f::15) To SN1PR04MB1982.namprd04.prod.outlook.com
 (2a01:111:e400:7a4b::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 348ae5e0-aef3-4731-35ac-08d585340045
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR04MB1982;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR04MB1982;3:Ei9mO6BiQ41/8Ze53gsdIsp7IJRCgfftmKilG1aQdVzwv9xNnhXKN2BuBRMaMdcuX+fdvfDZA6JuE2ntF2UYO+RwzkZ2gTMeJmgCGInowOMbAnkXhsipP9HdPxPDH59Bp+Oefe8EuriqNBQWoGM7b1kowgA1frbsaQRvs6KUZG6ID2KwSQGBSPm43uMIpTTVzYRms6E0BvQh00As2GMG4rsFPnjFEzwplIanXo4SlZ16b58L9n5Xacb/xUPGM+LI;25:GxkFaUWlvqjBEWmd1CblS1APvbw2X+afh7qK25xo/22pS/6Ltwj1ijsIMeKjsrYhzAgmOHVh090tgkX84Iy+qZlH/3zCPUcSAclx/5cditev4VZFYw528zjECijVnZ6V1n+ebhcja/v9YJ43amEdUZw9YsKrTMKCcvYFKDdEzBYqQHwkUXfthYrtw6L6BwStT3U9zzG7gMqoPSbl2PAnMI0wNx+Ahafh8SmJHDlnwPRPOGJz6H0RtRtuFvsi2qlY/rAknePq5xqx1dD9Bqf1u6+onXpOXKbvHLETF3ikQHQOJxk7FGu+e2X2XyDzqMavzGVWZMeFQpHsoU3KiHUdOA==;31:C2YRxNUm8nRITiewQAUrPNVY73aYnTIdnBN9Uq+oyEneQiNBwCmx1MQ/28UG6vT5qPI5DMubEuaRiegiXXflJfRJbvvr/9RevSP/RH+xvW2GQuIWHaH6CPdzZnPzRdWAK1dxKr9WIiHwuRDvSrdC0ptXw4ADMVio2LnkAQBWqr3Y7yuBElmalYjywt8a8tQwdW0i+LHpvMed+MshUulRXnQ1apNpYpwwqaQco3UBQe0=
X-MS-TrafficTypeDiagnostic: SN1PR04MB1982:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR04MB1982;20:nc+TfGpWnu5on/KDzubp+mnKILk5joRTqQU0NZHsU8KB3RscUy0BAOL1eHb62zWVvxf+Yr0U21xyQCfj22zVKrJpcF/Nd41jydi5PXa2AHOFq/8FPOZQXBGLBmF4KbUbHtRWMNQLcEJsnQluElivEOtodVj2j2lwb9HIR7wYNCvPjnS8eWs9/LSV4KuNh6/6vHVKZXbQBcxokM74Yk2SfaEXBsxp9MtIj0WRSjVYTONrUHouQ+X/K9YFMZx6uJR/Gehf05qT26FoU5eTiAD/4j4t40TvqqWRb4HsUhr7ZTyPTPL9F2fxnZGwB1xMAQ+tjw7UHpqGKDjPHtuuVD1uFzP2uDPt+5Xboy1vvZrH+Sxi3b+IqLNts5dU6UyaHPvxWxnSBLDDvfAvua7mh3hJugMgwdBoUSTeGl48z711iomoqTnKFAnVK7ZyC0RCupd69jj70wf0cmiKrLsDJraLPa5hdjsfEdfcioTlD7dmUlRips/40r7wKcJdfxOIS43k8DP7ro1jzAXAtC+QVUtLLdtb0UsDX/q801aiXSwsTLcrq596Qs2gE08FEkf8D80CDcJ79Q1F7SeoHGwPXuhaGs73ASFE1VfGz4EFz9j2vJk=;4:WKAfgxqxou2p1LZtBMMVxOhrZcVaDDCClBsMiItf4h2QY27lCzGBf6q/ogfIPxOgvWDon89qLIWmlAoFYwjz1At1KqEB/mQryU66nNr5WyonVEwu1DHxdE+lSt3KSgdyXIDIdF1Of+TSTs7Rsa9YVOP+OQ6riwgctWbPsthM2IzhkLwHSTfZgL8OCvnPK0Inq7SXzhI0lfqZHaXLVOg7nVSjhia2+sIzStGTS8+qTejXPll6elpsjZ4xM0abLrlyjg7HN7C02XxE5QdaS41vWQ==
X-Microsoft-Antispam-PRVS: <SN1PR04MB19827A856A1CD315E03167BEFEDF0@SN1PR04MB1982.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR04MB1982;BCL:0;PCL:0;RULEID:;SRVR:SN1PR04MB1982;
X-Forefront-PRVS: 060503E79B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(39380400002)(376002)(396003)(199004)(189003)(53754006)(26005)(45080400002)(6506007)(7696005)(25786009)(16526019)(97736004)(4326008)(6666003)(106356001)(478600001)(186003)(68736007)(81166006)(2906002)(8676002)(5890100001)(52116002)(51416003)(8936002)(386003)(105586002)(59450400001)(316002)(53936002)(5660300001)(50466002)(81156014)(305945005)(86362001)(54906003)(48376002)(55016002)(9686003)(66066001)(47776003)(58126008)(3846002)(16586007)(575784001)(6116002)(39060400002)(7736002)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR04MB1982;H:kerf.amer.corp.natinst.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR04MB1982;23:/hXzBBVqV9EQCDetSpTIVbDzhpqupZ50CPyAqMkBJ?=
 =?us-ascii?Q?jFBF3F4kzgEImiUKrug2mUGGLkafUN/x2ZF21m3IfVPxPP9AsuxUHuZ44iKU?=
 =?us-ascii?Q?cNRHJE7V/lmUIvF9pnarA8hnAVakVfIxThiBWqxeql24gRZvC4KY8yWhPcQB?=
 =?us-ascii?Q?5YBOUVLNG4Xfcg4R7cHyPNMRXk57CRo54+qddQwDOEdr2uAtwKniUtEK2XE8?=
 =?us-ascii?Q?mtF1dHh7V70z5Hd7M9fyE+hRHFFM8QJZxfCDQJYMQlc/42UOEAzv/LLkT0Jj?=
 =?us-ascii?Q?wIqaIPMFjEAM3scRqdqdA37v8EHCNsYNmuxyLMAk2swNGMST6m/W0lUJfg6H?=
 =?us-ascii?Q?JTsT7J62odOH42u83ePuNaJrYldYEsXt5TOT7mKBYyxKFeycNcI+SxixUuus?=
 =?us-ascii?Q?eWF2lgWzsRGT41FFoAhBVpU6aDG3uqml1AcSm/hwk8rgVmAhLIT87FP+wIft?=
 =?us-ascii?Q?7mqcypMPRC7xayqn8vvPcsPWLWAsDXX7e5RsSNnkrkWt2ILbcGRER8InsCQR?=
 =?us-ascii?Q?Z8sw9G0+3/idah+ZjGcAGrGpQ1CzcXJj4WoSDC9MowOryBrsDpuukcQL7uu+?=
 =?us-ascii?Q?ktllntKWjNNxHwHmuM8doTHQDilPLNiAboq6/VdtCAgkyBIDnODvvDi3Yufh?=
 =?us-ascii?Q?+S/2HCiAiqbvP8+opP6y9GAToMQjOk6iu07KYNKUYLv4eJ/Vv/FY6QTu8/Jf?=
 =?us-ascii?Q?EjSqWlHEia9w6iTJyDxNk5QZdG5zOp/m8ls6RglirQfU1sFOnJjNqPJsNMbZ?=
 =?us-ascii?Q?JN4Xbwv9vi66u7+dhgdR0ZHhJMPFFqyue9UWT/ShyyVfiRoTv9IlN3ljhjX+?=
 =?us-ascii?Q?72lKDMk2mNpfTf/sYpiQm4dggPbTjOZ7/wtkYqcH5bO+k7+xLqo36ArMO+oL?=
 =?us-ascii?Q?13kpai3jAGJoRZk+3x2F3bmNzuW15haJP9kLsGcaMYYHKvuRKp1/4p0x/bd8?=
 =?us-ascii?Q?ck3hFs5R7GJ+sxX8ZmS2kzqkQR+egKATryn6DjTbllARKOIE9y9otc6CHjkQ?=
 =?us-ascii?Q?v6qEFWBW2h3shoSwcLe2Xo6AAMwVgmm1fZwjjMX2LUdBxkQAwLbQ9jNHPdUq?=
 =?us-ascii?Q?uxBqu0XBA3Cu0yV42CThsHJMF9tGNKI2+UZq1XuS/kgzBFYgcSPv7OF0h9l0?=
 =?us-ascii?Q?7I9BFkSVFHIBGXOCX3HJgmRUWP5my6iFsB45vgeRwaHrlBz1whjumBVWVKOx?=
 =?us-ascii?Q?eb0MfwUrWjNC/zaWEAc/TCMFwfvTz00+2/qGvgd+cw8ALpKloat759tLw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: vkCWL56BMgwN1shC4fw/4ntYIuLmXpneVOfYoTzZPFey9oQv74j4u3AKf1Z9WuYdMm/t+35Hxuy03M2PPoQuw0O4g075DlBHeGi26zUZn+I2oZ1IIC4vzikpBRkGSk501GEX6Cx1EA7HEfp1U/RWzIGi8+oNC4YiiHP5dZ2bidPFZuIe8ayZaWbrkWC5djNn
X-Microsoft-Exchange-Diagnostics: 1;SN1PR04MB1982;6:i2r7QjpazlE5zDA7X/J3AdpUAYz9E1uOy80i2qk6j8lI29g4wJ+glsiJD2OMMJRDQ2fjRLvJgahVPS9PzqQf7kVDhQ4vGYF4EOdysOaKgxwfqhu7nkfjzQpllS1j6OBvE3xZRvZFeRi6jewbf6hBRm5Px44MVkf2b7oGP9MtwLCi350ouzSystyt6QIS5UHUqYQijEoTNVNBcytCTJiWLM4x/NvcAN304tingXwWlNSdN89DIUumvk0d+3RUh5RF83FTekkzJ33HDFlKxFU/IWPpeNy/PFVmd7Tg5vrJobd7NTXiZQokzi7zykWAq7QWR7prOPDTLwjAPJgE6cag60VrJIc2MQEK/y7U6n1QMGk=;5:sEuqwZCz98lfXikxmdcBASDQDzwzxfZ2/DmTNeYmkK29QCcrn99CWtTMEoMCLR7+CJeKkIDqmPh69ukutf5+4m089XNk4cZHhtgJUlEeU4cW571PM53AlvB8Hz000zTy7lGzdhsB3MTc5mzWZR4lzjruLJVC4dplXR6EOMvcCbs=;24:YYeiGu+1EwsjBhQ/3UICFGX8BqXet3utmPgleKIgkC/6kEhkTL+e66rv+Ft51BfLKp749UWKicrOEIEli8RTodfgvtiau2kKall/VBybuzM=;7:kw4BzXahYEsTJz9wOadvvW/L9ZXU/eUdclpEzDBghiqEIOX/1xnIxyFuHn4l+CweHwbwv3Chr3qcf8ke6zL0UUls/nkd0zVFJ8U7AUWgU1jhmYbHYWsFbICWsbpxhWEVy9Pfqy15QJKC6tpFXQReswZ5FWkvoLzPGTmPuoIDqtVUz7T8CBo8Ec9hbcG8C650O8ajlNrZlAPonSy0sSt+bpDbbiP4HlwRiR4f7GCnOyXVKZ287njSgJr8MJxoh5qv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 20:34:30.5090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 348ae5e0-aef3-4731-35ac-08d585340045
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR04MB1982
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803080222
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are seeing kernel page faults happening on module loads with certain
drivers like the i915 video driver[1]. This was initially discovered on
a 4.9 PREEMPT_RT kernel. It takes 5 days on average to reproduce using a
simple reboot loop test. Looking at the code paths involved I believe
the issue is still present in the latest vanilla kernel.

Some relevant points are:

  * x86_64 CPU: Intel Atom E3940

  * CONFIG_HUGETLBFS is not set (which also gates CONFIG_HUGETLB_PAGE)

Based on function traces I was able to gather the sequence of events is:

  1. Driver starts a ioremap operation for a region that is PMD_SIZE in
  size (or PUD_SIZE).

  2. The ioremap() operation is preempted while it's in the middle of
  setting up the page mappings:
  ioremap_page_range->...->ioremap_pmd_range->pmd_set_huge <<preempted>>

  3. Unrelated tasks run. Traces also include some cross core scheduling
  IPI calls.

  4. Driver resumes execution finishes the ioremap operation and tries to
  access the newly mapped IO region. This triggers a vmalloc fault.

  5. The vmalloc_fault() function hits a kernel page fault when trying to
  dereference a non-existent *pte_ref.

The reason this happens is the code paths called from ioremap_page_range()
make different assumptions about when a large page (pud/pmd) mapping can be
used versus the code paths in vmalloc_fault().

Using the PMD sized ioremap case as an example (the PUD case is similar):
ioremap_pmd_range() calls ioremap_pmd_enabled() which is gated by
CONFIG_HAVE_ARCH_HUGE_VMAP. On x86_64 this will return true unless the
"nohugeiomap" kernel boot parameter is passed in.

On the other hand, in the rare case when a page fault happens in the
ioremap'ed region, vmalloc_fault() calls the pmd_huge() function to check
if a PMD page is marked huge or if it should go on and get a reference to
the PTE. However pmd_huge() is conditionally compiled based on the user
configured CONFIG_HUGETLB_PAGE selected by CONFIG_HUGETLBFS. If the
CONFIG_HUGETLBFS option is not enabled pmd_huge() is always defined to be
0.

The end result is an OOPS in vmalloc_fault() when the non-existent pte_ref
is dereferenced because the test for pmd_huge() failed.

Commit f4eafd8bcd52 ("x86/mm: Fix vmalloc_fault() to handle large pages
properly") attempted to fix the mismatch between ioremap() and
vmalloc_fault() with regards to huge page handling but it missed this use
case.

I am working on a simpler reproducing case however so far I've been
unsuccessful in re-creating the conditions that trigger the vmalloc fault
in the first place. Adding explicit scheduling points in
ioremap_pmd_range/pmd_set_huge doesn't seem to be sufficient. Ideas
appreciated.

Any thoughts on what a correct fix would look like? Should the ioremap
code paths respect the HUGETLBFS config or would it be better for the
vmalloc fault code paths to match the tests used in ioremap and not rely
on the HUGETLBFS option being enabled?

Thanks,
    Gratian


[1]

[    3.837847] BUG: unable to handle kernel paging request at ffff8800900003c0
[    3.837855] IP: [<ffffffff81054330>] vmalloc_fault+0x1e5/0x21d
[    3.837857] PGD 1f20067
[    3.837857] PUD 0
[    3.837858]
[    3.837860] Oops: 0000 [#1] PREEMPT SMP
[    3.837880] Modules linked in: i915(+) dwc3 udc_core nichenumk(PO) nifslk(PO) nimdbgk(PO) niorbk(PO) nipalk(PO) intel_gtt drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm igb atomicchinchk(PO) coretemp i2c_i801 nibds(PO) i2c_smbus nikal(PO) i2c_algo_bit dwc3_pci agpgart video tpm_tis backlight tpm_tis_core tpm button fuse
[    3.837885] CPU: 1 PID: 238 Comm: udevd Tainted: P           O    4.9.33-rt23-5.6.0d60 #1
[    3.837886] Hardware name: National Instruments NI cRIO-9042/NI cRIO-9042, BIOS 5.12 09/04/2017
[    3.837887] task: ffff880179137080 task.stack: ffffc90001154000
[    3.837891] RIP: 0010:[<ffffffff81054330>]  [<ffffffff81054330>] vmalloc_fault+0x1e5/0x21d
[    3.837892] RSP: 0018:ffffc900011578e8  EFLAGS: 00010006
[    3.837893] RAX: 00003ffffffff000 RBX: ffff8800000003c0 RCX: 80000000900001f3
[    3.837894] RDX: 80000000900001f3 RSI: ffff880000000000 RDI: 00003fffffe00000
[    3.837895] RBP: ffffc900011578f8 R08: 0000000090000000 R09: 0000000090000000
[    3.837896] R10: 0000000000000080 R11: 0000000000000080 R12: ffffc90001278000
[    3.837897] R13: ffffc900011579a8 R14: ffff880179b3a400 R15: 0000000000000048
[    3.837899] FS:  00007f7b7942f880(0000) GS:ffff88017fc80000(0000) knlGS:0000000000000000
[    3.837900] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.837901] CR2: ffff8800900003c0 CR3: 0000000179207000 CR4: 00000000003406e0
[    3.837902] Stack:
[    3.837906]  0000000000000000 0000000000000000 ffffc90001157968 ffffffff810449f3
[    3.837909]  ffffc90001200000 ffffc90001400000 8000000000000173 0000000000000246
[    3.837911]  ffff880179b3a498 ffff880179137080 ffffc90001157958 0000000000000000
[    3.837912] Call Trace:
[    3.837919]  [<ffffffff810449f3>] __do_page_fault+0x313/0x420
[    3.837922]  [<ffffffff81044b55>] do_page_fault+0x25/0x70
[    3.837925]  [<ffffffff8105fb03>] ? iomem_map_sanity_check+0x93/0xd0
[    3.837930]  [<ffffffff815e1632>] page_fault+0x22/0x30
[    3.837994]  [<ffffffffa082350c>] ? i915_check_vgpu+0xc/0x80 [i915]
[    3.838048]  [<ffffffffa07c0dfa>] ? intel_uncore_init+0x1a/0x5c0 [i915]
[    3.838092]  [<ffffffffa075f28d>] i915_driver_load+0x73d/0x14d0 [i915]
[    3.838096]  [<ffffffff811ff596>] ? kernfs_add_one+0xf6/0x150
[    3.838141]  [<ffffffffa076aa0d>] i915_pci_probe+0x2d/0x50 [i915]
[    3.838145]  [<ffffffff8133fded>] local_pci_probe+0x2d/0x70
[    3.838147]  [<ffffffff813406a0>] pci_device_probe+0xd0/0x100
[    3.838152]  [<ffffffff81406518>] driver_probe_device+0xd8/0x280
[    3.838154]  [<ffffffff81406765>] __driver_attach+0xa5/0xb0
[    3.838157]  [<ffffffff814066c0>] ? driver_probe_device+0x280/0x280
[    3.838159]  [<ffffffff8140471a>] bus_for_each_dev+0x5a/0x90
[    3.838161]  [<ffffffff81405e5e>] driver_attach+0x1e/0x20
[    3.838163]  [<ffffffff81405ba0>] bus_add_driver+0x120/0x230
[    3.838166]  [<ffffffff81406e10>] driver_register+0x60/0xe0
[    3.838169]  [<ffffffff8134008e>] __pci_register_driver+0x7e/0x90
[    3.838171]  [<ffffffffa0895000>] ? 0xffffffffa0895000
[    3.838216]  [<ffffffffa089505a>] i915_init+0x5a/0x5e [i915]
[    3.838221]  [<ffffffff81000406>] do_one_initcall+0x46/0x160
[    3.838226]  [<ffffffff8112dea2>] ? do_init_module+0x29/0x1dd
[    3.838230]  [<ffffffff8112dedb>] do_init_module+0x62/0x1dd
[    3.838233]  [<ffffffff810caa34>] load_module+0x1db4/0x2510
[    3.838236]  [<ffffffff810c71f0>] ? show_initstate+0x50/0x50
[    3.838242]  [<ffffffff810cb241>] SYSC_finit_module+0xb1/0xc0
[    3.838246]  [<ffffffff810cb38e>] SyS_finit_module+0xe/0x10
[    3.838249]  [<ffffffff815e0660>] entry_SYSCALL_64_fastpath+0x13/0x94
[    3.838284] Code: 00 00 00 4c 0f 44 c8 49 21 d1 4d 39 c1 74 02 0f 0b 48 c1 eb 09 49 89 f8 81 e3 f8 0f 00 00 4d 85 d2 4c 0f 44 c0 48 01 f3 49 21 d0 <49> 8b 14 18 f7 c2 01 01 00 00 74 25 4d 85 db 48 0f 44 f8 48 21
[    3.838287] RIP  [<ffffffff81054330>] vmalloc_fault+0x1e5/0x21d
[    3.838288]  RSP <ffffc900011578e8>
[    3.838289] CR2: ffff8800900003c0
[    4.209883] ---[ end trace 0000000000000002 ]---
