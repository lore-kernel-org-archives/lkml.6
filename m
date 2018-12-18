Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEDCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4D4214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbeLRAoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:44:08 -0500
Received: from regular1.263xmail.com ([211.150.99.136]:40386 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeLRAoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:44:08 -0500
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2018 19:44:02 EST
Received: from wxt?rock-chips.com (unknown [192.168.167.154])
        by regular1.263xmail.com (Postfix) with ESMTP id C40FF33E;
        Tue, 18 Dec 2018 08:36:10 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.21.34] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id B8F4B369;
        Tue, 18 Dec 2018 08:36:09 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: wxt@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: wxt@rock-chips.com
X-UNIQUE-TAG: <2681c56c3bb5a2349e08035f28d530c2>
X-ATTACHMENT-NUM: 0
X-SENDER: wxt@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.21.34] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 14264O1I9FN;
        Tue, 18 Dec 2018 08:36:10 +0800 (CST)
Subject: Re: [PATCH v2 17/19] mailbox: rockchip: Use device-managed
 registration API
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20181217150217.32435-1-thierry.reding@gmail.com>
 <20181217150217.32435-18-thierry.reding@gmail.com>
From:   Caesar Wang <wxt@rock-chips.com>
Message-ID: <3761c546-fbc3-2e96-77f7-a17857c7c7cf@rock-chips.com>
Date:   Tue, 18 Dec 2018 08:36:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217150217.32435-18-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/17 下午11:02, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Get rid of some boilerplate driver removal code by using the newly added
> device-managed registration API.

Reviewed-by: Caesar Wang <wxt@rock-chips.com>

Thanks,
Caesar
>
> Cc: Caesar Wang <wxt@rock-chips.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/mailbox/rockchip-mailbox.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
> index d702a204f5c1..f24a77b1a0ff 100644
> --- a/drivers/mailbox/rockchip-mailbox.c
> +++ b/drivers/mailbox/rockchip-mailbox.c
> @@ -247,28 +247,15 @@ static int rockchip_mbox_probe(struct platform_device *pdev)
>   		mb->chans[i].msg = NULL;
>   	}
>   
> -	ret = mbox_controller_register(&mb->mbox);
> +	ret = devm_mbox_controller_register(&pdev->dev, &mb->mbox);
>   	if (ret < 0)
>   		dev_err(&pdev->dev, "Failed to register mailbox: %d\n", ret);
>   
>   	return ret;
>   }
>   
> -static int rockchip_mbox_remove(struct platform_device *pdev)
> -{
> -	struct rockchip_mbox *mb = platform_get_drvdata(pdev);
> -
> -	if (!mb)
> -		return -EINVAL;
> -
> -	mbox_controller_unregister(&mb->mbox);
> -
> -	return 0;
> -}
> -
>   static struct platform_driver rockchip_mbox_driver = {
>   	.probe	= rockchip_mbox_probe,
> -	.remove	= rockchip_mbox_remove,
>   	.driver = {
>   		.name = "rockchip-mailbox",
>   		.of_match_table = of_match_ptr(rockchip_mbox_of_match),

-- 
王晓腾 | 系统产品三部 | 软件工程师
Caesar Wang |  Product R&D Dept.III | Software engineer
**************************************************
福州瑞芯微电子股份有限公司
Fuzhou Rockchip Electronics Co.Ltd
地址：福建省福州市铜盘路软件大道89号软件园A区20号楼 (福州总部)
Addr: No.20 Building, A District, Fuzhou Software Park.Gulou District,Fuzhou,Fujian,China(Fuzhou Headquarters)
Tel：+86-0591-83991906-8221
Mobile: +86 15059456742
E-mail: wxt@rock-chips.com
*************************************************
****************************************************************************
保密提示：本邮件及其附件含有机密信息，仅发送给本邮件所指特定收件人。若非该特定收件人，请勿复制、
使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件或其他方式即刻告知发件人。
福州瑞芯微电子有限公司拥有本邮件信息的著作权及解释权，禁止任何未经授权许可的侵权行为。
IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents of this
email and any attachments may contain information that is privileged, confidential and/or exempt from disclosure under applicable law and relevant NDA.
If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information is STRICTLY PROHIBITED.
Please immediately contact the sender as soon as possible and destroy the material in its entirety in any format. Thank you.


