Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8921AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463C220820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463C220820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeKAVxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:53:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48657 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727862AbeKAVxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:53:04 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CE12FB595B34D;
        Thu,  1 Nov 2018 20:50:08 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 1 Nov 2018
 20:50:01 +0800
Subject: Re: [PATCH net] net: hns3: Fix for out-of-bounds access when setting
 pfc back pressure
To:     Yunsheng Lin <linyunsheng@huawei.com>, <davem@davemloft.net>
References: <1541074363-98630-1-git-send-email-linyunsheng@huawei.com>
CC:     <huangdaode@hisilicon.com>, <xuwei5@hisilicon.com>,
        <liguozhu@hisilicon.com>, <Yisen.Zhuang@huawei.com>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4b5d0e04-df53-6123-0562-7f0146d33ae9@huawei.com>
Date:   Thu, 1 Nov 2018 12:49:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1541074363-98630-1-git-send-email-linyunsheng@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2018 12:12, Yunsheng Lin wrote:
> The vport should be initialized to hdev->vport for each bp group,
> otherwise it will cause out-of-bounds access and bp setting not
> correct problem.
>
> [   35.254124] BUG: KASAN: slab-out-of-bounds in hclge_pause_setup_hw+0x2a0/0x3f8 [hclge]
> [   35.254126] Read of size 2 at addr ffff803b6651581a by task kworker/0:1/14
>
> [   35.254132] CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 4.19.0-rc7-hulk+ #85
> [   35.254133] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI RC0 - B052 (V0.52) 09/14/2018
> [   35.254141] Workqueue: events work_for_cpu_fn
> [   35.254144] Call trace:
> [   35.254147]  dump_backtrace+0x0/0x2f0
> [   35.254149]  show_stack+0x24/0x30
> [   35.254154]  dump_stack+0x110/0x184
> [   35.254157]  print_address_description+0x168/0x2b0
> [   35.254160]  kasan_report+0x184/0x310
> [   35.254162]  __asan_load2+0x7c/0xa0
> [   35.254170]  hclge_pause_setup_hw+0x2a0/0x3f8 [hclge]
> [   35.254177]  hclge_tm_init_hw+0x794/0x9f0 [hclge]
> [   35.254184]  hclge_tm_schd_init+0x48/0x58 [hclge]
> [   35.254191]  hclge_init_ae_dev+0x778/0x1168 [hclge]
> [   35.254196]  hnae3_register_ae_dev+0x14c/0x298 [hnae3]
> [   35.254206]  hns3_probe+0x88/0xa8 [hns3]
> [   35.254210]  local_pci_probe+0x7c/0xf0
> [   35.254212]  work_for_cpu_fn+0x34/0x50
> [   35.254214]  process_one_work+0x4d4/0xa38
> [   35.254216]  worker_thread+0x55c/0x8d8
> [   35.254219]  kthread+0x1b0/0x1b8
> [   35.254222]  ret_from_fork+0x10/0x1c
>
> [   35.254224] The buggy address belongs to the page:
> [   35.254228] page:ffff7e00ed994400 count:1 mapcount:0 mapping:0000000000000000 index:0x0 compound_mapcount: 0
> [   35.273835] flags: 0xfffff8000008000(head)
> [   35.282007] raw: 0fffff8000008000 dead000000000100 dead000000000200 0000000000000000
> [   35.282010] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [   35.282012] page dumped because: kasan: bad access detected
>
> [   35.282014] Memory state around the buggy address:
> [   35.282017]  ffff803b66515700: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> [   35.282019]  ffff803b66515780: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> [   35.282021] >ffff803b66515800: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> [   35.282022]                             ^
> [   35.282024]  ffff803b66515880: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> [   35.282026]  ffff803b66515900: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> [   35.282028] ==================================================================
> [   35.282029] Disabling lock debugging due to kernel taint
> [   35.282747] hclge driver initialization finished.
>
> Fixes: 67bf2541f4b9 ("net: hns3: Fixes the back pressure setting when sriov is enabled")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
> index aa5cb98..0c9c6ae 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
> @@ -1168,11 +1168,12 @@ static int hclge_pfc_setup_hw(struct hclge_dev *hdev)
>   */
>  static int hclge_bp_setup_hw(struct hclge_dev *hdev, u8 tc)
>  {
> -	struct hclge_vport *vport = hdev->vport;
>  	u32 i, k, qs_bitmap;
>  	int ret;
>
>  	for (i = 0; i < HCLGE_BP_GRP_NUM; i++) {
> +		struct hclge_vport *vport = hdev->vport;
> +

It seems to me that the bug is fixed but the code is not much better.

Since variable vport is only referenced in the inner loop, I would 
define it there.

>  		qs_bitmap = 0;
>
>  		for (k = 0; k < hdev->num_alloc_vport; k++) {
>

static int hclge_bp_setup_hw(struct hclge_dev *hdev, u8 tc)
  {
-       struct hclge_vport *vport = hdev->vport;
-       u32 i, k, qs_bitmap;
-       int ret;
+       int ret, i;

         for (i = 0; i < HCLGE_BP_GRP_NUM; i++) {
-               qs_bitmap = 0;
+               u32 qs_bitmap = 0;
+               int k;

                 for (k = 0; k < hdev->num_alloc_vport; k++) {
+                       struct hclge_vport *vport = &hdev->vport[k];
                         u16 qs_id = vport->qs_offset + tc;
                         u8 grp, sub_grp;

...

                         if (i == grp)
                                 qs_bitmap |= (1 << sub_grp);
-
-                       vport++;


... so this seems better and safer, as you're explicitly limiting vport 
within bounds of hdev->num_alloc_vport.


